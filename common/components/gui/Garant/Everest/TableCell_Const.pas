unit TableCell_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/TableCell_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::TableCell
//
// Ячейка таблицы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TableCell - "Ячейка таблицы".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idTableCell = 27;

function k2_typTableCell_MergeStatus: TableCell_MergeStatus_Tag;

function k2_typTableCell_VerticalAligment: TableCell_VerticalAligment_Tag;

function k2_attrStateCount: Integer;

function k2_attrMergeStatus: Integer;

function k2_attrVerticalAligment: Integer;
function k2_typTableCell: TableCellTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TableCell : TableCellTag = nil;

// start class TableCellTag

function k2_typTableCell: TableCellTag;
begin
 if (g_TableCell = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TableCell := TevNativeSchema(Tk2TypeTable.GetInstance).t_TableCell;
 end;//g_TableCell = nil
 Result := g_TableCell;
end;
var
 g_k2_attrStateCount: Integer = -1;

function k2_attrStateCount: Integer;
begin
 if (g_k2_attrStateCount = -1) then
  g_k2_attrStateCount :=  Tk2Attributes.Instance.CheckIDByName('StateCount');
 Result := g_k2_attrStateCount;
end;

var
 g_k2_attrMergeStatus: Integer = -1;

function k2_attrMergeStatus: Integer;
begin
 if (g_k2_attrMergeStatus = -1) then
  g_k2_attrMergeStatus :=  Tk2Attributes.Instance.CheckIDByName('MergeStatus');
 Result := g_k2_attrMergeStatus;
end;

var
 g_k2_attrVerticalAligment: Integer = -1;

function k2_attrVerticalAligment: Integer;
begin
 if (g_k2_attrVerticalAligment = -1) then
  g_k2_attrVerticalAligment :=  Tk2Attributes.Instance.CheckIDByName('VerticalAligment');
 Result := g_k2_attrVerticalAligment;
end;


var
 g_TableCell_MergeStatus : TableCell_MergeStatus_Tag = nil;

// start class MergeStatus

function k2_typTableCell_MergeStatus: TableCell_MergeStatus_Tag;
begin
 if (g_TableCell_MergeStatus = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TableCell_MergeStatus := TevNativeSchema(Tk2TypeTable.GetInstance).t_TableCell_MergeStatus;
 end;//g_TableCell = nil
 Result := g_TableCell_MergeStatus;
end;

var
 g_TableCell_VerticalAligment : TableCell_VerticalAligment_Tag = nil;

// start class VerticalAligment

function k2_typTableCell_VerticalAligment: TableCell_VerticalAligment_Tag;
begin
 if (g_TableCell_VerticalAligment = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_TableCell_VerticalAligment := TevNativeSchema(Tk2TypeTable.GetInstance).t_TableCell_VerticalAligment;
 end;//g_TableCell = nil
 Result := g_TableCell_VerticalAligment;
end;


end.