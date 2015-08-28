<!--#include file="inc/inc.asp"--><%
If session("role") <> 15 then Response.Redirect "login.asp" %>
<!DOCTYPE html>
<html>
<head>
	<title>דף ניהול ראשי</title>
    <meta name="robots" content="none">
<!--#include file="inc/header.asp"-->
</head>
<body dir="rtl">
<!--#include file="inc/top.asp"-->
<div class="view">
	<ul>
		<li><a href="loginHistory.asp">מעקב כניסות</a></li>
		<li><a href="userControl.asp">ניהול משתמשים</a></li>
	</ul>
</div>
</body>
</html>