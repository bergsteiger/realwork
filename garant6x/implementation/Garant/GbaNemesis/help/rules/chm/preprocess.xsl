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


<!-- Определяем вспомогательную переменную для исключения некоторых VCM-объектов -->

<xsl:variable name="data_description_id">
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


<!-- Вручную исключаем некоторые VCM-объекты. 

	 @id!='' and

-->


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
         @id!='DocNumberQuery' and
         @id!='opInternalDocNumber' and
         @id!='opDocumentSIze' and
	 $data_description_id!='mo_Folders-enFile' and
	 @id!='enReminder' and
	 @id!='opRemMWControlledChangingWarning' and
	 @id!='opRemMWOldBaseWarning' and
	 @id!='opRemMWGlobalFiltersWarning' and
	 @id!='opRemMWTrialModeWarning' and
	 @id!='opDocLastRedactionDate' and
	 @id!='opDocProperties' and
	 @id!='opUserName' and
	 @id!='enSubsPanel' and
	 @id!='opCopySubNumber' and
	 @id!='opCopyInformation' and
	 @id!='en_PictureInfo' and
	 @id!='opDocumentsWithoutClass' and
	 @id!='opDocumentsWithoutKey' and
	 @id!='opDocumentsWithoutIncluded' and
	 @id!='en_BaseSearchCard' and
	 @id!='opExportForIntegration' and
	 @id!='opShowDocumentPicture' and
	 @id!='vcmCustomizeTasksPanelForm' and
      	 @id!='opOpenDocOnNumber' and
	 @id!='opAvailableOperations' and
      	 $data_description_id!='enDocument-opShowTechComments' and
      	 $data_description_id!='mo_Search-opStartENO' and
	 $data_description_id!='vcm_dmTasksPanelMenu-opCustomize' and
	 $data_description_id!='vcm_dmTasksPanelMenu-enEdit' and	 
	 $data_description_id!='Document-enResult' and
	 @id!='' and
	 @id!='dwftMain' and
	 @id!='dwftSynchro'">



<!--	 
      	 $data_description_id!='' and
	 @id!='dwftSynchro' and
	 @id!='' and
	 @id!='' and
	 @id!='' and
	 @id!='' and
	 @id!='' and
	 @id!='' and
	 @id!='' and
	 @id!='' and
	 @id!='' and
	 @id!='' and
	 @id!='' and
	 @id!='' and
-->


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


<!-- Согласно http://mdp.garant.ru/pages/viewpage.action?pageId=96483812&focusedCommentId=97354782#comment-97354782 -->
<!-- для топиков c атрибутом alias (preprocess.xsl) 							            -->
<!-- будет выполняться перенаправление на другие страницы (page.xsl),						    -->
<!-- а сами топики будут скрыты из оглавления (reference.xsl). 							    -->

 <xsl:choose>
<!--	
	<xsl:when test="@id=''">
		  <xsl:attribute name="alias"></xsl:attribute>
	</xsl:when>
-->
	<xsl:when test="@id='mlsfMedicFirm'">
		  <xsl:attribute name="alias">dftMedicFirm</xsl:attribute>
	</xsl:when>
	<xsl:when test="@id='utTips'">
		  <xsl:attribute name="alias">dftTips</xsl:attribute>
	</xsl:when>
	<xsl:when test="@id='lftConsultation'">
		  <xsl:attribute name="alias">dftConsultation</xsl:attribute>
	</xsl:when>
	<xsl:when test="@id='utFolders'">
		  <xsl:attribute name="alias">utSaveOpen</xsl:attribute>
	</xsl:when>
	<xsl:when test="@id='utMainMenuNew'">
		  <xsl:attribute name="alias">utSimpleMainMenu</xsl:attribute>
	</xsl:when>
	<xsl:when test="@id='slqtOldKW'">
		  <xsl:attribute name="alias">slqtKW</xsl:attribute>
	</xsl:when>
	<xsl:when test="@id='cutOldKeyWord'">
		  <xsl:attribute name="alias">slqtKW</xsl:attribute>
	</xsl:when>
	<xsl:when test="@id='utqcAttributeSearch'">
		  <xsl:attribute name="alias">slqtAttribute</xsl:attribute>
	</xsl:when>
	<xsl:when test="@id='dftAutoreferatAfterSearch'">
		  <xsl:attribute name="alias">slqtLegistationReview</xsl:attribute>
	</xsl:when>
	<xsl:when test="@id='utqcInpharmSearch'">
		  <xsl:attribute name="alias">slqtInpharmSearch</xsl:attribute>
	</xsl:when>
	<xsl:when test="@id='dftAutoreferat'">
		  <xsl:attribute name="alias">nltMain</xsl:attribute>
	</xsl:when>
	<xsl:when test="@id='mlsfDrugList'">
		  <xsl:attribute name="alias">svSynchroView</xsl:attribute>
	</xsl:when>    
 </xsl:choose>


       <xsl:apply-templates select="@*|node()"/>
   </xsl:copy>

 </xsl:if>

</xsl:template>

</xsl:stylesheet>
