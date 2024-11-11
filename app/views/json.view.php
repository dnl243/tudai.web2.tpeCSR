<?php

class JSONView
{
  public function response($body, $statusCode = 200)
  {
    header("Content-Type: application/json");
    $statusText = $this->_requestStatus($statusCode);
    header("HTTP/1.1 $statusCode $statusText");
    echo json_encode($body);
  }

  private function _requestStatus($statusCode)
  {
    $status = array(
      200 => "OK",
      201 => "Created",
      204 => "No Content",
      400 => "Bad Request",
      401 => "Unauthorized",
      404 => "Not Found",
      500 => "Internal Server Error"
    );
    return $status[$statusCode];
  }
}
