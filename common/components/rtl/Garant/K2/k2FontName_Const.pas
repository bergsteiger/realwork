unit k2FontName_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2FontName_Const.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::K2::CoreTypes::k2Core::FontName
//
// ��������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� FontName - "��������� ������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Base {a},
  k2Core_Schema
  ;

function k2_typFontName: FontNameTag;

//#UC START# *484CE9CE0107const_intf*
//#UC END# *484CE9CE0107const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_FontName : FontNameTag = nil;

// start class FontNameTag

function k2_typFontName: FontNameTag;
begin
 if (g_FontName = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is Tk2CoreSchema);
  g_FontName := Tk2CoreSchema(Tk2TypeTable.GetInstance).t_FontName;
 end;//g_FontName = nil
 Result := g_FontName;
end;

end.