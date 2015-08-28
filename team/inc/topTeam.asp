<div id="teamTools">
    אהלן <a href="<%=baseA%>profile.asp?id=<%=session("userID")%>"><%=session("name")%></a> [<a href="login.asp?exit=1">התנתק</a>], <a href="new.asp">הוסף מילה</a>
    | <a href="history.asp">היסטוריה</a> | <a href=".">ראשי</a>
    <span style="float:left; margin-left:40px;" dir="ltr"><%
		response.write serverName %>		
	</span>
</div>