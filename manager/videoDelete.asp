<!--#include file="inc/inc.asp"--><%
If session("role") <> 15 then Response.Redirect "login.asp"

dim wordID,link,query,msg

wordID = request("ID")
link = request("link")

openDB "arabicWords"
set cmd=Server.CreateObject("adodb.command")
query = "DELETE FROM wordsLinks WHERE wordID="&wordID&" AND link='"&link&"'"
cmd.CommandType=1
cmd.CommandText=query
Response.Write query
'Response.End
set cmd.ActiveConnection=con
cmd.execute ,,128

closeDB

Session("Message") = "הסרטון הוסר בהצלחה"
Response.Redirect "videoControl.asp" %>