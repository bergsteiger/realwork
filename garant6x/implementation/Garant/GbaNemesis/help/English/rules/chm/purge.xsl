<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet 
 version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:msxsl="urn:schemas-microsoft-com:xslt"
 exclude-result-prefixes="msxsl"
>

<xsl:import href="..//common//identity.xsl"/> 

<!--
��⠢�塞 � ���, ����� ����� ����樨 ��� 
�� ����� ���⥩��஬.
-->

<xsl:template match="form">
 <xsl:if test=".//operation or (@container=0)">
  <xsl:copy>
   <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
 </xsl:if>
 
</xsl:template>


<!--
�����㥬 ⮫쪮 � ��魮��, ����� ����� ��� �� ���� ������.
-->

<xsl:template match="entity">
 <xsl:if test="operations/operation">
  <xsl:copy-of select="."/>
 </xsl:if>
</xsl:template>

</xsl:stylesheet>
