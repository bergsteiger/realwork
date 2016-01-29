unit TagName_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/TagName_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::TagName
//
// ��� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� TagName - "��� ����".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idTagName = 124;

function k2_typTagName: TagNameTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TagName : TagNameTag = nil;

// start class TagNameTag

function k2_typTagName: TagNameTag;
begin
 if (g_TagName = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TagName := TevNativeSchema(Tk2TypeTable.GetInstance).t_TagName;
 end;//g_TagName = nil
 Result := g_TagName;
end;

end.