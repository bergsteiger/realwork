unit NOT_COMPLETED_NemesisRes;
 {* [$90440042] }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\NOT_COMPLETED_NemesisRes.pas"
// ���������: "VCMApplication"
// ������� ������: "Nemesis" MUID: (4A9527D40146)
// ��� ����: "TNemesisRes"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimNemesisRes
;

type
 TNemesisRes = {final} class(TPrimNemesisRes)
  {* [$90440042] }
 end;//TNemesisRes

 TvcmApplicationRef = TNemesisRes;
  {* ������ �� ���������� ��� DesignTime ���������� }
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
 , StdRes
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
