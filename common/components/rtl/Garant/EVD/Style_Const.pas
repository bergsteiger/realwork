unit Style_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/Style_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::Style
//
// ����� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Style - "����� ����������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idStyle = 38;

function k2_attrStyle: Integer;

function k2_attrName: Integer;

function k2_typStyle: StyleTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Style : StyleTag = nil;

// start class StyleTag

function k2_typStyle: StyleTag;
begin
 if (g_Style = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Style := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Style;
 end;//g_Style = nil
 Result := g_Style;
end;
var
 g_k2_attrStyle: Integer = -1;

function k2_attrStyle: Integer;
begin
 if (g_k2_attrStyle = -1) then
  g_k2_attrStyle :=  Tk2Attributes.Instance.CheckIDByName('Style');
 Result := g_k2_attrStyle;
end;

var
 g_k2_attrName: Integer = -1;

function k2_attrName: Integer;
begin
 if (g_k2_attrName = -1) then
  g_k2_attrName :=  Tk2Attributes.Instance.CheckIDByName('Name');
 Result := g_k2_attrName;
end;


end.