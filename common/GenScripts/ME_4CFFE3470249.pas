unit vtLister;
 {* Видимый элемент для отображения виртуального списка строк. Для конечного использования. }

// Модуль: "w:\common\components\gui\Garant\VT\vtLister.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TvtLister" MUID: (4CFFE3470249)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , Windows
 , l3Interfaces
 , l3InternalInterfaces
 , l3ControlsTypes
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , vtHeader
 , afwInputControl
 , afwInterfaces
 , l3LogicalArray
 , l3LongintList
 , afwCaret
 , Classes
 , OvcColor
 , OvcCmd
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Types
 , Messages
 , afwTypes
 , l3DatLst
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Defaults
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *4CFFE3470249intf_uses*
 //#UC END# *4CFFE3470249intf_uses*
;

const
 DefAutoRowHeight = True;
 DefAlign = alNone;
 DefBorderStyle = Forms.bsSingle;
 DefColor = clWindow;
 DefColumns = 255;
 DefCtl3D = True;
 {$If Defined(Nemesis)}
 DefHeaderBack = l3Defaults.cGarant2011BackColor;
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 DefHeaderBack = clBtnFace;
 {$IfEnd} // NOT Defined(Nemesis)
 DefHeaderText = clBtnText;
 DefIntegralHeight = True;
 DefItemIndex = -1;
 DefMultiSelect = False;
 DefNumItems = 0;
 DefParentColor = False;
 DefParentCtl3D = True;
 DefProtectBack = clRed;
 DefProtectText = clWhite;
 DefRowHeight = 16;
 DefScrollBars = StdCtrls.ssVertical;
 DefSelectBack = clHighlight;
 DefSelectNFBack = clBtnFace;
 DefSelectText = clHighlightText;
 DefSelectNFText = clBtnText;
 DefShowHeader = False;
 DefTopIndex = 0;
 DefTabStop = True;
 DefUseTabStops = False;
const
 MaxTabStops = 128;
 msg_vtUpdateScroll = WM_User + 2;
 WM_U_ARTFULBEHAVIOUR = WM_User + 3;
 vtMultiLineDrawTextFormat = Windows.DT_LEFT or DT_WORDBREAK or DT_NOPREFIX;
 vt_smAllInvert = -2;
  {* для DoOnSelect }
 vt_smAllSelect = -3;
  {* для DoOnSelect }
 vt_TabbedMLOutGap = 8;
  {* зазор между колонками при многострочном выводе }
 msg_vtInvalidateNCArea = WM_User + 4;

type
 TvtVJustify = (
  vt_vjTop
  , vt_vjBottom
  , vt_vjCenter
 );//TvtVJustify

 TActionElement = procedure(Sender: TObject;
  Index: LongInt) of object;

 TCountChanged = procedure(Sender: TObject;
  NewCount: LongInt) of object;

 TCurrentChanged = procedure(Sender: TObject;
  aNewCurrent: LongInt;
  aOldCurrent: LongInt) of object;

 TvtUpdateFlag = (
  vt_ufHPos
  , vt_ufHInfo
  , vt_ufVPos
  , vt_ufVInfo
 );//TvtUpdateFlag

 TvtUpdateFlags = set of TvtUpdateFlag;

 TOverlayIndexArray = array of Integer;

 TCharToItemEvent = procedure(Sender: TObject;
  var SrchStr: AnsiString;
  aFromCurrent: Boolean;
  var Index: LongInt) of object;
  {* event to notify caller of a key press and return new item index }

 TGetStrItemEvent = procedure(Sender: TObject;
  Index: LongInt;
  var ItemString: Il3CString) of object;
  {* событие для получения строчки элемента.
event to get string to display }

 TGetPCharItemEvent = procedure(Sender: TObject;
  Index: LongInt;
  var ItemString: PAnsiChar) of object;
  {* событие для получения строчки элемента (в виде PChar).
event to get string (PCHAR) to display }

 TGetItemPainterEvent = function(Sender: TObject;
  Index: LongInt): Il3NodePainter of object;

 TGetItemImage = Tl3GetItemImage;
  {* event to get Index of Bitmap in ImageIndex; }

 TOnGetItemImageOverlays = procedure(Sender: TObject;
  aIndex: Integer;
  var theOverlays: TOverlayIndexArray) of object;

 TGetCellItemImage = function(Sender: TObject;
  Index: LongInt;
  Column: LongInt;
  var aImages: TCustomImageList): Integer of object;
  {* event to get Index of Bitmap in ImageIndex for tab-separated items; }

 TGetPickItemImage = procedure(Sender: TObject;
  Index: LongInt;
  var aImages: TCustomImageList;
  var aImageIndex: Integer) of object;
  {* event to get Index of Bitmap in ImageIndex }

 TGetItemHint = function(Sender: TObject;
  Index: LongInt): Il3CString of object;
  {* event to get Hint String; }

 TGetItemTextHint = function(Sender: TObject;
  Index: LongInt): Il3CString of object;
  {* получение hint-а при задерке курсора над текстом. }

 TGetItemCursor = function(aSender: TObject;
  aIndex: Integer): TCursor of object;
  {* event to get Item Cursor }

 TGetItemBitmapEvent = procedure(Sender: TObject;
  Index: LongInt;
  var ItemBMP: TBitmap) of object;
  {* event to get Bitmap of string to display }

 TGetItemColorEvent = procedure(Sender: TObject;
  Index: LongInt;
  var FG: TColor;
  var BG: TColor) of object;
  {* событие для получения цвета элемента.
event to get color of the item cell }

 TGetItemFontEvent = procedure(Sender: TObject;
  Index: LongInt;
  const aFont: Il3Font) of object;
  {* event to get Font of the item cell
событие для получения шрифта элемента. }

 TGetItemImageState = procedure(const Sender: TObject;
  const aItemIndex: LongInt;
  var aEnabled: Boolean) of object;
  {* событие получения состояния иконки. }

 TGetItemStatusEvent = procedure(Sender: TObject;
  Index: LongInt;
  var Protect: Boolean) of object;
  {* event to get the protected status item }

 TIsSelectedEvent = procedure(Sender: TObject;
  Index: LongInt;
  var SelectedState: Integer) of object;
  {* event to get the current selection status from the user }

 TSelectEvent = procedure(Sender: TObject;
  Index: LongInt;
  var SelectedState: Integer) of object;
  {* event to notify of a selection change }

 TTopIndexChanged = procedure(Sender: TObject;
  NewTopIndex: LongInt) of object;
  {* нотификация об изменении верхнего видимого элемента.
event to notify when the top index changes }

 TValidateCurrent = procedure(Sender: TObject;
  var NewCurrent: LongInt) of object;
  {* event to validate Current index changes }

 TQuickSearchStrChanged = procedure(Sender: TObject;
  const CurStr: AnsiString) of object;
  {* event to notify about changing quicksearch string }

 TCommandProcessedEvent = function(aSender: TObject;
  aOperation: Tl3OperationCode): Boolean of object;

 //#UC START# *514B3E890126ci*
 //#UC END# *514B3E890126ci*
 //#UC START# *514B3E890126cit*
 //#UC END# *514B3E890126cit*
 TvtListerHeader = class(TvtCustomHeader)
 //#UC START# *514B3E890126publ*
  published
   property Color;
   property Sections;
   property Font;
   property Images;
   property OnClickHeader;
   property OnGetItemImageIndex;
 //#UC END# *514B3E890126publ*
 end;//TvtListerHeader

 TvtToggleSelectionEvent = function(aSender: TObject;
  anIndex: Integer): Boolean of object;

 TvtItemStorageViewer = class(TafwInputControl)
  {* Базовый видимый элемент для отображения содержимого хранилищ (списков, деревьев etc). }
 end;//TvtItemStorageViewer

 TvtListerState = (
  vt_lsSizing
  , vt_lsUpdatingNCArea
 );//TvtListerState

 TvtListerStates = set of TvtListerState;

 TvtListerItemPart = (
  vt_lipText
  , vt_lipTextHint
  , vt_lipIconHint
 );//TvtListerItemPart

 TTabStopsRange = 0 .. MaxTabStops;

 TvtCustomListerPrim = class(TvtItemStorageViewer{$If NOT Defined(DesignTimeLibrary)}
 , IafwStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , Il3Window)
  private
   f_HintTimerCount: Integer;
   f_HintWindow: THintWindow;
   f_LastHintIndex: LongInt;
   f_HintPosition: TPoint;
   f_LastHintContext: Byte;
   f_FooterActive: Boolean;
   f_FontHeight: Integer;
   f_Rows: Integer;
   f_FontChanged: Boolean;
   f_NeedCurrentVisible: Boolean;
   f_NeedResetSelectArray: Boolean;
   f_DlgUnits: Integer;
   f_InScroll: Boolean;
   f_UpdateFlags: TvtUpdateFlags;
   f_NeedQuickSearch: Boolean;
   f_Updating: Boolean;
   f_LockDraw: Integer;
   f_OldMousePos: TPoint;
   f_LockMakeCurrentVisible: Boolean;
   f_ImagesChangeLink: TChangeLink;
   f_FocusedAt: Cardinal;
   f_DnDProcess: Boolean;
   f_NeedSelectFromPointAfterUpMouse: Boolean;
   f_LastHintTextColumn: Integer;
   f_NumTabStops: TTabStopsRange;
   f_InInitScrollInfo: Boolean;
   f_VScrollPersistent: Boolean;
   f_States: TvtListerStates;
   f_SelectArray: Tl3LogicalArray;
   f_ViewOptions: TvtViewOptions;
   f_DrawPoints: Tl3LongintList;
   f_AllowWithoutCurrent: Boolean;
    {* допустимо отсутствие текущего. }
   f_Caret: TafwCaret;
   f_VJustify: TvtVJustify;
   f_FooterCaption: AnsiString;
   f_FooterVisible: Boolean;
   f_FooterStyleID: Tl3StyleId;
   f_FooterActiveStyleID: Tl3StyleId;
   f_FooterFont: TFont;
   f_FooterActiveFont: TFont;
   f_OnFooterClick: TNotifyEvent;
   f_FooterSelected: Boolean;
   f_InterRowIndent: Integer;
    {* промежуток между элементами дерева }
   f_OnVScrollVisibleChanged: TNotifyEvent;
    {* изменилась видимость вертикальной полосы прокрутки }
   f_OnHScrollVisibleChanged: TNotifyEvent;
    {* изменилась видимость горизонтальной полосы прокрутки }
   f_SearchStr: AnsiString;
   f_AutoRowHeight: Boolean;
   f_Columns: Byte;
   f_Header: TvtListerHeader;
   f_IntegralHeight: Boolean;
   f_Current: LongInt;
    {* индекс текущего элемента }
   f_Images: TCustomImageList;
    {* список картинок для отображения перед элементами }
   f_MultiStrokeItem: Boolean;
   f_PickedList: Boolean;
    {* отображать ли галочки перед элементами }
   f_TriplePicked: Boolean;
    {* отображать ли "третье состояние" галочки перед элементами }
   f_ReadOnly: Boolean;
    {* признак запрещения редактирования }
   f_MultiSelect: Boolean;
   f_Options: TvlOptions;
   f_Total: LongInt;
    {* количество элементов }
   f_ProtectColor: TOvcColors;
   f_SelectColor: TOvcColors;
   f_SelectNonFocusColor: TOvcColors;
   f_DisableAlignTopIndex: Boolean;
   f_TopIndex: LongInt;
   f_UseTabStops: Boolean;
   f_FixAnchor: Boolean;
   f_UseStyleTable: Boolean;
    {* использовать изменение таблицы стилей }
   f_StyleId: Tl3StyleId;
    {* идентификатор стиля в таблице стилей }
   f_ActionElementMode: Tl3ActionElementMode;
   f_DrawGrid: Boolean;
   f_TreatDefaultColorAsWindowColor: Boolean;
   {$If Defined(Nemesis)}
   f_NonTrackScroll: Boolean;
   {$IfEnd} // Defined(Nemesis)
   f_OnToggleSelection: TvtToggleSelectionEvent;
   f_OnCharToItem: TCharToItemEvent;
   f_OnGetItemPainter: TGetItemPainterEvent;
    {* событие для получения автономного "рисовальщика" элемента }
   f_OnGetStrItem: TGetStrItemEvent;
    {* событие для получения строчки элемента }
   f_OnGetPCharItem: TGetPCharItemEvent;
    {* событие для получения строчки элемента (в виде PChar). }
   f_OnGetItemImageIndex: TGetItemImageIndex;
   f_OnGetItemImageOverlays: TOnGetItemImageOverlays;
   f_OnGetItemPickImage: TGetPickItemImage;
    {* событие для получения картинки галки (Pick) для элемента. Если ItemIndex < 0,
то Index картинки считать не надо (используется для получения ImageList) }
   f_OnGetItemIconHint: TGetItemHint;
    {* событие для получения hint'a для картинки элемента. }
   f_OnGetItemTextHint: TGetItemTextHint;
    {* событи для получения hint-а к тексту элемента. }
   f_OnGetItemCursor: TGetItemCursor;
    {* событие для получения Cursor для элемента. }
   f_OnGetItemColor: TGetItemColorEvent;
    {* событие для получения цвета элемента. }
   f_OnGetItemFont: TGetItemFontEvent;
    {* событие для получения шрифта элемента. }
   f_OnGetItemImageState: TGetItemImageState;
   f_OnGetItemStatus: TGetItemStatusEvent;
   f_OnIsSelected: TIsSelectedEvent;
   f_OnSelect: TSelectEvent;
   f_OnSelectChange: TSelectEvent;
   f_OnSelectChanged: TSelectEvent;
   f_OnTopIndexChanged: TTopIndexChanged;
    {* нотификация об изменении верхнего видимого элемента. }
   f_OnCurrentChanged: TCurrentChanged;
    {* нотификация об изменении текущего }
   f_OnValidateCurrent: TValidateCurrent;
    {* нотификация на корректировку номера текущего элемента }
   f_OnCountChanged: TCountChanged;
   f_OnUserCommand: TUserCommandEvent;
   f_OnIsCommandProcessed: TCommandProcessedEvent;
   f_OnActionElement: TActionElement;
   f_OnResize: TNotifyEvent;
   f_OnRMouseDown: TMouseEvent;
   f_OnLMouseDown: TMouseEvent;
   f_OnQuickSearchStrChanged: TQuickSearchStrChanged;
   f_OnGetCellItemImage: TGetCellItemImage;
   f_OnNeedRecalcConstraints: TNotifyEvent;
  protected
   f_HintTimer: TTimer;
   f_TabsFirstIndent: Integer;
   f_RowHeight: Integer;
   f_HighIndex: LongInt;
   f_Anchor: LongInt;
   f_InQuickSearch: Integer;
   f_LockSelectChange: Boolean;
   f_HDelta: Integer;
   f_EvenScrolled: Boolean;
   f_CaretPoint: TPoint;
   f_LastPageSize: Integer;
   f_InActionProcess: Boolean;
  private
   function ImageAddSpace: Integer;
   procedure UpdateFooterActivity(aValue: Boolean);
   procedure MakeSureCaretIsCreated;
   procedure DoNeedRecalcConstraints;
   procedure InvalidateNonclientArea;
   procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
   procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
   procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
   procedure WMGetText(var Msg: TWMGetText); message WM_GETTEXT;
   procedure WMGetTextLength(var Msg: TWMGetTextLength); message WM_GETTEXTLENGTH;
   procedure WMChar(var Msg: TWMChar); message WM_CHAR;
   procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd); message WM_ERASEBKGND;
   procedure WMGetDlgCode(var Msg: TWMGetDlgCode); message WM_GETDLGCODE;
   procedure WMHScroll(var Msg: TWMScroll); message WM_HSCROLL;
   procedure CNKeyDown(var Msg: TWMKeyDown); message CN_KEYDOWN;
   {$If NOT Defined(DesignTimeLibrary)}
   procedure WMSysKeyDown(var Msg: TWMSysKeyDown); message WM_SYSKEYDOWN;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
   procedure WMLButtonDown(var Msg: TWMLButtonDown); message WM_LBUTTONDOWN;
   procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
   procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
   procedure WMMouseActivate(var Msg: TWMMouseActivate); message WM_MOUSEACTIVATE;
   procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
   procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
   procedure WMSize(var Msg: TWMSize); message WM_SIZE;
   procedure WMVScroll(var Msg: TWMScroll); message WM_VSCROLL;
   procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
   procedure WMUArtfulBehaviour(var Msg: TMessage); message WM_U_ARTFULBEHAVIOUR;
   procedure msgvtUpdateScroll(var Msg: TMessage); message msg_vtUpdateScroll;
   procedure LBGetCaretIndex(var Msg: TMessage); message LB_GETCARETINDEX;
   procedure LBGetCount(var Msg: TMessage); message LB_GETCOUNT;
   procedure LBGetCurSel(var Msg: TMessage); message LB_GETCURSEL;
   procedure LBGetItemHeight(var Msg: TMessage); message LB_GETITEMHEIGHT;
   procedure LBGetItemRect(var Msg: TMessage); message LB_GETITEMRECT;
   procedure LBGetSel(var Msg: TMessage); message LB_GETSEL;
   procedure LBGetTopIndex(var Msg: TMessage); message LB_GETTOPINDEX;
   procedure LBResetContent(var Msg: TMessage); message LB_RESETCONTENT;
   procedure LBSelItemRange(var Msg: TMessage); message LB_SELITEMRANGE;
   procedure LBSetCurSel(var Msg: TMessage); message LB_SETCURSEL;
   procedure LBSetSel(var Msg: TMessage); message LB_SETSEL;
   procedure LBSetTabStops(var Msg: TMessage); message LB_SETTABSTOPS;
   procedure LBSetTopIndex(var Msg: TMessage); message LB_SETTOPINDEX;
   procedure WMWindowPosChanged(var Msg: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
   procedure InvalidateNCArea(var Message: TMessage); message msg_vtInvalidateNCArea;
  protected
   function pm_GetCompleteRowHeight: Integer;
   function pm_GetImagesHeight: Integer;
   function pm_GetImagesWidth: Integer;
   procedure pm_SetSelectArray(aValue: Tl3LogicalArray);
   procedure pm_SetViewOptions(aValue: TvtViewOptions); virtual;
   function pm_GetDrawPoints: Tl3LongintList;
   function pm_GetCaret: TafwCaret;
   procedure pm_SetVJustify(aValue: TvtVJustify);
   procedure pm_SetFooterCaption(const aValue: AnsiString);
   procedure pm_SetFooterVisible(aValue: Boolean);
   procedure pm_SetFooterStyleID(aValue: Tl3StyleId);
   procedure pm_SetFooterActiveStyleID(aValue: Tl3StyleId);
   procedure pm_SetFooterFont(aValue: TFont);
   procedure pm_SetFooterActiveFont(aValue: TFont);
   procedure pm_SetFooterSelected(aValue: Boolean);
   procedure pm_SetInterRowIndent(aValue: Integer);
   procedure pm_SetSearchStr(const aValue: AnsiString);
   procedure pm_SetAutoRowHeight(aValue: Boolean);
   function pm_GetRows: Integer;
   procedure pm_SetIntegralHeight(aValue: Boolean);
   procedure pm_SetCurrent(aValue: LongInt); virtual;
   function pm_GetImages: TCustomImageList; virtual;
   procedure pm_SetImages(aValue: TCustomImageList); virtual;
   procedure pm_SetMultiStrokeItem(aValue: Boolean);
   procedure pm_SetPickedList(aValue: Boolean);
   procedure pm_SetTriplePicked(aValue: Boolean);
   procedure pm_SetMultiSelect(aValue: Boolean);
   function pm_GetSelectedCount: Integer; virtual;
   function pm_GetSelected(Index: LongInt): Boolean; virtual;
   procedure pm_SetSelected(Index: LongInt;
    aValue: Boolean); virtual;
   function pm_GetSelectState(Index: LongInt): Integer;
   procedure pm_SetSelectState(Index: LongInt;
    aValue: Integer);
   function pm_GetInternalSelector: Boolean;
   procedure pm_SetInternalSelector(aValue: Boolean);
   procedure pm_SetTotal(aValue: LongInt); virtual;
   function pm_GetRowHeight: Integer;
   procedure pm_SetRowHeight(aValue: Integer);
   function pm_GetLockDraw: Boolean;
   function pm_GetShowHeader: Boolean;
   procedure pm_SetShowHeader(aValue: Boolean);
   procedure pm_SetTopIndex(aValue: LongInt); virtual;
   procedure pm_SetUseTabStops(aValue: Boolean);
   function pm_GetStrings(Index: LongInt): Il3CString;
   procedure pm_SetUseStyleTable(aValue: Boolean);
   procedure pm_SetStyleId(aValue: Tl3StyleId);
   procedure pm_SetDrawGrid(aValue: Boolean);
   function pm_GetIsHScrollVisible: Boolean;
   function pm_GetIsVScrollVisible: Boolean;
   procedure DoOnActionElement(Index: LongInt); virtual;
   procedure DoOnGetItemImageState(const aItemIndex: LongInt;
    var aEnabled: Boolean); virtual;
   procedure DoVScrollVisibleChanged;
   procedure DoHScrollVisibleChanged;
   function IsCommonScrollVisible(aVert: Boolean = True): Boolean;
    {* определяет наличие вертикальной/горизонтальной полосы прокрутки. }
   function IsNeedScrollBars: Boolean; virtual;
    {* определяет нужены ли в CreateParams стили WS_VSCROLL WS_HSCROLL. }
   function NeedShowHint: Boolean; virtual;
   procedure FreeHintWindow;
   function GetHintWindow: THintWindow;
   procedure ShowHintWindow(const aHint: Il3CString;
    const aPosition: TPoint);
   procedure HintTimerEvent(Sender: TObject);
   function IsHintNeededForAnElement(anIndex: Integer): Boolean; virtual;
   function NotifyIfNewCurrentEmpty: Boolean; virtual;
    {* определяет нужно ли вызывать событие OnCurrentChanged в случае если пришел NewCurrent = -1. }
   procedure UpdateInterRowIndent;
   function TSGetTabStopPos(anIndex: Integer;
    out aPos: Integer): Boolean;
   function DoOnGetItemIndent: Integer; virtual;
    {* функция определяет добавляемое свободное место до иконки элемента.
Если отступ в обработчике будет определен как нулевой, то по
умолчанию отступ делается на ширину иконки, если таковые имеются. }
   function DrawFooter(const aCanvas: Il3Canvas;
    aTop: Integer): Integer;
    {* Возвращает aTop + отрисованную высоту }
   function FooterLeftIndent: Integer;
   procedure DoFooterClick;
   procedure DropFooterSelection;
   procedure DoSetRowHeight(aValue: Integer);
   function ItemOnScreen(OnlyWhole: Boolean): Integer; virtual;
   procedure MakeDrawPoints(aDrawPoints: Tl3LongintList); virtual;
   procedure DropDrawPoints;
   function CalcTopIndex(aMaxVisItem: LongInt): LongInt; virtual;
   function AlignTopIndex: Boolean;
   procedure CheckParam;
   procedure SetCaret;
   procedure CharToItem(Sender: TObject;
    var SrchStr: AnsiString;
    aFromCurrent: Boolean;
    var Index: LongInt);
   procedure vlbClearSelRange(First: LongInt;
    Last: LongInt);
    {* clear the selection for the given range of indexes }
   procedure vlbDragSelection(First: LongInt;
    Last: LongInt;
    aSelectState: Integer);
    {* drag the selection }
   procedure vlbExtendSelection(Index: LongInt);
    {* Shift-LMouseBtn }
   procedure vlbNewActiveItem(Index: LongInt);
    {* set the currently selected item }
   procedure vlbSelectRangePrim(First: LongInt;
    Last: LongInt;
    Select: Boolean);
    {* change the selection for the given range of indexes }
   procedure vlbSetAllItemsPrim(Select: Boolean);
    {* primitive routine thats acts on all items }
   procedure vlbInvertAllItemsPrim;
    {* primitive routine thats invert selection on all items }
   procedure vlbHScrollPrim(aDelta: Integer);
   procedure vlbVScrollPrim(aDelta: Integer); virtual;
   procedure vlbSetSelRange(aFirst: LongInt;
    aLast: LongInt);
    {* set the selection on for the given range of indexes }
   function CanScrollWindow: Boolean; virtual;
   function NeedInitScrollInfoInvlbInitScrollInfo: Boolean; virtual;
   procedure vlbSetTopIndexPrim(Index: LongInt);
   procedure vlbInternalOnSelect(Sender: TObject;
    Index: LongInt;
    var Selected: Integer);
   procedure vlbInternalOnIsSelected(Sender: TObject;
    Index: LongInt;
    var Selected: Integer);
   procedure ResetSelectArray;
   procedure vlbAdjustIntegralHeight;
    {* adjust height of the list box }
   procedure vlbCalcFontFields;
    {* calculate sizes based on font selection }
   procedure vlbColorChanged(aColor: TObject);
    {* a color has changed, refresh display }
   procedure vlbDrawFocusRect(const CN: Il3Canvas;
    Index: LongInt); virtual;
    {* draw the focus rectangle }
   procedure vlbInitScrollInfo;
    {* setup scroll bar range and initial position }
   procedure vlbSetEasyCurrent(aIndex: LongInt);
   procedure vlbSetHScrollPos;
    {* set the horizontal scroll position }
   procedure vlbSetHScrollRange;
    {* set the horizontal scroll range }
   procedure vlbSetVScrollRange;
    {* set the vertical scroll range }
   procedure vlbValidateItem(Index: LongInt);
    {* validate the area for this item }
   procedure vlbSetCurrentPrim(aIndex: LongInt;
    aNeedValidation: Boolean = True);
   procedure vlbProcessingChar(const aMsg: TWMChar); virtual;
    {* processing new pressed char }
   function vlbItemHitTest(aIndex: Integer;
    const aPt: TPoint;
    fromScreen: Boolean = False): Byte; virtual;
   procedure SetCursorForItem(anIndex: Integer); virtual;
   function GetDragAndDropSupported: Boolean; virtual;
   procedure TryDragAndDrop(aNodeIndex: Integer;
    aKey: Integer); virtual;
   function DoOnGetItem(Index: LongInt): Il3CString; virtual;
   function DoOnGetItemPainter(Index: LongInt): Il3NodePainter; virtual;
   function DoOnGetItemImageIndex(aItemIndex: LongInt): Integer; virtual;
   procedure DoOnGetItemImageOverlays(aIndex: Integer;
    var theOverlays: TOverlayIndexArray); virtual;
   function DoOnGetItemPickImage(aItemIndex: LongInt;
    var aImages: TCustomImageList): Integer; virtual;
   function DoOnGetItemIconHint(aItemIndex: LongInt): Il3CString; virtual;
   function DoOnGetItemTextHint(aIndex: Integer): Il3CString; virtual;
   function PickImages: TCustomImageList;
   procedure DoOnGetItemColor(Index: LongInt;
    var FG: TColor;
    var BG: TColor); virtual;
   procedure DoOnGetItemFont(Index: LongInt;
    const aFont: Il3Font;
    anItemPart: TvtListerItemPart); virtual;
   function DoOnGetItemStatus(Index: LongInt): Boolean; virtual;
   function DoOnIsSelected(Index: LongInt): Integer; virtual;
   procedure DoOnSelect(Index: LongInt;
    aValue: Integer); virtual;
   procedure DoOnSelectOutRange(First: LongInt;
    Last: LongInt;
    aSelectState: Integer); virtual;
   procedure DoOnTopIndexChanged(NewTopIndex: LongInt); virtual;
   function DoDoProcessCommand(Cmd: Tl3OperationCode): Boolean; virtual;
   function DoIsCommandProcessed(Cmd: Tl3OperationCode): Boolean; virtual;
   function DoOnUserCommand(Command: Tl3OperationCode): Boolean; virtual;
   procedure DoCurrentChanged(aNewCurrent: LongInt;
    aOldCurrent: LongInt); virtual;
   procedure DoValidateCurrent(var aIndex: LongInt); virtual;
   procedure CallCurrentChanged(aNewCurrent: LongInt;
    aOldCurrent: LongInt); virtual;
   procedure DoCountChanged(aCount: LongInt); virtual;
   procedure RepaintSelected(Smart: Boolean);
   function GetHint(anIndex: Integer): Il3CString; virtual;
   procedure HeaderSizedProc(Sender: TObject;
    ASection: Integer;
    AWidth: Integer);
   procedure ImagesChanged(Sender: TObject);
   function UseDrawPoints: Boolean; virtual;
   function GetTopIndent: Integer;
   function GetItemVShift: Integer;
   procedure vlbSetVScrollPos;
   procedure SetSearchStrPrim(const aValue: AnsiString);
   procedure SetLockChangeSelected(aValue: Boolean);
   procedure InternalSetCurrent(aValue: LongInt);
   procedure InternalSetTopIndex(aValue: LongInt);
   procedure InternalSetTotal(aValue: LongInt);
   function NeedChangeCurrentOnMouseTrack: Boolean; virtual;
   function IsMouseMoved(const aPos: TPoint): Boolean; virtual;
   procedure ResetLastHint;
   procedure InitItemFont(Index: LongInt;
    const aFont: Il3Font;
    anItemPart: TvtListerItemPart);
    {* устанавлиет шрифт по умолчанию и вызывает _DoOnGetItemFont. }
   function FooterFontStored: Boolean;
    {* "Функция определяющая, что свойство FooterFont сохраняется" }
   function FooterActiveFontStored: Boolean;
    {* "Функция определяющая, что свойство FooterActiveFont сохраняется" }
   function HeaderStored: Boolean;
    {* "Функция определяющая, что свойство Header сохраняется" }
   function ImagesStored: Boolean;
    {* "Функция определяющая, что свойство Images сохраняется" }
   {$If NOT Defined(DesignTimeLibrary)}
   procedure StyleTableChanged;
    {* таблица стилей изменилась. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCL)}
   procedure WndProc(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure Loaded; override;
   function GetCommands: TafwCommands; override;
   function DoProcessCommand(Cmd: Tl3OperationCode;
    aForce: Boolean;
    aCount: Integer): Boolean; override;
   procedure DoChanged; override;
   function GetCaret: Il3Caret; override;
   procedure Paint(const CN: Il3Canvas); override;
    {* процедура рисования внешнего вида управляющего элемента }
   function InUpdating: Boolean; override;
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure DoMenuUnlockedFixUp; override;
   {$If NOT Defined(NoVCL)}
   procedure CreateWnd; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetBounds(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure Notification(AComponent: TComponent;
    Operation: TOperation); override;
   procedure ClearFields; override;
  public
   function GetImagesStored: Boolean; virtual;
   function CalcInterRowIndent: Integer; virtual;
   procedure SelectItems(aFinish: Integer); virtual;
    {* Создавалась, как ручка для тестов, но немного обобщает логику выделения }
   procedure BeginUpdate;
   procedure EndUpdate;
   procedure DrawItem(Index: LongInt);
   procedure InvalidateItem(Index: LongInt); virtual;
   function ItemAtPos(const Pos: TPoint;
    Existing: Boolean): LongInt;
   procedure ResetList;
   function GetNextSelectItem(Index: LongInt): LongInt;
   function GetItemTextIndent(Index: LongInt;
    aTextBoxHeight: Integer): Integer; virtual;
   function GetItemHeight(Index: LongInt): Integer;
   function GetItemDim(aItemIndex: Integer): TPoint; virtual;
   function GetFooterDim: TPoint;
   procedure HitTest(const aPt: TPoint;
    var aIndex: Integer;
    var aItemPart: Byte;
    fromScreen: Boolean = False); virtual;
   function GetItemsRangeDim(aBeginIndex: Integer;
    aEndIndex: Integer;
    aMaxHeight: Integer = 0): TPoint;
   function ExcludeRect: TRect; virtual;
   function GetDrawRect(Index: LongInt): TRect; virtual;
    {* Функция для получения координат отрисовки элемента с Index }
   function GetDrawTextRect(Index: LongInt): TRect;
    {* Функция для получения координат отрисовки текста элемента с Index }
   function CalcFullHeight: Integer;
   function CalcFullWidth: Integer;
    {* Функция для ширины самого длинного элемента }
   procedure vlbToggleSelection(Index: LongInt); virtual;
    {* process Ctrl-LMouseBtn }
   procedure vlbSelectAllItems;
    {* select all items in the list box }
   procedure vlbDeselectAllItems;
    {* clear the highlight from all items }
   procedure vlbMakeItemVisiblePrim(Index: LongInt);
    {* make sure the item is visible }
   function MousePointToIndex: LongInt;
    {* Return Item under mouse pointer }
   procedure ItemSourceChanged;
    {* Call It when Source of items is Change }
   procedure DrawLock;
   procedure DrawUnLock;
   procedure FullRedraw;
   function GetDrawString(aIndex: Integer): Il3CString;
    {* получаем строку для рисования }
   procedure LockChangeSelected;
   procedure UnLockChangeSelected;
   procedure LockMakeCurrentVisible;
   procedure UnLockMakeCurrentVisible;
   procedure SetNoCurrent;
    {* Убрать выделение и фокус, установить Current в -1 }
   procedure Changing;
   procedure Changed;
   procedure vlbMakeItemVisible(Index: LongInt);
   constructor Create(AOwner: TComponent); override;
   {$If NOT Defined(NoVCL)}
   procedure MouseWheelHandler(var Message: TMessage); override;
   {$IfEnd} // NOT Defined(NoVCL)
  protected
   property CompleteRowHeight: Integer
    read pm_GetCompleteRowHeight;
    {* высота элемента с учетом межстрочного интервала }
   property ImagesHeight: Integer
    read pm_GetImagesHeight;
   property ImagesWidth: Integer
    read pm_GetImagesWidth;
   property SelectArray: Tl3LogicalArray
    read f_SelectArray
    write pm_SetSelectArray;
   property ViewOptions: TvtViewOptions
    read f_ViewOptions
    write pm_SetViewOptions;
   property DrawPoints: Tl3LongintList
    read pm_GetDrawPoints;
   property AllowWithoutCurrent: Boolean
    read f_AllowWithoutCurrent
    write f_AllowWithoutCurrent;
    {* допустимо отсутствие текущего. }
   property Caret: TafwCaret
    read pm_GetCaret;
   property VJustify: TvtVJustify
    read f_VJustify
    write pm_SetVJustify;
   property FooterCaption: AnsiString
    read f_FooterCaption
    write pm_SetFooterCaption;
   property FooterVisible: Boolean
    read f_FooterVisible
    write pm_SetFooterVisible;
   property FooterStyleID: Tl3StyleId
    read f_FooterStyleID
    write pm_SetFooterStyleID;
   property FooterActiveStyleID: Tl3StyleId
    read f_FooterActiveStyleID
    write pm_SetFooterActiveStyleID;
   property FooterFont: TFont
    read f_FooterFont
    write pm_SetFooterFont
    stored FooterFontStored;
   property FooterActiveFont: TFont
    read f_FooterActiveFont
    write pm_SetFooterActiveFont
    stored FooterActiveFontStored;
   property OnFooterClick: TNotifyEvent
    read f_OnFooterClick
    write f_OnFooterClick;
   property FooterSelected: Boolean
    read f_FooterSelected
    write pm_SetFooterSelected;
  public
   property InterRowIndent: Integer
    read f_InterRowIndent
    write pm_SetInterRowIndent;
    {* промежуток между элементами дерева }
   property OnVScrollVisibleChanged: TNotifyEvent
    read f_OnVScrollVisibleChanged
    write f_OnVScrollVisibleChanged;
    {* изменилась видимость вертикальной полосы прокрутки }
   property OnHScrollVisibleChanged: TNotifyEvent
    read f_OnHScrollVisibleChanged
    write f_OnHScrollVisibleChanged;
    {* изменилась видимость горизонтальной полосы прокрутки }
   property SearchStr: AnsiString
    read f_SearchStr
    write pm_SetSearchStr;
   property AutoRowHeight: Boolean
    read f_AutoRowHeight
    write pm_SetAutoRowHeight;
   property Rows: Integer
    read pm_GetRows;
   property Columns: Byte
    read f_Columns
    write f_Columns;
   property Header: TvtListerHeader
    read f_Header
    stored HeaderStored;
   property IntegralHeight: Boolean
    read f_IntegralHeight
    write pm_SetIntegralHeight;
   property Current: LongInt
    read f_Current
    write pm_SetCurrent;
    {* индекс текущего элемента }
   property Images: TCustomImageList
    read pm_GetImages
    write pm_SetImages
    stored ImagesStored;
    {* список картинок для отображения перед элементами }
   property MultiStrokeItem: Boolean
    read f_MultiStrokeItem
    write pm_SetMultiStrokeItem;
   property PickedList: Boolean
    read f_PickedList
    write pm_SetPickedList;
    {* отображать ли галочки перед элементами }
   property TriplePicked: Boolean
    read f_TriplePicked
    write pm_SetTriplePicked;
    {* отображать ли "третье состояние" галочки перед элементами }
   property ReadOnly: Boolean
    read f_ReadOnly
    write f_ReadOnly;
    {* признак запрещения редактирования }
   property MultiSelect: Boolean
    read f_MultiSelect
    write pm_SetMultiSelect;
   property SelectedCount: Integer
    read pm_GetSelectedCount;
   property Selected[Index: LongInt]: Boolean
    read pm_GetSelected
    write pm_SetSelected;
    {* выделенные элементы }
   property SelectState[Index: LongInt]: Integer
    read pm_GetSelectState
    write pm_SetSelectState;
    {* "состояние" выделенных элементов. если не TriplePicked, то тоже что и Selected }
   property InternalSelector: Boolean
    read pm_GetInternalSelector
    write pm_SetInternalSelector;
   property Options: TvlOptions
    read f_Options
    write f_Options;
   property Total: LongInt
    read f_Total
    write pm_SetTotal;
    {* количество элементов }
   property ProtectColor: TOvcColors
    read f_ProtectColor
    write f_ProtectColor;
   property RowHeight: Integer
    read pm_GetRowHeight
    write pm_SetRowHeight;
   property LockDraw: Boolean
    read pm_GetLockDraw;
   property SelectColor: TOvcColors
    read f_SelectColor
    write f_SelectColor;
   property SelectNonFocusColor: TOvcColors
    read f_SelectNonFocusColor
    write f_SelectNonFocusColor;
   property ShowHeader: Boolean
    read pm_GetShowHeader
    write pm_SetShowHeader;
   property DisableAlignTopIndex: Boolean
    read f_DisableAlignTopIndex
    write f_DisableAlignTopIndex;
   property TopIndex: LongInt
    read f_TopIndex
    write pm_SetTopIndex;
   property UseTabStops: Boolean
    read f_UseTabStops
    write pm_SetUseTabStops;
   property FixAnchor: Boolean
    read f_FixAnchor
    write f_FixAnchor;
   property Strings[Index: LongInt]: Il3CString
    read pm_GetStrings;
   property UseStyleTable: Boolean
    read f_UseStyleTable
    write pm_SetUseStyleTable;
    {* использовать изменение таблицы стилей }
   property StyleId: Tl3StyleId
    read f_StyleId
    write pm_SetStyleId;
    {* идентификатор стиля в таблице стилей }
   property ActionElementMode: Tl3ActionElementMode
    read f_ActionElementMode
    write f_ActionElementMode;
   property DrawGrid: Boolean
    read f_DrawGrid
    write pm_SetDrawGrid;
   property IsHScrollVisible: Boolean
    read pm_GetIsHScrollVisible;
   property IsVScrollVisible: Boolean
    read pm_GetIsVScrollVisible;
   property TreatDefaultColorAsWindowColor: Boolean
    read f_TreatDefaultColorAsWindowColor
    write f_TreatDefaultColorAsWindowColor;
   {$If Defined(Nemesis)}
   property NonTrackScroll: Boolean
    read f_NonTrackScroll
    write f_NonTrackScroll;
   {$IfEnd} // Defined(Nemesis)
   property OnToggleSelection: TvtToggleSelectionEvent
    read f_OnToggleSelection
    write f_OnToggleSelection;
   property OnCharToItem: TCharToItemEvent
    read f_OnCharToItem
    write f_OnCharToItem;
   property OnGetItemPainter: TGetItemPainterEvent
    read f_OnGetItemPainter
    write f_OnGetItemPainter;
    {* событие для получения автономного "рисовальщика" элемента }
   property OnGetStrItem: TGetStrItemEvent
    read f_OnGetStrItem
    write f_OnGetStrItem;
    {* событие для получения строчки элемента }
   property OnGetPCharItem: TGetPCharItemEvent
    read f_OnGetPCharItem
    write f_OnGetPCharItem;
    {* событие для получения строчки элемента (в виде PChar). }
   property OnGetItemImageIndex: TGetItemImageIndex
    read f_OnGetItemImageIndex
    write f_OnGetItemImageIndex;
   property OnGetItemImageOverlays: TOnGetItemImageOverlays
    read f_OnGetItemImageOverlays
    write f_OnGetItemImageOverlays;
   property OnGetItemPickImage: TGetPickItemImage
    read f_OnGetItemPickImage
    write f_OnGetItemPickImage;
    {* событие для получения картинки галки (Pick) для элемента. Если ItemIndex < 0,
то Index картинки считать не надо (используется для получения ImageList) }
   property OnGetItemIconHint: TGetItemHint
    read f_OnGetItemIconHint
    write f_OnGetItemIconHint;
    {* событие для получения hint'a для картинки элемента. }
   property OnGetItemTextHint: TGetItemTextHint
    read f_OnGetItemTextHint
    write f_OnGetItemTextHint;
    {* событи для получения hint-а к тексту элемента. }
   property OnGetItemCursor: TGetItemCursor
    read f_OnGetItemCursor
    write f_OnGetItemCursor;
    {* событие для получения Cursor для элемента. }
   property OnGetItemColor: TGetItemColorEvent
    read f_OnGetItemColor
    write f_OnGetItemColor;
    {* событие для получения цвета элемента. }
   property OnGetItemFont: TGetItemFontEvent
    read f_OnGetItemFont
    write f_OnGetItemFont;
    {* событие для получения шрифта элемента. }
   property OnGetItemImageState: TGetItemImageState
    read f_OnGetItemImageState
    write f_OnGetItemImageState;
   property OnGetItemStatus: TGetItemStatusEvent
    read f_OnGetItemStatus
    write f_OnGetItemStatus;
   property OnIsSelected: TIsSelectedEvent
    read f_OnIsSelected
    write f_OnIsSelected;
   property OnSelect: TSelectEvent
    read f_OnSelect
    write f_OnSelect;
   property OnSelectChange: TSelectEvent
    read f_OnSelectChange
    write f_OnSelectChange;
   property OnSelectChanged: TSelectEvent
    read f_OnSelectChanged
    write f_OnSelectChanged;
   property OnTopIndexChanged: TTopIndexChanged
    read f_OnTopIndexChanged
    write f_OnTopIndexChanged;
    {* нотификация об изменении верхнего видимого элемента. }
   property OnCurrentChanged: TCurrentChanged
    read f_OnCurrentChanged
    write f_OnCurrentChanged;
    {* нотификация об изменении текущего }
   property OnValidateCurrent: TValidateCurrent
    read f_OnValidateCurrent
    write f_OnValidateCurrent;
    {* нотификация на корректировку номера текущего элемента }
   property OnCountChanged: TCountChanged
    read f_OnCountChanged
    write f_OnCountChanged;
   property OnUserCommand: TUserCommandEvent
    read f_OnUserCommand
    write f_OnUserCommand;
   property OnIsCommandProcessed: TCommandProcessedEvent
    read f_OnIsCommandProcessed
    write f_OnIsCommandProcessed;
   property OnActionElement: TActionElement
    read f_OnActionElement
    write f_OnActionElement;
   property OnResize: TNotifyEvent
    read f_OnResize
    write f_OnResize;
   property OnRMouseDown: TMouseEvent
    read f_OnRMouseDown
    write f_OnRMouseDown;
   property OnLMouseDown: TMouseEvent
    read f_OnLMouseDown
    write f_OnLMouseDown;
   property OnQuickSearchStrChanged: TQuickSearchStrChanged
    read f_OnQuickSearchStrChanged
    write f_OnQuickSearchStrChanged;
   property OnGetCellItemImage: TGetCellItemImage
    read f_OnGetCellItemImage
    write f_OnGetCellItemImage;
   property OnNeedRecalcConstraints: TNotifyEvent
    read f_OnNeedRecalcConstraints
    write f_OnNeedRecalcConstraints;
 end;//TvtCustomListerPrim

 //#UC START# *515062D301C4ci*
 //#UC END# *515062D301C4ci*
 //#UC START# *515062D301C4cit*
 //#UC END# *515062D301C4cit*
 TvtCustomLister = class(TvtCustomListerPrim)
  protected
   function FontStore: Boolean;
 //#UC START# *515062D301C4publ*
 public
   property Font stored FontStore;
   property Color stored FontStore;
   property Align;
   property Controller;
   property Ctl3D;
   property DragCursor;
   property DragMode;
   property Enabled;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property PopupMenu;
   property ShowHint;
   property TabOrder;
   property TabStop;
   property Visible;
   property Anchors;
   property Constraints;

   {inherited events}
   property OnClick;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnEndDrag;
   property OnEnter;
   property OnExit;
   property OnKeyDown;
   property OnKeyPress;
   property OnKeyUp;
   property OnMouseDown;
   property OnMouseMove;
   property OnMouseUp;
 //#UC END# *515062D301C4publ*
 end;//TvtCustomLister

 TvtCustomDataListerPrim = class(TvtCustomLister)
  {* Видимый элемент для отображения списка строк из Tl3DataList }
  private
   f_Items: Tl3CustomDataList;
  private
   procedure DStrOnIsSelected(Sender: TObject;
    Index: LongInt;
    var Selected: Integer);
   procedure DStrOnSelect(Sender: TObject;
    Index: LongInt;
    var Selected: Integer);
  protected
   function pm_GetItems: Tl3CustomDataList;
   procedure pm_SetItems(aValue: Tl3CustomDataList);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoChanged; override;
   function pm_GetSelectedCount: Integer; override;
  public
   constructor Create(AOwner: TComponent); override;
  public
   property Items: Tl3CustomDataList
    read pm_GetItems
    write pm_SetItems;
 end;//TvtCustomDataListerPrim

 //#UC START# *515414CF022Cci*
 //#UC END# *515414CF022Cci*
 //#UC START# *515414CF022Ccit*
 //#UC END# *515414CF022Ccit*
 TvtCustomDataLister = class(TvtCustomDataListerPrim)
 //#UC START# *515414CF022Cpubl*
  published
   property Items;
 //#UC END# *515414CF022Cpubl*
 end;//TvtCustomDataLister

 TvtCustomIStrListListerPrim = class(TvtCustomLister)
  private
   f_Items: Il3ViewStringList;
  protected
   procedure pm_SetItems(const aValue: Il3ViewStringList);
   function GetItems: Il3ViewStringList;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoChanged; override;
   function DoOnGetItem(Index: LongInt): Il3CString; override;
   procedure ClearFields; override;
  public
   property Items: Il3ViewStringList
    read f_Items
    write pm_SetItems;
 end;//TvtCustomIStrListListerPrim

 //#UC START# *515405400086ci*
 //#UC END# *515405400086ci*
 //#UC START# *515405400086cit*
 //#UC END# *515405400086cit*
 TvtCustomIStrListLister = class(TvtCustomIStrListListerPrim)
 //#UC START# *515405400086publ*
  published
   property Items;
 //#UC END# *515405400086publ*
 end;//TvtCustomIStrListLister

 TvtCustomDStringLister = class(TvtCustomDataLister)
  {* Видимый элемент для отображения списка строк из Tl3StringDataList }
  private
   procedure CharToItem(Sender: TObject;
    var SrchStr: AnsiString;
    aFromCurrent: Boolean;
    var Index: LongInt);
  protected
   function pm_GetItems: Tl3StringDataList;
   procedure pm_SetItems(aValue: Tl3StringDataList);
   function pm_GetSorted: Boolean;
   procedure pm_SetSorted(aValue: Boolean);
   function DoOnGetItem(Index: LongInt): Il3CString; override;
  public
   property Items: Tl3StringDataList
    read pm_GetItems
    write pm_SetItems;
   property Sorted: Boolean
    read pm_GetSorted
    write pm_SetSorted;
 end;//TvtCustomDStringLister

 //#UC START# *515405590022ci*
 //#UC END# *515405590022ci*
 //#UC START# *515405590022cit*
 //#UC END# *515405590022cit*
 TvtIStrListLister = class(TvtCustomIStrListLister)
  {* Видимый элемент для отображения списка строк из Il3ViewStringList }
 //#UC START# *515405590022publ*
  published
   property Images;
   property AutoRowHeight;
   property BorderStyle;
   property Columns;
   property Header;
   property IntegralHeight;
   property MultiSelect;
   property ProtectColor;
   property RowHeight;
   property ScrollStyle;
   property SelectColor;
   property SelectNonFocusColor;
   property ShowHeader;
   property UseTabStops;
   property PickedList;
   property MultiStrokeItem;
   property ReadOnly;
   property ViewOptions;

 //      property OnClickHeader;
   property OnGetItemImageIndex;
   property OnGetItemColor;
   property OnGetItemFont;
   property OnGetItemCursor;
   property OnGetItemStatus;
   property OnIsSelected;
   property OnSelect;
   property OnSelectChange;
   property OnSelectChanged;
   property OnTopIndexChanged;
   property OnCurrentChanged;
   property OnUserCommand;
   property OnIsCommandProcessed;

   {inherited properties}
   property Align;
   property Color;
   property Controller;
   property Ctl3D;
   property DragCursor;
   property DragMode;
   property Enabled;
   property Font;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property PopupMenu;
   property ShowHint;
   property TabOrder;
   property TabStop;
   property Visible;
   property Anchors;
   property Constraints;

   {inherited events}
   property OnClick;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnEndDrag;
   property OnEnter;
   property OnExit;
   property OnKeyDown;
   property OnKeyPress;
   property OnKeyUp;
   property OnMouseDown;
   property OnMouseMove;
   property OnMouseUp;
   property OnActionElement;
 //#UC END# *515405590022publ*
 end;//TvtIStrListLister

 //#UC START# *51541B4700C9ci*
 //#UC END# *51541B4700C9ci*
 //#UC START# *51541B4700C9cit*
 //#UC END# *51541B4700C9cit*
 TvtDStringLister = class(TvtCustomDStringLister)
 //#UC START# *51541B4700C9publ*
  published
   property Items;
   property Sorted;
   property Images;
   property AutoRowHeight;
   property BorderStyle;
   property Columns;
   property Header;
   property IntegralHeight;
   property MultiSelect;
   property ProtectColor;
   property RowHeight;
   property ScrollStyle;
   property SelectColor;
   property SelectNonFocusColor;
   property ShowHeader;
   property UseTabStops;
   property PickedList;
   property MultiStrokeItem;
   property ReadOnly;
   property ViewOptions;

//      property OnClickHeader;
   property OnGetItemImageIndex;
   property OnGetItemColor;
   property OnGetItemFont;
   property OnGetItemCursor;
   property OnGetItemStatus;
   property OnIsSelected;
   property OnSelect;
   property OnSelectChange;
   property OnSelectChanged;
   property OnTopIndexChanged;
   property OnCurrentChanged;
   property OnUserCommand;
   property OnIsCommandProcessed;

   {inherited properties}
   property Align;
   property Color;
   property Controller;
   property Ctl3D;
   property DragCursor;
   property DragMode;
   property Enabled;
   property Font;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property PopupMenu;
   property ShowHint;
   property TabOrder;
   property TabStop;
   property Visible;
   property Anchors;
   property Constraints;

   {inherited events}
   property OnClick;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnEndDrag;
   property OnEnter;
   property OnExit;
   property OnKeyDown;
   property OnKeyPress;
   property OnKeyUp;
   property OnMouseDown;
   property OnMouseMove;
   property OnMouseUp;
   property OnActionElement;
 //#UC END# *51541B4700C9publ*
 end;//TvtDStringLister

 //#UC START# *515404E40394ci*
 //#UC END# *515404E40394ci*
 //#UC START# *515404E40394cit*
 //#UC END# *515404E40394cit*
 TvtDataLister = class(TvtCustomDataLister)
 //#UC START# *515404E40394publ*
   published
    property Images;
    property AutoRowHeight;
    property BorderStyle;
    property Columns;
    property Header;
    property IntegralHeight;
    property MultiSelect;
    property ProtectColor;
    property RowHeight;
    property ScrollStyle;
    property SelectColor;
    property SelectNonFocusColor;
    property ShowHeader;
    property UseTabStops;
    property PickedList;
    property MultiStrokeItem;
    property ReadOnly;
    property ViewOptions;

//      property OnClickHeader;
    property OnGetStrItem;
    property OnGetItemImageIndex;
    property OnGetItemColor;
    property OnGetItemFont;
    property OnGetItemCursor;
    property OnGetItemStatus;
    property OnIsSelected;
    property OnSelect;
    property OnSelectChange;
    property OnSelectChanged;
    property OnTopIndexChanged;
    property OnCurrentChanged;
    property OnUserCommand;
    property OnIsCommandProcessed;

    {inherited properties}
    property Align;
    property Color;
    property Controller;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Anchors;
    property Constraints;

    {inherited events}
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnActionElement;
 //#UC END# *515404E40394publ*
 end;//TvtDataLister

 //#UC START# *4CFFE3470249ci*
 //#UC END# *4CFFE3470249ci*
 //#UC START# *4CFFE3470249cit*
 //#UC END# *4CFFE3470249cit*
 TvtLister = class(TvtCustomLister)
  {* Видимый элемент для отображения виртуального списка строк. Для конечного использования. }
 //#UC START# *4CFFE3470249publ*
  published
   property Images;
   property AutoRowHeight;
   property BorderStyle;
   property Columns;
   property Header;
   property IntegralHeight;
   property MultiSelect;
   property InternalSelector;
   property ProtectColor;
   property RowHeight;
   property ScrollStyle;
   property SelectColor;
   property SelectNonFocusColor;
   property ShowHeader;
   property UseTabStops;
   property PickedList;
   property TriplePicked;
   property MultiStrokeItem;
   property ReadOnly;
   property ViewOptions;
   property ActionElementMode;

   property OnCharToItem;
   property OnGetStrItem;
   property OnGetPCharItem;
   property OnGetItemImageIndex; 
   property OnGetItemImageOverlays;
   property OnGetItemColor;
   property OnGetItemFont;
   property OnGetItemCursor;
   property OnGetItemStatus;
   property OnIsSelected;
   property OnSelect;
   property OnSelectChange;
   property OnSelectChanged;
   property OnTopIndexChanged;
   property OnCurrentChanged;
   property OnCountChanged;
   property OnUserCommand;
   property OnIsCommandProcessed;

   {inherited properties}
   property Align;
   property Color;
   property Controller;
   property Ctl3D;
   property DragCursor;
   property DragMode;
   property Enabled;
   property Font;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property PopupMenu;
   property ShowHint;
   property TabOrder;
   property TabStop;
   property Visible;
   property Anchors;
   property Constraints;

   {inherited events}
   property OnClick;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnEndDrag;
   property OnEnter;
   property OnExit;
   property OnKeyDown;
   property OnKeyPress;
   property OnKeyUp;
   property OnMouseDown;
   property OnMouseMove;
   property OnMouseUp;
   property OnActionElement;
   property OnResize;
 //#UC END# *4CFFE3470249publ*
 end;//TvtLister

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
 , l3Base
 , l3ScreenIC
 , l3Canvas
 , l3FontTools
 , l3String
 , l3MinMax
 , l3Units
 , OvcConst
 , OvcData
 , OvcExcpt
 , vtStdRes
 , l3TabStops
 , l3Types
 , afwFacade
 , l3Chars
 , vtMultilineHint
 , afwFont
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , evdTextStyle_Const
 , evStyleTableTools
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ListerWordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
 //#UC START# *4CFFE3470249impl_uses*
 //#UC END# *4CFFE3470249impl_uses*
;

const
 gHintTimerTickInterval = 250;
 cXOffsetTextHint = 20;
  {* смещение для окна hint-а OnGetItemTextHint по оси X }
 cFocusRectBounds = 2;

//#UC START# *514B3E890126impl*
//#UC END# *514B3E890126impl*

function TvtCustomListerPrim.pm_GetCompleteRowHeight: Integer;
//#UC START# *514C606D0333_4CFFE36B00FAget_var*
//#UC END# *514C606D0333_4CFFE36B00FAget_var*
begin
//#UC START# *514C606D0333_4CFFE36B00FAget_impl*
 Result := RowHeight + InterRowIndent;
//#UC END# *514C606D0333_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetCompleteRowHeight

function TvtCustomListerPrim.pm_GetImagesHeight: Integer;
//#UC START# *514C60D50351_4CFFE36B00FAget_var*
//#UC END# *514C60D50351_4CFFE36B00FAget_var*
begin
//#UC START# *514C60D50351_4CFFE36B00FAget_impl*
 if Assigned(Images) then
  Result := Images.Height
 else
  Result := 0;
//#UC END# *514C60D50351_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetImagesHeight

function TvtCustomListerPrim.pm_GetImagesWidth: Integer;
//#UC START# *514C61C3012C_4CFFE36B00FAget_var*
//#UC END# *514C61C3012C_4CFFE36B00FAget_var*
begin
//#UC START# *514C61C3012C_4CFFE36B00FAget_impl*
 Result := 0;
 if Assigned(Images) then
  Result := Images.Width;
//#UC END# *514C61C3012C_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetImagesWidth

procedure TvtCustomListerPrim.pm_SetSelectArray(aValue: Tl3LogicalArray);
//#UC START# *514C647300D8_4CFFE36B00FAset_var*
//#UC END# *514C647300D8_4CFFE36B00FAset_var*
begin
//#UC START# *514C647300D8_4CFFE36B00FAset_impl*
 if InternalSelector then
  l3Set(f_SelectArray, aValue);
//#UC END# *514C647300D8_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetSelectArray

procedure TvtCustomListerPrim.pm_SetViewOptions(aValue: TvtViewOptions);
//#UC START# *514C657E03E6_4CFFE36B00FAset_var*
//#UC END# *514C657E03E6_4CFFE36B00FAset_var*
begin
//#UC START# *514C657E03E6_4CFFE36B00FAset_impl*
 GetCursorPos(f_OldMousePos); // http://mdp.garant.ru/pages/viewpage.action?pageId=324567330
 if (voShowInterRowSpace in ViewOptions) <> (voShowInterRowSpace in aValue) then
  if voShowInterRowSpace in aValue
   then InterRowIndent := CalcInterRowIndent
   else InterRowIndent := 0;
 f_ViewOptions := aValue;
 Invalidate;
//#UC END# *514C657E03E6_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetViewOptions

function TvtCustomListerPrim.pm_GetDrawPoints: Tl3LongintList;
//#UC START# *514C65C10366_4CFFE36B00FAget_var*
//#UC END# *514C65C10366_4CFFE36B00FAget_var*
begin
//#UC START# *514C65C10366_4CFFE36B00FAget_impl*
 if not UseDrawPoints then
  Result := nil
 else
 begin
  if f_DrawPoints = nil then
   f_DrawPoints := Tl3LongintList.Create;
  if f_DrawPoints.Count = 0 then
   MakeDrawPoints(f_DrawPoints);
  Result := f_DrawPoints;
 end;//if not UseDrawPoints then
//#UC END# *514C65C10366_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetDrawPoints

function TvtCustomListerPrim.pm_GetCaret: TafwCaret;
//#UC START# *514C6DC902FB_4CFFE36B00FAget_var*
//#UC END# *514C6DC902FB_4CFFE36B00FAget_var*
begin
//#UC START# *514C6DC902FB_4CFFE36B00FAget_impl*
 MakeSureCaretIsCreated;
 Result := f_Caret;
//#UC END# *514C6DC902FB_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetCaret

procedure TvtCustomListerPrim.pm_SetVJustify(aValue: TvtVJustify);
//#UC START# *514C6FD80315_4CFFE36B00FAset_var*
//#UC END# *514C6FD80315_4CFFE36B00FAset_var*
begin
//#UC START# *514C6FD80315_4CFFE36B00FAset_impl*
 if (f_VJustify <> aValue) then
 begin
  f_VJustify := aValue;
  Invalidate;
 end;//f_VJustify <> aValue
//#UC END# *514C6FD80315_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetVJustify

procedure TvtCustomListerPrim.pm_SetFooterCaption(const aValue: AnsiString);
//#UC START# *514C702B00F8_4CFFE36B00FAset_var*
//#UC END# *514C702B00F8_4CFFE36B00FAset_var*
begin
//#UC START# *514C702B00F8_4CFFE36B00FAset_impl*
 if f_FooterCaption <> aValue then
 begin
  f_FooterCaption := aValue;
  Invalidate;
 end;
//#UC END# *514C702B00F8_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetFooterCaption

procedure TvtCustomListerPrim.pm_SetFooterVisible(aValue: Boolean);
//#UC START# *514C7081005F_4CFFE36B00FAset_var*
//#UC END# *514C7081005F_4CFFE36B00FAset_var*
begin
//#UC START# *514C7081005F_4CFFE36B00FAset_impl*
 if f_FooterVisible <> aValue then
 begin
  f_FooterVisible := aValue;
  if not aValue then
   DropFooterSelection;
  Invalidate;
 end;
//#UC END# *514C7081005F_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetFooterVisible

procedure TvtCustomListerPrim.pm_SetFooterStyleID(aValue: Tl3StyleId);
//#UC START# *514C71530188_4CFFE36B00FAset_var*
//#UC END# *514C71530188_4CFFE36B00FAset_var*
begin
//#UC START# *514C71530188_4CFFE36B00FAset_impl*
 if f_FooterStyleID <> aValue then
 begin
  f_FooterStyleID := aValue;
  {$IfNDef DesignTimeLibrary}
  StyleTableChanged;
  {$EndIf DesignTimeLibrary}
 end;//if f_FooterStyleID <> aValue then
//#UC END# *514C71530188_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetFooterStyleID

procedure TvtCustomListerPrim.pm_SetFooterActiveStyleID(aValue: Tl3StyleId);
//#UC START# *514C71890159_4CFFE36B00FAset_var*
//#UC END# *514C71890159_4CFFE36B00FAset_var*
begin
//#UC START# *514C71890159_4CFFE36B00FAset_impl*
 if f_FooterActiveStyleID <> aValue then
 begin
  f_FooterActiveStyleID := aValue;
  {$IfNDef DesignTimeLibrary}
  StyleTableChanged;
  {$EndIf DesignTimeLibrary}
 end;//if f_FooterActiveStyleID <> aValue then
//#UC END# *514C71890159_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetFooterActiveStyleID

procedure TvtCustomListerPrim.pm_SetFooterFont(aValue: TFont);
//#UC START# *514C71DE02AD_4CFFE36B00FAset_var*
//#UC END# *514C71DE02AD_4CFFE36B00FAset_var*
begin
//#UC START# *514C71DE02AD_4CFFE36B00FAset_impl*
 if not UseStyleTable then
 begin
  FooterFont.Assign(aValue);
  f_FontChanged := True;// - такой вызов приводит к рекурсивному вызову SetDrawPointsArray
  DropDrawPoints;
  Invalidate;
 end;
//#UC END# *514C71DE02AD_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetFooterFont

procedure TvtCustomListerPrim.pm_SetFooterActiveFont(aValue: TFont);
//#UC START# *514C72070397_4CFFE36B00FAset_var*
//#UC END# *514C72070397_4CFFE36B00FAset_var*
begin
//#UC START# *514C72070397_4CFFE36B00FAset_impl*
 if not UseStyleTable then
 begin
  FooterActiveFont.Assign(aValue);
  f_FontChanged := True;// - такой вызов приводит к рекурсивному вызову SetDrawPointsArray
  DropDrawPoints;
  Invalidate;
 end;
//#UC END# *514C72070397_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetFooterActiveFont

procedure TvtCustomListerPrim.pm_SetFooterSelected(aValue: Boolean);
//#UC START# *514C729A034F_4CFFE36B00FAset_var*
//#UC END# *514C729A034F_4CFFE36B00FAset_var*
begin
//#UC START# *514C729A034F_4CFFE36B00FAset_impl*
 if not FooterVisible and aValue then
  Exit;
 if f_FooterSelected <> aValue then
 begin
  f_FooterSelected := aValue;
  Invalidate;
 end;
//#UC END# *514C729A034F_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetFooterSelected

procedure TvtCustomListerPrim.pm_SetInterRowIndent(aValue: Integer);
//#UC START# *514C7B2F008A_4CFFE36B00FAset_var*
//#UC END# *514C7B2F008A_4CFFE36B00FAset_var*
begin
//#UC START# *514C7B2F008A_4CFFE36B00FAset_impl*
 if aValue <> f_InterRowIndent then
 begin
  f_InterRowIndent := aValue;
  if (f_InterRowIndent > 0) and (f_InterRowIndent mod 2 = 1) then
   f_InterRowIndent := f_InterRowIndent + 1;
 end;//if aValue <> f_InterRowIndent then
//#UC END# *514C7B2F008A_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetInterRowIndent

procedure TvtCustomListerPrim.pm_SetSearchStr(const aValue: AnsiString);
//#UC START# *514C7C5202C2_4CFFE36B00FAset_var*
//#UC END# *514C7C5202C2_4CFFE36B00FAset_var*
begin
//#UC START# *514C7C5202C2_4CFFE36B00FAset_impl*
 if f_SearchStr = aValue then
  Exit;
 SetSearchStrPrim(aValue);
 if Assigned(f_OnQuickSearchStrChanged) then
  f_OnQuickSearchStrChanged(Self, aValue);
//#UC END# *514C7C5202C2_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetSearchStr

procedure TvtCustomListerPrim.pm_SetAutoRowHeight(aValue: Boolean);
//#UC START# *514C7C770338_4CFFE36B00FAset_var*
//#UC END# *514C7C770338_4CFFE36B00FAset_var*
begin
//#UC START# *514C7C770338_4CFFE36B00FAset_impl*
 if aValue <> f_AutoRowHeight then
 begin
  f_AutoRowHeight := aValue;
  if f_AutoRowHeight then
  begin
   vlbInitScrollInfo;
   pm_SetRowHeight(0);
    // - это чтобы высота ячейки пересчиталась;
   Refresh;
  end;//if f_AutoRowHeight then
 end;//if aValue <> f_AutoRowHeight then
//#UC END# *514C7C770338_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetAutoRowHeight

function TvtCustomListerPrim.pm_GetRows: Integer;
//#UC START# *514C7C9B0066_4CFFE36B00FAget_var*
//#UC END# *514C7C9B0066_4CFFE36B00FAget_var*
begin
//#UC START# *514C7C9B0066_4CFFE36B00FAget_impl*
 Result := ItemOnScreen(False);
//#UC END# *514C7C9B0066_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetRows

procedure TvtCustomListerPrim.pm_SetIntegralHeight(aValue: Boolean);
//#UC START# *514C7D770082_4CFFE36B00FAset_var*
//#UC END# *514C7D770082_4CFFE36B00FAset_var*
begin
//#UC START# *514C7D770082_4CFFE36B00FAset_impl*
 if (aValue <> f_IntegralHeight) and (Align in [alNone, alTop, alBottom]) then
 begin
  f_IntegralHeight := aValue;
  if f_IntegralHeight then
  begin
   {vlbCalcFontFields;}
   {vlbAdjustIntegralHeight;
   vlbCalcFontFields;}
   vlbInitScrollInfo;
  end;
 end;
//#UC END# *514C7D770082_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetIntegralHeight

procedure TvtCustomListerPrim.pm_SetCurrent(aValue: LongInt);
//#UC START# *514C7EB20050_4CFFE36B00FAset_var*
var
 l_IsCurrentChanged: Boolean;
//#UC END# *514C7EB20050_4CFFE36B00FAset_var*
begin
//#UC START# *514C7EB20050_4CFFE36B00FAset_impl*
 l_IsCurrentChanged := aValue <> f_Current;
 if (not PickedList) and
    (f_Current >= 0) and
    l_IsCurrentChanged then
  vlbDeselectAllItems;  // Здесь нельзя снимать выделение с одного элемента,
                        // т.к. это может привести к прогрузке всего дерева

 vlbSetCurrentPrim(aValue);
 if l_IsCurrentChanged and not f_LockMakeCurrentVisible then
  vlbMakeItemVisible(f_Current);
//#UC END# *514C7EB20050_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetCurrent

function TvtCustomListerPrim.pm_GetImages: TCustomImageList;
//#UC START# *514C7F9103BB_4CFFE36B00FAget_var*
//#UC END# *514C7F9103BB_4CFFE36B00FAget_var*
begin
//#UC START# *514C7F9103BB_4CFFE36B00FAget_impl*
 Result := f_Images;
//#UC END# *514C7F9103BB_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetImages

procedure TvtCustomListerPrim.pm_SetImages(aValue: TCustomImageList);
//#UC START# *514C7F9103BB_4CFFE36B00FAset_var*
//#UC END# *514C7F9103BB_4CFFE36B00FAset_var*
begin
//#UC START# *514C7F9103BB_4CFFE36B00FAset_impl*
 if (f_Images <> aValue) then
 begin
  if (f_ImagesChangeLink <> nil) AND (f_ImagesChangeLink.Sender = nil) then
   // - список картинок уже убит - надо его зачистить
   f_Images := nil;
  if (f_Images <> nil) then
   f_Images.UnRegisterChanges(f_ImagesChangeLink);
  f_Images := aValue;
  if (f_Images <> nil) then
  begin
   if (f_ImagesChangeLink = nil) then
   begin
    f_ImagesChangeLink := TChangeLink.Create;
    f_ImagesChangeLink.OnChange := ImagesChanged;
   end;//f_ImagesChangeLink = nil
   f_Images.RegisterChanges(f_ImagesChangeLink);
  end//f_Images <> nil
  else
   l3Free(f_ImagesChangeLink);
  ImagesChanged(nil);
 end;//f_Images <> aValue
//#UC END# *514C7F9103BB_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetImages

procedure TvtCustomListerPrim.pm_SetMultiStrokeItem(aValue: Boolean);
//#UC START# *514C7FD802E5_4CFFE36B00FAset_var*
//#UC END# *514C7FD802E5_4CFFE36B00FAset_var*
begin
//#UC START# *514C7FD802E5_4CFFE36B00FAset_impl*
 if aValue <> f_MultiStrokeItem then
 begin
  f_MultiStrokeItem := aValue;
  //http://mdp.garant.ru/pages/viewpage.action?pageId=505415962 
  if HandleAllocated then
  begin
   DropDrawPoints;
   DrawPoints;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=494505726
   DoNeedRecalcConstraints;
   vlbInitScrollInfo;
   Refresh;
  end;
 end;
//#UC END# *514C7FD802E5_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetMultiStrokeItem

procedure TvtCustomListerPrim.pm_SetPickedList(aValue: Boolean);
//#UC START# *514C80A90030_4CFFE36B00FAset_var*
//#UC END# *514C80A90030_4CFFE36B00FAset_var*
begin
//#UC START# *514C80A90030_4CFFE36B00FAset_impl*
 if f_PickedList <> aValue then
 begin
  f_PickedList := aValue;
  Refresh;
 end;
//#UC END# *514C80A90030_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetPickedList

procedure TvtCustomListerPrim.pm_SetTriplePicked(aValue: Boolean);
//#UC START# *514C812F007E_4CFFE36B00FAset_var*
//#UC END# *514C812F007E_4CFFE36B00FAset_var*
begin
//#UC START# *514C812F007E_4CFFE36B00FAset_impl*
 if f_TriplePicked <> aValue then
 begin
  f_TriplePicked := aValue;
  if f_TriplePicked then
   PickedList := True;
  Refresh;
 end;
//#UC END# *514C812F007E_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetTriplePicked

procedure TvtCustomListerPrim.pm_SetMultiSelect(aValue: Boolean);
//#UC START# *514C81EA0358_4CFFE36B00FAset_var*
//#UC END# *514C81EA0358_4CFFE36B00FAset_var*
begin
//#UC START# *514C81EA0358_4CFFE36B00FAset_impl*
 if aValue <> f_MultiSelect then
 begin
  f_MultiSelect := aValue;
  Refresh;
 end;
//#UC END# *514C81EA0358_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetMultiSelect

function TvtCustomListerPrim.pm_GetSelectedCount: Integer;
//#UC START# *514C82280017_4CFFE36B00FAget_var*
//#UC END# *514C82280017_4CFFE36B00FAget_var*
begin
//#UC START# *514C82280017_4CFFE36B00FAget_impl*
 Result := 0;
 if Assigned(f_SelectArray)
  then Result := f_SelectArray.SettedCount
  else Abort {not Realised Extended Selector};
//#UC END# *514C82280017_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetSelectedCount

function TvtCustomListerPrim.pm_GetSelected(Index: LongInt): Boolean;
//#UC START# *514C828F0157_4CFFE36B00FAget_var*
//#UC END# *514C828F0157_4CFFE36B00FAget_var*
begin
//#UC START# *514C828F0157_4CFFE36B00FAget_impl*
 Result := Boolean(DoOnIsSelected(Index));
//#UC END# *514C828F0157_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetSelected

procedure TvtCustomListerPrim.pm_SetSelected(Index: LongInt;
 aValue: Boolean);
//#UC START# *514C828F0157_4CFFE36B00FAset_var*
//#UC END# *514C828F0157_4CFFE36B00FAset_var*
begin
//#UC START# *514C828F0157_4CFFE36B00FAset_impl*
 DoOnSelect(Index, Integer(aValue));
//#UC END# *514C828F0157_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetSelected

function TvtCustomListerPrim.pm_GetSelectState(Index: LongInt): Integer;
//#UC START# *514C87D30396_4CFFE36B00FAget_var*
//#UC END# *514C87D30396_4CFFE36B00FAget_var*
begin
//#UC START# *514C87D30396_4CFFE36B00FAget_impl*
 Result := DoOnIsSelected(Index);
//#UC END# *514C87D30396_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetSelectState

procedure TvtCustomListerPrim.pm_SetSelectState(Index: LongInt;
 aValue: Integer);
//#UC START# *514C87D30396_4CFFE36B00FAset_var*
//#UC END# *514C87D30396_4CFFE36B00FAset_var*
begin
//#UC START# *514C87D30396_4CFFE36B00FAset_impl*
 DoOnSelect(Index, aValue);
//#UC END# *514C87D30396_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetSelectState

function TvtCustomListerPrim.pm_GetInternalSelector: Boolean;
//#UC START# *514C884901B4_4CFFE36B00FAget_var*
//#UC END# *514C884901B4_4CFFE36B00FAget_var*
begin
//#UC START# *514C884901B4_4CFFE36B00FAget_impl*
 Result := (@f_OnSelect = @TvtCustomListerPrim.vlbInternalOnSelect) and
           (@f_OnIsSelected = @TvtCustomListerPrim.vlbInternalOnIsSelected);
//#UC END# *514C884901B4_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetInternalSelector

procedure TvtCustomListerPrim.pm_SetInternalSelector(aValue: Boolean);
//#UC START# *514C884901B4_4CFFE36B00FAset_var*
//#UC END# *514C884901B4_4CFFE36B00FAset_var*
begin
//#UC START# *514C884901B4_4CFFE36B00FAset_impl*
 if aValue <> InternalSelector then
  if aValue then
  begin
   if not Assigned(f_SelectArray) then
    f_SelectArray := Tl3LogicalArray.Create;
   f_OnSelect := vlbInternalOnSelect;
   f_OnIsSelected := vlbInternalOnIsSelected;
  end else
  begin
   l3Free(f_SelectArray);
   f_OnSelect := nil;
   f_OnIsSelected := nil;
  end;
  Refresh;
//#UC END# *514C884901B4_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetInternalSelector

procedure TvtCustomListerPrim.pm_SetTotal(aValue: LongInt);
//#UC START# *514C89A601FE_4CFFE36B00FAset_var*
var
 NewCurrent : LongInt;
//#UC END# *514C89A601FE_4CFFE36B00FAset_var*
begin
//#UC START# *514C89A601FE_4CFFE36B00FAset_impl*
 if aValue <> f_Total then
 begin
  if aValue < 0 then
    aValue := High(aValue);

  {set new item index}
  {SelectFirst := f_Total = 0;}
  f_Total := aValue;
  if csDestroying in ComponentState then
   Exit;
  if f_Total = 0 then SearchStr := '';
  ResetSelectArray;
  {reset high index}
  if f_Total = 0
   then f_HighIndex := 0
   else f_HighIndex := Pred(f_Total);
  {reset horizontal offset}
  f_HDelta := 0;

  {reset selected item}
  if not ({f_LockSelectChange or} (csLoading in ComponentState) or (csDestroying in ComponentState)) then
  begin
   {AlignTopIndex;}
   {if f_TopIndex > f_HighIndex - f_Rows + 1 then TopIndex := f_HighIndex - f_Rows + 1;}
   NewCurrent := f_Current;
   if NewCurrent < 0 then
    NewCurrent := 0;
   if NewCurrent >= f_Total then
    NewCurrent := Pred(f_Total);
   f_Current := -1;
   vlbSetCurrentPrim(NewCurrent);

   if not FixAnchor then f_Anchor := f_Current;

   DoCountChanged(f_Total);

   if AlignTopIndex then DropDrawPoints;
  end;

  Invalidate;
  {Repaint;}

  vlbInitScrollInfo;
 end;
//#UC END# *514C89A601FE_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetTotal

function TvtCustomListerPrim.pm_GetRowHeight: Integer;
//#UC START# *514C8B9F030D_4CFFE36B00FAget_var*
//#UC END# *514C8B9F030D_4CFFE36B00FAget_var*
begin
//#UC START# *514C8B9F030D_4CFFE36B00FAget_impl*
 try
  (*if lFontChanged {and HandleAllocated} then*)
  if (f_RowHeight = 0) or f_FontChanged then
   vlbCalcFontFields;
  Result := f_RowHeight;
 except
  Result := DefRowHeight;
 end;//try..except
//#UC END# *514C8B9F030D_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetRowHeight

procedure TvtCustomListerPrim.pm_SetRowHeight(aValue: Integer);
//#UC START# *514C8B9F030D_4CFFE36B00FAset_var*
var
 l_MinRowHeight : Integer;
//#UC END# *514C8B9F030D_4CFFE36B00FAset_var*
begin
//#UC START# *514C8B9F030D_4CFFE36B00FAset_impl*
 l_MinRowHeight := 0;

 // если эту функцию вызвали просто для пересчета, то AutoRowHeight
 // сбрасывать не нужно

 if Images <> nil then l_MinRowHeight := Images.Height;
 if PickedList then l_MinRowHeight := Max(l_MinRowHeight, PickImages.Height);
 if f_FontHeight = 0 then
  vlbCalcFontFields;
 l_MinRowHeight := Max(l_MinRowHeight, f_FontHeight);

 if l_MinRowHeight = 0 then l_MinRowHeight := 30;//DefRowHeight;

 if (aValue < l_MinRowHeight)
    {or ((aValue > l_MinRowHeight) and f_AutoRowHeight)} then
  aValue := l_MinRowHeight;

 if aValue <> f_RowHeight then
 begin
  f_RowHeight := aValue;
  if voShowInterRowSpace in ViewOptions then
   InterRowIndent := CalcInterRowIndent;
  //if not (csReading in ComponentState) then
  begin
   vlbAdjustIntegralHeight;

   f_Rows := (ClientHeight - GetTopIndent + Pred(f_RowHeight)) div f_RowHeight;
   if f_Rows < 1 then
    f_Rows := 1;
   vlbInitScrollInfo;
   if not InUpdating then
    Refresh;
  end;//if not (csReading in ComponentState) then
 end;//if aValue <> f_RowHeight then
//#UC END# *514C8B9F030D_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetRowHeight

function TvtCustomListerPrim.pm_GetLockDraw: Boolean;
//#UC START# *514C8CD002EF_4CFFE36B00FAget_var*
//#UC END# *514C8CD002EF_4CFFE36B00FAget_var*
begin
//#UC START# *514C8CD002EF_4CFFE36B00FAget_impl*
 Result := f_LockDraw <> 0;
//#UC END# *514C8CD002EF_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetLockDraw

function TvtCustomListerPrim.pm_GetShowHeader: Boolean;
//#UC START# *51505875011D_4CFFE36B00FAget_var*
//#UC END# *51505875011D_4CFFE36B00FAget_var*
begin
//#UC START# *51505875011D_4CFFE36B00FAget_impl*
 Result := f_Header.Visible;
//#UC END# *51505875011D_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetShowHeader

procedure TvtCustomListerPrim.pm_SetShowHeader(aValue: Boolean);
//#UC START# *51505875011D_4CFFE36B00FAset_var*
//#UC END# *51505875011D_4CFFE36B00FAset_var*
begin
//#UC START# *51505875011D_4CFFE36B00FAset_impl*
 if aValue <> ShowHeader then
 begin
  f_Header.Visible := aValue;
  Invalidate;  {Refresh;}
 end;
//#UC END# *51505875011D_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetShowHeader

procedure TvtCustomListerPrim.pm_SetTopIndex(aValue: LongInt);
//#UC START# *515058D60074_4CFFE36B00FAset_var*
//#UC END# *515058D60074_4CFFE36B00FAset_var*
begin
//#UC START# *515058D60074_4CFFE36B00FAset_impl*
 vlbSetTopIndexPrim(aValue);
 //if f_MultiStrokeItem then vlbInitScrollInfo; //перенесено внутрь vlbSetTopIndexPrim
//#UC END# *515058D60074_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetTopIndex

procedure TvtCustomListerPrim.pm_SetUseTabStops(aValue: Boolean);
//#UC START# *515058FD0320_4CFFE36B00FAset_var*
//#UC END# *515058FD0320_4CFFE36B00FAset_var*
begin
//#UC START# *515058FD0320_4CFFE36B00FAset_impl*
 if f_UseTabStops <> aValue then
 begin
  f_UseTabStops := aValue;
  FullRedraw;
 end;//if f_UseTabStops <> aValue then
//#UC END# *515058FD0320_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetUseTabStops

function TvtCustomListerPrim.pm_GetStrings(Index: LongInt): Il3CString;
//#UC START# *515059960027_4CFFE36B00FAget_var*
//#UC END# *515059960027_4CFFE36B00FAget_var*
begin
//#UC START# *515059960027_4CFFE36B00FAget_impl*
 Result := DoOnGetItem(Index);
//#UC END# *515059960027_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetStrings

procedure TvtCustomListerPrim.pm_SetUseStyleTable(aValue: Boolean);
//#UC START# *51505A2901DF_4CFFE36B00FAset_var*
//#UC END# *51505A2901DF_4CFFE36B00FAset_var*
begin
//#UC START# *51505A2901DF_4CFFE36B00FAset_impl*
 if (f_UseStyleTable <> aValue) then
 begin
  f_UseStyleTable := aValue;
  {$IfNDef DesignTimeLibrary}
  StyleTableChanged;
  {$EndIf DesignTimeLibrary}
 end;//f_UseStyleTable <> aValue
//#UC END# *51505A2901DF_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetUseStyleTable

procedure TvtCustomListerPrim.pm_SetStyleId(aValue: Tl3StyleId);
//#UC START# *51505A890260_4CFFE36B00FAset_var*
//#UC END# *51505A890260_4CFFE36B00FAset_var*
begin
//#UC START# *51505A890260_4CFFE36B00FAset_impl*
 if f_StyleId <> aValue then
 begin
  f_StyleId := aValue;
  {$IfNDef DesignTimeLibrary}
  StyleTableChanged;
  {$EndIf DesignTimeLibrary}
 end;//if f_StyleId <> aValue then
//#UC END# *51505A890260_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetStyleId

procedure TvtCustomListerPrim.pm_SetDrawGrid(aValue: Boolean);
//#UC START# *51505B7500A2_4CFFE36B00FAset_var*
//#UC END# *51505B7500A2_4CFFE36B00FAset_var*
begin
//#UC START# *51505B7500A2_4CFFE36B00FAset_impl*
 if f_DrawGrid <> aValue then
 begin
  f_DrawGrid := aValue;
  FullRedraw;
 end;//if f_DrawGrid <> aValue then
//#UC END# *51505B7500A2_4CFFE36B00FAset_impl*
end;//TvtCustomListerPrim.pm_SetDrawGrid

function TvtCustomListerPrim.pm_GetIsHScrollVisible: Boolean;
//#UC START# *51505B93012A_4CFFE36B00FAget_var*
//#UC END# *51505B93012A_4CFFE36B00FAget_var*
begin
//#UC START# *51505B93012A_4CFFE36B00FAget_impl*
 Result := IsCommonScrollVisible(False);
//#UC END# *51505B93012A_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetIsHScrollVisible

function TvtCustomListerPrim.pm_GetIsVScrollVisible: Boolean;
//#UC START# *51505C8C0381_4CFFE36B00FAget_var*
//#UC END# *51505C8C0381_4CFFE36B00FAget_var*
begin
//#UC START# *51505C8C0381_4CFFE36B00FAget_impl*
 Result := IsCommonScrollVisible;
//#UC END# *51505C8C0381_4CFFE36B00FAget_impl*
end;//TvtCustomListerPrim.pm_GetIsVScrollVisible

procedure TvtCustomListerPrim.DoOnActionElement(Index: LongInt);
//#UC START# *508F81C1004D_4CFFE36B00FA_var*
//#UC END# *508F81C1004D_4CFFE36B00FA_var*
begin
//#UC START# *508F81C1004D_4CFFE36B00FA_impl*
 if (Total <> 0) and Assigned(f_OnActionElement) then
  f_OnActionElement(Self,Index);
//#UC END# *508F81C1004D_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnActionElement

procedure TvtCustomListerPrim.DoOnGetItemImageState(const aItemIndex: LongInt;
 var aEnabled: Boolean);
//#UC START# *508F83890058_4CFFE36B00FA_var*
//#UC END# *508F83890058_4CFFE36B00FA_var*
begin
//#UC START# *508F83890058_4CFFE36B00FA_impl*
 aEnabled := True;
 if Assigned(f_OnGetItemImageState) then
  f_OnGetItemImageState(Self, aItemIndex, aEnabled);
//#UC END# *508F83890058_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItemImageState

procedure TvtCustomListerPrim.DoVScrollVisibleChanged;
//#UC START# *5151AB610331_4CFFE36B00FA_var*
//#UC END# *5151AB610331_4CFFE36B00FA_var*
begin
//#UC START# *5151AB610331_4CFFE36B00FA_impl*
 if Assigned(f_OnVScrollVisibleChanged) then
  f_OnVScrollVisibleChanged(Self);
//#UC END# *5151AB610331_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoVScrollVisibleChanged

procedure TvtCustomListerPrim.DoHScrollVisibleChanged;
//#UC START# *5151AB9C026F_4CFFE36B00FA_var*
//#UC END# *5151AB9C026F_4CFFE36B00FA_var*
begin
//#UC START# *5151AB9C026F_4CFFE36B00FA_impl*
 if Assigned(f_OnHScrollVisibleChanged) then
  f_OnHScrollVisibleChanged(Self);
//#UC END# *5151AB9C026F_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoHScrollVisibleChanged

function TvtCustomListerPrim.IsCommonScrollVisible(aVert: Boolean = True): Boolean;
 {* определяет наличие вертикальной/горизонтальной полосы прокрутки. }
//#UC START# *5151ABC002E8_4CFFE36B00FA_var*
{$IfNDef XE}
const
 (*arrScrollPos : array[Boolean] of Byte = (SB_HORZ, SB_VERT);*)
 arrScrollObj : array[Boolean] of Integer = (Windows.OBJID_HSCROLL, Windows.OBJID_VSCROLL);
{$EndIf  XE}
var
 (*l_SI : TScrollInfo;*)
 l_SbI: TScrollBarInfo;
 l_SbState: DWORD;
//#UC END# *5151ABC002E8_4CFFE36B00FA_var*
begin
//#UC START# *5151ABC002E8_4CFFE36B00FA_impl*
 // Т.к. вертикальный скроллбар теперь может иметь флаг SIF_DISABLENOSCROLL,
 // определять его видимость нужно не расчетами, а исходить из того, что скажет
 // Windows
 // http://mdp.garant.ru/pages/viewpage.action?pageId=476367908

 l3FillChar(l_SbI, SizeOf(l_SbI), 0);
 l_SbI.cbSize := SizeOf(l_SbI);
 {$IfDef XE}
 if aVert then
  GetScrollBarInfo(Handle, Longint(OBJID_VSCROLL), l_SbI)
 else
  GetScrollBarInfo(Handle, Longint(OBJID_HSCROLL), l_SbI);
 {$Else XE}
 GetScrollBarInfo(Handle, arrScrollObj[aVert], l_SbI);
 {$EndIf XE}
 l_SbState := l_SbI.rgState[0];
 Result := ((l_SbState and STATE_SYSTEM_INVISIBLE) = 0) and
  ((l_SbState and STATE_SYSTEM_OFFSCREEN) = 0);

 (*l3FillChar(l_SI, SizeOf(l_SI), 0);
 with l_SI do
 begin
  cbSize := SizeOf(l_SI);
  fMask := SIF_ALL;
 end;//with l_SI do
 Windows.GetScrollInfo(Handle, arrScrollPos[aVert], l_SI);
 with l_SI do
  Result := ((nMax - nMin) > 0) and (nPage <= Cardinal(nMax - nMin));*)
//#UC END# *5151ABC002E8_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.IsCommonScrollVisible

function TvtCustomListerPrim.IsNeedScrollBars: Boolean;
 {* определяет нужены ли в CreateParams стили WS_VSCROLL WS_HSCROLL. }
//#UC START# *5151AC21016D_4CFFE36B00FA_var*
//#UC END# *5151AC21016D_4CFFE36B00FA_var*
begin
//#UC START# *5151AC21016D_4CFFE36B00FA_impl*
 Result := (f_Total > 0);
//#UC END# *5151AC21016D_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.IsNeedScrollBars

function TvtCustomListerPrim.NeedShowHint: Boolean;
//#UC START# *5151ACBF0052_4CFFE36B00FA_var*
//#UC END# *5151ACBF0052_4CFFE36B00FA_var*
begin
//#UC START# *5151ACBF0052_4CFFE36B00FA_impl*
 Result := not InDrop;
//#UC END# *5151ACBF0052_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.NeedShowHint

procedure TvtCustomListerPrim.FreeHintWindow;
//#UC START# *5151ACE20123_4CFFE36B00FA_var*
//#UC END# *5151ACE20123_4CFFE36B00FA_var*
begin
//#UC START# *5151ACE20123_4CFFE36B00FA_impl*
 f_HintTimerCount := 0;
 l3Free(f_HintWindow);
 Application.CancelHint;
 ShowHint := false;
 Hint := '';
 l3Free(f_HintTimer);
//#UC END# *5151ACE20123_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.FreeHintWindow

function TvtCustomListerPrim.GetHintWindow: THintWindow;
//#UC START# *5151ACFC01D8_4CFFE36B00FA_var*
var
 l_Font : Il3Font;
//#UC END# *5151ACFC01D8_4CFFE36B00FA_var*
begin
//#UC START# *5151ACFC01D8_4CFFE36B00FA_impl*
 if f_HintWindow = nil then
 begin
  f_HintWindow := HintWindowClass.create(self);
  {TfcTreeHintWindow(HintWindow).Node := Node;}

  f_HintWindow.Color := GetSysColor(COLOR_INFOBK);
  f_HintWindow.Canvas.Brush.Color := GetSysColor(COLOR_INFOBK);
  f_HintWindow.Canvas.Font := self.Font;
  l_Font := Canvas.Font;
  InitItemFont(f_LastHintIndex, l_Font, vt_lipTextHint);
  l3IFont2Font(l_Font, f_HintWindow.Canvas.Font);

  f_HintWindow.Canvas.Font.Color := GetSysColor(COLOR_INFOTEXT);
  f_HintWindow.Canvas.Pen.Color := clBlack;
 end;

 if f_HintTimer = nil then
 begin
  f_HintTimer := TTimer.Create(self);
  f_HintTimer.OnTimer := HintTimerEvent;
  f_HintTimer.Interval := gHintTimerTickInterval;
  f_HintTimer.Enabled := False;
 end;

 f_HintTimerCount := (Application.HintHidePause div gHintTimerTickInterval);
 Result := f_HintWindow;
//#UC END# *5151ACFC01D8_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetHintWindow

procedure TvtCustomListerPrim.ShowHintWindow(const aHint: Il3CString;
 const aPosition: TPoint);
//#UC START# *5151AD1803C2_4CFFE36B00FA_var*
//#UC END# *5151AD1803C2_4CFFE36B00FA_var*
begin
//#UC START# *5151AD1803C2_4CFFE36B00FA_impl*
 if f_HintTimer = nil then
 begin
  f_HintTimer := TTimer.Create(self);
  f_HintTimer.OnTimer := HintTimerEvent;
  f_HintTimer.Interval := gHintTimerTickInterval;
  f_HintTimer.Enabled := False;
 end;

 f_HintTimerCount := (Application.HintHidePause div gHintTimerTickInterval);

 f_HintPosition := aPosition;
 Hint := l3Str(aHint);
 ShowHint := NeedShowHint;
//#UC END# *5151AD1803C2_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.ShowHintWindow

procedure TvtCustomListerPrim.HintTimerEvent(Sender: TObject);
//#UC START# *5151AD8700DD_4CFFE36B00FA_var*
var
 cp: TPoint;
//#UC END# *5151AD8700DD_4CFFE36B00FA_var*
begin
//#UC START# *5151AD8700DD_4CFFE36B00FA_impl*
 if f_HintWindow = nil then
  Exit;
 if f_HintTimer = nil then
  Exit;

 GetCursorPos(CP);
 CP := self.ScreentoClient(CP);

 if (cp.x < 0) or (cp.x > ClientWidth) or
    (cp.y < 0) or (cp.y > ClientHeight) or not Application.Active then
 begin
  FreeHintWindow;
  ResetLastHint;
 end
 else
 begin
  if f_HintTimerCount = 0 then
   FreeHintWindow
  else
   Dec(f_HintTimerCount);
 end;
//#UC END# *5151AD8700DD_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.HintTimerEvent

function TvtCustomListerPrim.IsHintNeededForAnElement(anIndex: Integer): Boolean;
//#UC START# *5151ADD102D9_4CFFE36B00FA_var*
//#UC END# *5151ADD102D9_4CFFE36B00FA_var*
begin
//#UC START# *5151ADD102D9_4CFFE36B00FA_impl*
 Result := not f_MultiStrokeItem;
//#UC END# *5151ADD102D9_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.IsHintNeededForAnElement

function TvtCustomListerPrim.NotifyIfNewCurrentEmpty: Boolean;
 {* определяет нужно ли вызывать событие OnCurrentChanged в случае если пришел NewCurrent = -1. }
//#UC START# *5151AE2202F5_4CFFE36B00FA_var*
//#UC END# *5151AE2202F5_4CFFE36B00FA_var*
begin
//#UC START# *5151AE2202F5_4CFFE36B00FA_impl*
 Result := AllowWithoutCurrent;
//#UC END# *5151AE2202F5_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.NotifyIfNewCurrentEmpty

procedure TvtCustomListerPrim.UpdateInterRowIndent;
//#UC START# *5151AE520170_4CFFE36B00FA_var*
//#UC END# *5151AE520170_4CFFE36B00FA_var*
begin
//#UC START# *5151AE520170_4CFFE36B00FA_impl*
 if voShowInterRowSpace in ViewOptions then
 begin
  InterRowIndent := CalcInterRowIndent;
  Invalidate;
 end;
//#UC END# *5151AE520170_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.UpdateInterRowIndent

function TvtCustomListerPrim.TSGetTabStopPos(anIndex: Integer;
 out aPos: Integer): Boolean;
//#UC START# *5151AE7B00EA_4CFFE36B00FA_var*
var
 l_Width: Integer;
 l_InfoCanvas: Il3InfoCanvas;
 l_I, l_SectPos : Integer;
//#UC END# *5151AE7B00EA_4CFFE36B00FA_var*
begin
//#UC START# *5151AE7B00EA_4CFFE36B00FA_impl*
 if (anIndex < 0) or (anIndex > f_Header.Sections.Count-1) then
 begin
  if anIndex = 0 then
  begin
   Result := True;
   l_InfoCanvas := l3CrtIC;
   try
    aPos := l_InfoCanvas.DP2LP(l3SPoint(f_Header.Width,0)).X;
   finally
    l_InfoCanvas := nil;
   end; // try ... finally
  end
  else
   Result := False
 end else
 begin
   l_InfoCanvas := l3CrtIC;
   try
    Result := True;
    l_SectPos := 0;
    for l_I := 0 to anIndex do
    begin
     l_Width := f_Header.SectionWidth[l_I];
     if l_I = 0 then
      l_Width := l_Width - f_TabsFirstIndent;
     l_SectPos := l_SectPos + l_Width;
    end;
    if l_SectPos > f_Header.Width then
    begin
     l_SectPos := l_SectPos - f_Header.SectionWidth[anIndex];
     if l_SectPos > f_Header.Width then
      aPos := 0
     else
      aPos := l_InfoCanvas.DP2LP(l3SPoint(f_Header.Width - l_SectPos,0)).X;
    end else
    begin
     l_Width := f_Header.SectionWidth[anIndex];
     if anIndex = 0 then
      l_Width := l_Width - f_TabsFirstIndent;
     aPos := l_InfoCanvas.DP2LP(l3SPoint(l_Width,0)).X;
    end;
   finally
    l_InfoCanvas := nil;
   end; // try .. finally
 end;
//#UC END# *5151AE7B00EA_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.TSGetTabStopPos

function TvtCustomListerPrim.GetImagesStored: Boolean;
//#UC START# *5151AF3B039A_4CFFE36B00FA_var*
//#UC END# *5151AF3B039A_4CFFE36B00FA_var*
begin
//#UC START# *5151AF3B039A_4CFFE36B00FA_impl*
 Result := (f_Images <> nil);
//#UC END# *5151AF3B039A_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetImagesStored

function TvtCustomListerPrim.DoOnGetItemIndent: Integer;
 {* функция определяет добавляемое свободное место до иконки элемента.
Если отступ в обработчике будет определен как нулевой, то по
умолчанию отступ делается на ширину иконки, если таковые имеются. }
//#UC START# *5151AF650239_4CFFE36B00FA_var*
//#UC END# *5151AF650239_4CFFE36B00FA_var*
begin
//#UC START# *5151AF650239_4CFFE36B00FA_impl*
 Result := ImagesHeight;
//#UC END# *5151AF650239_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItemIndent

function TvtCustomListerPrim.DrawFooter(const aCanvas: Il3Canvas;
 aTop: Integer): Integer;
 {* Возвращает aTop + отрисованную высоту }
//#UC START# *5151AFD10046_4CFFE36B00FA_var*
var
 CR: Tl3SRect;
 l_Rect: TRect;
 l_Size: TPoint;
//#UC END# *5151AFD10046_4CFFE36B00FA_var*
begin
//#UC START# *5151AFD10046_4CFFE36B00FA_impl*
 if FooterVisible then
 begin
  aCanvas.BackColor := Color;
  if f_FooterActive then
   aCanvas.Font.AssignFont(FooterActiveFont)
  else
   aCanvas.Font.AssignFont(FooterFont);
  CR.R.WR := ClientRect;
  CR.Top := aTop;
  l_Size := GetFooterDim;
  CR.Bottom := CR.Top + l_Size.Y + InterRowIndent;
  aCanvas.FillRect(CR);
  l_Rect := CR.R.WR;
  Inc(l_Rect.Left, FooterLeftIndent);
  Inc(l_Rect.Top, InterRowIndent div 2);

  InflateRect(l_Rect, -cFocusRectBounds, 0);
  aCanvas.DrawText(l3PCharLen(FooterCaption), l_Rect, vtMultiLineDrawTextFormat);
  InflateRect(l_Rect, cFocusRectBounds, 0);
  if FooterSelected then
  begin
   l_Rect.Right := l_Rect.Left + l_Size.X;
   l_Rect.Bottom := l_Rect.Top + l_Size.Y;
   aCanvas.BackColor := Self.Color;
   aCanvas.Font.ForeColor := clBlack;
   aCanvas.Canvas.Brush.Color := ColorToRGB(Self.Font.Color) xor ColorToRGB(Self.Color);
   aCanvas.Canvas.DrawFocusRect(l_Rect);
  end;
  Result := CR.Bottom;
 end else
  Result := aTop;
//#UC END# *5151AFD10046_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DrawFooter

function TvtCustomListerPrim.FooterLeftIndent: Integer;
//#UC START# *5151AFFD0066_4CFFE36B00FA_var*
//#UC END# *5151AFFD0066_4CFFE36B00FA_var*
begin
//#UC START# *5151AFFD0066_4CFFE36B00FA_impl*
 Result := DoOnGetItemIndent + RowHeight div 4;
//#UC END# *5151AFFD0066_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.FooterLeftIndent

procedure TvtCustomListerPrim.DoFooterClick;
//#UC START# *5151B0180310_4CFFE36B00FA_var*
//#UC END# *5151B0180310_4CFFE36B00FA_var*
begin
//#UC START# *5151B0180310_4CFFE36B00FA_impl*
 if Assigned(f_OnFooterClick) then
  f_OnFooterClick(Self);
//#UC END# *5151B0180310_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoFooterClick

procedure TvtCustomListerPrim.DropFooterSelection;
//#UC START# *5151B02B00A9_4CFFE36B00FA_var*
//#UC END# *5151B02B00A9_4CFFE36B00FA_var*
begin
//#UC START# *5151B02B00A9_4CFFE36B00FA_impl*
 FooterSelected := False;
//#UC END# *5151B02B00A9_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DropFooterSelection

procedure TvtCustomListerPrim.DoSetRowHeight(aValue: Integer);
//#UC START# *5151B1A301F2_4CFFE36B00FA_var*
var
 l_MinRowHeight : Integer;
//#UC END# *5151B1A301F2_4CFFE36B00FA_var*
begin
//#UC START# *5151B1A301F2_4CFFE36B00FA_impl*
 l_MinRowHeight := 0;

 // если эту функцию вызвали просто для пересчета, то AutoRowHeight
 // сбрасывать не нужно

 if Images <> nil then l_MinRowHeight := Images.Height;
 if PickedList then l_MinRowHeight := Max(l_MinRowHeight, PickImages.Height);
 if f_FontHeight = 0 then
  vlbCalcFontFields;
 l_MinRowHeight := Max(l_MinRowHeight, f_FontHeight);

 if l_MinRowHeight = 0 then l_MinRowHeight := 30;//DefRowHeight;

 if (aValue < l_MinRowHeight)
    {or ((aValue > l_MinRowHeight) and f_AutoRowHeight)} then
  aValue := l_MinRowHeight;

 if aValue <> f_RowHeight then
 begin
  f_RowHeight := aValue;
  if voShowInterRowSpace in ViewOptions then
   InterRowIndent := CalcInterRowIndent;
  //if not (csReading in ComponentState) then
  begin
   vlbAdjustIntegralHeight;

   f_Rows := (ClientHeight - GetTopIndent + Pred(f_RowHeight)) div f_RowHeight;
   if f_Rows < 1 then
    f_Rows := 1;
   vlbInitScrollInfo;
   if not InUpdating then
    Refresh;
  end;//if not (csReading in ComponentState) then
 end;//if aValue <> f_RowHeight then
//#UC END# *5151B1A301F2_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoSetRowHeight

function TvtCustomListerPrim.ItemOnScreen(OnlyWhole: Boolean): Integer;
//#UC START# *5151B1F30312_4CFFE36B00FA_var*
//#UC END# *5151B1F30312_4CFFE36B00FA_var*
begin
//#UC START# *5151B1F30312_4CFFE36B00FA_impl*
 if UseDrawPoints then
 begin
  Result := DrawPoints.Count;
  if OnlyWhole and (Result > 0) and
     (DrawPoints.Last -
      {Ord(FMultiStrokeItem)*} InterRowIndent > ClientHeight) then Dec(Result);
 end//if UseDrawPoints then
 else
 begin
  if f_Rows = 0 then
   pm_GetRowHeight; // там пересчет f_Rows
  if OnlyWhole then
   Result := (ClientHeight - GetTopIndent) div CompleteRowHeight
  else
   Result := (ClientHeight - GetTopIndent + Pred(CompleteRowHeight)) div CompleteRowHeight;
 end;//if UseDrawPoints then
 if Result < 1 then
  Result := 1;
//#UC END# *5151B1F30312_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.ItemOnScreen

procedure TvtCustomListerPrim.MakeDrawPoints(aDrawPoints: Tl3LongintList);
//#UC START# *5151B22F0281_4CFFE36B00FA_var*
var
 l_SRect  : Tl3SRect;
 l_l3Rect : Tl3Rect;
 l_I      : LongInt;
 l_R      : TRect;
 l_CR     : TRect;
 l_CurH   : Integer;
 l_S      : Il3CString;
 l_Canvas : Il3InfoCanvas;
 l_Painter: Il3NodePainter;
 l_LWidth: Integer;
//#UC END# *5151B22F0281_4CFFE36B00FA_var*
begin
//#UC START# *5151B22F0281_4CFFE36B00FA_impl*
 if not UseDrawPoints then
  Exit;
 l_Canvas := l3CrtIC;
 //l_Canvas.BeginPaint;
 try
  l_R := Rect(0,0,ClientWidth, ClientHeight);
  if l_R.Right < 3 then l_R.Right := 3;
  if Images <> nil then
   Inc(l_R.Left,Images.Width + ImageAddSpace);
  if PickedList then
   Inc(l_R.Left,PickImages.Width + ImageAddSpace);

  l_I := 0;
  l_CurH := 0;
  aDrawPoints.Count := 0;
  while (l_I + f_TopIndex < f_Total) do
  begin
   Inc(l_CurH, GetItemHeight(l_I + f_TopIndex) + InterRowIndent);
   aDrawPoints.Add(l_CurH);
   if (l_CurH >= ClientHeight) then
    Break;
   Inc(l_I);
  end;//while (l_I + f_TopIndex < f_Total) do
 finally
  //l_Canvas.EndPaint;
 end;//try..finally
//#UC END# *5151B22F0281_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.MakeDrawPoints

procedure TvtCustomListerPrim.DropDrawPoints;
//#UC START# *5151B2900206_4CFFE36B00FA_var*
//#UC END# *5151B2900206_4CFFE36B00FA_var*
begin
//#UC START# *5151B2900206_4CFFE36B00FA_impl*
 if (f_DrawPoints <> nil) then
  f_DrawPoints.Clear;
//#UC END# *5151B2900206_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DropDrawPoints

function TvtCustomListerPrim.CalcTopIndex(aMaxVisItem: LongInt): LongInt;
//#UC START# *5151B2C70248_4CFFE36B00FA_var*
var
 l_TopIndent : Integer;
 l_Len         : Integer;
 R,CR        : TRect;
 l_S         : Il3CString;
 l_Canvas    : Il3InfoCanvas;
 l_l3Rect     : Tl3Rect;
 lSRect      : Tl3SRect;
//#UC END# *5151B2C70248_4CFFE36B00FA_var*
begin
//#UC START# *5151B2C70248_4CFFE36B00FA_impl*
 Result := 0;
 if not UseDrawPoints or (aMaxVisItem <= 0) then
  Exit;

 if (aMaxVisItem = f_HighIndex) and FooterVisible then
  l_Len := GetFooterDim.Y + InterRowIndent
 else
  l_Len := 0;

 Result := aMaxVisItem;
 l_Canvas := l3CrtIC;
 try
  repeat
   Inc(l_Len, GetItemHeight(Result));
   l_TopIndent := GetTopIndent;
   if (l_Len > ClientHeight - l_TopIndent) and (Result < aMaxVisItem)
    then Inc(Result);
   if l_Len >= ClientHeight - GetTopIndent then
    Break;
   Dec(Result);
   if Result < 0 then
    begin
     Result := 0;
     Break;
    end;
   Inc(l_Len, InterRowIndent);
  until False;
 finally
  l_Canvas := nil;
 end; {try..finally}
//#UC END# *5151B2C70248_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CalcTopIndex

function TvtCustomListerPrim.AlignTopIndex: Boolean;
//#UC START# *5152B6A002D5_4CFFE36B00FA_var*
var
 l_WholeRows    : Integer;
 l_SaveTopIndex : Integer;
//#UC END# *5152B6A002D5_4CFFE36B00FA_var*
begin
//#UC START# *5152B6A002D5_4CFFE36B00FA_impl*
 Result := False;
 if Total <= 0 then
  Exit;
 l_SaveTopIndex := TopIndex;
 if TopIndex > 0 then
  if UseDrawPoints then
  begin
   // Если меню/доки залочены - пересчитывать нелья
   // конец дерева (если был виден) уедет за границу экрана
   // К-171968647
   // Проверка и последующая корректировка при разлочке
   // полностью аналогична с FormDispatcher.Lock и InUpdating
   if (f_TopIndex - 1 + ItemOnScreen(False) >= f_HighIndex)
      and not IsMenuLocked and not DisableAlignTopIndex then
    f_TopIndex := CalcTopIndex(f_HighIndex);
  end//if UseDrawPoints then
  else
  begin
   l_WholeRows := (ClientHeight - GetTopIndent) div CompleteRowHeight;
   if FooterVisible then
    Dec(l_WholeRows);
   // Если меню/доки залочены - пересчитывать нелья
   // конец дерева (если был виден) уедет за границу экрана
   // К-171968647
   // Проверка и последующая корректировка при разлочке
   // полностью аналогична с FormDispatcher.Lock и InUpdating
   if (f_TopIndex -1 + l_WholeRows > f_HighIndex)
      and not IsMenuLocked and not DisableAlignTopIndex then
    f_TopIndex := f_HighIndex - l_WholeRows + 1;
  end;//if UseDrawPoints then
 if f_TopIndex < 0 then
  f_TopIndex := 0;
 Result := TopIndex <> l_SaveTopIndex;
//#UC END# *5152B6A002D5_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.AlignTopIndex

procedure TvtCustomListerPrim.CheckParam;
//#UC START# *5152B6CE024D_4CFFE36B00FA_var*
//#UC END# *5152B6CE024D_4CFFE36B00FA_var*
begin
//#UC START# *5152B6CE024D_4CFFE36B00FA_impl*
 if f_FontChanged {and HandleAllocated} then
  vlbCalcFontFields;
//#UC END# *5152B6CE024D_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CheckParam

procedure TvtCustomListerPrim.SetCaret;
//#UC START# *5152B6DD01D1_4CFFE36B00FA_var*
var
 St     : PAnsiChar;
 Extent : TSize;
 l_ICN  : Il3InfoCanvas;
 lRect  : TRect;
//#UC END# *5152B6DD01D1_4CFFE36B00FA_var*
begin
//#UC START# *5152B6DD01D1_4CFFE36B00FA_impl*
 if (SearchStr = '') or (Total = 0) then
  Exit;
 if Assigned(f_OnGetItemPainter) then
  InvalidateItem(Current)
 else
 begin
  ST := l3PCharLen(DoOnGetItem(Current)).S;
  l_ICN := l3CrtIC;
  l_ICN.Lock;
  try
   l_ICN.Font := Canvas.Font;
   if not Windows.GetTextExtentPointA(l_ICN.DC, ST, Length(SearchStr), Extent) then
    Exit;
  finally
   l_ICN.Unlock;
  end;{try..finally}

  lRect := GetDrawTextRect(Current);
  Caret.Position := l3SPoint(lRect.Left + Extent.cX, lRect.Top + GetItemVShift);
 end;
 //SetCaretPos(f_CaretPoint.X + Extent.cX,f_CaretPoint.Y);
//#UC END# *5152B6DD01D1_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.SetCaret

procedure TvtCustomListerPrim.CharToItem(Sender: TObject;
 var SrchStr: AnsiString;
 aFromCurrent: Boolean;
 var Index: LongInt);
//#UC START# *5152B6F00188_4CFFE36B00FA_var*
var
 I     : LongInt;
 Len   : Word;
 Res   : Integer;
//#UC END# *5152B6F00188_4CFFE36B00FA_var*
begin
//#UC START# *5152B6F00188_4CFFE36B00FA_impl*
 Len := Length(SrchStr);
 Index := -1;
 Screen.Cursor := crHourglass;
 try
  for I := 0 to Pred(Total) do
  begin
   Res := l3AnsiStrLICompExt(PAnsiChar(SrchStr), l3PCharLen(DoOnGetItem(I)).S, Len);
   if (Res = 0) then
   begin
    Index := I;
    Break;
   end;//Res = 0
   {if Res > 0 then Exit;   --if sorted only}
  end;//for I
 finally
  Screen.Cursor := crDefault;
 end;//try..finally
//#UC END# *5152B6F00188_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CharToItem

procedure TvtCustomListerPrim.vlbClearSelRange(First: LongInt;
 Last: LongInt);
 {* clear the selection for the given range of indexes }
//#UC START# *5152B71F0399_4CFFE36B00FA_var*
//#UC END# *5152B71F0399_4CFFE36B00FA_var*
begin
//#UC START# *5152B71F0399_4CFFE36B00FA_impl*
 vlbSelectRangePrim(First, Last, False);
//#UC END# *5152B71F0399_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbClearSelRange

procedure TvtCustomListerPrim.vlbDragSelection(First: LongInt;
 Last: LongInt;
 aSelectState: Integer);
 {* drag the selection }
//#UC START# *5152B75B012A_4CFFE36B00FA_var*
var
 l_I       : LongInt;
 OutSide : Boolean;
//#UC END# *5152B75B012A_4CFFE36B00FA_var*
begin
//#UC START# *5152B75B012A_4CFFE36B00FA_impl*
 {set new active item}
 vlbNewActiveItem(Last);

 {remove selection from visible selected items not in range}
 for l_I := f_TopIndex to Min(f_TopIndex + Pred(ItemOnScreen(false)), Pred(f_Total)) do
 begin
  if First <= Last
   then OutSide := (l_I < First) or (l_I > Last)
   else OutSide := (l_I < Last) or (l_I > First);

  if PickedList then
  begin
   if not (OutSide or (SelectState[l_I] = aSelectState)) then
    InvalidateItem(l_I)
  end
  else
   if (Selected[l_I] = OutSide) then
    InvalidateItem(l_I);
 end;
 DoOnSelectOutRange(First, Last, aSelectState);
 pm_SetCurrent(Last);
 Update;
//#UC END# *5152B75B012A_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbDragSelection

procedure TvtCustomListerPrim.vlbExtendSelection(Index: LongInt);
 {* Shift-LMouseBtn }
//#UC START# *5152B785035C_4CFFE36B00FA_var*
var
 l_I : LongInt;
 OutSide : Boolean;
//#UC END# *5152B785035C_4CFFE36B00FA_var*
begin
//#UC START# *5152B785035C_4CFFE36B00FA_impl*
 {Multiselect option requires OnSelect and OnIsSelected to be defined}
 if not f_MultiSelect {or (not Assigned(f_OnSelect))
    or (not Assigned(f_OnIsSelected)) } then
  Exit;

 {verify valid index}
 if Index < 0 then
  Index := 0
 else
  if Index > f_HighIndex then
   Index := f_HighIndex;

 {clear current selections}
 {vlbDeselectAllItems;}

 {DoOnSelect(-1, False);}

 for l_I := f_TopIndex to Min(f_TopIndex + Pred(ItemOnScreen(false)), Pred(f_Total)) do
  begin
   if f_Anchor <= Index
    then OutSide := (l_I < f_Anchor) or (l_I > Index)
    else OutSide := (l_I < Index) or (l_I > f_Anchor);

   if Selected[l_I] xor not OutSide then
   begin
    InvalidateItem(l_I);
   end;
  end;

 DoOnSelectOutRange(f_Anchor, Index, 1);

 {set selection for all items from the active one to the currently selected item}
 {vlbSetSelRange(lAnchor, Index);}

 {set new active item}
 f_Current := Index;
 pm_SetCurrent(f_Current);
 Update;
//#UC END# *5152B785035C_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbExtendSelection

procedure TvtCustomListerPrim.vlbNewActiveItem(Index: LongInt);
 {* set the currently selected item }
//#UC START# *5152B7A400C8_4CFFE36B00FA_var*
//#UC END# *5152B7A400C8_4CFFE36B00FA_var*
begin
//#UC START# *5152B7A400C8_4CFFE36B00FA_impl*
 {verify valid index}
 if Index < 0 then
  Index := 0
 else
  if Index > f_HighIndex then
   Index := f_HighIndex;

 {set the newly selected item index}
 vlbMakeItemVisible(Index);

 vlbSetEasyCurrent(Index);

 (*InvalidateItem(f_Current);
 InvalidateItem(Index);
 f_Current := Index;
 {set the newly selected item index}
 if Assigned(f_OnCurrentChanged) then f_OnCurrentChanged(Self, Index);*)

 if (f_InQuickSearch = 0) then SearchStr := '';
 if not f_MultiSelect then Selected[Index] := True;
 {InvalidateItem(Index);}
//#UC END# *5152B7A400C8_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbNewActiveItem

procedure TvtCustomListerPrim.vlbSelectRangePrim(First: LongInt;
 Last: LongInt;
 Select: Boolean);
 {* change the selection for the given range of indexes }
//#UC START# *5152B7C400AF_4CFFE36B00FA_var*
var
 l_I : LongInt;
//#UC END# *5152B7C400AF_4CFFE36B00FA_var*
begin
//#UC START# *5152B7C400AF_4CFFE36B00FA_impl*
 if First <= Last then
 begin
  for l_I := First to Last do
   if Selected[l_I] <> Select then
   begin
    Selected[l_I] := Select;
    InvalidateItem(l_I);
   end;
 end else
 for l_I := First downto Last do
  if Selected[l_I] <> Select then
  begin
   Selected[l_I] := Select;
   InvalidateItem(l_I);
  end;
//#UC END# *5152B7C400AF_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbSelectRangePrim

procedure TvtCustomListerPrim.vlbSetAllItemsPrim(Select: Boolean);
 {* primitive routine thats acts on all items }
//#UC START# *5152B8EA0346_4CFFE36B00FA_var*
var
 l_I : LongInt;
//#UC END# *5152B8EA0346_4CFFE36B00FA_var*
begin
//#UC START# *5152B8EA0346_4CFFE36B00FA_impl*
 if f_LockSelectChange then
  Exit;
 for l_I := f_TopIndex to Min(f_TopIndex + Pred(ItemOnScreen(false)), Pred(Total)) do
  if (Selected[l_I] <> Select) then
   InvalidateItem(l_I);

 {select or delselect all items}
 DoOnSelect(vt_smAllSelect, Ord(Select));
//#UC END# *5152B8EA0346_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbSetAllItemsPrim

procedure TvtCustomListerPrim.vlbInvertAllItemsPrim;
 {* primitive routine thats invert selection on all items }
//#UC START# *5152B922017A_4CFFE36B00FA_var*
var
 l_I : LongInt;
//#UC END# *5152B922017A_4CFFE36B00FA_var*
begin
//#UC START# *5152B922017A_4CFFE36B00FA_impl*
 for l_I := f_TopIndex to f_TopIndex + Pred(ItemOnScreen(false)) do
  InvalidateItem(l_I);

 {select or delselect all items}
 DoOnSelect(vt_smAllInvert, 1);
//#UC END# *5152B922017A_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbInvertAllItemsPrim

procedure TvtCustomListerPrim.vlbHScrollPrim(aDelta: Integer);
//#UC START# *5152B9400008_4CFFE36B00FA_var*
var
 SaveD : Integer;
//#UC END# *5152B9400008_4CFFE36B00FA_var*
begin
//#UC START# *5152B9400008_4CFFE36B00FA_impl*
 SaveD := f_HDelta;
 if aDelta < 0 then
  if Abs(aDelta) > f_HDelta then
   f_HDelta := 0
  else
   Inc(f_HDelta, aDelta)
 else
  if LongInt(f_HDelta) + aDelta > LongInt(f_Columns) then
   f_HDelta := f_Columns
  else
   Inc(f_HDelta, aDelta);

 if f_HDelta <> SaveD then
 begin
  vlbSetHScrollPos;
  Refresh;
 end;
//#UC END# *5152B9400008_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbHScrollPrim

procedure TvtCustomListerPrim.vlbVScrollPrim(aDelta: Integer);
//#UC START# *5152B96600E1_4CFFE36B00FA_var*
//#UC END# *5152B96600E1_4CFFE36B00FA_var*
begin
//#UC START# *5152B96600E1_4CFFE36B00FA_impl*
 pm_SetTopIndex(Min(Max(f_TopIndex + aDelta, 0), Pred(f_Total)));
//#UC END# *5152B96600E1_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbVScrollPrim

procedure TvtCustomListerPrim.vlbSetSelRange(aFirst: LongInt;
 aLast: LongInt);
 {* set the selection on for the given range of indexes }
//#UC START# *5152BA1102AA_4CFFE36B00FA_var*
//#UC END# *5152BA1102AA_4CFFE36B00FA_var*
begin
//#UC START# *5152BA1102AA_4CFFE36B00FA_impl*
 vlbSelectRangePrim(aFirst, aLast, True);
//#UC END# *5152BA1102AA_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbSetSelRange

function TvtCustomListerPrim.CanScrollWindow: Boolean;
//#UC START# *5152BAA303BA_4CFFE36B00FA_var*
//#UC END# *5152BAA303BA_4CFFE36B00FA_var*
begin
//#UC START# *5152BAA303BA_4CFFE36B00FA_impl*
 Result := True;
//#UC END# *5152BAA303BA_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CanScrollWindow

function TvtCustomListerPrim.NeedInitScrollInfoInvlbInitScrollInfo: Boolean;
//#UC START# *5152BAD2033B_4CFFE36B00FA_var*
//#UC END# *5152BAD2033B_4CFFE36B00FA_var*
begin
//#UC START# *5152BAD2033B_4CFFE36B00FA_impl*
 Result := f_MultiStrokeItem;
//#UC END# *5152BAD2033B_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.NeedInitScrollInfoInvlbInitScrollInfo

procedure TvtCustomListerPrim.vlbSetTopIndexPrim(Index: LongInt);
//#UC START# *5152BB1A0168_4CFFE36B00FA_var*
var
 DY         : LongInt;
 SaveD      : LongInt;
 ScrollArea,
 ClipArea,
 TopIndentArea,
 l_CR         : TRect;
 CN         : Il3Canvas;

 procedure ShiftArea(aVertShift: Integer);
 begin
  Windows.ScrollWindow(Handle, 0, aVertShift, @ScrollArea, @ClipArea);
  if (aVertShift mod 2 <> 0) then
   f_EvenScrolled := not f_EvenScrolled;
 end;
//#UC END# *5152BB1A0168_4CFFE36B00FA_var*
begin
//#UC START# *5152BB1A0168_4CFFE36B00FA_impl*
 f_NeedCurrentVisible := False;
 if csDesigning in ComponentState then
  Exit;
 if Index < 0 then
  Index := -1;
 Index := Min(Index, Pred(f_Total));
 if Index <> f_TopIndex then
 begin
  if (Index >= 0) and (Index <= f_HighIndex) then
  begin
   CN := Canvas;
   CN.BeginPaint;
   try
    CN.DrawEnabled := true;

    if (f_Current >= f_TopIndex) and (f_Current < f_TopIndex + ItemOnScreen(True)) then
     vlbDrawFocusRect(CN, f_Current);

    SaveD := f_TopIndex;

    {if we can't make the requested item the top one, at least show it}
    //if f_MultiStrokeItem or (Index + f_Rows -1 <= f_HighIndex)
    // then f_TopIndex := Index
    // else f_TopIndex := f_HighIndex - f_Rows + 1;

    f_TopIndex := Index;
    if f_TopIndex < 0 then
     f_TopIndex := 0;

    AlignTopIndex;

    vlbSetVScrollPos;

    if SaveD <> f_TopIndex then
    begin
     ClipArea := ClientRect;
     {adjust top of the clipping region to exclude the header, if any}
     if ShowHeader then
      with ClipArea do
       Top := Top + f_Header.Height;
     TopIndentArea := ClipArea;
     with ClipArea do
     begin
      Top := Top + InterRowIndent;
      TopIndentArea.Bottom := TopIndentArea.Top + InterRowIndent;
      Windows.InvalidateRect(Handle, @TopIndentArea, True);
      if ((Bottom - Top) > 0) and ((Right - Left) > 0) then
       if SaveD > f_HighIndex then
        Windows.InvalidateRect(Handle, @ClipArea, True)
       else
         {adjust bottom of the clipping region to an even number of rows}
        with ClipArea do
         if UseDrawPoints then
         begin
          DY := SaveD - f_TopIndex;
          ScrollArea := ClipArea;
          if (DrawPoints.Count <= 0) then
           ScrollArea.Bottom := ClientHeight
          else
           ScrollArea.Bottom := DrawPoints.Last;
          if ScrollArea.Bottom > ClientHeight then
           ScrollArea.Bottom := ClientHeight;
          if DY > 0 then {ScrollDown}
           DropDrawPoints; {New Item Height Table}
          if CanScrollWindow AND
             (Abs(DY) < ItemOnScreen(false)) then
            {scroll the window setting up a clipping region}
          begin
           l_CR := ClipArea;
           if DY > 0 then
            {Down}
           begin
            ScrollArea.Bottom := ClientHeight - DrawPoints[Pred(DY)];
            l_CR.Bottom := l_CR.Top + DrawPoints[Pred(DY)];
            ShiftArea(DrawPoints[Pred(DY)]);
            Inc(f_CaretPoint.Y,DrawPoints[Pred(DY)]);
           end//if DY > 0 then
           else
            {Up}
           begin
            DY := Abs(DY);
            Inc(ScrollArea.Top,DrawPoints[Pred(DY)]);
            {l_CR.Top := l_CR.Bottom - Integer(lDrawPointArray[Pred(DY)]);}
            l_CR.Top := l_CR.Top + (ScrollArea.Bottom - ScrollArea.Top);
            ShiftArea(-(DrawPoints[Pred(DY)]));
            Dec(f_CaretPoint.Y,DrawPoints[Pred(DY)]);
            DropDrawPoints;
           end;//if DY > 0 then
           Windows.InvalidateRect(Handle, @l_CR, True);
          end//if Abs(DY) < ItemOnScreen(false) then
          else
          begin
           Windows.InvalidateRect(Handle, @ClipArea, True);
           DropDrawPoints;
          end;//if Abs(DY) < ItemOnScreen(false) then
         end//if UseDrawPoints then
         else
         begin
          //ClipArea.Bottom := ClipArea.Top + ((ClipArea.Bottom - ClipArea.Top) div RowHeight) * RowHeight;
           {adjust bottom of the clipping region to an even number of rows}
          DY := SaveD - f_TopIndex;
          if CanScrollWindow AND
             (Abs(DY) < ItemOnScreen(false)) then
           {scroll the window setting up a clipping region}
          begin
           ScrollArea := ClipArea;
           l_CR := ClipArea;
           if DY > 0 then {Down}
           begin
            Dec(ScrollArea.Bottom, DY * CompleteRowHeight);
            l_CR.Bottom := l_CR.Top + DY * CompleteRowHeight;
           end
           else {Up}
           begin
            Inc(ScrollArea.Top, DY * CompleteRowHeight);
            l_CR.Top := l_CR.Bottom - DY * CompleteRowHeight;
           end;
           ShiftArea(DY * CompleteRowHeight);
           Inc(f_CaretPoint.Y, DY * CompleteRowHeight);
           Windows.InvalidateRect(Handle, @l_CR, True);
          end//if Abs(DY) < ItemOnScreen(false) then
          else
           Windows.InvalidateRect(Handle, @ClipArea, True);
         end;//if UseDrawPoints then
     end;//with ClipArea do
    end;//if SaveD <> f_TopIndex then
    {pm_SetCurrent(f_Current);}
    if (f_Current >= f_TopIndex) and (f_Current < f_TopIndex + ItemOnScreen(True)) then
     vlbDrawFocusRect(CN, f_Current);
    {notify that top index has changed}
    if SaveD <> f_TopIndex then
     DoOnTopIndexChanged(f_TopIndex);
   finally
    CN.EndPaint;
   end;{try..finally}
  end;//if (Index >= 0) and (Index <= f_HighIndex) then
 end;//if Index <> f_TopIndex then
 SetCaret;

 if NeedInitScrollInfoInvlbInitScrollInfo then
  vlbInitScrollInfo;
//#UC END# *5152BB1A0168_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbSetTopIndexPrim

procedure TvtCustomListerPrim.vlbInternalOnSelect(Sender: TObject;
 Index: LongInt;
 var Selected: Integer);
//#UC START# *5152BB7901EB_4CFFE36B00FA_var*
//#UC END# *5152BB7901EB_4CFFE36B00FA_var*
begin
//#UC START# *5152BB7901EB_4CFFE36B00FA_impl*
 if FixAnchor then
  Exit;
 if not Assigned(f_SelectArray) then
  Exit;
 f_SelectArray.ArrayCapacity := Total;
 case Index of
  vt_smAllInvert :
   f_SelectArray.AllInvert;
  vt_smAllSelect :
   begin
    {f_SelectArray.ArrayCapacity := Total;}
    if Boolean(Selected) then
     f_SelectArray.AllTrue
    else
     f_SelectArray.AllFalse;
   end;

  else
   f_SelectArray.LogArray[Index] := Boolean(Selected);
 end;
//#UC END# *5152BB7901EB_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbInternalOnSelect

procedure TvtCustomListerPrim.vlbInternalOnIsSelected(Sender: TObject;
 Index: LongInt;
 var Selected: Integer);
//#UC START# *5152BB9F03D1_4CFFE36B00FA_var*
//#UC END# *5152BB9F03D1_4CFFE36B00FA_var*
begin
//#UC START# *5152BB9F03D1_4CFFE36B00FA_impl*
 Selected := 0;
 if FixAnchor then
  Selected := Ord(Index <= f_Current)
 else
 begin
  if not Assigned(f_SelectArray) then
   Exit;
  Selected := Ord(f_SelectArray.LogArray[Index]);
 end;
//#UC END# *5152BB9F03D1_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbInternalOnIsSelected

procedure TvtCustomListerPrim.ResetSelectArray;
//#UC START# *5152BC630095_4CFFE36B00FA_var*
//#UC END# *5152BC630095_4CFFE36B00FA_var*
begin
//#UC START# *5152BC630095_4CFFE36B00FA_impl*
 if f_LockSelectChange then
 begin
  f_NeedResetSelectArray := True;
  Exit;
 end;
 if InternalSelector then
  f_SelectArray.ArrayCapacity := 0;
//#UC END# *5152BC630095_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.ResetSelectArray

procedure TvtCustomListerPrim.vlbAdjustIntegralHeight;
 {* adjust height of the list box }
//#UC START# *5152BCA30238_4CFFE36B00FA_var*
//#UC END# *5152BCA30238_4CFFE36B00FA_var*
begin
//#UC START# *5152BCA30238_4CFFE36B00FA_impl*
 if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
  if f_IntegralHeight then
   if ClientHeight mod CompleteRowHeight <> 0 then
    ClientHeight := (ClientHeight div CompleteRowHeight) * CompleteRowHeight;
//#UC END# *5152BCA30238_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbAdjustIntegralHeight

procedure TvtCustomListerPrim.vlbCalcFontFields;
 {* calculate sizes based on font selection }
//#UC START# *5152BCC300AE_4CFFE36B00FA_var*
var
 lForm    : TCustomForm;
 Alpha    : String;
 l_Canvas : Il3InfoCanvas;
//#UC END# *5152BCC300AE_4CFFE36B00FA_var*
begin
//#UC START# *5152BCC300AE_4CFFE36B00FA_impl*
 {$IfNDef DesignTimeLibrary}
 lForm := GetParentForm(Self);
 if (lForm = nil) {$IfDef l3HackedVCL}or lForm.IsRealInstance{$EndIf} then
 {$EndIf DesignTimeLibrary}
 begin
  //if not HandleAllocated then Exit;
  Alpha := GetOrphStr(SCAlphaString);

  {set the canvas Font}

  l_Canvas := l3CrtIC;
  l_Canvas.Lock;
  try
   l_Canvas.Font.AssignFont(Self.Font);
   f_FontHeight := l_Canvas.LP2DP(l_Canvas.TextExtent(l3PCharLen(GetOrphStr(SCTallLowChars)))).Y;

   if (not (csLoading in ComponentState) and f_AutoRowHeight) or (f_RowHeight = 0) then
    pm_SetRowHeight(f_FontHeight);

   {calculate the base dialog unit for tab spacing}
   f_DlgUnits := (l_Canvas.LP2DP(l_Canvas.TextExtent(l3PCharLen(Alpha))).X div Length(Alpha)) div 4;
   f_FontChanged := False;
  finally
   l_Canvas.Unlock;
  end;//try..finally
 end//(lForm <> nil) AND lForm.IsRealInstance
 {$IfNDef DesignTimeLibrary}
 else
 begin
  f_FontHeight := 10;
  if not (csLoading in ComponentState)  and f_AutoRowHeight then
   f_RowHeight := 16;
  f_DlgUnits := 10;
 end;//lForm <> nil..
 {$EndIf DesignTimeLibrary}
//#UC END# *5152BCC300AE_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbCalcFontFields

procedure TvtCustomListerPrim.vlbColorChanged(aColor: TObject);
 {* a color has changed, refresh display }
//#UC START# *5152BCD90314_4CFFE36B00FA_var*
//#UC END# *5152BCD90314_4CFFE36B00FA_var*
begin
//#UC START# *5152BCD90314_4CFFE36B00FA_impl*
 Refresh;
//#UC END# *5152BCD90314_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbColorChanged

procedure TvtCustomListerPrim.vlbDrawFocusRect(const CN: Il3Canvas;
 Index: LongInt);
 {* draw the focus rectangle }
//#UC START# *5152BD3E036D_4CFFE36B00FA_var*
var
 l_CR    : TRect;
//#UC END# *5152BD3E036D_4CFFE36B00FA_var*
begin
//#UC START# *5152BD3E036D_4CFFE36B00FA_impl*
 if (Index < 0) then
  Exit;
 if FooterSelected then
  Exit;
 if Focused then
 begin
  {Canvas.Brush.Color := clBlack;}
  SetTextColor(hDC(CN.DC), Graphics.ColorToRGB(Self.Font.Color));
  SetBkColor(hDC(CN.DC),Graphics.ColorToRGB(Color));
  SetBkMode(hDC(CN.DC), OPAQUE);  {Transparent}
  l_CR := GetDrawRect(Index);
  if l_CR.Right = 0 then
   Exit;

  Inc(l_CR.Left, GetItemTextIndent(Index, l_CR.Bottom - l_CR.Top));
  if not UseDrawPoints then
   Dec(l_CR.Bottom, InterRowIndent);

  if DrawGrid and (Index > 0) then
    Inc(l_CR.Top, 1);
  CN.Canvas.DrawFocusRect(l_CR);
 end;
//#UC END# *5152BD3E036D_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbDrawFocusRect

procedure TvtCustomListerPrim.vlbInitScrollInfo;
 {* setup scroll bar range and initial position }
//#UC START# *5152BE0A0233_4CFFE36B00FA_var*
//#UC END# *5152BE0A0233_4CFFE36B00FA_var*
begin
//#UC START# *5152BE0A0233_4CFFE36B00FA_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=476367908
 if (not f_InInitScrollInfo) then
 try
  f_InInitScrollInfo := True;
  if (not HandleAllocated) or (not IsWindow(Handle)) or
   (csDestroying in ComponentState) or (csLoading in ComponentState) then
   Exit;
  {initialize scroll bars, if any}
  DropDrawPoints;   
  vlbSetVScrollRange;
  vlbSetVScrollPos;
  vlbSetHScrollRange;
  vlbSetHScrollPos;
  //http://mdp.garant.ru/pages/viewpage.action?pageId=516166484
  InvalidateNonclientArea;
 finally
  f_InInitScrollInfo := False;
 end;
//#UC END# *5152BE0A0233_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbInitScrollInfo

procedure TvtCustomListerPrim.vlbSetEasyCurrent(aIndex: LongInt);
//#UC START# *5152BE58003E_4CFFE36B00FA_var*
var
  lOldCur : LongInt;
  I      : LongInt;

 procedure ValidateIndex(var aIndex : LongInt);
 begin
  if aIndex < 0 then
   aIndex := -1
  else
  if aIndex > f_HighIndex then
   if f_HighIndex < 0
    then aIndex := -1
    else aIndex := f_HighIndex;
 end;
//#UC END# *5152BE58003E_4CFFE36B00FA_var*
begin
//#UC START# *5152BE58003E_4CFFE36B00FA_impl*
 {verify valid index}
 ValidateIndex(aIndex);
 DoValidateCurrent(aIndex);
 ValidateIndex(aIndex);

 DropFooterSelection;

 if aIndex <> f_Current then
 begin
  lOldCur := f_Current;
  f_Current := aIndex;
  DoCurrentChanged(f_Current, lOldCur);

  if FixAnchor then
   for I := Min(lOldCur,f_Current) to Max(lOldCur,f_Current) do
    InvalidateItem(I)
  else
  begin
   InvalidateItem(lOldCur);
   InvalidateItem(f_Current);
  end;
 end;
//#UC END# *5152BE58003E_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbSetEasyCurrent

procedure TvtCustomListerPrim.vlbSetHScrollPos;
 {* set the horizontal scroll position }
//#UC START# *5152BEEF0105_4CFFE36B00FA_var*
//#UC END# *5152BEEF0105_4CFFE36B00FA_var*
begin
//#UC START# *5152BEEF0105_4CFFE36B00FA_impl*
 if ScrollStyle in [ssHorizontal, ssBoth] then
  if InUpdating or f_InScroll then
  begin
   if not (vt_ufHPos in f_UpdateFlags) then
   begin
    Include(f_UpdateFlags, vt_ufHPos);
    PostMessage(Handle, msg_vtUpdateScroll, 0, 0);
   end;
  end else
  begin
   Exclude(f_UpdateFlags, vt_ufHPos);
   SetScrollPos(Handle, SB_HORZ, f_HDelta, true);
  end;
//#UC END# *5152BEEF0105_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbSetHScrollPos

procedure TvtCustomListerPrim.vlbSetHScrollRange;
 {* set the horizontal scroll range }
//#UC START# *5152BF0B00CA_4CFFE36B00FA_var*
var
 l_IsVisible: Boolean;
//#UC END# *5152BF0B00CA_4CFFE36B00FA_var*
begin
//#UC START# *5152BF0B00CA_4CFFE36B00FA_impl*
 if ScrollStyle in [ssHorizontal, ssBoth] then
  if InUpdating or f_InScroll then
  begin
   if not (vt_ufHInfo in f_UpdateFlags) then
   begin
    Include(f_UpdateFlags, vt_ufHInfo);
    PostMessage(Handle, msg_vtUpdateScroll, 0, 0);
   end;
  end else
  begin
   Exclude(f_UpdateFlags, vt_ufHInfo);
   l_IsVisible := IsHScrollVisible;
   SetScrollRange(Handle, SB_HORZ, 0, f_Columns, true);
   if IsHScrollVisible <> l_IsVisible then
    DoHScrollVisibleChanged;
  end;
//#UC END# *5152BF0B00CA_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbSetHScrollRange

procedure TvtCustomListerPrim.vlbSetVScrollRange;
 {* set the vertical scroll range }
//#UC START# *5152BF9202DD_4CFFE36B00FA_var*
var
 l_ScrollInfo : TScrollInfo;
 l_PageSize   : Word;
 l_MaxTop     : Integer;
 l_IsVisible  : Boolean;
//#UC END# *5152BF9202DD_4CFFE36B00FA_var*
begin
//#UC START# *5152BF9202DD_4CFFE36B00FA_impl*
 if ScrollStyle in [ssVertical, ssBoth] then
  if InUpdating or f_InScroll then
  begin
   if not (vt_ufVInfo in f_UpdateFlags) then
   begin
    Include(f_UpdateFlags, vt_ufVInfo);
    PostMessage(Handle, msg_vtUpdateScroll, 0, 0);
   end;
  end//if InUpdating or f_InScroll then
  else
  begin
   Exclude(f_UpdateFlags, vt_ufVInfo);
   //if f_MultiStrokeItem
   // then l_MaxTop := CalcTopIndex(f_Total-1)
   // else l_MaxTop := f_Total-1; // - f_Rows;

   l_MaxTop := Pred(f_Total);
   if l_MaxTop < 0 then l_MaxTop := 0;
   if ClientHeight <= 0 then l_MaxTop := 0;    //http://mdp.garant.ru/pages/viewpage.action?pageId=297699119

   l_PageSize := Max(ItemOnScreen(True), 1);

   with l_ScrollInfo do
   begin
    cbSize := SizeOf(l_ScrollInfo);
    fMask := SIF_PAGE or SIF_RANGE;
    nMin := 0;
    nMax := l_MaxTop;
    nPage := l_PageSize;
    //nPos: Integer;
   end;//with l_ScrollInfo

   l_IsVisible := IsVScrollVisible or f_VScrollPersistent;

   //При уменьшении ширины, может возникать такая ситуация, когда
   //l_MaxTop = 1, l_PageSize = 1, и, хотя показывается далеко не все,
   //скроллбар пропадает.
   //http://mdp.garant.ru/pages/viewpage.action?pageId=508187704
   f_VScrollPersistent := f_MultiStrokeItem and (ItemOnScreen(True) < f_Total);
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=520250812

   //http://mdp.garant.ru/pages/viewpage.action?pageId=476367908
   if f_VScrollPersistent then
    l_ScrollInfo.fMask := l_ScrollInfo.fMask or SIF_DISABLENOSCROLL;
   SetScrollInfo(Handle, SB_VERT, l_ScrollInfo, True);

   f_LastPageSize := l_PageSize;

   // http://mdp.garant.ru/pages/viewpage.action?pageId=248195850
   if (l_IsVisible <> IsVScrollVisible) and (not f_VScrollPersistent) then
    DoVScrollVisibleChanged;
  end;//if InUpdating or f_InScroll then
//#UC END# *5152BF9202DD_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbSetVScrollRange

procedure TvtCustomListerPrim.vlbValidateItem(Index: LongInt);
 {* validate the area for this item }
//#UC START# *5152BFD20006_4CFFE36B00FA_var*
var
 l_CR : TRect;
//#UC END# *5152BFD20006_4CFFE36B00FA_var*
begin
//#UC START# *5152BFD20006_4CFFE36B00FA_impl*
 if (Index >= f_TopIndex) and (Index - f_TopIndex < ItemOnScreen(false)) then
 begin
  l_CR := GetDrawRect(Index);
  ValidateRect(Handle, @l_CR);
 end;
//#UC END# *5152BFD20006_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbValidateItem

procedure TvtCustomListerPrim.vlbSetCurrentPrim(aIndex: LongInt;
 aNeedValidation: Boolean = True);
//#UC START# *5152C00F0342_4CFFE36B00FA_var*
 procedure ValidateIndex(var aIndex : LongInt);
  begin
   if Total = 0 then
    aIndex := -1
   else
    if aIndex < 0 then
    begin
     if not AllowWithoutCurrent or (aIndex <> -1) then
      aIndex := 0;
    end
    else
     if aIndex > f_HighIndex then
      if f_HighIndex < 0 then
       aIndex := -1
      else
       aIndex := f_HighIndex;
  end;
var
 lOldCur : LongInt;
 I       : LongInt;
//#UC END# *5152C00F0342_4CFFE36B00FA_var*
begin
//#UC START# *5152C00F0342_4CFFE36B00FA_impl*
 if aNeedValidation then
 begin
  {verify valid index}
  ValidateIndex(aIndex);
  DoValidateCurrent(aIndex);
  ValidateIndex(aIndex);
 end;

 DropFooterSelection;

 {do we need to do any more}
 if (aIndex = f_Current) then
 begin
  //если ткнули в текущий, а он не выделен, то надо выделить
  if (f_Current >= 0) and (total > 0) and not (PickedList or Selected[f_Current]) and not f_LockSelectChange then
   Selected[f_Current] := True;
  Exit;
 end;

 {erase current selection}
{  InvalidateItem(f_Current); }

 if (f_Current >= 0) and not (PickedList or
    (f_MultiSelect and not ((SelectedCount = 1) and Selected[f_Current]))) then
  Selected[f_Current] := False;

 {set the newly selected item index}
 if f_Current >= f_Total then f_Current := -1;

 lOldCur := f_Current;
 f_Current := aIndex;

 if not (PickedList and f_MultiSelect) and not f_LockSelectChange then Selected[f_Current] := True;

 if FixAnchor then
 begin
  for I := Min(lOldCur,f_Current) to Max(lOldCur,f_Current) do
   DrawItem(I);
 end
 else
 begin
  if (lOldCur >= 0) and (lOldCur <= f_HighIndex) then InvalidateItem(lOldCur);
  InvalidateItem(f_Current);
  f_Anchor := f_Current;
 end;

 DoCurrentChanged(f_Current, lOldCur);

 if (f_InQuickSearch = 0) then SearchStr := '';

 if csDesigning in ComponentState then
  Exit;
//#UC END# *5152C00F0342_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbSetCurrentPrim

procedure TvtCustomListerPrim.vlbProcessingChar(const aMsg: TWMChar);
 {* processing new pressed char }
//#UC START# *5152C04F0258_4CFFE36B00FA_var*
 procedure lAddCharToSearchStr(Ch : Char);
 begin
  if Ch = #8 {BackSpace} then
  begin
   if Length(f_SearchStr) > 0 then
    System.Delete(f_SearchStr, Length(f_SearchStr),1)
  end
  else
   f_SearchStr := f_SearchStr + Ch;
 end;

 function lFindIndexBySearchStr : LongInt;
 begin
  Result := f_Current;
  if not Assigned(f_OnCharToItem) then
   Exit;

  if Length(f_SearchStr) = 0 then
   Result := -1
  else
  begin
   f_OnCharToItem(Self, f_SearchStr, true, Result);
   if Result = -1 then
    f_OnCharToItem(Self, f_SearchStr, False, Result);
  end;
  if Result = -1 then
   f_SearchStr := '';
 end;

var
 lNewCurrent : LongInt;
//#UC END# *5152C04F0258_4CFFE36B00FA_var*
begin
//#UC START# *5152C04F0258_4CFFE36B00FA_impl*
 lAddCharToSearchStr(Char(aMsg.CharCode));

 if f_InQuickSearch > 0 then
 begin
  f_NeedQuickSearch := True;
  Exit;
 end;

 repeat
  f_NeedQuickSearch := False;
  Inc(f_InQuickSearch);
  try
   lNewCurrent := lFindIndexBySearchStr;
   SetSearchStrPrim(f_SearchStr);

   try
    if (lNewCurrent = Current) then
     SetCaret
    else
     if (lNewCurrent >= 0) and (lNewCurrent <= f_HighIndex) then
      pm_SetCurrent(lNewCurrent);
   finally
    if Assigned(f_OnQuickSearchStrChanged) then
     f_OnQuickSearchStrChanged(Self, f_SearchStr);
   end;
  finally
   Dec(f_InQuickSearch);
  end;
 until not f_NeedQuickSearch;
//#UC END# *5152C04F0258_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbProcessingChar

function TvtCustomListerPrim.vlbItemHitTest(aIndex: Integer;
 const aPt: TPoint;
 fromScreen: Boolean = False): Byte;
//#UC START# *5152C09F00DB_4CFFE36B00FA_var*
var
 l_Pt : TPoint;
//#UC END# *5152C09F00DB_4CFFE36B00FA_var*
begin
//#UC START# *5152C09F00DB_4CFFE36B00FA_impl*
 if fromScreen then
  l_Pt := ScreenToClient(aPt)
 else
  l_Pt := aPt;
 Result := ihtText;
 if PickedList and
    (l_Pt.X >= (RowHeight div 4)) and
    (l_Pt.X <= (PickImages.Width + RowHeight div 4)) then
  Result := ihtPickIcon;
//#UC END# *5152C09F00DB_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbItemHitTest

procedure TvtCustomListerPrim.SetCursorForItem(anIndex: Integer);
//#UC START# *5152C10E027B_4CFFE36B00FA_var*
//#UC END# *5152C10E027B_4CFFE36B00FA_var*
begin
//#UC START# *5152C10E027B_4CFFE36B00FA_impl*
// DoNothing;
//#UC END# *5152C10E027B_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.SetCursorForItem

function TvtCustomListerPrim.GetDragAndDropSupported: Boolean;
//#UC START# *5152C16A028F_4CFFE36B00FA_var*
//#UC END# *5152C16A028F_4CFFE36B00FA_var*
begin
//#UC START# *5152C16A028F_4CFFE36B00FA_impl*
 Result := False;
//#UC END# *5152C16A028F_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetDragAndDropSupported

procedure TvtCustomListerPrim.TryDragAndDrop(aNodeIndex: Integer;
 aKey: Integer);
//#UC START# *5152C18C00BA_4CFFE36B00FA_var*
//#UC END# *5152C18C00BA_4CFFE36B00FA_var*
begin
//#UC START# *5152C18C00BA_4CFFE36B00FA_impl*
// nop
//#UC END# *5152C18C00BA_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.TryDragAndDrop

function TvtCustomListerPrim.DoOnGetItem(Index: LongInt): Il3CString;
//#UC START# *5152C3EC011B_4CFFE36B00FA_var*
var
 l_S : PAnsiChar;
//#UC END# *5152C3EC011B_4CFFE36B00FA_var*
begin
//#UC START# *5152C3EC011B_4CFFE36B00FA_impl*
 Result := nil;
 if Assigned(f_OnGetPCharItem) then
 begin
  l_S := nil;
  f_OnGetPCharItem(Self, Index, l_S);
  Result := l3CStr(l_S);
 end//Assigned(f_OnGetPCharItem)
 else
 begin
  if Assigned(f_OnGetStrItem) then
   f_OnGetStrItem(Self, Index, Result)
  else
  if (csDesigning in ComponentState) then
   Result := l3Fmt(GetOrphStr(SCSampleListItem), [Index])
  else
   Result := l3Fmt(GetOrphStr(SCGotItemWarning), [Index]);
 end;//Assigned(f_OnGetPCharItem)
//#UC END# *5152C3EC011B_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItem

function TvtCustomListerPrim.DoOnGetItemPainter(Index: LongInt): Il3NodePainter;
//#UC START# *5152C4DD0360_4CFFE36B00FA_var*
//#UC END# *5152C4DD0360_4CFFE36B00FA_var*
begin
//#UC START# *5152C4DD0360_4CFFE36B00FA_impl*
 if Assigned(f_OnGetItemPainter) then
  Result := f_OnGetItemPainter(Self, Index)
 else
  Result := nil;
//#UC END# *5152C4DD0360_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItemPainter

function TvtCustomListerPrim.DoOnGetItemImageIndex(aItemIndex: LongInt): Integer;
//#UC START# *5152C50900E5_4CFFE36B00FA_var*
//#UC END# *5152C50900E5_4CFFE36B00FA_var*
begin
//#UC START# *5152C50900E5_4CFFE36B00FA_impl*
 Result := -1;
 if Assigned(f_OnGetItemImageIndex) then
  Result := f_OnGetItemImageIndex(Self, aItemIndex);
//#UC END# *5152C50900E5_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItemImageIndex

procedure TvtCustomListerPrim.DoOnGetItemImageOverlays(aIndex: Integer;
 var theOverlays: TOverlayIndexArray);
//#UC START# *5152C53400B7_4CFFE36B00FA_var*
//#UC END# *5152C53400B7_4CFFE36B00FA_var*
begin
//#UC START# *5152C53400B7_4CFFE36B00FA_impl*
 SetLength(theOverlays, 0);
 if Assigned(f_OnGetItemImageOverlays) then
  f_OnGetItemImageOverlays(Self, aIndex, theOverlays);
//#UC END# *5152C53400B7_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItemImageOverlays

function TvtCustomListerPrim.DoOnGetItemPickImage(aItemIndex: LongInt;
 var aImages: TCustomImageList): Integer;
//#UC START# *5152C5EF02BC_4CFFE36B00FA_var*
//#UC END# *5152C5EF02BC_4CFFE36B00FA_var*
begin
//#UC START# *5152C5EF02BC_4CFFE36B00FA_impl*
 aImages := vtResources.Images;
 if aItemIndex < 0 then // Index не спрашивали
  Result := -1
 else
  Result := vt_imgListUnCheck + Ord(DoOnIsSelected(aItemIndex)) + vt_PickIconCnt*Ord(l3CRTIC.NearestColor(Color) = clWhite);

 if Assigned(f_OnGetItemPickImage) then
  f_OnGetItemPickImage(Self, aItemIndex, aImages, Result);
//#UC END# *5152C5EF02BC_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItemPickImage

function TvtCustomListerPrim.DoOnGetItemIconHint(aItemIndex: LongInt): Il3CString;
//#UC START# *5152C61C02CD_4CFFE36B00FA_var*
//#UC END# *5152C61C02CD_4CFFE36B00FA_var*
begin
//#UC START# *5152C61C02CD_4CFFE36B00FA_impl*
 if Assigned(f_OnGetItemIconHint) then
  Result := f_OnGetItemIconHint(Self, aItemIndex)
 else
  Result := nil;
//#UC END# *5152C61C02CD_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItemIconHint

function TvtCustomListerPrim.DoOnGetItemTextHint(aIndex: Integer): Il3CString;
//#UC START# *5152C6E20282_4CFFE36B00FA_var*
//#UC END# *5152C6E20282_4CFFE36B00FA_var*
begin
//#UC START# *5152C6E20282_4CFFE36B00FA_impl*
 if Assigned(f_OnGetItemTextHint) then
  Result := f_OnGetItemTextHint(Self, aIndex)
 else
  Result := nil;
//#UC END# *5152C6E20282_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItemTextHint

function TvtCustomListerPrim.PickImages: TCustomImageList;
//#UC START# *5152C708009F_4CFFE36B00FA_var*
//#UC END# *5152C708009F_4CFFE36B00FA_var*
begin
//#UC START# *5152C708009F_4CFFE36B00FA_impl*
 DoOnGetItemPickImage(-1, Result);
//#UC END# *5152C708009F_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.PickImages

procedure TvtCustomListerPrim.DoOnGetItemColor(Index: LongInt;
 var FG: TColor;
 var BG: TColor);
//#UC START# *5152C79F0258_4CFFE36B00FA_var*
//#UC END# *5152C79F0258_4CFFE36B00FA_var*
begin
//#UC START# *5152C79F0258_4CFFE36B00FA_impl*
 if Assigned(f_OnGetItemColor) then
  f_OnGetItemColor(Self, Index, FG, BG);
//#UC END# *5152C79F0258_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItemColor

procedure TvtCustomListerPrim.DoOnGetItemFont(Index: LongInt;
 const aFont: Il3Font;
 anItemPart: TvtListerItemPart);
//#UC START# *5152C7D50201_4CFFE36B00FA_var*
//#UC END# *5152C7D50201_4CFFE36B00FA_var*
begin
//#UC START# *5152C7D50201_4CFFE36B00FA_impl*
 if Assigned(f_OnGetItemFont) then
  f_OnGetItemFont(Self, Index, aFont);
//#UC END# *5152C7D50201_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItemFont

function TvtCustomListerPrim.DoOnGetItemStatus(Index: LongInt): Boolean;
//#UC START# *5152C7FE031B_4CFFE36B00FA_var*
//#UC END# *5152C7FE031B_4CFFE36B00FA_var*
begin
//#UC START# *5152C7FE031B_4CFFE36B00FA_impl*
 Result := False;
 if Assigned(f_OnGetItemStatus) then
  f_OnGetItemStatus(Self, Index, Result);
//#UC END# *5152C7FE031B_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnGetItemStatus

function TvtCustomListerPrim.DoOnIsSelected(Index: LongInt): Integer;
//#UC START# *5152C8300174_4CFFE36B00FA_var*
//#UC END# *5152C8300174_4CFFE36B00FA_var*
begin
//#UC START# *5152C8300174_4CFFE36B00FA_impl*
 if csDesigning in ComponentState then
  Result := Ord(Index = 0)
 else
 begin
  Result := Ord(Index = f_Current);
  if f_MultiSelect and Assigned(f_OnIsSelected) then
   f_OnIsSelected(Self, Index, Result);
 end;
//#UC END# *5152C8300174_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnIsSelected

procedure TvtCustomListerPrim.DoOnSelect(Index: LongInt;
 aValue: Integer);
//#UC START# *5152C85403DA_4CFFE36B00FA_var*
//#UC END# *5152C85403DA_4CFFE36B00FA_var*
begin
//#UC START# *5152C85403DA_4CFFE36B00FA_impl*
  if (csDesigning in ComponentState) or ReadOnly then
   Exit;
  if f_MultiSelect then
  begin
   if Assigned(f_OnSelect) then
   begin
    if aValue = -1 then
    begin
     aValue := Succ(SelectState[Index]);
     if aValue > Succ(Ord(TriplePicked)) then aValue := 0;
    end;

    {select if not protected - deselect always}
    if (aValue = 0) or (not DoOnGetItemStatus(Index)) then
    begin
     if Assigned(f_OnSelectChange) then
     begin
      f_OnSelectChange(Self,Index, aValue);
      if aValue < 0 then
       Exit;
     end;
     f_OnSelect(Self, Index, aValue);
     InvalidateItem(Index);
     if Assigned(f_OnSelectChanged) then f_OnSelectChanged(Self,Index, aValue);
    end;
   end else
    raise EOnSelectNotAssigned.Create;
  end;
//#UC END# *5152C85403DA_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnSelect

procedure TvtCustomListerPrim.DoOnSelectOutRange(First: LongInt;
 Last: LongInt;
 aSelectState: Integer);
//#UC START# *5152C88400DC_4CFFE36B00FA_var*
var
 l_I : LongInt;
//#UC END# *5152C88400DC_4CFFE36B00FA_var*
begin
//#UC START# *5152C88400DC_4CFFE36B00FA_impl*
 if ReadOnly or FixAnchor then
  Exit;
 if InternalSelector then
 begin
  if not Assigned(f_SelectArray) then
   Exit;
  f_SelectArray.ArrayCapacity := Total;
  if not PickedList then f_SelectArray.AllFalse;
  if aSelectState <> 0
   then f_SelectArray.SetInterval(First, Last, smSet)
   else f_SelectArray.SetInterval(First, Last, smReset);
 end else
 begin
  if First > Last then
  begin
   l_I := First;
   First := Last;
   Last := l_I;
   //Dec(Last);
  end;
  //else
  // Inc(First);

  if First < 0 then
   First := 0;
  if Last > f_HighIndex then
   Last := f_HighIndex;

  if not PickedList then
  begin
   for l_I := 0 to Pred(First) do
    Selected[l_I] := (aSelectState = 0);
   for l_I := Succ(Last) to f_HighIndex do
    Selected[l_I] := (aSelectState = 0);
  end;
  for l_I := First to Last do
   SelectState[l_I] := aSelectState;
 end;
//#UC END# *5152C88400DC_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnSelectOutRange

procedure TvtCustomListerPrim.DoOnTopIndexChanged(NewTopIndex: LongInt);
//#UC START# *5152C8B801C9_4CFFE36B00FA_var*
//#UC END# *5152C8B801C9_4CFFE36B00FA_var*
begin
//#UC START# *5152C8B801C9_4CFFE36B00FA_impl*
 if Assigned(f_OnTopIndexChanged) then
  f_OnTopIndexChanged(Self, NewTopIndex);
//#UC END# *5152C8B801C9_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnTopIndexChanged

function TvtCustomListerPrim.DoDoProcessCommand(Cmd: Tl3OperationCode): Boolean;
//#UC START# *5152C93400EB_4CFFE36B00FA_var*
 procedure NormalCurrent(var Index : LongInt);
 begin//NormalCurrent
  if Index < 0 then
   Index := 0;
  if Index > f_HighIndex then
   Index := f_HighIndex;
 end;//NormalCurrent
var
 l_I : LongInt;
//#UC END# *5152C93400EB_4CFFE36B00FA_var*
begin
//#UC START# *5152C93400EB_4CFFE36B00FA_impl*
 Result := inherited DoProcessCommand(Cmd, false, 1);
 if not Result AND (Cmd <> ccNone) then
 begin
  Result := true;
  case Cmd of
   ccLeft :
     if ScrollStyle in [ssHorizontal, ssBoth] then
     begin
      if f_HDelta > 0 then
      begin
       Dec(f_HDelta);
       vlbSetHScrollPos;
       Refresh;
      end;
     end else
     begin
      if f_Current > 0 then
      begin
       //if not PickedList then vlbDeselectAllItems;
       pm_SetCurrent(Pred(f_Current));
       if not FixAnchor then f_Anchor := f_Current;
      end;
     end;

   ccRight :
     if ScrollStyle in [ssHorizontal, ssBoth] then
     begin
      if f_HDelta < f_Columns then
      begin
       Inc(f_HDelta);
       vlbSetHScrollPos;
       Refresh;
      end;
     end else
     begin
      if f_Current < f_HighIndex then
      begin
       //if not PickedList then vlbDeselectAllItems;
       pm_SetCurrent(Succ(f_Current));
       if not FixAnchor then f_Anchor := f_Current;
      end;
     end;

   ccUp :
     if FooterSelected then
      FooterSelected := False
     else
     if (f_Current > 0) then
     begin
      //if not PickedList then  vlbDeselectAllItems;
      pm_SetCurrent(Pred(f_Current));
      {if not PickedList and f_MultiSelect then DoOnSelect(f_Current, True);}
      if not FixAnchor then f_Anchor := f_Current;
      //Refresh; //Perform(WM_PAINT,0,0);
     end else
     if AllowWithoutCurrent then
     begin
      if f_Current = 0 then
      begin
       //if not PickedList then  vlbDeselectAllItems;
       pm_SetCurrent(-1);
       {if not PickedList and f_MultiSelect then DoOnSelect(f_Current, True);}
       if not FixAnchor then f_Anchor := f_Current;
       //Refresh; //Perform(WM_PAINT,0,0);
      end else
      if f_Current = -1 then
      begin
       //if not PickedList then  vlbDeselectAllItems;
       pm_SetCurrent(f_HighIndex);
       {if not PickedList and f_MultiSelect then DoOnSelect(f_Current, True);}
       if not FixAnchor then f_Anchor := f_Current;
       //Refresh; //Perform(WM_PAINT,0,0);
      end;
     end;

   ccExtendUp :
     if f_MultiSelect then
      begin
       l_I := f_Current-1;
       SelectItems(l_I);
      end;

   ccDown :
     if f_Current < f_HighIndex then
     begin
      //if not PickedList then vlbDeselectAllItems;
      pm_SetCurrent(Succ(f_Current));
      {if not PickedList and f_MultiSelect then DoOnSelect(f_Current, True);}
      if not FixAnchor then f_Anchor := f_Current;

      //Refresh; //Perform(WM_PAINT,0,0);
     end else
     if AllowWithoutCurrent then
     begin
      if (f_Current = f_HighIndex) then
      begin
       //if not PickedList then vlbDeselectAllItems;
       pm_SetCurrent(-1);
       {if not PickedList and f_MultiSelect then DoOnSelect(f_Current, True);}
       if not FixAnchor then f_Anchor := f_Current;

       //Refresh; //Perform(WM_PAINT,0,0);
      end else
      if (f_Current = -1) then
      begin
       //if not PickedList then vlbDeselectAllItems;
       pm_SetCurrent(0);
       {if not PickedList and f_MultiSelect then DoOnSelect(f_Current, True);}
       if not FixAnchor then f_Anchor := f_Current;

       //Refresh; //Perform(WM_PAINT,0,0);
      end;
     end else
     if (f_Current = f_HighIndex) and FooterVisible then
      FooterSelected := True;

   ccExtendDown :
     if f_MultiSelect then
      begin
       l_I := f_Current + 1;
       SelectItems(l_I);
      end;

   ccHome :
     begin
      if f_Current <> 0 then
       begin
        //if not PickedList then vlbDeselectAllItems;
        pm_SetCurrent(0);
        if not FixAnchor then f_Anchor := f_Current;
       end;
      DropFooterSelection;
     end;
   ccExtendHome :
     begin
      if f_MultiSelect then
       if f_Current > 0 then
         SelectItems(0);
      DropFooterSelection;
     end;
   ccEnd :
     begin
      if (f_Total > 0) and (f_Current <> f_HighIndex) then
       begin
        //if not PickedList then vlbDeselectAllItems;
        pm_SetCurrent(f_HighIndex);
        if not FixAnchor then f_Anchor := f_Current;
       end;
      DropFooterSelection;
     end;

   ccExtendEnd :
     begin
      if f_MultiSelect then
       if f_Current < f_HighIndex then
         SelectItems(f_HighIndex);
      DropFooterSelection;
     end;

   ccPrevPage :
     if f_Total > 0
      then
       begin
        if ItemOnScreen(True) = 1
         then l_I := Pred(f_Current)
         else l_I := f_Current-(ItemOnScreen(True)-1);
        NormalCurrent(l_I);
        if l_I <> f_Current then
         begin
          //if not PickedList then vlbDeselectAllItems;
          pm_SetCurrent(l_I);
          if not FixAnchor then f_Anchor := f_Current;
         end;
        DropFooterSelection;
       end;
   ccExtendPgUp :
     if f_MultiSelect then
      begin
       l_I := f_Current-(ItemOnScreen(True)-1);
       SelectItems(l_I);
      end;

   ccNextPage :
     if f_Total > 0 then
      begin
       if ItemOnScreen(True) = 1
        then l_I := ItemOnScreen(True) + 1
        else l_I := f_Current + (ItemOnScreen(True)-1);

       NormalCurrent(l_I);
       if l_I <> f_Current then
        begin
         //if not PickedList then vlbDeselectAllItems;
         pm_SetCurrent(l_I);
         if not FixAnchor then f_Anchor := f_Current;
        end;
       DropFooterSelection;
      end;

   ccExtendPgDn :
     if f_MultiSelect then
      begin
       l_I := f_Current + Pred(ItemOnScreen(True));
       SelectItems(l_I);
      end;

   ccSelect:
   begin
    if Assigned(f_OnToggleSelection) then
    begin
     if f_OnToggleSelection(Self, f_Current) then
      vlbToggleSelection(f_Current);
    end//Assigned(f_OnToggleSelection)
    else
     vlbToggleSelection(f_Current);
   end;//ccSelect
   ccAllSelect    : vlbSelectAllItems;
   ccAllDeselect  : vlbDeselectAllItems;
   ccAllInvSelect : vlbInvertAllItemsPrim;

   ccActionItem   :
    if FooterSelected then
     DoFooterClick
    else
     DoOnActionElement(f_Current);
   else
   begin
    {do user command notification for user commands}
    Result := DoOnUserCommand(Cmd);
   end;//else
  end;//case Cmd
 end;//not Result AND (Cmd <> ccNone)
//#UC END# *5152C93400EB_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoDoProcessCommand

function TvtCustomListerPrim.DoIsCommandProcessed(Cmd: Tl3OperationCode): Boolean;
//#UC START# *5152C9900153_4CFFE36B00FA_var*
//#UC END# *5152C9900153_4CFFE36B00FA_var*
begin
//#UC START# *5152C9900153_4CFFE36B00FA_impl*
 if Assigned(f_OnIsCommandProcessed) then
  Result := f_OnIsCommandProcessed(Self, Cmd)
 else
  Result := True;
//#UC END# *5152C9900153_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoIsCommandProcessed

function TvtCustomListerPrim.DoOnUserCommand(Command: Tl3OperationCode): Boolean;
//#UC START# *5152CA11018D_4CFFE36B00FA_var*
//#UC END# *5152CA11018D_4CFFE36B00FA_var*
begin
//#UC START# *5152CA11018D_4CFFE36B00FA_impl*
 Result := Assigned(f_OnUserCommand) and f_OnUserCommand(Self, Command);
//#UC END# *5152CA11018D_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoOnUserCommand

procedure TvtCustomListerPrim.DoCurrentChanged(aNewCurrent: LongInt;
 aOldCurrent: LongInt);
//#UC START# *5152CA8601A6_4CFFE36B00FA_var*
//#UC END# *5152CA8601A6_4CFFE36B00FA_var*
begin
//#UC START# *5152CA8601A6_4CFFE36B00FA_impl*
 if (csDestroying in ComponentState) or IsInChange then
  Exit;
 if (aNewCurrent >= -1) then
  CallCurrentChanged(aNewCurrent, aOldCurrent);
//#UC END# *5152CA8601A6_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoCurrentChanged

procedure TvtCustomListerPrim.DoValidateCurrent(var aIndex: LongInt);
//#UC START# *5152CBED028E_4CFFE36B00FA_var*
//#UC END# *5152CBED028E_4CFFE36B00FA_var*
begin
//#UC START# *5152CBED028E_4CFFE36B00FA_impl*
 if Assigned(f_OnValidateCurrent) then
  f_OnValidateCurrent(Self, aIndex);
//#UC END# *5152CBED028E_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoValidateCurrent

procedure TvtCustomListerPrim.CallCurrentChanged(aNewCurrent: LongInt;
 aOldCurrent: LongInt);
//#UC START# *5152CC6A0355_4CFFE36B00FA_var*
//#UC END# *5152CC6A0355_4CFFE36B00FA_var*
begin
//#UC START# *5152CC6A0355_4CFFE36B00FA_impl*
 if ((aNewCurrent > -1) or NotifyIfNewCurrentEmpty) then
  if Assigned(f_OnCurrentChanged) then
   f_OnCurrentChanged(Self, aNewCurrent, aOldCurrent);
//#UC END# *5152CC6A0355_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CallCurrentChanged

procedure TvtCustomListerPrim.DoCountChanged(aCount: LongInt);
//#UC START# *5152CCBA007C_4CFFE36B00FA_var*
//#UC END# *5152CCBA007C_4CFFE36B00FA_var*
begin
//#UC START# *5152CCBA007C_4CFFE36B00FA_impl*
 if csDestroying in ComponentState then
  Exit;
 if Assigned(f_OnCountChanged) then
  f_OnCountChanged(Self, aCount);
 DoCurrentChanged(f_Current, f_Current);
//#UC END# *5152CCBA007C_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoCountChanged

procedure TvtCustomListerPrim.RepaintSelected(Smart: Boolean);
//#UC START# *5152CE16029D_4CFFE36B00FA_var*
var
 Last, l_I : LongInt;
//#UC END# *5152CE16029D_4CFFE36B00FA_var*
begin
//#UC START# *5152CE16029D_4CFFE36B00FA_impl*
 if Smart and
    (f_SelectColor.BackColor = f_SelectNonFocusColor.BackColor) and
    (f_SelectColor.TextColor = f_SelectNonFocusColor.TextColor) then
  Exit;

 if not MultiSelect or f_PickedList
  then DrawItem(f_Current)
  else
 begin
  Last := ItemOnScreen(False);
  if Last > f_Total then Last := f_Total;
  for l_I := 0 to Pred(Last) do
   if Selected[f_TopIndex + l_I] then DrawItem(f_TopIndex + l_I);
 end;
//#UC END# *5152CE16029D_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.RepaintSelected

function TvtCustomListerPrim.GetHint(anIndex: Integer): Il3CString;
//#UC START# *5152CE76012B_4CFFE36B00FA_var*
//#UC END# *5152CE76012B_4CFFE36B00FA_var*
begin
//#UC START# *5152CE76012B_4CFFE36B00FA_impl*
 Result := DoOnGetItem(anIndex);
//#UC END# *5152CE76012B_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetHint

procedure TvtCustomListerPrim.HeaderSizedProc(Sender: TObject;
 ASection: Integer;
 AWidth: Integer);
//#UC START# *5152CEB2008B_4CFFE36B00FA_var*
//#UC END# *5152CEB2008B_4CFFE36B00FA_var*
begin
//#UC START# *5152CEB2008B_4CFFE36B00FA_impl*
 FullRedraw;
//#UC END# *5152CEB2008B_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.HeaderSizedProc

procedure TvtCustomListerPrim.ImagesChanged(Sender: TObject);
//#UC START# *5152CF3902E9_4CFFE36B00FA_var*
//#UC END# *5152CF3902E9_4CFFE36B00FA_var*
begin
//#UC START# *5152CF3902E9_4CFFE36B00FA_impl*
 if Assigned(f_Images) and f_AutoRowHeight then
   pm_SetRowHeight(f_Images.Height);
 Invalidate;
//#UC END# *5152CF3902E9_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.ImagesChanged

function TvtCustomListerPrim.UseDrawPoints: Boolean;
//#UC START# *5152CFA002C3_4CFFE36B00FA_var*
//#UC END# *5152CFA002C3_4CFFE36B00FA_var*
begin
//#UC START# *5152CFA002C3_4CFFE36B00FA_impl*
 Result := f_MultiStrokeItem or Assigned(f_OnGetItemPainter);
//#UC END# *5152CFA002C3_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.UseDrawPoints

function TvtCustomListerPrim.CalcInterRowIndent: Integer;
//#UC START# *515584020214_4CFFE36B00FA_var*
//#UC END# *515584020214_4CFFE36B00FA_var*
begin
//#UC START# *515584020214_4CFFE36B00FA_impl*
 Result := f_RowHeight div 3;
//#UC END# *515584020214_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CalcInterRowIndent

procedure TvtCustomListerPrim.SelectItems(aFinish: Integer);
 {* Создавалась, как ручка для тестов, но немного обобщает логику выделения }
//#UC START# *515584B701A0_4CFFE36B00FA_var*
//#UC END# *515584B701A0_4CFFE36B00FA_var*
begin
//#UC START# *515584B701A0_4CFFE36B00FA_impl*
 vlbNewActiveItem(aFinish);
 vlbExtendSelection(aFinish);
//#UC END# *515584B701A0_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.SelectItems

procedure TvtCustomListerPrim.BeginUpdate;
//#UC START# *515584E8015F_4CFFE36B00FA_var*
//#UC END# *515584E8015F_4CFFE36B00FA_var*
begin
//#UC START# *515584E8015F_4CFFE36B00FA_impl*
 f_Updating := True;
//#UC END# *515584E8015F_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.BeginUpdate

procedure TvtCustomListerPrim.EndUpdate;
//#UC START# *515584F20246_4CFFE36B00FA_var*
//#UC END# *515584F20246_4CFFE36B00FA_var*
begin
//#UC START# *515584F20246_4CFFE36B00FA_impl*
 f_Updating := False;
 Refresh;
//#UC END# *515584F20246_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.EndUpdate

procedure TvtCustomListerPrim.DrawItem(Index: LongInt);
//#UC START# *5155850202DE_4CFFE36B00FA_var*
//#UC END# *5155850202DE_4CFFE36B00FA_var*
begin
//#UC START# *5155850202DE_4CFFE36B00FA_impl*
 InvalidateItem(Index);
 Update;
//#UC END# *5155850202DE_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DrawItem

procedure TvtCustomListerPrim.InvalidateItem(Index: LongInt);
//#UC START# *5155852A01C2_4CFFE36B00FA_var*
var
 l_CR : TRect;
//#UC END# *5155852A01C2_4CFFE36B00FA_var*
begin
//#UC START# *5155852A01C2_4CFFE36B00FA_impl*
 if not InUpdating and
    (Index >= f_TopIndex) and
    (Index - f_TopIndex < ItemOnScreen(false)) then
 begin
  l_CR := GetDrawRect(Index);
  if (not f_PickedList) and (Images <> nil) then Inc(l_CR.Left,Images.Width + ImageAddSpace);
  Windows.InvalidateRect(Handle, @l_CR, True);
 end;
//#UC END# *5155852A01C2_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.InvalidateItem

function TvtCustomListerPrim.ItemAtPos(const Pos: TPoint;
 Existing: Boolean): LongInt;
//#UC START# *515585530175_4CFFE36B00FA_var*
var
 l_I : Integer;
//#UC END# *515585530175_4CFFE36B00FA_var*
begin
//#UC START# *515585530175_4CFFE36B00FA_impl*
 if not Existing and ((Pos.X < 0) or (Pos.X > Width)) then
 begin
  Result := -1;
  Exit;
 end;//if not Existing and ((Pos.X < 0) or (Pos.X > Width)) then
 if (Pos.Y < GetTopIndent) or (Pos.Y >= ClientHeight) then
  Result := -1
 else
 begin {convert to an index}
  if UseDrawPoints then
  begin
   Result := -1;
   if DrawPoints = nil then
    Result := -1
   else
    for l_I := 0 to Pred(DrawPoints.Count) do
     if DrawPoints[l_I] > Pos.Y - GetTopIndent then
     begin
      Result := f_TopIndex + l_I;
      Break;
     end;//if DrawPoints[l_I] > Pos.Y - GetTopIndent then
  end//if UseDrawPoints then
  else
  begin
   Result := f_TopIndex + (Pos.Y - GetTopIndent) div CompleteRowHeight;
   {test for click below last item (IntegralHeight not set)}
   if ClientHeight mod CompleteRowHeight > 0 then
    Result := Min(Result, f_TopIndex + ItemOnScreen(false) - 1);
  end;//if UseDrawPoints then
 end;//if (Pos.Y < GetTopIndent) or (Pos.Y >= ClientHeight) then
//#UC END# *515585530175_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.ItemAtPos

procedure TvtCustomListerPrim.ResetList;
//#UC START# *51558586035F_4CFFE36B00FA_var*
//#UC END# *51558586035F_4CFFE36B00FA_var*
begin
//#UC START# *51558586035F_4CFFE36B00FA_impl*
 Total := 0;
 Current := 0;
 Repaint;
//#UC END# *51558586035F_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.ResetList

function TvtCustomListerPrim.GetNextSelectItem(Index: LongInt): LongInt;
//#UC START# *5155859A00BC_4CFFE36B00FA_var*
//#UC END# *5155859A00BC_4CFFE36B00FA_var*
begin
//#UC START# *5155859A00BC_4CFFE36B00FA_impl*
 for Result := Succ(Index) to Pred(Total) do
  if Selected[Result] then
   Exit;
 Result := -1;
//#UC END# *5155859A00BC_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetNextSelectItem

function TvtCustomListerPrim.GetItemTextIndent(Index: LongInt;
 aTextBoxHeight: Integer): Integer;
//#UC START# *515585B90316_4CFFE36B00FA_var*
//#UC END# *515585B90316_4CFFE36B00FA_var*
begin
//#UC START# *515585B90316_4CFFE36B00FA_impl*
 Result := 0;
 if (Images <> nil) then
  Inc(Result, Images.Width + ImageAddSpace);

 if f_PickedList then
  Inc(Result, PickImages.Width + ImageAddSpace);
//#UC END# *515585B90316_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetItemTextIndent

function TvtCustomListerPrim.GetItemHeight(Index: LongInt): Integer;
//#UC START# *515585F9029E_4CFFE36B00FA_var*
//#UC END# *515585F9029E_4CFFE36B00FA_var*
begin
//#UC START# *515585F9029E_4CFFE36B00FA_impl*
 Result := GetItemDim(Index).Y;
//#UC END# *515585F9029E_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetItemHeight

function TvtCustomListerPrim.GetItemDim(aItemIndex: Integer): TPoint;
//#UC START# *51558620037C_4CFFE36B00FA_var*
var
 l_R      : TRect;
 l_ICN    : Il3InfoCanvas;
 l_LWidth : Integer;
 l_Painter: Il3NodePainter;
 l_S      : Il3CString;
 l_SRect  : Tl3SRect;
 l_l3Rect : Tl3Rect;
//#UC END# *51558620037C_4CFFE36B00FA_var*
begin
//#UC START# *51558620037C_4CFFE36B00FA_impl*
 l_ICN := l3CrtIC;
 l_ICN.Lock;
 try
  InitItemFont(aItemIndex, l_ICN.Font, vt_lipText);
  if UseDrawPoints then
  begin
   l_R := Rect(0,0,ClientWidth, ClientHeight);
   if l_R.Right < 3 then l_R.Right := 3;
   if Images <> nil then
    Inc(l_R.Left, Images.Width + ImageAddSpace);
   if PickedList then
    Inc(l_R.Left, PickImages.Width + ImageAddSpace);

   Inc(l_R.Left, 2); // чтобы маленький отступ был слева

   l_Painter := DoOnGetItemPainter(aItemIndex);
   if l_Painter <> nil then
   begin
    l_LWidth := l_ICN.DP2LP(PointX(l_R.Right-l_R.Left)).X;
    l_R.Bottom := l_ICN.LP2DP(l3PointY(l_Painter.CalcHeight(l_ICN, l_LWidth))).Y
   end
   else
   begin
    l_S := DoOnGetItem(aItemIndex);
    if not l3IsNil(l_S) then
    begin
     if f_UseTabStops and (f_Header.Sections.Count > 0) then
     begin
      l_SRect.R.WR := l_R;
      l_l3Rect := l_ICN.DR2LR(l_SRect);
      if Assigned(Images) then
       f_TabsFirstIndent := Images.Width + ImageAddSpace
      else
       f_TabsFirstIndent := 0;
      l_ICN.TabbedMultilineTextOut(l3PCharLen(l_S),
                                      Tl3TabStops.Make(TSGetTabStopPos, True),
                                      l_l3Rect,
                                      True,
                                      vt_TabbedMLOutGap);
      l_SRect := l_ICN.LR2DR(l_l3Rect);
      l_R := l_SRect.R.WR;
     end//if f_UseTabStops and (f_Header.Sections.Count > 0) then
     else
      l_ICN.DrawText(l3PCharLen(l_S), l_R, DT_CALCRECT or vtMultiLineDrawTextFormat);
    end//if not l3IsNil(l_S) then
    else
     l_R.Bottom := RowHeight;
   end;

   if Images <> nil then
    l_R.Bottom := Max(l_R.Bottom, Images.Height + 2);

   if l_R.Bottom < RowHeight then
    l_R.Bottom := RowHeight;
   Result.X := l_R.Right - l_R.Left;
   Result.Y := l_R.Bottom;
  end//if UseDrawPoints then
  else
  begin
   Result.Y := RowHeight;
   Result.X := l_ICN.LP2DP(l_ICN.TextExtent(l3PCharLen(DoOnGetItem(aItemIndex)))).X;
   Inc(Result.X, GetItemTextIndent(aItemIndex, Result.Y));
  end;//if UseDrawPoints then
 finally
  l_ICN.Unlock;
 end;{try..finally}
//#UC END# *51558620037C_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetItemDim

function TvtCustomListerPrim.GetFooterDim: TPoint;
//#UC START# *5155863B00D2_4CFFE36B00FA_var*
var
 l_Canvas : Il3InfoCanvas;
 CR       : TRect;
const
 lMeasureStr : Tl3PCharLen = (S: 'Wy'#0; SLen : 2; SCodePage: CP_ANSI; );
//#UC END# *5155863B00D2_4CFFE36B00FA_var*
begin
//#UC START# *5155863B00D2_4CFFE36B00FA_impl*
 Result := Point(0, 0);
 if (ClientWidth = 0) or (FooterCaption = '') then
  Exit;

 CR := Rect(FooterLeftIndent, 0, ClientWidth, MaxInt);
 l_Canvas := l3CrtIC;
 l_Canvas.Font.AssignFont(FooterFont);
 InflateRect(CR, -cFocusRectBounds, 0);
 if f_MultiStrokeItem then
  l_Canvas.DrawText(l3PCharLen(FooterCaption), CR, DT_CALCRECT or vtMultiLineDrawTextFormat)
 else
  l_Canvas.DrawText(l3PCharLen(FooterCaption), CR, DT_CALCRECT);
 InflateRect(CR, cFocusRectBounds, 0);

 Result := Point(CR.Right - CR.Left, CR.Bottom - CR.Top);
//#UC END# *5155863B00D2_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetFooterDim

procedure TvtCustomListerPrim.HitTest(const aPt: TPoint;
 var aIndex: Integer;
 var aItemPart: Byte;
 fromScreen: Boolean = False);
//#UC START# *515586660348_4CFFE36B00FA_var*
var
 l_Pt : TPoint;
 l_Rect: TRect;
 l_Size: TPoint;
//#UC END# *515586660348_4CFFE36B00FA_var*
begin
//#UC START# *515586660348_4CFFE36B00FA_impl*
 if fromScreen
  then l_Pt := ScreenToClient(aPt)
  else l_Pt := aPt;
 aIndex := ItemAtPos(l_Pt, True);
 if (aIndex >= 0) then
  aItemPart := vlbItemHitTest(aIndex, l_Pt)
 else
  if FooterVisible then
  begin
   l_Rect := GetDrawRect(f_HighIndex);
   l_Rect.Top := l_Rect.Bottom + GetTopIndent + (InterRowIndent div 2);
   l_Rect.Left := FooterLeftIndent;
   l_Size := GetFooterDim;
   l_Rect.Right := l_Rect.Left + l_Size.X;
   l_Rect.Bottom := l_Rect.Top + l_Size.Y;
   if PtInRect(l_Rect, l_Pt) then
    aItemPart := ihtFooter
   else
    aItemPart := ihtNone;
  end else
   aItemPart := ihtNone;
//#UC END# *515586660348_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.HitTest

function TvtCustomListerPrim.GetItemsRangeDim(aBeginIndex: Integer;
 aEndIndex: Integer;
 aMaxHeight: Integer = 0): TPoint;
//#UC START# *515586B3035C_4CFFE36B00FA_var*
var
 l_I   : Integer;
 l_Dim : TPoint;
//#UC END# *515586B3035C_4CFFE36B00FA_var*
begin
//#UC START# *515586B3035C_4CFFE36B00FA_impl*
 Result := Point(0,0);
 CheckParam;
 if (aEndIndex = 0) or
    (aEndIndex > Total) then aEndIndex := Pred(Total);
 for l_I := aBeginIndex to aEndIndex do
 begin
  l_Dim := GetItemDim(l_I);
  Inc(Result.Y, l_Dim.Y);
  Result.X := Max(Result.X, l_Dim.X);
  if (aMaxHeight > 0) and (Result.Y >= aMaxHeight) then
   break;
 end;//for l_I := aBeginIndex to aEndIndex do
 Inc(Result.Y, InterRowIndent * (aEndIndex - aBeginIndex));
 if (aMaxHeight > 0) and (Result.Y > aMaxHeight) then
  Result.Y := aMaxHeight;
//#UC END# *515586B3035C_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetItemsRangeDim

function TvtCustomListerPrim.ExcludeRect: TRect;
//#UC START# *515586DF00E9_4CFFE36B00FA_var*
//#UC END# *515586DF00E9_4CFFE36B00FA_var*
begin
//#UC START# *515586DF00E9_4CFFE36B00FA_impl*
 l3FillChar(Result, SizeOf(Result));
 Result.Right := -1;
 Result.Bottom := -1;
//#UC END# *515586DF00E9_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.ExcludeRect

function TvtCustomListerPrim.GetDrawRect(Index: LongInt): TRect;
 {* Функция для получения координат отрисовки элемента с Index }
//#UC START# *515587060022_4CFFE36B00FA_var*
var
 l_TopIndent : Integer;
 l_Ex        : TRect;
//#UC END# *515587060022_4CFFE36B00FA_var*
begin
//#UC START# *515587060022_4CFFE36B00FA_impl*
 if f_NeedCurrentVisible then
  vlbMakeItemVisiblePrim(Current);
 l_TopIndent := GetTopIndent;
 if UseDrawPoints then
 begin
  if (Index >= f_TopIndex) and (Index < f_TopIndex + ItemOnScreen(false)) and
     (DrawPoints <> nil) and (DrawPoints.Count > (Index - f_TopIndex)) then
  begin
   if Index = f_TopIndex then
    Result := Rect(0,l_TopIndent, ClientWidth,l_TopIndent + DrawPoints[0])
   else
    Result := Rect(0,l_TopIndent + DrawPoints[Index-f_TopIndex-1],
                      ClientWidth,l_TopIndent + DrawPoints[Index-f_TopIndex]);
  end
  else
   Result := Rect(0,0,0,0);
 end//UseDrawPoints
 else
 begin
  if (Index >= f_TopIndex) and (Index < f_TopIndex + ItemOnScreen(false)) then
  //if (Index >= f_TopIndex) and (Index-f_TopIndex <= Pred(f_Rows)) then
  begin
   Result := ClientRect;
   Result.Top := (Index - f_TopIndex) * CompleteRowHeight + l_TopIndent;
   Result.Bottom := Result.Top + CompleteRowHeight;
  end else
   Result := Rect(0,0,0,0);
 end;//UseDrawPoints
 l_Ex := ExcludeRect;
 if ((Result.Top >=  l_Ex.Top) AND (Result.Top <=  l_Ex.Bottom)) OR
    ((Result.Bottom >=  l_Ex.Top) AND (Result.Bottom <=  l_Ex.Bottom)) then
  Result.Right := l_Ex.Left - 1;
//#UC END# *515587060022_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetDrawRect

function TvtCustomListerPrim.GetDrawTextRect(Index: LongInt): TRect;
 {* Функция для получения координат отрисовки текста элемента с Index }
//#UC START# *5155873F03BB_4CFFE36B00FA_var*
//#UC END# *5155873F03BB_4CFFE36B00FA_var*
begin
//#UC START# *5155873F03BB_4CFFE36B00FA_impl*
 Result := GetDrawRect(Index);
 Inc(Result.Left, GetItemTextIndent(Index, Result.Bottom - Result.Top));
 Result.Left := Min(Result.Left, Result.Right)
//#UC END# *5155873F03BB_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetDrawTextRect

function TvtCustomListerPrim.CalcFullHeight: Integer;
//#UC START# *51558765021D_4CFFE36B00FA_var*
var
 I : Integer;
//#UC END# *51558765021D_4CFFE36B00FA_var*
begin
//#UC START# *51558765021D_4CFFE36B00FA_impl*
 Result := 0;
 if UseDrawPoints then
 begin
  for I := 0 to Pred(Min(Total, 200)) do
                             // ^ нечего пытаться считать "все километры деревьев",
                             //   они всё равно в итоге нафиг никому не нужны
                             //   интересует лишь приблизительная оценка
                             //   http://mdp.garant.ru/pages/viewpage.action?pageId=259883587
   Inc(Result, GetItemDim(I).Y + InterRowIndent);
  Dec(Result, InterRowIndent);
 end//UseDrawPoints
 else
  Result := CompleteRowHeight * Total;
 Result := Result + InterRowIndent;
//#UC END# *51558765021D_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CalcFullHeight

function TvtCustomListerPrim.CalcFullWidth: Integer;
 {* Функция для ширины самого длинного элемента }
//#UC START# *515587A301FE_4CFFE36B00FA_var*
 function lpGetItemWidth(I : Integer) : Integer;
 var
  DisplayRect : TRect;
  l_St        : Il3CString;
  l_Rect      : TRect;
  l_Canvas    : Il3InfoCanvas;
 begin//lpGetItemWidth
  l_Canvas := l3CrtIC;
  l_Canvas.Lock;
  try
   DisplayRect := GetDrawTextRect(I);
   l_St := DoOnGetItem(I);
   InitItemFont(I, l_Canvas.Font, vt_lipText);

   l_Rect.Left := 0;
   l_Rect.Top := 0;
   l_Rect.Right := 0;
   l_Rect.Bottom := 0;

   l_Canvas.DrawText(l3PCharLen(l_St), l_Rect, DT_CALCRECT or
    DT_LEFT or DT_NOPREFIX or DrawTextBiDiModeFlagsReadingOnly);

   Result := DisplayRect.Left + l_Rect.Right - l_Rect.Left;
  finally
   l_Canvas.Unlock;
  end;//try..finally
 end;//lpGetItemWidth
var
 I : Integer;
//#UC END# *515587A301FE_4CFFE36B00FA_var*
begin
//#UC START# *515587A301FE_4CFFE36B00FA_impl*
 Result := 0;
 if f_MultiStrokeItem then
  Result := ClientWidth
 else
 for I := 0 to Pred(Total) do
  Result := Max(Result, lpGetItemWidth(I));
//#UC END# *515587A301FE_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CalcFullWidth

procedure TvtCustomListerPrim.vlbToggleSelection(Index: LongInt);
 {* process Ctrl-LMouseBtn }
//#UC START# *51558804036E_4CFFE36B00FA_var*
var
 lWasSelected : Boolean;
//#UC END# *51558804036E_4CFFE36B00FA_var*
begin
//#UC START# *51558804036E_4CFFE36B00FA_impl*
 {Multiselect option requires OnSelect and OnIsSelected to be defined}
 if not f_MultiSelect {or (not Assigned(f_OnSelect))
    or (not Assigned(f_OnIsSelected))} then
  Exit;
 {toggle highligt}
 lWasSelected := Selected[Index];
 DoOnSelect(Index, Ord(not lWasSelected));

 vlbSetEasyCurrent(Index);
 DrawItem(Index);
 {set new active item}
 {f_Current := Index;}
 {and anchor point}
 if not FixAnchor then f_Anchor := Index;
//#UC END# *51558804036E_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbToggleSelection

procedure TvtCustomListerPrim.vlbSelectAllItems;
 {* select all items in the list box }
//#UC START# *5155883303DE_4CFFE36B00FA_var*
//#UC END# *5155883303DE_4CFFE36B00FA_var*
begin
//#UC START# *5155883303DE_4CFFE36B00FA_impl*
 vlbSetAllItemsPrim(True);
//#UC END# *5155883303DE_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbSelectAllItems

procedure TvtCustomListerPrim.vlbDeselectAllItems;
 {* clear the highlight from all items }
//#UC START# *5155884C02D4_4CFFE36B00FA_var*
//#UC END# *5155884C02D4_4CFFE36B00FA_var*
begin
//#UC START# *5155884C02D4_4CFFE36B00FA_impl*
 vlbSetAllItemsPrim(False);
//#UC END# *5155884C02D4_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbDeselectAllItems

procedure TvtCustomListerPrim.vlbMakeItemVisiblePrim(Index: LongInt);
 {* make sure the item is visible }
//#UC START# *5155886A00C0_4CFFE36B00FA_var*
 function lp_FooterHeight: Integer;
 begin
  if FooterVisible then
   Result := GetFooterDim.Y + InterRowIndent
  else
   Result := 0;
 end;
var
 l_WholeRows : Integer;
//#UC END# *5155886A00C0_4CFFE36B00FA_var*
begin
//#UC START# *5155886A00C0_4CFFE36B00FA_impl*
 if Index = f_TopIndex then
  Exit;
 f_NeedCurrentVisible := False;
 if Index < f_TopIndex then
  TopIndex := Index
 else
 begin
  if UseDrawPoints then
  begin
   if (Index-f_TopIndex + 1 > DrawPoints.Count) or
      ((Index-f_TopIndex + 1 = DrawPoints.Count) and
      (DrawPoints.Last + lp_FooterHeight > ClientHeight - GetTopIndent)) then
    TopIndex := CalcTopIndex (Index);
  end//if UseDrawPoints then
  else
  begin
   l_WholeRows := Pred((ClientHeight - GetTopIndent) div CompleteRowHeight);
   if (Index = f_HighIndex) and FooterVisible then
    Dec(l_WholeRows);
   if Index > (f_TopIndex + l_WholeRows) then
    TopIndex := Index - l_WholeRows;
  end;//if UseDrawPoints then
 end;//if Index < f_TopIndex then
//#UC END# *5155886A00C0_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbMakeItemVisiblePrim

function TvtCustomListerPrim.MousePointToIndex: LongInt;
 {* Return Item under mouse pointer }
//#UC START# *5155890600BB_4CFFE36B00FA_var*
var
 Pt : TPoint;
//#UC END# *5155890600BB_4CFFE36B00FA_var*
begin
//#UC START# *5155890600BB_4CFFE36B00FA_impl*
 GetCursorPos(Pt);
 Pt := ScreenToClient(Pt);
 Result := ItemAtPos(Pt, False);
//#UC END# *5155890600BB_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.MousePointToIndex

procedure TvtCustomListerPrim.ItemSourceChanged;
 {* Call It when Source of items is Change }
//#UC START# *5155895202EF_4CFFE36B00FA_var*
//#UC END# *5155895202EF_4CFFE36B00FA_var*
begin
//#UC START# *5155895202EF_4CFFE36B00FA_impl*
 vlbInitScrollInfo;
 if Total <> 0 then
  {reposition so that items are displayed at bottom of list}
  if UseDrawPoints then
  begin
   DropDrawPoints;
   if f_TopIndex -1 + ItemOnScreen(True) < f_Current
    then TopIndex := CalcTopIndex(f_Current);
  end;
 Invalidate;
//#UC END# *5155895202EF_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.ItemSourceChanged

procedure TvtCustomListerPrim.DrawLock;
//#UC START# *51558984026B_4CFFE36B00FA_var*
//#UC END# *51558984026B_4CFFE36B00FA_var*
begin
//#UC START# *51558984026B_4CFFE36B00FA_impl*
 Inc(f_LockDraw);
 if f_LockDraw = 1 then
  Perform(WM_SetRedraw, 0, 0);
//#UC END# *51558984026B_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DrawLock

procedure TvtCustomListerPrim.DrawUnLock;
//#UC START# *5155899302E3_4CFFE36B00FA_var*
//#UC END# *5155899302E3_4CFFE36B00FA_var*
begin
//#UC START# *5155899302E3_4CFFE36B00FA_impl*
 if f_LockDraw > 0 then
  Dec(f_LockDraw);
 if f_LockDraw = 0 then
 begin
  Perform(WM_SetRedraw, 1, 0);
  Invalidate;
 end;
//#UC END# *5155899302E3_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DrawUnLock

procedure TvtCustomListerPrim.FullRedraw;
//#UC START# *515589A401B3_4CFFE36B00FA_var*
//#UC END# *515589A401B3_4CFFE36B00FA_var*
begin
//#UC START# *515589A401B3_4CFFE36B00FA_impl*
 if UseDrawPoints then
  DropDrawPoints;
 Invalidate;
//#UC END# *515589A401B3_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.FullRedraw

function TvtCustomListerPrim.GetDrawString(aIndex: Integer): Il3CString;
 {* получаем строку для рисования }
//#UC START# *515589C602E9_4CFFE36B00FA_var*
var
 l_S : Tl3WString;
//#UC END# *515589C602E9_4CFFE36B00FA_var*
begin
//#UC START# *515589C602E9_4CFFE36B00FA_impl*
 Result := nil;
 if (aIndex <= f_HighIndex) then
 begin
  Result := DoOnGetItem(aIndex);
  l_S := l3PCharLen(Result);
  if (f_HDelta < l_S.SLen) then
   Result := l3CStr(l3PCharLen(l_S.S + f_HDelta, Max(0, l_S.SLen - f_HDelta), l_S.SCodePage));
 end;//aIndex <= f_HighIndex
//#UC END# *515589C602E9_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetDrawString

procedure TvtCustomListerPrim.LockChangeSelected;
//#UC START# *51558A050343_4CFFE36B00FA_var*
//#UC END# *51558A050343_4CFFE36B00FA_var*
begin
//#UC START# *51558A050343_4CFFE36B00FA_impl*
 //Наверно надо счетчик присобачить
 SetLockChangeSelected(True);
//#UC END# *51558A050343_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LockChangeSelected

procedure TvtCustomListerPrim.UnLockChangeSelected;
//#UC START# *51558A190357_4CFFE36B00FA_var*
//#UC END# *51558A190357_4CFFE36B00FA_var*
begin
//#UC START# *51558A190357_4CFFE36B00FA_impl*
 //Наверно надо счетчик присобачить
 SetLockChangeSelected(False);
//#UC END# *51558A190357_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.UnLockChangeSelected

procedure TvtCustomListerPrim.LockMakeCurrentVisible;
//#UC START# *51558A2B002F_4CFFE36B00FA_var*
//#UC END# *51558A2B002F_4CFFE36B00FA_var*
begin
//#UC START# *51558A2B002F_4CFFE36B00FA_impl*
 f_LockMakeCurrentVisible := True;
//#UC END# *51558A2B002F_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LockMakeCurrentVisible

procedure TvtCustomListerPrim.UnLockMakeCurrentVisible;
//#UC START# *51558A3C00D9_4CFFE36B00FA_var*
//#UC END# *51558A3C00D9_4CFFE36B00FA_var*
begin
//#UC START# *51558A3C00D9_4CFFE36B00FA_impl*
 f_LockMakeCurrentVisible := False;
//#UC END# *51558A3C00D9_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.UnLockMakeCurrentVisible

procedure TvtCustomListerPrim.SetNoCurrent;
 {* Убрать выделение и фокус, установить Current в -1 }
//#UC START# *51558A520211_4CFFE36B00FA_var*
//#UC END# *51558A520211_4CFFE36B00FA_var*
begin
//#UC START# *51558A520211_4CFFE36B00FA_impl*
 if (not PickedList) and (-1 <> f_Current) then
  vlbDeselectAllItems;
 vlbSetCurrentPrim(-1, false);
//#UC END# *51558A520211_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.SetNoCurrent

procedure TvtCustomListerPrim.Changing;
//#UC START# *51558A910352_4CFFE36B00FA_var*
//#UC END# *51558A910352_4CFFE36B00FA_var*
begin
//#UC START# *51558A910352_4CFFE36B00FA_impl*
 inherited Changing;
//#UC END# *51558A910352_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.Changing

procedure TvtCustomListerPrim.Changed;
//#UC START# *51558A9E01ED_4CFFE36B00FA_var*
//#UC END# *51558A9E01ED_4CFFE36B00FA_var*
begin
//#UC START# *51558A9E01ED_4CFFE36B00FA_impl*
 inherited Changed;
//#UC END# *51558A9E01ED_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.Changed

function TvtCustomListerPrim.GetTopIndent: Integer;
//#UC START# *5158507D0071_4CFFE36B00FA_var*
//#UC END# *5158507D0071_4CFFE36B00FA_var*
begin
//#UC START# *5158507D0071_4CFFE36B00FA_impl*
 Result := Ord(ShowHeader) * f_Header.Height;
//#UC END# *5158507D0071_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetTopIndent

function TvtCustomListerPrim.ImageAddSpace: Integer;
//#UC START# *515855DB03C8_4CFFE36B00FA_var*
//#UC END# *515855DB03C8_4CFFE36B00FA_var*
begin
//#UC START# *515855DB03C8_4CFFE36B00FA_impl*
 Result := 2 * (RowHeight div 4);
//#UC END# *515855DB03C8_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.ImageAddSpace

procedure TvtCustomListerPrim.UpdateFooterActivity(aValue: Boolean);
//#UC START# *515855F70371_4CFFE36B00FA_var*
//#UC END# *515855F70371_4CFFE36B00FA_var*
begin
//#UC START# *515855F70371_4CFFE36B00FA_impl*
 if f_FooterActive <> aValue then
 begin
  f_FooterActive := aValue;
  Invalidate;
 end;
//#UC END# *515855F70371_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.UpdateFooterActivity

function TvtCustomListerPrim.GetItemVShift: Integer;
//#UC START# *515857F20020_4CFFE36B00FA_var*
//#UC END# *515857F20020_4CFFE36B00FA_var*
begin
//#UC START# *515857F20020_4CFFE36B00FA_impl*
 if UseDrawPoints then
  Result := InterRowIndent div 2
 else
  Result := (f_RowHeight - f_FontHeight) div 2;
//#UC END# *515857F20020_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetItemVShift

procedure TvtCustomListerPrim.vlbMakeItemVisible(Index: LongInt);
//#UC START# *5158596502B6_4CFFE36B00FA_var*
//#UC END# *5158596502B6_4CFFE36B00FA_var*
begin
//#UC START# *5158596502B6_4CFFE36B00FA_impl*
 if Index = f_TopIndex then
  Exit;
 if InUpdating and (Index = Current) then
  f_NeedCurrentVisible := True
 else
  vlbMakeItemVisiblePrim(Index);
//#UC END# *5158596502B6_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbMakeItemVisible

procedure TvtCustomListerPrim.vlbSetVScrollPos;
//#UC START# *51594A6C023F_4CFFE36B00FA_var*
//#UC END# *51594A6C023F_4CFFE36B00FA_var*
begin
//#UC START# *51594A6C023F_4CFFE36B00FA_impl*
 if ScrollStyle in [ssVertical, ssBoth] then
 if InUpdating or f_InScroll then
  begin
   if not (vt_ufVPos in f_UpdateFlags) then
   begin
    Include(f_UpdateFlags, vt_ufVPos);
    PostMessage(Handle, msg_vtUpdateScroll, 0, 0);
   end;
  end
  else
  begin
   Exclude(f_UpdateFlags, vt_ufVPos);
   SetScrollPos(Handle, SB_VERT, f_TopIndex, true);
  end;
//#UC END# *51594A6C023F_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.vlbSetVScrollPos

procedure TvtCustomListerPrim.SetSearchStrPrim(const aValue: AnsiString);
//#UC START# *51594F150115_4CFFE36B00FA_var*
//#UC END# *51594F150115_4CFFE36B00FA_var*
begin
//#UC START# *51594F150115_4CFFE36B00FA_impl*
 if (aValue = '') then
 begin
  if Caret.Visible then
   Caret.Visible := False;
 end else
 begin
  if not Caret.Visible then
   Caret.Visible := True;
 end;
 f_SearchStr := aValue;
//#UC END# *51594F150115_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.SetSearchStrPrim

procedure TvtCustomListerPrim.SetLockChangeSelected(aValue: Boolean);
//#UC START# *515998420356_4CFFE36B00FA_var*
//#UC END# *515998420356_4CFFE36B00FA_var*
begin
//#UC START# *515998420356_4CFFE36B00FA_impl*
 if f_LockSelectChange = aValue then
  Exit;
 f_LockSelectChange := aValue;
 if not f_LockSelectChange then
 begin
  if f_NeedResetSelectArray then
  begin
   f_NeedResetSelectArray := False;
   ResetSelectArray;
  end;
  if (not PickedList and f_MultiSelect) then
  begin
//   DoOnSelect(f_Current, 1); //закомментировал из-за 619559545
//   InvalidateItem(f_Current);
  end;
 end;
//#UC END# *515998420356_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.SetLockChangeSelected

procedure TvtCustomListerPrim.MakeSureCaretIsCreated;
//#UC START# *51599CCF0399_4CFFE36B00FA_var*
//#UC END# *51599CCF0399_4CFFE36B00FA_var*
begin
//#UC START# *51599CCF0399_4CFFE36B00FA_impl*
 if (f_Caret = nil) then
 begin
  f_Caret := TafwCaret.Create(Self);
  f_Caret.CellHeight := f_FontHeight;
  Canvas := nil;
 end;
//#UC END# *51599CCF0399_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.MakeSureCaretIsCreated

procedure TvtCustomListerPrim.InternalSetCurrent(aValue: LongInt);
//#UC START# *515AD8A00242_4CFFE36B00FA_var*
//#UC END# *515AD8A00242_4CFFE36B00FA_var*
begin
//#UC START# *515AD8A00242_4CFFE36B00FA_impl*
 f_Current := aValue;
//#UC END# *515AD8A00242_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.InternalSetCurrent

procedure TvtCustomListerPrim.InternalSetTopIndex(aValue: LongInt);
//#UC START# *515AD9440131_4CFFE36B00FA_var*
//#UC END# *515AD9440131_4CFFE36B00FA_var*
begin
//#UC START# *515AD9440131_4CFFE36B00FA_impl*
 f_TopIndex := aValue;
//#UC END# *515AD9440131_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.InternalSetTopIndex

procedure TvtCustomListerPrim.InternalSetTotal(aValue: LongInt);
//#UC START# *515ADA4F03E7_4CFFE36B00FA_var*
//#UC END# *515ADA4F03E7_4CFFE36B00FA_var*
begin
//#UC START# *515ADA4F03E7_4CFFE36B00FA_impl*
 f_Total := aValue;
//#UC END# *515ADA4F03E7_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.InternalSetTotal

function TvtCustomListerPrim.NeedChangeCurrentOnMouseTrack: Boolean;
//#UC START# *5266249D00E3_4CFFE36B00FA_var*
//#UC END# *5266249D00E3_4CFFE36B00FA_var*
begin
//#UC START# *5266249D00E3_4CFFE36B00FA_impl*
 Result := True;
//#UC END# *5266249D00E3_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.NeedChangeCurrentOnMouseTrack

function TvtCustomListerPrim.IsMouseMoved(const aPos: TPoint): Boolean;
//#UC START# *526624CF0324_4CFFE36B00FA_var*
//#UC END# *526624CF0324_4CFFE36B00FA_var*
begin
//#UC START# *526624CF0324_4CFFE36B00FA_impl*
 Result := (f_OldMousePos.X <> APos.X) or (f_OldMousePos.Y <> APos.Y);
//#UC END# *526624CF0324_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.IsMouseMoved

procedure TvtCustomListerPrim.DoNeedRecalcConstraints;
//#UC START# *526E14E103CA_4CFFE36B00FA_var*
//#UC END# *526E14E103CA_4CFFE36B00FA_var*
begin
//#UC START# *526E14E103CA_4CFFE36B00FA_impl*
 if Assigned(f_OnNeedRecalcConstraints) then
  f_OnNeedRecalcConstraints(Self);
//#UC END# *526E14E103CA_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoNeedRecalcConstraints

procedure TvtCustomListerPrim.InvalidateNonclientArea;
//#UC START# *52E8BAE402E4_4CFFE36B00FA_var*
//#UC END# *52E8BAE402E4_4CFFE36B00FA_var*
begin
//#UC START# *52E8BAE402E4_4CFFE36B00FA_impl*
 //http://mdp.garant.ru/pages/viewpage.action?pageId=514869678
 if (not f_InScroll) and (not (vt_lsSizing in f_States)) and
  (not (vt_lsUpdatingNCArea in f_States)) then
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=516166484
 begin
  //http://mdp.garant.ru/pages/viewpage.action?pageId=516166484
  Include(f_States, vt_lsUpdatingNCArea);
  SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or
   SWP_NOZORDER or SWP_NOACTIVATE or SWP_FRAMECHANGED);
 end;
//#UC END# *52E8BAE402E4_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.InvalidateNonclientArea

procedure TvtCustomListerPrim.ResetLastHint;
//#UC START# *5486DEEB034F_4CFFE36B00FA_var*
//#UC END# *5486DEEB034F_4CFFE36B00FA_var*
begin
//#UC START# *5486DEEB034F_4CFFE36B00FA_impl*
 f_LastHintIndex := -1;
 f_LastHintContext := ihtNone;
//#UC END# *5486DEEB034F_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.ResetLastHint

procedure TvtCustomListerPrim.InitItemFont(Index: LongInt;
 const aFont: Il3Font;
 anItemPart: TvtListerItemPart);
 {* устанавлиет шрифт по умолчанию и вызывает _DoOnGetItemFont. }
//#UC START# *5151ABF3037A_4CFFE36B00FA_var*
//#UC END# *5151ABF3037A_4CFFE36B00FA_var*
begin
//#UC START# *5151ABF3037A_4CFFE36B00FA_impl*
 aFont.AssignFont(Font);
 DoOnGetItemFont(Index, aFont, anItemPart);
//#UC END# *5151ABF3037A_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.InitItemFont

procedure TvtCustomListerPrim.CMCtl3DChanged(var Message: TMessage);
//#UC START# *51530D3E00CD_4CFFE36B00FA_var*
//#UC END# *51530D3E00CD_4CFFE36B00FA_var*
begin
//#UC START# *51530D3E00CD_4CFFE36B00FA_impl*
 inherited;
 Refresh;
//#UC END# *51530D3E00CD_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CMCtl3DChanged

procedure TvtCustomListerPrim.CMFontChanged(var Message: TMessage);
//#UC START# *51530D6702C7_4CFFE36B00FA_var*
//#UC END# *51530D6702C7_4CFFE36B00FA_var*
begin
//#UC START# *51530D6702C7_4CFFE36B00FA_impl*
 inherited;
 {reset internal size variables}
 {if f_IntegralHeight and not (csLoading in ComponentState) then begin
   vlbCalcFontFields;
   vlbAdjustIntegralHeight;
 end;}
 f_FontChanged := True;// - такой вызов приводит к рекурсивному вызову SetDrawPointsArray
 DropDrawPoints;
 Invalidate;
 //vlbCalcFontFields;
 //vlbInitScrollInfo;
//#UC END# *51530D6702C7_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CMFontChanged

procedure TvtCustomListerPrim.CMEnabledChanged(var Message: TMessage);
//#UC START# *51530D7C00C6_4CFFE36B00FA_var*
//#UC END# *51530D7C00C6_4CFFE36B00FA_var*
begin
//#UC START# *51530D7C00C6_4CFFE36B00FA_impl*
 inherited;
 Refresh;
//#UC END# *51530D7C00C6_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CMEnabledChanged

procedure TvtCustomListerPrim.WMGetText(var Msg: TWMGetText);
//#UC START# *51530DF20288_4CFFE36B00FA_var*
var
 l_P : Tl3PCharLen;
//#UC END# *51530DF20288_4CFFE36B00FA_var*
begin
//#UC START# *51530DF20288_4CFFE36B00FA_impl*
 if (Total = 0) or (Current < 0) then
  l3AssignNil(l_P)
 else
  l_P := l3PCharLen(DoOnGetItem(Current));

 if l3IsNil(l_P) then
  Msg.Result := 0
 else
  Msg.Result := l3StrLen(StrLCopy(Msg.Text, {$IfDef XE}PChar(l3DStr(l_P)){$Else}l_P.S{$EndIf}, Min(l_P.SLen, Pred(Msg.TextMax))));
//#UC END# *51530DF20288_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMGetText

procedure TvtCustomListerPrim.WMGetTextLength(var Msg: TWMGetTextLength);
//#UC START# *51530E03032F_4CFFE36B00FA_var*
//#UC END# *51530E03032F_4CFFE36B00FA_var*
begin
//#UC START# *51530E03032F_4CFFE36B00FA_impl*
 if (Total = 0) or (Current < 0) or (Current >= Total) then
  Msg.Result := 0
 else
  Msg.Result := l3PCharLen(DoOnGetItem(Current)).SLen;
//#UC END# *51530E03032F_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMGetTextLength

procedure TvtCustomListerPrim.WMChar(var Msg: TWMChar);
//#UC START# *51530E1903CE_4CFFE36B00FA_var*
//#UC END# *51530E1903CE_4CFFE36B00FA_var*
begin
//#UC START# *51530E1903CE_4CFFE36B00FA_impl*
 inherited;
 if not (not (Char(Msg.CharCode) in [#8, #32..#255]) or
        (GetKeyState(VK_CONTROL) < 0) or
        (GetKeyState(VK_ALT) < 0)) then
  vlbProcessingChar(Msg);
//#UC END# *51530E1903CE_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMChar

procedure TvtCustomListerPrim.WMEraseBkgnd(var Msg: TWMEraseBkgnd);
//#UC START# *51530E2E0324_4CFFE36B00FA_var*
//#UC END# *51530E2E0324_4CFFE36B00FA_var*
begin
//#UC START# *51530E2E0324_4CFFE36B00FA_impl*
 {indicate that we have processed this message}
 Msg.Result := 1;
//#UC END# *51530E2E0324_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMEraseBkgnd

procedure TvtCustomListerPrim.WMGetDlgCode(var Msg: TWMGetDlgCode);
//#UC START# *51530E430047_4CFFE36B00FA_var*
//#UC END# *51530E430047_4CFFE36B00FA_var*
begin
//#UC START# *51530E430047_4CFFE36B00FA_impl*
 inherited;
 Msg.Result := Msg.Result or DLGC_WANTCHARS or DLGC_WANTARROWS;
//#UC END# *51530E430047_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMGetDlgCode

procedure TvtCustomListerPrim.WMHScroll(var Msg: TWMScroll);
//#UC START# *51530E6202F7_4CFFE36B00FA_var*
//#UC END# *51530E6202F7_4CFFE36B00FA_var*
begin
//#UC START# *51530E6202F7_4CFFE36B00FA_impl*
 case Msg.ScrollCode of
  SB_LINERIGHT : vlbHScrollPrim( + 1);
  SB_LINELEFT  : vlbHScrollPrim(-1);
  SB_PAGERIGHT : vlbHScrollPrim( + 10);
  SB_PAGELEFT  : vlbHScrollPrim(-10);
  SB_THUMBPOSITION,
  SB_THUMBTRACK :
   if f_HDelta <> Msg.Pos then
   begin
     f_HDelta := Msg.Pos;
     vlbSetHScrollPos;
     Refresh;
   end;
 end;
//#UC END# *51530E6202F7_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMHScroll

procedure TvtCustomListerPrim.CNKeyDown(var Msg: TWMKeyDown);
//#UC START# *51530E950290_4CFFE36B00FA_var*
var
 l_Time : Cardinal;
//#UC END# *51530E950290_4CFFE36B00FA_var*
begin
//#UC START# *51530E950290_4CFFE36B00FA_impl*
 {$IfNDef DesignTimeLibrary}
 Use;
 try
  afw.BeginOp;
  try
   l_Time := GetTickCount;
   if (SearchStr <> '') and
      (not ((GetKeyState(VK_CONTROL) < 0) or (GetKeyState(VK_SHIFT) < 0))) then
    case Msg.CharCode of
     VK_ESCAPE:
     begin
      SearchStr := '';
      Msg.Result := 0;
      Exit;
     end;
     VK_SPACE:
     begin
      inherited;
      Exit;
     end;
    end;
   if inherited ProcessMessage(TMessage(Msg), l_Time) then
   begin
    Msg.Result := -1;
    {indicate that this message was processed}
   end
   else
    inherited;
  finally
   afw.EndOp;
  end;//try..finally
 finally
  Free;
 end;//try..finally
 {$Else DesignTimeLibrary}
 case Msg.CharCode of
  VK_UP: if DoDoProcessCommand(ccUp) then
   Msg.Result := -1;
  VK_DOWN: if DoDoProcessCommand(ccDown) then
   Msg.Result := -1;
  VK_HOME: if DoDoProcessCommand(ccHome) then
   Msg.Result := -1;
  VK_END: if DoDoProcessCommand(ccEnd) then
   Msg.Result := -1;
  VK_PRIOR: if DoDoProcessCommand(ccPrevPage) then
   Msg.Result := -1;
  VK_NEXT: if DoDoProcessCommand(ccNextPage) then
   Msg.Result := -1;
 else
  inherited;
 end;
 {$EndIf DesignTimeLibrary}
//#UC END# *51530E950290_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CNKeyDown

{$If NOT Defined(DesignTimeLibrary)}
procedure TvtCustomListerPrim.WMSysKeyDown(var Msg: TWMSysKeyDown);
//#UC START# *51530EE30256_4CFFE36B00FA_var*
//#UC END# *51530EE30256_4CFFE36B00FA_var*
begin
//#UC START# *51530EE30256_4CFFE36B00FA_impl*
 inherited;
 //if Msg.Result <> 0 then // это не работает, потому что винда все равно Msg.Result в ноль сбрасывает
  CNKeyDown(Msg);
//#UC END# *51530EE30256_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMSysKeyDown
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvtCustomListerPrim.WMKillFocus(var Msg: TWMKillFocus);
//#UC START# *51530F130012_4CFFE36B00FA_var*
//#UC END# *51530F130012_4CFFE36B00FA_var*
begin
//#UC START# *51530F130012_4CFFE36B00FA_impl*
 inherited;
 {re-draw focused item to erase focus rect}
 if csDestroying in ComponentState then
  Exit;
 FreeHintWindow;
 if f_Caret <> nil then
  f_Caret.Linked := False;
 SearchStr := '';
 {DrawItem(f_Current);}
 Invalidate;

 {$IfDef Nemesis}
 ResetLastHint; // http://mdp.garant.ru/pages/viewpage.action?pageId=573686142
 {$EndIf Nemesis}
 
 {RepaintSelected(True);}
//#UC END# *51530F130012_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMKillFocus

procedure TvtCustomListerPrim.WMLButtonDown(var Msg: TWMLButtonDown);
//#UC START# *51530F3D00E7_4CFFE36B00FA_var*
var
 PickIcon : Boolean;
 
 function PointToIndex : LongInt;
 var
  Pt : TPoint;
 begin//PointToIndex
  PickIcon := False;
  GetCursorPos(Pt);
  Pt := ScreenToClient(Pt);
  if (Pt.Y < GetTopIndent) then
  begin
  {speed up as the cursor moves farther away}
   Result := f_TopIndex + (Pt.Y div CompleteRowHeight) - 1;
   if (Result < 0) then
    Result := 0;
  end//Pt.Y < GetTopIndent
  else
   if (Pt.Y >= ClientHeight) then
   begin
   {speed up as the cursor moves farther away}
    Result := f_TopIndex + (Pt.Y div CompleteRowHeight);
    if Result > f_HighIndex then
     Result := f_HighIndex;
   end//Pt.Y >= ClientHeight
   else
   begin
    {convert to an index}
    Result := ItemAtPos(Pt, True);
    PickIcon := vlbItemHitTest(Result, Pt) = ihtPickIcon;
   end;//Pt.Y >= ClientHeight
 end;//PointToIndex

var
 l_I               : LongInt;
 LastI           : LongInt;
 l_LeftButton    : Byte;
 CtrlKeyDown     : Boolean;
 ShiftKeyDown    : Boolean;
 AltKeyDown      : Boolean;
 lSelSave        : Integer;
 lCurPoint       : TPoint;
 lSaveStartPoint : TPoint;
 l_SavedHandle   : THandle;
 l_Current       : Integer;
 l_Point         : TPoint;
 l_ItemPart      : Byte;
 l_TmpPoint      : TPoint;
 l_Continue      : Boolean;
 l_Flag          : Boolean;
 l_DoAction      : Boolean;
//#UC END# *51530F3D00E7_4CFFE36B00FA_var*
begin
//#UC START# *51530F3D00E7_4CFFE36B00FA_impl*
 {$IfNDef DesignTimeLibrary}
 Use;
 try
 {$EndIf DesignTimeLibrary}
  afw.BeginOp;
  try
////////////////////////////////////////////////////////////////////////////////
// Изменения связанные с переносом SingleDoubleClick с                        //
// vtOutlinerWithSingleClick                                                  //
////////////////////////////////////////////////////////////////////////////////
   if f_InActionProcess then
    Exit;
   l_Continue := True;
   l_DoAction := False;
   l_Current := High(Integer);
   l_ItemPart := ihtNone;
   // предотвращаем повторное попадание в эту ветку в текущем сеансе фокуса в
   // компоненте
   if (GetTickCount - f_FocusedAt < 200) and
     (f_ActionElementMode <> l3_amSingleClick) then
    f_FocusedAt := 0;

   l_SavedHandle := High(l_SavedHandle);
   // - чтобы компилятор не выдрючивался
   if l_Continue then
   begin
    l_Flag := (($8000 and GetKeyState(VK_LSHIFT))   <> 0) or
              (($8000 and GetKeyState(VK_RSHIFT))   <> 0) or
              (($8000 and GetKeyState(VK_LCONTROL)) <> 0) or
              (($8000 and GetKeyState(VK_RCONTROL)) <> 0);
    if not l_Flag then
    begin
     if (f_ActionElementMode <> l3_amDoubleClick) then
     begin
      l_Point := SmallPointToPoint(Msg.Pos);
      if (f_ActionElementMode = l3_amSecondSingleClick) then
      begin
       // ранее не вычисляли
       if l_Current = High(Integer) then
        HitTest(l_Point, l_Current, l_ItemPart);
       if l_Current = Current then
        if (l_ItemPart = ihtText) or (l_ItemPart = ihtIcon) or
          (l_ItemPart = ihtPickIcon) then
         l_DoAction := True;
      end//f_ActionElementMode = l3_amSecondSingleClick
      else
       l_DoAction := True;
     end;//f_ActionElementMode <> l3_amDoubleClick
     f_DnDProcess := False;
     //т.к. в inherited нас могут убить
     l_SavedHandle := Handle;
    end;//not l_Flag
   end;//l_Continue
////////////////////////////////////////////////////////////////////////////////

   inherited;
   {is this click on the header?}
   FreeHintWindow;

   if l_ItemPart = ihtFooter then
   begin
    DoFooterClick;
    if Assigned(f_OnFooterClick) then
     f_OnFooterClick(Self);
    Exit;
   end;

   if (f_Total <> 0) then
   begin
    l_I := PointToIndex;
    if l_I < 0 then Exit;
    {get the actual left button}
    l_LeftButton := l3System.Mouse.LeftButton;

    {get the key state}
    AltKeyDown := GetKeyState(VK_Menu) and $8000 <> 0;
    if f_MultiSelect then
    begin
     CtrlKeyDown := GetKeyState(VK_CONTROL) and $8000 <> 0;
     ShiftKeyDown := GetKeyState(VK_SHIFT) and $8000 <> 0;
    end
    else
    begin
     CtrlKeyDown := False;
     ShiftKeyDown := False;
    end;

    if AltKeyDown then
    begin
     if (DragMode=dmManual) and (SelectedCount > 0)
     then BeginDrag(False)
    end
    else
     if CtrlKeyDown then
      vlbToggleSelection(l_I)
     else
      if ShiftKeyDown then
       SelectItems(l_I)
      else
      begin
       (* Работает и без этого предварительного сброса выделения,
          т.к. в операции pm_SetCurrent эта логика уже есть,
          а при работе с другими ветками она вроде не нужна.

       if (not PickedList) and (l_I <> f_Current) then
        vlbDeselectAllItems;
       *)

       {reselect the active item}

       (*pm_SetCurrent{vlbSetFocusedIndex}(f_Current);*)
       {watch the mouse position while the left button is down}
       LastI := -1;
       lSelSave := 0;
       if Assigned(f_OnLMouseDown) then
        with Msg do 
         f_OnLMouseDown(Self, mbLeft, KeysToShiftState(Keys), XPos, YPos);
       GetCursorPos(lSaveStartPoint);

       if not PickIcon and GetDragAndDropSupported then
       begin
        // В случае нескольких выделенных перетаскивать можно за любой
        // выделенный:
        if not (Selected[l_I] and (SelectedCount > 1)) then
         pm_SetCurrent(l_I)
        else
         f_NeedSelectFromPointAfterUpMouse := True;
        GetCursorPos(lCurPoint);
        if (lSaveStartPoint.X = lCurPoint.X) and
           (lSaveStartPoint.Y = lCurPoint.Y) and
           (l3System.Keyboard.AsyncKey[l_LeftButton].Down) then
         repeat
          GetCursorPos(lCurPoint);
          if (Abs(lSaveStartPoint.X - lCurPoint.X) > 1) or
             (Abs(lSaveStartPoint.Y - lCurPoint.Y) > 1) then
          begin
           f_DnDProcess := true;
           f_NeedSelectFromPointAfterUpMouse := False;
           TryDragAndDrop(l_I, VK_LBUTTON);
           break;
          end;
          afw.ProcessMessages;
         until not l3System.Keyboard.AsyncKey[l_LeftButton].Down;
        // В случае если пользователь нажал и отпустил кнопку мыши при этом
        // не сделав движение мышью, выделим пункт по которому он щелкнул:
        if f_NeedSelectFromPointAfterUpMouse then
        begin
         pm_SetCurrent(l_I);
         f_NeedSelectFromPointAfterUpMouse := False;
        end;
       end
       else
        repeat
         l_I := PointToIndex;
         if (l_I >= 0) and (l_I < f_Total) then
         begin
          if (lSaveStartPoint.X <> High(LongInt)) then GetCursorPos(lCurPoint);

          if (LastI= -1) or
             (lSaveStartPoint.X = High(LongInt)) or
              // для выделения нескольких мышью надо переместить мышь не менее чем на 5 точек
             (Abs(lSaveStartPoint.X - lCurPoint.X) > 5) or
             (Abs(lSaveStartPoint.Y - lCurPoint.Y) > 5) then

           if not f_MultiSelect or (LastI = -1) then
           begin
            pm_SetCurrent(l_I);
            if not FixAnchor then f_Anchor := l_I;
            LastI := l_I;
            //GetCursorPos(lSaveStartPoint);
            if PickIcon then
            begin
             SelectState[l_I] := -1; //next select state
             lSelSave := SelectState[l_I];
             {SelSave := not Selected[l_I];
             Selected[l_I] := SelSave;}
             InvalidateItem(l_I);
            end
            else
             lSelSave := 1;
           end
           else
           begin
             {extend/shrink the selection to follow the mouse}
             lSaveStartPoint.X := High(LongInt); // больше не проверяем
             if MultiSelect and (l_I <> LastI) then
             begin
              vlbDragSelection(f_Anchor, l_I, lSelSave);
              if PickIcon and not FixAnchor then f_Anchor := l_I;
              LastI := l_I;
             end;
           end;
          afw.ProcessMessages;  {Gasp}
         end;
        until not l3System.Keyboard.AsyncKey[l_LeftButton].Down;
      end;//ShiftKeyDown
   end;//f_Total <> 0

////////////////////////////////////////////////////////////////////////////////
// Изменения связанные с переносом SingleDoubleClick с                        //
// vtOutlinerWithSingleClick                                                  //
////////////////////////////////////////////////////////////////////////////////
   if l_Continue then
   begin
    if GetDragAndDropSupported then
    begin
     GetCursorPos(l_TmpPoint);
     l_TmpPoint := ScreenToClient(l_TmpPoint);
     if (l_TmpPoint.X <> l_Point.X) or (l_TmpPoint.Y <> l_Point.Y) then
      l_DoAction := False;
    end;//GetDragAndDropSupported
    if l_DoAction and (not f_DnDProcess) then
    begin
     f_InActionProcess := True;
     try
      Sleep(100);
      afw.ProcessMessages;
      with l_Point do
       PostMessage(l_SavedHandle, WM_U_ARTFULBEHAVIOUR, X, Y);
     finally
      f_InActionProcess := False;
     end;//try..finally
    end;//l_DoAction..
   end;//l_Continue
   ////////////////////////////////////////////////////////////////////////////////
   f_DnDProcess := false;
  finally
   afw.EndOp;
  end;
 {$IfNDef DesignTimeLibrary}
 finally
  Free;
 end;
 {$EndIf DesignTimeLibrary}
//#UC END# *51530F3D00E7_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMLButtonDown

procedure TvtCustomListerPrim.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
//#UC START# *5153106C03CC_4CFFE36B00FA_var*
var
 L : Boolean;
//#UC END# *5153106C03CC_4CFFE36B00FA_var*
begin
//#UC START# *5153106C03CC_4CFFE36B00FA_impl*
 case f_ActionElementMode of
  l3_amDoubleClick :
  begin
   {DblClick;}
   {is this click below the header, if any}
   //if (Msg.YPos > GetTopIndent)
   if ItemAtPos(SmallPointToPoint(Msg.Pos), True) >= 0 then
   begin
    L := Focused;
    inherited;
    if L and not f_InActionProcess then
     DoOnActionElement(f_Current);
   end
   else
    {say we processed this message}
    Msg.Result := 0;
  end;
  l3_amSecondSingleClick :
   WMLButtonDown(Msg);
 end;//case f_ActionElementMode
//#UC END# *5153106C03CC_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMLButtonDblClk

procedure TvtCustomListerPrim.WMRButtonDown(var Message: TWMRButtonDown);
//#UC START# *515310E30131_4CFFE36B00FA_var*
var
 lInd : LongInt;
//#UC END# *515310E30131_4CFFE36B00FA_var*
begin
//#UC START# *515310E30131_4CFFE36B00FA_impl*
 FreeHintWindow;
 //lInd := MousePointToIndex;
 lInd := ItemAtPos({Pt}Point(Message.XPos, Message.YPos), False);

 if (lInd >= 0) and (lInd < Total) and (PickedList or not Selected[lInd]) then
 begin
  Current := lInd;
  if not FixAnchor then f_Anchor := lInd;
 end;

 if Assigned(f_OnRMouseDown) then
  with Message do 
   f_OnRMouseDown(Self, mbRight, KeysToShiftState(Keys), XPos, YPos);
 inherited;
//#UC END# *515310E30131_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMRButtonDown

procedure TvtCustomListerPrim.WMMouseActivate(var Msg: TWMMouseActivate);
//#UC START# *515310FF0095_4CFFE36B00FA_var*
//#UC END# *515310FF0095_4CFFE36B00FA_var*
begin
//#UC START# *515310FF0095_4CFFE36B00FA_impl*
 if csDesigning in ComponentState then
  Exit;
 inherited;
 if CanFocus then
  SetFocus;
//#UC END# *515310FF0095_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMMouseActivate

procedure TvtCustomListerPrim.WMMouseMove(var Message: TWMMouseMove);
//#UC START# *5153111A017A_4CFFE36B00FA_var*
var
 Indx      : LongInt;
 l_Point   : TPoint;
 l_Context : Byte;
 lCursor   : TCursor;
procedure ProcessToolTips;
  var
   l_CalcWidth: Integer;
   SP             : TPoint;
   l_R, DisplayRect : TRect;
   l_SwapDisplayRect: TRect;
   St             : Il3CString;
   l_TextHint     : Il3CString;
   l_WidthHint    : Il3CString;
   lTextWidth,
   lTextHeight    : Integer;
   lIsIconHint    : Boolean;
   l_Rect         : TRect;
   l_IsTextHint   : Boolean;
   l_TextColumn   : Integer;
   l_ColumnPos    : Integer;
   l_I              : Integer;
   l_StrRest,
   l_StrSub       : Tl3PCharLen;

  procedure DropHint;
  begin
   f_LastHintContext := ihtNone;
   f_LastHintTextColumn := -1;
   if SearchStr = '' then
    FreeHintWindow;
  end;

  procedure lp_RecalcWidthHeight;
  var
   l_Canvas: Il3InfoCanvas;
  const
   c_HintItemPart: array[Boolean] of TvtListerItemPart = (vt_lipIconHint, vt_lipTextHint);
  begin
   l_Canvas := l3CrtIC;
   l_Canvas.Lock;
   try
    InitItemFont(Indx, l_Canvas.Font, c_HintItemPart[lIsIconHint]);
    l_Rect.Left := 0;
    l_Rect.Top := 0;
    l_Rect.Right := 0;
    l_Rect.Bottom := 0;
    l_Canvas.DrawText(l3PCharLen(St), l_Rect, DT_CALCRECT or
     DT_LEFT or DT_NOPREFIX or DrawTextBiDiModeFlagsReadingOnly);
   finally
    l_Canvas.Unlock;
   end;//try..finally
   lTextWidth := l_Rect.Right - l_Rect.Left;
   lTextHeight := l_Rect.Bottom - l_Rect.Top;
  end;

  begin

   if not Application.Active then
    Exit;

   l_IsTextHint := False;

   l_ColumnPos := High(l_ColumnPos);
   // - чтобы компилятор не выебывался

   l_TextColumn := High(l_TextColumn);
   // - чтобы компилятор не выебывался
   
   // Определяем, в какой колонке находится курсор мыши (если многоколоночный листер):
   if f_UseTabStops and (f_Header.Sections.Count > 0) then
   begin
    SP := Self.ScreenToClient(l_Point);
    l_ColumnPos := 0;
    l_TextColumn := -1;
    for l_I := 0 to Pred(f_Header.Sections.Count) do
    begin
     Inc(l_ColumnPos, f_Header.SectionWidth[l_I]);
     if SP.X <= l_ColumnPos then
     begin
      l_TextColumn := l_I;
      Break;
     end;
    end;
   end;

   if (Indx <> f_LastHintIndex ) or
      (l_TextColumn <> f_LastHintTextColumn) or
      (l_Context <> f_LastHintContext) then
    begin
     if f_HintTimerCount > 0 then
      if f_SearchStr = '' then
       FreeHintWindow
      else
        if (f_OldMousePos.X <> l_Point.X) or (f_OldMousePos.Y <> l_Point.Y) then
         FreeHintWindow;
     if (Indx = -1) or (Indx >= Total) then
     begin
      ResetLastHint;
      Exit;
     end;

     DisplayRect := GetDrawTextRect(Indx);
     l_SwapDisplayRect := DisplayRect;

     St := nil;
     l_TextHint := nil;
     l_WidthHint := nil;
     lIsIconHint := false;
     if l_Context = ihtIcon then
     begin
      St := DoOnGetItemIconHint(Indx);
      if l3IsNil(St) then
      begin
       ResetLastHint;
       Exit;
      end;
      lIsIconHint := true;
     end;

     if (not lIsIconHint) {and (not f_MultiStrokeItem)} then
     begin
      // Получим hint при задержке курсора в области текста
      l_TextHint := DoOnGetItemTextHint(Indx);
      St := l_TextHint;
      l_IsTextHint := not l3IsNil(l_TextHint);
      if IsHintNeededForAnElement(Indx) then
      begin
       l_WidthHint := GetHint(Indx);
       // режем на куски, чтобы понять, что показывать (в случае многостолбцовости)
       if f_UseTabStops and (f_Header.Sections.Count > 0) then
       begin
        if l_TextColumn = -1 then
         l_WidthHint := nil
        else
        begin
         l_StrRest := l3PCharLen(l_WidthHint);
         for l_I := 0 to l_TextColumn do
         begin
          l_StrSub := l_StrRest;
          l_StrRest := l3FindChar(cc_Tab, l_StrSub);
         end;
         if l_StrSub.IsLast(cc_Tab) then
          Dec(l_StrSub.SLen);
         l_WidthHint := l3CStr(l_StrSub);
         with DisplayRect do
         begin
          Right := Left + l_ColumnPos - vt_TabbedMLOutGap;
          Left := Right - f_Header.SectionWidth[l_TextColumn] + vt_TabbedMLOutGap;
         end;
        end
       end;
       St := l_WidthHint;
      end;
     end;

     if not lIsIconHint and (DisplayRect.Left >= ClientRect.Right) then
     begin
      ResetLastHint;
      Exit;
     end;

     lp_RecalcWidthHeight;


     // Если элемент помещается целиком и hint к тексту (который выводится в
     // любом случае) не определен, то показывать не нужно
     if not lIsIconHint and not l3IsNil(l_WidthHint) then
      with DisplayRect do
      begin
       if (l_TextColumn = 0) and Assigned(Images) then // Если это первый столбец, то надо
        l_CalcWidth := Images.Width + ImageAddSpace   // учесть ширину картинки тоже
       else
        l_CalcWidth := 0;
       if lTextWidth <= Right - Left - l_CalcWidth then
       begin
        if l_IsTextHint then
        begin
         DisplayRect := l_SwapDisplayRect;
         St := l_TextHint;
         lp_RecalcWidthHeight;
        end
        else
        begin
         DropHint;
         ResetLastHint;
         Exit;
        end;
       end
       else
        l_IsTextHint := False;
      end;

     if l3IsNil(St) then
     begin
      ResetLastHint;
      Exit;
     end;

     if lIsIconHint then
     begin
      l_R.Left := Mouse.CursorPos.X + 5;
      l_R.Top := Mouse.CursorPos.Y + 5;
      l_R.Right := l_R.Left + lTextWidth + 6;
      l_R.Bottom := l_R.Top + lTextHeight + 2;
     end
     else
     begin
      SP := self.ClientToScreen(Point(0, 0));
      if f_UseTabStops and (l_TextColumn <> 0) and (Images <> nil) then
      begin
       Dec(DisplayRect.Right, Images.Width + ImageAddSpace);
       Dec(DisplayRect.Left, Images.Width + ImageAddSpace);
      end;


      l_R.Left := DisplayRect.Left + sp.x - 1;
      l_R.Top := DisplayRect.Top + sp.y - 3;
      l_R.Right := l_R.Left + lTextWidth + 6;
      l_R.Bottom := DisplayRect.Top + lTextHeight + sp.y - 2;
      // Сместим, если это hint для области текста, который показывается всегда,
      // на высоту строки текста и чуть вправо
      if l_IsTextHint then
       OffsetRect(l_R, cXOffsetTextHint, lTextHeight);
     end;

     if (DisplayRect.Bottom - DisplayRect.Top) > lTextHeight then
     case f_VJustify of
      //vt_vjTop :;
      vt_vjBottom :
       l_R.Top := DisplayRect.Bottom - lTextHeight;
      vt_vjCenter :
       l_R.Top := l_R.Top + (DisplayRect.Bottom - DisplayRect.Top - lTextHeight) div 2;
     end;

     f_LastHintIndex := Indx;
     f_LastHintContext := l_Context;
     f_LastHintTextColumn := l_TextColumn;
     if (l_Context = ihtIcon) or (l_Context = ihtText) then
     begin
      TvtMultilineHint.vtActivateHint(GetHintWindow, l_R, St);//use f_HintWindow
      f_HintTimer.Enabled := True;
     end;//(l_Context = ihtIcon) or (l_Context = ihtText)
    {end
    else
    begin
     f_LastHintIndex := -1;
     f_LastHintContext := ihtNone;}
    end;
 end;
//#UC END# *5153111A017A_4CFFE36B00FA_var*
begin
//#UC START# *5153111A017A_4CFFE36B00FA_impl*
 inherited;
 if ([vlMouseTrack, vlTooltips] * Options <> []) or
    Assigned(f_OnGetItemCursor) then
 begin
   //Indx := MousePointToIndex;
  Indx := ItemAtPos(Point(Message.xPos, Message.yPos), False);
  if Indx < 0 then
  begin
   if Assigned(f_OnGetItemCursor) then
   SetCursorForItem(-1);
   Exit;
  end;
  GetCursorPos(l_Point);
  l_Context := vlbItemHitTest(Indx, l_Point, true);

  //http://mdp.garant.ru/pages/viewpage.action?pageId=361399733
  if (vlMouseTrack in Options) AND NeedChangeCurrentOnMouseTrack
      // http://mdp.garant.ru/pages/viewpage.action?pageId=324567330
      // http://mdp.garant.ru/pages/viewpage.action?pageId=271749979
      and IsMouseMoved(l_Point) then
   Current := Indx;

  if vlTooltips in Options then
   ProcessToolTips;

  if Assigned(f_OnGetItemCursor) then
  begin
   lCursor := f_OnGetItemCursor(Self, Indx);
   SetCursorForItem(Indx);
   if lCursor = crDefault then
    lCursor := Cursor;
   Windows.SetCursor(Screen.Cursors[lCursor]);
  end;
 end;
 f_OldMousePos := l_Point;
//#UC END# *5153111A017A_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMMouseMove

procedure TvtCustomListerPrim.WMSetFocus(var Msg: TWMSetFocus);
//#UC START# *515311350263_4CFFE36B00FA_var*
//#UC END# *515311350263_4CFFE36B00FA_var*
begin
//#UC START# *515311350263_4CFFE36B00FA_impl*
 inherited;
 //Update;
 Invalidate;
 if f_Caret <> nil then
  f_Caret.Linked := True;
 f_FocusedAt := GetTickCount;
//#UC END# *515311350263_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMSetFocus

procedure TvtCustomListerPrim.WMSize(var Msg: TWMSize);
//#UC START# *515311520396_4CFFE36B00FA_var*
//#UC END# *515311520396_4CFFE36B00FA_var*
begin
//#UC START# *515311520396_4CFFE36B00FA_impl*
 Include(f_States, vt_lsSizing);
 try
  inherited;
  DropDrawPoints;
  if RowHeight > 0 then
  begin
   f_Rows := (ClientHeight - GetTopIndent + Pred(CompleteRowHeight)) div CompleteRowHeight;
   vlbAdjustIntegralHeight;
   if AlignTopIndex then
    DropDrawPoints;
   vlbInitScrollInfo;
   if not ShowHeader then
    f_Header.Width := Width;
  end;//if RowHeight > 0 then
  if Assigned(f_OnResize) then
   f_OnResize(Self);
 finally
  Exclude(f_States, vt_lsSizing);
 end;
//#UC END# *515311520396_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMSize

procedure TvtCustomListerPrim.WMVScroll(var Msg: TWMScroll);
//#UC START# *5153116A00B5_4CFFE36B00FA_var*
{$IfDef Nemesis}
 {$IfOpt D-}
  {$Define NonTrackScroll}
 {$EndIf D-}
{$EndIf Nemesis}

 function lGetScrollPos : Integer;
  var
   l_ScrollInfo : TScrollInfo;
  begin
   with l_ScrollInfo do
   begin
    cbSize := SizeOf(l_ScrollInfo);
    fMask := SIF_TrackPos or SIF_PAGE or SIF_RANGE;
   end;//with l_ScrollInfo
   GetScrollInfo(Handle, SB_Vert, l_ScrollInfo);

   if Msg.ScrollCode = SB_THUMBTRACK then
    Result := l_ScrollInfo.nTrackPos
   else
    Result := GetScrollPos(Handle, SB_Vert);

   // подгонка конца списка если thumb уперся в низ скроллинга
   // в общем не стирать ни в коем случае
   with l_ScrollInfo do
    if Result > nMax - nPage then
     Result := Pred(Total);
  end;
{$IfDef NonTrackScroll}
var
 l_ScrollInfo : TScrollInfo;
{$EndIf NonTrackScroll}
//#UC END# *5153116A00B5_4CFFE36B00FA_var*
begin
//#UC START# *5153116A00B5_4CFFE36B00FA_impl*
 //f_InScroll := True;
 case Msg.ScrollCode of
   SB_LINEUP :
    vlbVScrollPrim(-1);
   SB_LINEDOWN :
    vlbVScrollPrim( + 1);
   SB_PAGEDOWN :
    vlbVScrollPrim(Max(ItemOnScreen(True) - 1, 1));
   SB_PAGEUP :
    vlbVScrollPrim(-Max(ItemOnScreen(True) - 1, 1));
   SB_THUMBPOSITION :
    pm_SetTopIndex(Min(lGetScrollPos,Pred(Total)));
   SB_THUMBTRACK :
   begin
    {$IfDef NonTrackScroll}
    if NonTrackScroll then
    begin
     with l_ScrollInfo do
     begin
      cbSize := SizeOf(l_ScrollInfo);
      fMask := SIF_TRACKPOS;
     end;
     GetScrollInfo(Handle, SB_VERT, l_ScrollInfo);
     SetScrollPos(Handle, SB_VERT, l_ScrollInfo.nTrackPos, True);
    end//NonTrackScroll
    else
    {$EndIf NonTrackScroll}
     vlbSetTopIndexPrim(Min(lGetScrollPos,Pred(Total)));
   end;
   SB_ENDSCROLL :
    f_InScroll := False;
 end;
//#UC END# *5153116A00B5_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMVScroll

procedure TvtCustomListerPrim.WMSetCursor(var Msg: TWMSetCursor);
//#UC START# *515311A302C1_4CFFE36B00FA_var*
var
 l_Point: TPoint;
 l_Current: Integer;
 l_ItemPart: Byte;
//#UC END# *515311A302C1_4CFFE36B00FA_var*
begin
//#UC START# *515311A302C1_4CFFE36B00FA_impl*
 inherited;
 (* пользователь деревом сам устанавливает вид курсора, ВЫХОДИМ *)
 if Msg.HitTest = HTCLIENT then
 begin
  if Assigned(OnGetItemCursor) then
   Exit;
  GetCursorPos(l_Point);
  l_Point := ScreenToClient(l_Point);
  HitTest(l_Point, l_Current, l_ItemPart);
  SetCursorForItem(l_Current);
  UpdateFooterActivity(l_ItemPart = ihtFooter);
  if ((f_ActionElementMode = l3_amSingleClick) or
      ((f_ActionElementMode = l3_amSecondSingleClick) and (l_Current = Current) and Focused)) and
     ((l_ItemPart = ihtText) or (l_ItemPart = ihtIcon) or (l_ItemPart = ihtPickIcon)) then
   Windows.SetCursor(Screen.Cursors[crHandPoint])
   //Cursor := crHandPoint
  else
   if l_ItemPart = ihtFooter then
    Windows.SetCursor(Screen.Cursors[crHandPoint])
   else
    Windows.SetCursor(Screen.Cursors[crDefault]);
   //Cursor := crDefault;
 end;  
//#UC END# *515311A302C1_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMSetCursor

procedure TvtCustomListerPrim.WMUArtfulBehaviour(var Msg: TMessage);
//#UC START# *515311E3022D_4CFFE36B00FA_var*
var
 l_Current  : Integer;
 l_ItemPart : Byte;
 l_Point    : TPoint;
//#UC END# *515311E3022D_4CFFE36B00FA_var*
begin
//#UC START# *515311E3022D_4CFFE36B00FA_impl*
 l_Point := Point(Msg.wParam, Msg.lParam);
 HitTest(l_Point, l_Current, l_ItemPart);
 if l_Current = Current then
  if (l_ItemPart = ihtText) or (l_ItemPart = ihtIcon) or (l_ItemPart = ihtPickIcon) then
   DoOnActionElement(l_Current);
//#UC END# *515311E3022D_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMUArtfulBehaviour

procedure TvtCustomListerPrim.msgvtUpdateScroll(var Msg: TMessage);
//#UC START# *515312680164_4CFFE36B00FA_var*
var
 l_Msg : TMsg;
//#UC END# *515312680164_4CFFE36B00FA_var*
begin
//#UC START# *515312680164_4CFFE36B00FA_impl*
 if (f_UpdateFlags <> []) then
 begin
  if InUpdating or f_InScroll then
  begin
   if PeekMessage(l_Msg, Handle, Low(UINT), High(UINT), PM_NOREMOVE) then
   begin
    with Msg do
     if (l_Msg.Message <> Msg) AND (l_Msg.Message <> WM_Paint) then
      PostMessage(Handle, Msg, WParam, LParam)
     else
     begin
      // - нужно перепослать сообщение Msg, но после отработки ProcessMessages
      //   как это сделать - непонятно. :-(
     end;//l_Msg.Message <> Msg
    Exit;
   end;//PeekMessage
  end;//InUpdating
  if (vt_ufHInfo in f_UpdateFlags) then
   vlbSetHScrollRange;
  if (vt_ufHPos in f_UpdateFlags) then
   vlbSetHScrollPos;
  if (vt_ufVInfo in f_UpdateFlags) then
   vlbSetVScrollRange;
  if (vt_ufVPos in f_UpdateFlags) then
   vlbSetVScrollPos;
  //Invalidate;
  //Perform(WM_NCPaint, 0, 0);
  InvalidateNonclientArea;
  // - закомментировал WM_NCPaint и добавил вот это, ибо
  // WM_NCPaint в борьбе с невидимостью скроллбаров все равно не помогает
  // http://mdp.garant.ru/pages/viewpage.action?pageId=514869678&focusedCommentId=515536527#comment-515536527
 end;//f_UpdateFlags <> []
//#UC END# *515312680164_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.msgvtUpdateScroll

procedure TvtCustomListerPrim.LBGetCaretIndex(var Msg: TMessage);
//#UC START# *515313DE000A_4CFFE36B00FA_var*
//#UC END# *515313DE000A_4CFFE36B00FA_var*
begin
//#UC START# *515313DE000A_4CFFE36B00FA_impl*
 Msg.Result := f_Current {lFocusedIndex};
//#UC END# *515313DE000A_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBGetCaretIndex

procedure TvtCustomListerPrim.LBGetCount(var Msg: TMessage);
//#UC START# *515313F902B4_4CFFE36B00FA_var*
//#UC END# *515313F902B4_4CFFE36B00FA_var*
begin
//#UC START# *515313F902B4_4CFFE36B00FA_impl*
 Msg.Result := f_Total;
//#UC END# *515313F902B4_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBGetCount

procedure TvtCustomListerPrim.LBGetCurSel(var Msg: TMessage);
//#UC START# *5153140D02DB_4CFFE36B00FA_var*
//#UC END# *5153140D02DB_4CFFE36B00FA_var*
begin
//#UC START# *5153140D02DB_4CFFE36B00FA_impl*
 Msg.Result := f_Current;
//#UC END# *5153140D02DB_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBGetCurSel

procedure TvtCustomListerPrim.LBGetItemHeight(var Msg: TMessage);
//#UC START# *51531427022D_4CFFE36B00FA_var*
//#UC END# *51531427022D_4CFFE36B00FA_var*
begin
//#UC START# *51531427022D_4CFFE36B00FA_impl*
 Msg.Result := GetItemHeight(Msg.wParam);
//#UC END# *51531427022D_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBGetItemHeight

procedure TvtCustomListerPrim.LBGetItemRect(var Msg: TMessage);
//#UC START# *5153145A01A1_4CFFE36B00FA_var*
//#UC END# *5153145A01A1_4CFFE36B00FA_var*
begin
//#UC START# *5153145A01A1_4CFFE36B00FA_impl*
 PRect(Msg.Result)^ := Rect(0, 0, ClientWidth, RowHeight);
//#UC END# *5153145A01A1_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBGetItemRect

procedure TvtCustomListerPrim.LBGetSel(var Msg: TMessage);
//#UC START# *5153147503BF_4CFFE36B00FA_var*
//#UC END# *5153147503BF_4CFFE36B00FA_var*
begin
//#UC START# *5153147503BF_4CFFE36B00FA_impl*
 if (Msg.wParam >= 0) and (Msg.wParam <= f_HighIndex) then
  Msg.Result := Ord(DoOnIsSelected(Msg.wParam))
 else
  Msg.Result := LB_ERR;
//#UC END# *5153147503BF_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBGetSel

procedure TvtCustomListerPrim.LBGetTopIndex(var Msg: TMessage);
//#UC START# *5153148B01DE_4CFFE36B00FA_var*
//#UC END# *5153148B01DE_4CFFE36B00FA_var*
begin
//#UC START# *5153148B01DE_4CFFE36B00FA_impl*
 Msg.Result := f_TopIndex;
//#UC END# *5153148B01DE_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBGetTopIndex

procedure TvtCustomListerPrim.LBResetContent(var Msg: TMessage);
//#UC START# *515314A201D3_4CFFE36B00FA_var*
//#UC END# *515314A201D3_4CFFE36B00FA_var*
begin
//#UC START# *515314A201D3_4CFFE36B00FA_impl*
 Total := 0;
//#UC END# *515314A201D3_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBResetContent

procedure TvtCustomListerPrim.LBSelItemRange(var Msg: TMessage);
//#UC START# *515314F70356_4CFFE36B00FA_var*
//#UC END# *515314F70356_4CFFE36B00FA_var*
begin
//#UC START# *515314F70356_4CFFE36B00FA_impl*
 if f_MultiSelect and
    {(Msg.lParamLo >= 0) and}
    // - это закомментированно, т.к. проверяется типом
    (Msg.wParamLo <= f_HighIndex) and
    {(Msg.lParamHi >= 0) and}
    // - это закомментированно, т.к. проверяется типом
    (Msg.wParamHi <= f_HighIndex) then
 begin
  vlbSelectRangePrim(Msg.lParamLo, Msg.lParamHi, Msg.wParam > 0);
  Msg.Result := 0;
 end else
  Msg.Result := LB_ERR;
//#UC END# *515314F70356_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBSelItemRange

procedure TvtCustomListerPrim.LBSetCurSel(var Msg: TMessage);
//#UC START# *5153150E00C1_4CFFE36B00FA_var*
//#UC END# *5153150E00C1_4CFFE36B00FA_var*
begin
//#UC START# *5153150E00C1_4CFFE36B00FA_impl*
 if f_MultiSelect and (Msg.wParam >= -1) and (Msg.wParam <= f_HighIndex) then
 begin
  pm_SetCurrent(Msg.wParam);
  if Msg.wParam = $FFFF then
    Msg.Result := LB_ERR
  else
    Msg.Result := 0;
 end else
  Msg.Result := LB_ERR;
//#UC END# *5153150E00C1_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBSetCurSel

procedure TvtCustomListerPrim.LBSetSel(var Msg: TMessage);
//#UC START# *5153153F032A_4CFFE36B00FA_var*
//#UC END# *5153153F032A_4CFFE36B00FA_var*
begin
//#UC START# *5153153F032A_4CFFE36B00FA_impl*
 if f_MultiSelect and (Msg.lParam >= -1) and (Msg.lParam <= f_HighIndex) then
 begin
  if Msg.lParam = -1
   then vlbSetAllItemsPrim(Msg.wParam > 0)
   else
  begin
   DoOnSelect(Msg.lParam, Msg.wParam);
   InvalidateItem(Msg.lParam);
  end;
  Msg.Result := 0;
 end else
  Msg.Result := LB_ERR;
//#UC END# *5153153F032A_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBSetSel

procedure TvtCustomListerPrim.LBSetTabStops(var Msg: TMessage);
//#UC START# *515315610006_4CFFE36B00FA_var*
var
 I : Integer;
//#UC END# *515315610006_4CFFE36B00FA_var*
begin
//#UC START# *515315610006_4CFFE36B00FA_impl*
 f_NumTabStops := Msg.wParam;
 if (f_NumTabStops > MaxTabStops) then
 begin
  f_NumTabStops := MaxTabStops;
  Msg.Result := 0;  {didn't set all tabs}
 end//f_NumTabStops > MaxTabStops
 else
   Msg.Result := 1;

(*  if (lTabs = nil) then
 begin
  New(lTabs);
  l3FillChar(lTabs^, SizeOf(lTabs^));
 end;//lTabs
 for I := 0 to Pred(f_NumTabStops) do
   lTabs^[I] := PTabStopArray(Msg.lParam)^[I] {* f_DlgUnits};*)
//#UC END# *515315610006_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBSetTabStops

procedure TvtCustomListerPrim.LBSetTopIndex(var Msg: TMessage);
//#UC START# *5153158D02C0_4CFFE36B00FA_var*
//#UC END# *5153158D02C0_4CFFE36B00FA_var*
begin
//#UC START# *5153158D02C0_4CFFE36B00FA_impl*
 if (Msg.wParam >= 0) and (Msg.wParam <= f_HighIndex) then
 begin
  pm_SetTopIndex(Msg.wParam);
  Msg.Result := 0;
 end else
  Msg.Result := LB_ERR;
//#UC END# *5153158D02C0_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.LBSetTopIndex

procedure TvtCustomListerPrim.WMWindowPosChanged(var Msg: TWMWindowPosChanged);
//#UC START# *52E8BAB100AC_4CFFE36B00FA_var*
var
 l_Flags: UINT;
 l_WP: PWindowPos;
//#UC END# *52E8BAB100AC_4CFFE36B00FA_var*
begin
//#UC START# *52E8BAB100AC_4CFFE36B00FA_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=514869678
 l_WP := Msg.WindowPos;
 l_Flags := l_WP^.flags;
 if (vt_lsUpdatingNCArea in f_States) AND
  (l_Flags and SWP_NOMOVE <> 0) AND
  (l_Flags and SWP_NOSIZE <> 0) AND
  (l_Flags and SWP_NOZORDER <> 0) AND
  (l_Flags and SWP_FRAMECHANGED <> 0) AND
  (l_Flags and SWP_NOACTIVATE <> 0) then
 begin
  //http://mdp.garant.ru/pages/viewpage.action?pageId=516166484
  Exclude(f_States, vt_lsUpdatingNCArea);
  Msg.Result := 0;
 end
 else
  inherited;
//#UC END# *52E8BAB100AC_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WMWindowPosChanged

procedure TvtCustomListerPrim.InvalidateNCArea(var Message: TMessage);
//#UC START# *567411020074_4CFFE36B00FA_var*
//#UC END# *567411020074_4CFFE36B00FA_var*
begin
//#UC START# *567411020074_4CFFE36B00FA_impl*
 InvalidateNonclientArea;
//#UC END# *567411020074_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.InvalidateNCArea

function TvtCustomListerPrim.FooterFontStored: Boolean;
 {* "Функция определяющая, что свойство FooterFont сохраняется" }
//#UC START# *8A8A15D95C04_4CFFE36B00FA_var*
//#UC END# *8A8A15D95C04_4CFFE36B00FA_var*
begin
//#UC START# *8A8A15D95C04_4CFFE36B00FA_impl*
 Result := not UseStyleTable;
//#UC END# *8A8A15D95C04_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.FooterFontStored

function TvtCustomListerPrim.FooterActiveFontStored: Boolean;
 {* "Функция определяющая, что свойство FooterActiveFont сохраняется" }
//#UC START# *8B2B603F5F28_4CFFE36B00FA_var*
//#UC END# *8B2B603F5F28_4CFFE36B00FA_var*
begin
//#UC START# *8B2B603F5F28_4CFFE36B00FA_impl*
 Result := not UseStyleTable;
//#UC END# *8B2B603F5F28_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.FooterActiveFontStored

function TvtCustomListerPrim.HeaderStored: Boolean;
 {* "Функция определяющая, что свойство Header сохраняется" }
//#UC START# *EF11BF564CE4_4CFFE36B00FA_var*
//#UC END# *EF11BF564CE4_4CFFE36B00FA_var*
begin
//#UC START# *EF11BF564CE4_4CFFE36B00FA_impl*
 Result := (f_Header <> nil) AND (f_Header.Sections.Count > 0);
//#UC END# *EF11BF564CE4_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.HeaderStored

function TvtCustomListerPrim.ImagesStored: Boolean;
 {* "Функция определяющая, что свойство Images сохраняется" }
//#UC START# *03FA4B130756_4CFFE36B00FA_var*
//#UC END# *03FA4B130756_4CFFE36B00FA_var*
begin
//#UC START# *03FA4B130756_4CFFE36B00FA_impl*
 Result := GetImagesStored;
//#UC END# *03FA4B130756_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.ImagesStored

{$If NOT Defined(DesignTimeLibrary)}
procedure TvtCustomListerPrim.StyleTableChanged;
 {* таблица стилей изменилась. }
//#UC START# *467D2CB10135_4CFFE36B00FA_var*
var
 l_C : TColor;
//#UC END# *467D2CB10135_4CFFE36B00FA_var*
begin
//#UC START# *467D2CB10135_4CFFE36B00FA_impl*
 if UseStyleTable then
 begin
  evGetStyleFont(Font, f_StyleId);
  l_C := evGetStyleBackColor(f_StyleId);
  if (l_C = clDefault) then
  begin
   if TreatDefaultColorAsWindowColor then
    Color := clWindow;
  end else
   Color := l_C;
  evGetStyleFont(FooterFont, f_FooterStyleID);
  evGetStyleFont(FooterActiveFont, f_FooterActiveStyleID);
 end;//UseStyleTable
//#UC END# *467D2CB10135_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.StyleTableChanged
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvtCustomListerPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4CFFE36B00FA_var*
//#UC END# *479731C50290_4CFFE36B00FA_var*
begin
//#UC START# *479731C50290_4CFFE36B00FA_impl*
(* if (lTabs <> nil) then
  Dispose(lTabs);*)
 Images := nil;
 // - это чтобы отрегистрировать себя из Images
 FreeHintWindow; {l3Free(fHintWindow);}

 l3Free(f_DrawPoints);
 l3Free(f_ProtectColor);
 l3Free(f_SelectColor);
 l3Free(f_SelectNonFocusColor);
 l3Free(f_SelectArray);

  //for I := 0 to 2 do l3Free(FPickBMPArray[I]);

 {$IfNDef DesignTimeLibrary}
 evDelStyleTableSpy(Self);
 {$EndIf DesignTimeLibrary}

 l3Free(f_Caret);
 l3Free(f_FooterFont);
 l3Free(f_FooterActiveFont);
 inherited;
//#UC END# *479731C50290_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.Cleanup

constructor TvtCustomListerPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4CFFE36B00FA_var*
//#UC END# *47D1602000C6_4CFFE36B00FA_var*
begin
//#UC START# *47D1602000C6_4CFFE36B00FA_impl*
 inherited;
 f_TreatDefaultColorAsWindowColor := True;
 f_FooterFont := TafwFont.Create;
 f_FooterActiveFont := TafwFont.Create;
 ControlStyle := ControlStyle + [csOpaque]
                              - [csCaptureMouse, csClickEvents];
 ViewOptions := [];
 {set default values for inherited persistent properties}
 Align := DefAlign;
 Color := DefColor;
 Ctl3D := DefCtl3D;
 Height := 150;
 ParentColor := DefParentColor;
 ParentCtl3D := DefParentCtl3D;
 TabStop := DefTabStop;
 Width := 100;

 {set default values for new persistent properties}
 f_AutoRowHeight := DefAutoRowHeight;
 BorderStyle := DefBorderStyle;
 f_Columns := DefColumns;
 f_IntegralHeight := DefIntegralHeight;
 f_Current := DefItemIndex;
 f_MultiSelect := DefMultiSelect;
 f_Total := DefNumItems;
 {f_RowHeight := DefRowHeight;}
 {lMinRowHeight := 0;}

 ScrollStyle := DefScrollBars;
 f_TopIndex := DefTopIndex;
 f_UseTabStops := DefUseTabStops;

 {set defaults for internal variables}
 f_HDelta := 0;
 //lHaveHS := False;
 //lHaveVS := False;

 f_Anchor := 0;
 (*f_Current {lFocusedIndex} := DefItemIndex;*)

 f_NumTabStops := 0;

 {create and initialize color objects}
 f_ProtectColor := TOvcColors.Create(DefProtectText, DefProtectBack);
 f_ProtectColor.OnColorChange := vlbColorChanged;
 f_SelectColor := TOvcColors.Create(DefSelectText, DefSelectBack);
 f_SelectColor.OnColorChange := vlbColorChanged;
 f_SelectNonFocusColor := TOvcColors.Create(DefSelectNFText, DefSelectNFBack);
 f_SelectNonFocusColor.OnColorChange := vlbColorChanged;

 InternalSelector := True;
 SearchStr := '';
 //lBMPDimension.X := -1;
 OnCharToItem := CharToItem;

 ResetLastHint;
 Options := [vlTooltips];
 ShowHint := False;
 {FixAnchor := True;}
 //DoubleBuffered := True;
 f_Header := TvtListerHeader.Create(Self);
 with f_Header do
 begin
  Name := 'Header';
  BevelInner := bvNone;
  BevelOuter := bvRaised;
  BevelWidth := 1;
  Parent := Self;
  Align := alTop;
  Visible := DefShowHeader;
  OnSized := HeaderSizedProc;
  SetSubComponent(True);
 end;
 f_FocusedAt := 0;
 f_ActionElementMode := l3_amDoubleClick;
 f_DnDProcess := False;
 f_InActionProcess := False;
 f_EvenScrolled := True;
 f_UseStyleTable := False;
 f_StyleId := evd_saGUI;
 f_FooterStyleID := evd_saHyperLink;
 f_FooterActiveStyleID := evd_saActiveHyperLink;
 {$IfNDef DesignTimeLibrary}
 evAddStyleTableSpy(Self, True);
 {$EndIf DesignTimeLibrary}
 f_VJustify := vt_vjCenter;
 f_VScrollPersistent := False;
//#UC END# *47D1602000C6_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.Create

{$If NOT Defined(NoVCL)}
procedure TvtCustomListerPrim.WndProc(var Message: TMessage);
//#UC START# *47E136A80191_4CFFE36B00FA_var*
//#UC END# *47E136A80191_4CFFE36B00FA_var*
begin
//#UC START# *47E136A80191_4CFFE36B00FA_impl*
 case Message.Msg of
  WM_NCPAINT: CheckParam;
  WM_PAINT:
   begin
    CheckParam;
    if (f_UpdateFlags <> []) then
     Perform(msg_vtUpdateScroll, 0, 0);
    if f_NeedCurrentVisible then
     vlbMakeItemVisiblePrim(Current);
   end;
 end;
 inherited WndProc(Message);
//#UC END# *47E136A80191_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.WndProc
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtCustomListerPrim.Loaded;
//#UC START# *484516C00214_4CFFE36B00FA_var*
//#UC END# *484516C00214_4CFFE36B00FA_var*
begin
//#UC START# *484516C00214_4CFFE36B00FA_impl*
 inherited;
 {$IfNDef DesignTimeLibrary}
 StyleTableChanged;
 // - чтобы шрифт взять из таблицы стилей
 {$EndIf DesignTimeLibrary}
 if (Current < 0) and (Total > 0) then
  Current := 0;
 vlbCalcFontFields;
//#UC END# *484516C00214_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.Loaded

function TvtCustomListerPrim.GetCommands: TafwCommands;
//#UC START# *48BD1E3C03B5_4CFFE36B00FA_var*
//#UC END# *48BD1E3C03B5_4CFFE36B00FA_var*
begin
//#UC START# *48BD1E3C03B5_4CFFE36B00FA_impl*
 SetCommands([scListTableName], Result);
//#UC END# *48BD1E3C03B5_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetCommands

function TvtCustomListerPrim.DoProcessCommand(Cmd: Tl3OperationCode;
 aForce: Boolean;
 aCount: Integer): Boolean;
//#UC START# *48BD22E601F2_4CFFE36B00FA_var*
//#UC END# *48BD22E601F2_4CFFE36B00FA_var*
begin
//#UC START# *48BD22E601F2_4CFFE36B00FA_impl*
 Result := DoIsCommandProcessed(Cmd) and DoDoProcessCommand(Cmd);
//#UC END# *48BD22E601F2_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoProcessCommand

procedure TvtCustomListerPrim.DoChanged;
//#UC START# *48BD5F8303C4_4CFFE36B00FA_var*
//#UC END# *48BD5F8303C4_4CFFE36B00FA_var*
begin
//#UC START# *48BD5F8303C4_4CFFE36B00FA_impl*
 DropDrawPoints;
 if not (csDestroying in ComponentState) then Invalidate;
 if not FixAnchor then f_Anchor := f_Current;
//#UC END# *48BD5F8303C4_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoChanged

function TvtCustomListerPrim.GetCaret: Il3Caret;
//#UC START# *48C6B7E80104_4CFFE36B00FA_var*
//#UC END# *48C6B7E80104_4CFFE36B00FA_var*
begin
//#UC START# *48C6B7E80104_4CFFE36B00FA_impl*
 Result := f_Caret;
//#UC END# *48C6B7E80104_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.GetCaret

procedure TvtCustomListerPrim.Paint(const CN: Il3Canvas);
 {* процедура рисования внешнего вида управляющего элемента }
//#UC START# *48C6C044025E_4CFFE36B00FA_var*
var
 lCurPos: Integer;
 l_ItemVShift: Integer;
 l_TopIndent: Integer;
 I    : Integer;
 CR   : Tl3SRect;
 IR   : TRect;
 Clip : TRect;
 Last : Integer;
 l_TopVShift: Integer;
 l_BaseBGColor : TColor;
 //BMPDim : TPoint;

 procedure DrawItem(N : LongInt{; Row : Integer});
   {-Draw item N at Row}
 var
  FGColor      : TColor;
  BGColor      : TColor;
  R            : Tl3SRect;
  CRI          : Tl3SRect;
  l_l3Rect     : Tl3Rect;
  l_S          : Il3CString;
  l_ImageIndex : Integer;
  l_Images     : TCustomImageList;
  l_Temp       : Integer;
  l_Enabled    : Boolean;
  l_Overlays   : TOverlayIndexArray;
  I : Integer;
  l_ImgX: Integer;
  l_ImgY: Integer;
  l_Painter    : Il3NodePainter;
  l_NeedInvert: Boolean;
  l_CaretPos: Integer;
 begin
  {get bounding rectangle}
  CR.R.WR := GetDrawRect(N); // это полный прямоугольник - с отступом

  // а это - прямоугольник без отступов
  CRI := CR;
  Inc(CRI.R.Top, l_ItemVShift);
  Dec(CRI.R.Bottom, l_ItemVShift);

  {do we have anything to paint}
  if not IntersectRect(IR, Clip, CR.R.WR) then
   Exit;

  {assign colors to our canvas}
  CN.BackColor := l_BaseBGColor;
  CN.Font.AssignFont(Font);

  {Draw Picked List}
  if f_PickedList and (N <= f_HighIndex) then
  begin
   l_ImageIndex := DoOnGetItemPickImage(N, l_Images);

   if IR.Left < (CR.Left + l_Images.Width + ImageAddSpace) then
   begin
    CN.BackColor := l_BaseBGColor;
    CN.FillRect(l3SBounds(CR.Left,
                          CR.Top,
                          l_Images.Width + ImageAddSpace,
                          CR.Bottom - CR.Top));
    l_Images.Draw(CN.Canvas,
                  CR.Left + RowHeight div 4,
                  CR.Top + (RowHeight - l_Images.Height) shr 1 + l_ItemVShift,
                  l_ImageIndex,
                  True);
   end;
   Inc(CR.R.Left, l_Images.Width + ImageAddSpace);
   CRI.R.Left := CR.R.Left;
  end
  else
  begin
   if Images <> nil then
   begin
    CN.FillRect(l3SBounds(CR.Left,
                          CR.Top,
                          Images.Width + ImageAddSpace,
                          CR.Bottom - CR.Top));

    l_ImageIndex := DoOnGetItemImageIndex(N);
    DoOnGetItemImageState(N, l_Enabled);

    if (l_ImageIndex >= 0) and
       (IR.Left < (CR.R.Left + Images.Width + ImageAddSpace)) then
    begin
     l_ImgX := CR.Left + RowHeight div 4;
     l_ImgY := CR.Top + l_TopVShift;
     Images.Draw(CN.Canvas, l_ImgX, l_ImgY, l_ImageIndex, l_Enabled);
     DoOnGetItemImageOverlays(N, l_Overlays);
     if Length(l_Overlays) > 0 then
      for I := 0 to High(l_Overlays) do
       Images.Draw(CN.Canvas, l_ImgX, l_ImgY, l_Overlays[I], l_Enabled);
    end;
    Inc(CR.R.Left, Images.Width + ImageAddSpace);
    CRI.Left := CR.Left;
   end;
  end;

  {get colors}
  if DoOnGetItemStatus(N) then
  begin
   BGColor := f_ProtectColor.BackColor;
   FGColor := f_ProtectColor.TextColor;
   l_NeedInvert := False;
  end
  else
  begin
   l_NeedInvert := ((N = f_Current) and (not MultiSelect or f_PickedList)) or
      (Selected[N] and not f_PickedList);

   BGColor := l_BaseBGColor;
   FGColor := Font.Color;
   DoOnGetItemColor(N, FGColor, BGColor);
  end;

  {assign colors to our canvas}
  CN.BackColor := BGColor;
  CN.Font.ForeColor := FGColor;
  CN.Font.BackColor := BGColor;
  DoOnGetItemFont(N, CN.Font, vt_lipText);
  FGColor := CN.Font.ForeColor;
  BGColor := CN.Font.BackColor;

  if l_NeedInvert then
   CN.BeginInvert;

  l_Painter := DoOnGetItemPainter(N);
  try
   if (l_Painter <> nil) then
   begin
    l_CaretPos := 0;
    if (N = f_Current) then
    begin
     if SearchStr <> '' then
     begin
      l_CaretPos := Length(SearchStr);
     end;
     CN.ShowCursor := (l_CaretPos > 0);
    end;
    CN.FillRect(CR);
    R := CR;
    Inc(R.R.Left, 2); // чтобы маленький отступ был слева
    Inc(R.R.Top, l_TopVShift);
    l_l3Rect := CN.DR2LR(R);
    l_Painter.PaintNode(CN, l_l3Rect, 0, l_CaretPos, N = f_Current);
    if l_CaretPos > 0 then
     f_Caret.CheckHidden;
   end
   else
   begin
    {get the string}
    l_S := GetDrawString(N);

    {draw the string}
    if l3IsNil(l_S) then
    begin
     if f_MultiStrokeItem and (BGColor <> l_BaseBGColor) then
      CN.BackColor := BGColor;
     CN.FillRect(CRI);
    end
    else
    begin
     if f_MultiStrokeItem then
     begin
      CN.BackColor := BGColor;
      R := CR;
      R.Bottom := R.Top + l_ItemVShift;
      CN.FillRect(R);
      R.Top := CRI.Bottom;
      R.Bottom := R.Top + l_ItemVShift;
      CN.FillRect(R);

      CN.BackColor := BGColor;
      CN.FillRect(CRI);

      Inc(R.R.Left, 2); // чтобы маленький отступ был слева

      if f_UseTabStops and (f_Header.Sections.Count > 0) then
      begin
       R := CRI;
       Inc(R.R.Left, 2); // чтобы маленький отступ был слева
       l_l3Rect := CN.DR2LR(R);
       if Assigned(Images) then
        f_TabsFirstIndent := Images.Width + ImageAddSpace
       else
        f_TabsFirstIndent := 0;
       CN.TabbedMultilineTextOut(l3PCharLen(l_S), Tl3TabStops.Make(TSGetTabStopPos, True), l_l3Rect, False, vt_TabbedMLOutGap);
      end
      else
      begin
       R := CRI;
       Inc(R.R.Left, 2); // чтобы маленький отступ был слева
       CN.DrawText(l3PCharLen(l_S), R.R.WR, vtMultiLineDrawTextFormat);
      end;
     end//f_MultiStrokeItem
     else
     begin
      if f_UseTabStops and (f_Header.Sections.Count > 0) then
      begin
       CN.FillRect(CR);
       R := CR;
       //вывод одной строки с табуляциями
       if Assigned(Images) then
        f_TabsFirstIndent := Images.Width + ImageAddSpace
       else
        f_TabsFirstIndent := 0;
       CN.TabbedTextOut(l3SPoint(R.Left + 2, R.Top + l_ItemVShift),
          l3SRect(R.Left, R.Top + l_ItemVShift, R.Right, R.Bottom + l_ItemVShift), l3PCharLen(l_S),
          Tl3TabStops.Make(TSGetTabStopPos, True));
      end//f_UseTabStops..
      else
       CN.ExtTextOut(l3SPoint(CR.Left + 2, CR.Top + l_ItemVShift),
                     Tl3SRect(CR), l3PCharLen(l_S));
     end;//f_MultiStrokeItem
    end;//l3IsNil(l_S)
    if (N = f_Current) then
    begin
     if SearchStr <> '' then
     begin
      f_CaretPoint := Point(CRI.Left, CRI.Top);
      if not f_MultiStrokeItem then
       Inc(f_CaretPoint.X, 2);
      SetCaret;
     end;
    end;
   end;

  finally
   if l_NeedInvert then
    CN.EndInvert
  end;

  if (N = f_Current) then
   vlbDrawFocusRect(CN, f_Current);

 if f_DrawGrid and (N > 0) then
 begin
  CN.Canvas.Pen.Color := clLtGray;
  l_Temp := CR.Top;
  CN.Canvas.MoveTo(0, l_Temp);
  CN.Canvas.LineTo(ClientWidth, l_Temp);
 end;
end;
//#UC END# *48C6C044025E_4CFFE36B00FA_var*
begin
//#UC START# *48C6C044025E_4CFFE36B00FA_impl*
 if Enabled then
  l_BaseBGColor := Color
 else
  l_BaseBGColor := clBtnFace; // может, можно как-то получить цвет disabled окна?
 if SearchStr <> '' then
  MakeSureCaretIsCreated;
 inherited Paint(CN);
 {Exit if the updating flag is set}
 if csDestroying in ComponentState then Exit;

 if InUpdating then Exit;

 CN.Font.AssignFont(Font);
 {we will erase our own background}
 SetBkMode(hDC(CN.DC), TRANSPARENT);

 {get the clipping region}
 GetClipBox(hDC(CN.DC), Clip);

 {calculate last visible item}
 Last := ItemOnScreen(False);
 if Last > f_Total - f_TopIndex then
  Last := f_Total - f_TopIndex;

 CN.NotFocused := not Focused;

 l_ItemVShift := GetItemVShift;

 if UseDrawPoints then
  l_TopVShift := InterRowIndent div 2
 else
 if Images <> nil then
  l_TopVShift := (f_RowHeight - Images.Height) div 2
 else
  l_TopVShift := 0; // хоть он и не используется в этом случае, но на всякий пожарный...

 {display each row}
 for I := 1 to Last do
  DrawItem(f_TopIndex + Pred(I));

 {paint any blank area below last item and above first}
 CR.R.WR := ClientRect;
 l_TopIndent := GetTopIndent;
 if UseDrawPoints then
 begin
  if (DrawPoints <> nil) and (DrawPoints.Count > 0) then
   CR.Top := DrawPoints.Last;
  Inc(CR.R.Top, l_TopIndent);
 end //UseDrawPoints
 else
  CR.Top := CompleteRowHeight * Last + l_TopIndent;

 if (CR.Top < ClientHeight) and ((f_TopIndex + Last - 1 = f_HighIndex) or (Total = 0)) and FooterVisible then
  CR.Top := DrawFooter(CN, CR.Top);

 if CR.Top < ClientHeight then
  begin
   CR.R.Bottom := ClientHeight;
   {clear the area}
   CN.BackColor := l_BaseBGColor;
   CN.FillRect(CR);
  end;
 if (InterRowIndent > 0) then
 begin
  CR.R.WR := ClientRect;
  CR.R.Bottom := l_TopIndent;
  CR.R.Top := CR.Bottom - InterRowIndent;
  CN.BackColor := l_BaseBGColor;
  CN.FillRect(CR);
 end;

 // рисуем вертикальные полоски сетки (если надо)
 if UseTabStops and DrawGrid then
 begin
  CN.Canvas.Pen.Color := clLtGray;
  lCurPos := 0;
  for I := 0 to Header.Sections.Count-1 do
  begin
   Inc(lCurPos, Header.SectionWidth[I]);
   if lCurPos < ClientWidth then
   begin
    CN.Canvas.MoveTo(lCurPos, 0);
    CN.Canvas.LineTo(lCurPos, ClientHeight);
   end else
    Break;
  end;
 end;
//#UC END# *48C6C044025E_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.Paint

function TvtCustomListerPrim.InUpdating: Boolean;
//#UC START# *48C6C421015B_4CFFE36B00FA_var*
//#UC END# *48C6C421015B_4CFFE36B00FA_var*
begin
//#UC START# *48C6C421015B_4CFFE36B00FA_impl*
 Result := inherited InUpdating OR f_Updating;
//#UC END# *48C6C421015B_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.InUpdating

{$If NOT Defined(NoVCL)}
procedure TvtCustomListerPrim.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_4CFFE36B00FA_var*
const
  l3ScrollBarStyles : array[TScrollStyle] of LongInt =
                    (0, WS_HSCROLL, WS_VSCROLL, WS_HSCROLL or WS_VSCROLL);
//#UC END# *48C7925A02E5_4CFFE36B00FA_var*
begin
//#UC START# *48C7925A02E5_4CFFE36B00FA_impl*
 inherited;
 // Включаем прокрутку только если это необходимо (есть данные), иначе Windows
 // всегда создает полосы прокрутки если они определны в Style, потом они
 // убираются в следствии чего происходит перемиргивание
 if not IsNeedScrollBars then
  Params.Style := Params.Style and not l3ScrollBarStyles[ScrollStyle];
//#UC END# *48C7925A02E5_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CreateParams
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtCustomListerPrim.DoMenuUnlockedFixUp;
//#UC START# *4B05241502C5_4CFFE36B00FA_var*
//#UC END# *4B05241502C5_4CFFE36B00FA_var*
begin
//#UC START# *4B05241502C5_4CFFE36B00FA_impl*
 if AlignTopIndex then
 begin
  DropDrawPoints;
  Invalidate;
 end;
//#UC END# *4B05241502C5_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.DoMenuUnlockedFixUp

{$If NOT Defined(NoVCL)}
procedure TvtCustomListerPrim.CreateWnd;
//#UC START# *4CC8414403B8_4CFFE36B00FA_var*
//#UC END# *4CC8414403B8_4CFFE36B00FA_var*
begin
//#UC START# *4CC8414403B8_4CFFE36B00FA_impl*
  inherited;
  {do we have scroll bars}
  //lHaveVS := ScrollStyle in [ssVertical, ssBoth];
  //lHaveHS := ScrollStyle in [ssHorizontal, ssBoth];
  f_HighIndex := Pred(f_Total);

  //f_Current {lFocusedIndex} := DefItemIndex;

  {determine the height of one row and number of rows}
  f_FontChanged := True;
  {vlbAdjustIntegralHeight;}

  {setup scroll bar info}
  if (f_UpdateFlags <> []) then
  begin
   // - CQ OIT5-7430 "Скроллинг в перечне ситуаций во фрейме навигатора".
   if InUpdating then
    PostMessage(Handle, msg_vtUpdateScroll, 0, 0)
   else
    vlbInitScrollInfo;
  end;//f_UpdateFlags <> []
//#UC END# *4CC8414403B8_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.CreateWnd
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TvtCustomListerPrim.SetBounds(ALeft: Integer;
 ATop: Integer;
 AWidth: Integer;
 AHeight: Integer);
//#UC START# *4F2A599E0283_4CFFE36B00FA_var*
//#UC END# *4F2A599E0283_4CFFE36B00FA_var*
begin
//#UC START# *4F2A599E0283_4CFFE36B00FA_impl*
 if not (Align in [alNone, alTop, alBottom]) then
  f_IntegralHeight := False;
 inherited;
//#UC END# *4F2A599E0283_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.SetBounds
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtCustomListerPrim.Notification(AComponent: TComponent;
 Operation: TOperation);
//#UC START# *4F884378016A_4CFFE36B00FA_var*
//#UC END# *4F884378016A_4CFFE36B00FA_var*
begin
//#UC START# *4F884378016A_4CFFE36B00FA_impl*
 if (OPeration = opRemove) AND (aComponent = f_Images) then
  Images := nil;
 inherited;
//#UC END# *4F884378016A_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.Notification

{$If NOT Defined(NoVCL)}
procedure TvtCustomListerPrim.MouseWheelHandler(var Message: TMessage);
//#UC START# *515317860183_4CFFE36B00FA_var*
//#UC END# *515317860183_4CFFE36B00FA_var*
begin
//#UC START# *515317860183_4CFFE36B00FA_impl*
 if (Integer(Message.wParam) > 0) then
  vlbVScrollPrim(-1)
 else
  vlbVScrollPrim(1);
//#UC END# *515317860183_4CFFE36B00FA_impl*
end;//TvtCustomListerPrim.MouseWheelHandler
{$IfEnd} // NOT Defined(NoVCL)

procedure TvtCustomListerPrim.ClearFields;
begin
 FooterCaption := '';
 SearchStr := '';
 inherited;
end;//TvtCustomListerPrim.ClearFields

function TvtCustomLister.FontStore: Boolean;
//#UC START# *515AEA0D02C1_515062D301C4_var*
//#UC END# *515AEA0D02C1_515062D301C4_var*
begin
//#UC START# *515AEA0D02C1_515062D301C4_impl*
 Result := not UseStyleTable;
//#UC END# *515AEA0D02C1_515062D301C4_impl*
end;//TvtCustomLister.FontStore

//#UC START# *515062D301C4impl*
//#UC END# *515062D301C4impl*

function TvtCustomDataListerPrim.pm_GetItems: Tl3CustomDataList;
//#UC START# *5154139F022E_515404B3000Fget_var*
var
 l_Items : Tl3CustomDataList;
//#UC END# *5154139F022E_515404B3000Fget_var*
begin
//#UC START# *5154139F022E_515404B3000Fget_impl*
 if f_Items = nil then
 try
  l_Items := Tl3CustomDataList.Create;
  Items := l_Items;
 finally
  l3Free(l_Items);
 end;

 Result := f_Items;
//#UC END# *5154139F022E_515404B3000Fget_impl*
end;//TvtCustomDataListerPrim.pm_GetItems

procedure TvtCustomDataListerPrim.pm_SetItems(aValue: Tl3CustomDataList);
//#UC START# *5154139F022E_515404B3000Fset_var*
//#UC END# *5154139F022E_515404B3000Fset_var*
begin
//#UC START# *5154139F022E_515404B3000Fset_impl*
 if (f_Items = aValue) then
  Exit;
 if (f_Items <> nil) then
 begin
  Il3ChangeNotifier(Items).Unsubscribe(Il3ChangeRecipient(Self));
  l3Free(f_Items);
 end;

 if (aValue <> nil) then
 begin
  f_Items := aValue.Use;
  Il3ChangeNotifier(f_Items).Subscribe(Il3ChangeRecipient(Self));
  Total := f_Items.Count;
 end else
  Total := 0;
//#UC END# *5154139F022E_515404B3000Fset_impl*
end;//TvtCustomDataListerPrim.pm_SetItems

procedure TvtCustomDataListerPrim.DStrOnIsSelected(Sender: TObject;
 Index: LongInt;
 var Selected: Integer);
//#UC START# *51541632014E_515404B3000F_var*
//#UC END# *51541632014E_515404B3000F_var*
begin
//#UC START# *51541632014E_515404B3000F_impl*
 Selected := Ord(Items.Select[Index]);
//#UC END# *51541632014E_515404B3000F_impl*
end;//TvtCustomDataListerPrim.DStrOnIsSelected

procedure TvtCustomDataListerPrim.DStrOnSelect(Sender: TObject;
 Index: LongInt;
 var Selected: Integer);
//#UC START# *51541654007B_515404B3000F_var*
//#UC END# *51541654007B_515404B3000F_var*
begin
//#UC START# *51541654007B_515404B3000F_impl*
 case Index of
  vt_smAllInvert : Items.AllSelect(sbInvert);
  vt_smAllSelect : if (Selected <> 0)
                    then Items.AllSelect(sbSelect)
                    else Items.AllSelect(sbDeselect);
 else
  Items.Select[Index] := (Selected <> 0);
 end;
//#UC END# *51541654007B_515404B3000F_impl*
end;//TvtCustomDataListerPrim.DStrOnSelect

procedure TvtCustomDataListerPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_515404B3000F_var*
//#UC END# *479731C50290_515404B3000F_var*
begin
//#UC START# *479731C50290_515404B3000F_impl*
 Items := nil;
 inherited;
//#UC END# *479731C50290_515404B3000F_impl*
end;//TvtCustomDataListerPrim.Cleanup

constructor TvtCustomDataListerPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_515404B3000F_var*
//#UC END# *47D1602000C6_515404B3000F_var*
begin
//#UC START# *47D1602000C6_515404B3000F_impl*
 inherited;
 OnSelect := DStrOnSelect;
 OnIsSelected := DStrOnIsSelected;
//#UC END# *47D1602000C6_515404B3000F_impl*
end;//TvtCustomDataListerPrim.Create

procedure TvtCustomDataListerPrim.DoChanged;
//#UC START# *48BD5F8303C4_515404B3000F_var*
//#UC END# *48BD5F8303C4_515404B3000F_var*
begin
//#UC START# *48BD5F8303C4_515404B3000F_impl*
 Total := Items.Count;
 inherited;
//#UC END# *48BD5F8303C4_515404B3000F_impl*
end;//TvtCustomDataListerPrim.DoChanged

function TvtCustomDataListerPrim.pm_GetSelectedCount: Integer;
//#UC START# *514C82280017_515404B3000Fget_var*
//#UC END# *514C82280017_515404B3000Fget_var*
begin
//#UC START# *514C82280017_515404B3000Fget_impl*
 if Assigned(Items)
  then Result := Items.SelectCount
  else Result := 0;
//#UC END# *514C82280017_515404B3000Fget_impl*
end;//TvtCustomDataListerPrim.pm_GetSelectedCount

//#UC START# *515414CF022Cimpl*
//#UC END# *515414CF022Cimpl*

procedure TvtCustomIStrListListerPrim.pm_SetItems(const aValue: Il3ViewStringList);
//#UC START# *51541D370323_5154154E0275set_var*
var
 lChangeNotifier : Il3ChangeNotifier;
//#UC END# *51541D370323_5154154E0275set_var*
begin
//#UC START# *51541D370323_5154154E0275set_impl*
 if (f_Items = aValue) then
  Exit;
 if (f_Items <> nil) then
 begin
  if Supports(f_Items, Il3ChangeNotifier, lChangeNotifier) then
   lChangeNotifier.Unsubscribe(Il3ChangeRecipient(Self));
  f_Items := nil;
 end;

 if (aValue <> nil) then
 begin
  f_Items := aValue;
  if Supports(f_Items, Il3ChangeNotifier, lChangeNotifier) then
   lChangeNotifier.Subscribe(Il3ChangeRecipient(Self));
  Total := f_Items.Count;
 end else
  Total := 0;
//#UC END# *51541D370323_5154154E0275set_impl*
end;//TvtCustomIStrListListerPrim.pm_SetItems

function TvtCustomIStrListListerPrim.GetItems: Il3ViewStringList;
//#UC START# *51541D65039B_5154154E0275_var*
//#UC END# *51541D65039B_5154154E0275_var*
begin
//#UC START# *51541D65039B_5154154E0275_impl*
 Result := f_Items;
//#UC END# *51541D65039B_5154154E0275_impl*
end;//TvtCustomIStrListListerPrim.GetItems

procedure TvtCustomIStrListListerPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5154154E0275_var*
//#UC END# *479731C50290_5154154E0275_var*
begin
//#UC START# *479731C50290_5154154E0275_impl*
 Items := nil;
 inherited;
//#UC END# *479731C50290_5154154E0275_impl*
end;//TvtCustomIStrListListerPrim.Cleanup

procedure TvtCustomIStrListListerPrim.DoChanged;
//#UC START# *48BD5F8303C4_5154154E0275_var*
//#UC END# *48BD5F8303C4_5154154E0275_var*
begin
//#UC START# *48BD5F8303C4_5154154E0275_impl*
 Total := Items.Count;
 inherited;
//#UC END# *48BD5F8303C4_5154154E0275_impl*
end;//TvtCustomIStrListListerPrim.DoChanged

function TvtCustomIStrListListerPrim.DoOnGetItem(Index: LongInt): Il3CString;
//#UC START# *5152C3EC011B_5154154E0275_var*
//#UC END# *5152C3EC011B_5154154E0275_var*
begin
//#UC START# *5152C3EC011B_5154154E0275_impl*
 if (Items <> nil) then
  Result := Items[Index]
 else
  Result := nil;
//#UC END# *5152C3EC011B_5154154E0275_impl*
end;//TvtCustomIStrListListerPrim.DoOnGetItem

procedure TvtCustomIStrListListerPrim.ClearFields;
begin
 Items := nil;
 inherited;
end;//TvtCustomIStrListListerPrim.ClearFields

//#UC START# *515405400086impl*
//#UC END# *515405400086impl*

function TvtCustomDStringLister.pm_GetItems: Tl3StringDataList;
//#UC START# *51541C010347_515405080211get_var*
var
 l_Items : Tl3StringDataList;
//#UC END# *51541C010347_515405080211get_var*
begin
//#UC START# *51541C010347_515405080211get_impl*
 if f_Items = nil then
 try
  l_Items := Tl3StringDataList.Create;
  Items := l_Items;
 finally
  l3Free(l_Items);
 end;

 Result := Tl3StringDataList(f_Items);
//#UC END# *51541C010347_515405080211get_impl*
end;//TvtCustomDStringLister.pm_GetItems

procedure TvtCustomDStringLister.pm_SetItems(aValue: Tl3StringDataList);
//#UC START# *51541C010347_515405080211set_var*
//#UC END# *51541C010347_515405080211set_var*
begin
//#UC START# *51541C010347_515405080211set_impl*
 inherited pm_SetItems(aValue);
//#UC END# *51541C010347_515405080211set_impl*
end;//TvtCustomDStringLister.pm_SetItems

function TvtCustomDStringLister.pm_GetSorted: Boolean;
//#UC START# *51541C3A0061_515405080211get_var*
//#UC END# *51541C3A0061_515405080211get_var*
begin
//#UC START# *51541C3A0061_515405080211get_impl*
 Result := Items.Sorted;
//#UC END# *51541C3A0061_515405080211get_impl*
end;//TvtCustomDStringLister.pm_GetSorted

procedure TvtCustomDStringLister.pm_SetSorted(aValue: Boolean);
//#UC START# *51541C3A0061_515405080211set_var*
//#UC END# *51541C3A0061_515405080211set_var*
begin
//#UC START# *51541C3A0061_515405080211set_impl*
 Items.Sorted := aValue;
//#UC END# *51541C3A0061_515405080211set_impl*
end;//TvtCustomDStringLister.pm_SetSorted

procedure TvtCustomDStringLister.CharToItem(Sender: TObject;
 var SrchStr: AnsiString;
 aFromCurrent: Boolean;
 var Index: LongInt);
//#UC START# *51541B9501F1_515405080211_var*
var
 l_R     : Boolean;
 Len   : Word;
 ItStr : PAnsiChar;
//#UC END# *51541B9501F1_515405080211_var*
begin
//#UC START# *51541B9501F1_515405080211_impl*
 if Items.Count = 0 then
 begin
  Index := -1;
  Exit;
 end;
 Len := Length(SrchStr);
 l_R := Items.FindStrBegin(PAnsiChar(SrchStr), Index);
 if not l_R then
 begin
  Index := -1;
  Exit;
 end;
 ItStr := Items.Strings[Index];
 if not ((StrLen(ItStr) < Len) or
   (l3AnsiStrLICompExt(PAnsiChar(SrchStr), ItStr, Len) = 0)) then
  Index := -1;
//#UC END# *51541B9501F1_515405080211_impl*
end;//TvtCustomDStringLister.CharToItem

function TvtCustomDStringLister.DoOnGetItem(Index: LongInt): Il3CString;
//#UC START# *5152C3EC011B_515405080211_var*
//#UC END# *5152C3EC011B_515405080211_var*
begin
//#UC START# *5152C3EC011B_515405080211_impl*
 try
  if (csDesigning in ComponentState) and (Items.Count <= 0) then
   Result := l3Fmt(GetOrphStr(SCSampleListItem), [Index])
  else
   Result := l3CStr(Items.Strings[Index]);
 except
  Result := nil;
 end;//try..except
//#UC END# *5152C3EC011B_515405080211_impl*
end;//TvtCustomDStringLister.DoOnGetItem

//#UC START# *515405590022impl*
//#UC END# *515405590022impl*

//#UC START# *51541B4700C9impl*
//#UC END# *51541B4700C9impl*

//#UC START# *515404E40394impl*
//#UC END# *515404E40394impl*

//#UC START# *4CFFE3470249impl*
//#UC END# *4CFFE3470249impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtItemStorageViewer);
 {* Регистрация TvtItemStorageViewer }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomListerPrim);
 {* Регистрация TvtCustomListerPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomLister);
 {* Регистрация TvtCustomLister }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomDataListerPrim);
 {* Регистрация TvtCustomDataListerPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomDataLister);
 {* Регистрация TvtCustomDataLister }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomIStrListListerPrim);
 {* Регистрация TvtCustomIStrListListerPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomIStrListLister);
 {* Регистрация TvtCustomIStrListLister }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtCustomDStringLister);
 {* Регистрация TvtCustomDStringLister }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtIStrListLister);
 {* Регистрация TvtIStrListLister }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtDStringLister);
 {* Регистрация TvtDStringLister }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtDataLister);
 {* Регистрация TvtDataLister }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtLister);
 {* Регистрация TvtLister }
{$IfEnd} // NOT Defined(NoScripts)

end.
