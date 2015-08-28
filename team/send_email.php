<!DOCTYPE html>
<html>
<head>
	<title>mail upon new entry</title>
	<meta charset="UTF-8">
</head>	
<body>

<?php
$wordID = $_GET['wordID'];
$arabic = $_GET['arabic'];

$msg = "<html><body><table dir='rtl'>";
$msg .= "<tr><td>מספר</td><td><a href='http://ronen.rothfarb.info/arabic/word.asp?id=$wordID'>$wordID</a></td></tr>";
$msg .= "<tr><td>ערבית</td><td><a href='http://ronen.rothfarb.info/arabic/word.asp?id=$wordID'>$arabic</a></td></tr>";
$msg .= "</table></body></html>";
// use wordwrap() if lines are longer than 70 characters
$msg = wordwrap($msg,70);
//echo $msg;

$subject = "מילה חדשה במילון : ";
$subject .= "$arabic";

$headers = "Content-Type: text/html; charset=ISO-8859-1\r\n";

// send email
mail("arabic4hebs@gmail.com",$subject,$msg,$headers);

// Redirect browser
header("Location: http://ronen.rothfarb.info/arabicTeam/word.asp?id=$wordID");
exit();
?>
  
</body>
</html>