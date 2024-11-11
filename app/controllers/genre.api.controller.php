<?php

require_once 'app/models/genre.model.php';
require_once 'app/views/json.view.php';

class GenreApiController{
  private $model;
  private $view;

  public function __construct()
  {
    $this->model = new GenreModel();
    $this->view = new JSONView();
  }

  public function getGenres(){
    $genres = $this->model->getGenres();

    if (!$genres) {
      return $this->view->response("Genres Not Found", 404);
    }

    return $this->view->response($genres);
  }
}