<!--#include file="inc/inc.asp"--><%
If (session("role") and 2) = 0 then Response.Redirect "login.asp" 
dim x, total
openDB "arabicWords" %>
<!DOCTYPE html>
<html>
<head>
	<title>צוות מילון - דף ראשי</title>
    <meta name="robots" content="none">
<!--#include file="inc/header.asp"-->
    <style>
        h1 {font-size:1em; margin:0;}
        h2 {font-size:1em;}
        #dashboard  { width:500px; margin:0 auto; }
        .new {background-color: white; text-align: center; font-size: 3em; cursor: pointer;border: rgb(186, 218, 246) 1px solid; border-radius: 30px; margin: 0 auto; width: 98%;}
        .new a:visited, .new a:link {color: rgb(65, 145, 194);}
        #stats {display: table; width: 100%; margin-top:20px;}
        #stats > div {display: table-row;}
        #stats > div:not(:first-of-type) {cursor: pointer;}
        #stats span {display: table-cell; padding:8px 12px; text-align: right;}
        #stats span:nth-child(3n) {font-size: small;}
        #stats > div:first-of-type > span {border-bottom: 1px solid rgb(180, 180, 180);}
        #stats > div > span:first-of-type {width: 30%;}
        
        @media (max-width:520px) {
            #dashboard {width: 320px;}
            #stats > div > span:first-of-type {width: auto;}
        }
    </style>
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"-->
<!--#include file="inc/topTeam.asp"-->
<div id="dashboard">
    <div id="pTitle"><h1>צוות מילון - דף ראשי</h1></div>

    <div class="new" onclick="location.href='new.asp'" title="הוספת מילה חדשה">
        <a href="new.asp">+</a></div>
    <div id="stats">
        <h2>סטטיסטיקה</h2><% 
        mySQL="SELECT COUNT(*) FROM words"
        res.open mySQL, con
            total = res(0)
        res.close%>
        <div style="background-color: rgba(173, 173, 173, 0.25);">
            <span>סך כל המילים:</span>
            <span><%=total%>
            </span>
            <span>(100%)</span>
        </div>
        <div onclick="location.href='list.asp?status=2'" style="background-color: rgba(255, 0, 0, 0.2); color: rgb(164, 22, 22);">
            <span>חשד לטעות:</span>
            <span><% 
                mySQL="SELECT COUNT(*) FROM words WHERE status=-1"
                res.open mySQL, con
                    response.write res(0)
                    x = res(0)
                res.close%>
            </span>
            <span dir="ltr">
                (<%=round((x/total)*100,1)%>%)
            </span>
        </div>
        <div onclick="location.href='list.asp?status=0'" style="background-color: rgba(255, 255, 0, 0.31); color: rgb(147, 147, 10);">
            <span>טרם נבדקו:</span>
            <span><% 
                mySQL="SELECT COUNT(*) FROM words WHERE status=0"
                res.open mySQL, con
                    response.write res(0)
                    x = res(0)
                res.close%>
            </span>
            <span>
                (<%=round((x/total)*100,1)%>%)
            </span>
        </div>
        <div onclick="location.href='list.asp?status=1'" style="background-color: rgba(0, 128, 0, 0.13); color: green;">
            <span>נמצאו תקינות:</span>
            <span><% 
                mySQL="SELECT COUNT(*) FROM words WHERE status=1"
                res.open mySQL, con
                    response.write res(0)
                    x = res(0)
                res.close%>
            </span>
            <span>
                (<%=round((x/total)*100,1)%>%)
            </span>
        </div>
        <br/>
        <div onclick="location.href='listHidden.asp'" style="background-color: rgba(173, 173, 173, 0.25); margin-top:20px;">
            <span>מילים מוסתרות:</span>
            <span><% 
                mySQL="SELECT COUNT(*) FROM words WHERE show=off"
                res.open mySQL, con
                    response.write res(0)
                    x = res(0)
                res.close%>
            </span>
            <span>
                (<%=round((x/total)*100,1)%>%)
            </span>
        </div>
    </div>
</div>
<!--#include file="inc/trailer.asp"-->
</body>
</html>