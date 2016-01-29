unit Cloak_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/Cloak_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Cloak
//
// �������������� ������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Cloak - "�������������� ������ ����������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idCloak = 47;

function k2_typCloak: CloakTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Cloak : CloakTag = nil;

// start class CloakTag

function k2_typCloak: CloakTag;
begin
 if (g_Cloak = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Cloak := TevNativeSchema(Tk2TypeTable.GetInstance).t_Cloak;
 end;//g_Cloak = nil
 Result := g_Cloak;
end;

end.