unit TagBody_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/TagBody_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::TagBody
//
// ���� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� TagBody - "���� ����".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idTagBody = 128;

function k2_typTagBody: TagBodyTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TagBody : TagBodyTag = nil;

// start class TagBodyTag

function k2_typTagBody: TagBodyTag;
begin
 if (g_TagBody = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TagBody := TevNativeSchema(Tk2TypeTable.GetInstance).t_TagBody;
 end;//g_TagBody = nil
 Result := g_TagBody;
end;

end.