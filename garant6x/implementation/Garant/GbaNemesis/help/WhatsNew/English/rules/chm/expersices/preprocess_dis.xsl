<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet 
 version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:msxsl="urn:schemas-microsoft-com:xslt"
 exclude-result-prefixes="msxsl"
>

<xsl:import href="..//common//identity.xsl"/> 

<!-- убираем секции <controls> -->

<xsl:template match="application/modules/module/forms/form/controls|application/modules/module/forms/form/entities/entity/controls">
</xsl:template>


<!--
Оставляем только те формы, которые имеют операции или
не являются контейнером.
-->

<xsl:template match="form">
 <xsl:if test=".//operation or (@container=0)">
  <xsl:copy>
   <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
 </xsl:if>
</xsl:template>


<!-- 
Добавляем к операциям, сущностям и формам 
атрибуты m (модуль) и p (предок второго уровня, 
может быть сущностью, формой или модулем). 
Для операций модуля p тождественно m.
-->

<xsl:template match="operation | entity | usertypes/usertype">

<!-- Вручную исключаем некоторые VCM-объекты. 

@id!='' and

-->

<xsl:variable name="test">
    <xsl:choose>
       <xsl:when test="name()='operation'">
        <xsl:value-of select="../../@id"/>-<xsl:value-of select="@id"/>
       </xsl:when>

       <xsl:when test="name()='entity'">
        <xsl:value-of select="ancestor::module[1]/@id"/>-<xsl:value-of select="@id"/>
       </xsl:when>

       <xsl:otherwise>
        <xsl:value-of select="@id"/>
       </xsl:otherwise>
    </xsl:choose>
</xsl:variable>

 <xsl:if test="(name()!='entity' or operations/operation) and 
         @title!='' and 
         @id!='opDefaultAction' and 
         @id!='opInfo' and
         @id!='utSingleSearch' and
         @id!='slqtPostingOrder' and
         @id!='utqcPostingOrder' and
	 @id!='SubPanelSettings'and
	 @id!='opShow' and
         @id!='opShowInfo' and
	 @id!='enResults' and
	 @id!='slqtOldFilters' and
	 @id!='utAdmin' and
	 @id!='opExportToXML' and
	 @id!='opOpenWithLawSupport' and
	 @id!='utqcSearchMachine' and
         @id!='slqtWithLawSupport' and
	 @id!='slqtConsult' and
         @id!='opShowSpecial' and
	 $test!='mo_Folders-enFile'">
   

<!-- Копируем только те сущности, которые имеют хотя бы одну операцию. -->

   <xsl:copy>
  
     <xsl:attribute name="m">
      <xsl:value-of select="ancestor::module[1]/@id"/>
     </xsl:attribute>
     <xsl:attribute name="f">
      <xsl:value-of select="ancestor::form[1]/@id"/>
     </xsl:attribute>
     <xsl:attribute name="p">
      <xsl:value-of select="../../@id"/>
     </xsl:attribute>

     <xsl:attribute name="key">
      <xsl:choose>
       <xsl:when test="name()='operation'">
        <xsl:value-of select="../../@id"/>-<xsl:value-of select="@id"/>
       </xsl:when>

       <xsl:when test="name()='entity'">
        <xsl:value-of select="ancestor::module[1]/@id"/>-<xsl:value-of select="@id"/>
       </xsl:when>

       <xsl:otherwise>
        <xsl:value-of select="@id"/>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:attribute>
                                                                        

<!--    <xsl:if test="(ancestor::module[1]/@id = 'mo_Folders' and @id = 'enFile')">
    <xsl:attribute name="test">
      Yep
     </xsl:attribute>
     </xsl:if>

-->
   <!-- Исключаем выливку некоторых объектов -->


       <xsl:apply-templates select="@*|node()"/>
   </xsl:copy>

 </xsl:if>

</xsl:template>

</xsl:stylesheet>
