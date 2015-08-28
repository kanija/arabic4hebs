<!--#include file="inc/inc.asp"--><%
If (session("role") and 2) = 0 then Response.Redirect "login.asp"

dim countme
countme = 0
%>
<!DOCTYPE html>
<html>
<head>
	<title>מדריך למוסיף מילים</title>
    <meta name="robots" content="none">
<!--#include file="inc/header.asp"-->
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"-->
<!--#include file="inc/topTeam.asp"-->
<table align="center" style="width:600px">
    <tr>
        <td style="text-align:center;">
            <h3>קווים מנחים לתרגום</h3>
            <br />
            <li>השתדלו לשים מקף בין הברות</li>
            <li>השתדלו לתרגם לניב העירוני</li>
        </td>
    </tr>
</table>
<br />
<table align="center" border="1" cellpadding="5" style="text-align:center;">
    <tr style="background:#d4eaff">
        <td><b>תעתיק עברי</b><br/>(הערות)</td>
        <td><b>תעתיק לועזי</b></td>
        <td><b>דוגמא</b>
        <br />עברית / ערבית / אנגלית</td>
    </tr><tr>

        <td>א <br />(א' עיצורית)</td>
        <td>A E I O U</td>
        <td>אב / אב / <b>A</b>b
        <br />מה / אש / <b>E</b>sh</td>

    </tr><tr>
        <td>א <br />(א' לציון תנועת ה-א)</td>
        <td>a</td>
        <td>חבל / ח'ס<b>א</b>רה / Chsa<b>a</b>rah</td>

    </tr><tr>

        <td>ב <br />(ב' דגושה)</td>
        <td>B</td>
        <td>דלת / באב / <b>B</b>a<b>b</b></td>

    </tr><tr>

        <td>ג'</td>
        <td>J</td>
        <td>אגוזים / ג'וז / <b>J</b>oz</td>

    </tr><tr>

        <td>ד</td>
        <td>D</td>
        <td>אבקה / בודרה / Bu<b>d</b>rah</td>

    </tr><tr>

        <td>ד' <br />(ד' נחצית – כשאמצע הלשון נוגע בחיך)</td>
        <td style="direction:ltr;">D'</td>
        <td>אבד / ד'אע / <b>D'</b>aa</td>

    </tr><tr>

        <td>ה
        <br/>ה בסוף מילה=h</td>
        <td>H</td>
        <td>אבטלה / בטלה / Bat'ale<b>h</b></td>

    </tr><tr>

        <td>ו <br />(w עיצורית)</td>
        <td>W</td>
        <td>ורד / ורדה / <b>W</b>ardeh</td>

    </tr><tr>

        <td>ו <br />(w לציון תנועת ה-ו)</td>
        <td>u</td>
        <td>אגורות / קרוש / Qr<b>u</b>sh</td>

    </tr><tr>

        <td>ז</td>
        <td>Z</td>
        <td>ביקר / זאר / <b>Z</b>ar</td>

    </tr><tr>

        <td>ז^ <br />(ז' נחצית)</td>
        <td style="direction:ltr;">Z^</td>
        <td>צהריים / <b>ז^</b>והר / <b>Z^</b>uer</td>

    </tr><tr>

        <td>ח <br />(ח' "נכונה" בהיגוי מזרחי)</td>
        <td style="direction:ltr;">H^</td>
        <td>אגם / ב<b>ח</b>רה / Ba<b>h^</b>rah</td>

    </tr><tr>

        <td>ח' <br />(כ' רפה בעברית)</td>
        <td>Ch</td>
        <td>חבל / ח'סארה / <b>Ch</b>saarah</td>

    </tr><tr>

        <td>ט <br />(ט' עברית "נכונה", נחצית)</td>
        <td style="direction:ltr;">T'</td>
        <td>אבטלה / בטאלה / Ba<b>t'</b>aleh</td>

    </tr><tr>

        <td>י <br />(עיצורית)</td>
        <td>Y</td>
        <td>ממש (לגמרי) / יםם / <b>Y</b>amm</td>

    </tr><tr>

        <td>י <br />(לציון תנועת ה-י)</td>
        <td>i</td>
        <td>אני אוהב אותך / אנא בחבבכ / Ana bah<b>i</b>bbak</td>

    </tr><tr>

        <td>כ <br />(כ' דגושה)</td>
        <td>K</td>
        <td>כל / כול / <b>K</b>ul</td>

    </tr><tr>

        <td>ל</td>
        <td>L</td>
        <td>למה / ליש / <b>L</b>esh</td>

    </tr><tr>

        <td>מ</td>
        <td>M</td>
        <td>מין (ממקום) / מן / <b>M</b>in</td>

    </tr><tr>

        <td>נ</td>
        <td>N</td>
        <td>אנשים / נאס / <b>N</b>aas </td>

    </tr><tr>

        <td>ס</td>
        <td>S</td>
        <td>קל / סהל / <b>S</b>ahel</td>

    </tr><tr>

        <td>ע</td>
        <td>A E I O U</td>
        <td>על / <b>ע</b>לא / <b>A</b>la</td>

    </tr><tr>

        <td>ע' <br />(ר' גרונית)</td>
        <td style="direction:ltr;">R'</td>
        <td>מערב / <b>ע'</b>רב / <b>R'</b>arb</td>

    </tr><tr>

        <td>פ <br />(פ' רפה)</td>
        <td>F</td>
        <td>תקלה / פשלה / <b>F</b>ashlah</td>

    </tr><tr>

        <td>צ <br />(לא נהגית כמו צ', אלא כס' נחצית)</td>
        <td style="direction:ltr;">S'</td>
        <td>סבלנות / צבר / <b>S'</b>aber</td>

    </tr><tr>

        <td>ק <br />(בהיגוי העירוני מבטאים ק' כמו א' עיצורית)</td>
        <td style="direction:ltr;">Q / A E I O U</td>
        <td>אומרים / באולו / B<b>i</b>ulu
        <br />אומרים / בקולו / B<b>q</b>ulu</td>

    </tr><tr>

        <td>ר <br />(ר' עברית "נכונה", מגולגלת בקצה הקדמי של הלשון)</td>
        <td>R</td>
        <td>אדומה / חמרא / H^am<b>r</b>a</td>

    </tr><tr>

        <td>ש <br />(ש' עברית – תמיד ימנית)</td>
        <td>Sh</td>
        <td>חלון / שובבכ / <b>Sh</b>ubbak</td>

    </tr><tr>

        <td>ת</td>
        <td>T</td>
        <td>שניים / תנין / <b>T</b>nen</td>

    </tr><tr>

        <td>ת' <br />(th)</td>
        <td>Th</td>
        <td>שור / ת'ור / <b>Th</b>awr</td>

        </tr>
</table>
<br />
<table align="center" border="1" cellpadding="5" style="text-align:center;">
    <tr>
        <td>אם יש דגש במילה – מכפילים את האות</td>
        <td>אני אוהב אותך / אנא בח<b>בב</b>כ / Ana bah^i<b>bb</b>ak</td>
    </tr>
</table>

<br /><br />

<table align="center" border="0">
    <tr>
        <td>תודה רבה ל<b>דנה עמבר</b> על תרומתה למילון ולבניית הקווים המנחים בפרט!</td>
    </tr>
</table>
<br />
 

<!--#include file="inc/trailer.asp"-->