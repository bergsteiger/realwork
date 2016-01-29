unit PrimCustomizeTools_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/View/ToolbarMenu/Forms/PrimCustomizeTools_Form.pas"
// Начат: 13.09.2010 19:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> Shared Delphi Operations::VCMCustomization::View::ToolbarMenu::PrimCustomizeTools
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TPrimCustomizeToolsForm = {form} class(TvcmEntityForm)
 end;//TPrimCustomizeToolsForm

 TvcmEntityFormRef = TPrimCustomizeToolsForm;
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация PrimCustomizeTools
 TtfwClassRef.Register(TPrimCustomizeToolsForm);
{$IfEnd} //not NoScripts AND not NoVCM

end.