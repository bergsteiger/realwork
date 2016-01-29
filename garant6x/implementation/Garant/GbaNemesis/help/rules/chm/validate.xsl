<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet 
 version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:msxsl="urn:schemas-microsoft-com:xslt"
>
<xsl:import href="..//common//identity.xsl"/> 

<!--                                  -->
<!--  Проверка ссылочной целостности  -->
<!--                                  -->

<xsl:template match="help">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ru" lang="ru">

<head>
 <meta http-equiv="content-type" content="text/xml; charset=windows-1251" />
</head>

<body>
   <h2>Не найдены топики:</h2><br/>
   <p>(В data.xml есть <b>com</b>-ссылки на описание элемента, но в файл-справку страница для данного элемента не приезжает, т.к. отсутствует в nemesis.xml и ссылки идут на отсутствующую страницу)</p>
   <xsl:apply-templates select="//com"/>
  
   <h2>Описания без корреспондентов:</h2>
   <p>(В data.xml есть <b>description</b>-описание элемента, но в файл-справку страница для данного элемента не приезжает, т.к. отсутствует в nemesis.xml)</p>
   <xsl:apply-templates select="//description"/>
  
   <h2>Объекты без описаний:</h2><br2/>
   <p>(В data.xml отсутствует <b>description</b>-описание элемента, хотя в файле-справке страница для данного элемента формируется, согласно nemesis.xml)</p>
   <xsl:call-template name="nodes"/>

</body>
</html>

</xsl:template>


<xsl:template match="com">
 <xsl:variable name="topic" select="msxsl:node-set(/help//topic[@id=current()/@id])"/>
 <xsl:if test="count($topic)=0">
   <b><xsl:value-of select="@id"/></b><br/><br/>
 </xsl:if>

</xsl:template>


<xsl:template match="description">

 <xsl:variable name="links" select="msxsl:node-set(//*[@key=current()/@id])"/>
 
 <xsl:if test="count($links)=0">
   <b><xsl:value-of select="@id"/></b><br/><br/>
 </xsl:if>
</xsl:template>


<xsl:template name="nodes">
<!-- 
Ввиду того, что согласно http://mdp.garant.ru/pages/viewpage.action?pageId=96483812 
описания элементов будут скрыты, проверять наличие у них описаний - не нужно. 
Т.о., убираем условие "name()='entity' or" из предиката выборки переменной $nodes.
-->

 <xsl:variable name="nodes" select="/help/application/modules/module//node()[name()='usertype' or name()='operation']"/>
  <xsl:for-each select="$nodes">
    <xsl:if test="not(count(//description[@id=current()/@key]) or @alias)">
    <xsl:if test="@key!=''">
     <b><xsl:value-of select="@key"/></b>&#160;<xsl:value-of select="@title"/><br/><br/>
    </xsl:if>
    </xsl:if>
  </xsl:for-each>
</xsl:template>

</xsl:stylesheet>

