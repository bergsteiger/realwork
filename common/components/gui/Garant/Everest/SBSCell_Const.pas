unit SBSCell_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/SBSCell_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::SBSCell
//
// ������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� SBSCell - "������ �������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idSBSCell = 109;

function k2_typSBSCell: SBSCellTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SBSCell : SBSCellTag = nil;

// start class SBSCellTag

function k2_typSBSCell: SBSCellTag;
begin
 if (g_SBSCell = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_SBSCell := TevNativeSchema(Tk2TypeTable.GetInstance).t_SBSCell;
 end;//g_SBSCell = nil
 Result := g_SBSCell;
end;

end.