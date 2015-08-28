<!--#include file="inc/inc.asp"--><%

dim wordId, countMe, spacer, show, status, imgLink, imgCredit
dim	partsOfSpeach,pos,genders,gen,numbers,nums
dim creatorID,creationDate,userName
dim pronunciation, arabicWord, hebTrans, info, example, origin

dim labelNames(21), i
dim a,x,timePast
i=1

openDB "arabicWords"

mySQL = "SELECT * FROM labels"
res.open mySQL, con
    do while not res.EOF
        labelNames(i) = res("labelName")
        'labelNames(i) = "ok"
        i=i+1
        res.movenext
    loop
res.close


countMe = 0
spacer = ""

partsOfSpeach = "לא ידוע / אחר|שם עצם|שם תואר|פועל|תואר הפועל|מילית יחס|מילית חיבור|מילת קריאה|תחילית|סופית"
genders = "נטרלי|זכר|נקבה|לא ידוע / לא רלוונטי"
numbers = "בלתי ספיר|יחיד|זוגי|רבים|לא ידוע / לא רלוונטי"

Function GetName (Names, Num)
    Dim Arr
    Arr = Split(Names, "|")
    GetName = Arr(Num)
End Function

wordId = request("id")

mySQL = "SELECT * FROM words LEFT JOIN " & _
	"(SELECT * FROM [users] IN '"&Server.MapPath("/access_db/arabicUsers.mdb")&"') AS T " & _
	"ON words.creatorID=T.ID WHERE words.id = "&wordId&" ORDER BY arabicWord"
res.open mySQL, con

    if res.eof then
        session("msg") = "הערך שחיפשת הוסר או אוחד עם ערך אחר"
        response.redirect baseA
    end if

    hebTrans = res("hebrewTranslation")
    pronunciation = res("pronunciation")
    arabicWord = res("arabicWord")
    creatorID = res("creatorID")
    creationDate = res("creationDate")
    userName = res("userName")
    info = res("info")
    example = res("example")
    pos = res("partOfSpeach")
    gen = res("words.gender")
    nums = res("number")
    origin = res("originWordId")
    show = res("show")
    status = res("status")
    imgLink = res("imgLink")
    imgCredit = res("imgCredit")

res.close
'closeDB
%>
<!DOCTYPE html>
<html style="height:100%;">
<head>
    <title><%=hebTrans%></title>
    <meta property="og:title" content="<%=hebTrans%>" />
    <link rel="stylesheet" href="<%=baseT%>inc/arabicTeam.css" />
<!--#include file="inc/header.asp"-->
	<style>
		.disabled { background-color: rgba(238, 238, 238, 0.87); border-radius:15px; cursor:initial;}
		#toolsClick,#historyClick { cursor:pointer;}
		#toolsTable { display:block; margin-top:20px; background-color:rgba(225, 226, 144, 0.36); padding:8px 10px 10px 0px;}
		#toolsTable > div {display:inline-block; width:100px; height:100px; border: 1px solid rgba(174, 120, 78, 1); margin: 5px 5px; border-radius: 15px; text-align: center; vertical-align: middle; background-color: white; box-shadow: 2px 2px 5px rgba(174, 120, 78, 0.66); color: rgb(174, 120, 78);}
		#toolsTable > div:hover:not(.disabled) {background-color: rgb(255, 239, 208); box-shadow: 2px 2px 15px #999; cursor:pointer;}
		#toolsTable p {display:table-cell; width:100px; height:100px; vertical-align:middle; padding:0 5px; font-size:small;}
		#toolsTable img {opacity: 0.7;}
		.disabled img {opacity: 0.3 !important;}
        #reportErr { display:none;padding:8px 10px 10px 0px;}
	</style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script>
	$(document).ready(function(){
	  $("#toolsTable").hide();
	  $("#editHistory").hide();
      $("#reportErr").hide();
	  $("#toolsClick").click(function(){
	      $("#editHistory").hide();
          $("#reportErr").hide();
	      $("#toolsTable").slideToggle();
	  });
	  $("#historyClick").click(function(){
	      $("#toolsTable").hide();
          $("#reportErr").hide();
	      $("#editHistory").slideToggle();
	  });
      $("#errBtn").click(function(){
          $("#toolsTable").hide();
          $("#reportErr").slideToggle();
      });
      $("#back").click(function(){
          $("#reportErr").hide();
          $("#toolsTable").slideToggle();
      });
	});
	</script>
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"--><%
if (session("role") And 2)>0 then%><!--#include file="inc/topTeam.asp"--> <%end if%>
<div class="tableWord" style="box-shadow:rgba(0,0,0,0.45) 2px 2px 22px -3px; margin-bottom:20px; font-size:150%;">
	<div title="עברית" class="heb" style="border-bottom:solid 1px #cddbea; text-align:right; padding-right:5px; float:none;"><%=hebTrans%></div>
	<div title="ערבית" class="arb" style="border-bottom:solid 1px #cddbea; text-align:center; height:38px; "><span id="arbWordSpan"><%=arabicWord%></span></div>
	<div title="הגייה" class="eng" style="border-bottom:0px; text-align:left; padding-left:5px; float:none;"><%=pronunciation%></div>
</div><%
mySQL = "SELECT * FROM labels INNER JOIN wordsLabels ON labels.id=wordsLabels.labelID WHERE wordID=" + wordId + " ORDER BY labelName"
	res.open mySQL, con
	if not res.EOF then%>
	    <div class="table" style="text-align:left; margin: 0 auto 15px auto;"><%
		Do until res.EOF %>
			<a href="<%=baseA%>label.asp?id=<%=res("labelID")%>"><span class="label"><%=res("labelName")%></span></a> <%
			res.moveNext
		Loop%>
	    </div><%
	end if
	res.close
    
    mySQL = "SELECT * FROM wordsLinks INNER JOIN words ON wordsLinks.wordID=words.ID WHERE words.ID = " & wordId
	res.open mySQL, con
		if not res.EOF then %>
		<table style="margin:0px auto;">
			<%
			Do until res.EOF
			    if res("description")="YouTube Embed" then %>
			    <tr>
				    <td style="text-align:center;"><iframe class="youTube" src="//www.youtube.com/embed/<%=res("link")%>?rel=0&theme=light" allowfullscreen style="border:0;"></iframe></td>
			    </tr><%
			    else %>
			    <tr style="font-size:medium;">
				    <td><a href="<%=res("link")%>" target="<%=res("description")%>"><%=res("description")%></a></td>
			    </tr><%
			    end if
		        res.moveNext
		    Loop
            %>
            <tr><td style="text-align:left;"><a href="list.vids.asp">לכל הסרטונים</a></td></tr>
		</table><%
		end if
    res.close %>
	<table class="table">
	    <tr style="vertical-align:top;">
	        <td><%
				if info <> "" then %>
					<table class="tableWord">
						<tr><td class="ta3">הערות</td></tr>
						<tr><td class="ta6"><%=info%></td></tr>
					</table><%
		            end if 
					if example <> "" then %>
					<table class="tableWord">
						<tr><td class="ta3">דוגמאות</td></tr>
						<tr><td class="ta6"><%=example%></td></tr>
					</table><%
				end if %>

				<table class="tableWord">
					<tr>
					    <td class="ta5">חלק דיבר</td>
					    <td class="ta4"><%=GetName(partsOfSpeach,pos)%></td>
					</tr>
					<tr>
					    <td class="ta5">מין</td>
					    <td class="ta4"><%=GetName(genders,gen)%></td>
					</tr>
					<tr>
					    <td class="ta5">מספר</td>
					    <td class="ta4"><%=GetName(numbers,nums)%></td>
					</tr><%
				if (session("role") And 8)>0 then%>
					<tr>
			            <td class="ta5">
			                צורת המקור
			            </td>
						<td class="ta4">
			                <%=origin%> <span style="color:red;float:left;padding-left:10px;"> [מוצג כרגע רק לבודקי מילים ומעלה] </span>
						</td>
					</tr><%
				end if %>
				</table>
			</td>
		</tr>
	</table><%
if imgLink <> empty then %>
	<div class="table" style="text-align:center;" dir="ltr">
	    <img src="<%=imgLink%>" alt="<%=imgCredit%>" title="<%=imgCredit%>" class="photo" />
	    <span style="display:block; color:gray; font-size:small;">Credit : <%=imgCredit%></span>
	</div><%
end if
if not show then %>
    <div class="tableH" style="border:dashed 2px red;">
        <img src="<%=baseA%>img/site/hidden.png" alt="מילה זו מוסתרת מעיני הגולשים במילון" title="מילה זו מוסתרת מעיני הגולשים במילון" />
        <br/>ערך מוסתר (לא יופיע בתוצאות חיפוש)
    </div><%
end if 
Select Case status
    Case 1 %>
        <div class="tableH">
            <img src="<%=baseA%>img/site/correct.png" alt="ערך תקין" title="ערך תקין" />
            <br />ערך זה נבדק ונמצא תקין
        </div><%
    Case 0 %>
        <div class="tableH">
	        <img src="<%=baseA%>img/site/unchecked.png" alt="ערך זה טרם נבדק" title="ערך זה טרם נבדק" />
	        <br />ערך זה טרם נבדק
        </div> <%
    Case -1 %>
        <div class="tableH" style="border:dashed 2px red;">
            <!--tr style="text-align:center;background-color:#ffffff; vertical-align:middle; height:40px; font-weight:bold; color:black;"-->
            <img src="<%=baseA%>img/site/erroneous.png" alt="ערך לא תקין" title="ערך לא תקין" />
            <br />ערך זה סומן כ'לא תקין'.
            <span style="display:inline-block;">ייתכן ואיננו מדויק.</span>
        </div> <%
End Select %>

<table class="table" style="margin-bottom:20px;">
    <tr style="text-align:right;width:100%">
        <td><span role="button" id="toolsClick">עריכה</span> | <span role="button" id="historyClick"> היסטוריית עריכות </span> | <span> מס"ד: <%=wordId%></span></td>
    </tr>
</table>

    
<div id="toolsTable" class="table team"><%
if not (session("role") And 2)>0 then %>
	<span style="display:block; text-align:center; padding:20px; border:dotted rgb(187, 187, 39); font-weight:bold; background-color:rgb(253, 250, 215);
  border-width:1px 1px 1px 0; margin-bottom:5px;">על מנת לערוך, עליך <a href="<%=baseT%>login.asp">להתחבר</a></span><%
end if %>
    <div>
    	<p<%if not (session("role") And 4)>0 or status=-1 then%> class="disabled" title="ערך זה כבר סומן לא תקין או שאין לך הרשאה מתאימה"<%else%> id="errBtn" <%end if%>>
    		<img src="<%=baseA%>img/site/erroneous.png" id="erroneous_s" alt="סימון טעות" />
    		<br/>
        	דווח על טעות
    	</p>
    </div>
    <div>
    	<p<%if not (session("role") And 4)>0 or status=1 then%> class="disabled" title="אין לך הרשאה לאשר תקינות מילה זו"<%else%> onclick="if (confirm('האם לשנות סטטוס לתקין ללא ביצוע כל עריכה?')) location.href='<%=baseT%>word.correct.asp?wordId=<%=wordId%>&amp;status=<%=status%>'"<%end if%>>
    		<img src="<%=baseA%>img/site/correct.png" id="Img1" alt="אישור ערך" />
    		<br/>
    		אשר תקינות
    	</p>
	</div>
    <div>
    	<p<%if not (session("role") And 4)>0 or status=0 then%> class="disabled" title="ערך זה כבר סומן כ'טרם נבדק' או שאין לך הרשאה מתאימה"<%else%> onclick="exReset()"<%end if%>>
    		<img src="<%=baseA%>img/site/unchecked.png" id="reset" alt="ערך זה טרם נבדק"/>
    		<br/>
    		סמן ערך כ'טרם נבדק'
    	</p>
        <script>
            function exReset() {
                var explain = prompt("אנא הוסף הסבר לשינוי סטטוס המילה","");
                if (explain != "") location.href='word.reset.asp?wordID=<%=wordId%>&status=<%=status%>&explain='+explain;
                else alert ("יש לציין את הסיבה לשינוי סטטוס המילה") 
            }
        </script>
    </div>
    <div>
        <p<%if (session("role") And 4)>0 then%>  onclick="location.href='<%=baseT%>word.hide.asp?id=<%=wordId%>'"<%else%> class="disabled" title="אין לך הרשאה לשנות תצוגה של מילה זו"<%end if%>>
            <img src="<%=baseA%>img/site/hidden.png" id="hidden_s" alt="ביטול / הסתרת ערך"/>
            <br/><%
            if show=false then %>ביטול <%end if %>
            הסתרת המילה מהגולשים
        </p>
    </div>
    <div title="פעולה זו תהיה זמינה בעתיד">
        <p class="disabled">דווח על כפילות</p>
    </div>
    <div>
        <p<%if (session("role") And 4)>0 or session("userID")=creatorID then%> onclick="location.href='<%=baseT%>edit.asp?id=<%=wordId%>'"<%else%> class="disabled" title="אין לך הרשאה לערוך מילה זו"<%end if%>>
            עריכת מילה
        </p>
    </div>
</div>
<div id="reportErr" class="table team">
    <h3 style="padding-bottom:0; margin-bottom:0;">היכן יש טעות? <span style="font-weight:normal;">[בחירה מרובה]</span></h3>
    <form action="word.erroneous.asp">
        <input type="hidden" id="wordID" name="wordID" value="<%=wordId%>" />
        <input type="hidden" id="status" name="status" value="<%=status%>" />
        <div><%
            mySQL = "SELECT * FROM errorTypes ORDER BY errorType"
            res.open mySQL, con
            do until res.EOF %>
                <br/><input type="checkbox" id="errorType" name="errorType" value="<%=res("ID")%>"/>
                <%=res("errorType")%><%
                res.movenext
            loop
            res.close %>
        </div>
        <div style="margin:10px 0;">
            <textarea required rows="2" style="width:90%;" id="explain" name="explain" placeholder="הסבר / מידע נוסף"></textarea>
        </div>
        <input type="submit" value="אישור"/>
        <a id="back" href="#reportErr" style="margin-right:15px;">ביטול</a>
    </form>
</div>
<div id="editHistory" class="table team"><%
	 	mySQL="SELECT TOP 50 * FROM (SELECT * FROM history LEFT JOIN (SELECT ID,username FROM [users] IN '"&Server.MapPath("/access_db/arabicUsers.mdb")&"') AS T ON history.[user]=T.ID WHERE history.word="&wordId&" ORDER BY actionDate DESC)"
        res.open mySQL, con
        Do until res.EOF %>
            <div class="changeDiv">
                <div class="changeTop">
                    <span title="<%=res("actionDate")%>" style="width:70px;"><%
                        timePast = dateDiff("s",res("actionDate"),now())
                        'response.write timePast
                        if timePast =< 60 then
                            response.write "לפני " &timepast& " שניות"
                        else
                            if timePast =< 86400 then
                                if timepast/60 < 60 then 
                                    response.write "לפני " &round(timepast/60)& " דקות"
                                else
                                    response.write "לפני " &round(timepast/60/60)& " שעות"
                                end if
                            else
                                if timePast =< 172800 then
                                    response.write "אתמול"
                                else
                                    response.write FormatDateTime(res("actionDate"),1)
                                end if
                            end if
                        end if%>
                    </span>
                    <span style="font-weight:bold;"><%
                        Select Case res("action")
                        Case 1
                            response.write "מילה חדשה"
                        Case 2
                            response.write "חשד לטעות. בקשה לבדיקה"
                        Case 3
                            response.write "נבדק ונמצא תקין"
                        Case 4
                            response.write "תיקון טעויות"                        
                        Case 5
                            response.write "הסתרה"
                        Case 6
                            response.write "ביטול הסתרה"
                        Case 7
                            response.write "שליחה לארכיב"
                        Case 8
                            response.write "החזרה מארכיב" 
                        End Select %>
                    </span><%
                    if res("explain")<>"" then %>
                        <span> (הסבר לפעולה: <%=res("explain")%>)</span><%
                    end if %>
                    <span>ע"י</span>
                    <span><a href="<%=baseA%>profile.asp?id=<%=res("T.ID")%>" target="user"><%=res("username")%></a></span>
                    <!--<label>סוגי שגיאות</label>
                    <span><%=res("errorTypes")%></span>-->
                </div><%
                Select Case res("action")
                Case 2 
                    if res("errorTypes") then %>
                        <ul><%
                        dim errorCount, errorArray
                        errorArray = split(res("errorTypes"),",")
                        errorCount = ubound(errorArray)
                        for i=0 to errorCount
                            mySQL="SELECT errorType FROM errorTypes WHERE ID="&errorArray(i) 
                            res2.open mySQL, con %>
                            <li>
                                <%=res2(0)%>
                            </li><%
                            res2.close
                        next %>
                        </ul><%
                    end if
                Case 4 %>
                    <div class="hisTable"><%

                        if res("hebrewNew")<>res("hebrewOld") then %>
                        <div>
                            <span class="field">עברית</span>
                            <span class="new"><%=res("hebrewNew")%></span>
                            <span class="old"><%=res("hebrewOld")%></span>
                        </div><%
                        end if

                        if res("arabicNew")<>res("arabicOld") then%>
                        <div>
                            <span class="field">ערבית</span>
                            <span class="new"><%=res("arabicNew")%></span>
                            <span class="old"><%=res("arabicOld")%></span>
                        </div><%
                        end if
                        
                        if res("pronunciationNew")<>res("pronunciationOld") then%>
                        <div>
                            <span class="field">הגייה</span>
                            <span class="new"><%=res("pronunciationNew")%></span>
                            <span class="old"><%=res("pronunciationOld")%></span>
                        </div><%
                        end if

                        if res("statusNew")<>res("statusOld") then %>
                        <div>
                            <span class="field">סטטוס</span>
                            <span class="new"><%
                                Select Case res("statusNew")
                                Case 1
                                    response.write "תקין"
                                Case 0
                                    response.write "לא נבדק"
                                Case -1
                                    response.write "טעות"
                                Case else
                                    response.write "<b>מידע שגוי! פנה למנהל האתר.</b>"
                                End Select %>
                            </span>
                            <span class="old"><%
                                Select Case res("statusOld")
                                Case 1
                                    response.write "תקין"
                                Case 0
                                    response.write "לא נבדק"
                                Case -1
                                    response.write "טעות"
                                Case else
                                    response.write "<b>מידע שגוי! פנה למנהל האתר.</b>"
                                End Select %>
                            </span>
                        </div><%
                        end if 

                        if res("showNew")<>res("showOld") then %>
                        <div>
                            <span class="field">תצוגה</span>
                            <span class="new"><%
                                if res("showNew")=True then %>מוצג<%else%>מוסתר<%end if%>
                            </span>
                            <span class="old"><%
                                if res("showOld")=True then %>מוצג<%else%>מוסתר<%end if%>
                            </span>
                        </div><%
                        end if

                        if res("searchStringNew")<>res("searchStringOld") then%>
                        <div>
                            <span class="field">מילות חיפוש</span>
                            <span class="new"><%=res("searchStringNew")%></span>
                            <span class="old"><%=res("searchStringOld")%></span>
                        </div><%
                        end if

                        if res("rootNew")<>res("rootOld") then%>
                        <div>
                            <span class="field">צורת מקור</span>
                            <span class="new"><%=res("rootNew")%></span>
                            <span class="old"><%=res("rootOld")%></span>
                        </div><%
                        end if

                        if res("partOfSpeachNew")<>res("partOfSpeachOld") then%>
                        <div>
                            <span class="field">חלק דיבר</span>
                            <span class="new"><%
                                Select Case res("partOfSpeachNew")
                                Case 0
                                    response.write "לא ידוע / אחר"
                                Case 1
                                    response.write "שם עצם"
                                Case 2
                                    response.write "שם תואר"
                                Case 3
                                    response.write "פועל"
                                Case 4
                                    response.write "תואר הפועל"
                                Case 5
                                    response.write "מילית יחס"
                                Case 6
                                    response.write "מילת חיבור"
                                Case 7
                                    response.write "מילת קריאה"
                                Case 8
                                    response.write "תחילית"
                                Case 9
                                    response.write "סופית"
                                Case else
                                    response.write "<b>מידע שגוי! פנה למנהל האתר.</b>"
                                End Select %>
                            </span>
                            <span class="old"><%
                                Select Case res("partOfSpeachOld")
                                Case 0
                                    response.write "לא ידוע / אחר"
                                Case 1
                                    response.write "שם עצם"
                                Case 2
                                    response.write "שם תואר"
                                Case 3
                                    response.write "פועל"
                                Case 4
                                    response.write "תואר הפועל"
                                Case 5
                                    response.write "מילית יחס"
                                Case 6
                                    response.write "מילת חיבור"
                                Case 7
                                    response.write "מילת קריאה"
                                Case 8
                                    response.write "תחילית"
                                Case 9
                                    response.write "סופית"
                                Case else
                                    response.write "<b>מידע שגוי! פנה למנהל האתר.</b>"
                                End Select %>
                            </span>
                        </div><%
                        end if

                        if res("genderNew")<>res("genderOld") then%>
                        <div>
                            <span class="field">מין</span>
                            <span class="new"><%
                                Select Case res("genderNew")
                                Case 0
                                    response.write "נטרלי"
                                Case 1
                                    response.write "זכר"
                                Case 2
                                    response.write "נקבה"
                                Case 3
                                    response.write "לא ידוע / לא רלוונטי"
                                Case else
                                    response.write "<b>מידע שגוי! פנה למנהל האתר.</b>"
                                End Select %>
                            </span>
                            <span class="old"><%
                                Select Case res("genderOld")
                                Case 0
                                    response.write "נטרלי"
                                Case 1
                                    response.write "זכר"
                                Case 2
                                    response.write "נקבה"
                                Case 3
                                    response.write "לא ידוע / לא רלוונטי"
                                Case else
                                    response.write "<b>מידע שגוי! פנה למנהל האתר.</b>"
                                End Select %>
                            </span>
                        </div><%
                        end if

                        if res("numberNew")<>res("numberOld") then%>
                        <div>
                            <span class="field">מספר</span>
                            <span class="new"><%
                                Select Case res("numberNew")
                                Case 0
                                    response.write "בלתי ספיר"
                                Case 1
                                    response.write "יחיד"
                                Case 2
                                    response.write "זוגי"
                                Case 3
                                    response.write "רבים"
                                Case 4
                                    response.write "לא ידוע / לא רלוונטי"
                                Case else
                                    response.write "<b>מידע שגוי! פנה למנהל האתר.</b>"
                                End Select %>
                            </span>
                            <span class="old"><%
                                Select Case res("numberOld")
                                Case 0
                                    response.write "בלתי ספיר"
                                Case 1
                                    response.write "יחיד"
                                Case 2
                                    response.write "זוגי"
                                Case 3
                                    response.write "רבים"
                                Case 4
                                    response.write "לא ידוע / לא רלוונטי"
                                Case else
                                    response.write "<b>מידע שגוי! פנה למנהל האתר.</b>"
                                End Select %>
                            </span>
                        </div><%
                        end if

                        if res("infoNew")<>res("infoOld") then%>
                        <div>
                            <span class="field">הערות</span>
                            <span class="new"><%=res("infoNew")%></span>
                            <span class="old"><%=res("infoOld")%></span>
                        </div><%
                        end if

                        if res("exampleNew")<>res("exampleOld") then%>
                        <div>
                            <span class="field">דוגמאות</span>
                            <span class="new"><%=res("exampleNew")%></span>
                            <span class="old"><%=res("exampleOld")%></span>
                        </div><%
                        end if

                        if res("imgLinkNew")<>res("imgLinkOld") then%>
                        <div>
                            <span class="field">קישור לתמונה</span>
                            <span class="new"><%=res("imgLinkNew")%></span>
                            <span class="old"><%=res("imgLinkOld")%></span>
                        </div><%
                        end if

                        if res("imgCreditNew")<>res("imgCreditOld") then%>
                        <div>
                            <span class="field">קרדיט תמונה</span>
                            <span class="new"><%=res("imgCreditNew")%></span>
                            <span class="old"><%=res("imgCreditOld")%></span>
                        </div><%
                        end if

                        if res("linkDescNew")<>res("linkDescOld") then%>
                        <div>
                            <span class="field">סוג קישור</span>
                            <span class="new"><%=res("linkDescNew")%></span>
                            <span class="old"><%=res("linkDescOld")%></span>
                        </div><%
                        end if

                        if res("linkNew")<>res("linkOld") then%>
                        <div>
                            <span class="field">קישור</span>
                            <span class="new"><%=res("linkNew")%></span>
                            <span class="old"><%=res("linkOld")%></span>
                        </div><%
                        end if

                        if res("labelsNew")<>res("labelsOld") then%>
                        <div>
                            <span class="field">תגיות</span>
                            <span class="new"><%
                                if res("labelsNew")<>"" then
                                    a=Split(res("labelsNew"),",")
                                    for each x in a
                                        response.write(labelNames(x) & "; ")
                                    next
                                end if %>
                            </span>
                            <span class="old"><%
                                if res("labelsOld")<>"" then
                                    a=Split(res("labelsOld"),",")
                                    for each x in a
                                        response.write(labelNames(x) & "; ")
                                    next
                                end if %>
                            </span>
                        </div><%
                        end if %>
                </div><%

                Case 7
                    response.write "שליחה לארכיב"
                Case 8
                    response.write "החזרה מארכיב" 
                End Select %>
            </div> <%
            res.movenext
        loop%>
        <div class="changeDiv">
            <span class="field"><%=FormatDateTime(creationDate,1)%> <b>המילה נוספה למילון</b> ע"י <a href="profile.asp?id=<%=creatorID%>"><%=userName%></a></span>
        </div><%
        res.close %>
</div><%
closeDB %>
<!--#include file="inc/trailer.asp"-->