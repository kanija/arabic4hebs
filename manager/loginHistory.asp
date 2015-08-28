<!--#include file="inc/inc.asp"--><%
If session("role") <> 15 then Response.Redirect "login.asp" %>
<!DOCTYPE html>
<html>
<head>
	<title>מעקב כניסות</title>
    <meta name="robots" content="none">
    <!--#include file="inc/header.asp"-->
    <style>
    .loginLog {display:table-row;}
    .loginLog > span {display:table-cell; padding:5px 10px;}
    .loginLog:nth-child(odd) {background-color:#eee;}
    .loginLog:nth-child(even) {background-color:#fff;}
    </style>
</head>
<body>
<!--#include file="inc/top.asp"-->
<div class="view">
	<h1>מעקב כניסות</h1>
	<div><%
	openDB "arabicUsers"
		mySQL = "SELECT loginLog.*,users.username FROM loginLog LEFT JOIN users ON users.id = loginLog.userID ORDER BY loginTime DESC"
		res.open mySQL, con
			do until res.EOF %>
			<div class="loginLog">
				<span><%=res(1)%></span>
				<span dir="ltr"><%=res(2)%></span>
			</div><%
			res.movenext
			loop
		res.close
	closeDB %>
	</div>
</div>
</body>
</html>