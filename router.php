<?php

require_once 'libs/router.php';
require_once 'app/controllers/movie.api.controller.php';
require_once 'app/controllers/genre.api.controller.php';
require_once 'app/controllers/user.api.controller.php';
require_once 'app/middlewares/jwt.auth.middleware.php';

$router = new Router();
$router->addMiddleware(new JWTAuthMiddleware());

$router->addRoute('movies', 'GET', 'MovieApiController', 'getMovies');
$router->addRoute('movies/:id', 'GET', 'MovieApiController', 'getMovieById');
$router->addRoute('movies', 'POST', 'MovieApiController', 'addMovie');
$router->addRoute('movies/:id', 'PUT', 'MovieApiController', 'updateMovie');
$router->addRoute('movies/:id', 'DELETE', 'MovieApiController', 'deleteMovie');
$router->addRoute('genres', 'GET', 'GenreApiController', 'getGenres');

$router->addRoute('usuarios/token', 'GET', 'UserApiController', 'getToken');
$router->addRoute('usuarios', 'POST', 'UserApiController', 'addUser');
$router->addRoute('usuarios', 'GET', 'UserApiController', 'getUser');

$router->route($_GET['resource'], $_SERVER['REQUEST_METHOD']);

