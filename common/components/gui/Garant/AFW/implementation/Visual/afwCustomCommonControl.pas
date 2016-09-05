unit afwCustomCommonControl;

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonControl.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TafwCustomCommonControl" MUID: (48BBE37E00A2)

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
 l3IntfUses
 , afwCustomCommonControlPrim
 , l3PrinterInterfaces
;

type
 TafwCustomCommonControl = class(TafwCustomCommonControlPrim)
  protected
   function pm_GetCanvas: TCanvas;
   procedure Paint; virtual;
   procedure DoPaint; override;
  protected
   property Canvas: TCanvas
    read pm_GetCanvas;
 end;//TafwCustomCommonControl

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *48BBE37E00A2impl_uses*
 //#UC END# *48BBE37E00A2impl_uses*
;

function TafwCustomCommonControl.pm_GetCanvas: TCanvas;
//#UC START# *48BBE3AD0304_48BBE37E00A2get_var*
//#UC END# *48BBE3AD0304_48BBE37E00A2get_var*
begin
//#UC START# *48BBE3AD0304_48BBE37E00A2get_impl*
 Result := inherited Canvas.Canvas;
//#UC END# *48BBE3AD0304_48BBE37E00A2get_impl*
end;//TafwCustomCommonControl.pm_GetCanvas

procedure TafwCustomCommonControl.Paint;
//#UC START# *48BBE3C40283_48BBE37E00A2_var*
//#UC END# *48BBE3C40283_48BBE37E00A2_var*
begin
//#UC START# *48BBE3C40283_48BBE37E00A2_impl*
//#UC END# *48BBE3C40283_48BBE37E00A2_impl*
end;//TafwCustomCommonControl.Paint

procedure TafwCustomCommonControl.DoPaint;
//#UC START# *48BBE38D0061_48BBE37E00A2_var*
//#UC END# *48BBE38D0061_48BBE37E00A2_var*
begin
//#UC START# *48BBE38D0061_48BBE37E00A2_impl*
 Paint;
//#UC END# *48BBE38D0061_48BBE37E00A2_impl*
end;//TafwCustomCommonControl.DoPaint

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TafwCustomCommonControl);
 {* Регистрация TafwCustomCommonControl }
{$IfEnd} // NOT Defined(NoScripts)

end.
