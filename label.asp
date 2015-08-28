<!--#include file="inc/inc.asp"--><%
dim countMe, nikud, order
dim LID, LName, psik, current
order = "arabicWord"
Select case Left(Request("order")&"a",1)
    Case "e": order = "pronunciation"
    Case "h": order = "hebrewTranslation"
End select
countMe = 0
nikud = ""
LID = Request("id")
LName = "empty"
psik = ""

openDB "arabicWords"
mySQL = "SELECT labelName FROM labels Where ID="+LID
res.open mySQL, con
    LName = res("labelName")
res.close
%>
<!DOCTYPE html>
<html style="height:100%;">
<head>
    <title><%=LName%></title>
	<meta name="Description" content="קבוצות מילים לפי נושאים" />
    <!--#include file="inc/header.asp"-->
</head>
<body style="height:100%;">

<!--#include file="inc/top.asp"-->
<div id="pTitle">קבוצות מילים לפי נושאים</div>

<div id="tagsNew" class="lMenu">
    <ul><%
	mySQL = "SELECT * FROM labels ORDER BY labelName"
	res.open mySQL, con
	    Do until res.EOF 
            If cint(LID) = res("id") then
                LName = res("labelName")%>
                <li id="current"><%
            else %>
                <li><%
            End if%>
                <a href="label.asp?id=<%=res("id")%>"><%=res("labelName")%></a></li><%
		    res.moveNext
	    Loop
	res.close%>
    </ul>
</div>

<div id="tagTitle">
    <h3><%=LName%></h3>
</div>

	<table class="tableHeader">
	    <tr>
			<td style="width:33%;text-align:right;">
                <%if order="hebrewTranslation" then %> עברית <img src="img/site/sort.png" alt="סידור לפי עברית" /><%else %> <a href="label.asp?id=<%=LID%>&amp;order=h">עברית</a><%end if%></td>
		    <td style="width:34%;text-align:center;">
                <%if order="arabicWord" then %> ערבית <img src="img/site/sort.png" alt="סידור לפי ערבית" /><%else %> <a href="label.asp?id=<%=LID%>&amp;order=a">ערבית</a><%end if%></td>
	        <td style="width:33%;" class="tdEng">
                <%if order="pronunciation" then %> הגייה <img src="img/site/sort.png" alt="סידור לפי הגייה" /><%else %> <a href="label.asp?id=<%=LID%>&amp;order=e">הגייה</a><%end if%></td>
	    </tr>
    </table>
	<%
    mySQL = "SELECT DISTINCT words.id, words.arabicWord, words.hebrewTranslation, words.pronunciation, words.status, words.imgLink, wordsLabels.labelID, wordsLinks.description "&_
            "FROM (words INNER JOIN wordsLabels ON words.id = wordsLabels.wordID) LEFT JOIN wordsLinks ON words.id = wordsLinks.wordID "&_
            "WHERE (((wordsLabels.labelID)=" & LID & ")) ORDER BY "& order
	res.open mySQL, con

	    Do until res.EOF
	    if countMe mod 2 <> 0 Then nikud = "bg"%>
        <div class="listDiv" onclick="location.href='word.asp?id=<%=res("id")%>'"><%
            if len(res("imgLink"))>0 then %>
                <img src="img/site/photo.png" alt="לערך זה יש תמונה" title="לערך זה יש תמונה" class="img" /><%
            end if
            if res("description") <> "" then %>
                <img src="img/site/video.png" alt="לערך זה יש סרטון" title="לערך זה יש סרטון" class="img" /><%
            end if %>
            <span class="heb <%=nikud%>">
		        <%=res("hebrewTranslation")%><%

                Select Case res("status")
                    Case 1 %>
                    <img src="img/site/correct.png" alt="ערך זה נבדק ונמצא תקין" title="ערך זה נבדק ונמצא תקין" style="width:20px;opacity:0.7;float:left;" /> <%
                    Case -1 %>
                    <img src="img/site/erroneous.png" alt="ערך זה סומן כלא תקין" title="ערך זה סומן כלא תקין" style="width:20px;opacity:0.7;float:left;" /><%
                End Select  %>
            </span>
            <span class="arb <%=nikud%>"><%=res("arabicWord")%></span>
            <span class="eng <%=nikud%>"><%=res("pronunciation")%></span>
        </div><%
		    res.moveNext
		    nikud = ""
		    countMe = countMe + 1
	    Loop
	    res.close %>

<script type="text/javascript"><!--
    //document.title = document.title + " : <%=LName%>";
//--></script>
<!--#include file="inc/trailer.asp"-->