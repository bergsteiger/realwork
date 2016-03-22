unit nevTools;
 {* �������� ������������ ��� ������ � ������ �� ������ ��������� �������. }

// ������: "w:\common\components\gui\Garant\Everest\new\nevTools.pas"
// ���������: "Interfaces"
// ������� ������: "nevTools" MUID: (47C5207602D1)

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

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
 , afwInterfaces
 , evdTypes
 , l3PureMixIns
 , Messages
;

type
 InevBase = nevBase.InevBase;

 PInevObject = ^InevObject;

 InevViewControl = interface(InevBase)
  {* ������� ��� ���������� View. }
  ['{C670983A-A20D-4900-B747-EEAD76B7EAB1}']
  procedure Top;
  procedure Bottom;
  procedure PageUp;
  function PageDown: Boolean;
  procedure LineUp(aCount: Integer);
  procedure LineDown(aCount: Integer);
 end;//InevViewControl

 InevCaret = interface(InevViewControl)
  {* �������. }
  ['{C8808A38-35D6-4670-9F95-39A8C4957631}']
  procedure Home;
  procedure EndLine;
 end;//InevCaret

 InevScroller = interface(InevViewControl)
  {* ��������. }
  ['{A454B916-A78D-48D5-A3DD-50EEE95DAB10}']
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
  public
   rStart: Integer;
   rFinish: Integer;
  public
   procedure Dec(aCount: Integer);
   function Len: Integer;
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
  function pm_GetBorders: TevPair;
  property Borders: TevPair
   read pm_GetBorders;
 end;//MnevBordersHolder
 *)

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

 InevObject = interface;

 InevObjectModify = interface(InevBase)
  ['{BF4E81B7-9E9C-44BD-83AA-0882AD0D4ABD}']
  function Delete(anInMerge: Boolean;
   const anOp: InevOp = nil): Boolean;
   {* ������� �������� aPara. }
 end;//InevObjectModify

 InevObject = interface(InevObjectPrim)
  {* ������������ ������ }
  ['{4AAC8247-CD7A-4E84-9F99-431462796030}']
  function pm_GetHolder: InevObjectHolder;
  function pm_GetIsEmpty: Boolean;
  function pm_GetAnchorID: Integer;
  function Range(const aStart: InevBasePoint = nil;
   const aFinish: InevBasePoint = nil;
   aSharp: Boolean = False): InevRange;
   {* ��������� �� ������ �������. }
  function SubRange(const aView: InevView;
   aStart: Integer;
   aFinish: Integer): InevRange;
   {* ���������� ��������� �� ������ ������� �� aStart �� aFinish. }
  function MakePoint(const aParent: InevBasePoint = nil): InevPoint;
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
  property Holder: InevObjectHolder
   read pm_GetHolder;
  property IsEmpty: Boolean
   read pm_GetIsEmpty;
  property AnchorID: Integer
   read pm_GetAnchorID;
 end;//InevObject

 InevDocumentContainer = interface;

 InevParaList = interface;

 InevSubList = interface;

 InevParaInternal = interface(InevPara)
  {* ��������, "��� ��� ��� �����". }
  ['{F6C01987-BE37-4FB9-8041-0040A532C5FA}']
  procedure SignalPID(aPID: TnevParaIndex);
 end;//InevParaInternal

 InevPara = interface(InevObject)
  {* ������� ��� ������ � ����� ��� � ����������. }
  ['{E2A7ABAE-A99E-4D58-9DCD-CE0F1EE643CB}']
  function pm_GetDocumentContainer: InevDocumentContainer;
  function pm_GetPrev: InevPara;
  function pm_GetNext: InevPara;
  function pm_GetMainSubList: InevSubList;
  function pm_GetBackColor: TnevColor;
  function OwnerTag: Tl3Variant;
   {* ������������ ��� ������� ���������. }
  function OwnerPara: InevParaList;
   {* ������������ �������� ������� ���������. }
  function AsList: InevParaList;
  function IsComment: Boolean;
  property DocumentContainer: InevDocumentContainer
   read pm_GetDocumentContainer;
  property Prev: InevPara
   read pm_GetPrev;
   {* ���������� ��������. }
  property Next: InevPara
   read pm_GetNext;
   {* ��������� ��������. }
  property MainSubList: InevSubList
   read pm_GetMainSubList;
  property BackColor: TnevColor
   read pm_GetBackColor;
 end;//InevPara

 IevMarker = interface;

 InevDataFormatting = interface;

 InevFontPrim = interface(InevBase)
  ['{512A518A-44FD-4581-A3EE-F3F01B754226}']
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

 InevDataFormattingModify = interface(InevBase)
  ['{0081105F-C33D-4ED2-8DFC-DF6D98B1C3E6}']
  function SetAtom(const aView: InevView;
   anIndex: Cardinal;
   aValue: Tl3Variant;
   const anOp: InevOp): Boolean;
  function ChangeParam(const aView: InevView;
   const aMarker: IevMarker;
   aValue: Integer;
   const anOp: InevOp = nil): Boolean;
  function DeleteHyperlink(const anOp: InevOp = nil): Boolean;
  function DeleteSegments(const anOp: InevOp = nil): Boolean;
   {* ������� ��������. }
  function AddIndentMarker(const aView: InevView;
   aValue: Integer;
   const anOpPack: InevOp = nil): Boolean;
  function DeleteIndentMarker(const aView: InevView;
   const anOpPack: InevOp = nil): Boolean;
 end;//InevDataFormattingModify

 InevDataFormatting = interface(InevBase)
  ['{5469167E-A7B9-46CE-8AEE-F7AD9EAEBF0A}']
  function GetFont(const aView: InevView;
   aMap: TnevFormatInfoPrim;
   Stop: PInteger = nil): InevFontPrim;
  function GetStyle(Stop: PInteger = nil): Tl3Variant;
  function Modify(const aView: InevView): InevDataFormattingModify;
 end;//InevDataFormatting

 InevLocation = interface;

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

 InevText = interface;

 InevTextModify = interface(InevBase)
  ['{A036DA41-6517-44BE-BE78-886A6881855D}']
  function InsertString(const aView: InevView;
   const aString: Il3CString;
   const anOp: InevOp = nil;
   InsertMode: Boolean = True;
   aFlags: TnevInsertStringFlags = []): Boolean;
   {* ��������� ������. }
  function InsertStream(const aView: InevView;
   const aStream: IStream;
   aFormat: TnevFormat;
   const anOp: InevOp = nil;
   aFlags: TevLoadFlags = nevBase.evDefaultLoadFlags;
   aCodePage: Integer = CP_DefaultValue): Boolean;
  function DeleteString(const aView: InevView;
   Count: Integer;
   const anOp: InevOp = nil;
   aFlags: TnevInsertStringFlags = []): Boolean;
   {* ������� ������. }
  function DeleteChar(const aView: InevView;
   aDrawLines: Boolean;
   const anOp: InevOp): Boolean;
  function InsertBreak(const aView: InevView;
   aDrawLines: Boolean = False;
   const anOp: InevOp = nil): Boolean;
  function DeleteCharToLeft(const aView: InevView;
   aDrawLines: Boolean = False;
   const anOp: InevOp = nil): Boolean;
  function Split(const aView: InevView;
   aFlags: TnevInsertStringFlags;
   const anOp: InevOp): Il3TagRef;
  function JoinWith(const aView: InevView;
   aSecondPara: Tl3Variant;
   const anOp: InevOp = nil;
   MoveSubs: Boolean = True): Integer;
  function JoinWithNext(const aView: InevView;
   const anOp: InevOp = nil): Boolean;
 end;//InevTextModify

 InevText = interface(InevBase)
  ['{E439B50A-FDBE-40A6-8598-49E9337300B2}']
  function CanBeDeleted: Boolean;
  function Modify: InevTextModify;
 end;//InevText

 (*
 MnevObjectPointer = interface
  {* "���������" �� ������ }
  function Get_Obj: PInevObject;
  property Obj: PInevObject
   read Get_Obj;
 end;//MnevObjectPointer
 *)

 InevLocation = interface(Il3TagRef)
  ['{891307A2-24D2-4B62-9AD9-5F2B20607B42}']
  function pm_GetFormatting: InevDataFormatting;
  function pm_GetText: InevText;
  function Get_Obj: PInevObject;
  function Range: InevRange;
  function AsPoint: InevBasePoint;
  property Formatting: InevDataFormatting
   read pm_GetFormatting;
  property Text: InevText
   read pm_GetText;
  property Obj: PInevObject
   read Get_Obj;
 end;//InevLocation

 InevRangePrim_Iterate_Action = function(const anItem: InevRange;
  anIndex: Integer): Boolean;
  {* ��� �������������� ������� ��� InevRangePrim.Iterate }

 InevRangePrim = interface(InevLocation)
  {* ���������� ����� �������. ��� �������� �������� �� ������ }
  ['{8336B718-F0A5-4D74-9CFE-DF549D39EE7E}']
  function Iterate(anAction: InevRangePrim_Iterate_Action;
   aStart: Integer = l3Types.l3MinIndex): Integer;
   {* �������� �� ��������� ���������� �������� }
  function IterateF(anAction: InevRangePrim_Iterate_Action;
   aStart: Integer = l3Types.l3MinIndex): Integer;
   {* �������� �� ��������� ���������� �������� }
 end;//InevRangePrim

 InevDataObjectPrim2 = interface;

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

 InevRangeModify = interface(InevBase)
  {* ���������� ����� ������� � ������������ ��������������. }
  ['{C4CF95F9-9EEC-45D9-A2BF-3D64E7E307A8}']
  function Delete(const aView: InevView;
   const anOp: InevOp = nil;
   aMode: TevClearMode = ev_cmAll;
   const aPara: InevPara = nil): Boolean;
 end;//InevRangeModify

 IevSearchTool = interface(InevBase)
  ['{4891B3E0-1A86-43D8-AAFF-9ACD4EEC6763}']
  function pm_GetText: AnsiString;
  function pm_GetOptions: TevSearchOptionSet;
  procedure pm_SetOptions(aValue: TevSearchOptionSet);
  procedure Start;
   {* ������ ������. }
  procedure Finish(aCancel: Boolean;
   const aBlock: InevRange);
   {* ����� ������. }
  property Text: AnsiString
   read pm_GetText;
  property Options: TevSearchOptionSet
   read pm_GetOptions
   write pm_SetOptions;
 end;//IevSearchTool

 IevSearcher = interface(IevSearchTool)
  {* ���������� ��� ����������� �������� ������ ��������� (��� ���������). }
  ['{3B556353-DF1A-4C9F-B98C-BF9F690AD4AE}']
  function Check(const aView: InevView;
   const aBlock: InevRange;
   out theStart: InevBasePoint;
   out theFinish: InevBasePoint;
   const PrevBlock: InevRange): Boolean;
   {* ���������� �������� ������ ��������� (��� ���������). }
 end;//IevSearcher

 InevConfirm = interface;

 IevReplacer = interface(IevSearchTool)
  ['{A74CC1CC-7541-45CB-9FBD-C8AF13682C84}']
  function Get_Searcher: IevSearcher;
  procedure Set_Searcher(const aValue: IevSearcher);
  function Get_ReplaceCount: Integer;
  function Replace(const Container: InevOp;
   const aBlock: InevRange;
   const aConfirm: InevConfirm): Boolean;
  function NeedProgress: Boolean;
  property Searcher: IevSearcher
   read Get_Searcher
   write Set_Searcher;
  property ReplaceCount: Integer
   read Get_ReplaceCount;
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

 InevConfirm = interface(InevBase)
  {* call-back ��������� ��� ��������� ������� �� ������. }
  ['{977F1258-3816-4BEA-89AD-64E2ADC7EC61}']
  function Get_View: InevView;
  function Get_Progress: InevProgress;
  function ReplaceConfirm(const aBlock: InevRange;
   AlienReplaceConfirm: TevReplaceConfirmEvent): ShortInt;
   {* ������ �� ������. ������������ �������� ��. TevReplaceConfirmEvent. }
  function DeleteFoundRgn: Boolean;
  procedure Update;
  property View: InevView
   read Get_View;
   {* ������� ������. }
  property Progress: InevProgress
   read Get_Progress;
 end;//InevConfirm

 (*
 MnevSearchReplace = interface
  function SearchReplace(const aSearcher: IevSearcher;
   const aReplacer: IevReplacer;
   const aConfirm: InevConfirm;
   const aCursor: InevBasePoint = nil;
   const anOpPack: InevOp = nil;
   aNeedProgress: Boolean = True): Boolean;
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
  ['{A2FAE91B-FB8C-4F84-B777-54DA8CDA5CCA}']
  procedure Init(const aStart: InevBasePoint;
   const aFinish: InevBasePoint;
   aSharp: Boolean = False);
 end;//InevRangeFactory

 IevTableRange = interface(InevBase)
  {* �������� ��������� � �������. }
  ['{894FD198-468B-4DD6-B091-C13AFA47A194}']
  function Get_Obj: PInevObject;
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
  property Obj: PInevObject
   read Get_Obj;
 end;//IevTableRange

 InevRange = interface(InevRangePrim)
  {* ���������� ����� �������. }
  ['{4D334B1F-B231-4ACD-84FF-CECB659AC201}']
  function pm_GetData: IevdDataObject;
  function pm_GetBorders: TevPair;
  function SolidBottomChildBlock(const aView: InevView): InevRange;
  function GetChildSel(const aView: InevView;
   aChildIndex: Integer;
   aForDrawing: Boolean): InevRange;
  procedure GetBorderPoints(out BS: InevBasePoint;
   out BF: InevBasePoint);
  function BottomChildBlock(const aView: InevView): InevRange;
  function CloneSel(const aView: InevView): InevRange;
  function Modify: InevRangeModify;
  function ParentRange(aLevel: Integer = 0): InevRange;
  function Contains(const aView: InevView;
   const aPoint: InevBasePoint): Boolean;
  procedure Select(const aView: InevView;
   const C: InevBasePoint;
   aTarget: TevSelectTarget;
   const Ctx: InevOp = nil); overload;
  procedure Select(const aView: InevView;
   const C: InevBasePoint;
   aOpen: Integer;
   aClose: Integer;
   const Ctx: InevOp = nil); overload;
  function Solid(const aView: InevView): Boolean;
  function ContainsEnd(const aView: InevView): Boolean;
  function Collapsed(const aView: InevView): Boolean;
  function AsStorable: InevDataObjectPrim2;
  procedure RefreshBorders;
   {* ��������� ������� �����. http://mdp.garant.ru/pages/viewpage.action?pageId=409750147 }
  function SearchReplace(const aSearcher: IevSearcher;
   const aReplacer: IevReplacer;
   const aConfirm: InevConfirm;
   const aCursor: InevBasePoint = nil;
   const anOpPack: InevOp = nil;
   aNeedProgress: Boolean = True): Boolean;
   {* ������� ������/������. ���������� - ���� �� ������ ������. }
  function Search(const aView: InevView;
   const aSearcher: IevSearcher;
   const Progress: Il3Progress;
   const aStart: InevBasePoint;
   out cFStart: InevBasePoint;
   out cFFinish: InevBasePoint): Boolean;
   {* ���� � ��������� �������� �nSearch
             � ���������� ������ � ����� ���������� ��������� � (cFStart, cFFinish). }
  property Data: IevdDataObject
   read pm_GetData;
  property Borders: TevPair
   read pm_GetBorders;
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

 IevMarker = interface(InevBase)
  {* ������ ����������� ��������� ������� (������, ������� � �.�.). }
  ['{8F6CAD3C-4EA7-4C5A-8205-F13B50516694}']
  function pm_GetValue: Integer;
  function pm_GetClientValue: Integer;
  function pm_GetLevel: Integer;
  function pm_GetPara: InevPara;
  function Get_TagIndex: Integer;
  function Get_Acc: Integer;
  function Get_Style: TevParaMarkerStyle;
  function Get_Hint: Il3CString;
  function Get_View: InevView;
  procedure Set_View(const aValue: InevView);
  function MakeCopy(const aTagWrap: InevPara): IevMarker;
   {* ������ ����� ������� ��� aTagWrap. }
  procedure SetValue(Value: Integer;
   const Context: InevOp);
   {* ���������� ����� �������� ���������. }
  function CompareLevel(aTagWrap: Tl3Variant): Integer;
   {* �������� ������� ����������� ������� � ����. }
  function Compare(const aMarker: IevMarker): Integer;
   {* ���������� �������. }
  property Value: Integer
   read pm_GetValue;
   {* �������� ���������, ������������ ����� ������� ������. }
  property ClientValue: Integer
   read pm_GetClientValue;
   {* �������� ���������, ������������ ����� ������� �������. }
  property Level: Integer
   read pm_GetLevel;
   {* ������� ����������� �������. }
  property Para: InevPara
   read pm_GetPara;
   {* ������ ��� �������� �������� ������ ������. }
  property TagIndex: Integer
   read Get_TagIndex;
  property Acc: Integer
   read Get_Acc;
  property Style: TevParaMarkerStyle
   read Get_Style;
  property Hint: Il3CString
   read Get_Hint;
  property View: InevView
   read Get_View
   write Set_View;
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

 InevControlView = interface;

 InevPointListener = interface(InevBase)
  {* ������, ����������� ����������� �� ��������� �������. }
  ['{0EED36AA-2313-405B-B10C-0A9CF236DBB0}']
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

 IevCursorContext = interface(InevBase)
  {* ������ ��� ������ ��������� �������. }
  ['{9B8CC350-C3FE-455C-B3CB-8753EC2D136C}']
  procedure RecordCursor(const aCursor: InevBasePoint);
   {* ������ ������ �������. }
  procedure StopRecord;
   {* ��������� ������ ��������. }
 end;//IevCursorContext

 (*
 MnevPointModify = interface
  procedure Set_PositionW(aValue: TnevPosition);
  function DoMove(const aView: InevView;
   aCode: Integer;
   const anOp: InevOp;
   aCount: Integer): TnevMoveResult;
  function Move(const aView: InevView;
   aCode: Cardinal;
   const anOp: InevOp = nil;
   aCount: Integer = 1): Boolean;
  procedure Refresh;
  procedure SetEntryPointPrim(Value: Integer;
   const Context: IevCursorContext = nil);
  procedure SetEntryPoint(Value: Integer;
   const Context: IevCursorContext = nil); overload;
  procedure SetEntryPoint(aValue: Integer;
   const aContext: InevOp); overload;
  function ToBottomChild(const aView: InevView): InevBasePoint;
  procedure SetAtEnd(const aView: InevView;
   aValue: Boolean);
  procedure SetAtStart(const aView: InevView;
   aValue: Boolean);
  property PositionW: TnevPosition
   write Set_PositionW;
   {* �������. }
 end;//MnevPointModify
 *)

{$If Defined(evNeedMarkers)}
 IevMarkersSource = interface;

 //_ItemType_ = IevMarker;
 IevROMarkersList = interface(InevBase)
  ['{14427E27-7A02-4F6D-A4A0-992BA73B980C}']
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: IevMarker;
  function pm_GetLast: IevMarker;
  function pm_GetItems(anIndex: Integer): IevMarker;
  function pm_GetCount: Integer;
  property Empty: Boolean
   read pm_GetEmpty;
  property First: IevMarker
   read pm_GetFirst;
   {* ������ �������. }
  property Last: IevMarker
   read pm_GetLast;
   {* ��������� �������. }
  property Items[anIndex: Integer]: IevMarker
   read pm_GetItems;
   default;
  property Count: Integer
   read pm_GetCount;
   {* ����� ���������. }
 end;//IevROMarkersList

 IevMarkersList = interface(IevROMarkersList)
  ['{76D9BD7F-98F1-4DEC-B264-A0C609F49574}']
  function Add(const anItem: IevMarker): Integer;
 end;//IevMarkersList

 IevMarkersSource = interface(InevBase)
  {* �������� ��������, � ��������� ��� ������ (��. TevRuler) }
  ['{99735A49-8C58-41FC-B064-FB6A7303E510}']
  procedure GetMarkers(const aView: InevView;
   const aList: IevMarkersList);
   {* �������� ������� �� ��������� � aList. }
 end;//IevMarkersSource
{$IfEnd} // Defined(evNeedMarkers)

 (*
 MnevPaintOffsetY = interface
  function PaintOffsetY(const aView: InevView;
   aMap: TnevFormatInfoPrim): Integer;
 end;//MnevPaintOffsetY
 *)

 InevLeafPoint = interface(InevBase)
  {* ��������� �����. }
  ['{D121CB92-237B-4D54-8B67-0EE705E55D18}']
  procedure InitPointByPt(const aView: InevView;
   const aPoint: TnevPoint;
   const aMap: InevMap);
  function PaintOffsetY(const aView: InevView;
   aMap: TnevFormatInfoPrim): Integer;
 end;//InevLeafPoint

 (*
 MnevParentPointFactory = interface
  {* ������������� �������� �� ������������ ������ }
  function pm_GetTopParentPoint: InevBasePoint;
  function PointToParent(const aThisTarget: InevObjectPrim = nil;
   aNeedShowCollapsed: Boolean = False): InevBasePoint;
  property TopParentPoint: InevBasePoint
   read pm_GetTopParentPoint;
 end;//MnevParentPointFactory
 *)

 (*
 MnevParentPointFactoryEx = interface
  function PointToParentByLevel(aLevel: Integer = 0): InevBasePoint;
  function PointToTypedParent(aParentType: Tk2Type): InevBasePoint;
 end;//MnevParentPointFactoryEx
 *)

 (*
 MnevOuter = interface
  procedure pm_SetOuter(const aValue: InevBasePoint);
  property Outer: InevBasePoint
   write pm_SetOuter;
 end;//MnevOuter
 *)

 (*
 MnevParentPoint = interface
  function pm_GetParentPoint: InevBasePoint;
  property ParentPoint: InevBasePoint
   read pm_GetParentPoint;
 end;//MnevParentPoint
 *)

 (*
 MnevMostInner = interface
  {* ����� ���������� ����� ������� }
  function pm_GetMostInner: InevBasePoint;
  property MostInner: InevBasePoint
   read pm_GetMostInner;
   {* �������� ����� ������ ������� ������. }
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

 InevBasePoint = interface(InevLocation)
  {* ������� ����� ������ ������� }
  ['{63E69D39-0C41-494B-8D3A-0C7D9F2C1B9E}']
  function pm_GetInner: InevBasePoint;
  procedure pm_SetInner(const aValue: InevBasePoint);
  function Get_Position: TnevPosition;
  function pm_GetAfterEnd: Boolean;
  function Get_ShowCollapsed: Boolean;
  procedure Set_ShowCollapsed(aValue: Boolean);
  function Get_Listener: InevPointListener;
  function pm_GetBeforeStart: Boolean;
  function Get_AsLeaf: InevLeafPoint;
  function Get_HasInner: Boolean;
  {$If Defined(evNeedMarkers)}
  function Get_MarkersSource: IevMarkersSource;
  {$IfEnd} // Defined(evNeedMarkers)
  procedure Set_PositionW(aValue: TnevPosition);
  function pm_GetTopParentPoint: InevBasePoint;
  procedure pm_SetOuter(const aValue: InevBasePoint);
  function pm_GetParentPoint: InevBasePoint;
  function pm_GetMostInner: InevBasePoint;
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
   anMaxID: Integer = -1);
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
   const anOp: InevOp = nil;
   aCount: Integer = 1): Boolean;
  procedure Refresh;
  procedure SetEntryPointPrim(Value: Integer;
   const Context: IevCursorContext = nil);
  procedure SetEntryPoint(Value: Integer;
   const Context: IevCursorContext = nil); overload;
  procedure SetEntryPoint(aValue: Integer;
   const aContext: InevOp); overload;
  function ToBottomChild(const aView: InevView): InevBasePoint;
  procedure SetAtEnd(const aView: InevView;
   aValue: Boolean);
  procedure SetAtStart(const aView: InevView;
   aValue: Boolean);
  function PointToParent(const aThisTarget: InevObjectPrim = nil;
   aNeedShowCollapsed: Boolean = False): InevBasePoint;
  function PointToParentByLevel(aLevel: Integer = 0): InevBasePoint;
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
  property Inner: InevBasePoint
   read pm_GetInner
   write pm_SetInner;
   {* �������� "�����". ������������ ������� - ������ ��������� ������� }
  property Position: TnevPosition
   read Get_Position;
   {* �������. }
  property AfterEnd: Boolean
   read pm_GetAfterEnd;
  property ShowCollapsed: Boolean
   read Get_ShowCollapsed
   write Set_ShowCollapsed;
  property Listener: InevPointListener
   read Get_Listener;
  property BeforeStart: Boolean
   read pm_GetBeforeStart;
  property AsLeaf: InevLeafPoint
   read Get_AsLeaf;
  property HasInner: Boolean
   read Get_HasInner;
   {* ���� �� �������� ����� }
  {$If Defined(evNeedMarkers)}
  property MarkersSource: IevMarkersSource
   read Get_MarkersSource;
   {* �������� ���������� � "��������" (� ��������� ��� �������) }
  {$IfEnd} // Defined(evNeedMarkers)
  property PositionW: TnevPosition
   write Set_PositionW;
   {* �������. }
  property TopParentPoint: InevBasePoint
   read pm_GetTopParentPoint;
  property Outer: InevBasePoint
   write pm_SetOuter;
  property ParentPoint: InevBasePoint
   read pm_GetParentPoint;
  property MostInner: InevBasePoint
   read pm_GetMostInner;
   {* �������� ����� ������ ������� ������. }
 end;//InevBasePoint

 InevBaseLine4Anchor = interface(InevBasePoint)
  ['{F666D14F-9EB6-4440-BDE3-DCFDCBB14C89}']
 end;//InevBaseLine4Anchor

 InevBaseLine4Print = interface(InevBaseLine4Anchor)
  ['{E4F1D014-80CC-4E45-8C90-7E7D2A948144}']
 end;//InevBaseLine4Print

 TevDeleteParaFlag = (
  ev_dpfAtEnd
  , ev_dpfInternal
  , ev_dpfInMerge
  , ev_dpfForce
 );//TevDeleteParaFlag

 IevTagLine = interface(InevBase)
  {* "������" � ������� }
  ['{2F3E8CDD-14BA-479E-AF48-EF26883AA9C9}']
  function pm_GetLineEnd: Boolean;
  procedure pm_SetLineEnd(aValue: Boolean);
  function GetLine(aMap: TnevFormatInfoPrim): Integer;
  property LineEnd: Boolean
   read pm_GetLineEnd
   write pm_SetLineEnd;
 end;//IevTagLine

 IevOpInsertPara = interface(InevBase)
  ['{141FCA13-9FDD-453D-BBB2-5FC68440E607}']
  function DoIt(const anOpPack: InevOp;
   aPara: Tl3Variant;
   aFlags: TevInsertParaFlags = [ev_ipfAtEnd]): Boolean;
 end;//IevOpInsertPara

 TevDeleteParaFlags = set of TevDeleteParaFlag;

 IevSavedCursor = interface(InevBase)
  ['{98BEB493-9509-4DE6-A88B-FEF33D4ACEC6}']
  procedure Store(const Cursor: InevBasePoint);
  procedure Load(const Cursor: InevBasePoint);
  function Clone: IevSavedCursor;
 end;//IevSavedCursor

 InevLinkedPoint = interface(InevPoint)
  {* �����, ����������� � �������� }
  ['{6EBFDA70-5EBE-4267-B18D-E830F89248D7}']
  procedure LinkListener(const aListener: InevPointListener);
  procedure UnlinkListener(const aListener: InevPointListener);
 end;//InevLinkedPoint

 IevOpDeletePara = interface(InevBase)
  ['{1F0E1129-B3F4-40B0-9AD0-6B99C3992A4A}']
  function DoIt(const anOpPack: InevOp;
   aFlags: TevDeleteParaFlags = [ev_dpfAtEnd]): Boolean;
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

 IevDrawLineTool = interface(InevBase)
  {* ���������� ��� ��������� ����� }
  ['{0C576196-940D-4C09-AFFA-4464EE107AC6}']
  function DrawLine(const aView: InevView;
   aDirection: TevLineDirection;
   aStyle: TevLineStyle;
   const anOp: InevOp): Boolean;
   {* ���������� ����� � ����������� aDirection }
 end;//IevDrawLineTool

 InevPoint = interface(InevBaseLine4Print)
  ['{74253463-3477-483F-8574-0FE8507CB40F}']
  function Get_LinkedPoint: InevLinkedPoint;
  property LinkedPoint: InevLinkedPoint
   read Get_LinkedPoint;
 end;//InevPoint

 InevAnchor = interface(InevBaseLine4Anchor)
  {* ����� �� ����� ������ ������� }
  ['{18A7EA2D-4A5A-467F-A5F3-210A41C166E2}']
  function LinkListener(const aView: InevScrollListener): InevScrollListener;
  procedure UnlinkListener(const aControl: InevScrollListener);
 end;//InevAnchor

 InevMap = interface(InevShapePrim)
  ['{347CA194-1AD6-458B-B9B3-C14B512B8F92}']
  function Get_FI: TInevFormatInfoRet;
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
  property FI: TInevFormatInfoRet
   read Get_FI;
   {* ���������� � �������������� }
 end;//InevMap

 (*
 ShapeView = interface
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
 end;//ShapeView
 *)

 InevSimpleView = interface(InevBase)
  {* ����� ����������� ������� � ����������� ���������� �������������� �����������. }
  ['{BD62976A-2EC4-46F7-9165-AFDC20FF478D}']
  procedure InvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
 end;//InevSimpleView

 InevActiveElement = interface;

 (*
 ActiveElementHolder = interface
  {* ������ ��������� �������� ��������� ���������� }
  function Get_ActiveElement: InevActiveElement;
  function Get_ForceDrawFocusRect: Boolean;
  property ActiveElement: InevActiveElement
   read Get_ActiveElement;
   {* �������� ������� (��� � ������� ��������� ����) }
  property ForceDrawFocusRect: Boolean
   read Get_ForceDrawFocusRect;
   {* ����������� �� ��������� ����� � �������� ��������� ��������� }
 end;//ActiveElementHolder
 *)

 InevK235870994Hacker = interface(InevBase)
  {* [RequestLink:235870994] }
  ['{BAF87764-C80A-41F4-A137-9368A5322EE0}']
  function HackK235870994(const aMap: InevMap): Boolean;
 end;//InevK235870994Hacker

 InevMeasureView = interface(InevBase)
  {* "������� ������" ��� ��������� }
  ['{C38B39DE-DC8C-4D14-99B2-E7C414E9FC67}']
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
  ['{9F3045A5-6683-48E6-80B9-F6521876F750}']
  function pm_GetMetrics: InevViewMetrics;
  function Get_IsObjectCollapsed(const anObject: InevObject): Boolean;
  procedure Set_IsObjectCollapsed(const anObject: InevObject;
   aValue: Boolean);
  function Get_ActiveElement: InevActiveElement;
  function Get_ForceDrawFocusRect: Boolean;
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
   aCheckTopVisible: Boolean = False): InevMap;
  function FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
  function RootFormatInfo: TnevFormatInfoPrim;
  {$If Defined(evNeedCollapsedVersionComments)}
  procedure VersionInfoVisabilityChanged(aValue: Boolean);
  {$IfEnd} // Defined(evNeedCollapsedVersionComments)
  function FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim; overload;
  function FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
  function FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim; overload;
  property Metrics: InevViewMetrics
   read pm_GetMetrics;
  property IsObjectCollapsed[const anObject: InevObject]: Boolean
   read Get_IsObjectCollapsed
   write Set_IsObjectCollapsed;
  property ActiveElement: InevActiveElement
   read Get_ActiveElement;
   {* �������� ������� (��� � ������� ��������� ����) }
  property ForceDrawFocusRect: Boolean
   read Get_ForceDrawFocusRect;
   {* ����������� �� ��������� ����� � �������� ��������� ��������� }
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
  ['{F4E1C0A0-32A2-4DD2-9293-90F232269C8E}']
  procedure Invalidate;
   {* �������� �������� � ������������� �����������, �����-������ � �������. }
  procedure Update;
   {* �������� �������� � ������������� �����������, � ������ ������. }
  procedure Changed(aPlace: TnevChangePlace);
   {* ������ ��� ����������� ���������� }
 end;//InevViewArea

 InevInputView = interface;

 InevControl = interface;

 InevSelection = interface(InevBase)
  ['{C60B4B17-7703-4957-B485-4F7B28AD7686}']
  function pm_GetPoint: InevLinkedPoint;
  function pm_GetIsMulti: Boolean;
  function pm_GetView: InevView;
  function Select(const aSource: InevRange;
   AllowAddToMulti: Boolean): Boolean;
   {* ����������� ���� ��������� �������. }
  procedure SelectPt(const Value: TnevPoint;
   aNeedUpdate: Boolean);
   {* ������������� ������� ��������� (� ������� �����������). }
  function SelectPoint(const aPoint: InevBasePoint;
   aNeedSetTop: Boolean;
   aNeedShowCaret: Boolean = True;
   aDiff: Integer = 0): Boolean;
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
  property Point: InevLinkedPoint
   read pm_GetPoint;
  property IsMulti: Boolean
   read pm_GetIsMulti;
  property View: InevView
   read pm_GetView;
 end;//InevSelection

 InevControl = interface(IafwControl)
  {* ������� ������. }
  ['{B2ACE973-76B8-4969-9BBB-82E62EE15E23}']
  function pm_GetData: InevObject;
  function Get_Processor: InevProcessor;
  function pm_GetWindowExtent: TnevSPoint;
  function pm_GetMetrics: InevViewMetrics;
  function pm_GetDrawCanvas: InevCanvas;
  function pm_GetMousePos: TnevPoint;
  function pm_GetSelection: InevSelection;
  function pm_GetCommandProcessor: InevCommandProcessor;
  function pm_GetLMargin: Integer;
  function pm_GetAllowMultiSelect: Boolean;
  function pm_GetViewArea: InevViewArea;
  function pm_GetView: InevInputView;
  function Get_ActiveElement: InevActiveElement;
  function Get_ForceDrawFocusRect: Boolean;
  procedure InvalidateRect(const aRect: TnevRect);
   {* �������� �������� � ������������� ����������� ���������� ��������������, �����-������ � �������. }
  procedure SignalScroll(aDeltaY: Integer;
   aNeedVert: Boolean);
   {* �������� ��������, � ���, ��� ���������� ������� ���������. }
  function GetDelphiControl: TComponent;
  function CloseQuery: Boolean;
   {* ���������� �������, � ����������� �������� ����, �������� �� �����������. }
  function LP2DP(const aPoint: TnevPoint;
   toScreen: Boolean = False): TPoint;
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
  property Data: InevObject
   read pm_GetData;
  property Processor: InevProcessor
   read Get_Processor;
   {* ��������� ��������. }
  property WindowExtent: TnevSPoint
   read pm_GetWindowExtent;
   {* ������� ���� � ������. }
  property Metrics: InevViewMetrics
   read pm_GetMetrics;
   {* ������� �����������. }
  property DrawCanvas: InevCanvas
   read pm_GetDrawCanvas;
   {* ����� ��� ������. }
  property MousePos: TnevPoint
   read pm_GetMousePos;
   {* ������� ����. }
  property Selection: InevSelection
   read pm_GetSelection;
   {* ���������. }
  property CommandProcessor: InevCommandProcessor
   read pm_GetCommandProcessor;
  property LMargin: Integer
   read pm_GetLMargin;
  property AllowMultiSelect: Boolean
   read pm_GetAllowMultiSelect;
  property ViewArea: InevViewArea
   read pm_GetViewArea;
  property View: InevInputView
   read pm_GetView;
  property ActiveElement: InevActiveElement
   read Get_ActiveElement;
   {* �������� ������� (��� � ������� ��������� ����) }
  property ForceDrawFocusRect: Boolean
   read Get_ForceDrawFocusRect;
   {* ����������� �� ��������� ����� � �������� ��������� ��������� }
 end;//InevControl

 InevControlView = interface(InevView)
  {* ����� ����������� �������, ����������� � �������� ������. }
  ['{89F01116-BEBB-4527-872B-757B1E3D2108}']
  function pm_GetControl: InevControl;
  function PointByPt(const aPt: TnevPoint;
   aForSetCursor: Boolean = False): InevBasePoint;
   {* ���������� ������ ����������� �� ������ �����, � ������� ��������� View. }
  property Control: InevControl
   read pm_GetControl;
   {* �������, � ������� ������������ ������. }
 end;//InevControlView

 InevLinkedView = interface(InevControlView)
  {* ����� ����������� �������, ����������� � �������� ������. }
  ['{F707633E-77EE-42A6-A521-176A7FB3DE47}']
  procedure UnlinkControl(const aControl: InevControl);
   {* ����������� ������� �� ������� ������. }
 end;//InevLinkedView

 InevDrawView = interface(InevLinkedView)
  ['{882A899E-69B3-4D6A-A44E-B3D2DAF43C13}']
  function pm_GetTopAnchor: InevAnchor;
  function IsDocumentTailVisible: Boolean;
  function Draw(const aBlock: InevRange;
   var theMap: InevMap): Boolean;
  function BottomAnchor(aSimple: Boolean): InevAnchor;
  property TopAnchor: InevAnchor
   read pm_GetTopAnchor;
 end;//InevDrawView

 InevScrollView = interface(InevDrawView)
  {* View � ������������ ��������������. }
  ['{C387A788-4B88-4D95-8266-FC6576DFF87B}']
  function pm_GetScroller(aVert: Boolean): InevScroller;
  property Scroller[aVert: Boolean]: InevScroller
   read pm_GetScroller;
 end;//InevScrollView

 InevSelectionView = interface(InevScrollView)
  {* View � ������������ ��������� ��������. }
  ['{5CDC8815-821D-458E-8E67-BFC7F6F137A2}']
  function pm_GetMousePos: TnevPoint;
  function pm_GetAllowMultiSelect: Boolean;
  function MakePointVisible(const aPoint: InevBasePoint): Boolean;
  procedure MakePairVisible(const aStart: InevBasePoint;
   const aFinish: InevBasePoint);
  property MousePos: TnevPoint
   read pm_GetMousePos;
  property AllowMultiSelect: Boolean
   read pm_GetAllowMultiSelect;
 end;//InevSelectionView

 InevInputView = interface(InevSelectionView)
  {* View � ������������ �����. }
  ['{82E2BD0E-59B1-4F6B-AC72-CD550D2ED11B}']
  function pm_GetCaret: InevCaret;
  function InMakeCaretVisible: Boolean;
  procedure MakeCaretVisible;
  function IsCaretVisible: Boolean;
  procedure ClearPointToShow;
   {* �������� �������������� ������� ��� �������� }
  property Caret: InevCaret
   read pm_GetCaret;
 end;//InevInputView

 InevStorable = interface(InevBase)
  ['{539DB483-87BC-4C78-AEF6-D38B0D3D2FE5}']
  procedure Store(const aView: InevView;
   const G: InevTagGenerator;
   aFlags: TevdStoreFlags = evdInterfaces.evDefaultStoreFlags); overload;
   {* ��������� ��������� � G. }
 end;//InevStorable

 InevDataObjectPrim2 = interface(InevStorable)
  ['{86EF5CF2-F467-4259-8FFB-BCA92022B07C}']
  function pm_GetBorders: TevPair;
  property Borders: TevPair
   read pm_GetBorders;
 end;//InevDataObjectPrim2

 InevObjectList = interface(InevObject)
  ['{5DABA26C-12F4-4602-8A6A-907CDB1FA326}']
  function pm_GetCount: TnevParaIndex;
  function pm_GetLeafShapeCount: Integer;
  function pm_GetAlmostLinear: Boolean;
  function pm_GetObj(anIndex: TnevParaIndex): InevObject;
  function IndexOfObj(const aPara: InevObject): TnevParaIndex;
  property Count: TnevParaIndex
   read pm_GetCount;
   {* ����� ���������. }
  property LeafShapeCount: Integer
   read pm_GetLeafShapeCount;
  property AlmostLinear: Boolean
   read pm_GetAlmostLinear;
   {* ������ ����� ��������? }
  property Obj[anIndex: TnevParaIndex]: InevObject
   read pm_GetObj;
   default;
 end;//InevObjectList

 IevSubCache = interface(InevBase)
  ['{A86D6C6C-F575-459F-BDAB-5922A833B47E}']
  procedure ClearSubs;
  procedure NotifySubDeleted(const aSub: IevSub);
 end;//IevSubCache

 IevSub = interface;

 (*
 MnevTextArea = interface
  {* ������� ������ }
  function pm_GetLock: Il3Lock;
  function Get_ViewArea: InevViewArea;
  function Get_SubCache: IevSubCache;
  property Lock: Il3Lock
   read pm_GetLock;
  property ViewArea: InevViewArea
   read Get_ViewArea;
  property SubCache: IevSubCache
   read Get_SubCache;
 end;//MnevTextArea
 *)

 IelEditStrings = interface(InevBase)
  {* ������ ���������. }
  ['{B2266B21-154E-434B-871E-EEDBC0A31A16}']
  procedure Set_ParagraphStrings(anIndex: Integer;
   const aValue: Il3CString);
  property ParagraphStrings[anIndex: Integer]: Il3CString
   write Set_ParagraphStrings;
 end;//IelEditStrings

 InevTagReader = interface(InevBase)
  ['{21E745BD-0E5F-4A65-953A-B27F28B4AF34}']
  function ReadTag(aFormat: TnevFormat;
   const aPool: IStream;
   const aFilters: InevTagGenerator;
   const Block: InevDataObjectPrim2 = nil;
   aFlags: TevdStoreFlags = evdInterfaces.evDefaultStoreFlags;
   aCodePage: Integer = CP_DefaultValue): Integer;
   {* ������� ��� �� Storage � aPool. }
  function ReadTagEx(const Writer: InevTagGenerator;
   const aPool: IStream = nil;
   const aBlock: InevDataObjectPrim2 = nil;
   aFlags: TevdStoreFlags = evdInterfaces.evDefaultStoreFlags;
   CharCountMul: Integer = 2;
   const FormatName: Il3CString = nil;
   aCodePage: Integer = CP_DefaultValue): Integer;
   {* �������� �������� � ������ (Pool) �� TextSource. }
 end;//InevTagReader

 InevTagWriter = interface(InevBase)
  ['{5EF8A98B-7399-4CD6-9D0A-A750A80360EE}']
  function WriteTag(const aView: InevView;
   aFormat: TnevFormat;
   const aPool: IStream;
   const aBlock: IUnknown = nil;
   aFlags: TevLoadFlags = nevBase.evDefaultLoadFlags;
   aCodePage: Integer = CP_DefaultValue): Boolean;
   {* �������� ��� �� Pool � Storage. }
  procedure WriteTagEx(const aView: InevView;
   const aReader: InevReader;
   const aBlock: IUnknown = nil;
   aFlags: TevLoadFlags = nevBase.evDefaultLoadFlags);
   {* �������� ��� �� Pool � Storage. }
 end;//InevTagWriter

 InevFormatPool = interface(InevBase)
  ['{D0FDB03B-534E-4664-9480-560A17BDD7C2}']
  function FormatInfoForView(const aView: InevView): TnevFormatInfoPrim;
  procedure ClearFormatInfoForView(const aView: InevView);
 end;//InevFormatPool

 InevSectionBreaks = interface(InevBase)
  ['{185183FA-42CE-41E3-BD10-E7E66D4484F6}']
  function GetSectionWidth(const aChild: InevObject;
   out theWidth: Integer): Boolean;
  function GetSectionBreak(const aChild: InevObject;
   out theBreak: InevObject): Boolean;
   {* ���������� ������ ������� ��� ���������� ��������� �������� }
 end;//InevSectionBreaks

 InevObjectHolder = interface(InevObjectHolderPrim)
  ['{982A0AB5-FD32-4017-BBD5-0091B90D5672}']
  function pm_GetObj: InevObject;
  function Get_Modified: Boolean;
  procedure Set_Modified(aValue: Boolean);
  function Get_FormatPool: InevFormatPool;
  function Get_SectionBreaks: InevSectionBreaks;
  function pm_GetLock: Il3Lock;
  function Get_ViewArea: InevViewArea;
  function Get_SubCache: IevSubCache;
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
  property Obj: InevObject
   read pm_GetObj;
  property Modified: Boolean
   read Get_Modified
   write Set_Modified;
  property FormatPool: InevFormatPool
   read Get_FormatPool;
  property SectionBreaks: InevSectionBreaks
   read Get_SectionBreaks;
  property Lock: Il3Lock
   read pm_GetLock;
  property ViewArea: InevViewArea
   read Get_ViewArea;
  property SubCache: IevSubCache
   read Get_SubCache;
 end;//InevObjectHolder

 IevSelectionPairs = interface(InevBase)
  ['{A16E77C2-DD14-4977-9A08-FCF89A2CD988}']
  function pm_GetPairsCount: Integer;
  function pm_GetPair(anIndex: Integer): TevPair;
  property PairsCount: Integer
   read pm_GetPairsCount;
  property Pair[anIndex: Integer]: TevPair
   read pm_GetPair;
 end;//IevSelectionPairs

 IevTreeDataObject = interface(InevBase)
  ['{D90CA287-AC26-4C87-9E19-DBF99B9E0083}']
  procedure Store(const G: InevTagGenerator;
   aLevelTag: Integer;
   aIndent: Integer);
   {* ��������� ���� ������ � G }
 end;//IevTreeDataObject

 InevTextSource = interface;

 IevDocument = interface;

 IevDocumentPreviewInfo = interface(InevBase)
  ['{EC69D517-A0E6-4DC8-8635-C24364D70DDE}']
  function pm_GetHAFMacroReplacer: IafwHAFMacroReplacer;
  function Get_Preview: IafwDocumentPreview;
  function Get_CacheKey: TevPreviewCacheKey;
  property HAFMacroReplacer: IafwHAFMacroReplacer
   read pm_GetHAFMacroReplacer;
  property Preview: IafwDocumentPreview
   read Get_Preview;
  property CacheKey: TevPreviewCacheKey
   read Get_CacheKey;
 end;//IevDocumentPreviewInfo

 InevDocumentLimits = interface(InevBase)
  {* ����������� ���������. }
  ['{A7EBD11A-5359-4B0A-9C50-6CF4870628B8}']
  function pm_GetBruttoCharLimit: Integer;
  procedure pm_SetBruttoCharLimit(aValue: Integer);
  function pm_GetTextParaLimit: Integer;
  procedure pm_SetTextParaLimit(aValue: Integer);
  property BruttoCharLimit: Integer
   read pm_GetBruttoCharLimit
   write pm_SetBruttoCharLimit;
   {* ����������� �� ���������� ��������� ��������. }
  property TextParaLimit: Integer
   read pm_GetTextParaLimit
   write pm_SetTextParaLimit;
 end;//InevDocumentLimits

 InevDocumentInfo = interface(InevBase)
  {* ���������� � ���������. }
  ['{15D4C55E-0D79-4E43-B5D6-B8D8EF3D2DA8}']
  function pm_GetTextParaCount: Integer;
  function pm_GetBruttoCharCount: Integer;
  function pm_GetNettoCharCount: Integer;
  function pm_GetBitmapParaCount: Integer;
  procedure ClearStat;
  property TextParaCount: Integer
   read pm_GetTextParaCount;
  property BruttoCharCount: Integer
   read pm_GetBruttoCharCount;
  property NettoCharCount: Integer
   read pm_GetNettoCharCount;
  property BitmapParaCount: Integer
   read pm_GetBitmapParaCount;
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

 InevSubChangeListener = interface(InevBase)
  ['{C6A21013-3F5C-4C56-AC55-20B3ED3F8B81}']
  procedure SubChanged(aSub: Tl3Variant;
   aChangeType: TevChangeType);
   {* ��� ��������/������. }
 end;//InevSubChangeListener

 InevCommentTextProvider = interface(InevBase)
  ['{56CC32EA-8375-4369-93C9-F35B17FD4AF4}']
  function GetCommentTextByParaID(aParaID: Integer): Il3CString;
  procedure DeleteCommentByParaID(aParaID: Integer);
 end;//InevCommentTextProvider

 InevWaiter = interface(InevBase)
  ['{D6E5040A-EE39-4090-8CAF-C0E69B9D9A78}']
  function TrySelect(const aContainer: InevDocumentContainer): Boolean;
  function TrySelectObj(const aContainer: InevDocumentContainer;
   aParent: Tl3Variant;
   aChild: Tl3Variant): Boolean;
 end;//InevWaiter

 InevDocumentContainer = interface(InevObjectHolder)
  {* ��������� ���������. ������ ��� ����� ��������� � �����������, View, � TextSource. }
  ['{EA4E99C5-8378-4447-A714-EC5D36CACEFD}']
  function pm_GetTextSource: InevTextSource;
  function Get_Processor: InevProcessor;
  function Get_Document: IevDocument;
  function pm_GetSubList: InevSubList;
  function pm_GetDocumentInfo: InevDocumentInfo;
  function pm_GetDocumentLimits: InevDocumentLimits;
  function pm_GetAbortedLoad: Boolean;
  procedure pm_SetAbortedLoad(aValue: Boolean);
  function pm_GetNeedProcessMessages: Boolean;
  procedure pm_SetNeedProcessMessages(aValue: Boolean);
  function pm_GetContentsTree: InevSimpleTree;
  function pm_GetExistingDocument: Tl3Variant;
  function pm_GetLoading: Boolean;
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
  {$If NOT Defined(Nemesis)}
  procedure GetSubFlagsIterator(aLayer: Integer);
  {$IfEnd} // NOT Defined(Nemesis)
  function Preview(const aKey: TevPreviewCacheKey;
   const aMacroReplacer: IafwHAFMacroReplacer;
   const aRange: InevRange = nil;
   TreatRangeAsSelection: Boolean = True): InevComplexDocumentPreview;
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
  property TextSource: InevTextSource
   read pm_GetTextSource;
  property Processor: InevProcessor
   read Get_Processor;
  property Document: IevDocument
   read Get_Document;
  property SubList: InevSubList
   read pm_GetSubList;
  property DocumentInfo: InevDocumentInfo
   read pm_GetDocumentInfo;
  property DocumentLimits: InevDocumentLimits
   read pm_GetDocumentLimits;
   {* ����������� ���������. }
  property AbortedLoad: Boolean
   read pm_GetAbortedLoad
   write pm_SetAbortedLoad;
   {* �������� ��������� ��������. }
  property NeedProcessMessages: Boolean
   read pm_GetNeedProcessMessages
   write pm_SetNeedProcessMessages;
  property ContentsTree: InevSimpleTree
   read pm_GetContentsTree;
  property ExistingDocument: Tl3Variant
   read pm_GetExistingDocument;
  property Loading: Boolean
   read pm_GetLoading;
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
  ['{91BD9D0C-D885-4505-96F4-3EAA93C13906}']
  function InsertPara(aPID: TnevParaIndex;
   aPara: Tl3Variant;
   const anOp: InevOp;
   aFlags: TevInsertParaFlags = [ev_ipfNeedFire]): Boolean;
   {* ��������� �������� � ��������� �������. }
  function InsertDefaultPara(aPID: TnevParaIndex;
   const anOp: InevOp;
   aNeedFire: Boolean = True): Boolean;
   {* ��������� �������� � ����� ��-��������� � ��������� �������. }
 end;//InevParaListModify

 //_ItemType_ = InevPara;
 InevParas = interface(InevBase)
  {* �������� ������� ������ ����������. �� �������� ��������� ��������� ���������. ������ ��� �������� �������� ��� ������ ����������. }
  ['{8B771FE5-C465-4085-AC7A-7C853E25DA47}']
  function pm_GetEmpty: Boolean;
  function pm_GetFirst: InevPara;
  function pm_GetLast: InevPara;
  function pm_GetItems(anIndex: Integer): InevPara;
  function pm_GetCount: Integer;
  property Empty: Boolean
   read pm_GetEmpty;
  property First: InevPara
   read pm_GetFirst;
   {* ������ �������. }
  property Last: InevPara
   read pm_GetLast;
   {* ��������� �������. }
  property Items[anIndex: Integer]: InevPara
   read pm_GetItems;
   default;
  property Count: Integer
   read pm_GetCount;
   {* ����� ���������. }
 end;//InevParas

 InevParaList_IteratePara_Action = function(const anItem: InevPara;
  anIndex: Integer): Boolean;
  {* ��� �������������� ������� ��� InevParaList.IteratePara }

 InevParaList = interface(InevPara)
  {* ������� ��� ������ � ����� ��� �� ������� ���������� ��� ����������� �����������. }
  ['{6A444D87-A786-41D4-BEA7-E27EE58D3294}']
  function pm_GetParaCount: TnevParaIndex;
  function pm_GetPara(anIndex: TnevParaIndex): InevPara;
  function IteratePara(anAction: InevParaList_IteratePara_Action;
   aLo: TnevParaIndex = nev_piFirst;
   aHi: TnevParaIndex = nev_piLast;
   aLoadedOnly: Boolean = False): Integer;
  function IterateParaF(anAction: InevParaList_IteratePara_Action;
   aLo: TnevParaIndex = nev_piFirst;
   aHi: TnevParaIndex = nev_piLast;
   aLoadedOnly: Boolean = False): Integer;
  function GetParas(aFrom: TnevParaIndex = nev_piFirst;
   aTo: TnevParaIndex = nev_piLast): InevParas;
   {* ���������� ������ ����������. }
  function Modify: InevParaListModify;
  property ParaCount: TnevParaIndex
   read pm_GetParaCount;
   {* ����� ����������. }
  property Para[anIndex: TnevParaIndex]: InevPara
   read pm_GetPara;
   default;
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

 IevDocumentPart = interface;

 InevSubList_Iterate_Action = function(const anItem: IevSub;
  anIndex: Integer): Boolean;
  {* ��� �������������� ������� ��� InevSubList.Iterate }

 InevSubList = interface(InevBase)
  {* ������ �����. }
  ['{99ECE5EC-842E-406F-8A71-0A437E228625}']
  function pm_GetSub(anID: Integer): IevSub;
  function pm_GetSubEx(anID: Integer;
   aLayerID: Integer): IevSub;
  function pm_GetNewSub: IevSub;
  function pm_GetNewSubEx(aLayerID: Integer): IevSub;
  function pm_GetBlock(anID: Integer): IevDocumentPart;
  function pm_GetBlockEx(anID: Integer;
   aLayerID: Integer): IevDocumentPart;
  function Iterate(anAction: InevSubList_Iterate_Action;
   const aBlock: IUnknown = nil;
   const aMessage: Il3CString = nil): Integer;
   {* ���������� ������ ����� }
  function IterateF(anAction: InevSubList_Iterate_Action;
   const aBlock: IUnknown = nil;
   const aMessage: Il3CString = nil): Integer;
   {* ���������� ������ ����� }
  property Sub[anID: Integer]: IevSub
   read pm_GetSub;
   {* ����� � ��������������� anID �� ���� ev_sbtSub. }
  property SubEx[anID: Integer; aLayerID: Integer]: IevSub
   read pm_GetSubEx;
   {* ����� � ��������������� anID �� ���� aLayerID. }
  property NewSub: IevSub
   read pm_GetNewSub;
   {* ����� � ����� ID �� ���� ev_sbtSub. }
  property NewSubEx[aLayerID: Integer]: IevSub
   read pm_GetNewSubEx;
   {* ����� � ����� ID �� ���� aLayerID. }
  property Block[anID: Integer]: IevDocumentPart
   read pm_GetBlock;
   {* ���� � �������������� anID. }
  property BlockEx[anID: Integer; aLayerID: Integer]: IevDocumentPart
   read pm_GetBlockEx;
   {* ���� � �������������� anID. }
 end;//InevSubList

 IevSub = interface(InevBase)
  {* ����� ����� (�����) }
  ['{BC644272-5936-43F8-9A3A-29A6CC1CBD25}']
  function pm_GetSubPlace: TevSubPlace;
  function pm_GetName: Tl3WString;
  procedure pm_SetName(const aValue: Tl3WString);
  function pm_GetID: Integer;
  procedure pm_SetID(aValue: Integer);
  function pm_GetLayerID: Integer;
  function pm_GetFlags: Integer;
  procedure pm_SetFlags(aValue: Integer);
  function pm_GetCursor: Tl3Tag;
  procedure pm_SetCursor(aValue: Tl3Tag);
  function pm_GetSubList: InevSubList;
  function pm_GetNext: IevSub;
  function pm_GetLeafPara: Tl3Variant;
  function pm_GetPara: Tl3Variant;
  function pm_GetDocument: IevDocument;
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
  property SubPlace: TevSubPlace
   read pm_GetSubPlace;
   {* �������� �� ���� � ����������. }
  property Name: Tl3WString
   read pm_GetName
   write pm_SetName;
   {* ��� �����. }
  property ID: Integer
   read pm_GetID
   write pm_SetID;
   {* ������������� �����. }
  property LayerID: Integer
   read pm_GetLayerID;
   {* ������������� ���� �� ������� ��������� �����. }
  property Flags: Integer
   read pm_GetFlags
   write pm_SetFlags;
   {* ����� ������� ������ �����. }
  property Cursor: Tl3Tag
   read pm_GetCursor
   write pm_SetCursor;
   {* ������ �� �����. }
  property SubList: InevSubList
   read pm_GetSubList;
   {* ������ �����. }
  property Next: IevSub
   read pm_GetNext;
   {* ��������� ����� ���������. }
  property LeafPara: Tl3Variant
   read pm_GetLeafPara;
   {* �������� ������� ������, �� ������� ��������� �����. }
  property Para: Tl3Variant
   read pm_GetPara;
   {* ��������, �� ������� ��������� �����. }
  property Document: IevDocument
   read pm_GetDocument;
 end;//IevSub

 InevTool = interface(InevBase)
  ['{D33A322B-1284-49A1-97F4-6BF02B5F9BE6}']
  function Get_Obj: InevObjectPrim;
  property Obj: InevObjectPrim
   read Get_Obj;
 end;//InevTool

 InevTextSource = interface(InevBase)
  {* �������� ���������. ������ ��� ����� ��������� � ����������� � View }
  ['{ACCBE7B0-C804-44D8-B845-24F7B6B20BB0}']
  function Get_Document: Tl3Variant;
  function pm_GetLock: Il3Lock;
  function Get_ViewArea: InevViewArea;
  function Get_SubCache: IevSubCache;
  function CastAnyEditorTo(const IID: TGUID;
   out theObj): Boolean;
  procedure DocumentChanged(anOldDocument: Tl3Variant;
   aNewDocument: Tl3Variant);
  procedure MakeCursor;
  {$If NOT Defined(Nemesis)}
  function GetSubFlags(aLayer: Integer;
   const aSubList: InevSubList): Boolean;
  {$IfEnd} // NOT Defined(Nemesis)
  function GetControlData(const aControl: IevControl): IUnknown;
   {* ���������� ������ ��� ��������. }
  function GetControlImg(const aControl: TnevControlInfo;
   out theImageInfo: TnevControlImageInfo): Boolean;
   {* ���������� �������� ��� ��������. }
  procedure PropChanged(Prop: Tk2Prop;
   const V: TnevValues;
   const anOpPack: InevOp);
  property Document: Tl3Variant
   read Get_Document;
  property Lock: Il3Lock
   read pm_GetLock;
  property ViewArea: InevViewArea
   read Get_ViewArea;
  property SubCache: IevSubCache
   read Get_SubCache;
 end;//InevTextSource

 TevContentsRec = object
  public
   rLevel6: Integer;
   rCompareContentsLevel: Integer;
 end;//TevContentsRec

 IevDocumentPart = interface(IevSub)
  {* ����������� ���� ���������. }
  ['{E10B1725-26E0-4063-9BDC-077CAC947FFB}']
  function pm_GetExternalHandle: Integer;
  procedure pm_SetExternalHandle(aValue: Integer);
  function pm_GetObjType: Integer;
  procedure pm_SetObjType(aValue: Integer);
  function pm_GetParaCount: Integer;
  function pm_GetParentDocumentPart: IevDocumentPart;
  function pm_GetContentsRec: TevContentsRec;
  procedure pm_SetContentsRec(const aValue: TevContentsRec);
  function Merge: Boolean;
   {* ���������� ���� �� ���������. }
  function GetViewKind: TevBlockViewKind;
  property ExternalHandle: Integer
   read pm_GetExternalHandle
   write pm_SetExternalHandle;
   {* ������� ������������� ����� (��� ���������� � RTF). }
  property ObjType: Integer
   read pm_GetObjType
   write pm_SetObjType;
   {* ��� �������� ������� ObjType. }
  property ParaCount: Integer
   read pm_GetParaCount;
   {* ����� ���������� � �����. }
  property ParentDocumentPart: IevDocumentPart
   read pm_GetParentDocumentPart;
   {* ������������ ����. }
  property ContentsRec: TevContentsRec
   read pm_GetContentsRec
   write pm_SetContentsRec;
   {* ������� ����� � ����������. }
 end;//IevDocumentPart

 IevDocument = interface(IevDocumentPart)
  {* ��������. }
  ['{017F34A6-D0D3-4893-B152-9EABD448B7F9}']
  function pm_GetComment: Tl3WString;
  procedure pm_SetComment(const aValue: Tl3WString);
  function pm_GetShortName: Tl3WString;
  procedure pm_SetShortName(const aValue: Tl3WString);
  function pm_GetParentDocument: IevDocument;
  property Comment: Tl3WString
   read pm_GetComment
   write pm_SetComment;
   {* ����������� � ���������. }
  property ShortName: Tl3WString
   read pm_GetShortName
   write pm_SetShortName;
   {* �������� �������� ���������. }
  property ParentDocument: IevDocument
   read pm_GetParentDocument;
   {* ������������ ��������. �� ����� nil ������ ��� ������������ ������ ����������� ����������. }
 end;//IevDocument

 InevActiveElement = interface(InevBase)
  {* �������� ������� ������ }
  ['{1D0DC30D-B9AE-4F4A-A573-3A26230750BA}']
  function Get_Para: InevPara;
  procedure Invalidate;
   {* �������������� ������� ��������� �������� }
  function IsSame(const anElement: InevActiveElement): Boolean;
  property Para: InevPara
   read Get_Para;
 end;//InevActiveElement

 HnevView = object
  {* ������ ��� InevView }
  private
   f_InevView: InevView;
    {* ������ �� ��������� InevView }
  private
   procedure Fake; virtual;
    {* ��� ����� ����� ��������� �������������� ������ ������� ������� � ��������� }
  protected
   function pm_GetMetrics: InevViewMetrics;
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
    aCheckTopVisible: Boolean = False): InevMap;
   function FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
   function RootFormatInfo: TnevFormatInfoPrim;
   function Get_ActiveElement: InevActiveElement;
   function Get_ForceDrawFocusRect: Boolean;
   function Get_IsObjectCollapsed(const anObject: InevObject): Boolean;
   procedure Set_IsObjectCollapsed(const anObject: InevObject;
    aValue: Boolean);
   {$If Defined(evNeedCollapsedVersionComments)}
   procedure VersionInfoVisabilityChanged(aValue: Boolean);
   {$IfEnd} // Defined(evNeedCollapsedVersionComments)
   function FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim; overload;
   function FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
   function FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim; overload;
  public
   procedure InvalidateShape(const aShape: InevObject;
    aParts: TnevShapeParts);
   constructor Init(const aInevView: InevView); reintroduce;
 end;//HnevView

 InevCommentSwitcher = interface(InevBase)
  ['{92726298-8202-4867-8725-C5EB2E04E6D4}']
  function pm_GetShowComments: Boolean;
  procedure pm_SetShowComments(aValue: Boolean);
  function pm_GetShowVersionComments: Boolean;
  procedure pm_SetShowVersionComments(aValue: Boolean);
  function pm_GetShowUserComments: Boolean;
  procedure pm_SetShowUserComments(aValue: Boolean);
  function pm_GetShowTechComments: Boolean;
  procedure pm_SetShowTechComments(aValue: Boolean);
  property ShowComments: Boolean
   read pm_GetShowComments
   write pm_SetShowComments;
  property ShowVersionComments: Boolean
   read pm_GetShowVersionComments
   write pm_SetShowVersionComments;
  property ShowUserComments: Boolean
   read pm_GetShowUserComments
   write pm_SetShowUserComments;
  property ShowTechComments: Boolean
   read pm_GetShowTechComments
   write pm_SetShowTechComments;
 end;//InevCommentSwitcher

 InevRestartPositionSource = interface(InevBase)
  {* �������� ������� ����������� searcher'� }
  ['{3EDEF949-499A-4E52-949B-CB4FDA47C344}']
  function Get_RestartPos: InevBasePoint;
  property RestartPos: InevBasePoint
   read Get_RestartPos;
 end;//InevRestartPositionSource

 InevDocumentProvider = interface(InevStorable)
  {* ��������� ��������� }
  ['{2C3A8DA6-E894-41C3-861F-7C463DD264A1}']
  function Get_CanProvideOriginalDocument: Boolean;
  function Get_PageSetup: IafwPageSetup;
  function Get_OriginalDocument: Tl3Variant;
  property CanProvideOriginalDocument: Boolean
   read Get_CanProvideOriginalDocument;
  property PageSetup: IafwPageSetup
   read Get_PageSetup;
   {* ��������� �������� }
  property OriginalDocument: Tl3Variant
   read Get_OriginalDocument;
 end;//InevDocumentProvider

 InevQueryDocumentContainer = interface;

 InevControlListener = interface(InevBase)
  ['{7109F8A9-71C1-4AB3-8721-D4FB9F64D311}']
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
  ['{AA1AF210-BE26-436B-A28B-4AA0EEC19265}']
  function Get_ModelNotify: InevControlListener;
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
  property ModelNotify: InevControlListener
   read Get_ModelNotify;
 end;//InevQueryDocumentContainer

 IevRange = interface(InevBase)
  {* ��������� }
  ['{747BE4D8-B003-4DA0-921F-34B02A85CA80}']
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

 IevDocumentPoint = interface(InevBase)
  ['{D6906A23-A8AB-4720-B0F6-019F8A7CB430}']
  function Get_Obj: PInevObject;
  function Select(const Selection: InevSelection): Boolean;
   {* ���������� Selection �� ������ �����. }
  property Obj: PInevObject
   read Get_Obj;
 end;//IevDocumentPoint

 IevCommonControl = interface(InevPara)
  {* ������� ��������� ��� ���� �������-�������� ���������. }
  ['{8A00A75A-55D8-45B8-823A-8DF8B309C016}']
  function Get_Enabled: Boolean;
  function Get_Checked: Boolean;
  procedure Set_Checked(aValue: Boolean);
  function Get_Flat: Boolean;
  function Get_Name: Tl3WString;
  function Get_Text: Tl3WString;
  function Get_ControlType: TevControlType;
  function Get_Upper: Boolean;
  procedure Set_Upper(aValue: Boolean);
  function pm_GetCollapsed: Boolean;
  procedure pm_SetCollapsed(aValue: Boolean);
  property Enabled: Boolean
   read Get_Enabled;
   {* ����������� �����. }
  property Checked: Boolean
   read Get_Checked
   write Set_Checked;
   {* ������ ������/��������. }
  property Flat: Boolean
   read Get_Flat;
   {* ����������� �����. <?> ��, ��� ���������� �����������? }
  property Name: Tl3WString
   read Get_Name;
   {* ��� ��������. }
  property Text: Tl3WString
   read Get_Text;
   {* ����� ��������. }
  property ControlType: TevControlType
   read Get_ControlType;
   {* ��� ��������. }
  property Upper: Boolean
   read Get_Upper
   write Set_Upper;
   {* ������ ��� �����. }
  property Collapsed: Boolean
   read pm_GetCollapsed
   write pm_SetCollapsed;
 end;//IevCommonControl

 IevControl = interface(IevCommonControl)
  {* ������� �����. }
  ['{55C067F5-F2F3-4A53-B333-B8DDD90DD2A3}']
 end;//IevControl

 InevLeafPara = interface(InevPara)
  {* ������� ��� ������ � ����� ��� � ��������� ����������. }
  ['{EC469898-FF75-43F9-86C7-0FE509548605}']
 end;//InevLeafPara

 InevTextPara = interface(InevLeafPara)
  {* ������� ��� ������ � ����� ��� � ��������� ����������. }
  ['{B759BCA3-F646-45E0-BB19-416C281F3AFE}']
  function pm_GetFormatting(aPosition: Integer): InevDataFormatting;
  property Formatting[aPosition: Integer]: InevDataFormatting
   read pm_GetFormatting;
 end;//InevTextPara

 InevTable = interface(InevParaList)
  {* ���������� ��� ������ � ��������. }
  ['{083A899B-A433-4E90-BA90-ECDFA12FBE0B}']
  procedure AddRow(aColCount: Integer;
   aColumnWidth: Integer;
   aFramed: Boolean);
   {* ��������� � ������� ������ � ��������� ���������� ������ aColumnWidth. 
         ���� aFramed ���������, �� ��� ������ ������ ����������� �����. }
 end;//InevTable

 InevTableRow = interface(InevParaList)
  ['{77D2AA90-36E4-4465-84FC-8F3E0F0A7FF3}']
  function FindCell(aStart: Integer;
   aWidth: Integer;
   aRight: Boolean = False): TnevParaIndex;
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
  ['{CBAA54FD-BFEA-428B-A154-50D9CBED69CF}']
  function GetMergeHead(anIgnoreMergeStatus: Boolean = False): InevTableCell;
   {* ���������� ������ ������ � �����������. }
  function GetContinueCell(aNeedValidate: Boolean;
   aWhereFind: TnevFindCell): InevTableCell;
   {* ���������� ������ ������ �����������, ���� ����� ����������. }
  function GetContinueCellInRow(const aRow: InevPara;
   aWhereFind: TnevFindCell): InevTableCell;
  function GetHeadCellPara(anIgnoreMergeStatus: Boolean = False): InevPara;
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
  ['{D7540AD6-9B63-4FB1-9389-E001FDED056B}']
 end;//InevPrintView

function TevPair_C(aStart: Integer;
 aFinish: Integer): TevPair;
function L2InevRangePrimIterateAction(anAction: pointer): InevRangePrim_Iterate_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� InevRangePrim.Iterate }
function L2InevParaListIterateParaAction(anAction: pointer): InevParaList_IteratePara_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� InevParaList.IteratePara }
function L2InevSubListIterateAction(anAction: pointer): InevSubList_Iterate_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� InevSubList.Iterate }
function TevContentsRec_C(aLevel6: Integer = MaxInt-1;
 aCompareContentsLevel: Integer = 0): TevContentsRec;
 {* ������� evContentsRec }

implementation

uses
 l3ImplUses
 , l3Base
;

function TevPair_C(aStart: Integer;
 aFinish: Integer): TevPair;
//#UC START# *49E60C23017A_47C68B3B022A_var*
//#UC END# *49E60C23017A_47C68B3B022A_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *49E60C23017A_47C68B3B022A_impl*
 Result.rStart := aStart;
 Result.rFinish := aFinish;
//#UC END# *49E60C23017A_47C68B3B022A_impl*
end;//TevPair_C

function L2InevRangePrimIterateAction(anAction: pointer): InevRangePrim_Iterate_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� InevRangePrim.Iterate }
asm
 jmp l3LocalStub
end;//L2InevRangePrimIterateAction

function L2InevParaListIterateParaAction(anAction: pointer): InevParaList_IteratePara_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� InevParaList.IteratePara }
asm
 jmp l3LocalStub
end;//L2InevParaListIterateParaAction

function L2InevSubListIterateAction(anAction: pointer): InevSubList_Iterate_Action;
 {* ������� ������������ �������� ��� ��������� �������������� ������� ��� InevSubList.Iterate }
asm
 jmp l3LocalStub
end;//L2InevSubListIterateAction

function TevContentsRec_C(aLevel6: Integer = MaxInt-1;
 aCompareContentsLevel: Integer = 0): TevContentsRec;
 {* ������� evContentsRec }
//#UC START# *4A25320D0116_47C6BCC6034E_var*
//#UC END# *4A25320D0116_47C6BCC6034E_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4A25320D0116_47C6BCC6034E_impl*
 Result.rLevel6 := aLevel6;
 Result.rCompareContentsLevel := aCompareContentsLevel;
//#UC END# *4A25320D0116_47C6BCC6034E_impl*
end;//TevContentsRec_C

procedure TevPair.Dec(aCount: Integer);
//#UC START# *47C68B5B03E1_47C68B3B022A_var*
//#UC END# *47C68B5B03E1_47C68B3B022A_var*
begin
//#UC START# *47C68B5B03E1_47C68B3B022A_impl*
 if (rStart >= aCount) then
  System.Dec(rStart, aCount)
 else
  rStart := 0;
 if (rFinish >= aCount) then
  System.Dec(rFinish, aCount)
 else
  rFinish := 0;
//#UC END# *47C68B5B03E1_47C68B3B022A_impl*
end;//TevPair.Dec

function TevPair.Len: Integer;
//#UC START# *47C68B6603AB_47C68B3B022A_var*
//#UC END# *47C68B6603AB_47C68B3B022A_var*
begin
//#UC START# *47C68B6603AB_47C68B3B022A_impl*
 Result := rFinish - rStart;
//#UC END# *47C68B6603AB_47C68B3B022A_impl*
end;//TevPair.Len

function HnevView.pm_GetMetrics: InevViewMetrics;
//#UC START# *47C5B99001C4_4A4B231403B6get_var*
//#UC END# *47C5B99001C4_4A4B231403B6get_var*
begin
//#UC START# *47C5B99001C4_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B99001C4_4A4B231403B6get_impl*
end;//HnevView.pm_GetMetrics

function HnevView.Data: InevObject;
//#UC START# *47C5B9A30018_4A4B231403B6_var*
//#UC END# *47C5B9A30018_4A4B231403B6_var*
begin
//#UC START# *47C5B9A30018_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9A30018_4A4B231403B6_impl*
end;//HnevView.Data

function HnevView.RootMap: InevMap;
//#UC START# *47C5B9AA03E1_4A4B231403B6_var*
//#UC END# *47C5B9AA03E1_4A4B231403B6_var*
begin
//#UC START# *47C5B9AA03E1_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9AA03E1_4A4B231403B6_impl*
end;//HnevView.RootMap

function HnevView.Processor: InevProcessor;
//#UC START# *47C5B9B202F0_4A4B231403B6_var*
//#UC END# *47C5B9B202F0_4A4B231403B6_var*
begin
//#UC START# *47C5B9B202F0_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9B202F0_4A4B231403B6_impl*
end;//HnevView.Processor

procedure HnevView.ClearShapes;
//#UC START# *47C5B9C301B9_4A4B231403B6_var*
//#UC END# *47C5B9C301B9_4A4B231403B6_var*
begin
//#UC START# *47C5B9C301B9_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9C301B9_4A4B231403B6_impl*
end;//HnevView.ClearShapes

procedure HnevView.BeginDrawShape(const aShape: InevObject;
 const anAnchor: InevBasePoint;
 const anOrg: TnevPoint;
 var theMap: InevMap;
 aFake: Boolean;
 const aHacker: InevK235870994Hacker);
 {* �������� ���������� ����� � ������. }
//#UC START# *47C5B9DB0136_4A4B231403B6_var*
//#UC END# *47C5B9DB0136_4A4B231403B6_var*
begin
//#UC START# *47C5B9DB0136_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9DB0136_4A4B231403B6_impl*
end;//HnevView.BeginDrawShape

procedure HnevView.EndDrawShape;
 {* ����������� ���������� ����� � ������. }
//#UC START# *47C5B9FB03D1_4A4B231403B6_var*
//#UC END# *47C5B9FB03D1_4A4B231403B6_var*
begin
//#UC START# *47C5B9FB03D1_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5B9FB03D1_4A4B231403B6_impl*
end;//HnevView.EndDrawShape

function HnevView.MapByPoint(const aPoint: InevBasePoint;
 aCheckTopVisible: Boolean = False): InevMap;
//#UC START# *47C5BA240004_4A4B231403B6_var*
//#UC END# *47C5BA240004_4A4B231403B6_var*
begin
//#UC START# *47C5BA240004_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5BA240004_4A4B231403B6_impl*
end;//HnevView.MapByPoint

function HnevView.FormatInfoByPoint(const aPoint: InevBasePoint): TnevFormatInfoPrim;
//#UC START# *481078F302DD_4A4B231403B6_var*
//#UC END# *481078F302DD_4A4B231403B6_var*
begin
//#UC START# *481078F302DD_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *481078F302DD_4A4B231403B6_impl*
end;//HnevView.FormatInfoByPoint

function HnevView.RootFormatInfo: TnevFormatInfoPrim;
//#UC START# *4811BA6C005A_4A4B231403B6_var*
//#UC END# *4811BA6C005A_4A4B231403B6_var*
begin
//#UC START# *4811BA6C005A_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4811BA6C005A_4A4B231403B6_impl*
end;//HnevView.RootFormatInfo

procedure HnevView.InvalidateShape(const aShape: InevObject;
 aParts: TnevShapeParts);
//#UC START# *4816E2B2004E_4A4B231403B6_var*
//#UC END# *4816E2B2004E_4A4B231403B6_var*
begin
//#UC START# *4816E2B2004E_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4816E2B2004E_4A4B231403B6_impl*
end;//HnevView.InvalidateShape

function HnevView.Get_ActiveElement: InevActiveElement;
//#UC START# *4A27CEB10364_4A4B231403B6get_var*
//#UC END# *4A27CEB10364_4A4B231403B6get_var*
begin
//#UC START# *4A27CEB10364_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A27CEB10364_4A4B231403B6get_impl*
end;//HnevView.Get_ActiveElement

function HnevView.Get_ForceDrawFocusRect: Boolean;
//#UC START# *4B59A96702D9_4A4B231403B6get_var*
//#UC END# *4B59A96702D9_4A4B231403B6get_var*
begin
//#UC START# *4B59A96702D9_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B59A96702D9_4A4B231403B6get_impl*
end;//HnevView.Get_ForceDrawFocusRect

function HnevView.Get_IsObjectCollapsed(const anObject: InevObject): Boolean;
//#UC START# *4D5A3DD60219_4A4B231403B6get_var*
//#UC END# *4D5A3DD60219_4A4B231403B6get_var*
begin
//#UC START# *4D5A3DD60219_4A4B231403B6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5A3DD60219_4A4B231403B6get_impl*
end;//HnevView.Get_IsObjectCollapsed

procedure HnevView.Set_IsObjectCollapsed(const anObject: InevObject;
 aValue: Boolean);
//#UC START# *4D5A3DD60219_4A4B231403B6set_var*
//#UC END# *4D5A3DD60219_4A4B231403B6set_var*
begin
//#UC START# *4D5A3DD60219_4A4B231403B6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5A3DD60219_4A4B231403B6set_impl*
end;//HnevView.Set_IsObjectCollapsed

{$If Defined(evNeedCollapsedVersionComments)}
procedure HnevView.VersionInfoVisabilityChanged(aValue: Boolean);
//#UC START# *4D5A3E3E01B7_4A4B231403B6_var*
//#UC END# *4D5A3E3E01B7_4A4B231403B6_var*
begin
//#UC START# *4D5A3E3E01B7_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D5A3E3E01B7_4A4B231403B6_impl*
end;//HnevView.VersionInfoVisabilityChanged
{$IfEnd} // Defined(evNeedCollapsedVersionComments)

function HnevView.FormatInfoByPara(const aPara: InevObject): TnevFormatInfoPrim;
//#UC START# *4E6F8ED402EF_4A4B231403B6_var*
//#UC END# *4E6F8ED402EF_4A4B231403B6_var*
begin
//#UC START# *4E6F8ED402EF_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6F8ED402EF_4A4B231403B6_impl*
end;//HnevView.FormatInfoByPara

function HnevView.FormatInfoByObj(const anObj: InevObjectPrim): TnevFormatInfoPrim;
//#UC START# *4E6F8EF302A4_4A4B231403B6_var*
//#UC END# *4E6F8EF302A4_4A4B231403B6_var*
begin
//#UC START# *4E6F8EF302A4_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6F8EF302A4_4A4B231403B6_impl*
end;//HnevView.FormatInfoByObj

function HnevView.FormatInfoByPara(aPara: PInevObject): TnevFormatInfoPrim;
//#UC START# *4E6F98080175_4A4B231403B6_var*
//#UC END# *4E6F98080175_4A4B231403B6_var*
begin
//#UC START# *4E6F98080175_4A4B231403B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E6F98080175_4A4B231403B6_impl*
end;//HnevView.FormatInfoByPara

procedure HnevView.Fake;
 {* ��� ����� ����� ��������� �������������� ������ ������� ������� � ��������� }
begin
 Assert(false);
end;//HnevView.Fake

constructor HnevView.Init(const aInevView: InevView);
begin
 f_InevView := aInevView;
end;//HnevView.Init

end.
