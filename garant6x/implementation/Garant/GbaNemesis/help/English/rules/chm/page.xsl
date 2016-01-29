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

<!-- Вытаскиваем перевод названия страницы из тэга h3 
т.е. меняем @title на child::h3[@class='topic']

-->


<title><xsl:value-of select="child::h3[@class='topic']"/></title>

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
   title="Program shell extended version: 
   {/help/application/@versionmajor}.{/help/application/@versionminor}.{/help/application/@release}.{/help/application/@build}&#10;&#13;This information could be useful for technical support specialists."
  >
   <xsl:value-of select="/help/application/@title"/>&#160;

<!--<xsl:value-of select="/help/application/@versionname"/> -->

  </span>
 </td>
 <td align="right" nowrap="true">
  <xsl:for-each select="ancestor::topic">
   <a class="hf" href="page-{@id}.htm" title="Open this page">
    <xsl:value-of select="child::h3[@class='topic']"/>
   </a>
   <xsl:if test="position()!=last()">&#187;</xsl:if>
  </xsl:for-each>
 </td>
</tr>
</table>

<h1 align="right"
 onclick="clipboardData.setData('Text', '&lt;com id=&quot;{@id}&quot;/&gt;')"
>
<!-- Коммент на title_ext
 <xsl:if test="not(@title_ext)">
--> 
 
  <xsl:value-of select="child::h3[@class='topic']"/>
 
<!-- Коммент на title_ext
 </xsl:if>

 <xsl:if test="@title_ext">
  <xsl:value-of select="@title_ext"/>
 </xsl:if>
-->
 <xsl:variable name="currentver" select="concat(/help/application/@versionmajor, '.', /help/application/@versionminor)"/>

 <xsl:if test="@ver=$currentver">
  <br/><small>[New <xsl:value-of select="@ver"/>]</small>
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
<h6 onclick="clipboardData.setData('Text', '{@id}')" align="right"><xsl:value-of select="@id"/></h6>
-->


</td></tr>

<tr><td class="text" valign="top" height="*">

 <xsl:apply-templates select="*[not(self::topic or self::h3[@class='topic'] or self::hr)]"/>

</td></tr>

<tr><td valign="bottom" height="1%">

<table class="hf" cellspacing="0" cellpadding="2">
<tr class="blue">
    <td align="left"  nowrap="true">
     <a class="hf" title="About GARANT company" href="page-intro-contacts.htm">
      &#169; 2008 Garant-Service 
     </a>
    </td>
    <td align="right" nowrap="true">
     <a class="hf" title="E-mail us" href="mailto:info@garant.ru">info@garant.ru</a>&#160;|
     <a class="hf" title="Garant on Web" href="http://www.garant.ru" target="_blank">www.garant.ru</a>
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
 <xsl:copy-of select="../../annotation/*"/>
</xsl:template>

<!-- Текст -->

<xsl:template match="p">
 <p>
   <xsl:if test="position()=1 and name(parent::node())='text'" > <!--Первую букву выделяем только для первого абзаца в тексте -->
   <xsl:attribute name="class">first</xsl:attribute>
  </xsl:if>
  <xsl:apply-templates/>
 </p>
</xsl:template>


<xsl:template match="p[@style]">
 <xsl:choose>
   <xsl:when test="@style='img'">
    <img src="icon_nonvcm/{@src}" style="float:left;cursor:help;" title="Изображение объекта, которое упоминается в данном абзаце"/>
  </xsl:when>
  <xsl:when test="@style='attn'">
    <img src="help/warning.gif" style="float:left;cursor:help;" title="Important information"/>
  </xsl:when>
  <xsl:when test="@style='note'">
   <img src="help/page.gif" style="float:left;cursor:help;" title="Note"/>
  </xsl:when>

<!--Prime-->
  <xsl:when test="@style='prime'">
     <a href="page-whatisprime.htm">
     <img title="What is &quot;PRIME&quot;?" style="float:left;cursor:help;" src="icon_nonvcm/prime.gif"/></a>
  </xsl:when>

  <xsl:when test="@style='consult'">
     <a href="page-whatisconsult.htm">
     <img title="What is &quot;Consulting Service&quot;?" style="float:left;cursor:help;" src="icon_nonvcm/consult.gif"/></a>
  </xsl:when>


  <xsl:when test="@style='turbo'">
     <a href="page-whatisturbo.htm">
     <img title="Возможности описанные в этом разделе страницы доступны 
только при работе с программной оболочкой версии &quot;Турбо&quot;. Узнать про особенности 
оболочки системы &quot;ГАРАНТ Платформа F1 Турбо&quot;?" style="float:left;cursor:help;" src="icon_nonvcm/turbo32.gif"/></a>
  </xsl:when>


  <xsl:when test="@style='debug'">
   <img src="help/man.gif" style="float:left;cursor:help;" title="Служебное сообщение отладочной версии справочной системы"/>
  </xsl:when>
  <xsl:when test="@style='see'">
   <img src="help/book.gif" style="float:left;cursor:help;" title="Other pages for this theme"/>
  </xsl:when>
 </xsl:choose>

 <p class="{@style}">
  <xsl:if test="@style='see'">
    See also:<br/><br/>
  </xsl:if>
  <xsl:if test="@style='debug'">
    Developers notes:<br/><br/>
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
    <xsl:attribute name="title">[Image is presented in actual size]</xsl:attribute>
  </xsl:if>

  <xsl:if test="not (@nopreview)">
    <xsl:attribute name="width">300</xsl:attribute>
    <xsl:attribute name="class">screenshot</xsl:attribute>
    <xsl:attribute name="src">screenshot/<xsl:value-of select="@src"/></xsl:attribute>
    <xsl:attribute name="title">Open full-scale picture in a pop-up window</xsl:attribute>
    <xsl:attribute name="onclick">showImage(this.id + 'L',<xsl:number level="any"/>)</xsl:attribute>
    <xsl:attribute name="onmouseover">this.className='screenshotBorder'</xsl:attribute>
    <xsl:attribute name="onmouseout">this.className='screenshot'</xsl:attribute>
  </xsl:if>

 </img>

 <img class="screenshotL" src="screenshot/{@src}">
  <xsl:attribute name="id">image<xsl:number level="any"/>L</xsl:attribute>
  
<!-- Вытаскиваем перевод подписи к картинке из тэга div 
т.е. меняем @title на descendant::div

-->
  
  <xsl:attribute name="alt"><xsl:value-of select="descendant::div"/></xsl:attribute>
 </img>

 </td>
 <td valign="top" align="left">
  <xsl:if test="not(@summary)">
   <b>Picture. <xsl:number level="any"/></b><br/>
  </xsl:if>
  <xsl:value-of select="descendant::div"/>
 </td>
 </tr>
 </table>
 <p/>

 <xsl:if test="@summary">
  <xsl:for-each select="key('screens', @src)">
   <p/><a href="page-{ancestor::topic[1]/@id}.htm">
    <xsl:value-of select="ancestor::topic[1]/h3[@class='topic']/."/>
   </a>
   <br/>
   <xsl:value-of select="@title"/>
  </xsl:for-each>
 </xsl:if>

</xsl:template>


<xsl:template match="kw">
 <a>
  <xsl:attribute name="name"><xsl:number count="kw" level="any"/></xsl:attribute>
 </a>
</xsl:template>

<xsl:template match="br2">
 <br/><br/>
</xsl:template>

<xsl:template match="btn">
 <span class="btn" title="Button">
 <xsl:value-of select="."/>
 </span>
</xsl:template>

<xsl:template match="kbd">
 <span class="kbd" title="Keyboard shortcut">
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
  <xsl:value-of select="child::font[@color='#009933']"/>
 </span>
</xsl:template>

<xsl:template match="comment">
</xsl:template>

<xsl:template match="hint">
<xsl:choose>
	<xsl:when test="@title">
		 <acronym class="hint" title="{.}" onclick="alert(this.title)"><xsl:value-of select="@title"/></acronym>
	</xsl:when>
	<xsl:otherwise>
		 <acronym class="hint" title="{child::font[@color='#808080']}" onclick="alert(this.title)"><xsl:value-of select="child::font[@color='#009933']"/></acronym>
	</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="hintn">
<xsl:choose>
	<xsl:when test="@title">
		 <acronym class="hint" title="{normalize-space(.)}" onclick="alert(this.title)"><xsl:value-of select="@title"/></acronym>
	</xsl:when>
	<xsl:otherwise>
		 <acronym class="hint" title="{normalize-space(child::font[@color='#808080'])}" onclick="alert(this.title)"><xsl:value-of select="child::font[@color='#009933']"/></acronym>
	</xsl:otherwise>
</xsl:choose>

</xsl:template>

<xsl:template match="com">

 <xsl:variable name="topic" select="/help//topic[@id=current()/@id]"/>

 <xsl:if test="not($topic)">
  <b>[page missed]</b>
 <!--
  <xsl:message terminate="yes">
    Топик с id="<xsl:value-of select="@id"/>"
    не найден.
  </xsl:message>
 -->
 </xsl:if>

 <a href="page-{@id}.htm{@a}" title="{/help/descriptions/description[@id=current()/@id]/@ann}">
  <xsl:call-template name="hlink">
   <xsl:with-param name="topic" select="$topic"/>
  </xsl:call-template>
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

<!-- В переводе, "title" присутствует только у описаний (description) из-за чего мы не можем заменить 
блок choose на <xsl:value-of select="descendant::font[@color='#0000ff']"/> 
-->


 <xsl:choose>
  <xsl:when test="$topic/@title">
   <xsl:value-of select="$topic/@title"/>
  </xsl:when>
  <xsl:when test="@a and $atitle">
   <xsl:value-of select="$atitle"/>
  </xsl:when>
  <xsl:otherwise>
   <xsl:value-of select="descendant::font[@color='#0000ff']"/>
  </xsl:otherwise>
 </xsl:choose>
 </xsl:template>

</xsl:stylesheet>

