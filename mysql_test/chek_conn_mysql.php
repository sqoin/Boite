<?php
mysql_connect('db_host', 'db_username', 'password') or die('Could not connect the database : Username or password incorrect');
mysql_select_db('db_name') or die ('No database found');
echo 'Database Connected successfully';
?>
