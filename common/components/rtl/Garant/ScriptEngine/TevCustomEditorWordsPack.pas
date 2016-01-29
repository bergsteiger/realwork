unit TevCustomEditorWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Everest"
// ������: "TevCustomEditorWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$Everest::EditorFromStackKeyWords::TevCustomEditorWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  evdTypes,
  evCustomEditor,
  evEditorInterfaces,
  tfwScriptingInterfaces,
  tfwAxiomaticsResNameGetter,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  IedRangeWordsPack,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *D2EC9F607FB9ci*
//#UC END# *D2EC9F607FB9ci*
//#UC START# *D2EC9F607FB9cit*
//#UC END# *D2EC9F607FB9cit*
 TTevCustomEditorWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *D2EC9F607FB9publ*
//#UC END# *D2EC9F607FB9publ*
 end;//TTevCustomEditorWordsPackResNameGetter

// start class TTevCustomEditorWordsPackResNameGetter

class function TTevCustomEditorWordsPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'TevCustomEditorWordsPack';
end;//TTevCustomEditorWordsPackResNameGetter.ResName

 {$R TevCustomEditorWordsPack.res}

type
 TkwPopEditorInsertTable = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:InsertTable
*������:*
[code]
 aColNum aRowNum aEditor pop:Editor:InsertTable
[code]  }
 private
 // private methods
   procedure InsertTable(const aCtx: TtfwContext;
    aEditor: TevCustomEditor;
    aRowNum: Integer;
    aColNum: Integer);
     {* ���������� ����� ������� pop:Editor:InsertTable }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorInsertTable

// start class TkwPopEditorInsertTable

procedure TkwPopEditorInsertTable.InsertTable(const aCtx: TtfwContext;
  aEditor: TevCustomEditor;
  aRowNum: Integer;
  aColNum: Integer);
//#UC START# *2A65ED70712B_A1BCB5D9397E_var*
//#UC END# *2A65ED70712B_A1BCB5D9397E_var*
begin
//#UC START# *2A65ED70712B_A1BCB5D9397E_impl*
 aEditor.InsertTable(aColNum, aRowNum);
//#UC END# *2A65ED70712B_A1BCB5D9397E_impl*
end;//TkwPopEditorInsertTable.InsertTable

procedure TkwPopEditorInsertTable.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
 l_aRowNum : Integer;
 l_aColNum : Integer;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aRowNum := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRowNum: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aColNum := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aColNum: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 InsertTable(aCtx, l_aEditor, l_aRowNum, l_aColNum);
end;//TkwPopEditorInsertTable.DoDoIt

class function TkwPopEditorInsertTable.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:InsertTable';
end;//TkwPopEditorInsertTable.GetWordNameForRegister

function TkwPopEditorInsertTable.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorInsertTable.GetResultTypeInfo

function TkwPopEditorInsertTable.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2 + 1;
end;//TkwPopEditorInsertTable.GetAllParamsCount

function TkwPopEditorInsertTable.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor), TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwPopEditorInsertTable.ParamsTypes

type
 TkwPopEditorInsertRow = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:InsertRow
*������:*
[code]
 aEditor pop:Editor:InsertRow
[code]  }
 private
 // private methods
   procedure InsertRow(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
     {* ���������� ����� ������� pop:Editor:InsertRow }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorInsertRow

// start class TkwPopEditorInsertRow

procedure TkwPopEditorInsertRow.InsertRow(const aCtx: TtfwContext;
  aEditor: TevCustomEditor);
 {-}
begin
 aEditor.InsertRow;
end;//TkwPopEditorInsertRow.InsertRow

procedure TkwPopEditorInsertRow.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 InsertRow(aCtx, l_aEditor);
end;//TkwPopEditorInsertRow.DoDoIt

class function TkwPopEditorInsertRow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:InsertRow';
end;//TkwPopEditorInsertRow.GetWordNameForRegister

function TkwPopEditorInsertRow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorInsertRow.GetResultTypeInfo

function TkwPopEditorInsertRow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopEditorInsertRow.GetAllParamsCount

function TkwPopEditorInsertRow.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorInsertRow.ParamsTypes

type
 TkwPopEditorDeleteRow = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:DeleteRow
*������:*
[code]
 aEditor pop:Editor:DeleteRow
[code]  }
 private
 // private methods
   procedure DeleteRow(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
     {* ���������� ����� ������� pop:Editor:DeleteRow }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorDeleteRow

// start class TkwPopEditorDeleteRow

procedure TkwPopEditorDeleteRow.DeleteRow(const aCtx: TtfwContext;
  aEditor: TevCustomEditor);
 {-}
begin
 aEditor.DeleteRow;
end;//TkwPopEditorDeleteRow.DeleteRow

procedure TkwPopEditorDeleteRow.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DeleteRow(aCtx, l_aEditor);
end;//TkwPopEditorDeleteRow.DoDoIt

class function TkwPopEditorDeleteRow.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:DeleteRow';
end;//TkwPopEditorDeleteRow.GetWordNameForRegister

function TkwPopEditorDeleteRow.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorDeleteRow.GetResultTypeInfo

function TkwPopEditorDeleteRow.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopEditorDeleteRow.GetAllParamsCount

function TkwPopEditorDeleteRow.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorDeleteRow.ParamsTypes

type
 TkwPopEditorInsertColumn = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:InsertColumn
*������:*
[code]
 aEditor pop:Editor:InsertColumn
[code]  }
 private
 // private methods
   procedure InsertColumn(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
     {* ���������� ����� ������� pop:Editor:InsertColumn }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorInsertColumn

// start class TkwPopEditorInsertColumn

procedure TkwPopEditorInsertColumn.InsertColumn(const aCtx: TtfwContext;
  aEditor: TevCustomEditor);
 {-}
begin
 aEditor.InsertColumn;
end;//TkwPopEditorInsertColumn.InsertColumn

procedure TkwPopEditorInsertColumn.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 InsertColumn(aCtx, l_aEditor);
end;//TkwPopEditorInsertColumn.DoDoIt

class function TkwPopEditorInsertColumn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:InsertColumn';
end;//TkwPopEditorInsertColumn.GetWordNameForRegister

function TkwPopEditorInsertColumn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorInsertColumn.GetResultTypeInfo

function TkwPopEditorInsertColumn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopEditorInsertColumn.GetAllParamsCount

function TkwPopEditorInsertColumn.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorInsertColumn.ParamsTypes

type
 TkwPopEditorDeleteColumn = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:DeleteColumn
*������:*
[code]
 aEditor pop:Editor:DeleteColumn
[code]  }
 private
 // private methods
   procedure DeleteColumn(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
     {* ���������� ����� ������� pop:Editor:DeleteColumn }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorDeleteColumn

// start class TkwPopEditorDeleteColumn

procedure TkwPopEditorDeleteColumn.DeleteColumn(const aCtx: TtfwContext;
  aEditor: TevCustomEditor);
 {-}
begin
 aEditor.DeleteColumn;
end;//TkwPopEditorDeleteColumn.DeleteColumn

procedure TkwPopEditorDeleteColumn.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DeleteColumn(aCtx, l_aEditor);
end;//TkwPopEditorDeleteColumn.DoDoIt

class function TkwPopEditorDeleteColumn.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:DeleteColumn';
end;//TkwPopEditorDeleteColumn.GetWordNameForRegister

function TkwPopEditorDeleteColumn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorDeleteColumn.GetResultTypeInfo

function TkwPopEditorDeleteColumn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopEditorDeleteColumn.GetAllParamsCount

function TkwPopEditorDeleteColumn.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorDeleteColumn.ParamsTypes

type
 TkwPopEditorMergeCells = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:MergeCells
*������:*
[code]
 anAlgorytm aEditor pop:Editor:MergeCells
[code]  }
 private
 // private methods
   procedure MergeCells(const aCtx: TtfwContext;
    aEditor: TevCustomEditor;
    anAlgorytm: TedMergeAlgorythm);
     {* ���������� ����� ������� pop:Editor:MergeCells }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorMergeCells

// start class TkwPopEditorMergeCells

procedure TkwPopEditorMergeCells.MergeCells(const aCtx: TtfwContext;
  aEditor: TevCustomEditor;
  anAlgorytm: TedMergeAlgorythm);
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
  RunnerError('�� ������� �������� ���������.', aCtx);
 l_Table := l_Range.Table;
 if (l_Table = nil) then
  RunnerError('�� ������� �������� �������!', aCtx);
 l_Cells := l_Table.Cells;
 if (l_Cells = nil) then
  RunnerError('�� ������� �������� �������� �����!', aCtx);
 l_Cells.Merge(anAlgorytm);
//#UC END# *1D5492E02FD7_A451D154F580_impl*
end;//TkwPopEditorMergeCells.MergeCells

procedure TkwPopEditorMergeCells.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
 l_anAlgorytm : TedMergeAlgorythm;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anAlgorytm := TedMergeAlgorythm(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anAlgorytm: TedMergeAlgorythm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MergeCells(aCtx, l_aEditor, l_anAlgorytm);
end;//TkwPopEditorMergeCells.DoDoIt

class function TkwPopEditorMergeCells.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:MergeCells';
end;//TkwPopEditorMergeCells.GetWordNameForRegister

function TkwPopEditorMergeCells.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorMergeCells.GetResultTypeInfo

function TkwPopEditorMergeCells.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopEditorMergeCells.GetAllParamsCount

function TkwPopEditorMergeCells.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor), TypeInfo(TedMergeAlgorythm)]);
end;//TkwPopEditorMergeCells.ParamsTypes

type
 TkwPopEditorSplitCell = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:SplitCell
*������:*
[code]
 aVert aEditor pop:Editor:SplitCell
[code]  }
 private
 // private methods
   procedure SplitCell(const aCtx: TtfwContext;
    aEditor: TevCustomEditor;
    aVert: Boolean);
     {* ���������� ����� ������� pop:Editor:SplitCell }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorSplitCell

// start class TkwPopEditorSplitCell

procedure TkwPopEditorSplitCell.SplitCell(const aCtx: TtfwContext;
  aEditor: TevCustomEditor;
  aVert: Boolean);
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
 {-}
var
 l_aEditor : TevCustomEditor;
 l_aVert : Boolean;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aVert := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aVert: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SplitCell(aCtx, l_aEditor, l_aVert);
end;//TkwPopEditorSplitCell.DoDoIt

class function TkwPopEditorSplitCell.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:SplitCell';
end;//TkwPopEditorSplitCell.GetWordNameForRegister

function TkwPopEditorSplitCell.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorSplitCell.GetResultTypeInfo

function TkwPopEditorSplitCell.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopEditorSplitCell.GetAllParamsCount

function TkwPopEditorSplitCell.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor), TypeInfo(Boolean)]);
end;//TkwPopEditorSplitCell.ParamsTypes

type
 TkwPopEditorSplitTable = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:SplitTable
*������:*
[code]
 aEditor pop:Editor:SplitTable
[code]  }
 private
 // private methods
   procedure SplitTable(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
     {* ���������� ����� ������� pop:Editor:SplitTable }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorSplitTable

// start class TkwPopEditorSplitTable

procedure TkwPopEditorSplitTable.SplitTable(const aCtx: TtfwContext;
  aEditor: TevCustomEditor);
//#UC START# *4F994DADAE61_AA4E45C58AA3_var*
var
 l_Table: IedTable;
//#UC END# *4F994DADAE61_AA4E45C58AA3_var*
begin
//#UC START# *4F994DADAE61_AA4E45C58AA3_impl*
 l_Table := aEditor.Range.Table;
 if (l_Table = nil) then
  RunnerError('������ �� ��������� � �������.', aCtx)
 else
  aCtx.rCaller.Check(l_Table.Split(aEditor.TextSource.Indicator), '���������� ������� ����������� ��������.')
//#UC END# *4F994DADAE61_AA4E45C58AA3_impl*
end;//TkwPopEditorSplitTable.SplitTable

procedure TkwPopEditorSplitTable.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SplitTable(aCtx, l_aEditor);
end;//TkwPopEditorSplitTable.DoDoIt

class function TkwPopEditorSplitTable.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:SplitTable';
end;//TkwPopEditorSplitTable.GetWordNameForRegister

function TkwPopEditorSplitTable.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorSplitTable.GetResultTypeInfo

function TkwPopEditorSplitTable.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopEditorSplitTable.GetAllParamsCount

function TkwPopEditorSplitTable.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorSplitTable.ParamsTypes

type
 TkwPopEditorMergeTables = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:MergeTables
*������:*
[code]
 aEditor pop:Editor:MergeTables
[code]  }
 private
 // private methods
   procedure MergeTables(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
     {* ���������� ����� ������� pop:Editor:MergeTables }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorMergeTables

// start class TkwPopEditorMergeTables

procedure TkwPopEditorMergeTables.MergeTables(const aCtx: TtfwContext;
  aEditor: TevCustomEditor);
//#UC START# *7C77C501EF5C_E73997E799CF_var*
var
 l_Table: IedTable;
//#UC END# *7C77C501EF5C_E73997E799CF_var*
begin
//#UC START# *7C77C501EF5C_E73997E799CF_impl*
 l_Table := aEditor.Range.Table;
 if (l_Table = nil) then
  RunnerError('������ �� ��������� � �������.', aCtx)
 else
  aCtx.rCaller.Check(l_Table.Merge(aEditor.TextSource.Indicator), '����������� ������� ����������� ��������.')
//#UC END# *7C77C501EF5C_E73997E799CF_impl*
end;//TkwPopEditorMergeTables.MergeTables

procedure TkwPopEditorMergeTables.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 MergeTables(aCtx, l_aEditor);
end;//TkwPopEditorMergeTables.DoDoIt

class function TkwPopEditorMergeTables.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:MergeTables';
end;//TkwPopEditorMergeTables.GetWordNameForRegister

function TkwPopEditorMergeTables.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorMergeTables.GetResultTypeInfo

function TkwPopEditorMergeTables.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopEditorMergeTables.GetAllParamsCount

function TkwPopEditorMergeTables.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorMergeTables.ParamsTypes

type
 TkwPopEditorInsertSectionBreak = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:InsertSectionBreak
*������:*
[code]
 aPageOrientation aEditor pop:Editor:InsertSectionBreak
[code]  }
 private
 // private methods
   procedure InsertSectionBreak(const aCtx: TtfwContext;
    aEditor: TevCustomEditor;
    aPageOrientation: TevPageOrientation);
     {* ���������� ����� ������� pop:Editor:InsertSectionBreak }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorInsertSectionBreak

// start class TkwPopEditorInsertSectionBreak

procedure TkwPopEditorInsertSectionBreak.InsertSectionBreak(const aCtx: TtfwContext;
  aEditor: TevCustomEditor;
  aPageOrientation: TevPageOrientation);
//#UC START# *20D4E8106F99_5C1388B33B3A_var*
//#UC END# *20D4E8106F99_5C1388B33B3A_var*
begin
//#UC START# *20D4E8106F99_5C1388B33B3A_impl*
 aEditor.InsertPageBreak(True, aPageOrientation);
//#UC END# *20D4E8106F99_5C1388B33B3A_impl*
end;//TkwPopEditorInsertSectionBreak.InsertSectionBreak

procedure TkwPopEditorInsertSectionBreak.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
 l_aPageOrientation : TevPageOrientation;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aPageOrientation := TevPageOrientation(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aPageOrientation: TevPageOrientation : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 InsertSectionBreak(aCtx, l_aEditor, l_aPageOrientation);
end;//TkwPopEditorInsertSectionBreak.DoDoIt

class function TkwPopEditorInsertSectionBreak.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:InsertSectionBreak';
end;//TkwPopEditorInsertSectionBreak.GetWordNameForRegister

function TkwPopEditorInsertSectionBreak.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorInsertSectionBreak.GetResultTypeInfo

function TkwPopEditorInsertSectionBreak.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopEditorInsertSectionBreak.GetAllParamsCount

function TkwPopEditorInsertSectionBreak.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor), TypeInfo(TevPageOrientation)]);
end;//TkwPopEditorInsertSectionBreak.ParamsTypes

type
 TkwPopEditorPrevHyperlink = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:PrevHyperlink
*������:*
[code]
 aEditor pop:Editor:PrevHyperlink
[code]  }
 private
 // private methods
   procedure PrevHyperlink(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
     {* ���������� ����� ������� pop:Editor:PrevHyperlink }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorPrevHyperlink

// start class TkwPopEditorPrevHyperlink

procedure TkwPopEditorPrevHyperlink.PrevHyperlink(const aCtx: TtfwContext;
  aEditor: TevCustomEditor);
//#UC START# *DB7F8A6A9D94_B77C574814C1_var*
//#UC END# *DB7F8A6A9D94_B77C574814C1_var*
begin
//#UC START# *DB7F8A6A9D94_B77C574814C1_impl*
 aEditor.PrevHyperlink(False);
//#UC END# *DB7F8A6A9D94_B77C574814C1_impl*
end;//TkwPopEditorPrevHyperlink.PrevHyperlink

procedure TkwPopEditorPrevHyperlink.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PrevHyperlink(aCtx, l_aEditor);
end;//TkwPopEditorPrevHyperlink.DoDoIt

class function TkwPopEditorPrevHyperlink.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:PrevHyperlink';
end;//TkwPopEditorPrevHyperlink.GetWordNameForRegister

function TkwPopEditorPrevHyperlink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorPrevHyperlink.GetResultTypeInfo

function TkwPopEditorPrevHyperlink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopEditorPrevHyperlink.GetAllParamsCount

function TkwPopEditorPrevHyperlink.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorPrevHyperlink.ParamsTypes

type
 TkwPopEditorNextHyperlink = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:NextHyperlink
*������:*
[code]
 aEditor pop:Editor:NextHyperlink
[code]  }
 private
 // private methods
   procedure NextHyperlink(const aCtx: TtfwContext;
    aEditor: TevCustomEditor);
     {* ���������� ����� ������� pop:Editor:NextHyperlink }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorNextHyperlink

// start class TkwPopEditorNextHyperlink

procedure TkwPopEditorNextHyperlink.NextHyperlink(const aCtx: TtfwContext;
  aEditor: TevCustomEditor);
//#UC START# *8C3D0835326B_F05E0D5E838A_var*
//#UC END# *8C3D0835326B_F05E0D5E838A_var*
begin
//#UC START# *8C3D0835326B_F05E0D5E838A_impl*
 aEditor.NextHyperlink(False);
//#UC END# *8C3D0835326B_F05E0D5E838A_impl*
end;//TkwPopEditorNextHyperlink.NextHyperlink

procedure TkwPopEditorNextHyperlink.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 NextHyperlink(aCtx, l_aEditor);
end;//TkwPopEditorNextHyperlink.DoDoIt

class function TkwPopEditorNextHyperlink.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:NextHyperlink';
end;//TkwPopEditorNextHyperlink.GetWordNameForRegister

function TkwPopEditorNextHyperlink.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorNextHyperlink.GetResultTypeInfo

function TkwPopEditorNextHyperlink.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopEditorNextHyperlink.GetAllParamsCount

function TkwPopEditorNextHyperlink.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorNextHyperlink.ParamsTypes

type
 TkwPopEditorRange = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Editor:Range
*��� ����������:* IedRange
*������:*
[code]
INTERFACE VAR l_IedRange
 aEditor pop:Editor:Range >>> l_IedRange
[code]  }
 private
 // private methods
   function Range(const aCtx: TtfwContext;
    aEditor: TevCustomEditor): IedRange;
     {* ���������� ����� ������� pop:Editor:Range }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorRange

// start class TkwPopEditorRange

function TkwPopEditorRange.Range(const aCtx: TtfwContext;
  aEditor: TevCustomEditor): IedRange;
//#UC START# *7884E20C97ED_47D4B4C536FD_var*
//#UC END# *7884E20C97ED_47D4B4C536FD_var*
begin
//#UC START# *7884E20C97ED_47D4B4C536FD_impl*
 Result := aEditor.Range;
//#UC END# *7884E20C97ED_47D4B4C536FD_impl*
end;//TkwPopEditorRange.Range

procedure TkwPopEditorRange.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aEditor : TevCustomEditor;
begin
 try
  l_aEditor := TevCustomEditor(aCtx.rEngine.PopObjAs(TevCustomEditor));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TevCustomEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf((Range(aCtx, l_aEditor)), TypeInfo(IedRange));
end;//TkwPopEditorRange.DoDoIt

class function TkwPopEditorRange.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Editor:Range';
end;//TkwPopEditorRange.GetWordNameForRegister

function TkwPopEditorRange.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(IedRange);
end;//TkwPopEditorRange.GetResultTypeInfo

function TkwPopEditorRange.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopEditorRange.GetAllParamsCount

function TkwPopEditorRange.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditor)]);
end;//TkwPopEditorRange.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� ������������ �����������
 TTevCustomEditorWordsPackResNameGetter.Register;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_InsertTable
 TkwPopEditorInsertTable.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_InsertRow
 TkwPopEditorInsertRow.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_DeleteRow
 TkwPopEditorDeleteRow.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_InsertColumn
 TkwPopEditorInsertColumn.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_DeleteColumn
 TkwPopEditorDeleteColumn.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_MergeCells
 TkwPopEditorMergeCells.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_SplitCell
 TkwPopEditorSplitCell.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_SplitTable
 TkwPopEditorSplitTable.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_MergeTables
 TkwPopEditorMergeTables.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_InsertSectionBreak
 TkwPopEditorInsertSectionBreak.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_PrevHyperlink
 TkwPopEditorPrevHyperlink.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_NextHyperlink
 TkwPopEditorNextHyperlink.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Editor_Range
 TkwPopEditorRange.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TevCustomEditor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevCustomEditor));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TedMergeAlgorythm
 TtfwTypeRegistrator.RegisterType(TypeInfo(TedMergeAlgorythm));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� PageOrientation
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevPageOrientation));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� IedRange
 TtfwTypeRegistrator.RegisterType(TypeInfo(IedRange));
{$IfEnd} //not NoScripts

end.