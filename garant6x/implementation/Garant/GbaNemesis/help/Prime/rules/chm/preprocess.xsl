<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet 
 version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:msxsl="urn:schemas-microsoft-com:xslt"
 exclude-result-prefixes="msxsl"
>

<xsl:import href="..//common//identity.xsl"/> 

<!-- 㡨ࠥ� ᥪ樨 <controls> -->

<xsl:template match="application/modules/module/forms/form/controls|application/modules/module/forms/form/entities/entity/controls">
</xsl:template>


<!--�१��� ������� ����  -->

<xsl:template match="menu/menuitem">
<xsl:if test="@title!='�����' and
        @title!='���������' and
        @title!='������' and
        @title!='����'">
  <xsl:copy>
   <xsl:apply-templates select="@*|node()"/>
  </xsl:copy>
 </xsl:if>
</xsl:template>




<!--
  <menuitem title="����">
  </menuitem>
  <menuitem title="���㬥���">
  </menuitem>
  <menuitem title="������">
  </menuitem>
  <menuitem title="����">
  </menuitem>
-->


<!--
��⠢�塞 ⮫쪮 � ���, ����� ����� ����樨 ���
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
������塞 � ������, ��魮��� � �ଠ� 
��ਡ��� m (�����) � p (�।�� ��ண� �஢��, 
����� ���� ��魮����, �ମ� ��� ���㫥�). 
��� ����権 ����� p ⮦���⢥��� m.
-->

<xsl:template match="operation | entity | usertypes/usertype">

<!-- �����㥬 ⮫쪮 � ��魮��, ����� ����� ��� �� ���� ������. -->

<!-- ������ �᪫�砥� ������� VCM-��ꥪ��. 
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
