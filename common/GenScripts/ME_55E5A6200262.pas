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
  {* ����� ������� pop:Table:InsertRows
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 NumRows aTable pop:Table:InsertRows >>> l_Boolean
[code]  }
  function InsertRows(const aCtx: TtfwContext;
   const aTable: IedTable;
   NumRows: Integer): Boolean;
   {* ���������� ����� ������� pop:Table:InsertRows }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableInsertRows
 
 TkwPopTableSplit = class(TtfwClassLike)
  {* ����� ������� pop:Table:Split
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:Split >>> l_Boolean
[code]  }
  function Split(const aCtx: TtfwContext;
   const aTable: IedTable): Boolean;
   {* ���������� ����� ������� pop:Table:Split }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableSplit
 
 TkwPopTableMerge = class(TtfwClassLike)
  {* ����� ������� pop:Table:Merge
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:Merge >>> l_Boolean
[code]  }
  function Merge(const aCtx: TtfwContext;
   const aTable: IedTable): Boolean;
   {* ���������� ����� ������� pop:Table:Merge }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableMerge
 
 TkwPopTableDelete = class(TtfwClassLike)
  {* ����� ������� pop:Table:Delete
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:Delete >>> l_Boolean
[code]  }
  function Delete(const aCtx: TtfwContext;
   const aTable: IedTable): Boolean;
   {* ���������� ����� ������� pop:Table:Delete }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableDelete
 
 TkwPopTableRowCount = class(TtfwClassLike)
  {* ����� ������� pop:Table:RowCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aTable pop:Table:RowCount >>> l_Integer
[code]  }
  function RowCount(const aCtx: TtfwContext;
   const aTable: IedTable): Integer;
   {* ���������� ����� ������� pop:Table:RowCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableRowCount
 
 TkwPopTableCell = class(TtfwClassLike)
  {* ����� ������� pop:Table:Cell
*��� ����������:* IedCell
*������:*
[code]
INTERFACE VAR l_IedCell
 aTable pop:Table:Cell >>> l_IedCell
[code]  }
  function Cell(const aCtx: TtfwContext;
   const aTable: IedTable): IedCell;
   {* ���������� ����� ������� pop:Table:Cell }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableCell
 
 TkwPopTableCells = class(TtfwClassLike)
  {* ����� ������� pop:Table:Cells
*��� ����������:* IedCells
*������:*
[code]
INTERFACE VAR l_IedCells
 aTable pop:Table:Cells >>> l_IedCells
[code]  }
  function Cells(const aCtx: TtfwContext;
   const aTable: IedTable): IedCells;
   {* ���������� ����� ������� pop:Table:Cells }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableCells
 
 TkwPopTableColumn = class(TtfwClassLike)
  {* ����� ������� pop:Table:Column
*��� ����������:* IedColumn
*������:*
[code]
INTERFACE VAR l_IedColumn
 aTable pop:Table:Column >>> l_IedColumn
[code]  }
  function Column(const aCtx: TtfwContext;
   const aTable: IedTable): IedColumn;
   {* ���������� ����� ������� pop:Table:Column }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableColumn
 
 TkwPopTableColumnsIterator = class(TtfwClassLike)
  {* ����� ������� pop:Table:ColumnsIterator
*��� ����������:* IedColumnsIterator
*������:*
[code]
INTERFACE VAR l_IedColumnsIterator
 aTable pop:Table:ColumnsIterator >>> l_IedColumnsIterator
[code]  }
  function ColumnsIterator(const aCtx: TtfwContext;
   const aTable: IedTable): IedColumnsIterator;
   {* ���������� ����� ������� pop:Table:ColumnsIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableColumnsIterator
 
 TkwPopTableRowsIterator = class(TtfwClassLike)
  {* ����� ������� pop:Table:RowsIterator
*��� ����������:* IedRowsIterator
*������:*
[code]
INTERFACE VAR l_IedRowsIterator
 aTable pop:Table:RowsIterator >>> l_IedRowsIterator
[code]  }
  function RowsIterator(const aCtx: TtfwContext;
   const aTable: IedTable): IedRowsIterator;
   {* ���������� ����� ������� pop:Table:RowsIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableRowsIterator
 
 TkwPopTableOldNSRC = class(TtfwPropertyLike)
  {* ����� ������� pop:Table:OldNSRC
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:OldNSRC >>> l_Boolean
[code]  }
  function OldNSRC(const aCtx: TtfwContext;
   const aTable: IedTable): Boolean;
   {* ���������� ����� ������� pop:Table:OldNSRC }
  procedure DoSetValue(const aTable: IedTable;
   aValue: Boolean);
   {* ����� ��������� �������� �������� OldNSRC }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTableOldNSRC
 
end.
