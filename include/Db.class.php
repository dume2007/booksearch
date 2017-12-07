<?php
class Db
{
	protected $dbMode = 'master';
	protected $config;
	protected $conn;
	protected $m_link;
	protected $s_link;
	protected $sql;
	protected $result;
	protected $addFields;
	protected $addValues;
	protected $saveForm;
	protected $force_master = false;
	
	function __construct($auto_init = false){
		if($auto_init) {
			$this->init();
		}
	}

	public function close(){
		if(is_resource($this->m_link)) {
			$result = mysql_close($this->m_link);
			$this->m_link = null;
		}

		if(is_resource($this->s_link)) {
			$result = mysql_close($this->s_link);
			$this->s_link = null;
		}
	}

	public function setForceMaster($bl = true) {
		$this->force_master = $bl;
	}

	public function init(){
		global $config;
		
		if( empty($this->sql) ) return true;

		$this->dbMode = 'master';
		$this->conn   = $this->m_link;
		
		if($this->conn) return true;

		if( empty($config[$this->dbMode]) ){	
			$return['status'] = 0;
			$return['info']   = $this->dbMode.' database config set in config.php';
			echo json_encode($return);		
			exit;
		}
		$this->config = $config[$this->dbMode];

		if($this->dbMode == 'master') {
			$this->m_link = @mysql_pconnect($this->config['db_host'], $this->config['db_user'], $this->config['db_passwd']);	
			$this->conn = $this->m_link;
		} else {
			$this->s_link = @mysql_pconnect($this->config['db_host'], $this->config['db_user'], $this->config['db_passwd']);	
			$this->conn = $this->s_link;
		}

		if(!$this->conn) {
			$return = $this->error('connect fail');
			echo json_encode($return);		
			exit;
		}
	
		if(!mysql_select_db($this->config['db_database'], $this->conn)) {
			$return = $this->error('select database '.$this->config['db_database'].' fail');
			echo json_encode($return);		
			exit;
		}

		mysql_query("SET NAMES ".$this->config['coding'], $this->conn);
	}

	public function startTrans() {
		mysql_query("START TRANSACTION");
	}

	public function commit() {
		mysql_query("COMMIT");
	}

	public function rollback() {
		mysql_query("ROLLBACK");
	}

	public function end() {
		mysql_query("END"); 
	}
	
	protected function matchField($tb, $arr = array()){
		$return = array();
		$fields = $this->query("describe $tb");		
		foreach($fields as $field){
			if( $field['Key'] == 'PRI' && $field['Extra'] == 'auto_increment' ) continue;			
			foreach($arr as $k=>$v){
				if( $field['Field'] == $k ){		
					$v = html_entity_decode($v, ENT_QUOTES, 'UTF-8');			
					$v = str_replace("'", '"', $v);
					$v = str_replace("‘", '"', $v);		
					$return[$k] = $v; break;
				}
			}
		}
		return $return;
	}
	
	protected function creatAddForm($data){
		$this->addFields = '';
		$this->addValues = '';
		if(!is_array($data) || empty($data)) return;
		$i = 0;		
		foreach($data as $k=>$v){
			$v = str_replace("'", '"', $v);
			$v = str_replace("‘", '"', $v);
			$v = addslashes($v);
			if($i==0){
				$this->addFields = "".trim($k)."";
				$this->addValues = "'".trim($v)."'";
			}
			else{
				$this->addFields .= ','."".trim($k)."";
				$this->addValues .= ','."'".trim($v)."'";
			}
			$i++;
		}
	}
	protected function creatSaveForm($data){
		$this->saveForm = '';
		$i = 0;
		foreach($data as $k=>$v){
			$v = str_replace("'", '"', $v);
			$v = str_replace("‘", '"', $v);
			$v = addslashes($v);
			if($i==0){
				$this->saveForm = $k."='".trim($v)."'";
			}
			else{
				$this->saveForm .= ','.$k."='".trim($v)."'";
			}
			$i++;
		}
	}
	//select query
	function query($sql){
		$this->sql = $sql;
		$this->init();
		$result = mysql_query($this->sql, $this->conn);
		if(!$result){
			$this->error('fetch query fail');
		}	
		if( is_resource($result) ){
			$record = array();	
			while($row = mysql_fetch_assoc($result)){
				$record[] = $row;			
			}
			return $record;
		}
		else{
			return $result;
		}
	}
	
	//select single record
	function find($table,$where,$order = 'id desc',$limit = '0,1'){
		$this->sql = "SELECT * FROM $table where $where order by $order limit $limit";
		$this->init();
		$result = mysql_query($this->sql, $this->conn);
		if(!$result){
			$this->error('fetch record fail');
		}
		$record = array();
		while($row = mysql_fetch_assoc($result)){
			$record = $row;
		}
		return $record;
	}
	//insert record
	function add($table,$data){
		$data = $this->matchField($table, $data);
		$this->creatAddForm($data);		
		if(empty($this->addFields) || empty($this->addValues)) return false;
		$this->sql = "INSERT INTO ".$table."(".$this->addFields.") VALUES(".$this->addValues.")";
		$this->init();
		$result = mysql_query($this->sql, $this->conn);
		return $result;
	}
	//update record
	function save($table,$where,$data){
		$data = $this->matchField($table, $data);
		$this->creatSaveForm($data);
		if(empty($this->saveForm)) return false;
		$this->sql = "UPDATE $table SET ".$this->saveForm." WHERE $where";
		$this->init();
		$result = mysql_query($this->sql, $this->conn);
		return $result;		
	}
	//return affected rows
	function affected_rows(){
		return mysql_affected_rows($this->conn);
	}
	function insert_id()
	{
		return mysql_insert_id($this->conn);
	}
	function error($msg='')
	{
		$return['status'] = 0;
		$return['info']   = '1)、'.$msg.'<br>'.'2)、Error：'.mysql_error().'<br>3)、sql：'.$this->sql;

		//echo json_encode($return);
		return $return;	
		//echo mysql_error();	
		//exit;
	}	

	function __destruct()
	{
		$this->close();
		
		//var_dump('mysql_close', $result);
	}
}
?>
