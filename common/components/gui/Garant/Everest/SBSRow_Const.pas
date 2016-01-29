unit SBSRow_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/SBSRow_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::SBSRow
//
// ������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� SBSRow - "������ �������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idSBSRow = 108;

function k2_typSBSRow: SBSRowTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SBSRow : SBSRowTag = nil;

// start class SBSRowTag

function k2_typSBSRow: SBSRowTag;
begin
 if (g_SBSRow = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_SBSRow := TevNativeSchema(Tk2TypeTable.GetInstance).t_SBSRow;
 end;//g_SBSRow = nil
 Result := g_SBSRow;
end;

end.