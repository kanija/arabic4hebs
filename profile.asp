<!--#include file="inc/inc.asp"--><%
dim userId, name, d, gen, countMe, nikud

gen=""
countMe = 0
nikud = ""
userId = request("id")

openDB "arabicUsers"
mySQL = "SELECT * FROM users WHERE id =" &userId
res.open mySQL, con
if res.EOF then
    session("msg") = "מספר משתמש לא קיים"
    Response.Redirect "default.asp"
else
    name = res("name")
end if
%>
<!DOCTYPE html>
<html style="height:100%;">
<head>
    <title><%=res("username")%></title>
	<meta name="Description" content="שם המשתמש: <%=res("username")%>" />
    <!--#include file="inc/header.asp"-->
</head>
<body>

<!--#include file="inc/top.asp"-->
<br />
<table class="table" style="background:white; box-shadow:4px 2px 5px -2px #888; margin-bottom:20px;">
    <tr style="vertical-align:top;">
        <td style="width:360px; text-align:right; padding:8px;">
	        <span style="display:block;"><%=res("username")%></span>
	        <span style="font-size:small; line-height:15px;"><%=res("about")%></span>
        </td>
        <td style="width:130px; text-align:left;"><% 
            if res("gender")="2" then 
                gen="fe"
            else
                gen=""
            end if
            if res("picture")=true then %>
                <img src="img/profiles/<%=res("id")%>.png" style="height:128px;" title="<%=res("username")%>'s avatar" /> <%
            else %>
                <img src="img/profiles/<%=gen %>male.png" style="height:128px;" title="<%=res("username")%>'s avatar" /><%
            end if %>
        </td>
    </tr>
</table><%
closeDB 

openDB "arabicWords"
mySQL = "SELECT * FROM words WHERE show AND creatorId =" &userId& " ORDER BY creationDate DESC"
res.open mySQL, con
if res.EOF then %>
    <div class="table">משתמש זה טרם הוסיף ערכים למילון</div><%
else%>
	<h4 class="table">מילים שהוסיף משתמש זה למילון:</h4>
    <table class="tableHeader">
	    <tr>
			<td style="width:33%;text-align:right;">עברית</td>
		    <td style="width:34%;text-align:center;">ערבית</td>
	        <td style="width:33%;" class="tdEng">הגייה</td>
	    </tr>
	</table><%
	Do until res.EOF
        d = res("creationDate")
	    if countMe mod 2 <> 0 Then nikud = "bg"%>
        <div class="listDiv" onclick="location.href='word.asp?id=<%=res("id")%>'"><%
            if len(res("imgLink"))>0 then %>
                <img src="img/site/photo.png" alt="לערך זה יש תמונה" title="לערך זה יש תמונה" class="img" /><%
            end if %>
            <span class="heb <%=nikud%>">
		        <%=res("hebrewTranslation")%><%
                Select Case res("status")
                    Case 1 %>
                    <img src="img/site/correct.png" id="ערך זה נבדק ונמצא תקין" alt="ערך זה נבדק ונמצא תקין" title="ערך זה נבדק ונמצא תקין" style="width:20px;opacity:0.7;float:left;" /> <%
                    Case -1 %>
                    <img src="img/site/erroneous.png" id="ערך זה סומן כלא תקין" alt="ערך זה סומן כלא תקין" title="ערך זה סומן כלא תקין" style="width:20px;opacity:0.7;float:left;" /><%
                End Select  %>
            </span>
            <span class="arb <%=nikud%>"><%=res("arabicWord")%></span>
            <span class="eng <%=nikud%>">
                <%=res("pronunciation")%>
                <span id="createDate">
                    <span style="display:inline;padding-right:0px;"><%=Day(d)%> ב<%=MonthName(Month(d))%>, <%=year(d)%></span>
                    <span style="display:inline; font-size:smaller;"><%=formatDateTime(d,4)%></span>
                </span>
            </span>
        </div><%
		res.moveNext
		nikud = ""
		countMe = countMe + 1
	Loop%>
    <div class="results">נמצאו <%=countMe%> תוצאות </div><%    
end if
res.close 


if (session("role") And 2)>0 then
	mySQL = "SELECT * FROM words WHERE show=false AND creatorId =" &userId& " ORDER BY creationDate DESC"
	res.open mySQL, con
    if res.EOF then %>
        <div style="width:310px; margin:4px auto; text-align:center; background:#fbf2f2; color:#bf2121; font-size:125%; padding:8px 0px;">לא נמצאו ערכים מוסתרים למשתמש זה</div><%
    else%>
        <table class="tableHeader">
	        <tr><td colspan="3">
                <h3>מילים מוסתרות</h3>
            </td></tr>
	        <tr>
			    <td style="width:33%;text-align:right;">עברית</td>
		        <td style="width:34%;text-align:center;">ערבית</td>
	            <td style="width:33%;" class="tdEng">הגייה</td>
	        </tr>
	    </table><%
        countMe = 0
	    Do until res.EOF
            d = res("creationDate")
	        if countMe mod 2 <> 0 Then nikud = "bg"%>
            <div class="listDiv" onclick="location.href='word.asp?id=<%=res("id")%>'"><%
                if res("imgLink") <> false then %>
                    <img src="img/site/photo.png" alt="לערך זה יש תמונה" title="לערך זה יש תמונה" class="img" /><%
                end if %>
                <span class="heb <%=nikud%>">
		            <%=res("hebrewTranslation")%><%
                    Select Case res("status")
                        Case 1 %>
                        <img src="img/site/correct.png" id="ערך זה נבדק ונמצא תקין" alt="ערך זה נבדק ונמצא תקין" title="ערך זה נבדק ונמצא תקין" style="width:20px;opacity:0.7;float:left;" /> <%
                        Case -1 %>
                        <img src="img/site/erroneous.png" id="ערך זה סומן כלא תקין" alt="ערך זה סומן כלא תקין" title="ערך זה סומן כלא תקין" style="width:20px;opacity:0.7;float:left;" /><%
                    End Select  %>
                </span>
                <span class="arb <%=nikud%>"><%=res("arabicWord")%></span>
                <span class="eng <%=nikud%>">
                    <%=res("pronunciation")%>
                    <span style="font-size:small;float:right; display:inline; color:gray; direction:rtl; padding-right:0px;">
                        <span style="display:inline;padding-right:0px;"><%=Day(d)%> ב<%=MonthName(Month(d))%>, <%=year(d)%></span>
                        <span style="display:inline; font-size:smaller;"><%=formatDateTime(d,4)%></span>
                    </span>
                </span>
            </div><%
		    res.moveNext
		    nikud = ""
		    countMe = countMe + 1
	    Loop%>
        <div class="results">נמצאו <%=countMe%> תוצאות </div><%    
    end if
    res.close 
end if %>
<!--#include file="inc/trailer.asp"-->