<!--#include file="inc/inc.asp"-->
<!DOCTYPE html>
<html style="height:100%;">
<head>
	<title>מילון ערבית מדוברת - לדוברי עברית</title>
	<meta name="Description" content="המילון לערבית מדוברת (לדוברי עברית), הוא שירות חינמי והתנדבותי שנועד לעזור לאלה מכם שלומדים ערבית מדוברת, ורוצים למצוא תירגום מהיר למילים מסוימות" />
	<meta name="Keywords" content="מילון, ערבית, מדוברת, עברית, עברי, ערבי, חופשי, חינם, חינמי, תרגום, תירגום, מילים, איך, אומרים, בערבית" />
    <!--#include file="inc/header.asp"-->
</head>
<body>

<!--#include file="inc/top.asp"--><%

dim countMe, nikud, suggest, order, qWord, lastID
order = "hebrewTranslation"
Select case Left(Request("order")&"h",1)
    Case "e": order = "pronunciation"
    Case "a": order = "arabicWord"
End select
lastID = 0
countMe = 0
If Len(qFix)=0 then
	Randomize
	Select case Round(Rnd * 2)
		Case 0: suggest = "ברוכים הבאים&nbsp;"
		Case else: suggest = "מרחבא&nbsp;"
	End select
End if
qWord = Server.URLEncode(qFix)
nikud = ""%>
<!--Rich snippets for Google Search-->
<div itemscope itemtype="http://schema.org/Organization" style="display:none;"> 
   <span itemprop="name">מילון ערבית מדוברת - לדוברי עברית</span>
  <img itemprop="logo" src="img/site/logo.jpg" alt="logo" />
   <a href="http://ronen.rothfarb.info/arabic" itemprop="url">http://ronen.rothfarb.info/arabic</a>
</div>
<!--Ends here-->

<br/><br />
<div id="instructions">הקלידו מילה בעברית או בערבית מדוברת</div>

<form action="default.asp">
    <table id="search">
        <tr>
            <td colspan="2" id="searchTd">
                <input id="searchBox" onclick="this.select();" type="text" name="q" value="<%=qFix & suggest%>" />
            </td>
        </tr>
        <tr>
            <td id="searchRight">
                (תעתיק עברי בלבד)
            </td>
            <td id="searchLeft">
                <input style="font-size:125%; width:65px;" type="submit" value="חפש"/>
            </td>
        </tr>
    </table>
	<input type="hidden" name="order" value="<%=request("order")%>" />
</form>
<%
If len(qFix)>0 then
	openDB "arabicWords"
	mySQL = "SELECT words.id, words.arabicWord, words.hebrewTranslation, words.pronunciation, words.imgLink, words.status, wordsLinks.description "&_
            "FROM words LEFT JOIN wordsLinks ON words.id = wordsLinks.wordID "&_
            "WHERE show AND searchString LIKE ""%"&qFix&"%"" ORDER BY searchString LIKE ""%|"&qFix&"%"", "& order
	res.open mySQL, con
	if res.EOF then %>
        <div style="width:310px; margin:4px auto; text-align:center; background:#fbf2f2; color:#bf2121; font-size:125%; padding:8px 0px;">לא נמצאו תוצאות ל '<%=q%>'</div><%
	else%>
	<table class="tableHeader">
	    <tr>
			<td style="width:33%;text-align:right;">
                <%if order="hebrewTranslation" then %> עברית <img src="img/site/sort.png" alt="סדר לפי עברית" /><%else %> <a href="default.asp?q=<%=qWord%>&amp;order=h">עברית</a><%end if%></td>
		    <td style="width:34%;text-align:center;">
                <%if order="arabicWord" then %> ערבית <img src="img/site/sort.png" alt="סדר לפי ערבית" /><%else %> <a href="default.asp?q=<%=qWord%>&amp;order=a">ערבית</a><%end if%></td>
	        <td style="width:33%;" class="tdEng">
                <%if order="pronunciation" then %> הגייה <img src="img/site/sort.png" alt="סדר לפי הגייה" /><%else %> <a href="default.asp?q=<%=qWord%>&amp;order=e">הגייה</a><%end if%></td>
	    </tr>
	</table>
    <%end if
	    Do until res.EOF
	        if lastID <> res("id") then
                if countMe mod 2 <> 0 Then nikud = "bg"%>
                <div class="listDiv" onclick="location.href='word.asp?id=<%=res("id")%>'">
                    <span style="float:left;"><%
                        if len(res("imgLink"))>0 then %>
                            <img src="img/site/photo.png" alt="לערך זה יש תמונה" title="לערך זה יש תמונה" class="img" /><%
                        end if
                        if res("description") <> "" then %>
                            <img src="img/site/video.png" alt="לערך זה יש סרטון" title="לערך זה יש סרטון" class="img" /><%
                        end if 

                        Select Case res("status")
                            Case 1 %>
                            <img src="img/site/correct.png" id="ערך זה נבדק ונמצא תקין" alt="ערך זה נבדק ונמצא תקין" title="ערך זה נבדק ונמצא תקין" style="width:15px;opacity:0.7;margin-top:4px;" /> <%
                            Case -1 %>
                            <img src="img/site/erroneous.png" id="ערך זה סומן כלא תקין" alt="ערך זה סומן כלא תקין" title="ערך זה סומן כלא תקין" style="width:15px;opacity:0.7;margin-top:4px;" /><%
                        End Select%>
                    </span>
                    <span class="heb <%=nikud%>">
		                <%=res("hebrewTranslation")%>
                    </span>
                    <span class="arb <%=nikud%>"><%=res("arabicWord")%></span>
                    <span class="eng <%=nikud%>"><%=res("pronunciation")%></span>
                </div><%
            end if
		    lastID = res("id")
            res.moveNext
		    nikud = ""
		    countMe = countMe + 1
	    Loop
	    res.close %>
    <div id="results">נמצאו <%=countMe%> תוצאות לחיפוש '<%=q%>'</div><%
    closeDB
end if%>
<div style="min-width:320px; max-width:490px; margin:50px auto;">
    <script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
    <!-- Search Results Ad -->
    <ins class="adsbygoogle"
         style="display:block"
         data-ad-client="ca-pub-3338230826889333"
         data-ad-slot="9595580203"
         data-ad-format="auto"></ins>
    <script>
    (adsbygoogle = window.adsbygoogle || []).push({});
    </script>
</div>        
<!--#include file="inc/trailer.asp"-->
<%
response.Flush
If len(qFix)>0 then
	openDB "arabicSearch"
	mySQL = "SELECT searchCount FROM wordsSearched WHERE typed="""&q&""""
	res.open mySQL, con
	if res.EOF then
		mySQL = "INSERT into wordsSearched(typed) VALUES("""&q&""")"
	else
		mySQL = "UPDATE wordsSearched SET searchCount="&(res(0)+1)&" WHERE typed="""&q&""""
	end if
	res.close
	con.execute mySQL
	closeDB
end if
 %>