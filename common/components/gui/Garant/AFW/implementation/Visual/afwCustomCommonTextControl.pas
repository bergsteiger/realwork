unit afwCustomCommonTextControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AFW"
// ������: "w:/common/components/gui/Garant/AFW/implementation/Visual/afwCustomCommonTextControl.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::AFW::afwControl::TafwCustomCommonTextControl
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  afwCustomCommonTextControlPrim,
  l3PrinterInterfaces
  ;

type
 TafwCustomCommonTextControl = class(TafwCustomCommonTextControlPrim)
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
 end;//TafwCustomCommonTextControl

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TafwCustomCommonTextControl

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
{$If not defined(NoScripts)}
// ����������� TafwCustomCommonTextControl
 TtfwClassRef.Register(TafwCustomCommonTextControl);
{$IfEnd} //not NoScripts

end.