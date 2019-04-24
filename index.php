<?php
?>
<html>

<head>
	<title>Hack this</title>
</head>
	
<body>
	<h1>Super secret anonymous chat!</h1>
	<h3>Without any security issues!!!</h3>
	<form method="POST">
	<input type="text" name="msg">
	<input type="submit" value="Send">
	</form>
	
<p><hr>	
<?php
	if(isset($_POST['msg']))
	{
		system("echo \"" . $_POST['msg'] . "\" >> messages");
	}
	$messages = file_get_contents("messages");
	foreach(preg_split("/((\r?\n)|(\r\n?))/", $messages) as $line){
		echo htmlspecialchars($line);
		echo "<hr><br>";
	} 

?>
</p>

</body>

</html>
