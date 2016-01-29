unit npNavigatorListCBT;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$WithVCM"
// Модуль: "w:/common/components/gui/Garant/VT/npNavigatorListCBT.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$WithVCM::vtNavigator::TnpNavigatorListCBT
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  npNavigatorListPrim
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TnpNavigatorListCBT = class(TnpNavigatorListPrim, Il3CBTListener)
 protected
 // realized methods
   procedure CBTListenerNotify(Code: Integer;
     WParam: WPARAM;
     LParam: LPARAM;
     var theResult: Tl3HookProcResult);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//TnpNavigatorListCBT
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3ListenersManager
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TnpNavigatorListCBT

procedure TnpNavigatorListCBT.CBTListenerNotify(Code: Integer;
  WParam: WPARAM;
  LParam: LPARAM;
  var theResult: Tl3HookProcResult);
//#UC START# *4F79CF5C01BB_4F61FEEB00A5_var*
var
 l_Index : Integer;
//#UC END# *4F79CF5C01BB_4F61FEEB00A5_var*
begin
//#UC START# *4F79CF5C01BB_4F61FEEB00A5_impl*
  for l_Index := 0 to Pred(Count) do
   Items[l_Index].hCBT(Code, WParam, LParam);
//#UC END# *4F79CF5C01BB_4F61FEEB00A5_impl*
end;//TnpNavigatorListCBT.CBTListenerNotify

procedure TnpNavigatorListCBT.Cleanup;
//#UC START# *479731C50290_4F61FEEB00A5_var*
//#UC END# *479731C50290_4F61FEEB00A5_var*
begin
//#UC START# *479731C50290_4F61FEEB00A5_impl*
 Tl3ListenersManager.RemoveCBTListener(Self);
 inherited;
//#UC END# *479731C50290_4F61FEEB00A5_impl*
end;//TnpNavigatorListCBT.Cleanup

procedure TnpNavigatorListCBT.InitFields;
//#UC START# *47A042E100E2_4F61FEEB00A5_var*
//#UC END# *47A042E100E2_4F61FEEB00A5_var*
begin
//#UC START# *47A042E100E2_4F61FEEB00A5_impl*
 inherited;
 Tl3ListenersManager.AddCBTListener(Self);
//#UC END# *47A042E100E2_4F61FEEB00A5_impl*
end;//TnpNavigatorListCBT.InitFields

{$IfEnd} //not NoVCM

end.