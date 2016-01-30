unit afwCustomCommonTextControl;

// Модуль: "w:\common\components\gui\Garant\AFW\implementation\Visual\afwCustomCommonTextControl.pas"
// Стереотип: "GuiControl"

{$Include afwDefine.inc}

interface

uses
 l3IntfUses
 , afwCustomCommonTextControlPrim
 , l3PrinterInterfaces
;

type
 TafwCustomCommonTextControl = class(TafwCustomCommonTextControlPrim)
  protected
   function pm_GetCanvas: TCanvas;
   procedure Paint; virtual;
   procedure DoPaint; override;
  protected
   property Canvas: TCanvas
    read pm_GetCanvas;
 end;//TafwCustomCommonTextControl

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

function TafwCustomCommonTextControl.pm_GetCanvas: TCanvas;
//#UC START# *48BBD6680379_48BBD6550261get_var*
//#UC END# *48BBD6680379_48BBD6550261get_var*
begin
//#UC START# *48BBD6680379_48BBD6550261get_impl*
 Result := inherited Canvas.Canvas;
//#UC END# *48BBD6680379_48BBD6550261get_impl*
end;//TafwCustomCommonTextControl.pm_GetCanvas

procedure TafwCustomCommonTextControl.Paint;
//#UC START# *48BBD6AB0328_48BBD6550261_var*
//#UC END# *48BBD6AB0328_48BBD6550261_var*
begin
//#UC START# *48BBD6AB0328_48BBD6550261_impl*
//#UC END# *48BBD6AB0328_48BBD6550261_impl*
end;//TafwCustomCommonTextControl.Paint

procedure TafwCustomCommonTextControl.DoPaint;
//#UC START# *48BBD37B034F_48BBD6550261_var*
//#UC END# *48BBD37B034F_48BBD6550261_var*
begin
//#UC START# *48BBD37B034F_48BBD6550261_impl*
 Paint;
//#UC END# *48BBD37B034F_48BBD6550261_impl*
end;//TafwCustomCommonTextControl.DoPaint

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TafwCustomCommonTextControl);
 {* Регистрация TafwCustomCommonTextControl }
{$IfEnd} // NOT Defined(NoScripts)

end.
