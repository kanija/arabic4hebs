<!--#include file="inc/inc.asp"-->
<!DOCTYPE html>
<html style="height:100%;">
<head>
	<title>מילים עם סרטונים</title>
	<meta name="Description" content="כל המילים שיש להם סירטון" />
	<!--#include file="inc/header.asp"-->
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"--><%
dim countMe, order, lastID
order = "hebrewTranslation"
Select case Left(Request("order")&"h",1)
    Case "e": order = "pronunciation"
    Case "a": order = "arabicWord"
End select
lastID = 0
countMe = 0%>

<div id="pTitle">מילים עם סרטונים</div>

<table class="tableHeader">
	<tr>
		<td style="width:33%;text-align:right;">
            <%if order="hebrewTranslation" then %> עברית <img src="img/site/sort.png" /><%else %> <a href="?order=h">עברית</a><%end if%></td>
		<td style="width:34%;text-align:center;">
            <%if order="arabicWord" then %> ערבית <img src="img/site/sort.png" /><%else %> <a href="?order=a">ערבית</a><%end if%></td>
	    <td style="width:33%;" class="tdEng">
            <%if order="pronunciation" then %> הגייה <img src="img/site/sort.png" /><%else %> <a href="?order=e">הגייה</a><%end if%></td>
	</tr>
</table><%
openDB "arabicWords"
mySQL = "SELECT words.id, words.arabicWord, words.hebrewTranslation, words.pronunciation, words.imgLink, words.status, wordsLinks.description "&_
        "FROM words LEFT JOIN wordsLinks ON words.id = wordsLinks.wordID WHERE show ORDER BY "& order
res.open mySQL, con
    Do until res.EOF
        mySQL = "SELECT * FROM wordsLinks INNER JOIN words ON wordsLinks.wordID=words.ID WHERE words.ID = " & res("id")
	    res2.open mySQL, con
        Do until res2.EOF
            if res2("description")="YouTube Embed" and res2("id")<>lastID then %>
            <div class="listDiv" onclick="location.href='word.asp?id=<%=res("id")%>'"><%
                if res("imgLink") <> false then %>
                    <img src="img/site/photo.png" alt="לערך זה יש תמונה" title="לערך זה יש תמונה" class="img" /><%
                end if
                if res("description") <> "" then %>
                    <img src="img/site/video.png" alt="לערך זה יש סרטון" title="לערך זה יש סרטון" class="img" /><%
                end if %>
                <span class="heb">
		            <%=res("hebrewTranslation")%><%

                    Select Case res("status")
                        Case 1 %>
                        <img src="img/site/correct.png" id="ערך זה נבדק ונמצא תקין" alt="ערך זה נבדק ונמצא תקין" title="ערך זה נבדק ונמצא תקין" style="width:20px;opacity:0.7;float:left;" /> <%
                        Case -1 %>
                        <img src="img/site/erroneous.png" id="ערך זה סומן כלא תקין" alt="ערך זה סומן כלא תקין" title="ערך זה סומן כלא תקין" style="width:20px;opacity:0.7;float:left;" /><%
                    End Select  %>
                </span>
                <span class="arb"><%=res("arabicWord")%></span>
                <span class="eng"><%=res("pronunciation")%></span>
            </div><%
		    lastID = res2("id")
		    countMe = countMe + 1
            end if
            res2.movenext
        loop
        res2.close
		res.moveNext
	Loop
res.close 
closeDB %>

<br />
<!--#include file="inc/trailer.asp"-->