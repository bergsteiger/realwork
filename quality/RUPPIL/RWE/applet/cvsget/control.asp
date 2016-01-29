
<% 
Response.Buffer = false
%>


<HTML>

<head>

<style>

 body {font-family: Verdana, Arial, Helvetica, sans-serif; margin: 40px; font-size: 80%;}
 a:hover {text-decoration:underline;font-size: 9pt; font-family:helv;}
 a {text-decoration:none;font-size: 9pt; font-family:helv;}

<!-- TABLES -->

        table           {text-decoration:none;font-size: 8pt; font-family:helv;color:black;margin:0px;padding:0px;}
	tr		{vertical-align: center; font-size: 8pt;}
	td		{vertical-align: center;font-size: 80%;}

<!-- PARAGRAPH -->
	p		{margin: 0px; margin-top:3px;margin-bottom:3px;}
      	.comment	{font-family:tahoma;font-size:7pt;}
        select          {font-family:tahoma;font-size:8pt;border-width:1px;}
        input           {font-family:tahoma;font-size:8pt;border-width:1px;}

</style>


<meta http-equiv="pragma " content="no-cache">
 <meta http-equiv="cache-control" content="0">
 <title>Документы</title>
 <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=windows-1251">
</head>


<BODY bgcolor=dfdfdf>



<br><br><br><br>Идет обновление..<br><br>



<%

  Set sh = Server.CreateObject("WScript.Shell")

  cmd="%comspec% /c " &  Application("root") & "\bin\co.bat "

' Первый параметр - путь к .cvspass; слеши должны быть левыми

  cmd = cmd & Application("root") & "\bin "


' Положение файла в CVS относительно корня репозитория
' Слеши - правые (!)


 fid = Request.QueryString("fid")
 
  cmd = cmd & " " & fid

  ret=sh.Run (cmd,0,true)

  set sh=Nothing

  If (ret <> 0) Then
   Response.Write "Ошибка при обновлении файла.. "
  Else
   Response.Write "<a href='docs/" & fid & "'><b><font color=blue>:: Загрузить ::</font><b></a>"
  End If

%>

