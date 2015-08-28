<!--#include file="inc/inc.asp"-->
<!DOCTYPE html>
<html style="height:100%;">
<head>
	<title>כניסת ניהול</title>
    <meta name="robots" content="none">
<!--#include file="inc/header.asp"-->
</head>
<body style="height:100%;">
<div class="view" style="text-align:center;"><%
dim error, url
If Len(Request("url"))>0 then url=Request("url") else url="admin.asp"

If Len(Request("username"))>0 then
	openDB "arabicUsers"
	res.Open "select id,name,role,email from users where username="""&Request("username")&""" and password="""&Request("password")&"""",con,1
	if res.eof then 
		error="טעות בשם המשתמש או הסיסמא"
		session("role")=0
	else
		if res("role")<>15 then
			error="אין לך הרשאה להכנס למערכת הניהול. אנא פנה למנהל האתר למידע נוסף."
			session("role")=0
		else
			session("userID")=res("id")
			session("userName")=Request("username")
			session("email")=res("email")
			session("role")=res("role")
			session("name")=res("name")
			Response.Redirect "default.asp"
		end if
	end if
	res.Close
	CloseDB
End if
%>
<div id="pTitle">כניסה למנהלי המילון</div>

<form method="post" id="Form1" action="login.asp" >
<div class="table divStats" style="margin-top:10px;">
	    <input type="hidden" name="url" value="<%=url%>" id="Hidden1"/>
        <table style="width:100%; padding:15px;" lang="en" dir="ltr">
		    <tr>
                <td style="width:10px;">&nbsp;</td>
                <td style="padding:5px 5px;"><input style="width:90%; max-width:250px; padding:3px 3px;" type="text" id="username" name="username" autofocus placeholder="username" required /></td>
                <td style="width:10px;">&nbsp;</td>
		    </tr>
		    <tr>
                <td style="width:10px;">&nbsp;</td>
                <td style="padding:5px 5px;"><input style="width:90%; max-width:250px; padding:3px 3px;" type="password" id="password" name="password" placeholder="password" required /></td>
                <td style="width:10px;">&nbsp;</td>
		    </tr>
            <tr>
                <td style="width:10px;">&nbsp;</td>
                <td>
                    <input type="submit" value="יאללה" id="Submit1" name="Submit1" style="padding:4px 10px; font-size:large; margin-top:5px;" />
                </td>
                <td style="width:10px;">&nbsp;</td>
            </tr>
        </table>
</div>

<br />

<%if error<>"" then %><div class="tableH" style="border:dashed 2px red;"><%=error%></div><%end if%>

</form>
</div>