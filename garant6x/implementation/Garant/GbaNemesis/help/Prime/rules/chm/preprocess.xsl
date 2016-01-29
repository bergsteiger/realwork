<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet 
 version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:msxsl="urn:schemas-microsoft-com:xslt"
 exclude-result-prefixes="msxsl"
>

<xsl:import href="..//common//identity.xsl"/> 

<!-- гЎЁа Ґ¬ бҐЄжЁЁ <controls> -->

<xsl:template match="application/modules/module/forms/form/controls|application/modules/module/forms/form/entities/entity/controls">
</xsl:template>


<!--“аҐ§ Ґ¬ ѓ« ў­®Ґ ¬Ґ­о  -->

<xsl:template match="menu/menuitem">
<xsl:if test="@title!='Поиск' and
        @title!='Документы' and
        @title!='Анализ' and
        @title!='Окна'">
  <xsl:copy>
   <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
 </xsl:if>
</xsl:template>




<!--
  <menuitem title="Џ®ЁбЄ">
  </menuitem>
  <menuitem title="„®Єг¬Ґ­вл">
  </menuitem>
  <menuitem title="Ђ­ «Ё§">
  </menuitem>
  <menuitem title="ЋЄ­ ">
  </menuitem>
-->


<!--
Ћбв ў«пҐ¬ в®«мЄ® вҐ д®а¬л, Є®в®алҐ Ё¬Ґов ®ЇҐа жЁЁ Ё«Ё
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
„®Ў ў«пҐ¬ Є ®ЇҐа жЁп¬, бгй­®бвп¬ Ё д®а¬ ¬ 
 ваЁЎгвл m (¬®¤г«м) Ё p (ЇаҐ¤®Є ўв®а®Ј® га®ў­п, 
¬®¦Ґв Ўлвм бгй­®бвмо, д®а¬®© Ё«Ё ¬®¤г«Ґ¬). 
„«п ®ЇҐа жЁ© ¬®¤г«п p в®¦¤ҐбвўҐ­­® m.
-->

<xsl:template match="operation | entity | usertypes/usertype">

<!-- Љ®ЇЁагҐ¬ в®«мЄ® вҐ бгй­®бвЁ, Є®в®алҐ Ё¬Ґов е®вп Ўл ®¤­г ®ЇҐа жЁо. -->

<!-- ‚агз­го ЁбЄ«оз Ґ¬ ­ҐЄ®в®алҐ VCM-®ЎкҐЄвл. 
         @id!='' and

-->

 <xsl:if test="(name()!='entity' or operations/operation) and 
         @title!='' and 
         @id!='opDefaultAction' and 
         @id!='opInfo' and
         @id!='utEmptyMainWindow' and
         @id!='slqtFilters' and
         @id!='utqfAttributeSearch' and
         @id!='slqtPublishSource' and
         @id!='slqtAttribute' and
         @id!='slqtOldAttribute' and
         @id!='slqtKW' and
         @id!='slqtOldKW' and
         @id!='astOneLevel' and
         @id!='astFirstLevel' and
         @id!='opLoadFromFolder' and
         @id!='opShowTopLevelFrmAct' and
         @id!='opFindFirstSelected' and
         @id!='opSave' and
         @id!='opSaveToFolder' and
         @id!='opSetLeftFloat' and
         @id!='opSetRightFloat' and
         @id!='opSearchType' and
         @id!='en_DefineSearchDate' and
         @id!='slqtLegistationReview' and
         @id!='utqfLegistationReview' and
         @id!='opLogicAnd' and
         @id!='opLogicNot' and
         @id!='enNavigator' and
         @id!='utqcAttributeSearch' and
         @id!='utqcSearchMachine' and
         @id!='slqtWithLawSupport' and
         @id!='slqtConsult' and
         @id!='utqcSendConsultation' and
         @id!='utqcLegistationReview' and
         @id!='vcmCustomizeTasksPanelForm' and
         @id!='enDocument' and
         @id!='SubPanelSettings' and
         @id!='opShowSpecial' and
         @id!='enFilter' and
         @id!='enFilters' and
         @id!='enCardOperation' and
         @id!='SavePostListInt' and
         @id!='vcm_dmTasksPanelMenu' and
         @id!='opCustomize' and
         @id!='' and
         @id!='utSingleSearch'">
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


     <xsl:apply-templates select="@*|node()"/>
  
   </xsl:copy>

 </xsl:if>

</xsl:template>

</xsl:stylesheet>
