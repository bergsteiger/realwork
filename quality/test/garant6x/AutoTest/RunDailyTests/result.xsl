<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output 
 method="text"
 encoding="windows-1251"
/>
<xsl:template match="pc">*ПК <xsl:value-of select="@name"/>*<xsl:apply-templates/></xsl:template>

<xsl:template match="operation">*<xsl:value-of select="@name"/>*<xsl:apply-templates select="result_list[position()>last()-20]"/>
</xsl:template>

<xsl:template match="result_list">
|{metadata:<xsl:value-of select="ancestor::pc/@name"/>.<xsl:value-of select="ancestor::operation/@id"/>_<xsl:value-of select="position()"/>_date}<xsl:value-of select="@date"/>{metadata}|{metadata:<xsl:value-of select="ancestor::pc/@name"/>.<xsl:value-of select="ancestor::operation/@id"/>_<xsl:value-of select="position()"/>_build}<xsl:value-of select="substring(@build,19,3)"/>{metadata}|{metadata:<xsl:value-of select="ancestor::pc/@name"/>.<xsl:value-of select="ancestor::operation/@id"/>_<xsl:value-of select="position()"/>}<xsl:value-of select=" translate(@avg_delay, '.', ',')"/>{metadata}|</xsl:template>
</xsl:stylesheet>

