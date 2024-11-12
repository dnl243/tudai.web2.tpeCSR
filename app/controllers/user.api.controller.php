<?php

require_once 'app/models/user.model.php';
require_once 'app/views/json.view.php';
require_once 'libs/jwt.php';

class UserApiController
{
  private $model;
  private $view;

  public function __construct()
  {
    $this->model = new UserModel();
    $this->view = new JSONView();
  }

  public function getToken()
  {
    $auth_header = $_SERVER['HTTP_AUTHORIZATION'];
    $auth_header = explode(' ', $auth_header);
    if (count($auth_header) != 2) {
      return $this->view->response("Incorrect Credentials", 400);
    }
    if ($auth_header[0] != 'Basic') {
      return $this->view->response("Incorrect Credentials", 400);
    }
    $user_pass = base64_decode($auth_header[1]);
    $user_pass = explode(':', $user_pass);
    $user = $this->model->getUser(null, $user_pass[0]);
    if ($user == null || !password_verify($user_pass[1], $user->password)) {
      return $this->view->response("Incorrect Credentials", 400);
    }
    $token = createJWT(array(
      'sub' => $user->id_user,
      'email' => $user->email,
      'role' => 'admin',
      'iat' => time(),
      'exp' => time() + 300,
      'Saludo' => 'Hola',
    ));
    return $this->view->response($token);
  }

  public function addUser($req, $res){
    if (!isset($req->body->email) || empty($req->body->email)) {
      return $this->view->response("Data Is Missing (email)", 400);
    }
    if (!isset($req->body->password) || empty($req->body->password)) {
      return $this->view->response("Data Is Missing (password)", 400);
    }

    $email = $req->body->email;
    $password = $req->body->password;

    $password = password_hash($password, PASSWORD_BCRYPT);

    $user = $this->model->getUser(null, $email);
    if ($user) {
      return $this->view->response("The user = $user->email already exists in your database.", 400);
    }

    $id_user = $this->model->addUser($email, $password);
    $newUser = $this->model->getUser($id_user, null);
    if (!$newUser) {
      return $this->view->response("Error inserting a user.", 500);
    }

    return $this->view->response($newUser);

  }

  //?email="email"   ||  ?id_user="id_user"
  public function getUser($req, $res){

    $id_user = null;
    $email = null;

    if (!isset($req->query->email) && empty($req->query->email) && !isset($req->query->id_user) && empty($req->query->id_user)) {
      return $this->view->response("Data Is Missing (email or password)", 400);
    }

    if (isset($req->query->email) && !empty($req->query->email)) {
      $email = $req->query->email;
    }

    if (isset($req->query->id_user) && !empty($req->query->id_user)) {
      $id_user = $req->query->id_user;
    }

    $user = $this->model->getUser($id_user, $email);
    if (!$user) {
      return $this->view->response("User Not Found.", 404);
    }

    return $this->view->response($user);
  }

}
