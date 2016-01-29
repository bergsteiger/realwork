unit Attr_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/Attr_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Attr
//
// ������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Attr - "������� ����".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idAttr = 125;

function k2_typAttr: AttrTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Attr : AttrTag = nil;

// start class AttrTag

function k2_typAttr: AttrTag;
begin
 if (g_Attr = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Attr := TevNativeSchema(Tk2TypeTable.GetInstance).t_Attr;
 end;//g_Attr = nil
 Result := g_Attr;
end;

end.