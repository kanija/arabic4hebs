<!--#include file="inc/inc.asp"--><%
dim cntID, cntLBL, cntIMG, cntVID, cntUSR, cntSrch, sumSrch
    
openDB "arabicWords"
    mySQL = "SELECT count(ID) as cntID FROM words WHERE words.show "
    res.open mySQL, con
        cntID = res("cntID")
    res.close
        
    mySQL = "SELECT count(ID) as cntLBL FROM labels"
    res.open mySQL, con
        cntLBL = res("cntLBL")
    res.close
        
    mySQL = "SELECT count(ID) as cntIMG FROM words WHERE imgLink<>''"
    res.open mySQL, con
        cntIMG = res("cntIMG")
    res.close 

    mySQL = "SELECT count(wordID) as cntVID FROM wordsLinks"
    res.open mySQL, con
        cntVID = res("cntVID")
    res.close
closeDB
        
openDB "arabicUsers"
    mySQL = "SELECT count(ID) as cntUSR FROM users"
    res.open mySQL, con
        cntUSR = res("cntUSR")
    res.close
closeDB    
    
openDB "arabicSearch"
	mySQL = "SELECT count(*),sum(searchCount) FROM wordsSearched"
	res.open mySQL, con     
        cntSrch = res(0)
        sumSrch = res(1)
    res.close
closeDB

%>
<!DOCTYPE html>
<html style="height:100%;">
<head>
	<title>סטטיסטיקה</title>
	<meta name="Description" content="מידע וסטטיסטיקה על המילון והגלישה לאתר" />
<!--#include file="inc/header.asp"-->
    <style>
        .grow   { display:block; color:#539425; }
    </style>
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"-->

<div id="pTitle">סטטיסטיקה</div>

<br />
<div class="table divStats">
    נכון לרגע זה, ישנם במילון:
    <br /> <%=cntID%> ערכים, <%=cntLBL%> תגיות, 
    <br /><%=cntIMG%> תמונות ו-<%=cntVID%> סרטונים
    <br />שנוספו ע"י <%=cntUSR%> מתנדבים.
</div>
<br />
<div class="table divStats">
	מאז דצמבר 2009 ועד רגע זה
    <br />נעשו <%=sumSrch%> חיפושים
    <br />ל-<%=cntSrch%> מילים וביטויים שונים 
</div>
<br />
<div class="table divStats" style=" max-width:280px; padding:10px 10px; border-radius:10px; ">
    >> <a href="stats.topSearch.asp">100 המילים שחיפשו הכי הרבה</a>
</div>


<div class="table">
    <h4>מידע מגוגל אנליטיקס לגבי גלישה לאתר</h4>
</div>
<table class="tableStats">
    <tr>
        <th>&nbsp;</th>
        <th style="text-align:center;">2014</th>
        <th style="text-align:center;">2013</th>
        <th style="text-align:center;"><span>15.2.</span>2012</th>
    </tr>
    <tr>
        <th>כניסות ייחודיות</th>
        <td>39,321
            <span class="grow" dir="ltr">+131%</span>
        </td>
        <td>16,987
            <span class="grow" dir="ltr">+104%</span>
        </td>
        <td>8,299</td>
    </tr>
    <tr>
        <th>כניסות סה"כ</th>
        <td>67,260
            <span class="grow" dir="ltr">+146%</span>
        </td>
        <td>27,316
            <span class="grow" dir="ltr">+110%</span>
        </td>
        <td>12,963</td>
    </tr>
    <tr>
        <th>דפים שנצפו</th>
        <td>300,465
            <span class="grow" dir="ltr">+115%</span>
        </td>
        <td>139,577
            <span class="grow" dir="ltr">+65%</span>
        </td>
        <td>84,177</td>
    </tr>
    <!--
    <tr>
        <th>דפים שנצפו / כניסות סה"כ</th>
        <td>4.47</td>
        <td>5.11</td>
        <td>6.49</td>
    </tr>
    <tr>
        <th>משך כניסה ממוצע</th>
        <td>00:03:56</td>
        <td>00:03:58</td>
        <td>00:04:03</td>
    </tr>
    -->
    <tr>
        <th>&nbsp;</th>
        <th style="text-align:center;">2014</th>
        <th style="text-align:center;">2013</th>
        <th style="text-align:center;"><span>15.2.</span>2012</th>
    </tr>
    <tr>
        <th>כניסות ממחשבים</th>
        <td>28,577<br /><span>(42%)</span></td>
        <td>15,151<br /><span>(55%)</span></td>
        <td>9,736<br /><span>(75%)</span></td>
    </tr>
    <tr>
        <th>כניסות מסמארטפונים</th>
        <td>35,782<br /><span>(53%)</span></td>
        <td>10,971<br /><span>(40%)</span></td>
        <td>2,732<br /><span>(21%)</span></td>
    </tr>
    <tr>
        <th>כניסות מטאבלטים</th>
        <td>2,901<br /><span>(4%)</span></td>
        <td>1,194<br /><span>(4%)</span></td>
        <td>495<br /><span>(3%)</span></td>
    </tr>
</table>
<!--#include file="inc/trailer.asp"-->