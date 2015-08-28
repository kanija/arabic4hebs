<!--#include file="inc/inc.asp"-->
<!-- Language="VBScript" CodePage="65001"-->
<!-- Language="VBScript" CodePage="1255"--><%
Response.Write "<br/>TOP of code<br/>"
If (session("role") and 2) = 0 then Response.Redirect "login.asp"

Function getString (f)
	getString = "'" &replace(request(f),"'","&#39;")&"'"
End function

Dim wordID,query,msg,maxId,myMail
Dim actionDate,action,explain,errorTypes

Dim arabicWord,searchString,hebrew,pronunciation
Dim	partOfSpeach,gender,number,example,info,root
Dim imgLink,imgCredit,youtube,status,labels,show

Dim arabicWordOld,searchStringOld,hebrewOld,pronunciationOld
Dim	partOfSpeachOld,genderOld,numberOld,exampleOld,infoOld,rootOld
Dim imgLinkOld,imgCreditOld,youtubeOld,statusOld,labelsOld,showOld

Const lblCnt = 21
Dim labelsOldStr, labelsNewArr(),labelsNewStr
redim labelsNewArr(lblCnt)
'Dim label1,label2,label3,label4,label5,label6,label7,label8,label9,label10
'Dim label11,label12,label13,label14,label16,label17,label18,label19,label20,label21

openDB "arabicWords"

wordID = request("id")
    response.write "<br/>wordID = "&wordID&"<br/>"

explain = getString("explain")
	response.write "<br/>explain = "&explain

mySQL = "SELECT * FROM words WHERE id="&wordID
'response.write "<br/>mySQL = "&mySQL&"<br/>"
res.open mySQL, con
if res.EOF then
	session("msg") = "res.EOF on query: "&query
else
	showOld = res("show")
	arabicWordOld = "'" & res("arabicWord") & "'"
	hebrewOld = "'" & res("hebrewTranslation") & "'"
	pronunciationOld = "'" & res("pronunciation") & "'"
	searchStringOld = "'" & res("searchString") & "'"
	partOfSpeachOld = res("partOfSpeach")
	genderOld = res("gender")
	numberOld = res("number")
	exampleOld = "'" & res("example") & "'"
	infoOld = "'" & res("info") & "'"
	imgLinkOld = "'" & res("imgLink") & "'"
	imgCreditOld = "'" & res("imgCredit") & "'"
	statusOld = res("status")
	'youtubeOld = res("youtube")
	'labelsOld = res("labels")
end if
res.close

hebrew = getString("hebrewTranslation")
    response.write "<br/>hebrew = "&left(hebrew,len(hebrew))
	response.write "<br/>hebrewOld = "&left(hebrewOld,len(hebrewOld))
pronunciation = getString("pronunciation")
    response.write "<br/>pronunciation = "&pronunciation
	response.write "<br/>pronunciationOld = "&pronunciationOld
arabicWord = getString("arabicWord")
    response.write "<br/>arabicWord = "&arabicWord
    response.write "<br/>arabicWordOld = "&arabicWordOld

partOfSpeach = CLng(Request("partOfSpeach"))
    response.write "<br/>partOfSpeach = "&partOfSpeach
	response.write "<br/>partOfSpeachOld = "&partOfSpeachOld
gender = CLng(Request("gender"))
    response.write "<br/>gender = "&gender
	response.write "<br/>genderOld = "&genderOld
number = CLng(Request("number"))
    response.write "<br/>number = "&number
	response.write "<br/>numberOld = "&numberOld
example = getString("example")
    response.write "<br/>example = "&example
	response.write "<br/>exampleOld = "&exampleOld
info = getString("info")
    response.write "<br/>info = "&info
	response.write "<br/>infoOld = "&infoOld
imgLink = getString("imgLink")
    response.write "<br/>imgLink = "&imgLink
	response.write "<br/>imgLinkOld = "&imgLinkOld
imgCredit = getString("imgCredit")
    response.write "<br/>imgCredit = "&imgCredit
	response.write "<br/>imgCreditOld = "&imgCreditOld

status = request("status")
response.write "<br/>status = "&status
response.write "<br/>statusOld = "&statusOld


show = request("show")
	response.write "<br/>show = "&show
	response.write "<br/>showOld = "&showOld



Response.Write "<br/><br/>TEMP VALUES:<br/>"

action = 4
	response.write "<br/>action = "&action




Response.Write "<br/><br/>LEAVE FOR NOW...:<br/>"

searchString = Replace(Replace(Replace(getString("searchString"),",","|"),vbLf,"|"),vbCr,"")
if len(searchString)>255 then
    response.write "<br/>len Before=" & len(searchString)
    response.write "<br/>string Before=" & searchString
    searchString = left(searchString,255)
    response.write "<br/>len After=" & len(searchString)
    response.write "<br/>string After=" & searchString
end if
    response.write "<br/>searchString = "&searchString
	response.write "<br/>searchStringOld = "&searchStringOld
	response.write "<br/>"


errorTypes = "errorTypesTest"
	response.write "<br/>errorTypes = "&errorTypes

root = "0"
	response.write "<br/>root = "&root
rootOld = "0"
	response.write "<br/>rootOld = "&rootOld
labels = "lablesTEST"
	response.write "<br/>labels = "&labels
labelsOld = "lablesOldTEST"
	response.write "<br/>labelsOld = "&labelsOld
	response.write "<br/>"

youtube = request("youtube")
if youtube = empty then
    Response.Write "<br/>no youtube vid today"
else
    Response.Write "<br/>YEAY!! VIDEO!!"
    youtube = getString("youtube")
end if
	response.write "<br/>youtubeOld = "&youtubeOld

dim isFirst
dim i
labelsNewStr = ""
isFirst=true
for i=1 to lblCnt
	labelsNewArr(i)=(getString("label"&cstr(i))="'on'")
	if isFirst then
		if labelsNewArr(i) then
			labelsNewStr = cstr(i)
			isFirst = false
		end if
	else
		if labelsNewArr(i) then labelsNewStr = labelsNewStr & ", " & cstr(i)
	end if
	'response.write "<br/>labelsNewArr("&cstr(i)&") = "&labelsNewArr(i)
	'response.write "<br/>labelsNewStr = "&labelsNewStr
next

mySQL = "SELECT * FROM labels INNER JOIN wordsLabels ON labels.id=wordsLabels.labelID WHERE wordID=" + wordId
res.open mySQL, con
labelsOldStr = ""
isFirst=true
if not res.EOF then
	Do until res.EOF
		if isFirst then
			labelsOldStr = res("labelID")
			isFirst = false
		else
			labelsOldStr = labelsOldStr & ", " & res("labelID")
		end if
		res.moveNext
	Loop
end if
res.close

response.write "<br/>labelsOldStr = " & labelsOldStr

'Response.End

Set cmd=Server.CreateObject("adodb.command")

'THIS query is missing video, labels and searchString:'
query = "INSERT into history (word,actionDate,[action],statusOld,statusNew,[user],errorTypes,explain,showOld,showNew,hebrewOld,hebrewNew,arabicOld,arabicNew,pronunciationOld,pronunciationNew,searchStringOld,searchStringNew,rootOld,rootNew,partOfSpeachOld,partOfSpeachNew,genderOld,genderNew,numberOld,numberNew,infoOld,infoNew,exampleOld,exampleNew,imgLinkOld,imgLinkNew,imgCreditOld,imgCreditNew,labelsOld,labelsNew) VALUES ("&wordID&",now(),"&action&","&statusOld&","&status&","&session("userID")&",'"&errorTypes&"',"&explain&","&showOld&","&show&","&left(hebrewOld,len(hebrewOld))&","&left(hebrew,len(hebrew))&","&arabicWordOld&","&arabicWord&","&pronunciationOld&","&pronunciation&","&searchStringOld&","&searchString&","&rootOld&","&root&","&partOfSpeachOld&","&partOfSpeach&","&genderOld&","&gender&","&numberOld&","&number&","&infoOld&","&info&","&exampleOld&","&example&","&imgLinkOld&","&imgLink&","&imgCreditOld&","&imgCredit&",'"&labelsOldStr&"','"&labelsNewStr&"')"

cmd.CommandType=1
cmd.CommandText=query
Response.Write "<br/><br/>"& query
'Response.End
Set cmd.ActiveConnection=con
cmd.execute ,,128

query = "UPDATE words SET show="&show&",status="&status&",arabicWord="&arabicWord&",hebrewTranslation="&left(hebrew,len(hebrew))&",pronunciation="&pronunciation&",searchString="&searchString&",partOfSpeach="&partOfSpeach&",gender="&gender&",[number]="&number&",info="&info&",example="&example&",imgLink="&imgLink&",imgCredit="&imgCredit&" WHERE id="&wordId

cmd.CommandType=1
cmd.CommandText=query
Response.Write "<br/><br/>"& query
'Response.End
Set cmd.ActiveConnection=con
cmd.execute ,,128

query = "DELETE FROM wordsLabels WHERE wordID="&wordId
cmd.CommandType=1
cmd.CommandText=query
Set cmd.ActiveConnection=con
cmd.execute ,,128

for i=1 to lblCnt
	if labelsNewArr(i) then 
		query = "INSERT INTO wordsLabels (wordID,LabelID) VALUES ("&wordId&","&i&")"
		cmd.CommandText=query
		cmd.execute ,,128
	end if
next

session("msg") = "העריכה התבצעה בהצלחה"
response.Redirect "history.asp"
Response.End

query = "SELECT MAX(id) FROM words"
Set res = con.Execute (query)
maxId = res(0)

if len(youtube)=0 then 
    response.write "<br/>len(youtube)=0"
else
	query = "INSERT INTO wordsLinks (wordID, description, link) VALUES (" & maxId & ",'YouTube Embed',"&youtube&")"
    Response.Write "<br/>" & query
    Response.end
	cmd.CommandText=query
	cmd.execute ,,128
end if

response.write "<br/>Start OF labels"


closeDB

session("msg") = "המילה <a href=""http://ronen.rothfarb.info/arabic/word.asp?id=" & maxId & """><span class=""nikud"">" & arabicWord & "</span></a> נוספה למילון בהצלחה"

response.write "<br/>END OF INSERT"
'response.end
Response.Redirect "send_email.php?wordID="&maxId&"&arabic="&arabicWord
%>