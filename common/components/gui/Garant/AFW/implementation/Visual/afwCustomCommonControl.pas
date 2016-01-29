unit afwCustomCommonControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AFW"
// Модуль: "w:/common/components/gui/Garant/AFW/implementation/Visual/afwCustomCommonControl.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::AFW::afwControl::TafwCustomCommonControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  afwCustomCommonControlPrim,
  l3PrinterInterfaces
  ;

type
 TafwCustomCommonControl = class(TafwCustomCommonControlPrim)
 protected
 // property methods
   function pm_GetCanvas: TCanvas;
 protected
 // realized methods
   procedure DoPaint; override;
 protected
 // protected methods
   procedure Paint; virtual;
 protected
 // protected properties
   property Canvas: TCanvas
     read pm_GetCanvas;
 end;//TafwCustomCommonControl

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TafwCustomCommonControl

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
{$If not defined(NoScripts)}
// Регистрация TafwCustomCommonControl
 TtfwClassRef.Register(TafwCustomCommonControl);
{$IfEnd} //not NoScripts

end.