<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output 
 encoding="windows-1251" 
 doctype-public="-//IETF//DTD HTML//EN"
/>

<xsl:key name="kws" match="//topic/kw | //text/kw" use="string(@name)"/>

<xsl:template match="/">
<HTML>
<BODY>
<OBJECT type="text/site properties">
 <param name="Window Styles" value="0x800227"/>
 <param name="Font" value="Arial,8,204"/>
</OBJECT>

<xsl:variable name="unique_kw"
 select="(//topic/kw | //text/kw)[generate-id(.)=generate-id(key('kws', @name))]/@name"
/>

<UL>

<xsl:for-each select="$unique_kw">
 <xsl:sort select="."/>

 <LI> <OBJECT type="text/sitemap">
       <param name="Name" value="{.}"/>
       <xsl:for-each select="key('kws', .)">
        <param name="Name">
          <xsl:attribute name="value"><xsl:value-of select="ancestor-or-self::topic[1]/@title"/>, <xsl:value-of select="@name"/></xsl:attribute>
        </param>
        <param name="Local">
          <xsl:attribute name="value">page-<xsl:value-of select="ancestor-or-self::topic[1]/@id"/>.htm#<xsl:number count="kw" level="any"/></xsl:attribute>
        </param>
       </xsl:for-each>

     </OBJECT>
  </LI>

</xsl:for-each>

</UL>

</BODY></HTML>

</xsl:template>


</xsl:stylesheet>

