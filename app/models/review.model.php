<?php

require_once 'config.php';

class ReviewModel
{
  private $db;

  public function __construct()
  {
    $this->db = new PDO("mysql:host=" . MYSQL_HOST . ";dbname=" . MYSQL_DB . ";charset=utf8", MYSQL_USER, MYSQL_PASS);
  }
  
  // get review by id
  public function getReview($id_movie) {
    $sql = 'SELECT * FROM review WHERE id_movie = ?';

    $query = $this->db->prepare($sql);
    $query->execute([$id_movie]);

    $reviews = $query->fetchAll(PDO::FETCH_OBJ);
    return $reviews;
  }

  public function addReview($id_movie, $review, $score){
    $sql = 'INSERT INTO review (main_review, score, id_movie) VALUES (?, ?, ?)';

    $query = $this->db->prepare($sql);
    $query->execute([$review, $score, $id_movie]);

    $id_review = $this->db->lastInsertId();
    return $id_review;
  }
  
  public function getReviewById($id_review){
    $sql = 'SELECT * FROM review WHERE id_review = ?';

    $query = $this->db->prepare($sql);
    $query->execute([$id_review]);

    $new_review = $query->fetch(PDO::FETCH_OBJ);
    return $new_review;
  }
}
