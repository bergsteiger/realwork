unit EditorFromStackKeyWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\EditorFromStackKeyWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , evCustomEditorWindow
 , nevBase
 , nevTools
 , tfwAxiomaticsResNameGetter
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
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *89CE586D099Aci*
 //#UC END# *89CE586D099Aci*
 //#UC START# *89CE586D099Acit*
 //#UC END# *89CE586D099Acit*
 TEditorFromStackKeyWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *89CE586D099Apubl*
 //#UC END# *89CE586D099Apubl*
 end;//TEditorFromStackKeyWordsPackResNameGetter

 TkwPopEditorScrollBottom = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollBottom
*Пример:*
[code]
 aVert aEditor pop:Editor:ScrollBottom
[code]  }
  private
   procedure ScrollBottom(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow;
    aVert: Boolean);
    {* Реализация слова скрипта pop:Editor:ScrollBottom }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorScrollBottom

 TkwPopEditorScrollLineUp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollLineUp
*Пример:*
[code]
 aEditor pop:Editor:ScrollLineUp
[code]  }
  private
   procedure ScrollLineUp(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow);
    {* Реализация слова скрипта pop:Editor:ScrollLineUp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorScrollLineUp

 TkwPopEditorScrollLineDown = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollLineDown
*Пример:*
[code]
 aEditor pop:Editor:ScrollLineDown
[code]  }
  private
   procedure ScrollLineDown(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow);
    {* Реализация слова скрипта pop:Editor:ScrollLineDown }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorScrollLineDown

 TkwPopEditorScrollTo = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollTo
*Пример:*
[code]
 aPosition aVert aEditor pop:Editor:ScrollTo
[code]  }
  private
   procedure ScrollTo(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow;
    aVert: Boolean;
    aPosition: Integer);
    {* Реализация слова скрипта pop:Editor:ScrollTo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorScrollTo

 TkwPopEditorPushParaFromCursor = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:PushParaFromCursor
*Тип результата:* InevPara
*Пример:*
[code]
INTERFACE VAR l_InevPara
 aEditor pop:Editor:PushParaFromCursor >>> l_InevPara
[code]  }
  private
   function PushParaFromCursor(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): InevPara;
    {* Реализация слова скрипта pop:Editor:PushParaFromCursor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorPushParaFromCursor

 TkwPopEditorSelectAll = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SelectAll
*Пример:*
[code]
 aEditor pop:Editor:SelectAll
[code]  }
  private
   procedure SelectAll(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow);
    {* Реализация слова скрипта pop:Editor:SelectAll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorSelectAll

 TkwPopEditorSelectPara = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SelectPara
*Пример:*
[code]
 aEditor pop:Editor:SelectPara
[code]  }
  private
   procedure SelectPara(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow);
    {* Реализация слова скрипта pop:Editor:SelectPara }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorSelectPara

 TkwPopEditorAtTop = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:AtTop
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:AtTop >>> l_Boolean
[code]  }
  private
   function AtTop(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:AtTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorAtTop

 TkwPopEditorSelectWord = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SelectWord
*Пример:*
[code]
 aEditor pop:Editor:SelectWord
[code]  }
  private
   procedure SelectWord(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow);
    {* Реализация слова скрипта pop:Editor:SelectWord }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorSelectWord

 TkwPopEditorCaretVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:CaretVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:CaretVisible >>> l_Boolean
[code]  }
  private
   function CaretVisible(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:CaretVisible }
  protected
   class procedure DoSetValue(aEditor: TevCustomEditorWindow;
    aValue: Boolean);
    {* Метод установки значения свойства CaretVisible }
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorCaretVisible

 TkwPopEditorShowDocumentParts = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:ShowDocumentParts
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:ShowDocumentParts >>> l_Boolean
[code]  }
  private
   function ShowDocumentParts(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:ShowDocumentParts }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorShowDocumentParts

 TkwPopEditorWebStyle = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:WebStyle
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:WebStyle >>> l_Boolean
[code]  }
  private
   function WebStyle(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:WebStyle }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorWebStyle

 TkwPopEditorDrawSpecial = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:DrawSpecial
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:DrawSpecial >>> l_Boolean
[code]  }
  private
   function DrawSpecial(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:DrawSpecial }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorDrawSpecial

 TkwPopEditorDocumentTailVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:DocumentTailVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:DocumentTailVisible >>> l_Boolean
[code]  }
  private
   function DocumentTailVisible(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:DocumentTailVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorDocumentTailVisible

 TkwPopEditorModified = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:Modified
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:Modified >>> l_Boolean
[code]  }
  private
   function Modified(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:Modified }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorModified

 TkwPopEditorDrawLines = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:DrawLines
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:DrawLines >>> l_Boolean
[code]  }
  private
   function DrawLines(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): Boolean;
    {* Реализация слова скрипта pop:Editor:DrawLines }
  protected
   class procedure DoSetValue(aEditor: TevCustomEditorWindow;
    aValue: Boolean);
    {* Метод установки значения свойства DrawLines }
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorDrawLines

 TkwPopEditorAllowRubberTables = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:AllowRubberTables
*Тип результата:* TnevRubberTablesMode
*Пример:*
[code]
TnevRubberTablesMode VAR l_TnevRubberTablesMode
 aEditor pop:Editor:AllowRubberTables >>> l_TnevRubberTablesMode
[code]  }
  private
   function AllowRubberTables(const aCtx: TtfwContext;
    aEditor: TevCustomEditorWindow): TnevRubberTablesMode;
    {* Реализация слова скрипта pop:Editor:AllowRubberTables }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopEditorAllowRubberTables

class function TEditorFromStackKeyWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'EditorFromStackKeyWordsPack';
end;//TEditorFromStackKeyWordsPackResNameGetter.ResName

 {$R EditorFromStackKeyWordsPack.res}

procedure TkwPopEditorScrollBottom.ScrollBottom(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow;
 aVert: Boolean);
 {* Реализация слова скрипта pop:Editor:ScrollBottom }
//#UC START# *E878A5785856_57E2F8D45E5B_var*
//#UC END# *E878A5785856_57E2F8D45E5B_var*
begin
//#UC START# *E878A5785856_57E2F8D45E5B_impl*
 aEditor.View.Scroller[aVert].Bottom;
//#UC END# *E878A5785856_57E2F8D45E5B_impl*
end;//TkwPopEditorScrollBottom.ScrollBottom

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

procedure TkwPopEditorScrollLineUp.ScrollLineUp(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow);
 {* Реализация слова скрипта pop:Editor:ScrollLineUp }
//#UC START# *3365A63C1282_984121B2A39C_var*
//#UC END# *3365A63C1282_984121B2A39C_var*
begin
//#UC START# *3365A63C1282_984121B2A39C_impl*
 aEditor.View.Scroller[true].LineUp(1);
//#UC END# *3365A63C1282_984121B2A39C_impl*
end;//TkwPopEditorScrollLineUp.ScrollLineUp

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

procedure TkwPopEditorScrollLineDown.ScrollLineDown(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow);
 {* Реализация слова скрипта pop:Editor:ScrollLineDown }
//#UC START# *D3A35E072C1B_6EFB94FBB9D0_var*
//#UC END# *D3A35E072C1B_6EFB94FBB9D0_var*
begin
//#UC START# *D3A35E072C1B_6EFB94FBB9D0_impl*
 aEditor.View.Scroller[true].LineDown(1);
//#UC END# *D3A35E072C1B_6EFB94FBB9D0_impl*
end;//TkwPopEditorScrollLineDown.ScrollLineDown

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

procedure TkwPopEditorScrollTo.ScrollTo(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow;
 aVert: Boolean;
 aPosition: Integer);
 {* Реализация слова скрипта pop:Editor:ScrollTo }
//#UC START# *A3F91EDFD1C9_C6DBF363488D_var*
//#UC END# *A3F91EDFD1C9_C6DBF363488D_var*
begin
//#UC START# *A3F91EDFD1C9_C6DBF363488D_impl*
 aEditor.View.Scroller[aVert].ScrollTo(aPosition);
//#UC END# *A3F91EDFD1C9_C6DBF363488D_impl*
end;//TkwPopEditorScrollTo.ScrollTo

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

function TkwPopEditorPushParaFromCursor.PushParaFromCursor(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): InevPara;
 {* Реализация слова скрипта pop:Editor:PushParaFromCursor }
//#UC START# *DD411E2D2581_A463E79E2664_var*
//#UC END# *DD411E2D2581_A463E79E2664_var*
begin
//#UC START# *DD411E2D2581_A463E79E2664_impl*
 Result := aEditor.Selection.Cursor.MostInner.Obj^.AsPara;
//#UC END# *DD411E2D2581_A463E79E2664_impl*
end;//TkwPopEditorPushParaFromCursor.PushParaFromCursor

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
 aCtx.rEngine.PushIntf(PushParaFromCursor(aCtx, l_aEditor),InevPara);
end;//TkwPopEditorPushParaFromCursor.DoDoIt

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

procedure TkwPopEditorSelectAll.SelectAll(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow);
 {* Реализация слова скрипта pop:Editor:SelectAll }
//#UC START# *C4091644F56C_4E1035C3F4EA_var*
//#UC END# *C4091644F56C_4E1035C3F4EA_var*
begin
//#UC START# *C4091644F56C_4E1035C3F4EA_impl*
 aEditor.Select(ev_stDocument);
//#UC END# *C4091644F56C_4E1035C3F4EA_impl*
end;//TkwPopEditorSelectAll.SelectAll

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

procedure TkwPopEditorSelectPara.SelectPara(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow);
 {* Реализация слова скрипта pop:Editor:SelectPara }
//#UC START# *1FB82A59CE0C_3286856E5FD0_var*
//#UC END# *1FB82A59CE0C_3286856E5FD0_var*
begin
//#UC START# *1FB82A59CE0C_3286856E5FD0_impl*
 aEditor.Select(ev_stPara);
//#UC END# *1FB82A59CE0C_3286856E5FD0_impl*
end;//TkwPopEditorSelectPara.SelectPara

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

function TkwPopEditorAtTop.AtTop(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:AtTop }
//#UC START# *F84F861D4DF5_7B4AFEA8148C_var*
//#UC END# *F84F861D4DF5_7B4AFEA8148C_var*
begin
//#UC START# *F84F861D4DF5_7B4AFEA8148C_impl*
 Result := aEditor.View.TopAnchor.AtStart;
//#UC END# *F84F861D4DF5_7B4AFEA8148C_impl*
end;//TkwPopEditorAtTop.AtTop

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

procedure TkwPopEditorSelectWord.SelectWord(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow);
 {* Реализация слова скрипта pop:Editor:SelectWord }
//#UC START# *31861998FC92_2C60D13844FA_var*
//#UC END# *31861998FC92_2C60D13844FA_var*
begin
//#UC START# *31861998FC92_2C60D13844FA_impl*
 aEditor.Select(ev_stWord);
//#UC END# *31861998FC92_2C60D13844FA_impl*
end;//TkwPopEditorSelectWord.SelectWord

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

function TkwPopEditorCaretVisible.CaretVisible(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:CaretVisible }
//#UC START# *F1AC80FF6877_B38D1749E0D8_var*
//#UC END# *F1AC80FF6877_B38D1749E0D8_var*
begin
//#UC START# *F1AC80FF6877_B38D1749E0D8_impl*
 Result := aEditor.Selection.Caret.Visible;
//#UC END# *F1AC80FF6877_B38D1749E0D8_impl*
end;//TkwPopEditorCaretVisible.CaretVisible

class procedure TkwPopEditorCaretVisible.DoSetValue(aEditor: TevCustomEditorWindow;
 aValue: Boolean);
 {* Метод установки значения свойства CaretVisible }
//#UC START# *813D8AF5A13B_B38D1749E0D8_var*
//#UC END# *813D8AF5A13B_B38D1749E0D8_var*
begin
//#UC START# *813D8AF5A13B_B38D1749E0D8_impl*
 aEditor.Selection.Caret.Visible := aValue;
//#UC END# *813D8AF5A13B_B38D1749E0D8_impl*
end;//TkwPopEditorCaretVisible.DoSetValue

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

class function TkwPopEditorCaretVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:CaretVisible';
end;//TkwPopEditorCaretVisible.GetWordNameForRegister

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
 DoSetValue(Editor, aValue.AsBoolean);
end;//TkwPopEditorCaretVisible.SetValuePrim

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

function TkwPopEditorShowDocumentParts.ShowDocumentParts(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:ShowDocumentParts }
//#UC START# *1989F54F9653_A77B7AB26CFF_var*
//#UC END# *1989F54F9653_A77B7AB26CFF_var*
begin
//#UC START# *1989F54F9653_A77B7AB26CFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *1989F54F9653_A77B7AB26CFF_impl*
end;//TkwPopEditorShowDocumentParts.ShowDocumentParts

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

class function TkwPopEditorShowDocumentParts.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:ShowDocumentParts';
end;//TkwPopEditorShowDocumentParts.GetWordNameForRegister

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
 Editor. := aValue.AsBoolean;
end;//TkwPopEditorShowDocumentParts.SetValuePrim

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

function TkwPopEditorWebStyle.WebStyle(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:WebStyle }
//#UC START# *33DEC739C875_85D5F3815C6E_var*
//#UC END# *33DEC739C875_85D5F3815C6E_var*
begin
//#UC START# *33DEC739C875_85D5F3815C6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *33DEC739C875_85D5F3815C6E_impl*
end;//TkwPopEditorWebStyle.WebStyle

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

class function TkwPopEditorWebStyle.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:WebStyle';
end;//TkwPopEditorWebStyle.GetWordNameForRegister

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
 Editor. := aValue.AsBoolean;
end;//TkwPopEditorWebStyle.SetValuePrim

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

function TkwPopEditorDrawSpecial.DrawSpecial(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:DrawSpecial }
//#UC START# *A8F8F865E1DC_BB22FD3C71A4_var*
//#UC END# *A8F8F865E1DC_BB22FD3C71A4_var*
begin
//#UC START# *A8F8F865E1DC_BB22FD3C71A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *A8F8F865E1DC_BB22FD3C71A4_impl*
end;//TkwPopEditorDrawSpecial.DrawSpecial

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

class function TkwPopEditorDrawSpecial.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:DrawSpecial';
end;//TkwPopEditorDrawSpecial.GetWordNameForRegister

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
 Editor. := aValue.AsBoolean;
end;//TkwPopEditorDrawSpecial.SetValuePrim

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

function TkwPopEditorDocumentTailVisible.DocumentTailVisible(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:DocumentTailVisible }
//#UC START# *FC999CC36EB4_EE3EA3E1113C_var*
//#UC END# *FC999CC36EB4_EE3EA3E1113C_var*
begin
//#UC START# *FC999CC36EB4_EE3EA3E1113C_impl*
 Result := aEditor.View.IsDocumentTailVisible;
//#UC END# *FC999CC36EB4_EE3EA3E1113C_impl*
end;//TkwPopEditorDocumentTailVisible.DocumentTailVisible

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

class function TkwPopEditorDocumentTailVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:DocumentTailVisible';
end;//TkwPopEditorDocumentTailVisible.GetWordNameForRegister

procedure TkwPopEditorDocumentTailVisible.SetValuePrim(const aValue: TtfwStackValue;
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
 DoSetValue(Editor, aValue.AsBoolean);
end;//TkwPopEditorDocumentTailVisible.SetValuePrim

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

function TkwPopEditorModified.Modified(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:Modified }
//#UC START# *53C9376AB7F3_C36C39E9CCC8_var*
//#UC END# *53C9376AB7F3_C36C39E9CCC8_var*
begin
//#UC START# *53C9376AB7F3_C36C39E9CCC8_impl*
 !!! Needs to be implemented !!!
//#UC END# *53C9376AB7F3_C36C39E9CCC8_impl*
end;//TkwPopEditorModified.Modified

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

class function TkwPopEditorModified.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:Modified';
end;//TkwPopEditorModified.GetWordNameForRegister

procedure TkwPopEditorModified.SetValuePrim(const aValue: TtfwStackValue;
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
 Editor. := aValue.AsBoolean;
end;//TkwPopEditorModified.SetValuePrim

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

function TkwPopEditorDrawLines.DrawLines(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): Boolean;
 {* Реализация слова скрипта pop:Editor:DrawLines }
//#UC START# *4AE71A813BB5_3928ECE1F34F_var*
//#UC END# *4AE71A813BB5_3928ECE1F34F_var*
begin
//#UC START# *4AE71A813BB5_3928ECE1F34F_impl*
 Result := aEditor.Selection.DrawLines;
//#UC END# *4AE71A813BB5_3928ECE1F34F_impl*
end;//TkwPopEditorDrawLines.DrawLines

class procedure TkwPopEditorDrawLines.DoSetValue(aEditor: TevCustomEditorWindow;
 aValue: Boolean);
 {* Метод установки значения свойства DrawLines }
//#UC START# *D9A36FE270D1_3928ECE1F34F_var*
//#UC END# *D9A36FE270D1_3928ECE1F34F_var*
begin
//#UC START# *D9A36FE270D1_3928ECE1F34F_impl*
 aEditor.Selection.DrawLines := aValue;
//#UC END# *D9A36FE270D1_3928ECE1F34F_impl*
end;//TkwPopEditorDrawLines.DoSetValue

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

class function TkwPopEditorDrawLines.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:DrawLines';
end;//TkwPopEditorDrawLines.GetWordNameForRegister

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
 DoSetValue(Editor, aValue.AsBoolean);
end;//TkwPopEditorDrawLines.SetValuePrim

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

function TkwPopEditorAllowRubberTables.AllowRubberTables(const aCtx: TtfwContext;
 aEditor: TevCustomEditorWindow): TnevRubberTablesMode;
 {* Реализация слова скрипта pop:Editor:AllowRubberTables }
//#UC START# *27CCB8D080B9_1009897A0104_var*
//#UC END# *27CCB8D080B9_1009897A0104_var*
begin
//#UC START# *27CCB8D080B9_1009897A0104_impl*
 !!! Needs to be implemented !!!
//#UC END# *27CCB8D080B9_1009897A0104_impl*
end;//TkwPopEditorAllowRubberTables.AllowRubberTables

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

class function TkwPopEditorAllowRubberTables.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:AllowRubberTables';
end;//TkwPopEditorAllowRubberTables.GetWordNameForRegister

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
 Editor. := aValue.AsInt;
end;//TkwPopEditorAllowRubberTables.SetValuePrim

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

initialization
 TEditorFromStackKeyWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TevCustomEditorWindow));
 {* Регистрация типа TevCustomEditorWindow }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(InevPara));
 {* Регистрация типа InevPara }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnevRubberTablesMode));
 {* Регистрация типа TnevRubberTablesMode }
{$IfEnd} // NOT Defined(NoScripts)

end.
