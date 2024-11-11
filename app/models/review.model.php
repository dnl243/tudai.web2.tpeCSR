<?php

require_once 'config.php';

class ReviewModel
{
  private $db;

  public function __construct()
  {
    $this->db = new PDO("mysql:host=" . MYSQL_HOST . ";dbname=" . MYSQL_DB . ";charset=utf8", MYSQL_USER, MYSQL_PASS);
  }
  // obtener reseñas según id_movie
  public function getReview($id_movie) {
    $sql = 'SELECT * FROM review WHERE id_movie = ?';

    $query = $this->db->prepare($sql);
    $query->execute([$id_movie]);

    $reviews = $query->fetchAll(PDO::FETCH_OBJ);
    return $reviews;
  }
}
