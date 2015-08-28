<!--#include file="inc/inc.asp"--><%
If (session("role") and 2) = 0 then
	session("msg") = "אין לך הרשאה להסתרת מילה. אם זו טעות, פנה למנהל המילון."
	Response.Redirect "login.asp"
end If

dim wordID,action,statusOld,status
dim errorTypes,explain

wordID = request ("wordID")
response.write "<br/>wordID = "& wordID
action = 2
response.write "<br/>action = "& action
statusOld = request ("status")
response.write "<br/>statusOld = "& statusOld
status = -1
response.write "<br/>status = "& status
errorTypes = request ("errorType")
response.write "<br/>errorTypes = "& errorTypes
explain = request ("explain")
response.write "<br/>explain = "& explain


openDB "arabicWords"
Set cmd=Server.CreateObject("adodb.command")

mySQL = "INSERT into history (word,actionDate,[action],statusOld,statusNew,[user],errorTypes,explain) VALUES ("&wordID&",now(),"&action&","&statusOld&","&status&","&session("userID")&",'"&errorTypes&"','"&explain&"')"

cmd.CommandType=1
cmd.CommandText=mySQL
response.write "<br/>mySQL = "& mySQL
'response.end
Set cmd.ActiveConnection=con
cmd.execute ,,128

'CHANGE STATUS in WORDS TABLE'
mySQL = "UPDATE words SET status="&status&" WHERE id="&wordId
cmd.CommandType=1
cmd.CommandText=mySQL
response.write "<br/><br/>mySQL = "& mySQL
'response.end
Set cmd.ActiveConnection=con
cmd.execute ,,128

session("msg") = "הערך סומן כלא-תקין ויועבר לבדיקה. תודה על עזרתך!"

Response.Redirect baseA&"word.asp?id="&wordID

%>