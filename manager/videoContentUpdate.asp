<!--#include file="inc/inc.asp"-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
</head>
<body dir="ltr">
<div><%
If session("role") <> 15 then Response.Redirect "login.asp"

function getString (f)
	getString = "'" &replace(request(f),"'","''")&"'"
end function

dim wordID,link,content

wordID = request("ID")
link = getString("link")
content = getString("content")
response.write "<br/>"&wordID
response.write "<br/>"&link
response.write "<br/>"&content



openDB "arabicWords"
	set cmd=Server.CreateObject("adodb.command")
	mySQL = "UPDATE [wordsLinks] SET [content]="&content&" WHERE [wordID]="&wordID&" AND [link]="&link
	cmd.CommandType=1
	cmd.CommandText=mySQL
	Response.Write "<br/><br/>mySQL = "& mySQL
	'Response.End
	set cmd.ActiveConnection=con
	cmd.execute ,,128
closeDB

Session("Message") = "הפרטים עודכנו."

Response.Redirect "videoControl.asp" %>
</div>
</body>
</html>