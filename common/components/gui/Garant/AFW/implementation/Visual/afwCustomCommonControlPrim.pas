unit afwCustomCommonControlPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AFW"
// ������: "w:/common/components/gui/Garant/AFW/implementation/Visual/afwCustomCommonControlPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::AFW::afwControl::TafwCustomCommonControlPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  afwControl,
  l3InternalInterfaces
  ;

type
 TafwCustomCommonControlPrim = class(TafwControl)
 protected
 // overridden protected methods
   procedure Paint(const CN: Il3Canvas); override;
     {* ��������� ��������� �������� ���� ������������ �������� }
 protected
 // protected methods
   procedure DoPaint; virtual; abstract;
 end;//TafwCustomCommonControlPrim

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;

// start class TafwCustomCommonControlPrim

procedure TafwCustomCommonControlPrim.Paint(const CN: Il3Canvas);
//#UC START# *48C6C044025E_48BBE35E039F_var*
//#UC END# *48C6C044025E_48BBE35E039F_var*
begin
//#UC START# *48C6C044025E_48BBE35E039F_impl*
 DoPaint;
//#UC END# *48C6C044025E_48BBE35E039F_impl*
end;//TafwCustomCommonControlPrim.Paint

initialization
{$If not defined(NoScripts)}
// ����������� TafwCustomCommonControlPrim
 TtfwClassRef.Register(TafwCustomCommonControlPrim);
{$IfEnd} //not NoScripts

end.