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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TEditorFromStackKeyWordsPackResNameGetter
 
 TkwPopEditorScrollBottom = class(TtfwClassLike)
  {* ����� ������� pop:Editor:ScrollBottom
*������:*
[code]
 aVert aEditor pop:Editor:ScrollBottom
[code]  }
  procedure ScrollBottom(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow;
   aVert: Boolean);
   {* ���������� ����� ������� pop:Editor:ScrollBottom }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorScrollBottom
 
 TkwPopEditorScrollLineUp = class(TtfwClassLike)
  {* ����� ������� pop:Editor:ScrollLineUp
*������:*
[code]
 aEditor pop:Editor:ScrollLineUp
[code]  }
  procedure ScrollLineUp(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow);
   {* ���������� ����� ������� pop:Editor:ScrollLineUp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorScrollLineUp
 
 TkwPopEditorScrollLineDown = class(TtfwClassLike)
  {* ����� ������� pop:Editor:ScrollLineDown
*������:*
[code]
 aEditor pop:Editor:ScrollLineDown
[code]  }
  procedure ScrollLineDown(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow);
   {* ���������� ����� ������� pop:Editor:ScrollLineDown }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorScrollLineDown
 
 TkwPopEditorScrollTo = class(TtfwClassLike)
  {* ����� ������� pop:Editor:ScrollTo
*������:*
[code]
 aPosition aVert aEditor pop:Editor:ScrollTo
[code]  }
  procedure ScrollTo(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow;
   aVert: Boolean;
   aPosition: Integer);
   {* ���������� ����� ������� pop:Editor:ScrollTo }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorScrollTo
 
 TkwPopEditorPushParaFromCursor = class(TtfwClassLike)
  {* ����� ������� pop:Editor:PushParaFromCursor
*��� ����������:* InevPara
*������:*
[code]
INTERFACE VAR l_InevPara
 aEditor pop:Editor:PushParaFromCursor >>> l_InevPara
[code]  }
  function PushParaFromCursor(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): InevPara;
   {* ���������� ����� ������� pop:Editor:PushParaFromCursor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorPushParaFromCursor
 
 TkwPopEditorSelectAll = class(TtfwClassLike)
  {* ����� ������� pop:Editor:SelectAll
*������:*
[code]
 aEditor pop:Editor:SelectAll
[code]  }
  procedure SelectAll(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow);
   {* ���������� ����� ������� pop:Editor:SelectAll }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorSelectAll
 
 TkwPopEditorSelectPara = class(TtfwClassLike)
  {* ����� ������� pop:Editor:SelectPara
*������:*
[code]
 aEditor pop:Editor:SelectPara
[code]  }
  procedure SelectPara(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow);
   {* ���������� ����� ������� pop:Editor:SelectPara }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorSelectPara
 
 TkwPopEditorAtTop = class(TtfwClassLike)
  {* ����� ������� pop:Editor:AtTop
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:AtTop >>> l_Boolean
[code]  }
  function AtTop(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* ���������� ����� ������� pop:Editor:AtTop }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorAtTop
 
 TkwPopEditorSelectWord = class(TtfwClassLike)
  {* ����� ������� pop:Editor:SelectWord
*������:*
[code]
 aEditor pop:Editor:SelectWord
[code]  }
  procedure SelectWord(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow);
   {* ���������� ����� ������� pop:Editor:SelectWord }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorSelectWord
 
 TkwPopEditorCaretVisible = class(TtfwPropertyLike)
  {* ����� ������� pop:Editor:CaretVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:CaretVisible >>> l_Boolean
[code]  }
  function CaretVisible(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* ���������� ����� ������� pop:Editor:CaretVisible }
  procedure DoSetValue(aEditor: TevCustomEditorWindow;
   aValue: Boolean);
   {* ����� ��������� �������� �������� CaretVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorCaretVisible
 
 TkwPopEditorShowDocumentParts = class(TtfwPropertyLike)
  {* ����� ������� pop:Editor:ShowDocumentParts
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:ShowDocumentParts >>> l_Boolean
[code]  }
  function ShowDocumentParts(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* ���������� ����� ������� pop:Editor:ShowDocumentParts }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorShowDocumentParts
 
 TkwPopEditorWebStyle = class(TtfwPropertyLike)
  {* ����� ������� pop:Editor:WebStyle
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:WebStyle >>> l_Boolean
[code]  }
  function WebStyle(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* ���������� ����� ������� pop:Editor:WebStyle }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorWebStyle
 
 TkwPopEditorDrawSpecial = class(TtfwPropertyLike)
  {* ����� ������� pop:Editor:DrawSpecial
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:DrawSpecial >>> l_Boolean
[code]  }
  function DrawSpecial(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* ���������� ����� ������� pop:Editor:DrawSpecial }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorDrawSpecial
 
 TkwPopEditorDocumentTailVisible = class(TtfwPropertyLike)
  {* ����� ������� pop:Editor:DocumentTailVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:DocumentTailVisible >>> l_Boolean
[code]  }
  function DocumentTailVisible(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* ���������� ����� ������� pop:Editor:DocumentTailVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorDocumentTailVisible
 
 TkwPopEditorModified = class(TtfwPropertyLike)
  {* ����� ������� pop:Editor:Modified
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:Modified >>> l_Boolean
[code]  }
  function Modified(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* ���������� ����� ������� pop:Editor:Modified }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorModified
 
 TkwPopEditorDrawLines = class(TtfwPropertyLike)
  {* ����� ������� pop:Editor:DrawLines
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aEditor pop:Editor:DrawLines >>> l_Boolean
[code]  }
  function DrawLines(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): Boolean;
   {* ���������� ����� ������� pop:Editor:DrawLines }
  procedure DoSetValue(aEditor: TevCustomEditorWindow;
   aValue: Boolean);
   {* ����� ��������� �������� �������� DrawLines }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorDrawLines
 
 TkwPopEditorAllowRubberTables = class(TtfwPropertyLike)
  {* ����� ������� pop:Editor:AllowRubberTables
*��� ����������:* TnevRubberTablesMode
*������:*
[code]
TnevRubberTablesMode VAR l_TnevRubberTablesMode
 aEditor pop:Editor:AllowRubberTables >>> l_TnevRubberTablesMode
[code]  }
  function AllowRubberTables(const aCtx: TtfwContext;
   aEditor: TevCustomEditorWindow): TnevRubberTablesMode;
   {* ���������� ����� ������� pop:Editor:AllowRubberTables }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopEditorAllowRubberTables
 
end.
