unit NSRCTag_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/NSRCTag_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::NSRCTag
//
// ������� ����� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� NSRCTag - "������� ����� �����".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_attrName: Integer;

function k2_typNSRCTag: NSRCTagTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_NSRCTag : NSRCTagTag = nil;

// start class NSRCTagTag

function k2_typNSRCTag: NSRCTagTag;
begin
 if (g_NSRCTag = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_NSRCTag := TevdNativeSchema(Tk2TypeTable.GetInstance).t_NSRCTag;
 end;//g_NSRCTag = nil
 Result := g_NSRCTag;
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