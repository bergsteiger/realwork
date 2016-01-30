unit NemesisRes;
 {* [$90440042] }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\NemesisRes.pas"
// Стереотип: "VCMApplication"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimNemesisRes
;

type
 TvcmApplicationRef = TNemesisRes;
  {* Ссылка на приложение для DesignTime редакторов }

 TNemesisRes = {final} class(TPrimNemesisRes)
  {* [$90440042] }
 end;//TNemesisRes
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , moCompareEditions
 , moInternetAgent
 , moFolders
 , moChat
 , moWorkJournal
 , moMonitorings
 , moCommon
 , moDocument
 , moList
 , moDiction
 , moTips
 , moInpharm
 , moRubricator
 , moSettings
 , moMainMenu
 , moConsultations
 , moBaseSearch
 , moFilters
 , moUnderControl
 , moDocumentListFromFile
 , moChangesBetweenEditions
 , moSearch
 , moAAC
 , moCommonPost
 , evExtFormat
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
