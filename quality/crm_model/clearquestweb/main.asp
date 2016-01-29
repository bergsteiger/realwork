<%@ LANGUAGE=JScript%>
<%
 if (!Session('authUser')) Response.Redirect('default.asp');
%>

<html>

<title>Предложения и замечания</title>

<head>
 <link rel="stylesheet" href="style.css" type="text/css">
 <meta http-equiv="content-type" content="text/html; charset=windows-1251">
</head>

<!--
<frameset cols="250,*" border=1 framespacing=1 frameborder=1>
 <frame name="panel" src="panel.asp" scrolling="no" oresize=true>
 <frame name="list"  src="list.asp">
</frameset>
-->

<frameset rows="60,*" border=0  framespacing=0 frameborder=0>
 <frame name="panel" src="panel.asp" scrolling="no" oresize=true>
 <frame name="list"  src="blank.asp">
</frameset>

</html>
