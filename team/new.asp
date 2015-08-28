<!--#include file="inc/inc.asp"--><%
If (session("role") and 2) = 0 then Response.Redirect "login.asp"

dim countme
countme = 0
%>
<!DOCTYPE html>
<html>
<head>
	<title>הוספת מילה</title>
    <meta name="robots" content="none">
    <script src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js"></script>
<!--#include file="inc/header.asp"-->
    <style>
        a:link, a:visited {color: #1988cc;}
        a:hover {text-decoration: underline;}
        h2 {margin:0px 0px 15px 0px; font-size: 1.2em;}
        span {font-size:smaller;}

        .box {border: 1px solid rgba(0, 0, 0, 0.2); padding: 10px; margin-bottom: 20px; background-color: rgba(231, 237, 253, 0.25);}
        .box textarea {width:98%; border:dotted 1px;}
        .boxSub {  padding-top: 10px; margin-top: 10px; border-top: 1px solid rgba(0, 0, 0, 0.2);}
        .boxes {width:100%; margin-bottom: 20px;}
        .boxes > div {display: table-cell;min-width:200px;padding: 10px;background-color: rgba(231, 237, 253, 0.25); border: 1px solid rgba(0, 0, 0, 0.2);}
        .boxes > div:first-child {border-left: 0;}
        .line {width: 100%;}
        .line > div {display:inline-block;}
        .line > input {width: 100%; border: 0; border-bottom: 1px dotted; background: none;}
        .nikudHelp { width:100%; text-align: center;}
        .nikudHelp, .nikudHelp2 {vertical-align: middle;}
        .nikudHelp td {height: 30px; width: 30px; border: 1px dotted; background-color: rgba(204, 204, 204, 0.5);}
        .nikudHelp th {font-weight: normal; border: 1px dotted; background-color: rgba(204, 204, 204, 0.5); padding: 0 4px;}
        .nikudHelp2 td {font-size: 3em; min-width: 40px; text-align: center; padding-bottom: 10px; border: 1px dotted;}
        #page {max-width: 842px; min-width: 320px; margin: 0 auto;}
        .tags > div {display: inline-block;padding:4px 8px; border: 1px dotted; margin-bottom:5px; background: white;}
        .trans {text-align: center; width:100%;}
        .trans td {border: 1px solid gray; padding: 3px;}
        .trans td:nth-child(2) {direction: ltr;}
        .trans span {display: block; font-size: small;}
        .words {font-size:xx-large;border: solid 1px #ddd; padding: 0px 4px 10px 4px; background-color: white;}
        
        @media (max-width:840px) {
            textarea {width:95%; min-width: 300px;}
            .box {border-width: 1px 0 0 0; margin: 0 auto; padding:5px; width: 95%;}
            .boxes {width:100%; min-width: 320px; margin: 0;}
            .boxes > div {display: block; width: 95%; padding: 5px; border-width: 1px 0 0 0; margin: 0 auto;}
            #nHelp {display: none;}
            .words {font-size:large;}
            .words input {line-height: 2;}
        }
    </style>
    <script>
        $(function() {
          $('#searchString2').focus(function() {
            left = $('#searchStringX').val().length;
            $('#searchString2').attr('maxlength', 250 - left)
          });
        });
    </script>
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"-->
<!--#include file="inc/topTeam.asp"-->

<h1 style="text-align:center;">הוספת מילה חדשה</h1>

<div id="page">

    <div class="boxes">
        <div style="min-width: 300px;">
            <h2>רגע לפני שמתחילים...</h2>
            <ul style="line-height: 20px; margin-bottom:10px;">
                <li style="margin-bottom:10px;">מוודאים שהמילה לא מופיעה כבר במילון
                    <br/><span>ניתן להעזר ב<a href="http://ronen.rothfarb.info/arabic/list.asp" target="allWords">רשימת כל המילים במילון</a></span></li>
                <li>קוראים את <a href="guide.asp" target="guideLines">הקווים המנחים להוספת מילים</a></li>
            </ul>
        </div>
        <div style="color:rgb(230, 89, 89);">
            מטעמי אבטחה, אחרי <b><%=Session.Timeout%></b> דקות מרגע שדף זה נטען, לא ניתן יהיה להזין את המידע מהדף.
            <br/>על מנת שעבודתכם לא תהיה לחינם, אנא הקפידו לסיים וללחוץ על כפתור 'הוסף מילה' במסגרת זמן זה.
        </div>
    </div>

    <div id="nHelp" class="box">
        <div>
            <div>הוספת ניקוד</div>
            <table dir="ltr">
            <tr class="nikudHelp">
                <th style="background: rgba(247, 157, 157, 0.40);"> Caps Lock </th>
                <th> Shift </th>
                <th style="background:none; border-bottom: 0; border-top:0;"> + </th>
                <td>~</td>
                <td>1</td>
                <td>2</td>
                <td>3</td>
                <td>4</td>
                <td>5</td>
                <td>6</td>
                <td>7</td>
                <td>8</td>
                <td>9</td>
                <td>0</td>
                <td>-</td>
                <td>=</td>
                <td>\</td>
            </tr>
            <tr class="nikudHelp2">
                <th>&nbsp;</th>
                <th>&nbsp;</th>
                <th>&nbsp;</th>
                <td>כְ</td>
                <td>כֱ</td>
                <td>כֲ</td>
                <td>כֳ</td>
                <td>כִ</td>
                <td>כֵ</td>
                <td>כֶ</td>
                <td>כַ</td>
                <td>כָ</td>
                <td>שׂ</td>
                <td>שׁ</td>
                <td>וֹ</td>
                <td>וּ</td>
                <td>כֻ</td>
            </tr>
            </table>
        </div>
    </div>

    <form action="new.insert.asp" method="post" id="new" name="new" onsubmit="return CheckFields(this);">

    <div class="boxes">
        <div class="box" style="background-color:rgba(212, 234, 255, 0.5);">
            <div class="words">
                <div class="line" style="color:#1988cc;">
                    <input maxlength="50" id="hebrew" placeholder="עברית" type="text" class="nikud" name="hebrewTranslation" onkeypress="nikudTyper(this,event)" onchange="makeSearchStr()" onkeyup="makeSearchStr()" onblur="makeSearchStr()" required autofocus="true">
                </div>
                <div class="line" style="color:#2ead31;">
                    <input maxlength="50" id="arabic" placeholder="ערבית מדוברת - תעתיק עברי" type="text" class="nikud" style="text-align:center;" name="arabicWord" onkeypress="nikudTyper(this,event)" onchange="makeSearchStr()" onkeyup="makeSearchStr()" onblur="makeSearchStr()" required>
                </div>
                <div class="line" style="color:#d17111;">
                    <input maxlength="50" id="english" placeholder="הגייה באנגלית" type="text" dir="ltr" name="pronunciation" required />
                </div>
            </div>
            <div class="boxSub">
                <div>מילות חיפוש</div>
                <div>
                    <span>בנוסף למילה בערבית ובעברית, ניתן להוסיף צורות נוספות שיביאו למילה בעת חיפושן. למשל מילים נרדפות, או איות שגוי של המילה.</span>
                    <input type="hidden" name="searchString1" />
                </div>
                <div>
                    <div style="display: inline-block;min-width: 300px;"><textarea id="searchString2" name="searchString2" maxlength="255" placeholder="עד 255 תווים יחד עם המילה בערבית ובעברית"></textarea></div>
                    <div style="display:inline-block;min-width: 50px;"><textarea id="searchStringX" name="searchStringX" disabled="disabled"></textarea></div>
                </div>
            </div>
            <div class="boxSub">
                <div>
                    הערות
                    <br/><span>הערות ומידע נוסף שאתם רוצים לתת לצופה</span>
                </div>
                <div style="text-align: center;"><textarea maxlength="255" rows=4 cols=40 id="Textarea1" class="nikud" name="info" placeholder="למה משמשת המילה, איך עונים וכו'"></textarea></div>
            </div>
            <div class="boxSub">
                <div>
                    דוגמאות
                    <br/><span>&nbsp;</span>
                </div>
                <div style="text-align: center;"><textarea maxlength="100" rows=4 cols=40 id="Textarea1" class="nikud" name="example"></textarea></div>
            </div>
            <div class="boxSub">
                <div>
                    תגיות / נושאים
                    <br/><span>ניתן לסמן יותר מאחד, אך חשוב לשמור על רלוונטיות</span>
                </div>
                <div class="tags"><%
                    dim LID, LName
                    openDB "arabicWords"
                    mySQL = "SELECT * FROM labels ORDER BY labelName"
	                res.open mySQL, con
	                    Do until res.EOF
                            If LID = res("id") then
                                LName = res("labelName") 
                            End If
		                    %><div><input name="label<%=res("id")%>" id="label<%=res("id")%>" type="checkbox"/> <%=res("labelName")%></div>
		                    <%
		                    res.moveNext
                            countme = countme + 1
                            if countme mod 2 = 0 then
                            %><%
                            End if
	                    Loop
	                    res.close
                    closeDB %>
                </div>
            </div>
            <div class="boxSub">
                <div>חלק דיבר</div>
                <div>
                    <select name="partOfSpeach">
                        <option value="1" id="partOfSpeach1">שם עצם</option>
	                    <option value="2" id="partOfSpeach2">שם תואר</option>
	                    <option value="3" id="partOfSpeach3">פועל</option>
	                    <option value="4" id="partOfSpeach4">תואר הפועל</option>
	                    <option value="7" id="partOfSpeach7">מילת קריאה</option>
	                    <option value="5" id="partOfSpeach5">מילית יחס</option>
	                    <option value="6" id="partOfSpeach6">מילית חיבור</option>
	                    <option value="8" id="partOfSpeach8">תחילית</option>
	                    <option value="9" id="partOfSpeach9">סופית</option>
	                    <option value="0" id="partOfSpeach0" selected>לא ידוע / אחר</option>
                    </select>
                </div>

                <br/>

                <div>מין (בערבית)</div>
                <div>
                    <select name="gender">
	                    <option value="1" id="gender1">זכר</option>
	                    <option value="2" id="gender2">נקבה</option>
	                    <option value="0" id="gender0">נטרלי</option>
	                    <option value="3" id="gender3" selected>לא ידוע / לא רלוונטי</option>
                    </select>
                </div>

                <br/>

                <div>מספר (בערבית)</div>
                <div>
                    <select name="number">
                        <option value="1" id="number1">יחיד</option>
                        <option value="2" id="number2">זוגי</option>
	                    <option value="3" id="number3">רבים</option>
                        <option value="0" id="number0">בלתי ספיר</option>
                        <option value="4" id="number4" selected>לא ידוע / לא רלוונטי</option>
                    </select>
                </div>
            </div>
            <div class="boxSub">
                <div>קישור לתמונה</div>
                <span>שימו לב!
                <br/>הוסיפו קישור אך ורק לתמונות Common Creative
                <br/>קשרו לרזולוציה בינונית (מעל 250-250, מתחת ל-800-800)</span>
                <div><input type="text" dir="ltr" name="imgLink" style="width:95%;" placeholder="link" maxlength="254" /></div>
                <span>חובה לשים קרדיט בהתאם לדרישות בעל הזכויות</span>
                <div><input type="text" dir="ltr" name="imgCredit" style="width:95%;" placeholder="credit" maxlength="254" /></div>
            </div>
            <div class="boxSub">
                <div>קישור לסרטון יו-טיוב</div>
                <span>הדביקו את קוד הסרטון בלבד (ללא כתובת האתר). שימו לב כי לא כל סרטון ביו-טיוב ניתן להטמיע באתרים חיצונים, לכן ודאו שמופיע מתחת לסרטון האופציה להטמעה - Embed</span>
                <div style="font-size: small; padding: 14px;text-align: center;" dir="ltr">www.youtube.com/watch?v=<input type="text" dir="ltr" name="youtube" maxlength="255" /></div>
            </div>
        </div>
        <div style="text-align: center;">
            <table class="trans">
                <tr><td>תעתיק עברי<span>(הערות)</span></td><td>תעתיק לועזי</td></tr>
                <tr><td>א<span>(א' עיצורית)</span></td><td>a e i o u</td></tr>
                <tr><td>א<span>(א' לציון תנועת ה-א)</span></td><td>a</td></tr>
                <tr><td>ב<span>(ב' דגושה)</span></td><td>b</td></tr>
                <tr><td>ג'</td> <td>j</td></tr>
                <tr><td>ד</td><td>d</td></tr>
                <tr><td>ד'<span>(ד' נחצית – כשאמצע הלשון נוגע בחיך)</span></td><td>d'</td></tr>
                <tr><td>ה<span>(ה בסוף מילה=h)</span></td><td>h</td></tr>
                <tr><td>ו<span>(w עיצורית)</span></td><td>w</td></tr>
                <tr><td>ו<span>(w לציון תנועת ה-ו)</span></td><td>u</td></tr>
                <tr><td>ז</td><td>z</td></tr>
                <tr><td>ז^<span>(ז' נחצית)</span></td><td>z^</td></tr>
                <tr><td>ח<span>(ח' "נכונה" בהיגוי מזרחי)</span></td><td>h^</td></tr>
                <tr><td>ח'<span>(כ' רפה בעברית)</span></td><td>ch</td></tr>
                <tr><td>ט<span>(ט' עברית "נכונה", נחצית)</span></td><td>t'</td></tr>
                <tr><td>י<span>(עיצורית)</span></td><td>y</td></tr>
                <tr><td>י<span>(לציון תנועת ה-י)</span></td><td>i</td></tr>
                <tr><td>כ<span>(כ' דגושה)</span></td><td>k</td></tr>
                <tr><td>ל</td><td>l</td></tr>
                <tr><td>מ</td><td>m</td></tr>
                <tr><td>נ</td><td>n</td></tr>
                <tr><td>ס</td><td>s</td></tr>
                <tr><td>ע</td><td>a e i o u</td></tr>
                <tr><td>ע'<span>(ר' גרונית)</span></td><td>r'</td></tr>
                <tr><td>פ<span>(פ' רפה)</span></td><td>f</td></tr>
                <tr><td>צ<span>(לא נהגית כמו צ', אלא כס' נחצית)</span></td><td>s'</td></tr>
                <tr><td>ק<span>(בהיגוי העירוני מבטאים ק' כמו א' עיצורית)</span></td><td>q / a e i o u</td></tr>
                <tr><td>ר<span>(ר' עברית "נכונה", מגולגלת בקצה הקדמי של הלשון)</span></td><td>r</td></tr>
                <tr><td>ש<span>(ש' עברית – תמיד ימנית)</span></td><td>sh</td></tr>
                <tr><td>ת</td><td>t</td></tr>
                <tr><td>ת'<span>(th)</span></td><td>th</td></tr>
            </table>
        </div>


    </div>


    <div class="boxes">

    </div>
	
    <div style="width:90%; margin:20px auto; text-align: center;">
        <input style="font-size: large;padding: 10px;" type="submit" value="הוסף מילה" name="Submit1" id="Submit1" />
    </div>

    <div style="width:90%; margin:5px auto; text-align: center;">
    <h2>מכאן ומטה - לא פעיל עדיין</h2>
    </div>

    <div class="box">
		    <div>ניב</div>
		    <div><span>בחר את הניבים הרלוונטים להגייה הזו</span></div>
		    <div class="tags">
                <div><input disabled name="#" id="#" type="checkbox"/> משולש</div>
                <div><input disabled name="#" id="#" type="checkbox"/> ירושלמי</div>
                <div><input disabled name="#" id="#" type="checkbox"/> לבנטינית / פלסטינית כפרית</div>
                <div><input disabled name="#" id="#" type="checkbox"/> לבנטינית / פלסטינית עירונית</div>
                <div><input disabled name="#" id="#" type="checkbox"/> לבנטינית / פלסטינית בדואית</div>
                <div><input disabled name="#" id="#" type="checkbox"/> לבנטינית / לבנונית</div>
                <div><input disabled name="#" id="#" type="checkbox"/> לבנטינית / סורית</div>
            </div>
            <div><span>לתת דוגמאות לאזורים / ישובים בארץ בהם נעשה שימוש בכל ניב וניב [רונן, 5/2015]</span></div>
    </div>

    <div class="box">
		    <div>צורת המקור</div>
		    <div><input disabled type="radio" value="0" name="originWord" id="originWord0" /><label for="originWord0">זו צורת המקור</label></div>
		    <!-- להוסיף גם אופציה למי שלא יודע מה היא צורת המקור -->
		    <div><input disabled type="radio" value="1" name="originWord" id="originWord1" /><label for="originWord1">צורת המקור היא</label> <input type="text" name="originWord" xonkeyup="updateSelect(value)" id="originWord" /></div>
    </div>
    </form>
</div>


<!--#include file="inc/trailer.asp"-->
<script type="text/javascript" src="js/scripts.js"></script>
</body>
</html>