unit evCustomEditorWindow;

interface

uses
 l3IntfUses
 , evCustomEditorWindowPrim
 , evCustomTextSource
 , nevTools
 , nevBase
 , l3Interfaces
 , Messages
 , l3InternalInterfaces
 , vcmExternalInterfaces
 , nevGUIInterfaces
 , afwInterfaces
 , Windows
 , evExcept
 , evEditorWindowHotSpot
 , nevSelection
 , afwNavigation
 , evEditorInterfaces
 , evCustomFont
;

type
 RevEditorWindowHotSpot = class of TevEditorWindowHotSpot;
 
 RevSelection = class of TnevSelection;
 
 TevJumpToEvent = function(Sender: TObject;
  anEffects: TafwJumpToEffects;
  const aMoniker: IevMoniker): Boolean;
 
 TevParaChangeEvent = procedure(Sender: TObject;
  const aTextPara: IedTextParagraph) of object;
  {* нотификация об изменении текущего параграфа }
 
 TevGetHotspotInfo = procedure(Sender: TObject;
  const aHotSpot: IevHotSpot;
  const aKeys: TafwCursorState;
  var theInfo: TafwCursorInfo) of object;
 
 IevEditorWindowFont = class(TevCustomFont)
 end;//IevEditorWindowFont
 
 TevCustomEditorWindow = class(TevCustomEditorWindowPrim)
  {* Реализация базового оконного элемента для отображения содержимого документа }
  function IsReadOnly: Boolean;
  function IvcmState__LoadState(const aState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  function IvcmState__SaveState(out aState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  procedure DoHitTest(const aHotSpot: IevHotSpot;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
  function CheckMouseUp(const aHotSpot: IevHotSpot;
   const aState: TevMouseState): Boolean;
  procedure ScrollInfoChange(aVert: Boolean;
   const aScrollInfo: TScrollInfo;
   aPosChanged: Boolean);
  function DoBreakPara(aDrawLines: Boolean;
   const anOp: InevOp): Boolean; overload;
  function HandledReadOnly(E: EevReadOnly): Boolean;
  function VScrollWidth(const anIC: Il3InfoCanvas): Integer;
  function DoDrawDocument(const aCanvas: Il3Canvas;
   out aMap: InevMap): Boolean;
  procedure ParaChange;
   {* текущий параграф изменился. }
  procedure BlockChange;
   {* изменилось выделение. }
  procedure SetEditRect;
  procedure DoScrollEvent; overload;
  procedure MakeCursor;
  function ReplaceConfirm(const aBlock: InevRange;
   AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt;
  procedure MakeTextSource(out theTextSource: TevCustomTextSource);
  function AllowDrawDocumentEdge: Boolean;
  procedure AfterOperation;
  function IsVScrollBarVisible: Boolean;
   {* проверяет видимость вертикального скроллбара. }
  function GetPaintSelection: InevRange;
  procedure DoCursorInSelectionChange;
   {* изменилось свойство CursorInSelection. }
  procedure DoFontChange(const Font: Il3Font);
  procedure DoBeforeRMouseClick;
  function RightIndentMul: Integer;
  function WantEnter: Boolean;
  function WantTab(aKeyPressed: Boolean): Boolean;
  function DoBreakPara(aDrawLines: Boolean;
   const anOp: InevOp): Boolean; overload;
  function Tabulate: Boolean;
   {* эквивалетно нажатию Tab. }
  function Untabulate: Boolean;
   {* эквивалетно нажатию Shift-Tab. }
  function CloseQuery: Boolean;
  function MakeExportFilters(aSelection: Boolean;
   aForExport: Boolean): InevTagGenerator;
  procedure TextChange;
   {* вызывается при смене текста. }
  procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd);
  procedure WMPaint(var Msg: TWMPaint);
  procedure WMGetDlgCode(var Msg: TWMGetDlgCode);
  procedure WMChar(var Msg: TWMChar);
  procedure WMKeyDown(var Msg: TWMKeyDown);
  function GetHorzDelta: Integer;
   {* зазор, после которого начинается скроллирование вправо. }
  procedure SetTextColor(const aCanvas: Il3Canvas);
  function GetTopMargin: Integer;
   {* Возвращает отступ до текста сверху. }
  function ProcessHotSpots: Boolean;
   {* Обрабатывать ли "горячие точки" на предмет показа Hint'а и мышиного курсора или вызывать поведение по-умолчанию. [$100958718] }
  function GetInfoCanvas: InevInfoCanvas;
  function ProcessCommandEx(Cmd: Integer;
   aForce: Boolean;
   aSubCmd: Cardinal;
   aCount: Integer): Boolean;
   {* process the specified command, return true if processed }
  function SelectionClass: RevSelection;
  function HotSpotClass: RevEditorWindowHotSpot;
  procedure DoScrollEvent; overload;
  function SelectWhenUnfocused: Boolean;
  procedure DoUnselectAfterInsertData;
  function GetLimitWidth: Integer;
 end;//TevCustomEditorWindow
 
implementation

uses
 l3ImplUses
 , nevView
 , l3ProcessMessagesManager
 , TtfwClassRef_Proxy
 , EditorFromStackKeyWordsPack
;

end.
