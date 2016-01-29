unit SBS_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/SBS_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::SBS
//
// �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� SBS - "�������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idSBS = 25;

function k2_typSBS: SBSTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SBS : SBSTag = nil;

// start class SBSTag

function k2_typSBS: SBSTag;
begin
 if (g_SBS = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_SBS := TevNativeSchema(Tk2TypeTable.GetInstance).t_SBS;
 end;//g_SBS = nil
 Result := g_SBS;
end;

end.