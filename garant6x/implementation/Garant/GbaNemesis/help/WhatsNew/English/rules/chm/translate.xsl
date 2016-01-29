<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="..//common//identity.xsl"/> 


<xsl:output 
 method="html"
 encoding="windows-1251"
 indent="yes"
/>


<!-- Преобразуем <topic(id, title)> в <div(id, class=topic)><h3(class=topic, title)> -->

<xsl:template match="topic">
	<topic>
	<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
	<a>
	<xsl:attribute name="name"><xsl:value-of select="@id"/></xsl:attribute>
	<xsl:attribute name="style">topic</xsl:attribute>
	</a>
	<h3>
		<xsl:attribute name="class">topic</xsl:attribute>
		<xsl:value-of select="@title"/>
	</h3>
	<xsl:if test="annotation">
		<annotation>
			<xsl:copy-of select="annotation/*"/>
		</annotation>
	</xsl:if>		
	<xsl:apply-templates select="text/*"/>
	<hr/>
<!-- Для вложенных топиков -->
	<xsl:if test="topic">
		<xsl:apply-templates select="topic"/>
	</xsl:if>
	</topic>
</xsl:template>


<!-- Описания элементов справочника -->

<xsl:template match="description">

<!-- Условие, которое исключает из файла для переводчика описания неактивных в английской версии элементов Справочника -->
	<xsl:if test="not(/help/excludeddsc/com[@id=current()/@id]) and @id!=''">
	<description>
		<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
		<h3>
			<xsl:value-of select="(/help/application/modules/module/forms/form/entities/entity/operations/operation|
								  /help/application/modules/module/forms/form/entities/entity|
								  /help/application/modules/module/forms/form/usertypes/usertype|
								  /help/application/modules/module/operations/operation)[@key=current()/@id]/@title"/>
		</h3>
		(<font>
			<xsl:attribute name="class">description</xsl:attribute>
			<xsl:attribute name="color">#808080</xsl:attribute>
			<xsl:value-of select="@ann"/>
			</font>)
		<xsl:apply-templates/>
		<hr/>
	</description>
	</xsl:if>	
</xsl:template>


<!-- Текст -->

<xsl:template match="p">
 <p>
   <xsl:if test="@style">
   <xsl:attribute name="style"><xsl:value-of select="@style"/></xsl:attribute>
  </xsl:if>
  <xsl:apply-templates/>
 </p>
</xsl:template>

<!-- Картинки -->
<!-- Преобразуем <screen(src, title)> в <div(id=src, class="screen")><span(id=src)> -->

<xsl:template match="screen" name="screen">
<screen>
	<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
	<xsl:if test="@nopreview">
    	<xsl:attribute name="nopreview"><xsl:value-of select="@nopreview"/></xsl:attribute>
  	</xsl:if>
	
 <table width="95%" cellpadding="0" cellspacing="0">
 <tr>
 <xsl:text>&#10;</xsl:text>
 <td width="350px">
 	<img align="left">
  	<xsl:attribute name="id">image<xsl:number level="any"/></xsl:attribute>
  	<xsl:attribute name="src">screenshot/<xsl:value-of select="@src"/></xsl:attribute>
  	<xsl:attribute name="width">300</xsl:attribute>
 	</img>
 </td>
 <xsl:text>&#10;</xsl:text>
 <td valign="top" align="left">
  <xsl:if test="not(@summary)">
   <b>Picture <xsl:number level="any"/></b><br/>
  </xsl:if>
  <div>
  <xsl:attribute name="style"><xsl:value-of select="topic"/></xsl:attribute>
  <xsl:value-of select="@title"/>
  </div>
 </td>
 </tr>
 </table>
 <p/>
</screen>
</xsl:template>


<!-- Оформление -->

<xsl:template match="btn|kbd|sel">
<xsl:copy>
<font>
<xsl:attribute name="color">#009933</xsl:attribute>
	<xsl:value-of select="."/>
</font>
</xsl:copy>
</xsl:template>

<xsl:template match="comment">
</xsl:template>

<xsl:template match="hint|hintn">
<xsl:copy>
	<font>
		<xsl:attribute name="color">#009933</xsl:attribute>
		<xsl:value-of select="@title"/>
	</font>
	(<font>
		<xsl:attribute name="color">#808080</xsl:attribute>
		<xsl:value-of select="."/>
	</font>)
</xsl:copy>
</xsl:template>

<!-- Ссылки -->

<xsl:template match="com">
	<xsl:variable name="topic" select="/help//topic[@id=current()/@id]"/>
	<xsl:copy>
		<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
		<a href="#{@id}" title="Cсылка на топик {@id}">
		<font>
			<xsl:attribute name="color">#0000ff</xsl:attribute>
			<xsl:call-template name="hlink">
   				<xsl:with-param name="topic" select="$topic"/>
			</xsl:call-template>
		</font>
		</a>
	</xsl:copy>
</xsl:template>

<!--
 <xsl:if test="not($topic)">
  <b>[страница отсутствует]</b>
 </xsl:if>
-->
<!--
 <a href="page-{@id}.htm{@a}" title="{/help/descriptions/description[@id=current()/@id]/@ann}">
  <xsl:call-template name="hlink">
   <xsl:with-param name="topic" select="$topic"/>
  </xsl:call-template>
 </a>

</xsl:template>
-->


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
  <xsl:when test="not($topic)">
  	<xsl:value-of select="(/help/application/modules/module/forms/form/entities/entity/operations/operation|
  						   /help/application/modules/module/forms/form/entities/entity|
						  /help/application/modules/module/forms/form/usertypes/usertype|
						  /help/application/modules/module/operations/operation)[@key=current()/@id]/@title"/>
  </xsl:when>
  <xsl:otherwise>
   <xsl:value-of select="$topic/@title"/>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- Убираем из документа для переводчика служебную информацию по VCM -->
<xsl:template match="application">
<resource/>
</xsl:template>
<xsl:template match="excludeddsc">
</xsl:template>

</xsl:stylesheet>
