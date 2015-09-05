<!--#include file="inc/inc.asp"--><%
If session("role") <> 15 then Response.Redirect "login.asp" %>
<!DOCTYPE html>
<html>
<head>
	<title>דף ניהול ראשי</title>
    <meta name="robots" content="none">
<!--#include file="inc/header.asp"-->
	<style>
	li {display: inline-block; width:120px; height:20px; border:1px solid gray; padding: 80px 50px; margin: 10px 10px; font-size: 1.5em;}
	</style>
</head>
<body dir="rtl">
<!--#include file="inc/top.asp"-->
<div class="view">
	<ul>
		<li><a href="loginHistory.asp">מעקב כניסות</a></li>
		<li><a href="userControl.asp">ניהול משתמשים</a></li>
		<li><a href="videoControl.asp">ניהול סרטונים</a></li>
	</ul>
</div>
</body>
</html>