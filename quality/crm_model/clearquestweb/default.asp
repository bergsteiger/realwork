<%@ LANGUAGE=JScript%>

<html>
<title>������� ����� �����������</title>

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
������� ����� �����������
</h3>

<br><br><br>

<form name="loginForm" action="login.asp" method="post">

<table border=0 cellpadding=3px>


<!--
<tr>
<td colspan=2>
<h4>���� � �������</h4>
</td>
</tr>
-->

<tr
 title="��� ����� � ���� ����������� � ���������"
>

<td>
<b>�����:</b>
</td>

<td nowrap>
<input type=text name="login" value="<%=Request.Cookies("userinfo")("login")%>" maxlength=40 size=10>
</td>                        
</tr>

<tr
 title="��� ������� ������ ��� ������� � ���� �����������"
>

<td nowrap>
<b>������:</b>
</td>

<td nowrap>
<input type=password name="password" value="<%=Request.Cookies("userinfo")("password")%>" maxlength=40 size=10>
</td>

</tr>

<!--

<tr
 title="��� ����� ������ ������� ����� ������ � ��� ���� (�� �������� ������ ����� ������� �������� ������)"
>

<td nowrap>
<b>[������� ������?]</b>
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

<input type="submit" value="  ����  " 
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
//  Response.Write("�������������� ������ �������� Internet Explorer");

//Response.Write  "<br><br>��� �������: <script>document.write(navigator.userAgent);</script>"
%>
  
</font>

</body>

</html>

