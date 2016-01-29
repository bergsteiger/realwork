unit AttrName_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/AttrName_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::AttrName
//
// ��� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� AttrName - "��� ��������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idAttrName = 126;

function k2_typAttrName: AttrNameTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AttrName : AttrNameTag = nil;

// start class AttrNameTag

function k2_typAttrName: AttrNameTag;
begin
 if (g_AttrName = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_AttrName := TevNativeSchema(Tk2TypeTable.GetInstance).t_AttrName;
 end;//g_AttrName = nil
 Result := g_AttrName;
end;

end.