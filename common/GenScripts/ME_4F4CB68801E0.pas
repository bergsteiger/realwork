unit EditorFromStackKeyWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\EditorFromStackKeyWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "EditorFromStackKeyWordsPack" MUID: (4F4CB68801E0)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nevBase
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evCustomEditorWindow
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , nevTools
 , tfwPropertyLike
 , tfwTypeInfo
 , tfwAxiomaticsResNameGetter
 , kwPopEditorSelectCells
 , kwPopEditorWheelScroll
 , kwPopEditorSelectColumn
 , kwPopEditorSelectCellsVertical
 , kwPopEditorJumpToHyperlink
 , kwPopEditorRepaintTableLinesAndCheckWithEtalon
 , kwPopEditorPrintAcnhor
 , kwPopEditorPrintTableCellsParams
 , kwPopEditorLP2DP
 , kwPopEditorDP2LP
 , kwPopEditorCheckContinueCells
 , kwPopEditorGetLeftIndentDelta
 , kwPopEditorParaDown
 , kwPopEditorParaUp
 , kwPopEditorParaEnd
 , kwPopEditorParaHome
 , kwPopEditorSelectTable
 , kwPopEditorHasComment
 , kwPopEditorDeleteUserComment
 , kwPopEditorCurrentText
 , kwPopEditorUpdateCursorFromHotSpot
 , kwPopEditorUpdateCursorFromHotSpotEx
 , kwPopEditorTextToFile
 , kwPopEditorGetSelectionText
 , kwPopEditorGetParaByID
 , kwPopEditorGetSelectionTextInFormat
 , kwPopEditorBlockResize
 , kwPopEditorSelectCellByMouse
 , kwPopEditorSetTextParaStyle
 , kwPopEditorSetCursorByPoint
 {$If Defined(nsTest)}
 , kwPopEditorRepaintAndCheckWithEtalon
 {$IfEnd} // Defined(nsTest)
 , kwPopEditorCopyAndPaste2DocumentBottom
 , kwPopEditorResizeTableColumn
 , kwPopEditorResizeTableColumnEX
 , kwPopEditorCheckWithEtalon
 , kwPopEditorGetLMargin
 , kwPopEditorGetWrapLimit
 , kwPopEditorBlockResizeEX
 , kwPopEditorPasteRTF
 , kwPopEditorInsertStream
 , kwPopEditorPasteEVDTroughClipboard
 {$If Defined(nsTest)}
 , kwBeginWaitPrint
 {$IfEnd} // Defined(nsTest)
 {$If Defined(nsTest)}
 , kwEndWaitPrint
 {$IfEnd} // Defined(nsTest)
 , evTypes
 , TevCustomEditorWordsPack
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopEditorScrollBottom = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollBottom }
  private
   procedure ScrollBottom(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow;
    aVert: Boolean);
    {* Реализация слова скрипта pop:Editor:ScrollBottom }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorScrollBottom

 TkwPopEditorScrollLineUp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollLineUp }
  private
   procedure ScrollLineUp(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow);
    {* Реализация слова скрипта pop:Editor:ScrollLineUp }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorScrollLineUp

 TkwPopEditorScrollLineDown = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollLineDown }
  private
   procedure ScrollLineDown(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow);
    {* Реализация слова скрипта pop:Editor:ScrollLineDown }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorScrollLineDown

 TkwPopEditorScrollTo = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollTo }
  private
   procedure ScrollTo(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow;
    aVert: Boolean;
    aPosition: Integer);
    {* Реализация слова скрипта pop:Editor:ScrollTo }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorScrollTo

 TkwPopEditorPushParaFromCursor = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:PushParaFromCursor }
  private
   function PushParaFromCursor(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): InevPara;
    {* Реализация слова скрипта pop:Editor:PushParaFromCursor }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorPushParaFromCursor

 TkwPopEditorSelectAll = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SelectAll }
  private
   procedure SelectAll(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow);
    {* Реализация слова скрипта pop:Editor:SelectAll }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorSelectAll

 TkwPopEditorSelectPara = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SelectPara }
  private
   procedure SelectPara(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow);
    {* Реализация слова скрипта pop:Editor:SelectPara }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorSelectPara

 TkwPopEditorAtTop = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:AtTop }
  private
   function AtTop(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:AtTop }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorAtTop

 TkwPopEditorSelectWord = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SelectWord }
  private
   procedure SelectWord(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow);
    {* Реализация слова скрипта pop:Editor:SelectWord }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorSelectWord

 TkwPopEditorCaretVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:CaretVisible }
  private
   function CaretVisible(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:CaretVisible }
  protected
   class procedure DoSetValue(aEditor: TevCustomEditorWindow;
    aValue: Boolean);
    {* Метод установки значения свойства CaretVisible }
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopEditorCaretVisible

 TkwPopEditorShowDocumentParts = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:ShowDocumentParts }
  private
   function ShowDocumentParts(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:ShowDocumentParts }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopEditorShowDocumentParts

 TkwPopEditorWebStyle = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:WebStyle }
  private
   function WebStyle(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:WebStyle }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopEditorWebStyle

 TkwPopEditorDrawSpecial = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:DrawSpecial }
  private
   function DrawSpecial(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:DrawSpecial }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopEditorDrawSpecial

 TkwPopEditorDocumentTailVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:DocumentTailVisible }
  private
   function DocumentTailVisible(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:DocumentTailVisible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopEditorDocumentTailVisible

 TkwPopEditorModified = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:Modified }
  private
   function Modified(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:Modified }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopEditorModified

 TkwPopEditorDrawLines = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:DrawLines }
  private
   function DrawLines(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:DrawLines }
  protected
   class procedure DoSetValue(aEditor: TevCustomEditorWindow;
    aValue: Boolean);
    {* Метод установки значения свойства DrawLines }
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopEditorDrawLines

 TkwPopEditorAllowRubberTables = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:AllowRubberTables }
  private
   function AllowRubberTables(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): TnevRubberTablesMode;
    {* Реализация слова скрипта pop:Editor:AllowRubberTables }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopEditorAllowRubberTables

 TEditorFromStackKeyWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TEditorFromStackKeyWordsPackResNameGetter

procedure TkwPopEditorScrollBottom.ScrollBottom(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow;
 aVert: Boolean);
 {* Реализация слова скрипта pop:Editor:ScrollBottom }
//#UC START# *55D5F6BB01C5_55D5F6BB01C5_4829D92A037B_Word_var*
//#UC END# *55D5F6BB01C5_55D5F6BB01C5_4829D92A037B_Word_var*
begin
//#UC START# *55D5F6BB01C5_55D5F6BB01C5_4829D92A037B_Word_impl*
 aEditor.View.Scroller[aVert].Bottom;
//#UC END# *55D5F6BB01C5_55D5F6BB01C5_4829D92A037B_Word_impl*
end;//TkwPopEditorScrollBottom.ScrollBottom

class function TkwPopEditorScrollBottom.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:ScrollBottom';
end;//TkwPopEditorScrollBottom.GetWordNameForRegister

function TkwPopEditorScrollBottom.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorScrollBottom.GetResultTypeInfo

function TkwPopEditorScrollBottom.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopEditorScrollBottom.GetAllParamsCount

function TkwPopEditorScrollBottom.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow), TypeInfo(Boolean)]);
end;//TkwPopEditorScrollBottom.ParamsTypes

procedure TkwPopEditorScrollBottom.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
var l_aVert: Boolean;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
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
 ScrollBottom(aCtx, l_aEditor, l_aVert);
end;//TkwPopEditorScrollBottom.DoDoIt

procedure TkwPopEditorScrollLineUp.ScrollLineUp(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow);
 {* Реализация слова скрипта pop:Editor:ScrollLineUp }
//#UC START# *55D5F6F701A4_55D5F6F701A4_4829D92A037B_Word_var*
//#UC END# *55D5F6F701A4_55D5F6F701A4_4829D92A037B_Word_var*
begin
//#UC START# *55D5F6F701A4_55D5F6F701A4_4829D92A037B_Word_impl*
 aEditor.View.Scroller[true].LineUp(1);
//#UC END# *55D5F6F701A4_55D5F6F701A4_4829D92A037B_Word_impl*
end;//TkwPopEditorScrollLineUp.ScrollLineUp

class function TkwPopEditorScrollLineUp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:ScrollLineUp';
end;//TkwPopEditorScrollLineUp.GetWordNameForRegister

function TkwPopEditorScrollLineUp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorScrollLineUp.GetResultTypeInfo

function TkwPopEditorScrollLineUp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorScrollLineUp.GetAllParamsCount

function TkwPopEditorScrollLineUp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorScrollLineUp.ParamsTypes

procedure TkwPopEditorScrollLineUp.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ScrollLineUp(aCtx, l_aEditor);
end;//TkwPopEditorScrollLineUp.DoDoIt

procedure TkwPopEditorScrollLineDown.ScrollLineDown(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow);
 {* Реализация слова скрипта pop:Editor:ScrollLineDown }
//#UC START# *55D5F70C019D_55D5F70C019D_4829D92A037B_Word_var*
//#UC END# *55D5F70C019D_55D5F70C019D_4829D92A037B_Word_var*
begin
//#UC START# *55D5F70C019D_55D5F70C019D_4829D92A037B_Word_impl*
 aEditor.View.Scroller[true].LineDown(1);
//#UC END# *55D5F70C019D_55D5F70C019D_4829D92A037B_Word_impl*
end;//TkwPopEditorScrollLineDown.ScrollLineDown

class function TkwPopEditorScrollLineDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:ScrollLineDown';
end;//TkwPopEditorScrollLineDown.GetWordNameForRegister

function TkwPopEditorScrollLineDown.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorScrollLineDown.GetResultTypeInfo

function TkwPopEditorScrollLineDown.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorScrollLineDown.GetAllParamsCount

function TkwPopEditorScrollLineDown.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorScrollLineDown.ParamsTypes

procedure TkwPopEditorScrollLineDown.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ScrollLineDown(aCtx, l_aEditor);
end;//TkwPopEditorScrollLineDown.DoDoIt

procedure TkwPopEditorScrollTo.ScrollTo(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow;
 aVert: Boolean;
 aPosition: Integer);
 {* Реализация слова скрипта pop:Editor:ScrollTo }
//#UC START# *55D5F73E005E_55D5F73E005E_4829D92A037B_Word_var*
//#UC END# *55D5F73E005E_55D5F73E005E_4829D92A037B_Word_var*
begin
//#UC START# *55D5F73E005E_55D5F73E005E_4829D92A037B_Word_impl*
 aEditor.View.Scroller[aVert].ScrollTo(aPosition);
//#UC END# *55D5F73E005E_55D5F73E005E_4829D92A037B_Word_impl*
end;//TkwPopEditorScrollTo.ScrollTo

class function TkwPopEditorScrollTo.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:ScrollTo';
end;//TkwPopEditorScrollTo.GetWordNameForRegister

function TkwPopEditorScrollTo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorScrollTo.GetResultTypeInfo

function TkwPopEditorScrollTo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwPopEditorScrollTo.GetAllParamsCount

function TkwPopEditorScrollTo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow), TypeInfo(Boolean), TypeInfo(Integer)]);
end;//TkwPopEditorScrollTo.ParamsTypes

procedure TkwPopEditorScrollTo.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
var l_aVert: Boolean;
var l_aPosition: Integer;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
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
 try
  l_aPosition := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPosition: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ScrollTo(aCtx, l_aEditor, l_aVert, l_aPosition);
end;//TkwPopEditorScrollTo.DoDoIt

function TkwPopEditorPushParaFromCursor.PushParaFromCursor(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): InevPara;
 {* Реализация слова скрипта pop:Editor:PushParaFromCursor }
//#UC START# *55D5F82B0316_55D5F82B0316_4829D92A037B_Word_var*
//#UC END# *55D5F82B0316_55D5F82B0316_4829D92A037B_Word_var*
begin
//#UC START# *55D5F82B0316_55D5F82B0316_4829D92A037B_Word_impl*
 Result := aEditor.Selection.Cursor.MostInner.Obj^.AsPara;
//#UC END# *55D5F82B0316_55D5F82B0316_4829D92A037B_Word_impl*
end;//TkwPopEditorPushParaFromCursor.PushParaFromCursor

class function TkwPopEditorPushParaFromCursor.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:PushParaFromCursor';
end;//TkwPopEditorPushParaFromCursor.GetWordNameForRegister

function TkwPopEditorPushParaFromCursor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(InevPara);
end;//TkwPopEditorPushParaFromCursor.GetResultTypeInfo

function TkwPopEditorPushParaFromCursor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorPushParaFromCursor.GetAllParamsCount

function TkwPopEditorPushParaFromCursor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorPushParaFromCursor.ParamsTypes

procedure TkwPopEditorPushParaFromCursor.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushIntf(PushParaFromCursor(aCtx, l_aEditor), TypeInfo(InevPara));
end;//TkwPopEditorPushParaFromCursor.DoDoIt

procedure TkwPopEditorSelectAll.SelectAll(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow);
 {* Реализация слова скрипта pop:Editor:SelectAll }
//#UC START# *55D5F8E00362_55D5F8E00362_4829D92A037B_Word_var*
//#UC END# *55D5F8E00362_55D5F8E00362_4829D92A037B_Word_var*
begin
//#UC START# *55D5F8E00362_55D5F8E00362_4829D92A037B_Word_impl*
 aEditor.Select(ev_stDocument);
//#UC END# *55D5F8E00362_55D5F8E00362_4829D92A037B_Word_impl*
end;//TkwPopEditorSelectAll.SelectAll

class function TkwPopEditorSelectAll.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:SelectAll';
end;//TkwPopEditorSelectAll.GetWordNameForRegister

function TkwPopEditorSelectAll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorSelectAll.GetResultTypeInfo

function TkwPopEditorSelectAll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorSelectAll.GetAllParamsCount

function TkwPopEditorSelectAll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorSelectAll.ParamsTypes

procedure TkwPopEditorSelectAll.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SelectAll(aCtx, l_aEditor);
end;//TkwPopEditorSelectAll.DoDoIt

procedure TkwPopEditorSelectPara.SelectPara(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow);
 {* Реализация слова скрипта pop:Editor:SelectPara }
//#UC START# *55D5F9010294_55D5F9010294_4829D92A037B_Word_var*
//#UC END# *55D5F9010294_55D5F9010294_4829D92A037B_Word_var*
begin
//#UC START# *55D5F9010294_55D5F9010294_4829D92A037B_Word_impl*
 aEditor.Select(ev_stPara);
//#UC END# *55D5F9010294_55D5F9010294_4829D92A037B_Word_impl*
end;//TkwPopEditorSelectPara.SelectPara

class function TkwPopEditorSelectPara.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:SelectPara';
end;//TkwPopEditorSelectPara.GetWordNameForRegister

function TkwPopEditorSelectPara.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorSelectPara.GetResultTypeInfo

function TkwPopEditorSelectPara.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorSelectPara.GetAllParamsCount

function TkwPopEditorSelectPara.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorSelectPara.ParamsTypes

procedure TkwPopEditorSelectPara.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SelectPara(aCtx, l_aEditor);
end;//TkwPopEditorSelectPara.DoDoIt

function TkwPopEditorAtTop.AtTop(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:AtTop }
//#UC START# *55D6030E03A9_55D6030E03A9_4829D92A037B_Word_var*
//#UC END# *55D6030E03A9_55D6030E03A9_4829D92A037B_Word_var*
begin
//#UC START# *55D6030E03A9_55D6030E03A9_4829D92A037B_Word_impl*
 Result := aEditor.View.TopAnchor.AtStart;
//#UC END# *55D6030E03A9_55D6030E03A9_4829D92A037B_Word_impl*
end;//TkwPopEditorAtTop.AtTop

class function TkwPopEditorAtTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:AtTop';
end;//TkwPopEditorAtTop.GetWordNameForRegister

function TkwPopEditorAtTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopEditorAtTop.GetResultTypeInfo

function TkwPopEditorAtTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorAtTop.GetAllParamsCount

function TkwPopEditorAtTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorAtTop.ParamsTypes

procedure TkwPopEditorAtTop.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(AtTop(aCtx, l_aEditor));
end;//TkwPopEditorAtTop.DoDoIt

procedure TkwPopEditorSelectWord.SelectWord(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow);
 {* Реализация слова скрипта pop:Editor:SelectWord }
//#UC START# *55D608E50272_55D608E50272_4829D92A037B_Word_var*
//#UC END# *55D608E50272_55D608E50272_4829D92A037B_Word_var*
begin
//#UC START# *55D608E50272_55D608E50272_4829D92A037B_Word_impl*
 aEditor.Select(ev_stWord);
//#UC END# *55D608E50272_55D608E50272_4829D92A037B_Word_impl*
end;//TkwPopEditorSelectWord.SelectWord

class function TkwPopEditorSelectWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:SelectWord';
end;//TkwPopEditorSelectWord.GetWordNameForRegister

function TkwPopEditorSelectWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopEditorSelectWord.GetResultTypeInfo

function TkwPopEditorSelectWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorSelectWord.GetAllParamsCount

function TkwPopEditorSelectWord.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorSelectWord.ParamsTypes

procedure TkwPopEditorSelectWord.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SelectWord(aCtx, l_aEditor);
end;//TkwPopEditorSelectWord.DoDoIt

class procedure TkwPopEditorCaretVisible.DoSetValue(aEditor: TevCustomEditorWindow;
 aValue: Boolean);
 {* Метод установки значения свойства CaretVisible }
//#UC START# *55D5F5430178_4829D92A037B_Word_DoSetValue_55D5F5430178_4829D92A037B_Word_var*
//#UC END# *55D5F5430178_4829D92A037B_Word_DoSetValue_55D5F5430178_4829D92A037B_Word_var*
begin
//#UC START# *55D5F5430178_4829D92A037B_Word_DoSetValue_55D5F5430178_4829D92A037B_Word_impl*
 aEditor.Selection.Caret.Visible := aValue;
//#UC END# *55D5F5430178_4829D92A037B_Word_DoSetValue_55D5F5430178_4829D92A037B_Word_impl*
end;//TkwPopEditorCaretVisible.DoSetValue

function TkwPopEditorCaretVisible.CaretVisible(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:CaretVisible }
//#UC START# *55D5F5430178_55D5F5430178_4829D92A037B_Word_var*
//#UC END# *55D5F5430178_55D5F5430178_4829D92A037B_Word_var*
begin
//#UC START# *55D5F5430178_55D5F5430178_4829D92A037B_Word_impl*
 Result := aEditor.Selection.Caret.Visible;
//#UC END# *55D5F5430178_55D5F5430178_4829D92A037B_Word_impl*
end;//TkwPopEditorCaretVisible.CaretVisible

class function TkwPopEditorCaretVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:CaretVisible';
end;//TkwPopEditorCaretVisible.GetWordNameForRegister

function TkwPopEditorCaretVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopEditorCaretVisible.GetResultTypeInfo

function TkwPopEditorCaretVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorCaretVisible.GetAllParamsCount

function TkwPopEditorCaretVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorCaretVisible.ParamsTypes

procedure TkwPopEditorCaretVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Editor: TevCustomEditorWindow;
begin
 try
  l_Editor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Editor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DoSetValue(l_Editor, aValue.AsBoolean);
end;//TkwPopEditorCaretVisible.SetValuePrim

procedure TkwPopEditorCaretVisible.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(CaretVisible(aCtx, l_aEditor));
end;//TkwPopEditorCaretVisible.DoDoIt

function TkwPopEditorShowDocumentParts.ShowDocumentParts(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:ShowDocumentParts }
begin
 Result := aEditor.ShowDocumentParts;
end;//TkwPopEditorShowDocumentParts.ShowDocumentParts

class function TkwPopEditorShowDocumentParts.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:ShowDocumentParts';
end;//TkwPopEditorShowDocumentParts.GetWordNameForRegister

function TkwPopEditorShowDocumentParts.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopEditorShowDocumentParts.GetResultTypeInfo

function TkwPopEditorShowDocumentParts.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorShowDocumentParts.GetAllParamsCount

function TkwPopEditorShowDocumentParts.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorShowDocumentParts.ParamsTypes

procedure TkwPopEditorShowDocumentParts.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Editor: TevCustomEditorWindow;
begin
 try
  l_Editor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Editor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Editor.ShowDocumentParts := aValue.AsBoolean;
end;//TkwPopEditorShowDocumentParts.SetValuePrim

procedure TkwPopEditorShowDocumentParts.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(ShowDocumentParts(aCtx, l_aEditor));
end;//TkwPopEditorShowDocumentParts.DoDoIt

function TkwPopEditorWebStyle.WebStyle(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:WebStyle }
begin
 Result := aEditor.WebStyle;
end;//TkwPopEditorWebStyle.WebStyle

class function TkwPopEditorWebStyle.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:WebStyle';
end;//TkwPopEditorWebStyle.GetWordNameForRegister

function TkwPopEditorWebStyle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopEditorWebStyle.GetResultTypeInfo

function TkwPopEditorWebStyle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorWebStyle.GetAllParamsCount

function TkwPopEditorWebStyle.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorWebStyle.ParamsTypes

procedure TkwPopEditorWebStyle.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Editor: TevCustomEditorWindow;
begin
 try
  l_Editor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Editor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Editor.WebStyle := aValue.AsBoolean;
end;//TkwPopEditorWebStyle.SetValuePrim

procedure TkwPopEditorWebStyle.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(WebStyle(aCtx, l_aEditor));
end;//TkwPopEditorWebStyle.DoDoIt

function TkwPopEditorDrawSpecial.DrawSpecial(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:DrawSpecial }
begin
 Result := aEditor.DrawSpecial;
end;//TkwPopEditorDrawSpecial.DrawSpecial

class function TkwPopEditorDrawSpecial.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:DrawSpecial';
end;//TkwPopEditorDrawSpecial.GetWordNameForRegister

function TkwPopEditorDrawSpecial.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopEditorDrawSpecial.GetResultTypeInfo

function TkwPopEditorDrawSpecial.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorDrawSpecial.GetAllParamsCount

function TkwPopEditorDrawSpecial.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorDrawSpecial.ParamsTypes

procedure TkwPopEditorDrawSpecial.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Editor: TevCustomEditorWindow;
begin
 try
  l_Editor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Editor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Editor.DrawSpecial := aValue.AsBoolean;
end;//TkwPopEditorDrawSpecial.SetValuePrim

procedure TkwPopEditorDrawSpecial.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(DrawSpecial(aCtx, l_aEditor));
end;//TkwPopEditorDrawSpecial.DoDoIt

function TkwPopEditorDocumentTailVisible.DocumentTailVisible(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:DocumentTailVisible }
//#UC START# *55D5F7C3030B_55D5F7C3030B_4829D92A037B_Word_var*
//#UC END# *55D5F7C3030B_55D5F7C3030B_4829D92A037B_Word_var*
begin
//#UC START# *55D5F7C3030B_55D5F7C3030B_4829D92A037B_Word_impl*
 Result := aEditor.View.IsDocumentTailVisible;
//#UC END# *55D5F7C3030B_55D5F7C3030B_4829D92A037B_Word_impl*
end;//TkwPopEditorDocumentTailVisible.DocumentTailVisible

class function TkwPopEditorDocumentTailVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:DocumentTailVisible';
end;//TkwPopEditorDocumentTailVisible.GetWordNameForRegister

function TkwPopEditorDocumentTailVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopEditorDocumentTailVisible.GetResultTypeInfo

function TkwPopEditorDocumentTailVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorDocumentTailVisible.GetAllParamsCount

function TkwPopEditorDocumentTailVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorDocumentTailVisible.ParamsTypes

procedure TkwPopEditorDocumentTailVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству DocumentTailVisible', aCtx);
end;//TkwPopEditorDocumentTailVisible.SetValuePrim

procedure TkwPopEditorDocumentTailVisible.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(DocumentTailVisible(aCtx, l_aEditor));
end;//TkwPopEditorDocumentTailVisible.DoDoIt

function TkwPopEditorModified.Modified(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:Modified }
begin
 Result := aEditor.Modified;
end;//TkwPopEditorModified.Modified

class function TkwPopEditorModified.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:Modified';
end;//TkwPopEditorModified.GetWordNameForRegister

function TkwPopEditorModified.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopEditorModified.GetResultTypeInfo

function TkwPopEditorModified.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorModified.GetAllParamsCount

function TkwPopEditorModified.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorModified.ParamsTypes

procedure TkwPopEditorModified.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Modified', aCtx);
end;//TkwPopEditorModified.SetValuePrim

procedure TkwPopEditorModified.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Modified(aCtx, l_aEditor));
end;//TkwPopEditorModified.DoDoIt

class procedure TkwPopEditorDrawLines.DoSetValue(aEditor: TevCustomEditorWindow;
 aValue: Boolean);
 {* Метод установки значения свойства DrawLines }
//#UC START# *55D5FECF025D_4829D92A037B_Word_DoSetValue_55D5FECF025D_4829D92A037B_Word_var*
//#UC END# *55D5FECF025D_4829D92A037B_Word_DoSetValue_55D5FECF025D_4829D92A037B_Word_var*
begin
//#UC START# *55D5FECF025D_4829D92A037B_Word_DoSetValue_55D5FECF025D_4829D92A037B_Word_impl*
 aEditor.Selection.DrawLines := aValue;
//#UC END# *55D5FECF025D_4829D92A037B_Word_DoSetValue_55D5FECF025D_4829D92A037B_Word_impl*
end;//TkwPopEditorDrawLines.DoSetValue

function TkwPopEditorDrawLines.DrawLines(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:DrawLines }
//#UC START# *55D5FECF025D_55D5FECF025D_4829D92A037B_Word_var*
//#UC END# *55D5FECF025D_55D5FECF025D_4829D92A037B_Word_var*
begin
//#UC START# *55D5FECF025D_55D5FECF025D_4829D92A037B_Word_impl*
 Result := aEditor.Selection.DrawLines;
//#UC END# *55D5FECF025D_55D5FECF025D_4829D92A037B_Word_impl*
end;//TkwPopEditorDrawLines.DrawLines

class function TkwPopEditorDrawLines.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:DrawLines';
end;//TkwPopEditorDrawLines.GetWordNameForRegister

function TkwPopEditorDrawLines.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopEditorDrawLines.GetResultTypeInfo

function TkwPopEditorDrawLines.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorDrawLines.GetAllParamsCount

function TkwPopEditorDrawLines.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorDrawLines.ParamsTypes

procedure TkwPopEditorDrawLines.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Editor: TevCustomEditorWindow;
begin
 try
  l_Editor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Editor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DoSetValue(l_Editor, aValue.AsBoolean);
end;//TkwPopEditorDrawLines.SetValuePrim

procedure TkwPopEditorDrawLines.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(DrawLines(aCtx, l_aEditor));
end;//TkwPopEditorDrawLines.DoDoIt

function TkwPopEditorAllowRubberTables.AllowRubberTables(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): TnevRubberTablesMode;
 {* Реализация слова скрипта pop:Editor:AllowRubberTables }
begin
 Result := aEditor.AllowRubberTables;
end;//TkwPopEditorAllowRubberTables.AllowRubberTables

class function TkwPopEditorAllowRubberTables.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:AllowRubberTables';
end;//TkwPopEditorAllowRubberTables.GetWordNameForRegister

function TkwPopEditorAllowRubberTables.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnevRubberTablesMode);
end;//TkwPopEditorAllowRubberTables.GetResultTypeInfo

function TkwPopEditorAllowRubberTables.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopEditorAllowRubberTables.GetAllParamsCount

function TkwPopEditorAllowRubberTables.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TevCustomEditorWindow)]);
end;//TkwPopEditorAllowRubberTables.ParamsTypes

procedure TkwPopEditorAllowRubberTables.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Editor: TevCustomEditorWindow;
begin
 try
  l_Editor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Editor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_Editor.AllowRubberTables := TnevRubberTablesMode(aValue.AsInt);
end;//TkwPopEditorAllowRubberTables.SetValuePrim

procedure TkwPopEditorAllowRubberTables.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TevCustomEditorWindow;
begin
 try
  l_aEditor := TevCustomEditorWindow(aCtx.rEngine.PopObjAs(TevCustomEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aEditor: TevCustomEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(AllowRubberTables(aCtx, l_aEditor)));
end;//TkwPopEditorAllowRubberTables.DoDoIt

class function TEditorFromStackKeyWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'EditorFromStackKeyWordsPack';
end;//TEditorFromStackKeyWordsPackResNameGetter.ResName

{$R EditorFromStackKeyWordsPack.res}

initialization
 TkwPopEditorScrollBottom.RegisterInEngine;
 {* Регистрация pop_Editor_ScrollBottom }
 TkwPopEditorScrollLineUp.RegisterInEngine;
 {* Регистрация pop_Editor_ScrollLineUp }
 TkwPopEditorScrollLineDown.RegisterInEngine;
 {* Регистрация pop_Editor_ScrollLineDown }
 TkwPopEditorScrollTo.RegisterInEngine;
 {* Регистрация pop_Editor_ScrollTo }
 TkwPopEditorPushParaFromCursor.RegisterInEngine;
 {* Регистрация pop_Editor_PushParaFromCursor }
 TkwPopEditorSelectAll.RegisterInEngine;
 {* Регистрация pop_Editor_SelectAll }
 TkwPopEditorSelectPara.RegisterInEngine;
 {* Регистрация pop_Editor_SelectPara }
 TkwPopEditorAtTop.RegisterInEngine;
 {* Регистрация pop_Editor_AtTop }
 TkwPopEditorSelectWord.RegisterInEngine;
 {* Регистрация pop_Editor_SelectWord }
 TkwPopEditorCaretVisible.RegisterInEngine;
 {* Регистрация pop_Editor_CaretVisible }
 TkwPopEditorShowDocumentParts.RegisterInEngine;
 {* Регистрация pop_Editor_ShowDocumentParts }
 TkwPopEditorWebStyle.RegisterInEngine;
 {* Регистрация pop_Editor_WebStyle }
 TkwPopEditorDrawSpecial.RegisterInEngine;
 {* Регистрация pop_Editor_DrawSpecial }
 TkwPopEditorDocumentTailVisible.RegisterInEngine;
 {* Регистрация pop_Editor_DocumentTailVisible }
 TkwPopEditorModified.RegisterInEngine;
 {* Регистрация pop_Editor_Modified }
 TkwPopEditorDrawLines.RegisterInEngine;
 {* Регистрация pop_Editor_DrawLines }
 TkwPopEditorAllowRubberTables.RegisterInEngine;
 {* Регистрация pop_Editor_AllowRubberTables }
 TEditorFromStackKeyWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevCustomEditorWindow));
 {* Регистрация типа TevCustomEditorWindow }
 TtfwTypeRegistrator.RegisterType(TypeInfo(InevPara));
 {* Регистрация типа InevPara }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnevRubberTablesMode));
 {* Регистрация типа TnevRubberTablesMode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
