<!--#include file="inc/inc.asp"--><%
If (session("role") and 2) = 0 then Response.Redirect "login.asp" 
dim x, total


openDB "arabicWords" %>
<!DOCTYPE html>
<html>
<head>
	<title>מילים מוסתרות</title>
    <meta name="robots" content="none">
<!--#include file="inc/header.asp"-->
    <style>
        h1 {font-size:1em; margin:0;}
        h2 {font-size:1em;}
        #dashboard  { width:500px; margin:0 auto; }

        @media (max-width:520px) {
            #dashboard {width: 320px;}
        }
    </style>
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"-->
<!--#include file="inc/topTeam.asp"-->
<div id="dashboard">
    <div id="pTitle"><h1>מילים מוסתרות</h1></div>
    <span>מציג עד 50 ערכים, מסודר מותיק לחדש</span>
    <div id="check"><%
        mySQL="SELECT TOP 50 * FROM (SELECT * FROM words WHERE show=off ORDER BY creationDate)"
        res.open mySQL, con
	    Do until res.EOF %>
            <div class="listDiv" onclick="location.href='word.asp?id=<%=res("id")%>'">
                <span class="heb"><%=res("hebrewTranslation")%></span>
                <span class="arb"><%=res("arabicWord")%></span>
                <span class="eng"><%=res("pronunciation")%></span>
            </div><%
            res.movenext
        loop
        res.close %>
    </div>

</div>
<!--#include file="inc/trailer.asp"-->
</body>
</html>