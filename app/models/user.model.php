<?php

require_once 'config.php';

class UserModel
{
  private $db;

  public function __construct()
  {
    $this->db = new PDO("mysql:host=" . MYSQL_HOST . ";dbname=" . MYSQL_DB . ";charset=utf8", MYSQL_USER, MYSQL_PASS);
  }

  public function getUser($id_user, $email)
  {
    $sql = 'SELECT * FROM user WHERE id_user = ? OR email = ?';
    $query = $this->db->prepare($sql);
    $query->execute([$id_user, $email]);

    $user = $query->fetch(PDO::FETCH_OBJ);

    return $user;
  }

  public function addUser($email, $password){
    $sql = 'INSERT INTO user (email, password) VALUES (?, ?)';
    $query = $this->db->prepare($sql);
    $query->execute([$email, $password]);

    $id = $this->db->lastInsertId();
    return $id;
  }
}
