unit nevTools;

interface

uses
 l3IntfUses
 , nevBase
 , l3Variant
 , l3Types
 , l3Interfaces
 , k2Interfaces
 , k2Prim
 , evdInterfaces
 , evTypes
 , l3Core
 , k2Base
 , l3PureMixIns
 , afwInterfaces
 , evdTypes
 , Messages
;

type
 InevViewControl = interface
  {* ������� ��� ���������� View. }
  procedure Top;
  procedure Bottom;
  procedure PageUp;
  function PageDown: Boolean;
  procedure LineUp(aCount: Integer);
  procedure LineDown(aCount: Integer);
 end;//InevViewControl
 
 InevCaret = interface(InevViewControl)
  {* �������. }
  procedure Home;
  procedure EndLine;
 end;//InevCaret
 
 InevBase = nevBase.InevBase;
 
 InevScroller = interface(InevViewControl)
  {* ��������. }
  function Min: Integer;
  function Max: Integer;
  function Page: Integer;
  function Pos: Integer;
  function ScrollTo(aPosition: Integer): Boolean;
  procedure WheelUp;
  procedure WheelDown;
  procedure EndScroll;
 end;//InevScroller
 
 TevPair = object
 end;//TevPair
 
 TnevAddInnerMode = (
  nev_aimUsual
  , nev_aimHead
  , nev_aimSingleUsual
  , nev_aimSingleHead
 );//TnevAddInnerMode
 
 TnevInnerType = (
  nev_itNone
  , nev_itForDrawing
  , nev_itNeedInit
 );//TnevInnerType
 
 (*
 MnevBordersHolder = interface
 end;//MnevBordersHolder
 *)
 
 InevObjectModify = interface
  function Delete(anInMerge: Boolean;
   const anOp: InevOp): Boolean;
   {* ������� �������� aPara. }
 end;//InevObjectModify
 
 InevPara = interface;
 
 InevRange = interface;
 
 InevPoint = interface;
 
 InevBasePoint = interface;
 
 InevAnchor = interface;
 
 InevView = interface;
 
 InevObjectList = interface;
 
 InevObjectHolder = interface;
 
 InevBaseLine4Anchor = interface;
 
 InevBaseLine4Print = interface;
 
 InevObject = interface(InevObjectPrim)
  {* ������������ ������ }
  function Range(const aStart: InevBasePoint;
   const aFinish: InevBasePoint;
   aSharp: Boolean): InevRange;
   {* ��������� �� ������ �������. }
  function SubRange(const aView: InevView;
   aStart: Integer;
   aFinish: Integer): InevRange;
   {* ���������� ��������� �� ������ ������� �� aStart �� aFinish. }
  function MakePoint(const aParent: InevBasePoint): InevPoint;
   {* ����� � �������. }
  function CloneObj: InevObject;
  function OwnerObj: InevObjectList;
   {* ������������ ������ ������� �������. }
  function IsPara: Boolean;
  function AsPara: InevPara;
   {* ����������� ������ � ���������, ���� ��� ��������, ����� - ����������. }
  function ToList: InevObjectList;
  function MakeAnchor: InevAnchor;
  function Edit: InevObjectModify;
  function IsCollapsed(const aView: InevView): Boolean;
  function BaseLine4Anchor: InevBaseLine4Anchor;
  function BaseLine4Print: InevBaseLine4Print;
  function AppliesToMaxWidth: Boolean;
  procedure Invalidate(aParts: TnevShapeParts);
   {* �������� � ������������� ������������ �����, ���� ��� ������������ � �����-������ View. }
 end;//InevObject
 
 InevParaInternal = interface(InevPara)
  {* ��������, "��� ��� ��� �����". }
  procedure SignalPID(aPID: TnevParaIndex);
 end;//InevParaInternal
 
 InevDocumentContainer = interface;
 
 InevParaList = interface;
 
 InevSubList = interface;
 
 InevPara = interface(InevObject)
  {* ������� ��� ������ � ����� ��� � ����������. }
  function OwnerTag: Tl3Variant;
   {* ������������ ��� ������� ���������. }
  function OwnerPara: InevParaList;
   {* ������������ �������� ������� ���������. }
  function AsList: InevParaList;
  function IsComment: Boolean;
 end;//InevPara
 
 InevFontPrim = interface
  function SubFont(const aFont: InevFontPrim): Boolean;
   {* �������� �����. }
  function AsFont(CorrectItalic: Boolean): Il3Font;
   {* ����������� � Il3Font. }
  function GetParam(ItemIndex: TnevFontParam): Integer;
  procedure Set2Font(const aFont: Il3Font;
   CorrectItalic: Boolean);
   {* ����������� ���� Il3Font. }
  function Empty: Boolean;
  procedure MakeFontArray(BlockFont: Boolean);
  procedure InitFromTag(aTag: Tl3Variant);
 end;//InevFontPrim
 
 InevDataFormattingModify = interface
  function SetAtom(const aView: InevView;
   anIndex: Cardinal;
   aValue: Tl3Variant;
   const anOp: InevOp): Boolean;
  function ChangeParam(const aView: InevView;
   const aMarker: IevMarker;
   aValue: Integer;
   const anOp: InevOp): Boolean;
  function DeleteHyperlink(const anOp: InevOp): Boolean;
  function DeleteSegments(const anOp: InevOp): Boolean;
   {* ������� ��������. }
  function AddIndentMarker(const aView: InevView;
   aValue: Integer;
   const anOpPack: InevOp): Boolean;
  function DeleteIndentMarker(const aView: InevView;
   const anOpPack: InevOp): Boolean;
 end;//InevDataFormattingModify
 
 IevMarker = interface;
 
 InevDataFormatting = interface
  function GetFont(const aView: InevView;
   aMap: TnevFormatInfoPrim;
   Stop: PInteger): InevFontPrim;
  function GetStyle(Stop: PInteger): Tl3Variant;
  function Modify(const aView: InevView): InevDataFormattingModify;
 end;//InevDataFormatting
 
 TnevInsertStringFlag = (
  {* ���� �������� ��������/������� ������. }
  misfDirect
  , misfLockSegments
  , misfLockCursors
  , misfDraw
  , misfSetText
  , misfForSelection
   {* �������� ����������� ���������� �� � �������, � � ��������� http://mdp.garant.ru/pages/viewpage.action?pageId=220596558 }
 );//TnevInsertStringFlag
 
 TnevInsertStringFlags = set of TnevInsertStringFlag;
  {* ����� �������� ��������/������� ������. }
 
 InevTextModify = interface
  function InsertString(const aView: InevView;
   const aString: Il3CString;
   const anOp: InevOp;
   InsertMode: Boolean;
   aFlags: TnevInsertStringFlags): Boolean;
   {* ��������� ������. }
  function InsertStream(const aView: InevView;
   const aStream: IStream;
   aFormat: TnevFormat;
   const anOp: InevOp;
   aFlags: TevLoadFlags;
   aCodePage: Integer): Boolean;
  function DeleteString(const aView: InevView;
   Count: Integer;
   const anOp: InevOp;
   aFlags: TnevInsertStringFlags): Boolean;
   {* ������� ������. }
  function DeleteChar(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function InsertBreak(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function DeleteCharToLeft(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function Split(const aView: InevView;
   aFlags: TnevInsertStringFlags;
   const anOp: InevOp): Il3TagRef;
  function JoinWith(const aView: InevView;
   aSecondPara: Tl3Variant;
   const anOp: InevOp;
   MoveSubs: Boolean): Integer;
  function JoinWithNext(const aView: InevView;
   const anOp: InevOp): Boolean;
 end;//InevTextModify
 
 InevText = interface
  function CanBeDeleted: Boolean;
  function Modify: InevTextModify;
 end;//InevText
 
 (*
 MnevObjectPointer = interface
  {* "���������" �� ������ }
 end;//MnevObjectPointer
 *)
 
 InevLocation = interface(Il3TagRef)
  function Range: InevRange;
  function AsPoint: InevBasePoint;
 end;//InevLocation
 
 InevRangePrim_Iterate_Action = function(const anItem: InevRange;
  anIndex: Integer): Boolean;
  {* ��� �������������� ������� ��� InevRangePrim.Iterate }
 
 InevRangePrim = interface(InevLocation)
  {* ���������� ����� �������. ��� �������� �������� �� ������ }
  procedure Iterate;
   {* �������� �� ��������� ���������� �������� }
 end;//InevRangePrim
 
 TevClearMode = (
  ev_cmAll
  , ev_cmKeepOne
  , ev_cmEmpty
  , ev_cmForceKeepOne
   {* ������ ��������� ���� ��������.
http://mdp.garant.ru/pages/viewpage.action?pageId=228693150 }
  , ev_cmVertMergeCells
  , ev_cmClearFirstCell
  , ev_cmEmpty4BlockResize
  , ev_cmLeaveSegments
 );//TevClearMode
 
 InevRangeModify = interface
  {* ���������� ����� ������� � ������������ ��������������. }
  function Delete(const aView: InevView;
   const anOp: InevOp;
   aMode: TevClearMode;
   const aPara: InevPara): Boolean;
 end;//InevRangeModify
 
 IevSearchTool = interface
  procedure Start;
   {* ������ ������. }
  procedure Finish(aCancel: Boolean;
   const aBlock: InevRange);
   {* ����� ������. }
 end;//IevSearchTool
 
 IevSearcher = interface(IevSearchTool)
  {* ���������� ��� ����������� �������� ������ ��������� (��� ���������). }
  function Check(const aView: InevView;
   const aBlock: InevRange;
   out theStart: InevBasePoint;
   out theFinish: InevBasePoint;
   const PrevBlock: InevRange): Boolean;
   {* ���������� �������� ������ ��������� (��� ���������). }
 end;//IevSearcher
 
 InevConfirm = interface;
 
 IevReplacer = interface(IevSearchTool)
  function Replace(const Container: InevOp;
   const aBlock: InevRange;
   const aConfirm: InevConfirm): Boolean;
  function NeedProgress: Boolean;
 end;//IevReplacer
 
 TevReplaceConfirmEvent = function(Sender: TObject;
  const aBlock: InevRange): ShortInt of object;
  {* ������� ��� ������� �� ������ ��������� Block. ����������� ����� ����:
       |<br>
       |<ul>
       | <li><b>mrOk</b> - ��������.</li>
       | <li><b>mrYes</b> - ��������.</li>
       | <li><b>mrNo</b> - �� ��������.</li>
       | <li><b>mrAll</b> - �������� ���.</li>
       | <li><b>mrCancel</b> - ��������� ���� ������/������.</li>
       | <li><b>mrAbort</b> - ��������� ���� ������/������.</li>
       |</ul> }
 
 InevConfirm = interface
  {* call-back ��������� ��� ��������� ������� �� ������. }
  function ReplaceConfirm(const aBlock: InevRange;
   AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt;
   {* ������ �� ������. ������������ �������� ��. TevReplaceConfirmEvent. }
  function DeleteFoundRgn: Boolean;
  procedure Update;
 end;//InevConfirm
 
 (*
 MnevSearchReplace = interface
  function SearchReplace(const aSearcher: IevSearcher;
   const aReplacer: IevReplacer;
   const aConfirm: InevConfirm;
   const aCursor: InevBasePoint;
   const anOpPack: InevOp;
   aNeedProgress: Boolean): Boolean;
   {* ������� ������/������. ���������� - ���� �� ������ ������. }
 end;//MnevSearchReplace
 *)
 
 (*
 MnevSearchCriteria = interface
  {* �������� ������ }
  function Search(const aView: InevView;
   const aSearcher: IevSearcher;
   const Progress: Il3Progress;
   const aStart: InevBasePoint;
   out cFStart: InevBasePoint;
   out cFFinish: InevBasePoint): Boolean;
   {* ���� � ��������� �������� �nSearch
             � ���������� ������ � ����� ���������� ��������� � (cFStart, cFFinish). }
 end;//MnevSearchCriteria
 *)
 
 InevRangeFactory = interface(InevRange)
  {* ���������� ��������� ��� �������������� ��������� � ������� }
  procedure Init(const aStart: InevBasePoint;
   const aFinish: InevBasePoint;
   aSharp: Boolean);
 end;//InevRangeFactory
 
 IevTableRange = interface
  {* �������� ��������� � �������. }
  function GetRangeOffsets(out theStartOffset: Integer;
   out theFinishOffset: Integer): Boolean;
   {* ���������� �������������� ������� ��������� ���������. }
  function GetRangeBorders(out theStartRow: Integer;
   out theFinishRow: Integer;
   out theStartOffset: Integer;
   out theFinishOffset: Integer): Boolean;
   {* ���������� ������� ��������� ���������. }
  function Offset2Cells(aRow: Tl3Variant;
   aStartOffset: Integer;
   aFinishOffset: Integer;
   out theStartCell: Integer;
   out theFinishCell: Integer): Boolean;
   {* �������� ������� ��� ����� aRow ��� �������� (aStartOffset, aFinishOffset). }
 end;//IevTableRange
 
 InevDataObjectPrim2 = interface;
 
 InevRange = interface(InevRangePrim)
  {* ���������� ����� �������. }
  function SolidBottomChildBlock(const aView: InevView): InevRange;
  function GetChildSel(const aView: InevView;
   aChildIndex: Integer;
   aForDrawing: Boolean): InevRange;
  procedure GetBorderPoints(out BS: InevBasePoint;
   out BF: InevBasePoint);
  function BottomChildBlock(const aView: InevView): InevRange;
  function CloneSel(const aView: InevView): InevRange;
  function Modify: InevRangeModify;
  function ParentRange(aLevel: Integer): InevRange;
  function Contains(const aView: InevView;
   const aPoint: InevBasePoint): Boolean;
  procedure Select(const aView: InevView;
   const C: InevBasePoint;
   aTarget: TevSelectTarget;
   const Ctx: InevOp); overload;
  procedure Select(const aView: InevView;
   const C: InevBasePoint;
   aOpen: Integer;
   aClose: Integer;
   const Ctx: InevOp); overload;
  function Solid(const aView: InevView): Boolean;
  function ContainsEnd(const aView: InevView): Boolean;
  function Collapsed(const aView: InevView): Boolean;
  function AsStorable: InevDataObjectPrim2;
  procedure RefreshBorders;
   {* ��������� ������� �����. http://mdp.garant.ru/pages/viewpage.action?pageId=409750147 }
  function SearchReplace(const aSearcher: IevSearcher;
   const aReplacer: IevReplacer;
   const aConfirm: InevConfirm;
   const aCursor: InevBasePoint;
   const anOpPack: InevOp;
   aNeedProgress: Boolean): Boolean;
   {* ������� ������/������. ���������� - ���� �� ������ ������. }
  function Search(const aView: InevView;
   const aSearcher: IevSearcher;
   const Progress: Il3Progress;
   const aStart: InevBasePoint;
   out cFStart: InevBasePoint;
   out cFFinish: InevBasePoint): Boolean;
   {* ���� � ��������� �������� �nSearch
             � ���������� ������ � ����� ���������� ��������� � (cFStart, cFFinish). }
 end;//InevRange
 
 (*
 MnevBasePointModify = interface
  procedure AssignPoint(const aView: InevView;
   const aPoint: InevBasePoint);
  procedure DisableListener;
   {* ��������� ����������� �� ��������� }
  procedure EnableListener;
   {* �������� ����������� �� ��������� }
 end;//MnevBasePointModify
 *)
 
 (*
 MnevAnchorModify = interface
  {* ����� �������� � ������������ ����������� }
  procedure Bottom(const aView: InevView);
  function IncLine(const aView: InevView;
   var theLine: Integer;
   aByLine: Boolean): Integer;
   {* �������� ����� �� ��������� ����� �����. ���������� ���������� ���������� �� ������� ��������� �����. }
 end;//MnevAnchorModify
 *)
 
 TevParaMarkerStyle = (
  ev_pmsNone
  , ev_pmsFirstIndent
   {* ������ ������ ������ }
  , ev_pmsLeftIndent
   {* ����� ������ }
  , ev_pmsWrapColumn
   {* ������ ������� ������ }
  , ev_pmsColumnBorder
   {* ������� ������� ������� }
  , ev_pmsParaIndent
   {* ����� ������ ������ ���������� }
  , ev_pmsParaSize
   {* ������ ������ ���������� }
  , ev_pmsPageLeftIndent
   {* ����� ������ �������� }
  , ev_pmsPageRightIndent
   {* ������ ������ �������� }
  , ev_pmsPageSize
   {* ������ �������� }
  , ev_pmsTabIndent
   {* ������ ��������� �� ��������� }
 );//TevParaMarkerStyle
 
 IevMarker = interface
  {* ������ ����������� ��������� ������� (������, ������� � �.�.). }
  function MakeCopy(const aTagWrap: InevPara): IevMarker;
   {* ������ ����� ������� ��� aTagWrap. }
  procedure SetValue(Value: Integer;
   const Context: InevOp);
   {* ���������� ����� �������� ���������. }
  function CompareLevel(aTagWrap: Tl3Variant): Integer;
   {* �������� ������� ����������� ������� � ����. }
  function Compare(const aMarker: IevMarker): Integer;
   {* ���������� �������. }
 end;//IevMarker
 
 InevMap = interface;
 
 (*
 MnevViewBounds = interface
  {* ������� ������������� ������� }
  function ViewBounds(const aView: InevView;
   const aMap: InevMap): TnevRect;
   {* �������������� ����� "�������������". ��� ��������� ���������� ���������� �� ����� �������. ���� ����������� �������� �������������, �� ���������� ����� ������������ }
 end;//MnevViewBounds
 *)
 
 InevPointListener = interface
  {* ������, ����������� ����������� �� ��������� �������. }
  procedure CursorChanged(const aCursor: InevBasePoint);
   {* ������ aCursor ���������. }
  procedure ParaChanged(const aCursor: InevBasePoint);
   {* ������� �������� ���������. }
 end;//InevPointListener
 
 TnevMoveResult = (
  ev_dcNotDone
  , ev_dcDoneOk
  , ev_dcDoneFail
 );//TnevMoveResult
 
 IevCursorContext = interface
  {* ������ ��� ������ ��������� �������. }
  procedure RecordCursor(const aCursor: InevBasePoint);
   {* ������ ������ �������. }
  procedure StopRecord;
   {* ��������� ������ ��������. }
 end;//IevCursorContext
 
 (*
 MnevPointModify = interface
  function DoMove(const aView: InevView;
   aCode: Integer;
   const anOp: InevOp;
   aCount: Integer): TnevMoveResult;
  function Move(const aView: InevView;
   aCode: Cardinal;
   const anOp: InevOp;
   aCount: Integer): Boolean;
  procedure Refresh;
  procedure SetEntryPointPrim(Value: Integer;
   const Context: IevCursorContext);
  procedure SetEntryPoint(Value: Integer;
   const Context: IevCursorContext); overload;
  procedure SetEntryPoint(aValue: Integer;
   const aContext: InevOp); overload;
  function ToBottomChild(const aView: InevView): InevBasePoint;
  procedure SetAtEnd(const aView: InevView;
   aValue: Boolean);
  procedure SetAtStart(const aView: InevView;
   aValue: Boolean);
 end;//MnevPointModify
 *)
 
 IevROMarkersList = interface
 end;//IevROMarkersList
 
 IevMarkersList = interface(IevROMarkersList)
  function Add(const anItem: IevMarker): Integer;
 end;//IevMarkersList
 
 IevMarkersSource = interface
  {* �������� ��������, � ��������� ��� ������ (��. TevRuler) }
  procedure GetMarkers(const aView: InevView;
   const aList: IevMarkersList);
   {* �������� ������� �� ��������� � aList. }
 end;//IevMarkersSource
 
 (*
 MnevPaintOffsetY = interface
  function PaintOffsetY(const aView: InevView;
   aMap: TnevFormatInfoPrim): Integer;
 end;//MnevPaintOffsetY
 *)
 
 InevLeafPoint = interface
  {* ��������� �����. }
  procedure InitPointByPt(const aView: InevView;
   const aPoint: TnevPoint;
   const aMap: InevMap);
  function PaintOffsetY(const aView: InevView;
   aMap: TnevFormatInfoPrim): Integer;
 end;//InevLeafPoint
 
 (*
 MnevParentPointFactory = interface
  {* ������������� �������� �� ������������ ������ }
  function PointToParent(const aThisTarget: InevObjectPrim;
   aNeedShowCollapsed: Boolean): InevBasePoint;
 end;//MnevParentPointFactory
 *)
 
 (*
 MnevParentPointFactoryEx = interface
  function PointToParentByLevel(aLevel: Integer): InevBasePoint;
  function PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
 end;//MnevParentPointFactoryEx
 *)
 
 (*
 MnevOuter = interface
 end;//MnevOuter
 *)
 
 (*
 MnevParentPoint = interface
 end;//MnevParentPoint
 *)
 
 (*
 MnevMostInner = interface
  {* ����� ���������� ����� ������� }
 end;//MnevMostInner
 *)
 
 (*
 MnevDiff = interface
  function Diff(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Integer;
   {* ���������� ������ � "������" �� ���������. }
  function PartiallyVisible(const aView: InevView;
   const aPoint: InevBasePoint;
   const aMap: TnevFormatInfoPrim): Boolean;
   {* ���������� ����� �� ����� "�������� �������" ������������ ������ ����� (aPoint). ������� ��� ����������� ��������� ��������� ������ ������������ �����. }
 end;//MnevDiff
 *)
 
 (*
 MnevCorrectMove = interface
  procedure CorrectMoveRight(const aView: InevView;
   const aPoint: InevBasePoint;
   const anOp: InevOp);
 end;//MnevCorrectMove
 *)
 
 InevControlView = interface;
 
 InevBasePoint = interface(InevLocation)
  {* ������� ����� ������ ������� }
  function VertPosition(const aView: InevView;
   aMap: TnevFormatInfoPrim): TnevParaIndex;
  function NeedWindowsCaret: Boolean;
  function ClonePoint(const aView: InevView): InevBasePoint;
  function DeltaX(const aView: InevView;
   const aMap: InevMap): Integer;
  function InnerFor(const aChild: InevObject;
   var aRealTop: InevBasePoint): InevBasePoint;
  function AtEnd(const aView: InevView): Boolean;
  function AtStart: Boolean;
  function Compare(const aPoint: InevBasePoint): Integer;
  procedure CheckPos(const anOp: InevOp);
   {* ����������� �� ���������������� ������� ������� � ��������� ���������. �������� ������� }
  function ReadOnly: Boolean;
  function AsCursor(const aView: InevView): InevPoint;
  function ProcessMessage(const aView: InevControlView;
   var aMessage: TMessage;
   aTime: Cardinal): Boolean;
  function GetBlockLength: Integer;
  procedure MergeTo(const aView: InevView;
   const aBaseLine: InevBasePoint);
   {* ���������� �������� ������������ ������. }
  function InnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
   aForDrawing: TnevInnerType): InevBasePoint;
   {* �������� ������ ��������, �� �������� ����� �������� ��������� �����. }
  function HasBaseLine: Boolean;
   {* ��������� ���� �� ����������� ������ � ������� ������ �� ����� }
  procedure AddInner(const aView: InevView;
   const anInner: InevBaseLine4Anchor;
   anIndex: Integer;
   var aFirst: Boolean;
   aMode: TnevAddInnerMode);
  procedure CompareWithOtherInner(const aView: InevView;
   anMaxID: Integer);
   {* ����� ���������� AnchorByPoint ����� �������� "��������������������" (����� ��������� �� ������ ������) �������� ����� � ������� �����. }
  function InnerHead(aPID: Integer): InevBasePoint;
   {* ������ InnerFor, �� ��� ������ ������������ �����, ���������� �� ������ ������ (���� ������������ ������ ��� ������). }
  function HasHeadPart: Boolean;
   {* ������ �������� ����������� ������������ �����. }
  procedure AddHeadInner(const aHeadInner: InevBasePoint);
   {* ������ ��� ���������� � ������� ����� ����������� ������������ ����� (������������ ������ ��� ������). }
  procedure CopyHeadParts(const aFrom: InevBasePoint);
   {* �������� ������ ����� ����������� �����, ���� ��� ����. }
  procedure InitByCursor(const aView: InevView;
   const anInnerPoint: InevBasePoint);
   {* �������������� ������� ����� �� �������. }
  procedure InitBaseLineInner(const aView: InevView;
   const anItem: InevPara);
  function InnerTop(const aChild: InevObject): InevBasePoint;
   {* ���������� ��������� �� �������������� ������� ��� �����. ��� ������� ����� - ������ nil. }
  procedure AssignPoint(const aView: InevView;
   const aPoint: InevBasePoint);
  procedure DisableListener;
   {* ��������� ����������� �� ��������� }
  procedure EnableListener;
   {* �������� ����������� �� ��������� }
  procedure Bottom(const aView: InevView);
  function IncLine(const aView: InevView;
   var theLine: Integer;
   aByLine: Boolean): Integer;
   {* �������� ����� �� ��������� ����� �����. ���������� ���������� ���������� �� ������� ��������� �����. }
  function DoMove(const aView: InevView;
   aCode: Integer;
   const anOp: InevOp;
   aCount: Integer): TnevMoveResult;
  function Move(const aView: InevView;
   aCode: Cardinal;
   const anOp: InevOp;
   aCount: Integer): Boolean;
  procedure Refresh;
  procedure SetEntryPointPrim(Value: Integer;
   const Context: IevCursorContext);
  procedure SetEntryPoint(Value: Integer;
   const Context: IevCursorContext); overload;
  procedure SetEntryPoint(aValue: Integer;
   const aContext: InevOp); overload;
  function ToBottomChild(const aView: InevView): InevBasePoint;
  procedure SetAtEnd(const aView: InevView;
   aValue: Boolean);
  procedure SetAtStart(const aView: InevView;
   aValue: Boolean);
  function PointToParent(const aThisTarget: InevObjectPrim;
   aNeedShowCollapsed: Boolean): InevBasePoint;
  function PointToParentByLevel(aLevel: Integer): InevBasePoint;
  function PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
  function Diff(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Integer;
   {* ���������� ������ � "������" �� ���������. }
  function PartiallyVisible(const aView: InevView;
   const aPoint: InevBasePoint;
   const aMap: TnevFormatInfoPrim): Boolean;
   {* ���������� ����� �� ����� "�������� �������" ������������ ������ ����� (aPoint). ������� ��� ����������� ��������� ��������� ������ ������������ �����. }
  function ViewBounds(const aView: InevView;
   const aMap: InevMap): TnevRect;
   {* �������������� ����� "�������������". ��� ��������� ���������� ���������� �� ����� �������. ���� ����������� �������� �������������, �� ���������� ����� ������������ }
  procedure CorrectMoveRight(const aView: InevView;
   const aPoint: InevBasePoint;
   const anOp: InevOp);
 end;//InevBasePoint
 
 InevBaseLine4Anchor = interface(InevBasePoint)
 end;//InevBaseLine4Anchor
 
 InevBaseLine4Print = interface(InevBaseLine4Anchor)
 end;//InevBaseLine4Print
 
 TevDeleteParaFlag = (
  ev_dpfAtEnd
  , ev_dpfInternal
  , ev_dpfInMerge
  , ev_dpfForce
 );//TevDeleteParaFlag
 
 IevTagLine = interface
  {* "������" � ������� }
  function GetLine(aMap: TnevFormatInfoPrim): Integer;
 end;//IevTagLine
 
 IevOpInsertPara = interface
  function DoIt(const anOpPack: InevOp;
   aPara: Tl3Variant;
   aFlags: TevInsertParaFlags): Boolean;
 end;//IevOpInsertPara
 
 TevDeleteParaFlags = set of TevDeleteParaFlag;
 
 IevSavedCursor = interface
  procedure Store(const Cursor: InevBasePoint);
  procedure Load(const Cursor: InevBasePoint);
  function Clone: IevSavedCursor;
 end;//IevSavedCursor
 
 InevLinkedPoint = interface(InevPoint)
  {* �����, ����������� � �������� }
  procedure LinkListener(const aListener: InevPointListener);
  procedure UnlinkListener(const aListener: InevPointListener);
 end;//InevLinkedPoint
 
 IevOpDeletePara = interface
  function DoIt(const anOpPack: InevOp;
   aFlags: TevDeleteParaFlags): Boolean;
 end;//IevOpDeletePara
 
 TevLineStyle = (
  ev_lsNormal
  , ev_lsClear
  , ev_lsSymbol
  , ev_lsMove
 );//TevLineStyle
 
 TevLineDirection = (
  {* ����������� ��������� ����� }
  ev_ldUp
  , ev_ldDown
  , ev_ldLeft
  , ev_ldRight
  , ev_ldHome
  , ev_ldEnd
 );//TevLineDirection
 
 IevDrawLineTool = interface
  {* ���������� ��� ��������� ����� }
  function DrawLine(const aView: InevView;
   aDirection: TevLineDirection;
   aStyle: TevLineStyle;
   const anOp: InevOp): Boolean;
   {* ���������� ����� � ����������� aDirection }
 end;//IevDrawLineTool
 
 InevPoint = interface(InevBaseLine4Print)
 end;//InevPoint
 
 InevAnchor = interface(InevBaseLine4Anchor)
  {* ����� �� ����� ������ ������� }
  function LinkListener(const aView: InevScrollListener): InevScrollListener;
  procedure UnlinkListener(const aControl: InevScrollListener);
 end;//InevAnchor
 
 InevMap = interface(InevShapePrim)
  function IsMapValid: Boolean;
  function rVisible: Boolean;
  procedure SetDrawnBottom(const aBottom: TnevPoint);
  function ReserveMap(const aShape: InevObject): InevMap;
  function IsLinked: Boolean;
  procedure AdjustTopByAnchor(const aView: InevView;
   const anAnchor: InevBasePoint);
  function CheckFormatInfo(const anObject: InevObject): TInevFormatInfoRet;
  procedure ClearBounds;
   {* ������� �������������. }
  function GetMaxTop: Integer;
   {* ���� ����� ������ �������� Top � �������� �����. }
  function GetChildMap(anIndex: Integer): InevMap;
  procedure SetDrawnTop(aTop: Integer);
  function GetChildenRight4Fill: Integer;
 end;//InevMap
 
 (*
 ShapeView = interface
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
 end;//ShapeView
 *)
 
 InevSimpleView = interface
  {* ����� ����������� ������� � ����������� ���������� �������������� �����������. }
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
 end;//InevSimpleView
 
 InevActiveElement = interface;
 
 (*
 ActiveElementHolder = interface
  {* ������ ��������� �������� ��������� ���������� }
 end;//ActiveElementHolder
 *)
 
 InevK235870994Hacker = interface
  {* [RequestLink:235870994] }
  function HackK235870994(const aMap: InevMap): Boolean;
 end;//InevK235870994Hacker
 
 InevMeasureView = interface
  {* "������� ������" ��� ��������� }
  procedure MakePointVisible(const aTop: InevAnchor;
   const aPoint: InevBasePoint;
   var thePos: Integer);
   {* ������ ���, ����� ������ ��� ����� �� �������� ������ }
 end;//InevMeasureView
 
 (*
 InevShapesPainted = interface
  {* ��������� ����������� ������ � ���������� ������������ ���������� }
  function Root: InevMap;
  function PointByPt(const aView: InevView;
   const aPos: TnevPoint;
   CheckHidden: Boolean): InevBaseLine4Anchor;
   {* ���������� �������� ������ ������� ������ �� �����������. }
  function MapByPoint(const aPoint: InevBasePoint): InevMap;
  function Empty: Boolean;
  function SubShapesCount: Integer;
  procedure SetSingle(aValue: Boolean);
   {* ��������� � ����� ��������� ���������� ��������. }
  procedure Clear;
   {* ������� ������ InevShape. }
  procedure ClearEx;
   {* ������� ������ InevShape. <?> ��� ���������� �� Clear? }
  procedure BeginDraw(const aShape: InevObject;
   const anAnchor: InevBasePoint;
   const aTopLeft: TnevPoint;
   var theMap: InevMap);
  procedure EndDraw;
  function MaxWidth: Integer;
  function VertScroll(const aView: InevView;
   const aFrom: InevBasePoint;
   const aTo: InevBasePoint;
   const anEx: TnevPoint): Integer;
   {* ���������� ���������� �������� ��������� �� ���������� �� aFrom ��
             aTo � ���������� ���������� ����� �������� ��������� ����������. }
  function HorzScroll(aFrom: Integer;
   aTo: Integer;
   const anEx: TnevPoint): Integer;
   {* ���������� ���������� �������� ��������� �� ���������� �� aFrom ��
             aTo � ���������� ���������� ����� �������� ��������� ����������. }
 end;//InevShapesPainted
 *)
 
 InevView = interface(InevSimpleView)
  {* ����� ����������� ������� }
  function Data: InevObject;
  function RootMap: InevMap;
  function Processor: InevProcessor;
  procedure ClearShapes;
  procedure BeginDrawShape(const aShape: InevObject;
   const anAnchor: InevBasePoint;
   const anOrg: TnevPoint;
   var theMap: InevMap;
   aFake: Boolean;
   const aHacker: InevK235870994Hacker);
   {* �������� ���������� ����� � ������. }
  procedure EndDrawShape;
   {* ����������� ���������� ����� � ������. }
  function MapByPoint(const aPoint: InevBasePoint;
   aCheckTopVisible: Boolean): InevMap;
  function FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
  function RootFormatInfo: TnevFormatInfoPrim;
  procedure VersionInfoVisabilityChanged(aValue: Boolean);
  function FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim; overload;
  function FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
  function FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim; overload;
 end;//InevView
 
 TnevChangePlace = (
  {* ��� �������� }
  nev_cpView
   {* ��������� ������� ����������� ���������� }
  , nev_cpPara
   {* ������ ���������� ��������� }
  , nev_cpText
   {* ����� ��������� ��������� }
 );//TnevChangePlace
 
 InevViewArea = interface(InevSimpleView)
  {* ������� ������. }
  procedure Invalidate;
   {* �������� �������� � ������������� �����������, �����-������ � �������. }
  procedure Update;
   {* �������� �������� � ������������� �����������, � ������ ������. }
  procedure Changed(aPlace: TnevChangePlace);
   {* ������ ��� ����������� ���������� }
 end;//InevViewArea
 
 InevSelection = interface
  function Select(const aSource: InevRange;
   AllowAddToMulti: Boolean): Boolean;
   {* ����������� ���� ��������� �������. }
  procedure SelectPt(const Value: TnevPoint;
   aNeedUpdate: Boolean);
   {* ������������� ������� ��������� (� ������� �����������). }
  function SelectPoint(const aPoint: InevBasePoint;
   aNeedSetTop: Boolean;
   aNeedShowCaret: Boolean;
   aDiff: Integer): Boolean;
   {* �������� aNeedSetTop �������� ������������ �� ������� ���� ������ ��� ������
���� false, �� ������ ������ ���������� � ����� ����� ������
� ���� true - �� ����� ������ }
  function AddBlock(const aStart: InevBasePoint;
   const aFinish: InevBasePoint): Boolean;
   {* ��������� ������� ���������. }
  function Unselect: Boolean;
   {* ����� ���������. }
  function GetBlock: InevRange;
   {* �������� ������� ������ ���������. }
  function Contains(const C: InevBasePoint): Boolean;
   {* ��������� �������� �� ��������� ������. }
 end;//InevSelection
 
 InevInputView = interface;
 
 InevControl = interface(IafwControl)
  {* ������� ������. }
  procedure InvalidateRect(const aRect: TnevRect);
   {* �������� �������� � ������������� ����������� ���������� ��������������, �����-������ � �������. }
  procedure SignalScroll(aDeltaY: Integer;
   aNeedVert: Boolean);
   {* �������� ��������, � ���, ��� ���������� ������� ���������. }
  function GetDelphiControl: TComponent;
  function CloseQuery: Boolean;
   {* ���������� �������, � ����������� �������� ����, �������� �� �����������. }
  function LP2DP(const aPoint: TnevPoint;
   toScreen: Boolean): TPoint;
  procedure CursorChanged;
  function CanScroll: Boolean;
  procedure SetFlag(aFlag: TevUpdateWindowFlag);
   {* ���������� ���� aFlag. }
  procedure UpdateCaretAndInvalidate;
   {* ��������� � ����������� ������� + �������������� }
  procedure ParaChanged;
   {* ����������� � ����� �������� ���������. }
  procedure ForceRepaint;
   {* �� ������� ������������ ���������� �������� (����� ������ �������� ��������������). ����� ��� http://mdp.garant.ru/pages/viewpage.action?pageId=204113269 }
  function InClose: Boolean;
   {* �������� � �������� ��������. }
 end;//InevControl
 
 InevControlView = interface(InevView)
  {* ����� ����������� �������, ����������� � �������� ������. }
  function PointByPt(const aPt: TnevPoint;
   aForSetCursor: Boolean): InevBasePoint;
   {* ���������� ������ ����������� �� ������ �����, � ������� ��������� View. }
 end;//InevControlView
 
 InevLinkedView = interface(InevControlView)
  {* ����� ����������� �������, ����������� � �������� ������. }
  procedure UnlinkControl(const aControl: InevControl);
   {* ����������� ������� �� ������� ������. }
 end;//InevLinkedView
 
 InevDrawView = interface(InevLinkedView)
  function IsDocumentTailVisible: Boolean;
  function Draw(const aBlock: InevRange;
   var theMap: InevMap): Boolean;
  function BottomAnchor(aSimple: Boolean): InevAnchor;
 end;//InevDrawView
 
 InevScrollView = interface(InevDrawView)
  {* View � ������������ ��������������. }
 end;//InevScrollView
 
 InevSelectionView = interface(InevScrollView)
  {* View � ������������ ��������� ��������. }
  function MakePointVisible(const aPoint: InevBasePoint): Boolean;
  procedure MakePairVisible(const aStart: InevBasePoint;
   const aFinish: InevBasePoint);
 end;//InevSelectionView
 
 InevInputView = interface(InevSelectionView)
  {* View � ������������ �����. }
  function InMakeCaretVisible: Boolean;
  procedure MakeCaretVisible;
  function IsCaretVisible: Boolean;
  procedure ClearPointToShow;
   {* �������� �������������� ������� ��� �������� }
 end;//InevInputView
 
 InevStorable = interface
  procedure Store(const aView: InevView;
   const G: InevTagGenerator;
   aFlags: TevdStoreFlags); overload;
   {* ��������� ��������� � G. }
 end;//InevStorable
 
 InevDataObjectPrim2 = interface(InevStorable)
 end;//InevDataObjectPrim2
 
 InevObjectList = interface(InevObject)
  function IndexOfObj(const aPara: InevObject): TnevParaIndex;
 end;//InevObjectList
 
 IevSubCache = interface
  procedure ClearSubs;
  procedure NotifySubDeleted(const aSub: IevSub);
 end;//IevSubCache
 
 IevSub = interface;
 
 (*
 MnevTextArea = interface
  {* ������� ������ }
 end;//MnevTextArea
 *)
 
 IelEditStrings = interface
  {* ������ ���������. }
 end;//IelEditStrings
 
 InevTagReader = interface
  function ReadTag(aFormat: TnevFormat;
   const aPool: IStream;
   const aFilters: InevTagGenerator;
   const Block: InevDataObjectPrim2;
   aFlags: TevdStoreFlags;
   aCodePage: Integer): Integer;
   {* ������� ��� �� Storage � aPool. }
  function ReadTagEx(const Writer: InevTagGenerator;
   const aPool: IStream;
   const aBlock: InevDataObjectPrim2;
   aFlags: TevdStoreFlags;
   CharCountMul: Integer;
   const FormatName: Il3CString;
   aCodePage: Integer): Integer;
   {* �������� �������� � ������ (Pool) �� TextSource. }
 end;//InevTagReader
 
 InevTagWriter = interface
  function WriteTag(const aView: InevView;
   aFormat: TnevFormat;
   const aPool: IStream;
   const aBlock: IUnknown;
   aFlags: TevLoadFlags;
   aCodePage: Integer): Boolean;
   {* �������� ��� �� Pool � Storage. }
  procedure WriteTagEx(const aView: InevView;
   const aReader: InevReader;
   const aBlock: IUnknown;
   aFlags: TevLoadFlags);
   {* �������� ��� �� Pool � Storage. }
 end;//InevTagWriter
 
 InevFormatPool = interface
  function FormatInfoForView(const aView: InevView): TnevFormatInfoPrim;
  procedure ClearFormatInfoForView(const aView: InevView);
 end;//InevFormatPool
 
 InevSectionBreaks = interface
  function GetSectionWidth(const aChild: InevObject;
   out theWidth: Integer): Boolean;
  function GetSectionBreak(const aChild: InevObject;
   out theBreak: InevObject): Boolean;
   {* ���������� ������ ������� ��� ���������� ��������� �������� }
 end;//InevSectionBreaks
 
 InevObjectHolder = interface(InevObjectHolderPrim)
  function TagReader: InevTagReader;
  function TagWriter: InevTagWriter;
  function FindObjByID(aParaID: Integer;
   out aPara: InevObject): Boolean;
  procedure ChildAdded(aList: Tl3Variant;
   aProp: Tk2ArrayProperty;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: InevOp);
  procedure ChildDeleted(aList: Tl3Variant;
   aProp: Tk2ArrayProperty;
   aChild: Tl3Variant;
   anIndex: Integer;
   const anOpPack: InevOp);
  procedure UpdatePreview;
  procedure PropChanged(Prop: Tk2Prop;
   const V: TnevValues;
   const anOpPack: InevOp);
  procedure SectionBreakAdded(const anObject: InevObject);
   {* ��������� ������ ������� }
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  function AllowsThisDecor(aFI: TnevFormatInfoPrim;
   aType: TnevDecorType): Boolean;
   {* ��������� �� ��������� ��������� ��������� ��������� ������������� }
 end;//InevObjectHolder
 
 IevSelectionPairs = interface
 end;//IevSelectionPairs
 
 IevTreeDataObject = interface
  procedure Store(const G: InevTagGenerator;
   aLevelTag: Integer;
   aIndent: Integer);
   {* ��������� ���� ������ � G }
 end;//IevTreeDataObject
 
 IevDocumentPreviewInfo = interface
 end;//IevDocumentPreviewInfo
 
 InevDocumentLimits = interface
  {* ����������� ���������. }
 end;//InevDocumentLimits
 
 InevDocumentInfo = interface
  {* ���������� � ���������. }
  procedure ClearStat;
 end;//InevDocumentInfo
 
 TevChangeType = (
  ev_chtAdded
  , ev_chtDeleted
  , ev_chtDocument
 );//TevChangeType
 
 TnevDocumentEvent = (
  nev_deNettoCharCountChange
  , nev_deBruttoCharCountChange
  , nev_deTextParaCountChange
  , nev_deTOCCreated
  , nev_deChangeModified
 );//TnevDocumentEvent
 
 InevSubChangeListener = interface
  procedure SubChanged(aSub: Tl3Variant;
   aChangeType: TevChangeType);
   {* ��� ��������/������. }
 end;//InevSubChangeListener
 
 InevCommentTextProvider = interface
  function GetCommentTextByParaID(aParaID: Integer): Il3CString;
  procedure DeleteCommentByParaID(aParaID: Integer);
 end;//InevCommentTextProvider
 
 InevWaiter = interface
  function TrySelect(const aContainer: InevDocumentContainer): Boolean;
  function TrySelectObj(const aContainer: InevDocumentContainer;
   aParent: Tl3Variant;
   aChild: Tl3Variant): Boolean;
 end;//InevWaiter
 
 InevTextSource = interface;
 
 IevDocument = interface;
 
 InevDocumentContainer = interface(InevObjectHolder)
  {* ��������� ���������. ������ ��� ����� ��������� � �����������, View, � TextSource. }
  function HasDocument: Boolean;
  function IsSame(const aContainer: InevDocumentContainer): Boolean;
  function IsSameText(const aTextSource: IUnknown): Boolean; overload;
  function IsSameText(const aContainer: InevDocumentContainer): Boolean; overload;
  function ReadFrom(const aStream: IStream): Boolean;
  procedure WriteTo(const aGenerator: InevTagGenerator);
  procedure LinkTextSource(const aTextSource: InevTextSource);
  procedure UnlinkTextSource(const aTextSource: InevTextSource);
  function HasProcessor: Boolean;
  procedure RemoveFromDocumentsCache;
  function Internal: IUnknown;
   {* //InevDocumentContainerInternal }
  procedure GetSubFlagsIterator(aLayer: Integer);
  function Preview(const aKey: TevPreviewCacheKey;
   const aMacroReplacer: IafwHAFMacroReplacer;
   const aRange: InevRange;
   TreatRangeAsSelection: Boolean): InevComplexDocumentPreview;
  function RealizeSub(aLayerHandle: Integer;
   Atom: Tl3Variant;
   anObject: Tl3Variant): Tl3Variant; overload;
  function LinkWaiter(const aWaiter: InevWaiter): Boolean;
  function GetGenerator(const aView: InevView;
   const aGeneratorTarget: IUnknown): InevTagGenerator;
  procedure LinkSubChangeListener(const aSubChangeListener: InevSubChangeListener);
  function DefaultDocumentType: Tk2Type;
   {* ��� ��������� ��-��������� }
  procedure NotifySubAdded(aParaID: Integer;
   aSubID: Integer;
   aLayerID: Integer;
   const aSubName: Tl3WString;
   aFlags: Integer);
   {* ����������� � ���������� Sub'� � ������ "�������" ��������� }
 end;//InevDocumentContainer
 
 TevInsertParaFlag = (
  ev_ipfCheckPrev
  , ev_ipfNeedFire
  , ev_ipfForce
  , ev_ipfAtEnd
 );//TevInsertParaFlag
 
 (*
 MnevParaIterator = interface
 end;//MnevParaIterator
 *)
 
 TevInsertParaFlags = set of TevInsertParaFlag;
 
 InevParaListModify = interface(Il3TagRef)
  {* ������� ��� ������ � ����� ��� �� ������� ����������. }
  function InsertPara(aPID: TnevParaIndex;
   aPara: Tl3Variant;
   const anOp: InevOp;
   aFlags: TevInsertParaFlags): Boolean;
   {* ��������� �������� � ��������� �������. }
  function InsertDefaultPara(aPID: TnevParaIndex;
   const anOp: InevOp;
   aNeedFire: Boolean): Boolean;
   {* ��������� �������� � ����� ��-��������� � ��������� �������. }
 end;//InevParaListModify
 
 InevParas = interface
  {* �������� ������� ������ ����������. �� �������� ��������� ��������� ���������. ������ ��� �������� �������� ��� ������ ����������. }
 end;//InevParas
 
 InevParaList_IteratePara_Action = function(const anItem: InevPara;
  anIndex: Integer): Boolean;
  {* ��� �������������� ������� ��� InevParaList.IteratePara }
 
 InevParaList = interface(InevPara)
  {* ������� ��� ������ � ����� ��� �� ������� ���������� ��� ����������� �����������. }
  procedure IteratePara;
  function GetParas(aFrom: TnevParaIndex;
   aTo: TnevParaIndex): InevParas;
   {* ���������� ������ ����������. }
  function Modify: InevParaListModify;
 end;//InevParaList
 
 TnevPoint = nevBase.TnevPoint;
 
 TnevRect = nevBase.TnevRect;
 
 TevMouseState = TnevMouseState;
 
 TevNeighbourPos = (
  {* ������� ������. }
  ev_npUp
  , ev_npDown
  , ev_npDownInternal
 );//TevNeighbourPos
 
 InevComplexDocumentPreview = nevBase.InevComplexDocumentPreview;
 
 TevMouseEffect = TnevMouseEffect;
 
 InevOp = nevBase.InevOp;
 
 InevProcessor = nevBase.InevProcessor;
 
 TnevFramePart = nevBase.TnevFramePart;
 
 InevScrollListener = nevBase.InevScrollListener;
 
 InevCanvas = nevBase.InevCanvas;
 
 TevCursorState = TnevCursorState;
 
 InevProgress = nevBase.InevProgress;
 
 TnevColor = nevBase.TnevColor;
 
 InevInfoCanvas = nevBase.InevInfoCanvas;
 
 InevSimpleTree = nevBase.InevSimpleTree;
 
 InevViewMetrics = nevBase.InevViewMetrics;
 
 InevSimpleNode = nevBase.InevSimpleNode;
 
 InevNode = nevBase.InevNode;
 
 TevLoadDocFlag = (
  {* ���� ��������� }
  ev_ldfDocumentReaded
 );//TevLoadDocFlag
 
 TevLoadDocFlags = set of TevLoadDocFlag;
  {* ����� ��������� }
 
 (*
 BasePrimitives = interface
  {* ������� ���� }
 end;//BasePrimitives
 *)
 
 InevSubList_Iterate_Action = function(const anItem: IevSub;
  anIndex: Integer): Boolean;
  {* ��� �������������� ������� ��� InevSubList.Iterate }
 
 IevDocumentPart = interface;
 
 InevSubList = interface
  {* ������ �����. }
  procedure Iterate;
   {* ���������� ������ ����� }
 end;//InevSubList
 
 IevSub = interface
  {* ����� ����� (�����) }
  function IsVisibleOnSubPanel: Boolean;
  procedure SetTo(EntryPoint: Tl3Variant);
   {* ������������� ����� � EntryPoint. }
  function Select(const Selection: InevSelection): Boolean;
   {* ���������� Selection �� ������ �����. }
  function Delete(const aView: InevView): Boolean;
   {* ������� �����. }
  function IsInIndex: Boolean;
  function Exists: Boolean;
   {* ��������� ���������� �� ����� �����. }
  function SubInstance: Tl3Variant;
   {* ���������� Sub. }
  function AsObject: Tl3Variant;
 end;//IevSub
 
 InevTool = interface
 end;//InevTool
 
 InevTextSource = interface
  {* �������� ���������. ������ ��� ����� ��������� � ����������� � View }
  function CastAnyEditorTo(const IID: TGUID;
   out theObj): Boolean;
  procedure DocumentChanged(anOldDocument: Tl3Variant;
   aNewDocument: Tl3Variant);
  procedure MakeCursor;
  function GetSubFlags(aLayer: Integer;
   const aSubList: InevSubList): Boolean;
  function GetControlData(const aControl: IevControl): IUnknown;
   {* ���������� ������ ��� ��������. }
  function GetControlImg(const aControl: TnevControlInfo;
   out theImageInfo: TnevControlImageInfo): Boolean;
   {* ���������� �������� ��� ��������. }
  procedure PropChanged(Prop: Tk2Prop;
   const V: TnevValues;
   const anOpPack: InevOp);
 end;//InevTextSource
 
 TevContentsRec = object
 end;//TevContentsRec
 
 IevDocumentPart = interface(IevSub)
  {* ����������� ���� ���������. }
  function Merge: Boolean;
   {* ���������� ���� �� ���������. }
  function GetViewKind: TevBlockViewKind;
 end;//IevDocumentPart
 
 IevDocument = interface(IevDocumentPart)
  {* ��������. }
 end;//IevDocument
 
 InevActiveElement = interface
  {* �������� ������� ������ }
  procedure Invalidate;
   {* �������������� ������� ��������� �������� }
  function IsSame(const anElement: InevActiveElement): Boolean;
 end;//InevActiveElement
 
 PInevObject = ^InevObject;
 
 HnevView = object
  {* ������ ��� InevView }
 end;//HnevView
 
 InevCommentSwitcher = interface
 end;//InevCommentSwitcher
 
 InevRestartPositionSource = interface
  {* �������� ������� ����������� searcher'� }
 end;//InevRestartPositionSource
 
 InevDocumentProvider = interface(InevStorable)
  {* ��������� ��������� }
 end;//InevDocumentProvider
 
 InevControlListener = interface
  function CanInsertPara: Boolean;
   {* ��������� �� ��������� ��������. }
  procedure InsertOnUndo(aPrev: Tl3Variant;
   aChild: Tl3Variant;
   anAdd: Boolean);
   {* ������� �� ������� ��� �������. }
  procedure DeleteOnUndo(aTag: Tl3Variant);
   {* ������� �������� ��� �������. }
  procedure HideDroppedControl(CanSetFocus: Boolean);
   {* ���������� ��������� ������� ��������� ��������� (����� ��� ����������� ��������). }
  function MouseWheel(aDown: Boolean): Boolean;
   {* ������� ��������� ����. }
  function KeyDown(const aView: InevView;
   var Msg: TWMKeyDown;
   aCurPara: Tl3Variant): Boolean;
   {* ������� ��������� � ������� ������. }
  procedure ChangePara(const aCurPara: InevPara);
   {* ������� ����� ������� ���������. }
  procedure BeforeRMouseClick;
   {* �������, ���������� ����� ���������� ����. }
  procedure ClearUpper;
  function NeedKey(aPara: Tl3Variant;
   var aKeyCode: Word): Boolean;
   {* �������/���� ������������� ������. }
  procedure CursorCreate;
   {* �������� ������ ����� ��������. }
  procedure UpdateState;
  function IsLastField(aPara: Tl3Variant): Boolean;
   {* ��������� �������� �� �������� ��������� ��� �������� ������. }
  function IsFirstField(aPara: Tl3Variant): Boolean;
   {* ��������� �������� �� �������� ������ ��� �������� ������. }
  procedure StartPaste;
   {* ������ ��� �������� �������. }
  procedure FinishPaste;
   {* ������ ��� �������� �������. }
  function IsPasting: Boolean;
   {* ������ ������ ��� �������� �������. }
  function GetFirstPara(OnlyFields: Boolean): InevPara;
   {* �������� ������ ��������, � ������� ����� �������� �����. }
  function GetLastPara(OnlyFields: Boolean): InevPara;
   {* �������� ��������� ��������, � ������� ����� �������� �����. }
 end;//InevControlListener
 
 InevQueryDocumentContainer = interface(InevDocumentContainer)
  function GetCurrPara: Tl3Variant;
  procedure SetCursorToPara(const aPara: InevPara;
   bAtEnd: Boolean;
   aNeedClear: Boolean);
   {* ������������� ������ �� ������������ ��������. }
  procedure ClearCard;
   {* ���������� ������� ��. }
  procedure AfterCollapsed;
  procedure ReleaseListeners;
  procedure LinkListener(const aListener: InevControlListener);
  procedure UnlinkListener(const aListener: InevControlListener);
 end;//InevQueryDocumentContainer
 
 IevRange = interface
  {* ��������� }
  procedure AssignSel(const aView: InevView;
   const aSource: InevRange);
   {* ����������� ���� ��������� ������� }
  function GetBlock: InevRange;
   {* �������� ������� ������ ��������� }
  procedure SetToStart;
   {* ���������� ��������� � ������ }
  function Unselect(const aView: InevView): Boolean;
   {* ����� ��������� }
  procedure SetToFinish(aMoveUpInLines: Integer);
 end;//IevRange
 
 TnevPointByPtMode = (
  {* ����� ��������� ����� �� ������ ������������. }
  nev_ppmNone
   {* ������� ���������. }
  , nev_ppmNeedAnchor
   {* ������������� ����� (��� ����� ������� ���������������� ������� �����). }
  , nev_ppmCheckHidden
   {* �������� ���������, �� ������������ ������ - ��� ������ ��������� ������ ������������ ������. }
  , nev_ppmSetCursor
   {* ��������� ����� ��� ��������� �������. ���� ������� ������-����������� ������������, �� �������� �������� Head-������. }
  , nev_ppmNeedAnchorWithSimpleBaseLine
   {* ��������� ����� � �� ��������� ������������������ ������� ������. }
 );//TnevPointByPtMode
 
 IevDocumentPoint = interface
  function Select(const Selection: InevSelection): Boolean;
   {* ���������� Selection �� ������ �����. }
 end;//IevDocumentPoint
 
 IevCommonControl = interface(InevPara)
  {* ������� ��������� ��� ���� �������-�������� ���������. }
 end;//IevCommonControl
 
 IevControl = interface(IevCommonControl)
  {* ������� �����. }
 end;//IevControl
 
 InevLeafPara = interface(InevPara)
  {* ������� ��� ������ � ����� ��� � ��������� ����������. }
 end;//InevLeafPara
 
 InevTextPara = interface(InevLeafPara)
  {* ������� ��� ������ � ����� ��� � ��������� ����������. }
 end;//InevTextPara
 
 InevTable = interface(InevParaList)
  {* ���������� ��� ������ � ��������. }
  procedure AddRow(aColCount: Integer;
   aColumnWidth: Integer;
   aFramed: Boolean);
   {* ��������� � ������� ������ � ��������� ���������� ������ aColumnWidth. 
         ���� aFramed ���������, �� ��� ������ ������ ����������� �����. }
 end;//InevTable
 
 InevTableRow = interface(InevParaList)
  function FindCell(aStart: Integer;
   aWidth: Integer;
   aRight: Boolean): TnevParaIndex;
   {* �������� ����� ������ �� �������� � �� ������. }
 end;//InevTableRow
 
 TnevFindCell = (
  {* <?> �������, ��� ���? }
  fc_Up
  , fc_Down
  , fc_DownInternal
 );//TnevFindCell
 
 InevTableCell = interface(InevParaList)
  {* ���������� ��� ������ � ��������. }
  function GetMergeHead(anIgnoreMergeStatus: Boolean): InevTableCell;
   {* ���������� ������ ������ � �����������. }
  function GetContinueCell(aNeedValidate: Boolean;
   aWhereFind: TnevFindCell): InevTableCell;
   {* ���������� ������ ������ �����������, ���� ����� ����������. }
  function GetContinueCellInRow(const aRow: InevPara;
   aWhereFind: TnevFindCell): InevTableCell;
  function GetHeadCellPara(anIgnoreMergeStatus: Boolean): InevPara;
  function GetContinueCellPara(aNeedValidate: Boolean;
   aWhereFind: TnevFindCell): InevPara;
  function CheckCellWidth(aValue: Integer;
   aOuterWidth: Integer): Integer;
  function IsEmptyCell: Boolean;
  function GetUpperCell: InevPara;
   {* ���������� ������ ������. }
 end;//InevTableCell
 
 (*
 Paragraphs = interface
  {* "�����" � ����������� }
 end;//Paragraphs
 *)
 
 InevPrintView = interface(InevView)
  {* ������� ������. }
 end;//InevPrintView
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
