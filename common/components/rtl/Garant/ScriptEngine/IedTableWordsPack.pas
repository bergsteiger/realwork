unit IedTableWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\IedTableWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "IedTableWordsPack" MUID: (55E5A6200262)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , evEditorInterfaces
 , l3Variant
 , k2Interfaces
 , nevBase
 , nevTools
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *55E5A6200262impl_uses*
 //#UC END# *55E5A6200262impl_uses*
;

type
 TkwPopTableInsertRows = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:InsertRows }
  private
   function InsertRows(const aCtx: TtfwContext;
    const aTable: IedTable;
    NumRows: Integer): Boolean;
    {* Реализация слова скрипта pop:Table:InsertRows }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableInsertRows

 TkwPopTableSplit = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Split }
  private
   function Split(const aCtx: TtfwContext;
    const aTable: IedTable): Boolean;
    {* Реализация слова скрипта pop:Table:Split }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableSplit

 TkwPopTableMerge = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Merge }
  private
   function Merge(const aCtx: TtfwContext;
    const aTable: IedTable): Boolean;
    {* Реализация слова скрипта pop:Table:Merge }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableMerge

 TkwPopTableDelete = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Delete }
  private
   function Delete(const aCtx: TtfwContext;
    const aTable: IedTable): Boolean;
    {* Реализация слова скрипта pop:Table:Delete }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableDelete

 TkwPopTableRowCount = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:RowCount }
  private
   function RowCount(const aCtx: TtfwContext;
    const aTable: IedTable): Integer;
    {* Реализация слова скрипта pop:Table:RowCount }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableRowCount

 TkwPopTableCell = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Cell }
  private
   function Cell(const aCtx: TtfwContext;
    const aTable: IedTable): IedCell;
    {* Реализация слова скрипта pop:Table:Cell }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableCell

 TkwPopTableCells = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Cells }
  private
   function Cells(const aCtx: TtfwContext;
    const aTable: IedTable): IedCells;
    {* Реализация слова скрипта pop:Table:Cells }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableCells

 TkwPopTableColumn = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:Column }
  private
   function Column(const aCtx: TtfwContext;
    const aTable: IedTable): IedColumn;
    {* Реализация слова скрипта pop:Table:Column }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableColumn

 TkwPopTableColumnsIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:ColumnsIterator }
  private
   function ColumnsIterator(const aCtx: TtfwContext;
    const aTable: IedTable): IedColumnsIterator;
    {* Реализация слова скрипта pop:Table:ColumnsIterator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableColumnsIterator

 TkwPopTableRowsIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Table:RowsIterator }
  private
   function RowsIterator(const aCtx: TtfwContext;
    const aTable: IedTable): IedRowsIterator;
    {* Реализация слова скрипта pop:Table:RowsIterator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableRowsIterator

 TkwPopTableOldNSRC = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Table:OldNSRC }
  private
   function OldNSRC(const aCtx: TtfwContext;
    const aTable: IedTable): Boolean;
    {* Реализация слова скрипта pop:Table:OldNSRC }
  protected
   class procedure DoSetValue(const aTable: IedTable;
    aValue: Boolean);
    {* Метод установки значения свойства OldNSRC }
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopTableOldNSRC

function TkwPopTableInsertRows.InsertRows(const aCtx: TtfwContext;
 const aTable: IedTable;
 NumRows: Integer): Boolean;
 {* Реализация слова скрипта pop:Table:InsertRows }
//#UC START# *55E5A6480145_55E5A6480145_4BBC910E0391_Word_var*
//#UC END# *55E5A6480145_55E5A6480145_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A6480145_55E5A6480145_4BBC910E0391_Word_impl*
 Result :=  aTable.InsertRows(NumRows);
//#UC END# *55E5A6480145_55E5A6480145_4BBC910E0391_Word_impl*
end;//TkwPopTableInsertRows.InsertRows

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

function TkwPopTableSplit.Split(const aCtx: TtfwContext;
 const aTable: IedTable): Boolean;
 {* Реализация слова скрипта pop:Table:Split }
//#UC START# *55E5A65F0349_55E5A65F0349_4BBC910E0391_Word_var*
//#UC END# *55E5A65F0349_55E5A65F0349_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A65F0349_55E5A65F0349_4BBC910E0391_Word_impl*
 Result := aTable.Split(nil);
//#UC END# *55E5A65F0349_55E5A65F0349_4BBC910E0391_Word_impl*
end;//TkwPopTableSplit.Split

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

function TkwPopTableMerge.Merge(const aCtx: TtfwContext;
 const aTable: IedTable): Boolean;
 {* Реализация слова скрипта pop:Table:Merge }
//#UC START# *55E5A66903D8_55E5A66903D8_4BBC910E0391_Word_var*
//#UC END# *55E5A66903D8_55E5A66903D8_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A66903D8_55E5A66903D8_4BBC910E0391_Word_impl*
 Result := aTable.Merge(nil);
//#UC END# *55E5A66903D8_55E5A66903D8_4BBC910E0391_Word_impl*
end;//TkwPopTableMerge.Merge

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

function TkwPopTableDelete.Delete(const aCtx: TtfwContext;
 const aTable: IedTable): Boolean;
 {* Реализация слова скрипта pop:Table:Delete }
//#UC START# *55E5A68602F0_55E5A68602F0_4BBC910E0391_Word_var*
//#UC END# *55E5A68602F0_55E5A68602F0_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A68602F0_55E5A68602F0_4BBC910E0391_Word_impl*
 Result := aTable.Delete;
//#UC END# *55E5A68602F0_55E5A68602F0_4BBC910E0391_Word_impl*
end;//TkwPopTableDelete.Delete

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

function TkwPopTableRowCount.RowCount(const aCtx: TtfwContext;
 const aTable: IedTable): Integer;
 {* Реализация слова скрипта pop:Table:RowCount }
//#UC START# *55E5A69E0012_55E5A69E0012_4BBC910E0391_Word_var*
//#UC END# *55E5A69E0012_55E5A69E0012_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A69E0012_55E5A69E0012_4BBC910E0391_Word_impl*
 Result := aTable.RowCount;
//#UC END# *55E5A69E0012_55E5A69E0012_4BBC910E0391_Word_impl*
end;//TkwPopTableRowCount.RowCount

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

function TkwPopTableCell.Cell(const aCtx: TtfwContext;
 const aTable: IedTable): IedCell;
 {* Реализация слова скрипта pop:Table:Cell }
//#UC START# *55E5A6B001EF_55E5A6B001EF_4BBC910E0391_Word_var*
//#UC END# *55E5A6B001EF_55E5A6B001EF_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A6B001EF_55E5A6B001EF_4BBC910E0391_Word_impl*
 Result := aTable.Cell;
//#UC END# *55E5A6B001EF_55E5A6B001EF_4BBC910E0391_Word_impl*
end;//TkwPopTableCell.Cell

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

function TkwPopTableCells.Cells(const aCtx: TtfwContext;
 const aTable: IedTable): IedCells;
 {* Реализация слова скрипта pop:Table:Cells }
//#UC START# *55E5A6C10230_55E5A6C10230_4BBC910E0391_Word_var*
//#UC END# *55E5A6C10230_55E5A6C10230_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A6C10230_55E5A6C10230_4BBC910E0391_Word_impl*
 Result := aTable.Cells;
//#UC END# *55E5A6C10230_55E5A6C10230_4BBC910E0391_Word_impl*
end;//TkwPopTableCells.Cells

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

function TkwPopTableColumn.Column(const aCtx: TtfwContext;
 const aTable: IedTable): IedColumn;
 {* Реализация слова скрипта pop:Table:Column }
//#UC START# *55E5A6D40041_55E5A6D40041_4BBC910E0391_Word_var*
//#UC END# *55E5A6D40041_55E5A6D40041_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A6D40041_55E5A6D40041_4BBC910E0391_Word_impl*
 Result := aTable.Column;
//#UC END# *55E5A6D40041_55E5A6D40041_4BBC910E0391_Word_impl*
end;//TkwPopTableColumn.Column

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

function TkwPopTableColumnsIterator.ColumnsIterator(const aCtx: TtfwContext;
 const aTable: IedTable): IedColumnsIterator;
 {* Реализация слова скрипта pop:Table:ColumnsIterator }
//#UC START# *55E5A7750138_55E5A7750138_4BBC910E0391_Word_var*
//#UC END# *55E5A7750138_55E5A7750138_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A7750138_55E5A7750138_4BBC910E0391_Word_impl*
 Result := aTable.ColumnsIterator;
//#UC END# *55E5A7750138_55E5A7750138_4BBC910E0391_Word_impl*
end;//TkwPopTableColumnsIterator.ColumnsIterator

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

function TkwPopTableRowsIterator.RowsIterator(const aCtx: TtfwContext;
 const aTable: IedTable): IedRowsIterator;
 {* Реализация слова скрипта pop:Table:RowsIterator }
//#UC START# *55E5A78C019B_55E5A78C019B_4BBC910E0391_Word_var*
//#UC END# *55E5A78C019B_55E5A78C019B_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A78C019B_55E5A78C019B_4BBC910E0391_Word_impl*
 Result := aTable.RowsIterator;
//#UC END# *55E5A78C019B_55E5A78C019B_4BBC910E0391_Word_impl*
end;//TkwPopTableRowsIterator.RowsIterator

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

class procedure TkwPopTableOldNSRC.DoSetValue(const aTable: IedTable;
 aValue: Boolean);
 {* Метод установки значения свойства OldNSRC }
//#UC START# *55E5A70E01E7_4BBC910E0391_Word_DoSetValue_55E5A70E01E7_4BBC910E0391_Word_var*
//#UC END# *55E5A70E01E7_4BBC910E0391_Word_DoSetValue_55E5A70E01E7_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A70E01E7_4BBC910E0391_Word_DoSetValue_55E5A70E01E7_4BBC910E0391_Word_impl*
 aTable.OldNSRC := aValue;
//#UC END# *55E5A70E01E7_4BBC910E0391_Word_DoSetValue_55E5A70E01E7_4BBC910E0391_Word_impl*
end;//TkwPopTableOldNSRC.DoSetValue

function TkwPopTableOldNSRC.OldNSRC(const aCtx: TtfwContext;
 const aTable: IedTable): Boolean;
 {* Реализация слова скрипта pop:Table:OldNSRC }
//#UC START# *55E5A70E01E7_55E5A70E01E7_4BBC910E0391_Word_var*
//#UC END# *55E5A70E01E7_55E5A70E01E7_4BBC910E0391_Word_var*
begin
//#UC START# *55E5A70E01E7_55E5A70E01E7_4BBC910E0391_Word_impl*
 Result := aTable.OldNSRC;
//#UC END# *55E5A70E01E7_55E5A70E01E7_4BBC910E0391_Word_impl*
end;//TkwPopTableOldNSRC.OldNSRC

class function TkwPopTableOldNSRC.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Table:OldNSRC';
end;//TkwPopTableOldNSRC.GetWordNameForRegister

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
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedTable));
 {* Регистрация типа IedTable }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
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
