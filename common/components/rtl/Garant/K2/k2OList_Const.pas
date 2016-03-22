unit k2OList_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2OList_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::K2::CoreTypes::k2Core::OList
//
// ������ ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� OList - "������ ��������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_typOList: OListTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_OList : OListTag = nil;

// start class OListTag

function k2_typOList: OListTag;
begin
 if (g_OList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_OList := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_OList;
 end;//g_OList = nil
 Result := g_OList;
end;

end.