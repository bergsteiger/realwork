unit DictItemEx_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/DictItemEx_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::DictItemEx
//
// ����������� ������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� DictItemEx - "����������� ������� �������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idDictItemEx = 87;

function k2_attrPrivate: Integer;

function k2_typDictItemEx: DictItemExTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DictItemEx : DictItemExTag = nil;

// start class DictItemExTag

function k2_typDictItemEx: DictItemExTag;
begin
 if (g_DictItemEx = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_DictItemEx := TevdNativeSchema(Tk2TypeTable.GetInstance).t_DictItemEx;
 end;//g_DictItemEx = nil
 Result := g_DictItemEx;
end;
var
 g_k2_attrPrivate: Integer = -1;

function k2_attrPrivate: Integer;
begin
 if (g_k2_attrPrivate = -1) then
  g_k2_attrPrivate :=  Tk2Attributes.Instance.CheckIDByName('Private');
 Result := g_k2_attrPrivate;
end;


end.