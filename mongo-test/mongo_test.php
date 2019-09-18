<?php
  
   $services_json = json_decode(getenv("VCAP_SERVICES"),true);
   $mongo_config = $services_json["mongodb-1.8"][0]["credentials"];
   
   $username = $mongo_config["username"];
   $password = $mongo_config["password"];
   $hostname = $mongo_config["hostname"];
   $port = $mongo_config["port"];
  $db = $mongo_config["db"];
  $name = $mongo_config["name"];
  
  $connect = "mongodb://${username}:${password}@${hostname}:${port}/${db}";
  $m = new Mongo($connect);
  $db = $m->selectDB($db);
  $collection = $db->items;
  $cursor = $collection->find();
  
   echo $cursor->count() . ' document(s) found. <br/>';
    foreach ($cursor as $obj) {
      echo 'Name: ' . $obj['name'] . '<br/>';
      echo 'Quantity: ' . $obj['quantity'] . '<br/>';
      echo 'Price: ' . $obj['price'] . '<br/>';
      echo '<br/>';
    }
  
  echo 'hello'
  
  ?>
