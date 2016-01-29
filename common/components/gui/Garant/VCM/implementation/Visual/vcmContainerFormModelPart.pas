unit vcmContainerFormModelPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmContainerFormModelPart.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmContainerFormModelPart
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmInterfaces,
  vcmEntityForm
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmContainerFormModelPart = class(TvcmEntityForm)
 protected
 // protected methods
   procedure AfterInsertForm(const aForm: IvcmEntityForm); virtual;
 end;//TvcmContainerFormModelPart
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmContainerFormModelPart

procedure TvcmContainerFormModelPart.AfterInsertForm(const aForm: IvcmEntityForm);
//#UC START# *4F7C6DFE00DE_4F7B1BC201C2_var*
//#UC END# *4F7C6DFE00DE_4F7B1BC201C2_var*
begin
//#UC START# *4F7C6DFE00DE_4F7B1BC201C2_impl*
 // - ничего не делаем, пусть потомки разбираются
//#UC END# *4F7C6DFE00DE_4F7B1BC201C2_impl*
end;//TvcmContainerFormModelPart.AfterInsertForm

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmContainerFormModelPart
 TtfwClassRef.Register(TvcmContainerFormModelPart);
{$IfEnd} //not NoScripts AND not NoVCM

end.