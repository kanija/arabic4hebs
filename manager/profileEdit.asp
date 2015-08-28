<!--#include file="inc/inc.asp"--><%
If session("role") <> 15 then Response.Redirect "login.asp" %>
<!DOCTYPE html>
<html>
<head>
<!--#include file="inc/header.asp"-->
</head>
<body>
<%
Sub Checkbox(role, mask)
    %><input name="role" id="role<%=mask%>" type="checkbox" value="<%=mask%><%
    if (role and mask)<>0 then
        %>" checked="checked<%
    end if
    %>" /><%
End Sub

dim userId, userName, d

userId = request("id")

openDB "arabicUsers"
mySQL = "SELECT * FROM users WHERE id="&userId
res.open mySQL, con

%>
<div style="width:600px;margin:0px auto; text-align:left;">
<h2><%=Session("Message") %></h2>
<form action="profileUpdate.asp" method="post" >
<input type="hidden" name="id" value="<%=userId%>" />
<br />
    <table class="tableA" border="0" align="center" cellpadding="0" cellspacing="0">
	    <tr><td>שם מלא:             </td><td><input name="name" value="<%=res("name")%>" />               </td></tr>
	    <tr><td>דואר אלקטרוני:      </td><td><input name="eMail" value="<%=res("eMail")%>" />              </td></tr>
	    <tr><td style="vertical-align:top;">אודות:      </td><td><textarea name="about" cols="40" rows="4"><%=res("about")%></textarea></td></tr>
	    <tr><td colspan="2">&nbsp;  </td></tr>
	    <tr><td>שם משתמש:           </td><td><input name="userName" value="<%=res("userName")%>" />           </td></tr>
	    <tr><td>סִסמה:               </td><td><input name="password" />           </td></tr>
	    <tr><td colspan="2">&nbsp;  </td></tr>
	    <tr><td style="vertical-align:top;">תפקיד:              </td><td>   
	             <%checkbox res("role"),2%><label for="role2">הוספת מילים</label>
	        <br /><%checkbox res("role"),4%><label for="role4">בקרת מילים</label>
	        <br /><%checkbox res("role"),8%><label for="role8">ניהול אתר</label>
            </td></tr>
        <tr><td>מגדר:           </td><td>
            <input name="gender" id="gender1" value="1" type="radio" <%if res("gender")="1" then %>checked="checked"<%end if %> /><label for="gender1">זכר</label>
            <input name="gender" id="gender2" value="2" type="radio" <%if res("gender")="2" then %>checked="checked"<%end if %> /><label for="gender2">נקבה</label>
            </td></tr>
        <tr><td>תמונה:           </td><td>
            <input name="picture" id="picture1" value="TRUE" type="radio" <%if res("picture") then %>checked="checked"<%end if %> /><label for="picture1">יש</label>
            <input name="picture" id="picture2" value="FALSE" type="radio" <%if not res("picture") then %>checked="checked"<%end if %> /><label for="picture2">אין</label>
            </td></tr>
    </table>
    <br /><input type="submit" value="עדכן" />
    <br /><br /><a href="userControl.asp">חזרה לדף שליטה</a>
</form><%

Session("Message") = ""

closeDB %>
</div>
</body>