<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet 
 version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:msxsl="urn:schemas-microsoft-com:xslt"
 exclude-result-prefixes="msxsl"
>

<xsl:import href="..//common//identity.xsl"/> 

<!--
Ћбв ў«пҐ¬ вҐ д®а¬л, Є®в®алҐ Ё¬Ґов ®ЇҐа жЁЁ Ё«Ё 
­Ґ пў«повбп Є®­вҐ©­Ґа®¬.
-->

<xsl:template match="form">
 <xsl:if test=".//operation or (@container=0)">
  <xsl:copy>
   <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
 </xsl:if>
 
</xsl:template>


<!--
Љ®ЇЁагҐ¬ в®«мЄ® вҐ бгй­®бвЁ, Є®в®алҐ Ё¬Ґов е®вп Ўл ®¤­г ®ЇҐа жЁо.
-->

<xsl:template match="entity">
 <xsl:if test="operations/operation">
  <xsl:copy-of select="."/>
 </xsl:if>
</xsl:template>

</xsl:stylesheet>
