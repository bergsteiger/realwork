unit k2MemoryStream;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2MemoryStream.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::Standard::Tk2MemoryStream
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Interfaces,
  l3Memory
  ;

type
 Tk2MemoryStream = class(Tl3MemoryStream, Ik2RawData)
 protected
 // realized methods
   function pm_GetIsModified: Boolean;
 end;//Tk2MemoryStream

implementation

// start class Tk2MemoryStream

function Tk2MemoryStream.pm_GetIsModified: Boolean;
//#UC START# *49A67D980375_530B3FE100E2get_var*
//#UC END# *49A67D980375_530B3FE100E2get_var*
begin
//#UC START# *49A67D980375_530B3FE100E2get_impl*
// Result := false;
 Result := true;
 // - ����� �� ������� Archi �������, ��� �������� ���, ��� ��� �� ����������
//#UC END# *49A67D980375_530B3FE100E2get_impl*
end;//Tk2MemoryStream.pm_GetIsModified

end.