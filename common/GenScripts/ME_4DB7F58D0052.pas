unit f1WordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\f1WordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "f1WordsPack" MUID: (4DB7F58D0052)

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwDocumentsCacheClear
 , kwTimeMachineSetDate
 , kwPopEditorHasComment
 , kwExportHelp
 , kwFiltersList
 , kwF1BaseDate
 , kwAttributeSearch
 , kwOk
 , kwMainMenu
 , kwF1ComplectName
 , kwF1ComplectOwner
 , kwRestoreSettings
 , kwClearDocumentContextSearchHistory
 , kwClearPharmContextSearchHistory
 , kwIsPharmPermanentFilterExists
 , kwIsLegalPermanentFilterExists
 , kwIsMyDocumentsEmpty
 , kwConfigurationsGetCount
 , kwConfigurationsGetConfiguration
 , kwConfigurationGetName
 , kwConfigurationGetType
 , kwConfigurationsGetActiveConfiguration
 , kwConfigurationActivate
 , kwConfigurationGetID
 , tfwScriptingTypes
 , SysUtils
 , tfwTypeRegistrator
;
{$IfEnd} // NOT Defined(NoScripts)

end.
