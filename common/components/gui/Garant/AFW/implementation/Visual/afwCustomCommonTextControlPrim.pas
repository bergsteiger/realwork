unit afwCustomCommonTextControlPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AFW"
// ������: "w:/common/components/gui/Garant/AFW/implementation/Visual/afwCustomCommonTextControlPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::AFW::afwControl::TafwCustomCommonTextControlPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  afwTextControl,
  l3InternalInterfaces
  ;

type
 TafwCustomCommonTextControlPrim = class(TafwTextControl)
 protected
 // overridden protected methods
   procedure Paint(const CN: Il3Canvas); override;
     {* ��������� ��������� �������� ���� ������������ �������� }
 protected
 // protected methods
   procedure DoPaint; virtual; abstract;
 end;//TafwCustomCommonTextControlPrim

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TafwCustomCommonTextControlPrim

procedure TafwCustomCommonTextControlPrim.Paint(const CN: Il3Canvas);
//#UC START# *48C6C044025E_48BBD3480266_var*
//#UC END# *48C6C044025E_48BBD3480266_var*
begin
//#UC START# *48C6C044025E_48BBD3480266_impl*
 inherited;
 DoPaint;
//#UC END# *48C6C044025E_48BBD3480266_impl*
end;//TafwCustomCommonTextControlPrim.Paint

initialization
{$If not defined(NoScripts)}
// ����������� TafwCustomCommonTextControlPrim
 TtfwClassRef.Register(TafwCustomCommonTextControlPrim);
{$IfEnd} //not NoScripts

end.