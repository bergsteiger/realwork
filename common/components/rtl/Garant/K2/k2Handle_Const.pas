unit k2Handle_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/K2/k2Handle_Const.pas"
// �����: 17.07.1998 16:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi::K2::Standard::k2Native::Handle
//
// ������������� ������������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Handle - "������������� ������������� �������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Native_Schema
  ;

function k2_typHandle: HandleAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Handle : HandleAtom = nil;

// start class HandleAtom

function k2_typHandle: HandleAtom;
begin
 if (g_Handle = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2NativeSchema);
  g_Handle := Tk2NativeSchema(Tk2TypeTable.GetInstance).t_Handle;
 end;//g_Handle = nil
 Result := g_Handle;
end;

end.