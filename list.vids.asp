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
<div id="pTitle">מילים עם סרטונים</div>
<div id="center"><%
dim countMe, lastLink
lastLink = ""
countMe = 0

openDB "arabicWords"
mySQL = "SELECT wordsLinks.description, wordsLinks.link, wordsLinks.wordID, words.arabicWord, words.hebrewTranslation, words.pronunciation, words.status, words.imgLink "&_
        "FROM words INNER JOIN wordsLinks ON words.id = wordsLinks.wordID "&_
        "WHERE (((wordsLinks.description)='YouTube Embed')) ORDER BY wordsLinks.link;"
res.open mySQL, con
    Do until res.EOF
            'if res("link")<>lastLink then %>
            <div class="listDiv">
                <div style="padding:10px 0px;" onclick="location.href='word.asp?id=<%=res("wordID")%>'"><%
                    if res("imgLink") <> false then %>
                        <img src="img/site/photo.png" alt="לערך זה יש תמונה" title="לערך זה יש תמונה" class="img" /><%
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