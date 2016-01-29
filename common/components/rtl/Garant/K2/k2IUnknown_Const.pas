unit k2IUnknown_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2IUnknown_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi::K2::CoreTypes::k2Core::IUnknown
//
// ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� IUnknown - "���������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_typIUnknown: IUnknownAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_IUnknown : IUnknownAtom = nil;

// start class IUnknownAtom

function k2_typIUnknown: IUnknownAtom;
begin
 if (g_IUnknown = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_IUnknown := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_IUnknown;
 end;//g_IUnknown = nil
 Result := g_IUnknown;
end;

end.