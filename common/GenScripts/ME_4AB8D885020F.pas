unit OldSituationSearch_Form;
 {* ����� �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\OldSituationSearch_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "OldSituationSearch" MUID: (4AB8D885020F)
// ��� ����: "TcfOldSituationSearch"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimOldSituationSearchOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_cfOldSituationSearch: TvcmFormDescriptor = (rFormID : (rName : 'cfOldSituationSearch'; rID : 0); rFactory : nil);
  {* ������������� ����� TcfOldSituationSearch }

type
 TcfOldSituationSearch = class;

 OldSituationSearchFormDef = interface
  {* ������������� ����� OldSituationSearch }
  ['{C98510C7-15ED-408C-B356-69BB7B6D9CA4}']
 end;//OldSituationSearchFormDef

 TcfOldSituationSearch = {final} class(TPrimOldSituationSearchOptionsForm, OldSituationSearchFormDef)
  {* ����� �� �������� }
 end;//TcfOldSituationSearch
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , OldSituationSearchKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TcfOldSituationSearch);
 {* ����������� OldSituationSearch }
{$IfEnd} // NOT Defined(NoScripts)
 fm_cfOldSituationSearch.SetFactory(TcfOldSituationSearch.Make);
 {* ����������� ������� ����� OldSituationSearch }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
