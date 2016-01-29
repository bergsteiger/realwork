<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
<xsl:import href="..//common//identity.xsl"/> 
-->

<xsl:output 
 method="xml"
 encoding="windows-1251"
 indent="yes"
/>

<xsl:template match="/">
<help>
<xsl:apply-templates/>
</help>
</xsl:template>


<xsl:template match="node()">
 <xsl:if test="@ver='7.2.0'">

 <xsl:if test="name()!='topic' and name()!='description'">
 <topic>
 <xsl:attribute name="id"><xsl:value-of select="ancestor::topic[1]/@id"/></xsl:attribute>
<text>
  <xsl:copy-of select="."/>
</text>
 </topic>
 </xsl:if>

 <xsl:if test="name()='topic' or name()='description'">
  <xsl:copy-of select="."/>
 </xsl:if>

 </xsl:if>


 <xsl:if test="child::node()">
  <xsl:apply-templates/>
 </xsl:if>


</xsl:template>



</xsl:stylesheet>