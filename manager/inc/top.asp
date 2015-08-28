<div class="top">
    <span><a href="default.asp">דף ראשי</a></span>
    <span><a href="userControl.asp">ניהול משתמשים</a></span>
    <span><a href="loginHistory.asp">מעקב כניסות</a></span>
    <span style="float:left; margin-left:40px;" dir="ltr"><%
		dim serverName
		serverName = Request.ServerVariables("SERVER_NAME")
		response.write serverName %>
	</span>
</div>