<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output 
 method="xml"
 encoding="UTF-8"
 indent="yes"
/>

<xsl:template match="@*|node()">
 <xsl:copy>
  <xsl:apply-templates select="@*|node()"/>
 </xsl:copy>
</xsl:template>


<xsl:variable name="today" select="document('curdate.xml')/today"/>

<xsl:template match="/">
  <xsl:apply-templates select="root"/>
</xsl:template>

<xsl:template match="operation">
  <xsl:copy>
  <xsl:apply-templates select="@*|node()"/>
  <xsl:if test="not(result_list[@date=$today/@date and @build=$today/@build]) and 
		ancestor::pc/@name=$today/@pc">
    <result_list>
      <xsl:attribute name="date">
        <xsl:value-of select="$today/@date"/>
      </xsl:attribute>
      <xsl:attribute name="build">
        <xsl:value-of select="$today/@build"/>
      </xsl:attribute>
      <xsl:attribute name="avg_delay">0</xsl:attribute>
    </result_list>
  </xsl:if>
</xsl:copy>
</xsl:template>

<xsl:template match="result">
<xsl:copy-of select="."/>
</xsl:template>

</xsl:stylesheet>