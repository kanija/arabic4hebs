<!--#include file="inc/inc.asp"-->
<!DOCTYPE html>
<html style="height:100%;">
<head>
	<title>מילים עם סרטונים</title>
	<meta name="Description" content="כל המילים שיש להם סירטון" />
	<!--#include file="inc/header.asp"-->
    <style>
        #center {text-align:center;}
        .heb {text-align: right;}
        .listDiv {width:320px; display:inline-block; border:1px dotted grey;}
        .youtube {width:320px; height:180px;}
        
        @media (max-width:340px) {
            
            .listDiv {border:0;padding:0;margin-bottom:15px;}
        }
        
    </style>
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"-->
<div id="pTitle">סרטונים</div>
<div id="center">
    <div>
        <script src="https://apis.google.com/js/platform.js"></script>
        <div class="g-ytsubscribe" data-channelid="UCHnLvw-TCwckLXmjYozv9tw" data-layout="default" data-count="default"></div>
    </div><%
dim countMe, lastLink
lastLink = ""
countMe = 0

openDB "arabicWords"

mySQL = "SELECT DISTINCT wordsLinks.link, wordsLinks.content, wordsLinks.description, wordsLinks.wordID, words.arabicWord, words.hebrewTranslation, words.pronunciation, words.status, words.imgLink "&_
        "FROM words INNER JOIN wordsLinks ON words.id = wordsLinks.wordID "&_
        "WHERE (((wordsLinks.description)='YouTube Embed')) ORDER BY wordsLinks.link;"

mySQL = "SELECT DISTINCT link,content FROM wordsLinks WHERE description='YouTube Embed' ORDER BY content;"

res.open mySQL, con
    Do until res.EOF
            'if res("link")<>lastLink then %>
            <div class="listDiv">
                <div style="padding:10px 0px;">
                    <span class="heb">
                        <%=res("content")%>
                    </span>
                </div>

                <div class="youtube" id="<%=res("link")%>"></div>


            </div>
            <%
		    lastLink = res("link")
            countMe = countMe + 1
            'end if
		res.moveNext
	Loop
res.close 
closeDB %>
<br />
</div>
<script src="http://ronen.rothfarb.info/arabic/inc/youtube.js"></script>
<!--#include file="inc/trailer.asp"-->