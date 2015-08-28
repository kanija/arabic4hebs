<!--#include virtual="/inc/inc.asp"-->
<!--#include virtual="/inc/frame.asp"-->
<%
dim iMsg, iConf, sch, SendEmailGmail

if Len(Request.Form("email")) > 0 then
	Set iMsg = CreateObject("CDO.Message")
	Set iConf = CreateObject("CDO.Configuration")

	' send one copy with Google SMTP server (with autentication)
	sch = "http://schemas.microsoft.com/cdo/configuration/"
	With iConf.Fields
		.Item(sch & "smtpauthenticate") = 1
		.Item(sch & "smtpusessl") = True
		.Item(sch & "smtpserver") = "smtp.gmail.com" 
		.Item(sch & "sendusername") = "smtp@mhcolor.com"
		.Item(sch & "sendpassword") = "samsung"
		.Item(sch & "smtpserverport") = 465
		.Item(sch & "sendusing") = 2
		.Item(sch & "connectiontimeout") = 100
		.Update
	End With

	With iMsg
		Set .Configuration = iConf
		.To = "michelle@mhcolor.com"
		.CC = "ronen@mhcolor.com"
		.From = "mhcolor.com contact <smtp@mhcolor.com>"
		.Subject = "יצירת קשר מהאתר"
		.HTMLBody = "<div dir=""rtl""><table style=""width:600px;border:solid 1px gray;"">" & _
			"<tr><td style=""width:120px;"">" & "שם השולח: " & "</td><td>" &  Request.Form("firstname")&" "& Request.Form("lastname") & _
			"</td></tr><tr><td>" & "טלפון: " & "</td><td>" & Request.Form ("phone") & _
			"</td></tr><tr><td>" & "מייל: " & "</td><td>" & Request.Form ("email") & _
			"</td></tr></table><blockquote>" & Request.Form ("body") & _
			"</blockquote></div>" & _
			"<table><tr><td>" & "Agent: " & "</td><td>" & Request.ServerVariables("HTTP_USER_AGENT")  & _
			"</td></tr><tr><td>" & "Resolution: " & "</td><td>" & Request.Form ("resolution") & _
			"</td></tr></table>"
		'.TextBody = Request.Form ("body") & vbNewLine & "Phone: " & Request.Form ("phone")
		'.Sender = 
		'.Organization = "Myname"
		.ReplyTo = Request.Form("firstname")&" "& Request.Form("lastname")&"<"&Request.Form("email")&">"
		SendEmailGmail = .Send
	End With

	set iMsg = nothing
	set iConf = nothing

end if

WriteHeader "יצירת קשר"
%>
	<table class="main" align="center" style="border-top:solid 1px #7c947e" border="0">
	<tr>
		 <td>
			 <br />
			 <br />אתם מוזמנים להתקשר אלי:
			 <br />מישל הולץ
			 <br />054-4447179
			 <br />
			 <br />
			 <h2>הודעתכם נשלחה בהצלחה</h2>
			 <br />
			 <br />
		 </td>
		<td style="text-align:left;">
			<br/><br/>
			<iframe src="http://www.facebook.com/plugins/likebox.php?href=http%3A%2F%2Fwww.facebook.com%2Fmhcolor&amp;width=350&amp;colorscheme=light&amp;show_faces=true&amp;stream=true&amp;header=true&amp;height=600" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:350px; height:600px;" allowTransparency="true"></iframe>
		</td>
	</tr>
	</table>
<%
WriteFooter
%>