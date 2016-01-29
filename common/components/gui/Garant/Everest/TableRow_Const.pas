unit TableRow_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/TableRow_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::TableRow
//
// Строка таблицы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TableRow - "Строка таблицы".
// ! Полностью генерируется с модели. Править руками - нельзя. !

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