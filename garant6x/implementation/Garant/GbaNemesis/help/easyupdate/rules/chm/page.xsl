<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="..//common//identity.xsl"/> 

<xsl:output 
 method="html"
 encoding="windows-1251"
 indent="yes"
/>

<xsl:template match="topic">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251"></meta>

<title><xsl:value-of select="@title"/></title>

 <link rel="stylesheet" type="text/css" href="help.css"/>
 <script src="help.js"/>

 <xsl:apply-templates select="head/*"/>

</head>

<body>
<xsl:apply-templates select="kw"/>

<table width="100%" height="100%" cellpadding="0" cellspacing="0">
<tr><td valign="top" height="1%">

<table class="hf" cellspacing="0" cellpadding="2">
<tr class="blue">
 <td align="left"  nowrap="true">
  <img src="help/flag10x6anim.gif" align="absmiddle"/>
  <span 
   class="hf"
   id="versionInfo"
  >
   ГАРАНТ Платформа F1 ЭКСПЕРТ. <xsl:value-of select="/help/@title"/>
  </span>
 </td>
 <td align="right" nowrap="true">
  <xsl:for-each select="ancestor::topic">
   <a class="hf" href="page-{@id}.htm" title="Перейти к этому разделу">
    <xsl:value-of select="@title"/>
   </a>
   <xsl:if test="position()!=last()">&#187;</xsl:if>
  </xsl:for-each>
 </td>
</tr>
</table>

<h1 align="right"
 onclick="clipboardData.setData('Text', '&lt;com id=&quot;{@id}&quot;/&gt;')"
>

 <xsl:if test="not(@title_ext)">
  <xsl:value-of select="@title"/>
 </xsl:if>

 <xsl:if test="@title_ext">
  <xsl:value-of select="@title_ext"/>
 </xsl:if>

 <xsl:variable name="currentver" select="concat(/help/application/@versionmajor, '.', /help/application/@versionminor)"/>

 <xsl:if test="@ver=$currentver">
  <br/><small>[новое в версии <xsl:value-of select="@ver"/>]</small>
 </xsl:if>

</h1>


<!--

<script>
function savePage(){
 document.execCommand('SaveAs', 'true', document.title);
}

function printPage(){
 window.print();
}

function addPage(){
 window.external.AddFavorite(location.href, document.title);
}


function exportPage(){
 var word = new ActiveXObject("Word.Application");
 word.Application.Visible = true;
 var doc=word.Documents.Add();
 window.document.execCommand('SelectAll');
 window.document.execCommand('Copy');
 word.Selection.Paste();
}

function sendPage(){
}

</script>

 <div style="text-align:right;">
 <div 
  class="toolbarT"
  onmouseover="var e=event.srcElement;if(e.tagName=='SPAN') e.className=(event.type=='mouseover')?'outset':''" 
  onmouseout = "this.onmouseover()"
 >
  <span 
   title="Сохранить на диск"
   style="background-image: url(help/save.gif);"
   onclick="savePage()"
  />
  <span 
   title="Распечатать текущую страницу"
   style="background-image: url(help/printer16.gif);"
   onclick="printPage()"
  />
  <span 
   title="Экспорт в MS Word"
   style="background-image: url(help/winword.gif);"
   onclick="exportPage()"
  />

  <span 
   title="Добавить в избранное"
   style="background-image: url(help/favadd.gif);"
   onclick="addPage()"
  />

  <span 
   title="Переслать по почте"
   style="background-image: url(help/sendby.gif);"
   onclick="sendPage()"
  />

 </div>
 </div>

-->

<!--
<br2/>
<h6 align="right"><xsl:value-of select="@id"/></h6>
-->


</td></tr>

<tr><td class="text" valign="top" height="*">

 <xsl:apply-templates select="text/*"/>

</td></tr>

<tr><td valign="bottom" height="1%">

<table class="hf" cellspacing="0" cellpadding="2">
<tr class="blue">
    <td align="left"  nowrap="true">
     <a class="hf" title="Показать подробную информацию о компании" href="page-intro-contacts.htm">
      &#169; 2008 Гарант-Сервис
     </a>
    </td>
    <td align="right" nowrap="true">
     <a class="hf" title="Создать почтовое сообщение для компании-разработчика" href="mailto:info@garant.ru">info@garant.ru</a>&#160;|
     <a class="hf" title="Открыть сайт компании-разработчика" href="http://www.garant.ru" target="_blank">www.garant.ru</a>
    </td>
</tr>
</table>

</td></tr>
</table>

</body> 
</html>

</xsl:template>

<!-- Аннотации к разделам -->

<xsl:template match="annotations">
 <xsl:for-each select="/help/topic[annotation]">
   <h3>
    <a href="page-{@id}.htm">
     <xsl:value-of select="@title"/>
    </a>
   </h3>
  <xsl:copy-of select="annotation/*"/>
 </xsl:for-each>
</xsl:template>

<xsl:template match="text//annotation">
 <xsl:copy-of select="../../annotation"/>
</xsl:template>

<!-- Текст -->

<xsl:template match="p">
 <p>
  <xsl:apply-templates/>
 </p>
</xsl:template>


<xsl:template match="p[@style]">
 <xsl:choose>
   <xsl:when test="@style='img'">
    <img src="icon_nonvcm/{@src}" style="float:left;cursor:help;" title="Изображение объекта, которое упоминается в данном абзаце"/>
  </xsl:when>
  <xsl:when test="@style='attn'">
    <img src="help/warning.gif" style="float:left;cursor:help;" title="Важные сведения"/>
  </xsl:when>
  <xsl:when test="@style='note'">
   <img src="help/page.gif" style="float:left;cursor:help;" title="Примечание"/>
  </xsl:when>
  <xsl:when test="@style='debug'">
   <img src="help/man.gif" style="float:left;cursor:help;" title="Служебное сообщение отладочной версии справочной системы"/>
  </xsl:when>
  <xsl:when test="@style='see'">
   <img src="help/book.gif" style="float:left;cursor:help;" title="Ссылки на страницы Руководства, посвященные данной тематике"/>
  </xsl:when>
 </xsl:choose>

 <p class="{@style}">
  <xsl:if test="@style='see'">
    Ссылки по теме:<br/><br/>
  </xsl:if>
  <xsl:if test="@style='debug'">
    Примечание разработчика справочной системы:<br/><br/>
  </xsl:if>
  <xsl:apply-templates/>
 </p>
</xsl:template>


<xsl:template match="p[@ver]">
  <div class="newFeature">
    [Новое в вер. <xsl:value-of select="@ver"/>]<br/>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<!-- Картинки -->

<xsl:key name="screens" match="//topic//screen[not(@summary)]" use="@src"/>

<xsl:template match="screen" name="screen">
 <table width="95%" cellpadding="0" cellspacing="0">
 <tr>
 <td width="350px">
 <img align="left">
  <xsl:attribute name="id">image<xsl:number level="any"/></xsl:attribute>

  <xsl:attribute name="src">screenshot/<xsl:value-of select="@src"/></xsl:attribute>

  <xsl:if test="@nopreview">
    <xsl:attribute name="src">screenshot/<xsl:value-of select="@src"/></xsl:attribute>
    <xsl:attribute name="title">[Изображение показано в натуральную величину]</xsl:attribute>
  </xsl:if>

  <xsl:if test="not (@nopreview)">
    <xsl:attribute name="width">300</xsl:attribute>
    <xsl:attribute name="class">screenshot</xsl:attribute>
    <xsl:attribute name="src">screenshot/<xsl:value-of select="@src"/></xsl:attribute>
    <xsl:attribute name="title">Нажмите, чтобы открыть полноразмерную иллюстрацию в отдельном окне</xsl:attribute>
    <xsl:attribute name="onclick">showImage(this.id + 'L',<xsl:number level="any"/>)</xsl:attribute>
    <xsl:attribute name="onmouseover">this.className='screenshotBorder'</xsl:attribute>
    <xsl:attribute name="onmouseout">this.className='screenshot'</xsl:attribute>
  </xsl:if>

 </img>

 <img class="screenshotL" src="screenshot/{@src}">
  <xsl:attribute name="id">image<xsl:number level="any"/>L</xsl:attribute>
  <xsl:attribute name="alt"><xsl:value-of select="@title"/></xsl:attribute>
 </img>

 </td>
 <td valign="top" align="left">
  <xsl:if test="not(@summary)">
   <b>Рис. <xsl:number level="any"/></b><br/>
  </xsl:if>
  <xsl:value-of select="@title"/>
 </td>
 </tr>
 </table>
 <p/>

 <xsl:if test="@summary">
  <xsl:for-each select="key('screens', @src)">
   <p/><a href="page-{ancestor::topic[1]/@id}.htm">
    <xsl:value-of select="ancestor::topic[1]/@title"/>
   </a>
   <br/>
   <xsl:value-of select="@title"/>
  </xsl:for-each>
 </xsl:if>

</xsl:template>










<xsl:template match="screen_below" name="screen_below">
 <table width="270" align="center" cellpadding="0" cellspacing="0">
 <tr>
 <td align="center"> 
 <img>
  <xsl:attribute name="id">image<xsl:number level="any"/></xsl:attribute>

  <xsl:attribute name="src">screenshot/preview_<xsl:value-of select="@src"/></xsl:attribute>

  <xsl:if test="@nopreview">
    <xsl:attribute name="src">screenshot/<xsl:value-of select="@src"/></xsl:attribute>
    <xsl:attribute name="title">[Изображение показано в натуральную величину]</xsl:attribute>
  </xsl:if>

  <xsl:if test="not (@nopreview)">
    <xsl:attribute name="class">screenshot</xsl:attribute>
    <xsl:attribute name="src">screenshot/preview_<xsl:value-of select="@src"/></xsl:attribute>
    <xsl:attribute name="title">Нажмите, чтобы открыть полноразмерную иллюстрацию в отдельном окне</xsl:attribute>
    <xsl:attribute name="onclick">showImage(this.id + 'L')</xsl:attribute>
    <xsl:attribute name="onmouseover">this.className='screenshotBorder'</xsl:attribute>
    <xsl:attribute name="onmouseout">this.className='screenshot'</xsl:attribute>
  </xsl:if>

 </img>

 <img class="screenshotL" src="screenshot/{@src}">
  <xsl:attribute name="id">image<xsl:number level="any"/>L</xsl:attribute>
 </img>
 </td>
 </tr>
<tr>
 <td align="center" valign="top" >
  <xsl:if test="not(@summary)">
   <b>Рис. <xsl:number level="any"/></b><br/>
  </xsl:if>
  <xsl:value-of select="@title"/>
 </td>
 </tr>
 </table>
   

 <xsl:if test="@summary">
  <xsl:for-each select="key('screens', @src)">
   <p/><a href="page-{ancestor::topic[1]/@id}.htm">
    <xsl:value-of select="ancestor::topic[1]/@title"/>
   </a>
   <br/>
   <xsl:value-of select="@title"/>
  </xsl:for-each>
 </xsl:if>

</xsl:template>


<!-- конец обработки изображения -->


<xsl:template match="kw">
 <a>
  <xsl:attribute name="name"><xsl:number count="kw" level="any"/></xsl:attribute>
 </a>
</xsl:template>

<xsl:template match="br2">
 <br/><br/>
</xsl:template>

<xsl:template match="btn">
 <span class="btn" title="Кнопка">
 <xsl:value-of select="."/>
 </span>
</xsl:template>


<xsl:template match="kbd">
 <span class="kbd" title="Горячие клавиши для вызова команды">
  <xsl:choose>
  
   <xsl:when test="@key='larr'"><img src="help/{@key}.gif"/></xsl:when>
   <xsl:when test="@key='uarr'"><img src="help/{@key}.gif"/></xsl:when>
   <xsl:when test="@key='rarr'"><img src="help/{@key}.gif"/></xsl:when>
   <xsl:when test="@key='darr'"><img src="help/{@key}.gif"/></xsl:when>

   <xsl:when test="@key='back'"><img src="help/larr.gif"/> Backspace</xsl:when>
   <xsl:otherwise>
    <xsl:value-of select="."/>
   </xsl:otherwise>
  </xsl:choose>
 </span>
</xsl:template>

<xsl:template match="sel">
 <span class="sel">
  <xsl:apply-templates/>
 </span>
</xsl:template>

<xsl:template match="comment">
</xsl:template>

<xsl:template match="hint">
 <acronym class="hint" title="{.}" onclick="alert(this.title)"><xsl:value-of select="@title"/></acronym>
</xsl:template>

<xsl:template match="hintn">
 <acronym class="hint" title="{normalize-space(.)}" onclick="alert(this.title)"><xsl:value-of select="@title"/></acronym>
</xsl:template>

<xsl:template match="com">

 <xsl:variable name="topic" select="/help//topic[@id=current()/@id]"/>

 <xsl:if test="not($topic)">
  <b>[страница отсутствует]</b>
 <!--
  <xsl:message terminate="yes">
    Топик с id="<xsl:value-of select="@id"/>"
    не найден.
  </xsl:message>
 -->
 </xsl:if>

 <a href="page-{@id}.htm{@a}" title="{@hint}">
   <xsl:if test="not(@parent)">
    <xsl:call-template name="hlink">
     <xsl:with-param name="topic" select="$topic"/>
    </xsl:call-template>
   </xsl:if>

   <xsl:if test="@parent">
    <xsl:variable name="elements" select="/help/application/modules/module[@id=substring-before(current()/@id, '-')]//*[@id=substring-after(current()/@id, '-')]"/>
    <xsl:call-template name="hlink">
     <xsl:with-param name="topic" select="$elements[../../@id=current()/@parent]"/>
    </xsl:call-template>
   </xsl:if>
 </a>

</xsl:template>

<xsl:template name="hlink">
 <xsl:param name="topic"/>
 <xsl:variable name="atitle" select="$topic//a[concat('#', @name)=current()/@a]/@title"/>

 <xsl:choose>
  <xsl:when test="@icon='no'">
  </xsl:when>
  <xsl:when test="$topic/@icon">
   <img src="icon/{$topic/@icon}"/>
  </xsl:when>
  <xsl:when test="@icon='tab'">
   <img src="help/empty16px.gif"/>
  </xsl:when>
 </xsl:choose>

 <xsl:choose>
  <xsl:when test="@title">
   <xsl:value-of select="@title"/>
  </xsl:when>
  <xsl:when test="@a and $atitle">
   <xsl:value-of select="$atitle"/>
  </xsl:when>
  <xsl:otherwise>
   <xsl:value-of select="$topic/@title"/>
  </xsl:otherwise>
 </xsl:choose>

</xsl:template>


</xsl:stylesheet>

