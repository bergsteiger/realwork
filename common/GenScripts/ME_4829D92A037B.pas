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
  {* ����������� �� ��������� �������� ��������� }
 
 TevGetHotspotInfo = procedure(Sender: TObject;
  const aHotSpot: IevHotSpot;
  const aKeys: TafwCursorState;
  var theInfo: TafwCursorInfo) of object;
 
 IevEditorWindowFont = class(TevCustomFont)
 end;//IevEditorWindowFont
 
 TevCustomEditorWindow = class(TevCustomEditorWindowPrim)
  {* ���������� �������� �������� �������� ��� ����������� ����������� ��������� }
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
   {* ������� �������� ���������. }
  procedure BlockChange;
   {* ���������� ���������. }
  procedure SetEditRect;
  procedure DoScrollEvent; overload;
  procedure MakeCursor;
  function ReplaceConfirm(const aBlock: InevRange;
   AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt;
  procedure MakeTextSource(out theTextSource: TevCustomTextSource);
  function AllowDrawDocumentEdge: Boolean;
  procedure AfterOperation;
  function IsVScrollBarVisible: Boolean;
   {* ��������� ��������� ������������� ����������. }
  function GetPaintSelection: InevRange;
  procedure DoCursorInSelectionChange;
   {* ���������� �������� CursorInSelection. }
  procedure DoFontChange(const Font: Il3Font);
  procedure DoBeforeRMouseClick;
  function RightIndentMul: Integer;
  function WantEnter: Boolean;
  function WantTab(aKeyPressed: Boolean): Boolean;
  function DoBreakPara(aDrawLines: Boolean;
   const anOp: InevOp): Boolean; overload;
  function Tabulate: Boolean;
   {* ����������� ������� Tab. }
  function Untabulate: Boolean;
   {* ����������� ������� Shift-Tab. }
  function CloseQuery: Boolean;
  function MakeExportFilters(aSelection: Boolean;
   aForExport: Boolean): InevTagGenerator;
  procedure TextChange;
   {* ���������� ��� ����� ������. }
  procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd);
  procedure WMPaint(var Msg: TWMPaint);
  procedure WMGetDlgCode(var Msg: TWMGetDlgCode);
  procedure WMChar(var Msg: TWMChar);
  procedure WMKeyDown(var Msg: TWMKeyDown);
  function GetHorzDelta: Integer;
   {* �����, ����� �������� ���������� �������������� ������. }
  procedure SetTextColor(const aCanvas: Il3Canvas);
  function GetTopMargin: Integer;
   {* ���������� ������ �� ������ ������. }
  function ProcessHotSpots: Boolean;
   {* ������������ �� "������� �����" �� ������� ������ Hint'� � �������� ������� ��� �������� ��������� ��-���������. [$100958718] }
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
