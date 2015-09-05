<!--#include file="inc/inc.asp"--><%
If session("role") <> 15 then Response.Redirect "login.asp" %>
<!DOCTYPE html>
<html>
<head>
	<title>ניהול סרטונים</title>
    <meta name="robots" content="none">
<!--#include file="inc/header.asp"-->
</head>
<body>
<!--#include file="inc/top.asp"-->
<div class="view">
	<h2>ניהול סרטונים</h2><%
openDB "arabicWords"
mySQL = "SELECT * FROM wordsLinks ORDER BY wordID"
res.open mySQL, con %>

<table border="1">
    <tr>
        <td>wordID</td>
        <td>description</td>
        <td>link</td>
        <td>content</td>
        <td>delete</td>
    </tr><%
    do until res.EOF %>
	    <tr>
	        <td><%=res("wordID")%></td>
	        <td><%=res("description")%></td>
	        <td><%=res("link")%></td>
	        <td style="text-align:right;">
	        	<%=res("content")%><%
	        	dim i
	        	i=1 %>
        		<span style="float:left;"><a href=# onclick="editTo(<%=res("wordID")%>,'<%=res("link")%>')">edit</a>
        		</span>
	        </td>
	        <td><a href='videoDelete.asp?id=<%=res("wordID")%>&link=<%=res("link")%>' onclick="return confirm('DELETE link to wordID <%=res("wordID")%>?')">delete link</a></td>
	    </tr><%
	    i=i+1
	    res.movenext
	loop %>
</table>
<script>
    function editTo(wid,wlink) {
        var newVal = prompt("מה נאמר בסרטון?","");
        if (newVal != null) {
        	if (newVal != "") location.href="videoContentUpdate.asp?id="+wid+"&link="+wlink+"&content="+newVal;
        	else alert ("לא ניתן להשאיר שדה זה ריק")
        }
    }
</script> <%
closeDB %>
</div>
</body>