<?php

require_once 'config.php';

class GenreModel{
  private $db;

  public function __construct()
  {
    $this->db = new PDO("mysql:host=" . MYSQL_HOST . ";dbname=" . MYSQL_DB . ";charset=utf8", MYSQL_USER, MYSQL_PASS);
  }

  public function getGenres(){
    $sql = 'SELECT * FROM genre';
    $query = $this->db->prepare($sql);
    $query->execute();
    $genres = $query->fetchAll(PDO::FETCH_OBJ);
    
    return $genres;
  }
}