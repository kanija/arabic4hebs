<%
if Request.QueryString("exit")="1" then 
	session.Abandon
	Session("role")=null
	Response.redirect("login.asp")
end if

q = trim(Request("q"))
qFix = Replace(q, ChrW(160), "") %>
<div id="banner" style="z-index:3; text-align:center; min-width:320px;">
    <span style="position:fixed; top:5px; right:6px; ">
        <a href="#" onclick="toggleMenu();">
            <img src="img/site/menu.png" title="תפריט" alt="תפריט" />
        </a>
    </span>
    <form action="." style="text-align:center; display:inline-block; padding:4px;">
        <span id="searchTop" style="border-bottom-left-radius:0px; border-top-left-radius:0px;" >
            <input onclick="this.select();" type="text" id="searchBoxTop" name="q" value="<%=qFix%>" style="background-color:white; background-image:url(img/site/search.png); background-repeat:no-repeat; background-position:right; padding-right:30px; background-size:24px; "/>
        </span>
        <input type="submit" style="display:none;">
		<input type="hidden" name="order" value="<%=request("order")%>" />
    </form>
    <span style="position:fixed; top:3px; left:4px; ">
        <a href="default.asp">
            <img src="img/site/logo_small.png" alt="מילון ערבית מדוברת" style="height:34px;" />
        </a>
    </span>
</div>


<div id="container">

    <div style="display:none; border:0px solid red; width:320px; margin:0px auto; text-align:center;">
        <a href="default.asp" style="border:0px solid green;">
            <span style="font-size:150%;">
                מילון ערבית מדוברת
            </span>
            <span style="display:inline-block;">
                לדוברי עברית
            </span>
        </a>
    </div>

    <div id="nav" class="navNew" style="z-index:3;"><%
        dim cURL
        cURL = mid(Request.ServerVariables("url"),22) %>
	    <ul>
		    <li<%if cURL="default.asp" then%> class="current"<%end if%>><a href="default.asp">ראשי</a></li>
            <li class="hr"></li>
		    <li<%if left(cURL,5)="label" then%> class="current"<%end if%>><a href="label.asp?id=1">מילים לפי נושאים<span style="font-size:80%;"></span></a></li>
		    <li<%if cURL="list.vids.asp" then%> class="current"<%end if%>><a href="list.vids.asp">מילים עם סירטון</a></li>
		    <li<%if cURL="list.pics.asp" then%> class="current"<%end if%>><a href="list.pics.asp">מילים עם תמונה</a></li>
		    <li<%if cURL="list.asp" then%> class="current"<%end if%>><a href="list.asp">כל המילים <span style="font-size:80%;"></span></a></li>
            <li class="hr"></li>
		    <li<%if cURL="links.asp" then%> class="current"<%end if%>><a href="links.asp">קישורים</a></li>
		    <li<%if cURL="stats.asp" then%> class="current"<%end if%>><a href="stats.asp">סטטיסטיקה</a></li>
		    <li<%if cURL="about.asp" then%> class="current"<%end if%>><a href="about.asp">אודות</a></li>
		    <li<%if cURL="team.asp" then%> class="current"<%end if%>><a href="team.asp">דרושים</a></li>
		    <li<%if cURL="about.dev.asp" then%> class="current"<%end if%>><a href="about.dev.asp">עדכונים טכניים</a></li>
	    </ul>
        <span style="position:absolute; top:10px; left:0;" onclick="toggleMenu();"><a href="#">x</a></span>
    </div>	

    <%if msg <> "" then %><div id="message"><%=msg%></div><%end if %>

    <br />