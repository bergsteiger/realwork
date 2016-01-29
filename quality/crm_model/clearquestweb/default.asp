<%@ LANGUAGE=JScript%>

<html>
<title>Система сбора предложений</title>

<head>
 <link rel="stylesheet" href="style.css" type="text/css">
 <meta http-equiv="content-type" content="text/html; charset=windows-1251">
 <meta http-equiv="pragma " content="no-cache">

<script>

function onLoad(){
 if (top!=window) top.document.location.replace(document.location);
 document.all('login').focus();
}

</script>

</head>

<body 
 class="panel" 
 style="margin:50px;text-align:center;"
 onload=" onLoad();"
>

<h3>
Система сбора предложений
</h3>

<br><br><br>

<form name="loginForm" action="login.asp" method="post">

<table border=0 cellpadding=3px>


<!--
<tr>
<td colspan=2>
<h4>Вход в систему</h4>
</td>
</tr>
-->

<tr
 title="Ваш логин в базе предложений и замечаний"
>

<td>
<b>Логин:</b>
</td>

<td nowrap>
<input type=text name="login" value="<%=Request.Cookies("userinfo")("login")%>" maxlength=40 size=10>
</td>                        
</tr>

<tr
 title="Ваш текущий пароль для доступа к базе предложений"
>

<td nowrap>
<b>Пароль:</b>
</td>

<td nowrap>
<input type=password name="password" value="<%=Request.Cookies("userinfo")("password")%>" maxlength=40 size=10>
</td>

</tr>

<!--

<tr
 title="Для смены пароля впишите новый пароль в это поле (не забудьте ввести также текущее значение пароля)"
>

<td nowrap>
<b>[сменить пароль?]</b>
</td>

<td nowrap>
<input type=password name="newpassw" value="" maxlength=40 size=10> 
&nbsp;
</td>
</tr>

-->

<tr>

<td colspan=2 align=center>
<br>

<input type="submit" value="  Вход  " 
 class="button"
 style="width:100%;"
>

</td>
</tr>


</table>

</form>

<!-- ----------------------------------->

<font style="font-size: 7pt; color=red">

<% 
 var bc = Server.CreateObject("MSWC.BrowserType")
// if (bc.browser != "IE") and (CInt(Mid(bc.version,1,1))<5) 
//  Response.Write("Поддерживаются только браузеры Internet Explorer");

//Response.Write  "<br><br>Ваш браузер: <script>document.write(navigator.userAgent);</script>"
%>
  
</font>

</body>

</html>

