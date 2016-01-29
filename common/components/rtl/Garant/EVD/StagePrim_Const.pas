unit StagePrim_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/StagePrim_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::StagePrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� StagePrim .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_attrUser: Integer;

function k2_typStagePrim: StagePrimTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_StagePrim : StagePrimTag = nil;

// start class StagePrimTag

function k2_typStagePrim: StagePrimTag;
begin
 if (g_StagePrim = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_StagePrim := TevdNativeSchema(Tk2TypeTable.GetInstance).t_StagePrim;
 end;//g_StagePrim = nil
 Result := g_StagePrim;
end;
var
 g_k2_attrUser: Integer = -1;

function k2_attrUser: Integer;
begin
 if (g_k2_attrUser = -1) then
  g_k2_attrUser :=  Tk2Attributes.Instance.CheckIDByName('User');
 Result := g_k2_attrUser;
end;


end.