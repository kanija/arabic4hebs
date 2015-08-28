<!--#include file="inc/inc.asp"-->
<!DOCTYPE html>
<html style="height:100%;">
<head>
	<title>כניסת מתנדבים</title>
    <meta name="robots" content="none">
<!--#include file="inc/header.asp"-->
    <style>
        .teamLogo {text-align: center;  margin-bottom: 25px;}
        .teamLogo > div {display: inline-block;}
        
        @media (max-width:330px) {
            
            .teamLogo img {width: 50px;}
        }
    </style>
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"--><%
dim error,backTo,ref,a,x,cTime
ref = Request.ServerVariables("HTTP_REFERER") 'PREVIOUS PAGE : word.asp / login.asp'
'Response.write "<br/>ref = "&ref
'response.write "<br/>Request(ref) = "&Request("ref")
if Request("ref")<>"" then ref=Request("ref")
'Response.write "<br/>ref="&ref

'a=Split(ref,"/") 'TRIM DOMAIN'
'for each x in a
'    ref=x
'next

if ref="" then ref="default.asp"
'Response.write "<br/>ref="&ref
'Response.write "<br/>backTo="&backTo

if Request("ref")="login.asp" then backTo="default.asp" else backTo=ref
'Response.write "<br/>backTo="&backTo
if backTo="" then backTo="default.asp"
'Response.write "<br/>backTo="&backTo

If Len(Request("username"))>0 then
	openDB "arabicUsers"
	res.Open "select id,name,role,email from users where username="""&Request("username")&""" and password="""&Request("password")&"""",con,1
	if res.eof then 
		error="טעות בשם המשתמש או הסיסמא"
        session("role")=0
	else
		session("userID")=res("id")
		session("userName")=Request("username")
		session("email")=res("email")
		session("role")=res("role")
		session("name")=res("name")
        cTime = DateAdd("h",10,now()) 'ADDING 10 Hours to sync with Israel's Timezone'

        'INSERT loginLast TO users'
        mySQL = "UPDATE Users SET lastLogin='"&cTime&"' WHERE id="&res("id")
        cmd.CommandType=1
        cmd.CommandText=mySQL
        response.write "<div dir='ltr'>"&mySQL&"</div>"
        'response.end
        Set cmd.ActiveConnection=con
        cmd.execute ,,128

        'INSERT userID & now() TO loginLog'
        mySQL = "INSERT INTO loginLog (userID,loginTime) VALUES ("&res("id")&",'"&cTime&"')"
        cmd.CommandType=1
        cmd.CommandText=mySQL
        response.write "<div dir='ltr'>"&mySQL&"</div>"
        'response.end
        Set cmd.ActiveConnection=con
        cmd.execute ,,128

		Response.Redirect backTo
	end if
	res.Close
	CloseDB
End if %>
<div class="table teamLogo" dir="ltr">
    <div><img src="img/teamLogo-let1-60px.png" alt="t" /></div>
    <div><img src="img/teamLogo-let2-60px.png" alt="E" /></div>
    <div><img src="img/teamLogo-let3-60px.png" alt="A" /></div>
    <div><img src="img/teamLogo-let4-60px.png" alt="M" /></div>
    <div><img src="<%=baseA%>img/site/logo-60px.png" alt="ע" /></div>
</div>
<div id="pTitle">כניסה למתנדבי המילון</div>
<form method="post" id="Form1" action="login.asp" >
<div class="table divStats">
       <input type="hidden" name="ref" value="<%=ref%>" id="ref"/>
        <table style="width:100%;" lang="en" dir="ltr">
		    <tr>
                <td style="width:10px;">&nbsp;</td>
                <td style="padding:5px 5px;"><input style="width:90%; max-width:250px; padding:3px 3px;" type="text" id="username" name="username" placeholder="username" autofocus required /></td>
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

<div class="table divStats" style="max-width:290px;">
	רוצים גם להוסיף ערכים למילון?
	<br /><a href="<%=baseA%>team.asp"><u>לחצו כאן</u></a>
</div>
</form>
<br />
<!--#include file="inc/trailer.asp"-->
</body>
</html>