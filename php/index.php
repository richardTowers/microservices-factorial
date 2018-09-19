<?php

$inp = intval(explode('/', getenv('REQUEST_URI'))[1]);

if ($inp <= 1) {
  echo file_get_contents('http://base-factorial.apps.internal:8080');
} else {
  $prec = $inp - 1;
  $prec = intval(file_get_contents("http://factorial.apps.internal:8080/$prec"));
  echo ($inp * $prec);
}

?>
