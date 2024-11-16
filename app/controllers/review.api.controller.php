<?php

require_once 'app/models/review.model.php';
require_once 'app/models/movie.model.php';
require_once 'app/views/json.view.php';

class ReviewApiController{
  private $model;
  private $modelMovie;
  private $view;

  public function __construct(){
    $this->model = new ReviewModel();
    $this->modelMovie = new MovieModel();
    $this->view = new JSONView();
  }

  public function addReview($req, $res){
    if (!isset($req->body->id_movie) || empty($req->body->id_movie)) {
      return $this->view->response("Data Is Missing (id_movie)", 400);
    }
    if (!isset($req->body->review) || empty($req->body->review)) {
      return $this->view->response("Data Is Missing (review)", 400);
    }
    if (!isset($req->body->score) || empty($req->body->score)) {
      return $this->view->response("Data Is Missing (score)", 400);
    }

    $id_movie = $req->body->id_movie;
    $review = $req->body->review;
    $score = $req->body->score;

    $movie = $this->modelMovie->getMovie($id_movie, null);

    if (!$movie) {
      return $this->view->response("The movie = $id_movie does not exist in your database.", 400);
    }

    $id_review = $this->model->addReview($id_movie, $review, $score);

    if (!$id_review) {
      return $this->view->response("Error inserting a user.", 500);
    }

    $new_review = $this->model->getReviewById($id_review);
    return $this->view->response($new_review);
  }
}