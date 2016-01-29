<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output 
 encoding="windows-1251" 
 doctype-public="-//IETF//DTD HTML//EN"
/>

<xsl:template match="/">
<HTML>
<BODY>
<OBJECT type="text/site properties">
 <param name="Window Styles" value="0x800227"/>
 <param name="Font" value="Arial,8,204"/>
</OBJECT>

<UL>
<xsl:apply-templates select="help/topic"/>
</UL>

</BODY></HTML>

</xsl:template>

<!-- TEMPLATES -->

<xsl:template match="topic">

<!-- Преобразование для топиков, у которых нет дочерних топиков -->
<!-- условие not(@cnt='hide') нужно для скрытия из раздела  
Справочник страниц с описаниями Элементов и Команд. (CQ 27758)  -->


  <xsl:if test="not(topic) and not(@cnt='hide')">             
    <LI> <OBJECT type="text/sitemap">
         <param name="Name" value="{child::h3[1]}"/>
         <param name="Local" value="page-{@id}.htm"/>
        </OBJECT>
    </LI>
  </xsl:if>
  
  <xsl:if test="topic and not(@cnt='hide')">
    <LI> <OBJECT type="text/sitemap">
         <param name="Name" value="{child::h3[1]}"/>
         <param name="Local" value="page-{@id}.htm"/>
        </OBJECT>

        <UL>
          <xsl:apply-templates select="topic"/>
        </UL>  
    </LI>

  </xsl:if>
  
</xsl:template>

</xsl:stylesheet>