<?php

require_once 'app/models/movie.model.php';
require_once 'app/models/review.model.php';
require_once 'app/views/json.view.php';

class MovieApiController
{
  private $model;
  private $modelReview;
  private $view;

  public function __construct()
  {
    $this->model = new MovieModel();
    $this->modelReview = new ReviewModel();
    $this->view = new JSONView();
  }

  public function getMovies($req, $res)
  {
    // captura de parámetro GET para filtro
    $filterOptions = ['main_genre'];
    $genreOptions = $this->getGenres();
    $filterBy = null;
    $filterValue = null;
    if (isset($req->query->filter) && !empty($req->query->filter) && isset($req->query->filterValue) && !empty($req->query->filterValue)) {
      $filterBy = $this->_verifyExistence(strtolower(urldecode($req->query->filter)), $filterOptions);
      $filterValue = $this->_verifyExistence(strtolower(urldecode($req->query->filterValue)), $genreOptions);
    }

    // captura de parámetro GET para orden
    $orderFields = $this->getTableData('movie');
    $orderFields[] = 'main_genre';
    $orderOptions = ["asc", "desc"];
    $orderBy = null;
    $orderValue = null;
    if (isset($req->query->order) && !empty($req->query->order) && isset($req->query->orderValue) && !empty($req->query->orderValue)) {
      $orderBy = $this->_verifyExistence(strtolower(urldecode($req->query->order)), $orderFields);
      $orderValue = $this->_verifyExistence(strtolower(urldecode($req->query->orderValue)), $orderOptions);
    }

    // captura de parámetros GET para paginación
    $offset = null;
    $limit = null;
    if (
      isset($req->query->page) && isset($req->query->limit)
      && is_numeric($req->query->page) && is_numeric($req->query->limit)
    ) {
      $page = $req->query->page;
      $limit = $req->query->limit;
      $offset = ($page - 1) * $limit;
    }

    $movies = $this->model->getMovies($filterBy, $filterValue, $orderBy, $orderValue, $offset, $limit);

    if (!$movies) {
      return $this->view->response("Movies Not Found", 404);
    }

    return $this->view->response($movies);
  }

  private function _verifyExistence($option, $arrayOptions)
  {
    foreach ($arrayOptions as $value) {
      if ($value == $option) {
        return $value;
      }
    }
  }

  private function getTableData($table)
  {
    $orderFields = [];
    $tableData = $this->model->getTableData($table);
    foreach ($tableData as $table) {
      $orderFields[] = $table->Field;
    }

    return $orderFields;
  }

  private function getGenres()
  {
    $genreOptions = [];
    $genres = $this->model->getGenres();
    foreach ($genres as $genre) {
      $genreOptions[] = $genre->main_genre;
    }
    return $genreOptions;
  }

  public function getMovieById($req, $res)
  {
    if (!isset($req->params->id) || empty($req->params->id) || !is_numeric($req->params->id)) {
      return $this->view->response("Incorrect Data", 400);
    }

    $id_movie = $req->params->id;

    $movie = $this->model->getMovie($id_movie, null);

    if (!$movie) {
      return $this->view->response("Movie Not Found", 404);
    }

    $review = $this->modelReview->getReview($id_movie);

    if ($review) {
      $movie->reviews = $review;
    }

    return $this->view->response($movie);
  }

  public function addMovie($req, $res)
  {
    if (!$res->user) {
      return $this->view->response("Authorization error: Invalid token.", 401);
    }

    if (!isset($req->body->title) || empty($req->body->title)) {
      return $this->view->response("Data Is Missing (title)", 400);
    }
    if (!isset($req->body->poster_path) || empty($req->body->poster_path)) {
      return $this->view->response("Data Is Missing (poster_path)", 400);
    }
    if (!isset($req->body->release_date) || empty($req->body->release_date)) {
      return $this->view->response("Data Is Missing (release_date)", 400);
    }
    if (!isset($req->body->overview) || empty($req->body->overview)) {
      return $this->view->response("Data Is Missing (overview)", 400);
    }
    if (!isset($req->body->company) || empty($req->body->company)) {
      return $this->view->response("Data Is Missing (company)", 400);
    }
    if (!isset($req->body->main_genre) || empty($req->body->main_genre)) {
      return $this->view->response("Data Is Missing (main_genre)", 400);
    }

    $title = $req->body->title;
    $poster_path = $req->body->poster_path;
    $release_date = $req->body->release_date;
    $overview = $req->body->overview;
    $company = $req->body->company;
    $main_genre = $req->body->main_genre;

    $movie = $this->model->getMovie(null, $title);
    if ($movie) {
      return $this->view->response("The movie = $movie->title already exists in your database.", 400);
    }

    $genre = $this->model->getGenre(null, $main_genre);
    if (!$genre) {
      return $this->view->response("You must enter an existing gender.", 400);
    }

    $id_movie = $this->model->add($title, $poster_path, $release_date, $overview, $company, $genre->id_genre);
    $newMovie = $this->model->getMovie($id_movie, null);
    if (!$newMovie) {
      return $this->view->response("Error inserting a movie.", 500);
    }

    return $this->view->response($newMovie, 201);
  }

  public function updateMovie($req, $res)
  {
    if (!$res->user) {
      return $this->view->response("Authorization error: Invalid token.", 401);
    }

    if (!isset($req->params->id) || empty($req->params->id) || !is_numeric($req->params->id)) {
      return $this->view->response("Invalid Id", 400);
    }

    $id_movie = $req->params->id;

    $movie = $this->model->getMovie($id_movie, null);
    if (!$movie) {
      return $this->view->response("The id = $id_movie does not have an associated record.", 404);
    }

    $movieData = [];

    (!isset($req->body->title) || empty($req->body->title)) ? null : $movieData["title"] = $req->body->title;
    (!isset($req->body->poster_path) || empty($req->body->poster_path)) ? null : $movieData["poster_path"] = $req->body->poster_path;
    (!isset($req->body->release_date) || empty($req->body->release_date)) ? null : $movieData["release_date"] = $req->body->release_date;
    (!isset($req->body->overview) || empty($req->body->overview)) ? null : $movieData["overview"] = $req->body->overview;
    (!isset($req->body->company) || empty($req->body->company)) ? null : $movieData["company"] = $req->body->company;
    if (isset($req->body->main_genre) || !empty($req->body->main_genre)) {
      $genre = $this->model->getGenre(null, $req->body->main_genre);
      if (!$genre) {
        return $this->view->response("You must enter an existing gender.", 400);
      }
      $movieData["id_genre"] = $genre->id_genre;
    }

    if (count($movieData) == 0) {
      return $this->view->response("There is no data to modify", 400);
    }

    $this->model->edit($id_movie, $movieData);
    $updatedMovie = $this->model->getMovie($id_movie, null);
    if (!$updatedMovie) {
      return $this->view->response("Error when modifying a movie.", 500);
    }

    return $this->view->response($updatedMovie, 201);
  }

  public function deleteMovie($req, $res)
  {
    if (!$res->user) {
      return $this->view->response("Authorization error: Invalid token.", 401);
    }

    $id_movie = $req->params->id;

    $movie = $this->model->getMovie($id_movie, null);

    if (!$movie) {
      return $this->view->response("Movie Not Found", 404);
    }

    $this->model->delete($id_movie, null);

    $movie = $this->model->getMovie($id_movie, null);

    if ($movie) {
      return $this->view->response("An error has occurred", 500);
    }

    return $this->view->response("Movie successfully deleted", 200);
  }
}
