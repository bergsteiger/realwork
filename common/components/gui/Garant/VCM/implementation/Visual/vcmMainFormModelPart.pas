unit vcmMainFormModelPart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmMainFormModelPart.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmMainFormModelPart
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
  vcmContainerForm
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmMainFormModelPart = class(TvcmContainerForm)
 protected
 // protected methods
   procedure DispatcherCreated; virtual;
   procedure AfterModulesRegistered; virtual;
 end;//TvcmMainFormModelPart
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

// start class TvcmMainFormModelPart

procedure TvcmMainFormModelPart.DispatcherCreated;
//#UC START# *4F7B0CF50022_4F7B0CBE0283_var*
//#UC END# *4F7B0CF50022_4F7B0CBE0283_var*
begin
//#UC START# *4F7B0CF50022_4F7B0CBE0283_impl*
 // - ничего не делаем, пусть потомки разбираются
//#UC END# *4F7B0CF50022_4F7B0CBE0283_impl*
end;//TvcmMainFormModelPart.DispatcherCreated

procedure TvcmMainFormModelPart.AfterModulesRegistered;
//#UC START# *537DB0AD03D8_4F7B0CBE0283_var*
//#UC END# *537DB0AD03D8_4F7B0CBE0283_var*
begin
//#UC START# *537DB0AD03D8_4F7B0CBE0283_impl*
 // - ничего не делаем, пусть потомки разбираются
//#UC END# *537DB0AD03D8_4F7B0CBE0283_impl*
end;//TvcmMainFormModelPart.AfterModulesRegistered

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmMainFormModelPart
 TtfwClassRef.Register(TvcmMainFormModelPart);
{$IfEnd} //not NoScripts AND not NoVCM

end.