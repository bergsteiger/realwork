unit PrimOldSituationSearchOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimOldSituationSearchOptions_Form.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 �������� ����������::Search::View::Search::PrimOldSituationSearchOptions
//
// ����� �� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  PrimOldSituationSearch_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimOldSituationSearchOptionsForm = {form} class(TPrimOldSituationSearchForm)
  {* ����� �� �������� }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
     {* ������� }
   {$IfEnd} //not NoVCM
 end;//TPrimOldSituationSearchOptionsForm

 TvcmContainerFormRef = TPrimOldSituationSearchOptionsForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TPrimOldSituationSearchOptionsForm

{$If not defined(NoVCM)}
procedure TPrimOldSituationSearchOptionsForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
//#UC START# *494F89C30197_4C44149E023Fgetstate_var*
//#UC END# *494F89C30197_4C44149E023Fgetstate_var*
begin
//#UC START# *494F89C30197_4C44149E023Fgetstate_impl*
 // - ������ �� ������ 
//#UC END# *494F89C30197_4C44149E023Fgetstate_impl*
end;//TPrimOldSituationSearchOptionsForm.Edit_Delete_GetState
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� PrimOldSituationSearchOptions
 TtfwClassRef.Register(TPrimOldSituationSearchOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.