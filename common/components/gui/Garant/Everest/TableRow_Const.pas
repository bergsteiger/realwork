unit TableRow_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/TableRow_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::TableRow
//
// ������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� TableRow - "������ �������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idTableRow = 26;

function k2_typTableRow: TableRowTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TableRow : TableRowTag = nil;

// start class TableRowTag

function k2_typTableRow: TableRowTag;
begin
 if (g_TableRow = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TableRow := TevNativeSchema(Tk2TypeTable.GetInstance).t_TableRow;
 end;//g_TableRow = nil
 Result := g_TableRow;
end;

end.