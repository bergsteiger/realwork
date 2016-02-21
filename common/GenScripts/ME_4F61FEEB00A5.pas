unit npNavigatorListCBT;

// Модуль: "w:\common\components\gui\Garant\VT\npNavigatorListCBT.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , npNavigatorListPrim
 , l3Interfaces
;

type
 TnpNavigatorListCBT = class(TnpNavigatorListPrim, Il3CBTListener)
  protected
   procedure CBTListenerNotify(Code: Integer;
    WParam: WPARAM;
    LParam: LPARAM;
    var theResult: Tl3HookProcResult);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
 end;//TnpNavigatorListCBT
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3ListenersManager
;

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
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(NoVCM)

end.
