<!--#include file="inc/inc.asp"-->
<!DOCTYPE html>
<html style="height:100%;">
<head>
	<title>כל המילים במילון</title>
	<meta name="Description" content="כל המילים במילון בדף אחד" />
    <!--#include file="inc/header.asp"-->
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"--><%
dim suggest, order, pLetter
order = "hebrewTranslation"
Select case Left(Request("order")&"h",1)
    Case "e": order = "pronunciation"
    Case "a": order = "arabicWord"
End select
%>

<div id="pTitle">כל המילים במילון</div>
<br />
<div class="table" style="text-align:center;">
    <b>דף זה עלול לעלות לאט</b>, מכיוון שהוא מכיל את כל המילים במילון
</div>
<br />
<div id="simpleList"><%
	openDB "arabicWords"
	mySQL = "SELECT words.id, arabicWord, hebrewTranslation, pronunciation, userName FROM words LEFT JOIN " & _
	    "(SELECT * FROM [users] IN '"&Server.MapPath("/access_db/arabicUsers.mdb")&"') AS T " & _
	    "ON words.creatorID=T.ID WHERE words.show ORDER BY "& order
	res.open mySQL, con
	    Do until res.EOF
            if left(res("hebrewTranslation"),1) <> pLetter then %>
                <span class="letter"><%=left(res("hebrewTranslation"),1)%></span> <%
            end if %>
            <div class="simpleDiv" onclick="location.href='word.asp?id=<%=res("id")%>'">
                <span class="heb"><%=res("hebrewTranslation")%></span>
                <span class="arb"><%=res("arabicWord")%></span>
                <span class="eng"><%=res("pronunciation")%></span>
            </div><%
		    pLetter = left(res("hebrewTranslation"),1)
            res.moveNext
	    Loop
	    res.close %>
</div>
<br />
<!--#include file="inc/trailer.asp"-->