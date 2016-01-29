unit PrimOldSituationSearchOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimOldSituationSearchOptions_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMContainer::Class>> F1 Основные прецеденты::Search::View::Search::PrimOldSituationSearchOptions
//
// Поиск по ситуации
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
  {* Поиск по ситуации }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
     {* Удалить }
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
 // - ничего не делаем 
//#UC END# *494F89C30197_4C44149E023Fgetstate_impl*
end;//TPrimOldSituationSearchOptionsForm.Edit_Delete_GetState
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimOldSituationSearchOptions
 TtfwClassRef.Register(TPrimOldSituationSearchOptionsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.