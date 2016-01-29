unit IedTableWordsPack;

interface

uses
 l3IntfUses
 , evEditorInterfaces
 , l3Variant
 , nevBase
 , k2Interfaces
 , nevTools
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopTableInsertRows = class(TtfwClassLike)
  {* Слово скрипта pop:Table:InsertRows
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 NumRows aTable pop:Table:InsertRows >>> l_Boolean
[code]  }
  function InsertRows(const aCtx: TtfwContext;
   const aTable: IedTable;
   NumRows: Integer): Boolean;
   {* Реализация слова скрипта pop:Table:InsertRows }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableInsertRows
 
 TkwPopTableSplit = class(TtfwClassLike)
  {* Слово скрипта pop:Table:Split
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:Split >>> l_Boolean
[code]  }
  function Split(const aCtx: TtfwContext;
   const aTable: IedTable): Boolean;
   {* Реализация слова скрипта pop:Table:Split }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableSplit
 
 TkwPopTableMerge = class(TtfwClassLike)
  {* Слово скрипта pop:Table:Merge
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:Merge >>> l_Boolean
[code]  }
  function Merge(const aCtx: TtfwContext;
   const aTable: IedTable): Boolean;
   {* Реализация слова скрипта pop:Table:Merge }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableMerge
 
 TkwPopTableDelete = class(TtfwClassLike)
  {* Слово скрипта pop:Table:Delete
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:Delete >>> l_Boolean
[code]  }
  function Delete(const aCtx: TtfwContext;
   const aTable: IedTable): Boolean;
   {* Реализация слова скрипта pop:Table:Delete }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableDelete
 
 TkwPopTableRowCount = class(TtfwClassLike)
  {* Слово скрипта pop:Table:RowCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aTable pop:Table:RowCount >>> l_Integer
[code]  }
  function RowCount(const aCtx: TtfwContext;
   const aTable: IedTable): Integer;
   {* Реализация слова скрипта pop:Table:RowCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableRowCount
 
 TkwPopTableCell = class(TtfwClassLike)
  {* Слово скрипта pop:Table:Cell
*Тип результата:* IedCell
*Пример:*
[code]
INTERFACE VAR l_IedCell
 aTable pop:Table:Cell >>> l_IedCell
[code]  }
  function Cell(const aCtx: TtfwContext;
   const aTable: IedTable): IedCell;
   {* Реализация слова скрипта pop:Table:Cell }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableCell
 
 TkwPopTableCells = class(TtfwClassLike)
  {* Слово скрипта pop:Table:Cells
*Тип результата:* IedCells
*Пример:*
[code]
INTERFACE VAR l_IedCells
 aTable pop:Table:Cells >>> l_IedCells
[code]  }
  function Cells(const aCtx: TtfwContext;
   const aTable: IedTable): IedCells;
   {* Реализация слова скрипта pop:Table:Cells }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableCells
 
 TkwPopTableColumn = class(TtfwClassLike)
  {* Слово скрипта pop:Table:Column
*Тип результата:* IedColumn
*Пример:*
[code]
INTERFACE VAR l_IedColumn
 aTable pop:Table:Column >>> l_IedColumn
[code]  }
  function Column(const aCtx: TtfwContext;
   const aTable: IedTable): IedColumn;
   {* Реализация слова скрипта pop:Table:Column }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableColumn
 
 TkwPopTableColumnsIterator = class(TtfwClassLike)
  {* Слово скрипта pop:Table:ColumnsIterator
*Тип результата:* IedColumnsIterator
*Пример:*
[code]
INTERFACE VAR l_IedColumnsIterator
 aTable pop:Table:ColumnsIterator >>> l_IedColumnsIterator
[code]  }
  function ColumnsIterator(const aCtx: TtfwContext;
   const aTable: IedTable): IedColumnsIterator;
   {* Реализация слова скрипта pop:Table:ColumnsIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableColumnsIterator
 
 TkwPopTableRowsIterator = class(TtfwClassLike)
  {* Слово скрипта pop:Table:RowsIterator
*Тип результата:* IedRowsIterator
*Пример:*
[code]
INTERFACE VAR l_IedRowsIterator
 aTable pop:Table:RowsIterator >>> l_IedRowsIterator
[code]  }
  function RowsIterator(const aCtx: TtfwContext;
   const aTable: IedTable): IedRowsIterator;
   {* Реализация слова скрипта pop:Table:RowsIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableRowsIterator
 
 TkwPopTableOldNSRC = class(TtfwPropertyLike)
  {* Слово скрипта pop:Table:OldNSRC
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:OldNSRC >>> l_Boolean
[code]  }
  function OldNSRC(const aCtx: TtfwContext;
   const aTable: IedTable): Boolean;
   {* Реализация слова скрипта pop:Table:OldNSRC }
  procedure DoSetValue(const aTable: IedTable;
   aValue: Boolean);
   {* Метод установки значения свойства OldNSRC }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableOldNSRC
 
end.
