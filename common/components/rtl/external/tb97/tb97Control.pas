unit tb97Control;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "tb97"
// ������: "w:/common/components/rtl/external/tb97/tb97Control.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::tb97::tb97utils::Ttb97Control
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\tb97\TB97VER.INC}

interface

{$If not defined(NoTB97)}
uses
  afwCustomCommonControl
  ;
{$IfEnd} //not NoTB97

{$If not defined(NoTB97)}
type
 Ttb97Control = class(TafwCustomCommonControl)
 end;//Ttb97Control
{$IfEnd} //not NoTB97

implementation

{$If not defined(NoTB97)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoTB97

{$If not defined(NoTB97)}


{$IfEnd} //not NoTB97

initialization
{$If not defined(NoScripts) AND not defined(NoTB97)}
// ����������� Ttb97Control
 TtfwClassRef.Register(Ttb97Control);
{$IfEnd} //not NoScripts AND not NoTB97

end.