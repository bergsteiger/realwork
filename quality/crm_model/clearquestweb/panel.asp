<%@ LANGUAGE=JScript%>
<%
 if (!Session('authUser')) Response.Redirect('default.asp');
 var db = Session('db');
%>


<% 
 var classificator = 'Array(';

 var pName, tName;
 var re;

 var rs = db.BuildQuery('Project');
 rs.BuildField('name');

 var rsltset = db.BuildResultSet(rs);
 rsltset.Execute();

 var status = rsltset.MoveNext();

 while (status == 1){
  pName = rsltset.GetColumnValue(1);
  re = /\'/ig;
  pName = pName.replace(re, '"');

  classificator+= 'Array(\'' + pName + '\'';

  var trs = db.BuildQuery('Theme');
  trs.BuildField('name');
  var operator = trs.BuildFilterOperator(1)
  operator.BuildFilter('Project', 1, pName);

  var trsltset = db.BuildResultSet(trs);
  trsltset.Execute();

  var tstatus = trsltset.MoveNext();

  while (tstatus == 1){
   tName = trsltset.GetColumnValue(1);
   re = /\'/ig;
   tName = tName.replace(re, '"');
   classificator+= ', \'' + tName +  '\'';
   tstatus = trsltset.MoveNext();
  }

  classificator+= ')';

  status = rsltset.MoveNext();
  if (status == 1) 
   classificator+= ', ';
  else
   classificator+= ')';
 }
%>


<html>

<head>
 <link rel="stylesheet" href="style.css" type="text/css">
 <meta http-equiv="content-type" content="text/html; charset=windows-1251">
 <meta http-equiv="pragma " content="no-cache">

<script>

var classificator = <%=classificator%>; 
var allOption = '-- ��� --';

var theme    = 'all';
var project  = 'all';
var interval = 'all';
var sort     = 'date';
var order    = 'asc';
var context  = '';

function onLoad(){
 var i, option;
 with (document.all('project')) {
  option = new Option('-- ��� --', 'all');
  options.add(option);
  for (i=0; i<classificator.length; i++) {
   option = new Option(classificator[i][0], classificator[i][0]);
   options.add(option);
  }
 }
 update();
}

// ��������� ���� "����"

function fillTheme(projectIndex){
 var i, option;

// ������� ������
 var themeSel     = document.all('theme');
 while (themeSel.options.length!=0) themeSel.options.remove(0);
 option = new Option('-- ��� --', 'all');
 themeSel.options.add(option);

// ���������� ������ ���

 if (projectIndex) {
  themeSel.disabled = false;
 }
 else {
  themeSel.selectedIndex = 0;
  themeSel.disabled = true;
  return;
 }

 with (themeSel) {
  for (i=1; i<classificator[projectIndex-1].length; i++) {
   option = new Option(classificator[projectIndex-1][i], classificator[projectIndex-1][i]);
   options.add(option);
  }
 }
}

// �������� ������� ����������

function changeSort(newSort, newOrder){
 sort  = newSort;
 order = newOrder;
 update();
}

// ��������� ������

function update(){
 with (document.all('project'))  {project  = options[selectedIndex].value;}
 with (document.all('theme'))    {theme    = options[selectedIndex].value;}
 with (document.all('interval')) {interval = options[selectedIndex].value;}
 context = document.all('context').value;

 var url = 'list.asp';

 url += '?sort='  + sort;
 url += '&order=' + order;

 if (theme!='all')    url += '&theme=' + theme;
 if (project!='all')  url += '&project=' + project;
 if (interval!='all') url += '&interval=' + interval;
 if (context)         url += '&context=' + escape(context);

 top.frames.list.location.replace(url);
}

</script>

</head>


<body 
 class="panel"
 onload="onLoad()"
>

<TABLE cellpadding=6 border=0>
<TR>
<TD>

<table>

<tr title="������, � �������� ��������� �����������">
<td>
������
</td>

<td>
<select 
 id="project"
 onchange="fillTheme(selectedIndex); update();"
 >
</select>

</td>
</tr>

<tr title="���� �����������">
<td>
����
</td>

<td>
<select 
 id="theme"
 onchange="update();"
 disabled
 >
<option value='all' selected>-- ��� --</option>
</select>
</td>

</table>

</TD>
<TD>

<table>

<tr title="���� ����������� �����������">
<td>
��������
</td>

<td>
<select 
 id="interval"
 onchange="update();"
 >
<option value='all' selected>-- ��� --</option>

<%
var d = new Date();

function toCQString(d){
 d = new Date(d);
 var s = d.getYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate();
 return s;
}
%>

<option value='<%=toCQString(d.setDate(d.getDate()-7))%>'>
������</option>

<option value='<%=toCQString(d.setDate(d.getDate()-14))%>'>
��� ������</option>

<option value='<%=toCQString(d.setMonth(d.getMonth()-1))%>'>
�����</option>

<option value='<%=toCQString(d.setMonth(d.getMonth()-3))%>'>
3 ������</option>

<option value='<%=toCQString(d.setMonth(d.getMonth()-6))%>'>
�������</option>

<option value='<%=toCQString(d.setYear(d.getYear()-1))%>'>
���</option>

</select>
</td>
</tr>

<tr title="�������� ������ ��������� ��������� �����..">
<td>
��������
</td>

<td>
<input type="text"
 id="context"
 style="width:180px;"
 onchange="update();"
 onkeypress="if (event.keyCode==13) update();"
 >
</td>
</tr>

</table>

</TD>
</TR>
</TABLE>


</body>
</html>
