unit vtLister;

interface

uses
 l3IntfUses
 , Windows
 , l3Interfaces
 , l3InternalInterfaces
 , l3ControlsTypes
 , ImgList
 , Controls
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
 , ExtCtrls
 , Types
 , Messages
 , afwTypes
 , Forms
 , l3Defaults
 , StdCtrls
 , l3DatLst
;

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
 
 TvtListerHeader = class(TvtCustomHeader)
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
 
 // TTabStopsRange
 
 TvtCustomListerPrim = class(TvtItemStorageViewer, IafwStyleTableSpy, Il3Window)
  procedure DoOnActionElement(Index: LongInt);
  procedure DoOnGetItemImageState(const aItemIndex: LongInt;
   var aEnabled: Boolean);
  procedure DoVScrollVisibleChanged;
  procedure DoHScrollVisibleChanged;
  function IsCommonScrollVisible(aVert: Boolean): Boolean;
   {* определяет наличие вертикальной/горизонтальной полосы прокрутки. }
  function IsNeedScrollBars: Boolean;
   {* определяет нужены ли в CreateParams стили WS_VSCROLL WS_HSCROLL. }
  function NeedShowHint: Boolean;
  procedure FreeHintWindow;
  function GetHintWindow: THintWindow;
  procedure ShowHintWindow(const aHint: Il3CString;
   const aPosition: TPoint);
  procedure HintTimerEvent(Sender: TObject);
  function IsHintNeededForAnElement(anIndex: Integer): Boolean;
  function NotifyIfNewCurrentEmpty: Boolean;
   {* определяет нужно ли вызывать событие OnCurrentChanged в случае если пришел NewCurrent = -1. }
  procedure UpdateInterRowIndent;
  function TSGetTabStopPos(anIndex: Integer;
   out aPos: Integer): Boolean;
  function GetImagesStored: Boolean;
  function DoOnGetItemIndent: Integer;
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
  function ItemOnScreen(OnlyWhole: Boolean): Integer;
  procedure MakeDrawPoints(aDrawPoints: Tl3LongintList);
  procedure DropDrawPoints;
  function CalcTopIndex(aMaxVisItem: LongInt): LongInt;
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
  procedure vlbVScrollPrim(aDelta: Integer);
  procedure vlbSetSelRange(aFirst: LongInt;
   aLast: LongInt);
   {* set the selection on for the given range of indexes }
  function CanScrollWindow: Boolean;
  function NeedInitScrollInfoInvlbInitScrollInfo: Boolean;
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
   Index: LongInt);
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
   aNeedValidation: Boolean);
  procedure vlbProcessingChar(const aMsg: TWMChar);
   {* processing new pressed char }
  function vlbItemHitTest(aIndex: Integer;
   const aPt: TPoint;
   fromScreen: Boolean): Byte;
  procedure SetCursorForItem(anIndex: Integer);
  function GetDragAndDropSupported: Boolean;
  procedure TryDragAndDrop(aNodeIndex: Integer;
   aKey: Integer);
  function DoOnGetItem(Index: LongInt): Il3CString;
  function DoOnGetItemPainter(Index: LongInt): Il3NodePainter;
  function DoOnGetItemImageIndex(aItemIndex: LongInt): Integer;
  procedure DoOnGetItemImageOverlays(aIndex: Integer;
   var theOverlays: TOverlayIndexArray);
  function DoOnGetItemPickImage(aItemIndex: LongInt;
   var aImages: TCustomImageList): Integer;
  function DoOnGetItemIconHint(aItemIndex: LongInt): Il3CString;
  function DoOnGetItemTextHint(aIndex: Integer): Il3CString;
  function PickImages: TCustomImageList;
  procedure DoOnGetItemColor(Index: LongInt;
   var FG: TColor;
   var BG: TColor);
  procedure DoOnGetItemFont(Index: LongInt;
   const aFont: Il3Font;
   anItemPart: TvtListerItemPart);
  function DoOnGetItemStatus(Index: LongInt): Boolean;
  function DoOnIsSelected(Index: LongInt): Integer;
  procedure DoOnSelect(Index: LongInt;
   aValue: Integer);
  procedure DoOnSelectOutRange(First: LongInt;
   Last: LongInt;
   aSelectState: Integer);
  procedure DoOnTopIndexChanged(NewTopIndex: LongInt);
  function DoDoProcessCommand(Cmd: Tl3OperationCode): Boolean;
  function DoIsCommandProcessed(Cmd: Tl3OperationCode): Boolean;
  function DoOnUserCommand(Command: Tl3OperationCode): Boolean;
  procedure DoCurrentChanged(aNewCurrent: LongInt;
   aOldCurrent: LongInt);
  procedure DoValidateCurrent(var aIndex: LongInt);
  procedure CallCurrentChanged(aNewCurrent: LongInt;
   aOldCurrent: LongInt);
  procedure DoCountChanged(aCount: LongInt);
  procedure RepaintSelected(Smart: Boolean);
  function GetHint(anIndex: Integer): Il3CString;
  procedure HeaderSizedProc(Sender: TObject;
   ASection: Integer;
   AWidth: Integer);
  procedure ImagesChanged(Sender: TObject);
  function UseDrawPoints: Boolean;
  function CalcInterRowIndent: Integer;
  procedure SelectItems(aFinish: Integer);
   {* Создавалась, как ручка для тестов, но немного обобщает логику выделения }
  procedure BeginUpdate;
  procedure EndUpdate;
  procedure DrawItem(Index: LongInt);
  procedure InvalidateItem(Index: LongInt);
  function ItemAtPos(const Pos: TPoint;
   Existing: Boolean): LongInt;
  procedure ResetList;
  function GetNextSelectItem(Index: LongInt): LongInt;
  function GetItemTextIndent(Index: LongInt;
   aTextBoxHeight: Integer): Integer;
  function GetItemHeight(Index: LongInt): Integer;
  function GetItemDim(aItemIndex: Integer): TPoint;
  function GetFooterDim: TPoint;
  procedure HitTest(const aPt: TPoint;
   var aIndex: Integer;
   var aItemPart: Byte;
   fromScreen: Boolean);
  function GetItemsRangeDim(aBeginIndex: Integer;
   aEndIndex: Integer;
   aMaxHeight: Integer): TPoint;
  function ExcludeRect: TRect;
  function GetDrawRect(Index: LongInt): TRect;
   {* Функция для получения координат отрисовки элемента с Index }
  function GetDrawTextRect(Index: LongInt): TRect;
   {* Функция для получения координат отрисовки текста элемента с Index }
  function CalcFullHeight: Integer;
  function CalcFullWidth: Integer;
   {* Функция для ширины самого длинного элемента }
  procedure vlbToggleSelection(Index: LongInt);
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
  function GetTopIndent: Integer;
  function ImageAddSpace: Integer;
  procedure UpdateFooterActivity(aValue: Boolean);
  function GetItemVShift: Integer;
  procedure vlbMakeItemVisible(Index: LongInt);
  procedure vlbSetVScrollPos;
  procedure SetSearchStrPrim(const aValue: AnsiString);
  procedure SetLockChangeSelected(aValue: Boolean);
  procedure MakeSureCaretIsCreated;
  procedure InternalSetCurrent(aValue: LongInt);
  procedure InternalSetTopIndex(aValue: LongInt);
  procedure InternalSetTotal(aValue: LongInt);
  function NeedChangeCurrentOnMouseTrack: Boolean;
  function IsMouseMoved(const aPos: TPoint): Boolean;
  procedure DoNeedRecalcConstraints;
  procedure InvalidateNonclientArea;
  procedure ResetLastHint;
  procedure InitItemFont(Index: LongInt;
   const aFont: Il3Font;
   anItemPart: TvtListerItemPart);
   {* устанавлиет шрифт по умолчанию и вызывает _DoOnGetItemFont. }
  procedure CMCtl3DChanged(var Message: TMessage);
  procedure CMFontChanged(var Message: TMessage);
  procedure CMEnabledChanged(var Message: TMessage);
  procedure WMGetText(var Msg: TWMGetText);
  procedure WMGetTextLength(var Msg: TWMGetTextLength);
  procedure WMChar(var Msg: TWMChar);
  procedure WMEraseBkgnd(var Msg: TWMEraseBkgnd);
  procedure WMGetDlgCode(var Msg: TWMGetDlgCode);
  procedure WMHScroll(var Msg: TWMScroll);
  procedure CNKeyDown(var Msg: TWMKeyDown);
  procedure WMSysKeyDown(var Msg: TWMSysKeyDown);
  procedure WMKillFocus(var Msg: TWMKillFocus);
  procedure WMLButtonDown(var Msg: TWMLButtonDown);
  procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk);
  procedure WMRButtonDown(var Message: TWMRButtonDown);
  procedure WMMouseActivate(var Msg: TWMMouseActivate);
  procedure WMMouseMove(var Message: TWMMouseMove);
  procedure WMSetFocus(var Msg: TWMSetFocus);
  procedure WMSize(var Msg: TWMSize);
  procedure WMVScroll(var Msg: TWMScroll);
  procedure WMSetCursor(var Msg: TWMSetCursor);
  procedure WMUArtfulBehaviour(var Msg: TMessage);
  procedure msgvtUpdateScroll(var Msg: TMessage);
  procedure LBGetCaretIndex(var Msg: TMessage);
  procedure LBGetCount(var Msg: TMessage);
  procedure LBGetCurSel(var Msg: TMessage);
  procedure LBGetItemHeight(var Msg: TMessage);
  procedure LBGetItemRect(var Msg: TMessage);
  procedure LBGetSel(var Msg: TMessage);
  procedure LBGetTopIndex(var Msg: TMessage);
  procedure LBResetContent(var Msg: TMessage);
  procedure LBSelItemRange(var Msg: TMessage);
  procedure LBSetCurSel(var Msg: TMessage);
  procedure LBSetSel(var Msg: TMessage);
  procedure LBSetTabStops(var Msg: TMessage);
  procedure LBSetTopIndex(var Msg: TMessage);
  procedure WMWindowPosChanged(var Msg: TWMWindowPosChanged);
  function FooterFontStored: Boolean;
   {* "Функция определяющая, что свойство FooterFont сохраняется" }
  function FooterActiveFontStored: Boolean;
   {* "Функция определяющая, что свойство FooterActiveFont сохраняется" }
  function HeaderStored: Boolean;
   {* "Функция определяющая, что свойство Header сохраняется" }
  function ImagesStored: Boolean;
   {* "Функция определяющая, что свойство Images сохраняется" }
  procedure StyleTableChanged;
   {* таблица стилей изменилась. }
 end;//TvtCustomListerPrim
 
 TvtCustomLister = class(TvtCustomListerPrim)
  function FontStore: Boolean;
 end;//TvtCustomLister
 
 TvtCustomDataListerPrim = class(TvtCustomLister)
  {* Видимый элемент для отображения списка строк из Tl3DataList }
  procedure DStrOnIsSelected(Sender: TObject;
   Index: LongInt;
   var Selected: Integer);
  procedure DStrOnSelect(Sender: TObject;
   Index: LongInt;
   var Selected: Integer);
 end;//TvtCustomDataListerPrim
 
 TvtCustomDataLister = class(TvtCustomDataListerPrim)
 end;//TvtCustomDataLister
 
 TvtCustomIStrListListerPrim = class(TvtCustomLister)
  function GetItems: Il3ViewStringList;
 end;//TvtCustomIStrListListerPrim
 
 TvtCustomIStrListLister = class(TvtCustomIStrListListerPrim)
 end;//TvtCustomIStrListLister
 
 TvtCustomDStringLister = class(TvtCustomDataLister)
  {* Видимый элемент для отображения списка строк из Tl3StringDataList }
  procedure CharToItem(Sender: TObject;
   var SrchStr: AnsiString;
   aFromCurrent: Boolean;
   var Index: LongInt);
 end;//TvtCustomDStringLister
 
 TvtIStrListLister = class(TvtCustomIStrListLister)
  {* Видимый элемент для отображения списка строк из Il3ViewStringList }
 end;//TvtIStrListLister
 
 TvtDStringLister = class(TvtCustomDStringLister)
 end;//TvtDStringLister
 
 TvtDataLister = class(TvtCustomDataLister)
 end;//TvtDataLister
 
 TvtLister = class(TvtCustomLister)
  {* Видимый элемент для отображения виртуального списка строк. Для конечного использования. }
 end;//TvtLister
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
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
 , evStyleTableSpy
 , evdTextStyle_Const
 , evStyleTableTools
 , ListerWordsPack
;

end.
