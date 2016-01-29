<%@ LANGUAGE=JScript%>
<%
 if (!Session('authUser')) {
  Response.Write('<h3>Извините, время ожидания истекло. Войдите в систему заново.</h3>');
  Response.End();
 }
%>

<html>
<title>Предложение <%=Request('id')%></title>

<head>
 <link rel="stylesheet" href="style.css" type="text/css">
 <meta http-equiv="content-type" content="text/html; charset=windows-1251">
 <meta http-equiv="pragma " content="no-cache">

<script>
</script>

<style>

.td {border:1px solid gray;}

</style>

</head>

<% 
 var db = Session('db');

 var request = db.GetEntity('Request', Request('id'));

 var id            = getField('id');
 var date          = getField('date_submit');
 var name          = getField('name');
 var description   = getField('description');
 var theme         = getField('theme');
 var project       = getField('project');
 var sources_count = getField('sources_count');
 var attachments   = getField('attachments');

 var sources       = request.GetFieldValue('sources').GetValueAsList();

function getField(fieldName){
 return request.GetFieldValue(fieldName).GetValue;
}
%>

<body style="margin:4px;background-color:#dddddd;">

<table idth="98%" border="0" cellspacing="0" cellpadding="2"
 style="width:100%;height:100%;"
>

<tr height="1%">
 <td colspan="3" nowrap>
    <b><%=name%></b>
 </td>
</tr>

<tr height="1%">
 <td colspan="3">
    <%='[' + project + ']: ' + theme %>
 </td>
</tr>

<tr height="*">
 <td colspan="3" nowrap>
  <textarea><%=description%></textarea>
 </td>
</tr>

<tr height="1%">
 <td colspan="3">

<%
 var a, s, link, fName, ext;
 var afs = request.AttachmentFields();
 var af = afs.Item(0)
 var as = af.Attachments;
 if (as.Count()) Response.Write('Приложения:');
 for (i=0; i< as.Count();i++){
   a = as.Item(i)

   ext = a.FileName.split('.');
   ext = (ext.length-1) ? '.' + ext[ext.length-1] : '';

   fName = Server.MapPath('attachments/attachment' + i + ext);
   link = 'attachments/attachment' + i + ext;

   a.Load(fName);

   s = ' [<a target="_blank" href="' + link + '">' + a.FileName + '</a>] '
   Response.Write(s);
 }

%>

  <br>
 </td>
</tr>


<tr height="90">
 <td colspan="3">
  Откуда поступило:
  <div style="height:70px;overflow:auto;background-color:white;margin-top:2px;">
   <table width=99% border=0>
   <tr>
   <td>

<% 

var source;
var srcName, srcEmail, srcPhone, srcOrganization, srcAppointment, srcServiceOrganization, srcRegion, srcComments

function getSrcField(fieldName){
 var s = source.GetFieldValue(fieldName).GetValue;
 var re = /\"/ig;
 s = s.replace(re, '\'');
 return s; 
}

function makeSource(srcName, srcEmail, srcPhone, srcOrganization, srcAppointment, srcServiceOrganization, srcRegion, srcComments){
 var s = info ='';

 info = 'Заявитель: ' + srcName + '\n';
 if (srcAppointment)         info+= 'Должность: ' + srcAppointment + '\n';
 if (srcOrganization)        info+= 'Организация: ' + srcOrganization + '\n';
 if (srcRegion)              info+= 'Регион: ' + srcRegion + '\n';
 if (srcEmail)               info+= 'Email: ' + srcEmail + '\n';
 if (srcPhone)               info+= 'Телефон: ' + srcPhone + '\n';
 if (srcServiceOrganization) info+= 'Обслуживается в: ' + srcServiceOrganization + '\n';
 if (srcComments)            info+= 'Комментарии: ' + srcComments + '\n';
   

 s+= '<tr onmouseover="bgColor=\'#ddddff\'" onmouseout="bgColor=\'\'" onclick="alert(title)" title="' + info + '" style="cursor:hand;">';
 s+= '<td>';
 s+= (srcOrganization)?srcOrganization:srcName;
 s+= '</td>';

 s+= '<td width=*>';
 s+= srcRegion;
 s+= '</td></tr>';

 Response.Write(s);
}

 try{
  for (i=0;i<=sources.ubound();i++) {
    source = db.GetEntity('source', sources.getItem(i));

    srcName                = getSrcField('name');
    srcEmail               = getSrcField('email');
    srcPhone               = getSrcField('phone');
    srcOrganization        = getSrcField('organization');
    srcAppointment         = getSrcField('appointment');
    srcServiceOrganization = getSrcField('service_organization');
    srcRegion              = getSrcField('region');
    srcComments            = getSrcField('comments');

    makeSource(srcName, srcEmail, srcPhone, srcOrganization, srcAppointment, srcServiceOrganization, srcRegion, srcComments);
   }
 } catch(e){};
%> 
   </td>
   </tr>
   </table>

  </div>
 </td>
</tr>


</table>


</body>
</html>