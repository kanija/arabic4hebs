﻿</div>
<!--these br's are needed cause the trailer hides the bottom part of the page-->
<br /><br /><br />
    <table class="footer">
        <tr>
            <td>
                <div id="inFooter" style="display:none;">
					<br />
					הפרויקט 'מילון ערבית מדוברת' הוא שירות אינטרנט חינמי וחופשי לשימוש.
                    נוסד בשנת 2006 ע"י אלון ו<a href="http://ronen.rothfarb.info">רונן רוטפרב</a>, ומאז מנוהל ומתוחזק על ידי מתנדבים.
					<b>זהו לא מילון רשמי!</b> את המילים מוסיפים ובודקים משתמשי המילון בעצמם
                    <br />
				    <div style="display:inline-block;padding:10px 10px;">
					    <img src="http://mirrors.creativecommons.org/presskit/icons/sa.svg" style="width:24px;" alt="Share-alike" title="Share-alike (Licensees may distribute derivative works only under a license identical to the license that governs the original work)" />
					    <img src="http://mirrors.creativecommons.org/presskit/icons/by.svg" style="width:24px;" alt="Attribution" title="Attribution (Licensees may copy, distribute, display and perform the work and make derivative works based on it only if they give the author or licensor the credits in the manner specified by these)" />
					    <img src="http://mirrors.creativecommons.org/presskit/icons/cc.svg" style="width:24px;" alt="Creative Commons" title="Creative Commons" />
				    </div>
                    <br />
				</div>
                <div style="padding:5px 8px; text-align:left;">
                    <div style="display:inline-block; float:right;">
                        <img src="img/site/info.png" style="width:24px;" onclick="toggleTable()" alt="סוג של דיסקליימר" title="סוג של דיסקליימר" />
                    </div>
                    <img id="email" src="img/site/gmail.png" style="display:none; height:24px; opacity:1;" alt="arabic4hebs בג'ימייל דוט קום" />
                    <div style="display:inline-block;">
                        <a href="img/site/gmail.png" target="our email address"><img src="img/site/email.png" style="height:24px;" title="כיתבו לנו" alt="כיתבו לנו" onmouseover="showEmail()" onmouseout="hideEmail()" /></a>
                    </div>
                    <div style="display:inline-block;">
                        <a href="https://www.facebook.com/spoken.arabic.dictionary" target="facebook-A4H"><img src="img/site/facebook.png" style="width:24px;" alt="דף הפייסבוק של המילון" title="דף הפייסבוק של המילון" /></a>
                    </div>
                    <div style="display:inline-block;">
                        <a href="https://www.youtube.com/channel/UCHnLvw-TCwckLXmjYozv9tw" target="youtube-A4H"><img src="img/site/youtube.png" style="width:24px;" alt="ערוץ היו-טיוב של המילון" title="ערוץ היו-טיוב של המילון" /></a>
                    </div>
                </div>
            </td>
        </tr>
    </table>
	
	<script>
	function toggleTable() {
    var lTable = document.getElementById("inFooter");
    lTable.style.display = (lTable.style.display == "table") ? "none" : "table";
}	</script>

	<script>
	function toggleSearch() {
    var srch = document.getElementById("topSearch");
    srch.style.display = (srch.style.display == "inline-block") ? "none" : "inline-block";
}	</script>

	<script>
	function toggleMenu() {
    var lMenu = document.getElementById("nav");
    lMenu.style.display = (lMenu.style.display == "table") ? "none" : "table";
}	</script>

	<script>
	function showEmail() {
    var emailPng = document.getElementById("email");
    emailPng.style.display = "inline-block";
}	</script>

	<script>
	function hideEmail() {
    var emailPng = document.getElementById("email");
    emailPng.style.display = "none";
}	</script>

</body>
</html>