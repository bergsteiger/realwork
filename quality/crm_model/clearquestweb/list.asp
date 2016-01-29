<%@ LANGUAGE=JScript%>
<%
 if (!Session('authUser')) Response.Redirect('default.asp');
%>

<html>
<title>Предложения и замечания</title>

<head>
 <link rel="stylesheet" href="style.css" type="text/css">
 <meta http-equiv="content-type" content="text/html; charset=windows-1251">
 <meta http-equiv="pragma " content="no-cache">

<script>
function onOver(e) {e.className = 'requestL'}
function onOut(e)  {e.className = e.type}

function showDetails(id){
 var s;
 window.open('details.asp?id=' + id, '_blank', 'height=300,width=450,resizable=Yes,scrollbars=no,directories=no,status=no,toolbar=no');
}
</script>

</head>

<body>

<% 
 var db = Session('db');

 var requests = db.BuildQuery('Request');

 var operator = requests.BuildFilterOperator(1)

 requests.BuildField('dbid');
 requests.BuildField('date_submit');
 requests.BuildField('name');
 requests.BuildField('description');
 requests.BuildField('theme');
 requests.BuildField('project');
 requests.BuildField('sources_count');

 operator.BuildFilter('Type', 1, 'Предложение');

 var theme = Request.QueryString('theme');
 if (theme.Count) {
  theme = String(theme);
  operator.BuildFilter('theme', 1, theme);
 }

 var project = Request.QueryString('project');
 if (project.Count) {
  project = String(project);
  operator.BuildFilter('project', 1, project);
 }

 var interval = Request.QueryString('interval');
 if (interval.Count) {
  interval = String(interval);
  operator.BuildFilter('date_submit', 6, interval);
 }

 var context = Request.QueryString('context');
 if (context.Count) {
  context = String(context);
  operator.BuildFilter('name', 7, context);
  Response.Write('>>>>>:' + context);
 }

 var queryfielddefs = requests.QueryFieldDefs;
 var sortfield = queryfielddefs.Item(1);
 sortfield.SortType(2);
 sortfield.SortOrder(1);

 var rsltset = db.BuildResultSet(requests);
 rsltset.EnableRecordCount();
 rsltset.Execute();

 var recordsCount = rsltset.RecordCount;

%>
 <small style="color:gray;">
 <img src="img/down.gif" title="Показан порядок сортировки" align="absmiddle">
 дата поступления (всего предложений: <%=recordsCount%>)<br><br><br>
 </small>
<%

 var status = rsltset.MoveNext();
 var odd = true;

 while (status == 1){
  writeRequest(
  odd,
  rsltset.GetColumnValue(1), 
  rsltset.GetColumnValue(2), 
  rsltset.GetColumnValue(3), 
  rsltset.GetColumnValue(4), 
  rsltset.GetColumnValue(5), 
  rsltset.GetColumnValue(6), 
  rsltset.GetColumnValue(7));
  odd = !odd;
  status = rsltset.MoveNext();
 }

// ----------------------

function writeRequest(odd, id, date, name, description, theme, project, sources_count){
 var br = '<br>';
 var re = /\n/ig;
 d = description.replace(re, '<br>');

 var s = '<div onmouseover="onOver(this)" onmouseout="onOut(this)" onclick="showDetails(' + id + ')" ';

 s += 'title=" Дата поступления: ' + date + '\n Количество заявителей: ' + sources_count + '"';
 s += (odd) ? 'class="requestS" type="requestS"':'class="request" type="request"';
 s +=  '>';

// name = name.toUpperCase();

 s+= name.bold() + br + br;
 s+= '[' + project + ']:' + '&nbsp;' + theme + '' + br;
 
 s+= '</div>';
 
 Response.Write(s);
}

%>

<% if (recordsCount) {%>
<br>
<small style="color:gray;">
Конец страницы
</small>
<% }%>

</body>
</html>