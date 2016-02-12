unit IedTableWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\IedTableWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
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
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopTableInsertRows = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:InsertRows
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 NumRows aTable pop:Table:InsertRows >>> l_Boolean
[code]  }
  private
   function InsertRows(const aCtx: TtfwContext;
    const aTable: IedTable;
    NumRows: Integer): Boolean;
    {* Реализация слова скрипта pop:Table:InsertRows }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableInsertRows

 TkwPopTableSplit = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Split
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:Split >>> l_Boolean
[code]  }
  private
   function Split(const aCtx: TtfwContext;
    const aTable: IedTable): Boolean;
    {* Реализация слова скрипта pop:Table:Split }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableSplit

 TkwPopTableMerge = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Merge
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:Merge >>> l_Boolean
[code]  }
  private
   function Merge(const aCtx: TtfwContext;
    const aTable: IedTable): Boolean;
    {* Реализация слова скрипта pop:Table:Merge }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableMerge

 TkwPopTableDelete = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Delete
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:Delete >>> l_Boolean
[code]  }
  private
   function Delete(const aCtx: TtfwContext;
    const aTable: IedTable): Boolean;
    {* Реализация слова скрипта pop:Table:Delete }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableDelete

 TkwPopTableRowCount = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:RowCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aTable pop:Table:RowCount >>> l_Integer
[code]  }
  private
   function RowCount(const aCtx: TtfwContext;
    const aTable: IedTable): Integer;
    {* Реализация слова скрипта pop:Table:RowCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableRowCount

 TkwPopTableCell = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Cell
*Тип результата:* IedCell
*Пример:*
[code]
INTERFACE VAR l_IedCell
 aTable pop:Table:Cell >>> l_IedCell
[code]  }
  private
   function Cell(const aCtx: TtfwContext;
    const aTable: IedTable): IedCell;
    {* Реализация слова скрипта pop:Table:Cell }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableCell

 TkwPopTableCells = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Cells
*Тип результата:* IedCells
*Пример:*
[code]
INTERFACE VAR l_IedCells
 aTable pop:Table:Cells >>> l_IedCells
[code]  }
  private
   function Cells(const aCtx: TtfwContext;
    const aTable: IedTable): IedCells;
    {* Реализация слова скрипта pop:Table:Cells }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableCells

 TkwPopTableColumn = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Column
*Тип результата:* IedColumn
*Пример:*
[code]
INTERFACE VAR l_IedColumn
 aTable pop:Table:Column >>> l_IedColumn
[code]  }
  private
   function Column(const aCtx: TtfwContext;
    const aTable: IedTable): IedColumn;
    {* Реализация слова скрипта pop:Table:Column }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableColumn

 TkwPopTableColumnsIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:ColumnsIterator
*Тип результата:* IedColumnsIterator
*Пример:*
[code]
INTERFACE VAR l_IedColumnsIterator
 aTable pop:Table:ColumnsIterator >>> l_IedColumnsIterator
[code]  }
  private
   function ColumnsIterator(const aCtx: TtfwContext;
    const aTable: IedTable): IedColumnsIterator;
    {* Реализация слова скрипта pop:Table:ColumnsIterator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableColumnsIterator

 TkwPopTableRowsIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:RowsIterator
*Тип результата:* IedRowsIterator
*Пример:*
[code]
INTERFACE VAR l_IedRowsIterator
 aTable pop:Table:RowsIterator >>> l_IedRowsIterator
[code]  }
  private
   function RowsIterator(const aCtx: TtfwContext;
    const aTable: IedTable): IedRowsIterator;
    {* Реализация слова скрипта pop:Table:RowsIterator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableRowsIterator

 TkwPopTableOldNSRC = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Table:OldNSRC
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTable pop:Table:OldNSRC >>> l_Boolean
[code]  }
  private
   function OldNSRC(const aCtx: TtfwContext;
    const aTable: IedTable): Boolean;
    {* Реализация слова скрипта pop:Table:OldNSRC }
  protected
   class procedure DoSetValue(const aTable: IedTable;
    aValue: Boolean);
    {* Метод установки значения свойства OldNSRC }
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableOldNSRC

function TkwPopTableInsertRows.InsertRows(const aCtx: TtfwContext;
 const aTable: IedTable;
 NumRows: Integer): Boolean;
 {* Реализация слова скрипта pop:Table:InsertRows }
//#UC START# *F7FB8E9291AE_B20D345184F3_var*
//#UC END# *F7FB8E9291AE_B20D345184F3_var*
begin
//#UC START# *F7FB8E9291AE_B20D345184F3_impl*
 Result :=  aTable.InsertRows(NumRows);
//#UC END# *F7FB8E9291AE_B20D345184F3_impl*
end;//TkwPopTableInsertRows.InsertRows

procedure TkwPopTableInsertRows.DoDoIt(const aCtx: TtfwContext);
var l_aTable: IedTable;
var l_NumRows: Integer;
begin
 try
  l_aTable := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTable: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_NumRows := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра NumRows: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(InsertRows(aCtx, l_aTable, l_NumRows));
end;//TkwPopTableInsertRows.DoDoIt

class function TkwPopTableInsertRows.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:InsertRows';
end;//TkwPopTableInsertRows.GetWordNameForRegister

function TkwPopTableInsertRows.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTableInsertRows.GetResultTypeInfo

function TkwPopTableInsertRows.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopTableInsertRows.GetAllParamsCount

function TkwPopTableInsertRows.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedTable), TypeInfo(Integer)]);
end;//TkwPopTableInsertRows.ParamsTypes

function TkwPopTableSplit.Split(const aCtx: TtfwContext;
 const aTable: IedTable): Boolean;
 {* Реализация слова скрипта pop:Table:Split }
//#UC START# *F04373CABCB5_C352B50F9289_var*
//#UC END# *F04373CABCB5_C352B50F9289_var*
begin
//#UC START# *F04373CABCB5_C352B50F9289_impl*
 Result := aTable.Split(nil);
//#UC END# *F04373CABCB5_C352B50F9289_impl*
end;//TkwPopTableSplit.Split

procedure TkwPopTableSplit.DoDoIt(const aCtx: TtfwContext);
var l_aTable: IedTable;
begin
 try
  l_aTable := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTable: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Split(aCtx, l_aTable));
end;//TkwPopTableSplit.DoDoIt

class function TkwPopTableSplit.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:Split';
end;//TkwPopTableSplit.GetWordNameForRegister

function TkwPopTableSplit.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTableSplit.GetResultTypeInfo

function TkwPopTableSplit.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTableSplit.GetAllParamsCount

function TkwPopTableSplit.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedTable)]);
end;//TkwPopTableSplit.ParamsTypes

function TkwPopTableMerge.Merge(const aCtx: TtfwContext;
 const aTable: IedTable): Boolean;
 {* Реализация слова скрипта pop:Table:Merge }
//#UC START# *405C16C0ED76_51F83F13B477_var*
//#UC END# *405C16C0ED76_51F83F13B477_var*
begin
//#UC START# *405C16C0ED76_51F83F13B477_impl*
 Result := aTable.Merge(nil);
//#UC END# *405C16C0ED76_51F83F13B477_impl*
end;//TkwPopTableMerge.Merge

procedure TkwPopTableMerge.DoDoIt(const aCtx: TtfwContext);
var l_aTable: IedTable;
begin
 try
  l_aTable := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTable: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Merge(aCtx, l_aTable));
end;//TkwPopTableMerge.DoDoIt

class function TkwPopTableMerge.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:Merge';
end;//TkwPopTableMerge.GetWordNameForRegister

function TkwPopTableMerge.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTableMerge.GetResultTypeInfo

function TkwPopTableMerge.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTableMerge.GetAllParamsCount

function TkwPopTableMerge.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedTable)]);
end;//TkwPopTableMerge.ParamsTypes

function TkwPopTableDelete.Delete(const aCtx: TtfwContext;
 const aTable: IedTable): Boolean;
 {* Реализация слова скрипта pop:Table:Delete }
//#UC START# *ABE4F95ABF19_9A1A2962F095_var*
//#UC END# *ABE4F95ABF19_9A1A2962F095_var*
begin
//#UC START# *ABE4F95ABF19_9A1A2962F095_impl*
 Result := aTable.Delete;
//#UC END# *ABE4F95ABF19_9A1A2962F095_impl*
end;//TkwPopTableDelete.Delete

procedure TkwPopTableDelete.DoDoIt(const aCtx: TtfwContext);
var l_aTable: IedTable;
begin
 try
  l_aTable := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTable: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Delete(aCtx, l_aTable));
end;//TkwPopTableDelete.DoDoIt

class function TkwPopTableDelete.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:Delete';
end;//TkwPopTableDelete.GetWordNameForRegister

function TkwPopTableDelete.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTableDelete.GetResultTypeInfo

function TkwPopTableDelete.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTableDelete.GetAllParamsCount

function TkwPopTableDelete.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedTable)]);
end;//TkwPopTableDelete.ParamsTypes

function TkwPopTableRowCount.RowCount(const aCtx: TtfwContext;
 const aTable: IedTable): Integer;
 {* Реализация слова скрипта pop:Table:RowCount }
//#UC START# *BBF6619AD0DE_D3B877D57F14_var*
//#UC END# *BBF6619AD0DE_D3B877D57F14_var*
begin
//#UC START# *BBF6619AD0DE_D3B877D57F14_impl*
 Result := aTable.RowCount;
//#UC END# *BBF6619AD0DE_D3B877D57F14_impl*
end;//TkwPopTableRowCount.RowCount

procedure TkwPopTableRowCount.DoDoIt(const aCtx: TtfwContext);
var l_aTable: IedTable;
begin
 try
  l_aTable := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTable: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(RowCount(aCtx, l_aTable));
end;//TkwPopTableRowCount.DoDoIt

class function TkwPopTableRowCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:RowCount';
end;//TkwPopTableRowCount.GetWordNameForRegister

function TkwPopTableRowCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopTableRowCount.GetResultTypeInfo

function TkwPopTableRowCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTableRowCount.GetAllParamsCount

function TkwPopTableRowCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedTable)]);
end;//TkwPopTableRowCount.ParamsTypes

function TkwPopTableCell.Cell(const aCtx: TtfwContext;
 const aTable: IedTable): IedCell;
 {* Реализация слова скрипта pop:Table:Cell }
//#UC START# *9B376DA3DAFB_EF2649C51BB8_var*
//#UC END# *9B376DA3DAFB_EF2649C51BB8_var*
begin
//#UC START# *9B376DA3DAFB_EF2649C51BB8_impl*
 Result := aTable.Cell;
//#UC END# *9B376DA3DAFB_EF2649C51BB8_impl*
end;//TkwPopTableCell.Cell

procedure TkwPopTableCell.DoDoIt(const aCtx: TtfwContext);
var l_aTable: IedTable;
begin
 try
  l_aTable := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTable: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(Cell(aCtx, l_aTable), TypeInfo(IedCell));
end;//TkwPopTableCell.DoDoIt

class function TkwPopTableCell.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:Cell';
end;//TkwPopTableCell.GetWordNameForRegister

function TkwPopTableCell.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(IedCell);
end;//TkwPopTableCell.GetResultTypeInfo

function TkwPopTableCell.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTableCell.GetAllParamsCount

function TkwPopTableCell.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedTable)]);
end;//TkwPopTableCell.ParamsTypes

function TkwPopTableCells.Cells(const aCtx: TtfwContext;
 const aTable: IedTable): IedCells;
 {* Реализация слова скрипта pop:Table:Cells }
//#UC START# *DB37D80BE703_2EB72067A09C_var*
//#UC END# *DB37D80BE703_2EB72067A09C_var*
begin
//#UC START# *DB37D80BE703_2EB72067A09C_impl*
 Result := aTable.Cells;
//#UC END# *DB37D80BE703_2EB72067A09C_impl*
end;//TkwPopTableCells.Cells

procedure TkwPopTableCells.DoDoIt(const aCtx: TtfwContext);
var l_aTable: IedTable;
begin
 try
  l_aTable := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTable: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(Cells(aCtx, l_aTable), TypeInfo(IedCells));
end;//TkwPopTableCells.DoDoIt

class function TkwPopTableCells.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:Cells';
end;//TkwPopTableCells.GetWordNameForRegister

function TkwPopTableCells.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(IedCells);
end;//TkwPopTableCells.GetResultTypeInfo

function TkwPopTableCells.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTableCells.GetAllParamsCount

function TkwPopTableCells.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedTable)]);
end;//TkwPopTableCells.ParamsTypes

function TkwPopTableColumn.Column(const aCtx: TtfwContext;
 const aTable: IedTable): IedColumn;
 {* Реализация слова скрипта pop:Table:Column }
//#UC START# *A6F4E6335479_B6DB26D3AD5E_var*
//#UC END# *A6F4E6335479_B6DB26D3AD5E_var*
begin
//#UC START# *A6F4E6335479_B6DB26D3AD5E_impl*
 Result := aTable.Column;
//#UC END# *A6F4E6335479_B6DB26D3AD5E_impl*
end;//TkwPopTableColumn.Column

procedure TkwPopTableColumn.DoDoIt(const aCtx: TtfwContext);
var l_aTable: IedTable;
begin
 try
  l_aTable := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTable: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(Column(aCtx, l_aTable), TypeInfo(IedColumn));
end;//TkwPopTableColumn.DoDoIt

class function TkwPopTableColumn.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:Column';
end;//TkwPopTableColumn.GetWordNameForRegister

function TkwPopTableColumn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(IedColumn);
end;//TkwPopTableColumn.GetResultTypeInfo

function TkwPopTableColumn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTableColumn.GetAllParamsCount

function TkwPopTableColumn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedTable)]);
end;//TkwPopTableColumn.ParamsTypes

function TkwPopTableColumnsIterator.ColumnsIterator(const aCtx: TtfwContext;
 const aTable: IedTable): IedColumnsIterator;
 {* Реализация слова скрипта pop:Table:ColumnsIterator }
//#UC START# *4926B5C48AD7_983A86B9A3EB_var*
//#UC END# *4926B5C48AD7_983A86B9A3EB_var*
begin
//#UC START# *4926B5C48AD7_983A86B9A3EB_impl*
 Result := aTable.ColumnsIterator;
//#UC END# *4926B5C48AD7_983A86B9A3EB_impl*
end;//TkwPopTableColumnsIterator.ColumnsIterator

procedure TkwPopTableColumnsIterator.DoDoIt(const aCtx: TtfwContext);
var l_aTable: IedTable;
begin
 try
  l_aTable := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTable: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(ColumnsIterator(aCtx, l_aTable), TypeInfo(IedColumnsIterator));
end;//TkwPopTableColumnsIterator.DoDoIt

class function TkwPopTableColumnsIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:ColumnsIterator';
end;//TkwPopTableColumnsIterator.GetWordNameForRegister

function TkwPopTableColumnsIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(IedColumnsIterator);
end;//TkwPopTableColumnsIterator.GetResultTypeInfo

function TkwPopTableColumnsIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTableColumnsIterator.GetAllParamsCount

function TkwPopTableColumnsIterator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedTable)]);
end;//TkwPopTableColumnsIterator.ParamsTypes

function TkwPopTableRowsIterator.RowsIterator(const aCtx: TtfwContext;
 const aTable: IedTable): IedRowsIterator;
 {* Реализация слова скрипта pop:Table:RowsIterator }
//#UC START# *0373031B92C5_06F487D1C4C1_var*
//#UC END# *0373031B92C5_06F487D1C4C1_var*
begin
//#UC START# *0373031B92C5_06F487D1C4C1_impl*
 Result := aTable.RowsIterator;
//#UC END# *0373031B92C5_06F487D1C4C1_impl*
end;//TkwPopTableRowsIterator.RowsIterator

procedure TkwPopTableRowsIterator.DoDoIt(const aCtx: TtfwContext);
var l_aTable: IedTable;
begin
 try
  l_aTable := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTable: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(RowsIterator(aCtx, l_aTable), TypeInfo(IedRowsIterator));
end;//TkwPopTableRowsIterator.DoDoIt

class function TkwPopTableRowsIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:RowsIterator';
end;//TkwPopTableRowsIterator.GetWordNameForRegister

function TkwPopTableRowsIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(IedRowsIterator);
end;//TkwPopTableRowsIterator.GetResultTypeInfo

function TkwPopTableRowsIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTableRowsIterator.GetAllParamsCount

function TkwPopTableRowsIterator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedTable)]);
end;//TkwPopTableRowsIterator.ParamsTypes

function TkwPopTableOldNSRC.OldNSRC(const aCtx: TtfwContext;
 const aTable: IedTable): Boolean;
 {* Реализация слова скрипта pop:Table:OldNSRC }
//#UC START# *1B9FF9897E50_0948A1EE404E_var*
//#UC END# *1B9FF9897E50_0948A1EE404E_var*
begin
//#UC START# *1B9FF9897E50_0948A1EE404E_impl*
 Result := aTable.OldNSRC;
//#UC END# *1B9FF9897E50_0948A1EE404E_impl*
end;//TkwPopTableOldNSRC.OldNSRC

class procedure TkwPopTableOldNSRC.DoSetValue(const aTable: IedTable;
 aValue: Boolean);
 {* Метод установки значения свойства OldNSRC }
//#UC START# *A4C04E3CC4D7_0948A1EE404E_var*
//#UC END# *A4C04E3CC4D7_0948A1EE404E_var*
begin
//#UC START# *A4C04E3CC4D7_0948A1EE404E_impl*
 aTable.OldNSRC := aValue;
//#UC END# *A4C04E3CC4D7_0948A1EE404E_impl*
end;//TkwPopTableOldNSRC.DoSetValue

procedure TkwPopTableOldNSRC.DoDoIt(const aCtx: TtfwContext);
var l_aTable: IedTable;
begin
 try
  l_aTable := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTable: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(OldNSRC(aCtx, l_aTable));
end;//TkwPopTableOldNSRC.DoDoIt

class function TkwPopTableOldNSRC.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:OldNSRC';
end;//TkwPopTableOldNSRC.GetWordNameForRegister

procedure TkwPopTableOldNSRC.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Table: IedTable;
begin
 try
  l_Table := IedTable(aCtx.rEngine.PopIntf(IedTable));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Table: IedTable : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DoSetValue(l_Table, aValue.AsBoolean);
end;//TkwPopTableOldNSRC.SetValuePrim

function TkwPopTableOldNSRC.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopTableOldNSRC.GetResultTypeInfo

function TkwPopTableOldNSRC.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTableOldNSRC.GetAllParamsCount

function TkwPopTableOldNSRC.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(IedTable)]);
end;//TkwPopTableOldNSRC.ParamsTypes

initialization
 TkwPopTableInsertRows.RegisterInEngine;
 {* Регистрация pop_Table_InsertRows }
 TkwPopTableSplit.RegisterInEngine;
 {* Регистрация pop_Table_Split }
 TkwPopTableMerge.RegisterInEngine;
 {* Регистрация pop_Table_Merge }
 TkwPopTableDelete.RegisterInEngine;
 {* Регистрация pop_Table_Delete }
 TkwPopTableRowCount.RegisterInEngine;
 {* Регистрация pop_Table_RowCount }
 TkwPopTableCell.RegisterInEngine;
 {* Регистрация pop_Table_Cell }
 TkwPopTableCells.RegisterInEngine;
 {* Регистрация pop_Table_Cells }
 TkwPopTableColumn.RegisterInEngine;
 {* Регистрация pop_Table_Column }
 TkwPopTableColumnsIterator.RegisterInEngine;
 {* Регистрация pop_Table_ColumnsIterator }
 TkwPopTableRowsIterator.RegisterInEngine;
 {* Регистрация pop_Table_RowsIterator }
 TkwPopTableOldNSRC.RegisterInEngine;
 {* Регистрация pop_Table_OldNSRC }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedTable));
 {* Регистрация типа IedTable }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedCell));
 {* Регистрация типа IedCell }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedCells));
 {* Регистрация типа IedCells }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedColumn));
 {* Регистрация типа IedColumn }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedColumnsIterator));
 {* Регистрация типа IedColumnsIterator }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedRowsIterator));
 {* Регистрация типа IedRowsIterator }
{$IfEnd} // NOT Defined(NoScripts)

end.
