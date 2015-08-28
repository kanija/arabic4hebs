<!--#include file="inc/inc.asp"--><%
If (session("role") and 2) = 0 then Response.Redirect "login.asp" 
openDB "arabicWords" 

dim labelNames(21), i
dim a,x,timePast
i=1

mySQL = "SELECT * FROM labels"
res.open mySQL, con
    do while not res.EOF
        labelNames(i) = res("labelName")
        'labelNames(i) = "ok"
        i=i+1
        res.movenext
    loop
res.close
%>
<!DOCTYPE html>
<html>
<head>
	<title>פעולות אחרונות</title>
    <meta name="robots" content="none">
<!--#include file="inc/header.asp"-->
</head>
<body style="height:100%;">
<!--#include file="inc/top.asp"-->
<!--#include file="inc/topTeam.asp"-->
<div id="dashboard">
    <div id="pTitle"><h1>50 פעולות אחרונות</h1></div><%
        mySQL="SELECT TOP 50 * FROM (SELECT * FROM history LEFT JOIN (SELECT ID,username FROM [users] IN '"&Server.MapPath("/access_db/arabicUsers.mdb")&"') AS T ON history.[user]=T.ID ORDER BY actionDate DESC)"
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
                    </span>
                    <span> של המילה </span>
                    <span><a href="../word.asp?id=<%=res("word")%>"><%
                    if res("hebrewNew")<>"" then%>
                        <%=res("hebrewNew")%><%
                    else
                        mySQL = "SELECT hebrewTranslation FROM words WHERE id="&res("word")
                        if not res.EOF then
                            res2.open mySQL, con
                                response.write res2(0)
                            res2.close
                        else
                            response.write "<b>res.EOF</b>"
                        end if
                    end if %></a>,</span><%
                    if res("explain")<>"" then %>
                        <span> (הסבר לפעולה: <%=res("explain")%>)</span><%
                    end if %>
                    <span style="float:left;">
                        <a href='word.asp?id=<%=res("word")%>'><%=res("word")%></a>
                    </span>

                    <span>ע"י</span>
                    <span><a href="http://ronen.rothfarb.info/arabic/profile.asp?id=<%=res("T.ID")%>" target="user"><%=res("username")%></a></span>
                    <!--<label>סוגי שגיאות</label>
                    <span><%=res("errorTypes")%></span>-->
                </div><%
                Select Case res("action")
                Case 1
                    response.write "מילה חדשה"
                Case 2
                    response.write "חשד לטעות. בקשה לבדיקה"
                Case 3
                    response.write "נבדק ונמצא תקין"
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
        loop
        res.close %>
</div>
<!--#include file="inc/trailer.asp"-->
</body>
</html>