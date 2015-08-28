<!--#include file="inc/inc.asp"--><%
If (session("role") and 2) = 0 then
	session("msg") = "אין לך הרשאה להסתרת מילה. אם זו טעות, פנה למנהל המילון."
	Response.Redirect "login.asp"
end If

dim query,msg,wordId,action,showOld,show,explain

wordId = CLng(Request("id"))
explain = Request("explain")

openDB "arabicWords"

query = "SELECT show FROM words WHERE id="&wordID
res.open query, con
	showOld = res(0)
res.close	    

if showOld="True" then
	show="False"
	action=5 'Hide'
	session("msg") = "המילה הוסתרה מהגולשים"
else
	show="True"
	action=6 'unHide'
	session("msg") = "המילה מוצגת לגולשים"
end if
response.write "<br/>showOld="&showOld
response.write "<br/>show="&show
'response.end

'insert to history'
set cmd=Server.CreateObject("adodb.command")
query = "INSERT INTO history (word,actionDate,[action],[user],showOld,showNew,explain) VALUES ("&wordID&",now(),"&action&","&session("userID")&","&showOld&","&show&",'"&explain&"')"
cmd.CommandType=1
cmd.CommandText=query
'Response.Write query
'Response.End
set cmd.ActiveConnection=con
cmd.execute ,,128



query = "UPDATE [words] SET show=not show WHERE id="&wordId
cmd.CommandType=1
cmd.CommandText=query
'Response.Write query
'Response.End
set cmd.ActiveConnection=con
cmd.execute ,,128
closeDB

Response.Redirect "../word.asp?id="&wordId
%>