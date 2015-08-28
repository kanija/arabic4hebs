<!--#include file="inc/inc.asp"--><%
If session("role") <> 15 then Response.Redirect "login.asp"

function getString (f)
	getString = "'" &replace(request(f),"'","&#39;")&"'"
end function

dim name,eMail,about,username,password,role,gender
dim query,msg,maxId

name = getString("name")
eMail = getString("eMail")
about = getString("about")
username = getString("username")
password = getString("password")
role = replace(Request("role"), ",", "+")
gender = getString("gender")

openDB "arabicUsers"
set cmd=Server.CreateObject("adodb.command")
query = "INSERT INTO [users] ([name],[eMail],[about],[username],[password],[role],[gender]) VALUES ("&_
		name&","&eMail&","&about&","&username&","&password&","&role&"+1, "&gender&")"
cmd.CommandType=1
cmd.CommandText=query
'Response.Write query
'Response.End
set cmd.ActiveConnection=con
cmd.execute ,,128
query = "SELECT MAX(id) FROM users"
set res = con.Execute (query)
maxId = res(0)
closeDB

Session("Message") = "המשתמש נוסף."

Response.Redirect "profileEdit.asp?id="&maxId
%>