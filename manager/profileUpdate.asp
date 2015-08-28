<!--#include file="inc/inc.asp"--><%
If session("role") <> 15 then Response.Redirect "login.asp"


function getString (f)
	getString = "'" &replace(request(f),"'","&#39;")&"'"
end function

dim name,eMail,about,username,password,role,gender, picture
dim query,msg,userId

userId = CLng(Request("id"))
name = getString("name")
eMail = getString("eMail")
about = getString("about")
username = getString("username")
password = getString("password")
If password = "''" then password = "[password]"
role = replace(Request("role"), ",", "+")
gender = getString("gender")
picture = Request("picture")

openDB "arabicUsers"
set cmd=Server.CreateObject("adodb.command")
query = "UPDATE [users] SET [name]="&name&",[eMail]="&eMail&",[about]="&about&",[username]="& _
    username&",[password]="&password&",[gender]="&gender&",[picture]="&picture&",[role]="&role&"+1 WHERE id="&userId
cmd.CommandType=1
cmd.CommandText=query
'Response.Write query
'Response.End
set cmd.ActiveConnection=con
cmd.execute ,,128
closeDB

Session("Message") = "הפרטים עודכנו."

Response.Redirect "profileEdit.asp?id="&userId
%>