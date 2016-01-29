unit EditorFromStackKeyWordsPack;

interface

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

implementation

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
 , kwPopEditorRepaintAndCheckWithEtalon
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
 , kwBeginWaitPrint
 , kwEndWaitPrint
 , evTypes
 , TevCustomEditorWordsPack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TEditorFromStackKeyWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TEditorFromStackKeyWordsPackResNameGetter
 
 TkwPopEditorScrollBottom = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollBottom
*Пример:*
[code]
 aVert aEditor pop:Editor:ScrollBottom
[code]  }
  procedure ScrollBottom(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow;
   aVert: Boolean);
   {* Реализация слова скрипта pop:Editor:ScrollBottom }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorScrollBottom
 
 TkwPopEditorScrollLineUp = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollLineUp
*Пример:*
[code]
 aEditor pop:Editor:ScrollLineUp
[code]  }
  procedure ScrollLineUp(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow);
   {* Реализация слова скрипта pop:Editor:ScrollLineUp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorScrollLineUp
 
 TkwPopEditorScrollLineDown = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollLineDown
*Пример:*
[code]
 aEditor pop:Editor:ScrollLineDown
[code]  }
  procedure ScrollLineDown(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow);
   {* Реализация слова скрипта pop:Editor:ScrollLineDown }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorScrollLineDown
 
 TkwPopEditorScrollTo = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:ScrollTo
*Пример:*
[code]
 aPosition aVert aEditor pop:Editor:ScrollTo
[code]  }
  procedure ScrollTo(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow;
   aVert: Boolean;
   aPosition: Integer);
   {* Реализация слова скрипта pop:Editor:ScrollTo }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorScrollTo
 
 TkwPopEditorPushParaFromCursor = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:PushParaFromCursor
*Тип результата:* InevPara
*Пример:*
[code]
INTERFACE VAR l_InevPara
 aEditor pop:Editor:PushParaFromCursor >>> l_InevPara
[code]  }
  function PushParaFromCursor(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): InevPara;
   {* Реализация слова скрипта pop:Editor:PushParaFromCursor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorPushParaFromCursor
 
 TkwPopEditorSelectAll = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SelectAll
*Пример:*
[code]
 aEditor pop:Editor:SelectAll
[code]  }
  procedure SelectAll(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow);
   {* Реализация слова скрипта pop:Editor:SelectAll }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorSelectAll
 
 TkwPopEditorSelectPara = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SelectPara
*Пример:*
[code]
 aEditor pop:Editor:SelectPara
[code]  }
  procedure SelectPara(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow);
   {* Реализация слова скрипта pop:Editor:SelectPara }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorSelectPara
 
 TkwPopEditorAtTop = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:AtTop
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:AtTop >>> l_Boolean
[code]  }
  function AtTop(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* Реализация слова скрипта pop:Editor:AtTop }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorAtTop
 
 TkwPopEditorSelectWord = class(TtfwClassLike)
  {* Слово скрипта pop:Editor:SelectWord
*Пример:*
[code]
 aEditor pop:Editor:SelectWord
[code]  }
  procedure SelectWord(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow);
   {* Реализация слова скрипта pop:Editor:SelectWord }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorSelectWord
 
 TkwPopEditorCaretVisible = class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:CaretVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:CaretVisible >>> l_Boolean
[code]  }
  function CaretVisible(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* Реализация слова скрипта pop:Editor:CaretVisible }
  procedure DoSetValue(aEditor: TevCustomEditorWindow;
   aValue: Boolean);
   {* Метод установки значения свойства CaretVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorCaretVisible
 
 TkwPopEditorShowDocumentParts = class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:ShowDocumentParts
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:ShowDocumentParts >>> l_Boolean
[code]  }
  function ShowDocumentParts(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* Реализация слова скрипта pop:Editor:ShowDocumentParts }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorShowDocumentParts
 
 TkwPopEditorWebStyle = class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:WebStyle
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:WebStyle >>> l_Boolean
[code]  }
  function WebStyle(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* Реализация слова скрипта pop:Editor:WebStyle }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorWebStyle
 
 TkwPopEditorDrawSpecial = class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:DrawSpecial
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:DrawSpecial >>> l_Boolean
[code]  }
  function DrawSpecial(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* Реализация слова скрипта pop:Editor:DrawSpecial }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorDrawSpecial
 
 TkwPopEditorDocumentTailVisible = class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:DocumentTailVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:DocumentTailVisible >>> l_Boolean
[code]  }
  function DocumentTailVisible(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* Реализация слова скрипта pop:Editor:DocumentTailVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorDocumentTailVisible
 
 TkwPopEditorModified = class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:Modified
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:Modified >>> l_Boolean
[code]  }
  function Modified(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* Реализация слова скрипта pop:Editor:Modified }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorModified
 
 TkwPopEditorDrawLines = class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:DrawLines
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:DrawLines >>> l_Boolean
[code]  }
  function DrawLines(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* Реализация слова скрипта pop:Editor:DrawLines }
  procedure DoSetValue(aEditor: TevCustomEditorWindow;
   aValue: Boolean);
   {* Метод установки значения свойства DrawLines }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorDrawLines
 
 TkwPopEditorAllowRubberTables = class(TtfwPropertyLike)
  {* Слово скрипта pop:Editor:AllowRubberTables
*Тип результата:* TnevRubberTablesMode
*Пример:*
[code]
TnevRubberTablesMode VAR l_TnevRubberTablesMode
 aEditor pop:Editor:AllowRubberTables >>> l_TnevRubberTablesMode
[code]  }
  function AllowRubberTables(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): TnevRubberTablesMode;
   {* Реализация слова скрипта pop:Editor:AllowRubberTables }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorAllowRubberTables
 
end.
