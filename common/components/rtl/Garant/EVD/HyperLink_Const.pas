unit HyperLink_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/HyperLink_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::HyperLink
//
// �������������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� HyperLink - "�������������� ������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idHyperLink = 14;

function k2_attrURL: Integer;

function k2_typHyperLink: HyperLinkTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_HyperLink : HyperLinkTag = nil;

// start class HyperLinkTag

function k2_typHyperLink: HyperLinkTag;
begin
 if (g_HyperLink = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_HyperLink := TevdNativeSchema(Tk2TypeTable.GetInstance).t_HyperLink;
 end;//g_HyperLink = nil
 Result := g_HyperLink;
end;
var
 g_k2_attrURL: Integer = -1;

function k2_attrURL: Integer;
begin
 if (g_k2_attrURL = -1) then
  g_k2_attrURL :=  Tk2Attributes.Instance.CheckIDByName('URL');
 Result := g_k2_attrURL;
end;


end.