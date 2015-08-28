﻿<!-- Language="VBScript" CodePage="65001"-->
<!-- Language="VBScript" CodePage="1255"--><%
dim msg, q, qFix, bColor

msg = Session("msg")
Session("msg") = "" %>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <!--base href="<%=baseA%>" target="_blank"-->
	<link rel="stylesheet" href="<%=baseA%>css/normalize.css" />
	<link rel="stylesheet" href="<%=baseA%>css/nav.css" />
	<link rel="stylesheet" href="<%=baseA%>css/arabic_constant.css" />
	<link rel="stylesheet" href="<%=baseA%>css/arabic_upto499wide.css" media="(max-width:499px)" />
  <link rel="stylesheet" href="<%=baseA%>css/arabic_from500wide.css" media="(min-width:500px)" />
	<link rel="stylesheet" href="<%=baseA%>css/arabic_upto499high.css" media="(max-height:499px)" />
  <link rel="stylesheet" href="<%=baseA%>css/arabic_from500high.css" media="(min-height:500px)" />
  <link rel="stylesheet" href="inc/arabicTeam.css" />
	<link rel="shortcut icon" href="img/teamFavicon.ico" />
  <link rel="image_src" href="<%=baseA%>img/site/logo.jpg" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- google analytics STARTS here -->
    <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', 'UA-16150819-2']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();
    </script>
    <!-- google analytics ENDS here -->