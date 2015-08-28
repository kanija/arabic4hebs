<!--#include file="inc/inc.asp"--><%
If session("role") <> 15 then Response.Redirect "login.asp" %>
<!DOCTYPE html>
<html>
<head>
	<title>ניהול משתמשים</title>
    <meta name="robots" content="none">
<!--#include file="inc/header.asp"-->
</head>
<body>
<!--#include file="inc/top.asp"-->
<div class="view"><%

Sub Checkbox(role, mask)
    %><img width="16" height="16<%
    if (role and mask)<>0 then
        %>" alt="V" src="http://ronen.rothfarb.info/arabic/img/site/correct.png<%
    else
        %>" alt="X" src="http://ronen.rothfarb.info/arabic/img/site/x.png<%
    end if
    %>" /><%
End Sub

dim userId, userName, d, gen

gen=""
userId = request("id")

openDB "arabicUsers"
mySQL = "SELECT * FROM users ORDER BY name"
res.open mySQL, con %>

<div style="width:800px; margin:0 auto; text-align:center;">
	<h2>ניהול משתמשים</h2>
	<a href="profileNew.asp" style="background:#eeddcc;width:150px;border:solid 1px gray; padding:3px;">הוספת משתמש חדש</a>
</div>
<table border="1">
    <tr style="background:#edc;">
        <td style="width:80px;"></td>
        <td style="width:100px; text-align:right;">פרטי משתמש</td>
        <td style="width:300px; text-align:right;">אודות</td>
        <td style="width:100px;">כניסה אחרונה</td>
        <td style="width:20px;">צפייה</td>
        <td style="width:20px;">הוספה</td>
        <td style="width:20px;">בקרה</td>
        <td style="width:20px;">ניהול</td>
        <td style="width:60px;"></td>
    </tr><%
    do until res.EOF %>
	    <tr><% 
	        if res("gender")="2" then 
	            gen="fe"
	        else
	            gen=""
	        end if
	        if res("picture")=true then %>
	            <td><img src="http://ronen.rothfarb.info/arabic/img/profiles/<%=res("id")%>.png" title="<%=res("userName")%>" height="64" /></td><%
	        else %>
	            <td><img src="http://ronen.rothfarb.info/arabic/img/profiles/<%=gen %>male.png" title="<%=res("userName")%>" height="64" /></td><%
	        end if %>
	        <td style="vertical-align:top; text-align:right;">
	            <a href="http://ronen.rothfarb.info/arabic/profile.asp?id=<%=res("id")%>" target="profile<%=res("id")%>">
	            <%=res("name")%>
	            <div dir="ltr">
	            	<%=res("userName")%>
	            	<br />
	            	<span style="font-size:smaller;"><%=res("eMail")%></span>
	            </div></a>
	        </td>
	        <td style="vertical-align:top;width:300px; text-align:right; font-size:small;"><%=res("about")%>&nbsp;</td>
	        <td><%=res("lastLogin")%></td>
	        <td><%Checkbox res("role"), 1%></td>
	        <td><%Checkbox res("role"), 2%></td>
	        <td><%Checkbox res("role"), 4%></td>
	        <td><%Checkbox res("role"), 8%></td>
	        <td style="text-align:left;"><a href="profileEdit.asp?id=<%=res("id")%>"><div style="background:#eeddcc;width:45px;border:solid 1px gray; text-align:center;">עריכה</div></a></td>
	    </tr><%
	    res.movenext
	loop %>
</table><%
closeDB %>
</div>
</body>