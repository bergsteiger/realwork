unit f1WordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\f1WordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

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
;
{$IfEnd} // NOT Defined(NoScripts)

end.
