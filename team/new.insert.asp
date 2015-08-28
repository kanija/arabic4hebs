<!--#include file="inc/inc.asp"-->
<!-- Language="VBScript" CodePage="65001"-->
<!-- Language="VBScript" CodePage="1255"--><%
Response.Write "TOP of code"
If (session("role") and 2) = 0 then Response.Redirect "login.asp"

Function getString (f)
	getString = "'" &replace(request(f),"'","&#39;")&"'"
End function

Dim query,msg,maxId,myMail,cTime
Dim arabicWord,searchString,hebrewTranslation,pronunciation
Dim	partOfSpeach,gender,number,example,info
Dim imgLink,imgCredit,youtube, status
Dim label1, label2, label3, label4, label5, label6, label7,label8,label9,label10
Dim label11, label12, label13, label14, label16, label17, label18, label19, label20
Dim label21

arabicWord = getString("arabicWord")
searchString = Replace(Replace(Replace(getString("searchString1")&"&'|'&"& getString("searchString2"),",","|"),vbLf,"|"),vbCr,"")
if len(searchString)>255 then
    response.write "<br/>len Before=" & len(searchString)
    response.write "<br/>string Before=" & searchString
    searchString = left(searchString,255)
    response.write "<br/>len After=" & len(searchString)
    response.write "<br/>string After=" & searchString
    response.end
end if
hebrewTranslation = getString("hebrewTranslation")
pronunciation = getString("pronunciation")
partOfSpeach = CLng(Request("partOfSpeach"))
gender = CLng(Request("gender"))
number = CLng(Request("number"))
example = getString("example")
info = getString("info")
imgLink = getString("imgLink")
imgCredit = getString("imgCredit")
if (session("role") And 4)>0 then status=1 else status=0

Response.Write "<br/>WHERE AM II?"
    
youtube = request("youtube")
if youtube = empty then
    Response.Write "<br/>no youtube vid today"
else
    Response.Write "<br/>YEAY!! VIDEO!!"
    youtube = getString("youtube")
end if

label1=(getString("label1")="'on'")
label2=(getString("label2")="'on'")
label3=(getString("label3")="'on'")
label4=(getString("label4")="'on'")
label5=(getString("label5")="'on'")
label6=(getString("label6")="'on'")
label7=(getString("label7")="'on'")
label8=(getString("label8")="'on'")
label9=(getString("label9")="'on'")
label10=(getString("label10")="'on'")
label11=(getString("label11")="'on'")
label12=(getString("label12")="'on'")
label13=(getString("label13")="'on'")
label14=(getString("label14")="'on'")
label16=(getString("label16")="'on'")
label17=(getString("label17")="'on'")
label18=(getString("label18")="'on'")
label19=(getString("label19")="'on'")
label20=(getString("label20")="'on'")
label21=(getString("label21")="'on'")

cTime = DateAdd("h",10,now()) 'ADDING 10 Hours to sync with Israel's Timezone'

openDB "arabicWords"
Set cmd=Server.CreateObject("adodb.command")
query = "INSERT INTO words (arabicWord,searchString,hebrewTranslation,pronunciation,"&_
		"partOfSpeach,gender,[number],example,info,creatorID,creationDate,imgLink,imgCredit,status) VALUES ("& _
		arabicWord&",'|'&"&searchString&","& hebrewTranslation&","&pronunciation&","&_
		partOfSpeach&","&gender&","&number&","&example&","&info&","&session("userID")&",'"&cTime&"',"&imgLink&","&imgCredit&","&status&")"
cmd.CommandType=1
cmd.CommandText=query
Response.Write "<br/>"& query
'Response.End
Set cmd.ActiveConnection=con
cmd.execute ,,128

query = "SELECT MAX(id) FROM words"
Set res = con.Execute (query)
maxId = res(0)

if len(youtube)=0 then 
    response.write "<br/>len(youtube)=0"
else
	query = "INSERT INTO wordsLinks (wordID, description, link) VALUES (" & maxId & ",'YouTube Embed',"&youtube&")"
    Response.Write "<br/>" & query
    'Response.end
	cmd.CommandText=query
	cmd.execute ,,128
end if

response.write "<br/>Start OF labels"

if label1 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 1)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label2 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 2)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label3 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 3)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label4 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 4)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label5 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 5)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label6 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 6)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label7 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 7)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label8 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 8)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label9 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 9)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label10 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 10)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label11 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 11)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label12 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 12)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label13 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 13)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label14 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 14)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label16 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 16)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label17 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 17)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label18 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 18)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label19 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 19)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label20 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 20)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
if label21 then 
	query = "INSERT INTO wordsLabels (wordID, LabelID) VALUES (" & maxId & ", 21)"
	cmd.CommandText=query
	cmd.execute ,,128
end if
response.write "<br/>END OF labels"

closeDB

session("msg") = "המילה <a href=""../word.asp?id=" & maxId & """><span class=""nikud"">" & arabicWord & "</span></a> נוספה למילון בהצלחה"

response.write "<br/>END OF INSERT"
'response.end
if serverName="ronen.rothfarb.info" then Response.Redirect "send_email.php?wordID="&maxId&"&arabic="&arabicWord
Response.Redirect "../word.asp?id="&maxId
%>