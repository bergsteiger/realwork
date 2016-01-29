<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="..//common//identity.xsl"/> 

<xsl:output method="text"/> 

<xsl:template match="help">
[OPTIONS]
Title=<xsl:value-of select="@title"/>
Compiled file=<xsl:value-of select="@filename"/>.chm
Contents file=<xsl:value-of select="@filename"/>.hhc
Index file=<xsl:value-of select="@filename"/>.hhk
Binary Index=No
Compatibility=1.1 or later
Default Font=MS Sans Serif,8,204
Default Window=Main
Default topic=page-0.htm
Display compile progress=Yes
Enhanced decompilation=Yes
Full-text search=Yes
Language=0x419 Russian
Error log file=help.log

[WINDOWS]
Main="<xsl:value-of select="@title"/>","<xsl:value-of select="/help/@filename"/>.hhc","<xsl:value-of select="/help/@filename"/>.hhk","page-main.htm","page-main.htm",,,,,0x2020,,0x0,[20,15,750,570],0xc0000,0x400,,1,,,0
</xsl:template>                                                                                  
</xsl:stylesheet>