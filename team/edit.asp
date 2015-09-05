<!--#include file="inc/inc.asp"--><%
If (session("role") and 2) = 0 then Response.Redirect "login.asp"

dim countme, wordID
countme = 0
wordID = request("ID")
%>
<!DOCTYPE html>
<html>
<head>
	<title>עריכת מילה</title>
    <meta name="robots" content="none">
    <script src="//ajax.aspnetcdn.com/ajax/jQuery/jquery-1.8.3.min.js"></script>
<!--#include file="inc/header.asp"-->
    <style>
        .disabled {color: #aaa; background-color: #ddd;}
    </style>
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"-->
<!--#include file="inc/topTeam.asp"-->

<h1 style="text-align:center;">עריכת מילה</h1>

<div id="page">



    <form action="edit.update.asp?id=<%=wordID%>" method="post" id="edit" name="edit" onsubmit="return CheckFields(this);"><%
    openDB "arabicWords"
    mySQL = "SELECT * FROM words WHERE id="&wordID
	res.open mySQL, con
	    if res.EOF then
            session("msg")="Error. ID not in Database."
            response.redirect "default.asp"
        else %>
            <div class="box">
                <div>
                    <h2>הסיבה לעריכה</h2>
                    <textarea autofocus="required" required maxlength="255" rows=4 cols=40 id="Textarea1" class="nikud" name="explain" placeholder="ציינו כאן את הסיבה לעריכה"></textarea>
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
            <div class="boxes">
                <div class="box" style="background-color:rgba(212, 234, 255, 0.5);">
                    <div class="words">
                        <div class="line" style="color:#1988cc;">
                            <input maxlength="50" value="<%=res("hebrewTranslation")%>" id="hebrew" placeholder="עברית" type="text" class="nikud" name="hebrewTranslation" onkeypress="nikudTyper(this,event)" onchange="makeSearchStr()" onkeyup="makeSearchStr()" onblur="makeSearchStr()" required>
                        </div>
                        <div class="line" style="color:#2ead31;">
                            <input maxlength="50" value="<%=res("arabicWord")%>" id="arabic" placeholder="ערבית מדוברת - תעתיק עברי" type="text" class="nikud" style="text-align:center;" name="arabicWord" onkeypress="nikudTyper(this,event)" onchange="makeSearchStr()" onkeyup="makeSearchStr()" onblur="makeSearchStr()" required>
                        </div>
                        <div class="line" style="color:#d17111;">
                            <input maxlength="50" value="<%=res("pronunciation")%>" id="english" placeholder="הגייה באנגלית" type="text" dir="ltr" name="pronunciation" required />
                        </div>
                    </div>
                    <div class="boxSub">
                        <div>מילות חיפוש</div>
                        <div>
                            <span>בנוסף למילה בערבית ובעברית, ניתן להוסיף צורות נוספות שיביאו למילה בעת חיפושן. למשל מילים נרדפות, או איות שגוי של המילה.</span>
                        </div>
                        <div>
                            <div style="display: inline-block;min-width:100%;"><textarea id="searchString" name="searchString" maxlength="255" placeholder="עד 255 תווים יחד עם המילה בערבית ובעברית"><%=res("searchString")%></textarea></div>
                        </div>
                    </div>
                    <div class="boxSub">
                        <div>
                            הערות
                            <br/><span>הערות ומידע נוסף שאתם רוצים לתת לצופה</span>
                        </div>
                        <div style="text-align: center;"><textarea maxlength="255" rows=4 cols=40 id="Textarea1" class="nikud" name="info" placeholder="למה משמשת המילה, איך עונים וכו'"><%=res("info")%></textarea></div>
                    </div>
                    <div class="boxSub">
                        <div>
                            דוגמאות
                            <br/><span>&nbsp;</span>
                        </div>
                        <div style="text-align: center;"><textarea maxlength="100" rows=4 cols=40 id="Textarea1" class="nikud" name="example"><%=res("example")%></textarea></div>
                    </div>
                    <div class="boxSub">
                        <div>
                            תגיות / נושאים
                            <br/><span>ניתן לסמן יותר מאחד, אך חשוב לשמור על רלוונטיות</span>
                        </div>
                        <div class="tags"><%
                            dim inUse
                            mySQL = "SELECT * FROM labels ORDER BY labelName"
	                        res2.open mySQL, con
	                            Do until res2.EOF
                                    mySQL = "SELECT * FROM wordsLabels WHERE wordID="&wordID
                                    res3.open mySQL, con
                                        inUse = ""
                                        while not res3.EOF
                                            if res2("id") = res3("labelID") then inUse="checked"
                                            res3.moveNext
                                        wend
                                    res3.close %>
		                            <div>
                                        <input <%=inUse%> name="label<%=res2("id")%>" id="label<%=res2("id")%>" type="checkbox"/> <%=res2("labelName")%>
                                    </div><%
		                            res2.moveNext
	                            Loop
	                            res2.close
                            %>
                        </div>
                    </div>
                    <div class="boxSub">
                        <div>חלק דיבר</div>
                        <div>
                            <select name="partOfSpeach">
	                            <option value="0" id="partOfSpeach0" <%if res("partOfSpeach")=0 then%>selected<%end if%>>לא ידוע / אחר</option>
                                <option value="1" id="partOfSpeach1" <%if res("partOfSpeach")=1 then%>selected<%end if%>>שם עצם</option>
	                            <option value="2" id="partOfSpeach2" <%if res("partOfSpeach")=2 then%>selected<%end if%>>שם תואר</option>
	                            <option value="3" id="partOfSpeach3" <%if res("partOfSpeach")=3 then%>selected<%end if%>>פועל</option>
	                            <option value="4" id="partOfSpeach4" <%if res("partOfSpeach")=4 then%>selected<%end if%>>תואר הפועל</option>
	                            <option value="7" id="partOfSpeach7" <%if res("partOfSpeach")=7 then%>selected<%end if%>>מילת קריאה</option>
	                            <option value="5" id="partOfSpeach5" <%if res("partOfSpeach")=5 then%>selected<%end if%>>מילית יחס</option>
	                            <option value="6" id="partOfSpeach6" <%if res("partOfSpeach")=6 then%>selected<%end if%>>מילית חיבור</option>
	                            <option value="8" id="partOfSpeach8" <%if res("partOfSpeach")=8 then%>selected<%end if%>>תחילית</option>
	                            <option value="9" id="partOfSpeach9" <%if res("partOfSpeach")=9 then%>selected<%end if%>>סופית</option>
                            </select>
                        </div>

                        <br/>

                        <div>מין (בערבית)</div>
                        <div>
                            <select name="gender">
	                            <option value="3" id="gender3" <%if res("gender")=3 then%>selected<%end if%>>לא ידוע / לא רלוונטי</option>
	                            <option value="1" id="gender1" <%if res("gender")=1 then%>selected<%end if%>>זכר</option>
	                            <option value="2" id="gender2" <%if res("gender")=2 then%>selected<%end if%>>נקבה</option>
	                            <option value="0" id="gender0" <%if res("gender")=0 then%>selected<%end if%>>נטרלי</option>
                            </select>
                        </div>

                        <br/>

                        <div>מספר (בערבית)</div>
                        <div>
                            <select name="number">
                                <option value="4" id="number4" <%if res("number")=4 then%>selected<%end if%>>לא ידוע / לא רלוונטי</option>
                                <option value="1" id="number1" <%if res("number")=1 then%>selected<%end if%>>יחיד</option>
                                <option value="2" id="number2" <%if res("number")=2 then%>selected<%end if%>>זוגי</option>
	                            <option value="3" id="number3" <%if res("number")=3 then%>selected<%end if%>>רבים</option>
                                <option value="0" id="number0" <%if res("number")=0 then%>selected<%end if%>>בלתי ספיר</option>
                            </select>
                        </div>
                    </div>
                    <div class="boxSub">
                        <div>קישור לתמונה</div>
                        <span>שימו לב!
                        <br/>הוסיפו קישור אך ורק לתמונות Common Creative
                        <br/>קשרו לרזולוציה בינונית (מעל 250-250, מתחת ל-800-800)</span>
                        <div><input type="text" dir="ltr" value="<%=res("imgLink")%>" name="imgLink" style="width:95%;" placeholder="link" maxlength="254" /></div>
                        <span>חובה לשים קרדיט בהתאם לדרישות בעל הזכויות</span>
                        <div><input type="text" dir="ltr" value="<%=res("imgCredit")%>" name="imgCredit" style="width:95%;" placeholder="credit" maxlength="254" /></div>
                    </div><%
                    if session("userID")=1 then 
                        mySQL = "SELECT * FROM wordsLinks WHERE wordID="&wordID
                        res2.open mySQL
                        if res2.EOF then %>
                            <div class="boxSub">
                                <div>קישור לסרטון יו-טיוב</div>
                                <span>הדביקו את קוד הסרטון בלבד (ללא כתובת האתר). שימו לב כי לא כל סרטון ביו-טיוב ניתן להטמיע באתרים חיצונים, לכן ודאו שמופיע מתחת לסרטון האופציה להטמעה - Embed</span>
                                <div style="font-size: small; padding: 14px;text-align: center;" dir="ltr">www.youtube.com/watch?v=<input type="text" dir="ltr" name="youtube" maxlength="255" /></div>
                            </div><%
                        else %>
                            <div class="boxSub">
                                [SHOW VIDEOS]
                            </div> <%
                        end if
                        res2.close
                    end if %>
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


            <div>
                <div>סטטוס
                    עדכנו את סטטוס המילה במידת הצורך
                    <br/>(מכיוון שאתה ברמת מפקח, עצם העריכה שלך משנה את סטטוס המילה לתקין.)
                </div>
                <div>
                    <select name="status">
                        <option value="0" id="status0" <%if res("status")=0 then%>selected<%end if%>>טרם נבדק</option>
                        <option value="1" id="status1" <%if res("status")=1 then%>selected<%end if%>>תקין</option>
                        <option value="-1" id="status-1" <%if res("status")=-1 then%>selected<%end if%>>חשד לטעות</option>
                    </select>
                </div>
                <div>הצגה / הסתרה
                </div>
                <div>
                    <select name="show">
                        <option value="on" id="showOn" <%if res("show")=1 then%>selected<%end if%>>הצגה</option>
                        <option value="off" id="showOff" <%if res("show")=0 then%>selected<%end if%>>הסתרה</option>
                    </select>
                </div>
            </div>
	
            <div style="width:90%; margin:20px auto; text-align: center;">
                <input style="font-size: large;padding: 10px;" type="submit" value="עדכן מילה" name="Submit1" id="Submit1" />
            </div>

            <div style="width:90%; margin:5px auto; text-align: center;">
            <h2>מכאן ומטה - לא פעיל עדיין</h2>
            </div>

            <div class="box disabled">
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

            <div class="box disabled">
		            <div>צורת המקור</div>
		            <div><input disabled type="radio" value="0" name="originWord" id="originWord0" /><label for="originWord0">זו צורת המקור</label></div>
		            <!-- להוסיף גם אופציה למי שלא יודע מה היא צורת המקור -->
		            <div><input disabled type="radio" value="1" name="originWord" id="originWord1" /><label for="originWord1">צורת המקור היא</label> <input type="text" name="originWord" xonkeyup="updateSelect(value)" id="originWord" /></div>
            </div><%
        end if
	res.close
    closeDB %>
    </form>
</div>

<!--#include file="inc/trailer.asp"-->
<script type="text/javascript" src="js/scripts.js"></script>
</body>
</html>