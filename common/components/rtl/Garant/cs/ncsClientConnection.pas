unit ncsClientConnection;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "cs"
// ������: "w:/common/components/rtl/Garant/cs/ncsClientConnection.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Connection::TncsClientConnection
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  ncsConnection
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsClientConnection = class(TncsConnection)
 end;//TncsClientConnection
{$IfEnd} //not Nemesis

implementation

end.