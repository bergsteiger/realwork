<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:import href="..//common//identity.xsl"/> 


<xsl:template match="resource">
 <xsl:copy-of select="document('vcm.xml')"/>
</xsl:template>

</xsl:stylesheet>