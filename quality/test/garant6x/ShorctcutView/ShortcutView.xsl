<?xml version="1.0" encoding="windows-1251"?>

<xsl:stylesheet 
 version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:msxsl="urn:schemas-microsoft-com:xslt"
 exclude-result-prefixes="msxsl"
>

<xsl:template match="form">

	<form>
	<xsl:if test="@title != ''">
	<li>
		<xsl:value-of select="@title"/> :    
		<xsl:apply-templates select="entities"/>
	</li>
	</xsl:if>
	</form>			

</xsl:template>
<xsl:template match="entities">
		<entities>
		<ul>
		<xsl:value-of select="@title"/>
		<xsl:apply-templates select="entity"/>
		</ul>
		</entities>
</xsl:template>
<xsl:template match="entity">
		<entity>
		<li>
		<xsl:value-of select="@title"/>
		<xsl:apply-templates select="operations"/>
		</li>
		</entity>
</xsl:template>

<xsl:template match="operations">
		<operations>
		<ul>
		<xsl:value-of select="@title"/>
		<xsl:apply-templates select="operation"/>
		</ul>
		</operations>
</xsl:template>

<xsl:template match="operation">
	<operation>
	<xsl:if test="@shortcut != ''">
	<li>
		<b>
		<font color="green">
			<xsl:value-of select="@shortcut"/>(<xsl:value-of select="@title"/>); <xsl:text> </xsl:text>
		</font>
		</b>
	</li>
	</xsl:if>
	</operation>

</xsl:template>
</xsl:stylesheet >
