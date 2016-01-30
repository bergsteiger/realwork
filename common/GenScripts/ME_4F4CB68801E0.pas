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
//#UC START# *4DAEEDE10285_57E2F8D45E5B_var*
//#UC END# *4DAEEDE10285_57E2F8D45E5B_var*
begin
//#UC START# *4DAEEDE10285_57E2F8D45E5B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_57E2F8D45E5B_impl*
end;//TkwPopEditorScrollBottom.DoDoIt

class function TkwPopEditorScrollBottom.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:ScrollBottom';
end;//TkwPopEditorScrollBottom.GetWordNameForRegister

function TkwPopEditorScrollBottom.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_57E2F8D45E5B_var*
//#UC END# *551544E2001A_57E2F8D45E5B_var*
begin
//#UC START# *551544E2001A_57E2F8D45E5B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_57E2F8D45E5B_impl*
end;//TkwPopEditorScrollBottom.GetResultTypeInfo

function TkwPopEditorScrollBottom.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_57E2F8D45E5B_var*
//#UC END# *559687E6025A_57E2F8D45E5B_var*
begin
//#UC START# *559687E6025A_57E2F8D45E5B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_57E2F8D45E5B_impl*
end;//TkwPopEditorScrollBottom.GetAllParamsCount

function TkwPopEditorScrollBottom.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_57E2F8D45E5B_var*
//#UC END# *5617F4D00243_57E2F8D45E5B_var*
begin
//#UC START# *5617F4D00243_57E2F8D45E5B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_57E2F8D45E5B_impl*
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
//#UC START# *4DAEEDE10285_984121B2A39C_var*
//#UC END# *4DAEEDE10285_984121B2A39C_var*
begin
//#UC START# *4DAEEDE10285_984121B2A39C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_984121B2A39C_impl*
end;//TkwPopEditorScrollLineUp.DoDoIt

class function TkwPopEditorScrollLineUp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:ScrollLineUp';
end;//TkwPopEditorScrollLineUp.GetWordNameForRegister

function TkwPopEditorScrollLineUp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_984121B2A39C_var*
//#UC END# *551544E2001A_984121B2A39C_var*
begin
//#UC START# *551544E2001A_984121B2A39C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_984121B2A39C_impl*
end;//TkwPopEditorScrollLineUp.GetResultTypeInfo

function TkwPopEditorScrollLineUp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_984121B2A39C_var*
//#UC END# *559687E6025A_984121B2A39C_var*
begin
//#UC START# *559687E6025A_984121B2A39C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_984121B2A39C_impl*
end;//TkwPopEditorScrollLineUp.GetAllParamsCount

function TkwPopEditorScrollLineUp.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_984121B2A39C_var*
//#UC END# *5617F4D00243_984121B2A39C_var*
begin
//#UC START# *5617F4D00243_984121B2A39C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_984121B2A39C_impl*
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
//#UC START# *4DAEEDE10285_6EFB94FBB9D0_var*
//#UC END# *4DAEEDE10285_6EFB94FBB9D0_var*
begin
//#UC START# *4DAEEDE10285_6EFB94FBB9D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6EFB94FBB9D0_impl*
end;//TkwPopEditorScrollLineDown.DoDoIt

class function TkwPopEditorScrollLineDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:ScrollLineDown';
end;//TkwPopEditorScrollLineDown.GetWordNameForRegister

function TkwPopEditorScrollLineDown.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6EFB94FBB9D0_var*
//#UC END# *551544E2001A_6EFB94FBB9D0_var*
begin
//#UC START# *551544E2001A_6EFB94FBB9D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6EFB94FBB9D0_impl*
end;//TkwPopEditorScrollLineDown.GetResultTypeInfo

function TkwPopEditorScrollLineDown.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_6EFB94FBB9D0_var*
//#UC END# *559687E6025A_6EFB94FBB9D0_var*
begin
//#UC START# *559687E6025A_6EFB94FBB9D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_6EFB94FBB9D0_impl*
end;//TkwPopEditorScrollLineDown.GetAllParamsCount

function TkwPopEditorScrollLineDown.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6EFB94FBB9D0_var*
//#UC END# *5617F4D00243_6EFB94FBB9D0_var*
begin
//#UC START# *5617F4D00243_6EFB94FBB9D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6EFB94FBB9D0_impl*
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
//#UC START# *4DAEEDE10285_C6DBF363488D_var*
//#UC END# *4DAEEDE10285_C6DBF363488D_var*
begin
//#UC START# *4DAEEDE10285_C6DBF363488D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C6DBF363488D_impl*
end;//TkwPopEditorScrollTo.DoDoIt

class function TkwPopEditorScrollTo.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:ScrollTo';
end;//TkwPopEditorScrollTo.GetWordNameForRegister

function TkwPopEditorScrollTo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C6DBF363488D_var*
//#UC END# *551544E2001A_C6DBF363488D_var*
begin
//#UC START# *551544E2001A_C6DBF363488D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C6DBF363488D_impl*
end;//TkwPopEditorScrollTo.GetResultTypeInfo

function TkwPopEditorScrollTo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C6DBF363488D_var*
//#UC END# *559687E6025A_C6DBF363488D_var*
begin
//#UC START# *559687E6025A_C6DBF363488D_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C6DBF363488D_impl*
end;//TkwPopEditorScrollTo.GetAllParamsCount

function TkwPopEditorScrollTo.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C6DBF363488D_var*
//#UC END# *5617F4D00243_C6DBF363488D_var*
begin
//#UC START# *5617F4D00243_C6DBF363488D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C6DBF363488D_impl*
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
//#UC START# *4DAEEDE10285_A463E79E2664_var*
//#UC END# *4DAEEDE10285_A463E79E2664_var*
begin
//#UC START# *4DAEEDE10285_A463E79E2664_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A463E79E2664_impl*
end;//TkwPopEditorPushParaFromCursor.DoDoIt

class function TkwPopEditorPushParaFromCursor.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:PushParaFromCursor';
end;//TkwPopEditorPushParaFromCursor.GetWordNameForRegister

function TkwPopEditorPushParaFromCursor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A463E79E2664_var*
//#UC END# *551544E2001A_A463E79E2664_var*
begin
//#UC START# *551544E2001A_A463E79E2664_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A463E79E2664_impl*
end;//TkwPopEditorPushParaFromCursor.GetResultTypeInfo

function TkwPopEditorPushParaFromCursor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_A463E79E2664_var*
//#UC END# *559687E6025A_A463E79E2664_var*
begin
//#UC START# *559687E6025A_A463E79E2664_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_A463E79E2664_impl*
end;//TkwPopEditorPushParaFromCursor.GetAllParamsCount

function TkwPopEditorPushParaFromCursor.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A463E79E2664_var*
//#UC END# *5617F4D00243_A463E79E2664_var*
begin
//#UC START# *5617F4D00243_A463E79E2664_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A463E79E2664_impl*
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
//#UC START# *4DAEEDE10285_4E1035C3F4EA_var*
//#UC END# *4DAEEDE10285_4E1035C3F4EA_var*
begin
//#UC START# *4DAEEDE10285_4E1035C3F4EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4E1035C3F4EA_impl*
end;//TkwPopEditorSelectAll.DoDoIt

class function TkwPopEditorSelectAll.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:SelectAll';
end;//TkwPopEditorSelectAll.GetWordNameForRegister

function TkwPopEditorSelectAll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4E1035C3F4EA_var*
//#UC END# *551544E2001A_4E1035C3F4EA_var*
begin
//#UC START# *551544E2001A_4E1035C3F4EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4E1035C3F4EA_impl*
end;//TkwPopEditorSelectAll.GetResultTypeInfo

function TkwPopEditorSelectAll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_4E1035C3F4EA_var*
//#UC END# *559687E6025A_4E1035C3F4EA_var*
begin
//#UC START# *559687E6025A_4E1035C3F4EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_4E1035C3F4EA_impl*
end;//TkwPopEditorSelectAll.GetAllParamsCount

function TkwPopEditorSelectAll.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4E1035C3F4EA_var*
//#UC END# *5617F4D00243_4E1035C3F4EA_var*
begin
//#UC START# *5617F4D00243_4E1035C3F4EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4E1035C3F4EA_impl*
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
//#UC START# *4DAEEDE10285_3286856E5FD0_var*
//#UC END# *4DAEEDE10285_3286856E5FD0_var*
begin
//#UC START# *4DAEEDE10285_3286856E5FD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3286856E5FD0_impl*
end;//TkwPopEditorSelectPara.DoDoIt

class function TkwPopEditorSelectPara.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:SelectPara';
end;//TkwPopEditorSelectPara.GetWordNameForRegister

function TkwPopEditorSelectPara.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3286856E5FD0_var*
//#UC END# *551544E2001A_3286856E5FD0_var*
begin
//#UC START# *551544E2001A_3286856E5FD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3286856E5FD0_impl*
end;//TkwPopEditorSelectPara.GetResultTypeInfo

function TkwPopEditorSelectPara.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_3286856E5FD0_var*
//#UC END# *559687E6025A_3286856E5FD0_var*
begin
//#UC START# *559687E6025A_3286856E5FD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_3286856E5FD0_impl*
end;//TkwPopEditorSelectPara.GetAllParamsCount

function TkwPopEditorSelectPara.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3286856E5FD0_var*
//#UC END# *5617F4D00243_3286856E5FD0_var*
begin
//#UC START# *5617F4D00243_3286856E5FD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3286856E5FD0_impl*
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
//#UC START# *4DAEEDE10285_7B4AFEA8148C_var*
//#UC END# *4DAEEDE10285_7B4AFEA8148C_var*
begin
//#UC START# *4DAEEDE10285_7B4AFEA8148C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7B4AFEA8148C_impl*
end;//TkwPopEditorAtTop.DoDoIt

class function TkwPopEditorAtTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:AtTop';
end;//TkwPopEditorAtTop.GetWordNameForRegister

function TkwPopEditorAtTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7B4AFEA8148C_var*
//#UC END# *551544E2001A_7B4AFEA8148C_var*
begin
//#UC START# *551544E2001A_7B4AFEA8148C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7B4AFEA8148C_impl*
end;//TkwPopEditorAtTop.GetResultTypeInfo

function TkwPopEditorAtTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_7B4AFEA8148C_var*
//#UC END# *559687E6025A_7B4AFEA8148C_var*
begin
//#UC START# *559687E6025A_7B4AFEA8148C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_7B4AFEA8148C_impl*
end;//TkwPopEditorAtTop.GetAllParamsCount

function TkwPopEditorAtTop.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7B4AFEA8148C_var*
//#UC END# *5617F4D00243_7B4AFEA8148C_var*
begin
//#UC START# *5617F4D00243_7B4AFEA8148C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7B4AFEA8148C_impl*
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
//#UC START# *4DAEEDE10285_2C60D13844FA_var*
//#UC END# *4DAEEDE10285_2C60D13844FA_var*
begin
//#UC START# *4DAEEDE10285_2C60D13844FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2C60D13844FA_impl*
end;//TkwPopEditorSelectWord.DoDoIt

class function TkwPopEditorSelectWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:SelectWord';
end;//TkwPopEditorSelectWord.GetWordNameForRegister

function TkwPopEditorSelectWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2C60D13844FA_var*
//#UC END# *551544E2001A_2C60D13844FA_var*
begin
//#UC START# *551544E2001A_2C60D13844FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2C60D13844FA_impl*
end;//TkwPopEditorSelectWord.GetResultTypeInfo

function TkwPopEditorSelectWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_2C60D13844FA_var*
//#UC END# *559687E6025A_2C60D13844FA_var*
begin
//#UC START# *559687E6025A_2C60D13844FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_2C60D13844FA_impl*
end;//TkwPopEditorSelectWord.GetAllParamsCount

function TkwPopEditorSelectWord.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2C60D13844FA_var*
//#UC END# *5617F4D00243_2C60D13844FA_var*
begin
//#UC START# *5617F4D00243_2C60D13844FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2C60D13844FA_impl*
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
//#UC START# *4DAEEDE10285_B38D1749E0D8_var*
//#UC END# *4DAEEDE10285_B38D1749E0D8_var*
begin
//#UC START# *4DAEEDE10285_B38D1749E0D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B38D1749E0D8_impl*
end;//TkwPopEditorCaretVisible.DoDoIt

class function TkwPopEditorCaretVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:CaretVisible';
end;//TkwPopEditorCaretVisible.GetWordNameForRegister

procedure TkwPopEditorCaretVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B38D1749E0D8_var*
//#UC END# *52D00B00031A_B38D1749E0D8_var*
begin
//#UC START# *52D00B00031A_B38D1749E0D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B38D1749E0D8_impl*
end;//TkwPopEditorCaretVisible.SetValuePrim

function TkwPopEditorCaretVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B38D1749E0D8_var*
//#UC END# *551544E2001A_B38D1749E0D8_var*
begin
//#UC START# *551544E2001A_B38D1749E0D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B38D1749E0D8_impl*
end;//TkwPopEditorCaretVisible.GetResultTypeInfo

function TkwPopEditorCaretVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_B38D1749E0D8_var*
//#UC END# *559687E6025A_B38D1749E0D8_var*
begin
//#UC START# *559687E6025A_B38D1749E0D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_B38D1749E0D8_impl*
end;//TkwPopEditorCaretVisible.GetAllParamsCount

function TkwPopEditorCaretVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B38D1749E0D8_var*
//#UC END# *5617F4D00243_B38D1749E0D8_var*
begin
//#UC START# *5617F4D00243_B38D1749E0D8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B38D1749E0D8_impl*
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
//#UC START# *4DAEEDE10285_A77B7AB26CFF_var*
//#UC END# *4DAEEDE10285_A77B7AB26CFF_var*
begin
//#UC START# *4DAEEDE10285_A77B7AB26CFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A77B7AB26CFF_impl*
end;//TkwPopEditorShowDocumentParts.DoDoIt

class function TkwPopEditorShowDocumentParts.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:ShowDocumentParts';
end;//TkwPopEditorShowDocumentParts.GetWordNameForRegister

procedure TkwPopEditorShowDocumentParts.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A77B7AB26CFF_var*
//#UC END# *52D00B00031A_A77B7AB26CFF_var*
begin
//#UC START# *52D00B00031A_A77B7AB26CFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A77B7AB26CFF_impl*
end;//TkwPopEditorShowDocumentParts.SetValuePrim

function TkwPopEditorShowDocumentParts.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A77B7AB26CFF_var*
//#UC END# *551544E2001A_A77B7AB26CFF_var*
begin
//#UC START# *551544E2001A_A77B7AB26CFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A77B7AB26CFF_impl*
end;//TkwPopEditorShowDocumentParts.GetResultTypeInfo

function TkwPopEditorShowDocumentParts.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_A77B7AB26CFF_var*
//#UC END# *559687E6025A_A77B7AB26CFF_var*
begin
//#UC START# *559687E6025A_A77B7AB26CFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_A77B7AB26CFF_impl*
end;//TkwPopEditorShowDocumentParts.GetAllParamsCount

function TkwPopEditorShowDocumentParts.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A77B7AB26CFF_var*
//#UC END# *5617F4D00243_A77B7AB26CFF_var*
begin
//#UC START# *5617F4D00243_A77B7AB26CFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A77B7AB26CFF_impl*
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
//#UC START# *4DAEEDE10285_85D5F3815C6E_var*
//#UC END# *4DAEEDE10285_85D5F3815C6E_var*
begin
//#UC START# *4DAEEDE10285_85D5F3815C6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_85D5F3815C6E_impl*
end;//TkwPopEditorWebStyle.DoDoIt

class function TkwPopEditorWebStyle.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:WebStyle';
end;//TkwPopEditorWebStyle.GetWordNameForRegister

procedure TkwPopEditorWebStyle.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_85D5F3815C6E_var*
//#UC END# *52D00B00031A_85D5F3815C6E_var*
begin
//#UC START# *52D00B00031A_85D5F3815C6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_85D5F3815C6E_impl*
end;//TkwPopEditorWebStyle.SetValuePrim

function TkwPopEditorWebStyle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_85D5F3815C6E_var*
//#UC END# *551544E2001A_85D5F3815C6E_var*
begin
//#UC START# *551544E2001A_85D5F3815C6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_85D5F3815C6E_impl*
end;//TkwPopEditorWebStyle.GetResultTypeInfo

function TkwPopEditorWebStyle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_85D5F3815C6E_var*
//#UC END# *559687E6025A_85D5F3815C6E_var*
begin
//#UC START# *559687E6025A_85D5F3815C6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_85D5F3815C6E_impl*
end;//TkwPopEditorWebStyle.GetAllParamsCount

function TkwPopEditorWebStyle.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_85D5F3815C6E_var*
//#UC END# *5617F4D00243_85D5F3815C6E_var*
begin
//#UC START# *5617F4D00243_85D5F3815C6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_85D5F3815C6E_impl*
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
//#UC START# *4DAEEDE10285_BB22FD3C71A4_var*
//#UC END# *4DAEEDE10285_BB22FD3C71A4_var*
begin
//#UC START# *4DAEEDE10285_BB22FD3C71A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BB22FD3C71A4_impl*
end;//TkwPopEditorDrawSpecial.DoDoIt

class function TkwPopEditorDrawSpecial.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:DrawSpecial';
end;//TkwPopEditorDrawSpecial.GetWordNameForRegister

procedure TkwPopEditorDrawSpecial.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BB22FD3C71A4_var*
//#UC END# *52D00B00031A_BB22FD3C71A4_var*
begin
//#UC START# *52D00B00031A_BB22FD3C71A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BB22FD3C71A4_impl*
end;//TkwPopEditorDrawSpecial.SetValuePrim

function TkwPopEditorDrawSpecial.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_BB22FD3C71A4_var*
//#UC END# *551544E2001A_BB22FD3C71A4_var*
begin
//#UC START# *551544E2001A_BB22FD3C71A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_BB22FD3C71A4_impl*
end;//TkwPopEditorDrawSpecial.GetResultTypeInfo

function TkwPopEditorDrawSpecial.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_BB22FD3C71A4_var*
//#UC END# *559687E6025A_BB22FD3C71A4_var*
begin
//#UC START# *559687E6025A_BB22FD3C71A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_BB22FD3C71A4_impl*
end;//TkwPopEditorDrawSpecial.GetAllParamsCount

function TkwPopEditorDrawSpecial.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_BB22FD3C71A4_var*
//#UC END# *5617F4D00243_BB22FD3C71A4_var*
begin
//#UC START# *5617F4D00243_BB22FD3C71A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_BB22FD3C71A4_impl*
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
//#UC START# *4DAEEDE10285_EE3EA3E1113C_var*
//#UC END# *4DAEEDE10285_EE3EA3E1113C_var*
begin
//#UC START# *4DAEEDE10285_EE3EA3E1113C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EE3EA3E1113C_impl*
end;//TkwPopEditorDocumentTailVisible.DoDoIt

class function TkwPopEditorDocumentTailVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:DocumentTailVisible';
end;//TkwPopEditorDocumentTailVisible.GetWordNameForRegister

procedure TkwPopEditorDocumentTailVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_EE3EA3E1113C_var*
//#UC END# *52D00B00031A_EE3EA3E1113C_var*
begin
//#UC START# *52D00B00031A_EE3EA3E1113C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_EE3EA3E1113C_impl*
end;//TkwPopEditorDocumentTailVisible.SetValuePrim

function TkwPopEditorDocumentTailVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_EE3EA3E1113C_var*
//#UC END# *551544E2001A_EE3EA3E1113C_var*
begin
//#UC START# *551544E2001A_EE3EA3E1113C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_EE3EA3E1113C_impl*
end;//TkwPopEditorDocumentTailVisible.GetResultTypeInfo

function TkwPopEditorDocumentTailVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_EE3EA3E1113C_var*
//#UC END# *559687E6025A_EE3EA3E1113C_var*
begin
//#UC START# *559687E6025A_EE3EA3E1113C_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_EE3EA3E1113C_impl*
end;//TkwPopEditorDocumentTailVisible.GetAllParamsCount

function TkwPopEditorDocumentTailVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_EE3EA3E1113C_var*
//#UC END# *5617F4D00243_EE3EA3E1113C_var*
begin
//#UC START# *5617F4D00243_EE3EA3E1113C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_EE3EA3E1113C_impl*
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
//#UC START# *4DAEEDE10285_C36C39E9CCC8_var*
//#UC END# *4DAEEDE10285_C36C39E9CCC8_var*
begin
//#UC START# *4DAEEDE10285_C36C39E9CCC8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C36C39E9CCC8_impl*
end;//TkwPopEditorModified.DoDoIt

class function TkwPopEditorModified.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:Modified';
end;//TkwPopEditorModified.GetWordNameForRegister

procedure TkwPopEditorModified.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C36C39E9CCC8_var*
//#UC END# *52D00B00031A_C36C39E9CCC8_var*
begin
//#UC START# *52D00B00031A_C36C39E9CCC8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C36C39E9CCC8_impl*
end;//TkwPopEditorModified.SetValuePrim

function TkwPopEditorModified.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C36C39E9CCC8_var*
//#UC END# *551544E2001A_C36C39E9CCC8_var*
begin
//#UC START# *551544E2001A_C36C39E9CCC8_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C36C39E9CCC8_impl*
end;//TkwPopEditorModified.GetResultTypeInfo

function TkwPopEditorModified.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C36C39E9CCC8_var*
//#UC END# *559687E6025A_C36C39E9CCC8_var*
begin
//#UC START# *559687E6025A_C36C39E9CCC8_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C36C39E9CCC8_impl*
end;//TkwPopEditorModified.GetAllParamsCount

function TkwPopEditorModified.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C36C39E9CCC8_var*
//#UC END# *5617F4D00243_C36C39E9CCC8_var*
begin
//#UC START# *5617F4D00243_C36C39E9CCC8_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C36C39E9CCC8_impl*
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
//#UC START# *4DAEEDE10285_3928ECE1F34F_var*
//#UC END# *4DAEEDE10285_3928ECE1F34F_var*
begin
//#UC START# *4DAEEDE10285_3928ECE1F34F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3928ECE1F34F_impl*
end;//TkwPopEditorDrawLines.DoDoIt

class function TkwPopEditorDrawLines.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:DrawLines';
end;//TkwPopEditorDrawLines.GetWordNameForRegister

procedure TkwPopEditorDrawLines.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3928ECE1F34F_var*
//#UC END# *52D00B00031A_3928ECE1F34F_var*
begin
//#UC START# *52D00B00031A_3928ECE1F34F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3928ECE1F34F_impl*
end;//TkwPopEditorDrawLines.SetValuePrim

function TkwPopEditorDrawLines.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3928ECE1F34F_var*
//#UC END# *551544E2001A_3928ECE1F34F_var*
begin
//#UC START# *551544E2001A_3928ECE1F34F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3928ECE1F34F_impl*
end;//TkwPopEditorDrawLines.GetResultTypeInfo

function TkwPopEditorDrawLines.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_3928ECE1F34F_var*
//#UC END# *559687E6025A_3928ECE1F34F_var*
begin
//#UC START# *559687E6025A_3928ECE1F34F_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_3928ECE1F34F_impl*
end;//TkwPopEditorDrawLines.GetAllParamsCount

function TkwPopEditorDrawLines.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3928ECE1F34F_var*
//#UC END# *5617F4D00243_3928ECE1F34F_var*
begin
//#UC START# *5617F4D00243_3928ECE1F34F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3928ECE1F34F_impl*
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
//#UC START# *4DAEEDE10285_1009897A0104_var*
//#UC END# *4DAEEDE10285_1009897A0104_var*
begin
//#UC START# *4DAEEDE10285_1009897A0104_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1009897A0104_impl*
end;//TkwPopEditorAllowRubberTables.DoDoIt

class function TkwPopEditorAllowRubberTables.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Editor:AllowRubberTables';
end;//TkwPopEditorAllowRubberTables.GetWordNameForRegister

procedure TkwPopEditorAllowRubberTables.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1009897A0104_var*
//#UC END# *52D00B00031A_1009897A0104_var*
begin
//#UC START# *52D00B00031A_1009897A0104_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1009897A0104_impl*
end;//TkwPopEditorAllowRubberTables.SetValuePrim

function TkwPopEditorAllowRubberTables.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1009897A0104_var*
//#UC END# *551544E2001A_1009897A0104_var*
begin
//#UC START# *551544E2001A_1009897A0104_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1009897A0104_impl*
end;//TkwPopEditorAllowRubberTables.GetResultTypeInfo

function TkwPopEditorAllowRubberTables.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_1009897A0104_var*
//#UC END# *559687E6025A_1009897A0104_var*
begin
//#UC START# *559687E6025A_1009897A0104_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_1009897A0104_impl*
end;//TkwPopEditorAllowRubberTables.GetAllParamsCount

function TkwPopEditorAllowRubberTables.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1009897A0104_var*
//#UC END# *5617F4D00243_1009897A0104_var*
begin
//#UC START# *5617F4D00243_1009897A0104_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1009897A0104_impl*
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
