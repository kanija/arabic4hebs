<!--#include file="inc/inc.asp"-->
<!DOCTYPE html>
<html>
<head>
	<title>דף בבדיקה - טופס</title>
    <meta name="robots" content="none">
<!--#include file="inc/header.asp"-->
    <style>
        h2 {font-size:1em;}
    </style>
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"-->
<!--#include file="inc/topTeam.asp"--> 

    <script type="text/javascript"><!--

	function isEmail(V) { return /[\w\.]+@[\w\.]+\.\w{2,6}/.test(V); }

	function CheckMail(F) {
		if (!isEmail(F.email.value)) {
			F.email.focus();
			alert("נא להזין אימייל תקין");
			return false;
		}
		F.resolution.value = screen.width + "×" + screen.height;
		return true;
	}

//--></script>
<table class="main" style="border-top:solid 1px #7c947e" border="0">
<tr>
    <td>
    <br />
    <br />
    <br />אתם מוזמנים להתקשר, לשלוח מייל
    <br />או למלא את הפרטים שלכם בטופס ואנו נחזור אליכם
    <br />
    <br />
	<form method="post" action="smtp_test.asp" onsubmit="return CheckMail(this)">
	    <input name="resolution" value="noscript" type="hidden" />
	    <table cellpadding="4">
		    <tr>
			    <td>שם פרטי</td>
			    <td><input type="text" name="firstname" /></td>
		    </tr>
		    <tr>
			    <td>שם משפחה</td>
			    <td><input type="text" name="lastname" /></td>
		    </tr>
		    <tr>
			    <td>טלפון</td>
			    <td><input type="text" name="phone" /></td>
		    </tr>
		    <tr>
			    <td>דוא"ל</td>
			    <td><input type="text" name="email" /></td>
		    </tr>
		    <tr>
			    <td>הערות</td>
			    <td><textarea name="body" cols="40" rows="6"></textarea></td>
		    </tr>
		    <tr>
			    <td colspan="2" style="text-align:left;"><input type="submit" value="שליחה" /></td>
		    </tr>
	    </table>
	</form> 
	<br/><br/>
    </td>
</tr>
</table>

<!--#include file="inc/trailer.asp"-->
</body>
</html>