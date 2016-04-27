unit TevCustomEditorWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\TevCustomEditorWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TevCustomEditorWordsPack" MUID: (55E46D4F03AE)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evCustomEditor
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , evEditorInterfaces
 , evdTypes
 , l3Interfaces
 , IedRangeWordsPack
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 TTevCustomEditorWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TTevCustomEditorWordsPackResNameGetter

 TkwPopEditorInsertTable = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:InsertTable
*Пример:*
[code]
 aColNum aRowNum aEditor pop:Editor:InsertTable
[code]  }
  private
   procedure InsertTable(const aCtx: TtfwContext;
    aEditor: TevCustomEditor;
    aRowNum: Integer;
    aColNum: Integer);
    {* Реализация слова скрипта pop:Editor:InsertTable }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorInsertTable

 TkwPopEditorInsertRow = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:InsertRow
*Пример:*
[code]
 aEditor pop:Editor:InsertRow
[code]  }
  private
   procedure InsertRow(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
    {* Реализация слова скрипта pop:Editor:InsertRow }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorInsertRow

 TkwPopEditorDeleteRow = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:DeleteRow
*Пример:*
[code]
 aEditor pop:Editor:DeleteRow
[code]  }
  private
   procedure DeleteRow(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
    {* Реализация слова скрипта pop:Editor:DeleteRow }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorDeleteRow

 TkwPopEditorInsertColumn = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:InsertColumn
*Пример:*
[code]
 aEditor pop:Editor:InsertColumn
[code]  }
  private
   procedure InsertColumn(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
    {* Реализация слова скрипта pop:Editor:InsertColumn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorInsertColumn

 TkwPopEditorDeleteColumn = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:DeleteColumn
*Пример:*
[code]
 aEditor pop:Editor:DeleteColumn
[code]  }
  private
   procedure DeleteColumn(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
    {* Реализация слова скрипта pop:Editor:DeleteColumn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorDeleteColumn

 TkwPopEditorMergeCells = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:MergeCells
*Пример:*
[code]
 anAlgorytm aEditor pop:Editor:MergeCells
[code]  }
  private
   procedure MergeCells(const aCtx: TtfwContext;
    aEditor: TevCustomEditor;
    anAlgorytm: TedMergeAlgorythm);
    {* Реализация слова скрипта pop:Editor:MergeCells }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorMergeCells

 TkwPopEditorSplitCell = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SplitCell
*Пример:*
[code]
 aVert aEditor pop:Editor:SplitCell
[code]  }
  private
   procedure SplitCell(const aCtx: TtfwContext;
    aEditor: TevCustomEditor;
    aVert: Boolean);
    {* Реализация слова скрипта pop:Editor:SplitCell }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorSplitCell

 TkwPopEditorSplitTable = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SplitTable
*Пример:*
[code]
 aEditor pop:Editor:SplitTable
[code]  }
  private
   procedure SplitTable(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
    {* Реализация слова скрипта pop:Editor:SplitTable }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorSplitTable

 TkwPopEditorMergeTables = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:MergeTables
*Пример:*
[code]
 aEditor pop:Editor:MergeTables
[code]  }
  private
   procedure MergeTables(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
    {* Реализация слова скрипта pop:Editor:MergeTables }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorMergeTables

 TkwPopEditorInsertSectionBreak = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:InsertSectionBreak
*Пример:*
[code]
 aPageOrientation aEditor pop:Editor:InsertSectionBreak
[code]  }
  private
   procedure InsertSectionBreak(const aCtx: TtfwContext;
    aEditor: TevCustomEditor;
    aPageOrientation: TevPageOrientation);
    {* Реализация слова скрипта pop:Editor:InsertSectionBreak }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorInsertSectionBreak

 TkwPopEditorPrevHyperlink = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:PrevHyperlink
*Пример:*
[code]
 aEditor pop:Editor:PrevHyperlink
[code]  }
  private
   procedure PrevHyperlink(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
    {* Реализация слова скрипта pop:Editor:PrevHyperlink }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorPrevHyperlink

 TkwPopEditorNextHyperlink = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:NextHyperlink
*Пример:*
[code]
 aEditor pop:Editor:NextHyperlink
[code]  }
  private
   procedure NextHyperlink(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
    {* Реализация слова скрипта pop:Editor:NextHyperlink }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorNextHyperlink

 TkwPopEditorRange = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:Range
*Тип результата:* IedRange
*Пример:*
[code]
INTERFACE VAR l_IedRange
 aEditor pop:Editor:Range >>> l_IedRange
[code]  }
  private
   function Range(const aCtx: TtfwContext;
    aEditor: TevCustomEditor): IedRange;
    {* Реализация слова скрипта pop:Editor:Range }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorRange

class function TTevCustomEditorWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'TevCustomEditorWordsPack';
end;//TTevCustomEditorWordsPackResNameGetter.ResName

 {$R TevCustomEditorWordsPack.res}

procedure TkwPopEditorInsertTable.InsertTable(const aCtx: TtfwContext;
 aEditor: TevCustomEditor;
 aRowNum: Integer;
 aColNum: Integer);
 {* Реализация слова скрипта pop:Editor:InsertTable }
//#UC START# *2A65ED70712B_A1BCB5D9397E_var*
//#UC END# *2A65ED70712B_A1BCB5D9397E_var*
begin
//#UC START# *2A65ED70712B_A1BCB5D9397E_impl*
 aEditor.InsertTable(aColNum, aRowNum);
//#UC END# *2A65ED70712B_A1BCB5D9397E_impl*
end;//TkwPopEditorInsertTable.InsertTable

procedure TkwPopEditorInsertTable.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
var l_aRowNum: Integer;
var l_aColNum: Integer;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aRowNum := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRowNum: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aColNum := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aColNum: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 InsertTable(aCtx, l_aEditor, l_aRowNum, l_aColNum);
end;//TkwPopEditorInsertTable.DoDoIt

function TkwPopEditorInsertTable.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorInsertTable.GetResultTypeInfo

function TkwPopEditorInsertTable.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwPopEditorInsertTable.GetAllParamsCount

function TkwPopEditorInsertTable.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor), TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwPopEditorInsertTable.ParamsTypes

class function TkwPopEditorInsertTable.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:InsertTable';
end;//TkwPopEditorInsertTable.GetWordNameForRegister

procedure TkwPopEditorInsertRow.InsertRow(const aCtx: TtfwContext;
 aEditor: TevCustomEditor);
 {* Реализация слова скрипта pop:Editor:InsertRow }
begin
 aEditor.InsertRow;
end;//TkwPopEditorInsertRow.InsertRow

procedure TkwPopEditorInsertRow.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 InsertRow(aCtx, l_aEditor);
end;//TkwPopEditorInsertRow.DoDoIt

function TkwPopEditorInsertRow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorInsertRow.GetResultTypeInfo

function TkwPopEditorInsertRow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorInsertRow.GetAllParamsCount

function TkwPopEditorInsertRow.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorInsertRow.ParamsTypes

class function TkwPopEditorInsertRow.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:InsertRow';
end;//TkwPopEditorInsertRow.GetWordNameForRegister

procedure TkwPopEditorDeleteRow.DeleteRow(const aCtx: TtfwContext;
 aEditor: TevCustomEditor);
 {* Реализация слова скрипта pop:Editor:DeleteRow }
begin
 aEditor.DeleteRow;
end;//TkwPopEditorDeleteRow.DeleteRow

procedure TkwPopEditorDeleteRow.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DeleteRow(aCtx, l_aEditor);
end;//TkwPopEditorDeleteRow.DoDoIt

function TkwPopEditorDeleteRow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorDeleteRow.GetResultTypeInfo

function TkwPopEditorDeleteRow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorDeleteRow.GetAllParamsCount

function TkwPopEditorDeleteRow.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorDeleteRow.ParamsTypes

class function TkwPopEditorDeleteRow.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:DeleteRow';
end;//TkwPopEditorDeleteRow.GetWordNameForRegister

procedure TkwPopEditorInsertColumn.InsertColumn(const aCtx: TtfwContext;
 aEditor: TevCustomEditor);
 {* Реализация слова скрипта pop:Editor:InsertColumn }
begin
 aEditor.InsertColumn;
end;//TkwPopEditorInsertColumn.InsertColumn

procedure TkwPopEditorInsertColumn.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 InsertColumn(aCtx, l_aEditor);
end;//TkwPopEditorInsertColumn.DoDoIt

function TkwPopEditorInsertColumn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorInsertColumn.GetResultTypeInfo

function TkwPopEditorInsertColumn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorInsertColumn.GetAllParamsCount

function TkwPopEditorInsertColumn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorInsertColumn.ParamsTypes

class function TkwPopEditorInsertColumn.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:InsertColumn';
end;//TkwPopEditorInsertColumn.GetWordNameForRegister

procedure TkwPopEditorDeleteColumn.DeleteColumn(const aCtx: TtfwContext;
 aEditor: TevCustomEditor);
 {* Реализация слова скрипта pop:Editor:DeleteColumn }
begin
 aEditor.DeleteColumn;
end;//TkwPopEditorDeleteColumn.DeleteColumn

procedure TkwPopEditorDeleteColumn.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DeleteColumn(aCtx, l_aEditor);
end;//TkwPopEditorDeleteColumn.DoDoIt

function TkwPopEditorDeleteColumn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorDeleteColumn.GetResultTypeInfo

function TkwPopEditorDeleteColumn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorDeleteColumn.GetAllParamsCount

function TkwPopEditorDeleteColumn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorDeleteColumn.ParamsTypes

class function TkwPopEditorDeleteColumn.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:DeleteColumn';
end;//TkwPopEditorDeleteColumn.GetWordNameForRegister

procedure TkwPopEditorMergeCells.MergeCells(const aCtx: TtfwContext;
 aEditor: TevCustomEditor;
 anAlgorytm: TedMergeAlgorythm);
 {* Реализация слова скрипта pop:Editor:MergeCells }
//#UC START# *1D5492E02FD7_A451D154F580_var*
var
 l_Table     : IedTable;
 l_Range     : IedRange;
 l_Cells     : IedCells;
//#UC END# *1D5492E02FD7_A451D154F580_var*
begin
//#UC START# *1D5492E02FD7_A451D154F580_impl*
 l_Range := aEditor.Range;
 if (l_Range = nil) then
  RunnerError('Не удалось получить выделение.', aCtx);
 l_Table := l_Range.Table;
 if (l_Table = nil) then
  RunnerError('Не удалось получить таблицу!', aCtx);
 l_Cells := l_Table.Cells;
 if (l_Cells = nil) then
  RunnerError('Не удалось получить диапазон ячеек!', aCtx);
 l_Cells.Merge(anAlgorytm);
//#UC END# *1D5492E02FD7_A451D154F580_impl*
end;//TkwPopEditorMergeCells.MergeCells

procedure TkwPopEditorMergeCells.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
var l_anAlgorytm: TedMergeAlgorythm;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anAlgorytm := TedMergeAlgorythm(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anAlgorytm: TedMergeAlgorythm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MergeCells(aCtx, l_aEditor, l_anAlgorytm);
end;//TkwPopEditorMergeCells.DoDoIt

function TkwPopEditorMergeCells.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorMergeCells.GetResultTypeInfo

function TkwPopEditorMergeCells.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopEditorMergeCells.GetAllParamsCount

function TkwPopEditorMergeCells.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor), TypeInfo(TedMergeAlgorythm)]);
end;//TkwPopEditorMergeCells.ParamsTypes

class function TkwPopEditorMergeCells.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:MergeCells';
end;//TkwPopEditorMergeCells.GetWordNameForRegister

procedure TkwPopEditorSplitCell.SplitCell(const aCtx: TtfwContext;
 aEditor: TevCustomEditor;
 aVert: Boolean);
 {* Реализация слова скрипта pop:Editor:SplitCell }
//#UC START# *FC2B610EC587_3AC5FB50949B_var*
var
 l_Cell : IedCell;
 l_Table: IedTable;
//#UC END# *FC2B610EC587_3AC5FB50949B_var*
begin
//#UC START# *FC2B610EC587_3AC5FB50949B_impl*
 l_Table := aEditor.Range.Table;
 if (l_Table <> nil) then
 begin
  l_Cell := l_Table.Cell;
  if (l_Cell <> nil) then
  begin
   if aVert then
    l_Cell.Split(ev_orVertical)
   else
    l_Cell.Split(ev_orHorizontal);
  end;//l_Cell <> nil
 end;//l_Table <> nil
//#UC END# *FC2B610EC587_3AC5FB50949B_impl*
end;//TkwPopEditorSplitCell.SplitCell

procedure TkwPopEditorSplitCell.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
var l_aVert: Boolean;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aVert := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aVert: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SplitCell(aCtx, l_aEditor, l_aVert);
end;//TkwPopEditorSplitCell.DoDoIt

function TkwPopEditorSplitCell.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorSplitCell.GetResultTypeInfo

function TkwPopEditorSplitCell.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopEditorSplitCell.GetAllParamsCount

function TkwPopEditorSplitCell.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor), TypeInfo(Boolean)]);
end;//TkwPopEditorSplitCell.ParamsTypes

class function TkwPopEditorSplitCell.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:SplitCell';
end;//TkwPopEditorSplitCell.GetWordNameForRegister

procedure TkwPopEditorSplitTable.SplitTable(const aCtx: TtfwContext;
 aEditor: TevCustomEditor);
 {* Реализация слова скрипта pop:Editor:SplitTable }
//#UC START# *4F994DADAE61_AA4E45C58AA3_var*
var
 l_Table: IedTable;
//#UC END# *4F994DADAE61_AA4E45C58AA3_var*
begin
//#UC START# *4F994DADAE61_AA4E45C58AA3_impl*
 l_Table := aEditor.Range.Table;
 if (l_Table = nil) then
  RunnerError('Курсор не находится в таблице.', aCtx)
 else
  aCtx.rCaller.Check(l_Table.Split(aEditor.TextSource.Indicator), 'Разделение таблицы закончелось неудачей.')
//#UC END# *4F994DADAE61_AA4E45C58AA3_impl*
end;//TkwPopEditorSplitTable.SplitTable

procedure TkwPopEditorSplitTable.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SplitTable(aCtx, l_aEditor);
end;//TkwPopEditorSplitTable.DoDoIt

function TkwPopEditorSplitTable.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorSplitTable.GetResultTypeInfo

function TkwPopEditorSplitTable.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorSplitTable.GetAllParamsCount

function TkwPopEditorSplitTable.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorSplitTable.ParamsTypes

class function TkwPopEditorSplitTable.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:SplitTable';
end;//TkwPopEditorSplitTable.GetWordNameForRegister

procedure TkwPopEditorMergeTables.MergeTables(const aCtx: TtfwContext;
 aEditor: TevCustomEditor);
 {* Реализация слова скрипта pop:Editor:MergeTables }
//#UC START# *7C77C501EF5C_E73997E799CF_var*
var
 l_Table: IedTable;
//#UC END# *7C77C501EF5C_E73997E799CF_var*
begin
//#UC START# *7C77C501EF5C_E73997E799CF_impl*
 l_Table := aEditor.Range.Table;
 if (l_Table = nil) then
  RunnerError('Курсор не находится в таблице.', aCtx)
 else
  aCtx.rCaller.Check(l_Table.Merge(aEditor.TextSource.Indicator), 'Объединение таблицы закончелось неудачей.')
//#UC END# *7C77C501EF5C_E73997E799CF_impl*
end;//TkwPopEditorMergeTables.MergeTables

procedure TkwPopEditorMergeTables.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MergeTables(aCtx, l_aEditor);
end;//TkwPopEditorMergeTables.DoDoIt

function TkwPopEditorMergeTables.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorMergeTables.GetResultTypeInfo

function TkwPopEditorMergeTables.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorMergeTables.GetAllParamsCount

function TkwPopEditorMergeTables.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorMergeTables.ParamsTypes

class function TkwPopEditorMergeTables.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:MergeTables';
end;//TkwPopEditorMergeTables.GetWordNameForRegister

procedure TkwPopEditorInsertSectionBreak.InsertSectionBreak(const aCtx: TtfwContext;
 aEditor: TevCustomEditor;
 aPageOrientation: TevPageOrientation);
 {* Реализация слова скрипта pop:Editor:InsertSectionBreak }
//#UC START# *20D4E8106F99_5C1388B33B3A_var*
//#UC END# *20D4E8106F99_5C1388B33B3A_var*
begin
//#UC START# *20D4E8106F99_5C1388B33B3A_impl*
 aEditor.InsertPageBreak(True, aPageOrientation);
//#UC END# *20D4E8106F99_5C1388B33B3A_impl*
end;//TkwPopEditorInsertSectionBreak.InsertSectionBreak

procedure TkwPopEditorInsertSectionBreak.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
var l_aPageOrientation: TevPageOrientation;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPageOrientation := TevPageOrientation(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPageOrientation: TevPageOrientation : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 InsertSectionBreak(aCtx, l_aEditor, l_aPageOrientation);
end;//TkwPopEditorInsertSectionBreak.DoDoIt

function TkwPopEditorInsertSectionBreak.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorInsertSectionBreak.GetResultTypeInfo

function TkwPopEditorInsertSectionBreak.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopEditorInsertSectionBreak.GetAllParamsCount

function TkwPopEditorInsertSectionBreak.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor), TypeInfo(TevPageOrientation)]);
end;//TkwPopEditorInsertSectionBreak.ParamsTypes

class function TkwPopEditorInsertSectionBreak.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:InsertSectionBreak';
end;//TkwPopEditorInsertSectionBreak.GetWordNameForRegister

procedure TkwPopEditorPrevHyperlink.PrevHyperlink(const aCtx: TtfwContext;
 aEditor: TevCustomEditor);
 {* Реализация слова скрипта pop:Editor:PrevHyperlink }
//#UC START# *DB7F8A6A9D94_B77C574814C1_var*
//#UC END# *DB7F8A6A9D94_B77C574814C1_var*
begin
//#UC START# *DB7F8A6A9D94_B77C574814C1_impl*
 aEditor.PrevHyperlink(False);
//#UC END# *DB7F8A6A9D94_B77C574814C1_impl*
end;//TkwPopEditorPrevHyperlink.PrevHyperlink

procedure TkwPopEditorPrevHyperlink.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PrevHyperlink(aCtx, l_aEditor);
end;//TkwPopEditorPrevHyperlink.DoDoIt

function TkwPopEditorPrevHyperlink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorPrevHyperlink.GetResultTypeInfo

function TkwPopEditorPrevHyperlink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorPrevHyperlink.GetAllParamsCount

function TkwPopEditorPrevHyperlink.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorPrevHyperlink.ParamsTypes

class function TkwPopEditorPrevHyperlink.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:PrevHyperlink';
end;//TkwPopEditorPrevHyperlink.GetWordNameForRegister

procedure TkwPopEditorNextHyperlink.NextHyperlink(const aCtx: TtfwContext;
 aEditor: TevCustomEditor);
 {* Реализация слова скрипта pop:Editor:NextHyperlink }
//#UC START# *8C3D0835326B_F05E0D5E838A_var*
//#UC END# *8C3D0835326B_F05E0D5E838A_var*
begin
//#UC START# *8C3D0835326B_F05E0D5E838A_impl*
 aEditor.NextHyperlink(False);
//#UC END# *8C3D0835326B_F05E0D5E838A_impl*
end;//TkwPopEditorNextHyperlink.NextHyperlink

procedure TkwPopEditorNextHyperlink.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 NextHyperlink(aCtx, l_aEditor);
end;//TkwPopEditorNextHyperlink.DoDoIt

function TkwPopEditorNextHyperlink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorNextHyperlink.GetResultTypeInfo

function TkwPopEditorNextHyperlink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorNextHyperlink.GetAllParamsCount

function TkwPopEditorNextHyperlink.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorNextHyperlink.ParamsTypes

class function TkwPopEditorNextHyperlink.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:NextHyperlink';
end;//TkwPopEditorNextHyperlink.GetWordNameForRegister

function TkwPopEditorRange.Range(const aCtx: TtfwContext;
 aEditor: TevCustomEditor): IedRange;
 {* Реализация слова скрипта pop:Editor:Range }
//#UC START# *7884E20C97ED_47D4B4C536FD_var*
//#UC END# *7884E20C97ED_47D4B4C536FD_var*
begin
//#UC START# *7884E20C97ED_47D4B4C536FD_impl*
 Result := aEditor.Range;
//#UC END# *7884E20C97ED_47D4B4C536FD_impl*
end;//TkwPopEditorRange.Range

procedure TkwPopEditorRange.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(Range(aCtx, l_aEditor), TypeInfo(IedRange));
end;//TkwPopEditorRange.DoDoIt

function TkwPopEditorRange.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(IedRange);
end;//TkwPopEditorRange.GetResultTypeInfo

function TkwPopEditorRange.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorRange.GetAllParamsCount

function TkwPopEditorRange.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorRange.ParamsTypes

class function TkwPopEditorRange.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:Range';
end;//TkwPopEditorRange.GetWordNameForRegister

initialization
 TTevCustomEditorWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwPopEditorInsertTable.RegisterInEngine;
 {* Регистрация pop_Editor_InsertTable }
 TkwPopEditorInsertRow.RegisterInEngine;
 {* Регистрация pop_Editor_InsertRow }
 TkwPopEditorDeleteRow.RegisterInEngine;
 {* Регистрация pop_Editor_DeleteRow }
 TkwPopEditorInsertColumn.RegisterInEngine;
 {* Регистрация pop_Editor_InsertColumn }
 TkwPopEditorDeleteColumn.RegisterInEngine;
 {* Регистрация pop_Editor_DeleteColumn }
 TkwPopEditorMergeCells.RegisterInEngine;
 {* Регистрация pop_Editor_MergeCells }
 TkwPopEditorSplitCell.RegisterInEngine;
 {* Регистрация pop_Editor_SplitCell }
 TkwPopEditorSplitTable.RegisterInEngine;
 {* Регистрация pop_Editor_SplitTable }
 TkwPopEditorMergeTables.RegisterInEngine;
 {* Регистрация pop_Editor_MergeTables }
 TkwPopEditorInsertSectionBreak.RegisterInEngine;
 {* Регистрация pop_Editor_InsertSectionBreak }
 TkwPopEditorPrevHyperlink.RegisterInEngine;
 {* Регистрация pop_Editor_PrevHyperlink }
 TkwPopEditorNextHyperlink.RegisterInEngine;
 {* Регистрация pop_Editor_NextHyperlink }
 TkwPopEditorRange.RegisterInEngine;
 {* Регистрация pop_Editor_Range }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevCustomEditor));
 {* Регистрация типа TevCustomEditor }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TedMergeAlgorythm));
 {* Регистрация типа TedMergeAlgorythm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevPageOrientation));
 {* Регистрация типа PageOrientation }
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedRange));
 {* Регистрация типа IedRange }
{$IfEnd} // NOT Defined(NoScripts)

end.
