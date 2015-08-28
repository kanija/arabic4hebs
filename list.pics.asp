<!--#include file="inc/inc.asp"-->
<!DOCTYPE html>
<html style="height:100%;">
<head>
	<title>מילים עם תמונות</title>
	<meta name="Description" content="כל המילים שיש להם תמונה" />
	<!--#include file="inc/header.asp"-->
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"--><%
dim countMe, order
order = "hebrewTranslation"
Select case Left(Request("order")&"h",1)
    Case "e": order = "pronunciation"
    Case "a": order = "arabicWord"
End select
countMe = 0 %>

<div id="pTitle">מילים עם תמונות</div>

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
            "FROM words left JOIN wordsLinks ON words.id = wordsLinks.wordID WHERE show ORDER BY "& order
	res.open mySQL, con
	Do until res.EOF
		if res("imgLink") <> false then %>
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
		    countMe = countMe + 1
			end if
		    res.moveNext
		Loop
	    res.close %>

<br />
<!--#include file="inc/trailer.asp"-->