unit l3Interfaces;

interface

uses
 l3IntfUses
 , Windows
 , l3PureMixIns
 , ActiveX
 , l3Core
;

type
 Tl3WString = object
  {* ������ � ���������� � � ������. }
 end;//Tl3WString
 
 Il3CString = interface
  {* ����������� ������ }
 end;//Il3CString
 
 Il3Base = interface
  {* ������� ��������� ���������� L3 }
  function CheckStamp(const aGUID: TGUID): Boolean;
   {* ��������� ����� ���������� ����������. �������� ��� ����, ����� ������, ��� ���������� ���� "������". }
 end;//Il3Base
 
 TGUID = System.TGUID;
  {* GUID }
 
 Il3Reader = interface
  {* �������� �����. }
  procedure execute;
   {* ��������� ������� ������ �����. }
 end;//Il3Reader
 
 Il3Notify = interface
  {* ����������� ���������. }
 end;//Il3Notify
 
 Il3CaretOwner = interface
  {* �������� ������� �����. }
  procedure RedrawCaret;
 end;//Il3CaretOwner
 
 Il3Lock = interface
  {* �����. }
  procedure Lock(const aLocker: IUnknown);
   {* �������. }
  procedure Unlock(const aLocker: IUnknown);
   {* �������. }
 end;//Il3Lock
 
 Il3FrameTextPainter = interface
  {* ���������� ������ �����. }
  procedure DrawFrameText(aTop: Boolean);
   {* ������ ����� �����. }
 end;//Il3FrameTextPainter
 
 IDataObject = ActiveX.IDataObject;
  {* ������ �������������� ������ ��� ������ ������ ��� drag-and-drop. }
 
 Il3ChangeNotifier = interface
  {* ���������� �� ��������� ������. }
  procedure Subscribe(const aRecipient: Il3Notify);
   {* �������� �� ���������. }
  procedure Unsubscribe(const aRecipient: Il3Notify);
   {* "�������" �� ���������. }
 end;//Il3ChangeNotifier
 
 Il3Tool = interface
  {* ����������, ����������� � ��������. }
  procedure OwnerDead;
   {* ����������� � ������ ��������. }
 end;//Il3Tool
 
 Il3ItemNotifyRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������. }
  procedure Notify(const aNotifier: Il3ChangeNotifier;
   aOperation: Integer;
   aIndex: Integer);
   {* ������ ��������. }
 end;//Il3ItemNotifyRecipient
 
 Il3ChangeRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������� ������. }
  procedure Changed;
   {* ����������� � ���������� ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
  procedure Changing;
   {* ����������� � ������ ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
 end;//Il3ChangeRecipient
 
 TPoint = l3Core.TPoint;
  {* �����. }
 
 IEnumFormatEtc = IEnumFORMATETC;
  {* �������� �� ������ ������ IDataObject. }
 
 Il3DataObjectInfo = interface
  {* ���������� �� ������� ������������ � ������ ������. }
 end;//Il3DataObjectInfo
 
 Tl3PCharLenPrim = Tl3WString;
  {* ������ � �������. }
 
 Tl3FontIndex = (
  {* ������ ������. }
  l3_fiNone
   {* ���. }
  , l3_fiSub
   {* ������. }
  , l3_fiSuper
   {* �������. }
  , l3_fiObject
   {* ������ }
  , l3_fiBaseLined
 );//Tl3FontIndex
 
 Tl3TabStopStyle = (
  {* ����� ������� ���������. }
  l3_tssLeft
  , l3_tssCenter
  , l3_tssRight
  , l3_tssDecimal
  , l3_tssLine
 );//Tl3TabStopStyle
 
 Tl3Orientation = (
  {* ���������� �������. }
  ev_orNone
   {* ������������. }
  , ev_orHorizontal
   {* �������������. }
  , ev_orVertical
   {* �����������. }
 );//Tl3Orientation
 
 HResult = System.HResult;
 
 Tl3ClipboardFormat = Cardinal;
  {* ������ ������ ������ ������. }
 
 Tl3StringArray = array of AnsiString;
  {* ������������ ������ �����. }
 
 Tl3StyleId = type Integer;
  {* ������������� ������� ������. }
 
 Tl3ClipboardFormats = array of Tl3ClipboardFormat;
  {* ����� �������� ������ ������ ������. }
 
 Tl3StoragePlace = TStgMedium;
  {* �������� ������. }
 
 Tl3Color = l3Core.Tl3Color;
 
 LCID = l3Core.LCID;
  {* ������������� ������. }
 
 Il3LocaleInfo = interface
  {* ���������� � ������. }
 end;//Il3LocaleInfo
 
 Il3SelectCountChangedRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������� ���������� ���������� ���������. }
  procedure SelectCountChanged(anOldCount: Integer;
   aNewCount: Integer);
   {* ������ ��������. }
 end;//Il3SelectCountChangedRecipient
 
 Il3ExternalTreeChangedRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������� ���������� ������� ���������. }
  procedure ExternalVisibleCountChanged(aNewCount: Integer;
   aNodeIndex: Integer;
   aDelta: Integer);
   {* ������ ��������. }
  procedure ExternalInvalidate;
   {* �����������. }
  procedure ExternalModified(aNode: Integer;
   aDelta: Integer);
   {* � ������ ���� ���������/������� ��������.
             - aNode:
                 ���� ���� �������� ��������/������� ����. ��������� ����������
                 � ����;
             - aDelta:
                 ���������� ��������� ������� ���� ���������/�������. ����
                 aDelta �� ������ ����� �������� ���� �������; }
 end;//Il3ExternalTreeChangedRecipient
 
 Il3MultipartText = interface
  {* ��������� ��� ��������� ������ � ���� �������� (��� ��������������� ����, � ���������). }
  function GetTextPart(aIndex: Integer): Tl3PCharLenPrim;
   {* ���������� ����� ������ �� �������. }
 end;//Il3MultipartText
 
 Il3XMLWriter = interface
  {* ��������� XML. }
  procedure PutData(const aString: AnsiString); overload;
  procedure PutData(const aString: Il3CString); overload;
  procedure PutData(const aString: Tl3WString); overload;
  procedure OpenLevel(const aString: AnsiString); overload;
   {* ��������� ����� ���. }
  procedure OpenLevel(const aString: AnsiString;
   const aSuffix: AnsiString); overload;
   {* ��������� ����� ���. aSuffix - �������� ����. }
  procedure OpenSubLevel(const aSuffix: AnsiString);
   {* ��������� ����������, ����� ��������� ����� "s" � ����������� ������. }
  procedure CloseLevel;
   {* ��������� ���. }
  function CS(const aSt: Tl3WString): AnsiString; overload;
   {* Escape'�� ������. }
  function CS(const aSt: Il3CString): AnsiString; overload;
   {* Escape'�� ������. }
  function CS(const aString: AnsiString): AnsiString; overload;
   {* Escape'�� ������. }
  procedure Start;
   {* �������� ���������. }
  procedure Finish;
   {* ����������� ���������. }
 end;//Il3XMLWriter
 
 Il3AString = interface
  {* ANSI-������. }
  function S: PAnsiChar;
   {* ���������� ������. }
 end;//Il3AString
 
 Il3RangeManager = interface
  {* �������� �������. }
  function HasPage(anIndex: Integer): Boolean;
   {* �������� �� �������� ��������� ��������. }
 end;//Il3RangeManager
 
 TStrings = l3Core.TStrings;
  {* ������ �����. }
 
 hDC = l3Core.hDC;
  {* �������� ���������� ������. }
 
 Tl3PageOrientation = (
  {* ���������� ��������. }
  l3_poPortrait
   {* �������. }
  , l3_poLandscape
   {* ���������. }
 );//Tl3PageOrientation
 
 Il3Strings = interface
  {* ������ �����. }
 end;//Il3Strings
 
 Il3StringsEx = interface(Il3Strings)
  {* ������ �����. }
  procedure Assign(const aStrings: Il3StringsEx); overload;
  procedure Assign(aStrings: TStrings); overload;
  function EQ(const aStrings: Il3StringsEx): Boolean;
  function Add(const aStr: AnsiString): Integer; overload;
  function Add(const Item: Il3CString): Integer; overload;
  function Add(const aStr: Tl3WString): Integer; overload;
  function AddObject(const aStr: AnsiString;
   anObject: TObject): Integer; overload;
  function AddObject(const aStr: Il3CString;
   anObject: TObject): Integer; overload;
  procedure Insert(aIndex: Integer;
   const aStr: Il3CString); overload;
  procedure Insert(aIndex: Integer;
   const aStr: AnsiString); overload;
  procedure BeginUpdate;
  procedure EndUpdate;
  procedure Clear;
  procedure Delete(anIndex: Integer);
  function IndexOf(const aSt: AnsiString): Integer; overload;
  function IndexOf(const aSt: Il3CString): Integer; overload;
  function IndexOf(const aSt: Tl3WString): Integer; overload;
 end;//Il3StringsEx
 
 Tl3OrientationSet = set of Tl3Orientation;
  {* ��������� ���������� �������. }
 
 // Tl3Orientation1
 
 Tl3Inch = Integer;
  {* ����. }
 
 Tl3_PointXY = record
 end;//Tl3_PointXY
 
 Tl3InchOArray = array [Tl3Orientation1] of Tl3Inch;
 
 Tl3InchBArray = array [Boolean] of Tl3Inch;
 
 Tl3PointSF = record
 end;//Tl3PointSF
 
 Tl3_PointUnion = record
 end;//Tl3_PointUnion
 
 Tl3_Point = object
  {* ������� ����� � ������������ � ������ (������� ����������). }
 end;//Tl3_Point
 
 Tl3_RectLRTB = record
 end;//Tl3_RectLRTB
 
 Tl3_SPoint = object
  {* ������� ����� � ������������ � �������� (�� ������). }
 end;//Tl3_SPoint
 
 Tl3_RectTB = record
 end;//Tl3_RectTB
 
 Tl3PointBArray = array [Boolean] of Tl3_Point;
 
 Tl3_RectUnion = record
 end;//Tl3_RectUnion
 
 Tl3_Rect = object
  {* �������������. }
 end;//Tl3_Rect
 
 Il3Meter = interface
  {* ��������� ��������� }
  procedure ProgressProc(aState: Byte;
   aValue: Integer;
   const aMsg: Il3CString);
  procedure FreeNotification(AComponent: TComponent);
  procedure RemoveFreeNotification(AComponent: TComponent);
 end;//Il3Meter
 
 Il3SimpleView = interface
  procedure Update;
 end;//Il3SimpleView
 
 Il3Window = interface
  {* ����. }
  procedure Invalidate;
   {* ������ �� �����������. }
 end;//Il3Window
 
 IStream = ActiveX.IStream;
  {* �����. }
 
 Il3TempStream = interface
  {* ��������� ��������� ������. }
  function MakeForWrite(aNeedCompression: Boolean): IStream;
   {* ������� ����� ��� ������. }
  function MakeForRead: IStream;
   {* ������� ����� ��� ������. }
 end;//Il3TempStream
 
 Il3DropTarget = interface
  {* ����� ���� ����� �������� ������. }
  function GetAcceptableFormats: Tl3ClipboardFormats;
   {* ������ ���������� ��������. }
  function DoDrop(aFormat: Tl3ClipboardFormat;
   const aMedium: Tl3StoragePlace;
   var dwEffect: Integer): Boolean;
  function DoDragOver(const aData: IDataObject;
   const aPoint: TPoint): Boolean;
  procedure DoDragEnter(const aData: IDataObject;
   const aPoint: TPoint);
  procedure DoDragLeave;
  function Keys2Effect(aKeys: Integer): Integer;
 end;//Il3DropTarget
 
 TFormatEtc = ActiveX.TFormatEtc;
 
 PMsg = l3Core.PMsg;
 
 Tl3HookProcResult = record
 end;//Tl3HookProcResult
 
 LPARAM = l3Core.LPARAM;
 
 WPARAM = l3Core.WPARAM;
 
 Il3Listener = interface
 end;//Il3Listener
 
 Il3ToolOwner = interface
  {* �������� ������������. }
  procedure AddTool(const aTool: Il3Tool);
   {* �������� ����������. }
  procedure RemoveTool(const aTool: Il3Tool);
   {* ������� ����������. }
 end;//Il3ToolOwner
 
 IDropSource = ActiveX.IDropSource;
 
 IDropTarget = ActiveX.IDropTarget;
 
 IAdviseSink = ActiveX.IAdviseSink;
 
 IEnumStatData = ActiveX.IEnumStatData;
 
 PFormatEtc = ActiveX.PFormatEtc;
 
 hWnd = l3Core.hWnd;
 
 HPALETTE = l3Core.HPALETTE;
 
 HMETAFILE = l3Core.HMETAFILE;
 
 HGLOBAL = l3Core.HGLOBAL;
 
 Tl3CheckBoxState = (
  {* ��������� Checkbox'�. }
  l3_cbUnchecked
   {* �� ������. }
  , l3_cbChecked
   {* ������. }
  , l3_cbGrayed
   {* ��������. }
 );//Tl3CheckBoxState
 
 Tl3ButtonState = (
  {* ��������� ������. }
  l3_bsUp
   {* ������. }
  , l3_bsDisabled
   {* ���������. }
  , l3_bsDown
   {* ������. }
  , l3_bsExclusive
   {* <?> �������, ��� ���? }
 );//Tl3ButtonState
 
 Tl3Alignment = (
  {* ������������. }
  l3_taLeftJustify
   {* �����. }
  , l3_taRightJustify
   {* ������. }
  , l3_taCenter
   {* �� ������. }
 );//Tl3Alignment
 
 Tl3ValueMapID = record
  {* ������������� ����. }
 end;//Tl3ValueMapID
 
 Il3ValueMap = interface
  {* ������ ��������� ��� ��� "������"-�����. }
  procedure GetDisplayNames(const aList: Il3StringsEx);
   {* ��������� ������ ���������� "UI-������" }
  function MapSize: Integer;
   {* ���������� ��������� � ����. }
 end;//Il3ValueMap
 
 Il3StringValueMap = interface(Il3ValueMap)
  {* ���� "������"-"������" ��� ��������. }
  function DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
  function ValueToDisplayName(const aValue: Il3CString): Il3CString;
 end;//Il3StringValueMap
 
 Il3ValueMapFactory = interface
  {* ������� �������� ��� ����-��������. }
  function MakeMap(const aID: Tl3ValueMapID): Il3ValueMap;
 end;//Il3ValueMapFactory
 
 Il3StringValueMapFactory = interface(Il3ValueMapFactory)
  {* ������� ��� Il3StringValueMap. }
 end;//Il3StringValueMapFactory
 
 Il3IntegerValueMap = interface(Il3ValueMap)
  {* ���� "������"-"�����" ��� ��������. }
  function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
  function ValueToDisplayName(aValue: Integer): Il3CString;
 end;//Il3IntegerValueMap
 
 Il3IntegerValueMapFactory = interface(Il3ValueMapFactory)
  {* ������� ��� Il3IntegerValueMap. }
 end;//Il3IntegerValueMapFactory
 
 Il3IntegerValueMapManager = interface
  {* ��������� ��� Il3IntegerValueMap. }
  procedure RegisterFactory(const aFactory: Il3IntegerValueMapFactory;
   aPreferred: Boolean);
   {* aPreferred - ������� ����� ���������� ��� ����� ������. }
  procedure UnRegisterFactory(const aFactory: Il3IntegerValueMapFactory);
 end;//Il3IntegerValueMapManager
 
 Tl3LinePartDrawType = (
  {* ��� ����� �����. }
  lpdDraw
   {* ����� �������� ������. }
  , lpdSpecialDraw
   {* ��������� ����� (������ ��� ����������� ������� ���������). }
  , lpdHidden
   {* ������ �� ����� �����������. }
 );//Tl3LinePartDrawType
 
 Tl3FramePartIndex = (
  {* ������ ����� �����. }
  l3_fpiUp
  , l3_fpiDown
  , l3_fpiLeft
  , l3_fpiRight
 );//Tl3FramePartIndex
 
 Tl3FramePart = record
  {* ������� �����. }
 end;//Tl3FramePart
 
 Tl3FramePartArray = array [Tl3FramePartIndex] of Tl3FramePart;
  {* ������ ��������� �����. }
 
 Il3Lines = interface
  {* ������ �����. }
  function AsObject: TObject;
 end;//Il3Lines
 
 Il3MultiLines = interface
  function IsSingle: Boolean;
  function HasBreakInWord: Boolean;
 end;//Il3MultiLines
 
 Il3List = interface
  {* ������. }
  procedure Clear;
   {* �������� ������. }
  procedure Delete(anIndex: Integer);
   {* ������� ������� �� ������� Index. }
 end;//Il3List
 
 Il3InterfaceList = interface(Il3List)
  {* ������ �����������. }
  function Add(const anItem: IUnknown): Integer;
   {* ��������� �������. ���������� �� ������. }
  procedure Insert(anIndex: Integer;
   const anItem: IUnknown);
   {* ��������� ������� Item �� ������� Index. }
  procedure AssignList(const aList: Il3InterfaceList);
 end;//Il3InterfaceList
 
 Tl3FontIndexes = set of Tl3FontIndex;
  {* ��������� �������� ������. }
 
 TFontName = l3Core.TFontName;
  {* ��������� ������. }
 
 TFontPitch = l3Core.TFontPitch;
 
 Il3FontInfo = interface
  {* ���������� � ������. }
 end;//Il3FontInfo
 
 TFontStyles = l3Core.TFontStyles;
 
 Il3FontPrim = interface(Il3FontInfo)
  {* ����� �������. }
 end;//Il3FontPrim
 
 hFont = l3Core.hFont;
 
 TFont = l3Core.TFont;
 
 Il3FontMetrics = interface
  {* ������� ������. }
  function Pos2Index(W: Integer;
   const S: Tl3WString): Integer;
   {* ������� ������ ������� �� ��������� W ������ �� ������ ������ S. }
  function TextExtent(const S: Tl3WString): Tl3_Point;
   {* ���������� ������� ������ ������ � ������. }
 end;//Il3FontMetrics
 
 TCharSet = set of AnsiChar;
  {* ��������� ��������. }
 
 Tl3DString = type WideString;
 
 Tl3SetBitType = (
  sbSelect
  , sbDeselect
  , sbInvert
 );//Tl3SetBitType
 
 Tl3Direction = (
  {* ����������� ��������. }
  dUp
  , dUpMax
  , dDown
  , dDownMax
  , dLeft
  , dRight
 );//Tl3Direction
 
 Tl3WordPosition = (
  wpAnyPathWord
   {* � ����� ����� �����. }
  , wpAtBeginWord
   {* � ������ �����. }
  , wpAtBeginString
   {* � ������ ������. }
 );//Tl3WordPosition
 
 Tl3WordOrder = (
  {* ������� ��������� ����. }
  woAnyOrder
   {* � ����� �������. }
  , woAsWrote
   {* � ������ ������� ���������� ���������. }
 );//Tl3WordOrder
 
 Tl3TreeLevelDist = (
  {* ������� ��� ������������� ��������. }
  tldAllLevels
   {* �� ���� �������. }
  , tldOneLevel
   {* � �������� ������ ������. }
 );//Tl3TreeLevelDist
 
 Tl3CStringArray = array of Il3CString;
  {* ������������ ������ �����. }
 
 Tl3MemoryFlag = (
  {* ���� ������������� ������. }
  l3_mfNil
   {* �� ������������. }
  , l3_mfSmall
   {* ������ 4-� ����. }
  , l3_mfLocal
   {* �������� �� GetMem. }
  , l3_mfGlobal
   {* �������� �� GlobalAlloc. }
 );//Tl3MemoryFlag
 
 Tl3PtrRec = record
  {* ��������� �� ����� ������. }
 end;//Tl3PtrRec
 
 Tl3PtrRecLen = record
  {* �������������� ������ � ���������� � ������. }
 end;//Tl3PtrRecLen
 
 Tl3WrappedWString = record
  {* ����������� ������. }
 end;//Tl3WrappedWString
 
 Tl3WStrCast = record
  {* ���������� ����� Tl3PtrRec � Tl3WStr. }
 end;//Tl3WStrCast
 
 Il3Console = interface
  {* �������. }
  procedure Shift(aDelta: Integer);
   {* �������� ������ ������. }
  procedure Say(const aStr: Il3CString);
   {* ������� ������� �� �������. }
 end;//Il3Console
 
 Tl3Frame = record
  {* �����. }
 end;//Tl3Frame
 
 Il3Font = interface(Il3FontPrim)
  {* ����� �������. }
  function AssignFont(Font: TFont): Boolean;
  procedure Assign2Font(const aFont: Il3Font);
  procedure Lock;
  procedure Unlock;
  function HF: hFont;
  function IsAtomic: Boolean;
   {* ������ ��� ������� ������ ������������ ����� ������ ������? }
  function FM: Il3FontMetrics;
   {* ������� ������. }
 end;//Il3Font
 
 Tl3LinesColorArray = array [Tl3LinePartDrawType] of Tl3Color;
  {* ����� ��� ��������� �����. }
 
 // Tl3Index
 
 VCLBitmap = l3Core.VCLBitmap;
  {* ��������. }
 
 Tl3OperationCode = Cardinal;
  {* ������� ������������ ���������� � ���������� ������������ ��������� ShortCut-�� }
 
 IStorage = ActiveX.IStorage;
 
 Il3WordsSeq = interface
  {* "������". }
  function WordStart(Pos: Tl3Position): Tl3Position;
  function WordLeft(Pos: Tl3Position): Tl3Position;
  function WordFinish(Pos: Tl3Position): Tl3Position;
  function WordRight(Pos: Tl3Position): Tl3Position;
 end;//Il3WordsSeq
 
 (*
 Ml3PageSetup = interface
  {* ���������� � �������� }
 end;//Ml3PageSetup
 *)
 
 WinBool = l3Core.WinBool;
 
 Il3Caret = interface
  function CheckHidden: Boolean;
  function CanHide: Boolean;
 end;//Il3Caret
 
 Il3ScrollCaret = interface(Il3Caret)
  function IsInited: Boolean;
  function IsOnScreen: Boolean;
  procedure Scroll(const aOfs: Tl3_SPoint);
  procedure Reset;
 end;//Il3ScrollCaret
 
 Il3MemoryPool = interface
  {* ����� ������. }
 end;//Il3MemoryPool
 
 Il3HandleMemoryPool = interface(Il3MemoryPool)
  {* ����� ������ � Windows Handle. }
  function ReleaseHandle: THandle;
  function AsHandle: THandle;
   {* Windows Handle ����� ������. }
 end;//Il3HandleMemoryPool
 
 Il3StringValueMapManager = interface
  {* ��������� ��� Il3StringValueMap. }
  procedure RegisterFactory(const aFactory: Il3StringValueMapFactory;
   aPreferred: Boolean);
   {* aPreferred - ������� ����� ���������� ��� ����� ������. }
  procedure UnRegisterFactory(const aFactory: Il3StringValueMapFactory);
 end;//Il3StringValueMapManager
 
 Tl3CompareAction = function(I: Integer;
  J: Integer): Integer;
  {* ������� ��������� ���������. }
 
 PInteger = l3Core.PInteger;
  {* ��������� �� Integer. }
 
 Large = Int64;
 
 Il3Progress = interface
  {* ��������� ��������. }
  procedure Start(Count: Integer;
   const aMsg: Il3CString); overload;
   {* ������ �������. }
  procedure Start(Count: Large;
   const aMsg: Il3CString); overload;
   {* ������ �������. }
  procedure Finish;
   {* ��������� �������. }
  procedure Progress(Current: Integer); overload;
   {* �������� ������� ���������. }
  procedure Progress(Current: Large); overload;
   {* �������� ������� ���������. }
  procedure ProgressEx(Current: Integer;
   const aMsg: Il3CString);
  procedure ChangeIO(Start: Boolean);
   {* �������� ���� InIO. }
  function InIO: Boolean;
   {* � �������� �����/������? }
  function InUse: Boolean;
 end;//Il3Progress
 
 Tl3TabStop = record
  {* �������� ������� ���������. }
 end;//Tl3TabStop
 
 Il3TabStops = interface
  {* ������� ���������. }
  function Clone: Il3TabStops;
   {* ��������� ������� ���������. }
  function Next: Tl3TabStop;
   {* ��������� ������� ���������. }
  function Filler: Tl3WString;
   {* ��������� ������-�����������. }
  function Style: Tl3TabStopStyle;
   {* ��������� �����. }
  function NeedCutByTab: Boolean;
  procedure Reset;
 end;//Il3TabStops
 
 Il3ProgressSource = interface
 end;//Il3ProgressSource
 
 Il3DocIDSource = interface
 end;//Il3DocIDSource
 
 Il3TabInfo = interface
  {* ���������� � ������� ��������� ���������. }
  function TabOffset: Integer;
  function TabStops: Il3TabStops;
 end;//Il3TabInfo
 
 Tl3MouseAction = (
  {* ������� ����. }
  l3_maDown
  , l3_maUp
  , l3_maDouble
  , l3_maMove
  , l3_maCtlMove
 );//Tl3MouseAction
 
 Tl3MouseButton = (
  {* ������ ����. }
  l3_mbLeft
  , l3_mbMiddle
  , l3_mbRight
 );//Tl3MouseButton
 
 Il3Rollback = interface
  {* ������, ������� ���������� ������ }
  procedure Rollback;
   {* �������� ������ }
 end;//Il3Rollback
 
 Il3PageSetup = interface
  {* ���������� � �������� }
 end;//Il3PageSetup
 
 Tl3StringID = object
 end;//Tl3StringID
 
 Pl3StringID = ^Tl3StringID;
 
 Il3ApplicationL10NStrings = interface
  {* ������������ ������ ���������� }
  procedure Define(const aName: AnsiString;
   const aRus: AnsiString;
   const anAlien: AnsiString);
 end;//Il3ApplicationL10NStrings
 
 Il3IntegerList = interface
  {* ������ ����� ����� }
 end;//Il3IntegerList
 
 Pl3WString = ^Tl3WString;
 
 Il3GetMessageListener = interface(Il3Listener)
  procedure GetMessageListenerNotify(Code: Integer;
   aWParam: WPARAM;
   Msg: PMsg;
   var theResult: Tl3HookProcResult);
 end;//Il3GetMessageListener
 
 Il3WndProcRetListener = interface(Il3Listener)
  procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
   var theResult: Tl3HookProcResult);
 end;//Il3WndProcRetListener
 
 Il3MouseListener = interface(Il3Listener)
  procedure MouseListenerNotify(aMouseMessage: WPARAM;
   aHookStruct: PMouseHookStruct;
   var theResult: Tl3HookProcResult);
 end;//Il3MouseListener
 
 Il3WndProcListener = interface(Il3Listener)
  {* ���������, ���������� ����������� � ����������� ��������� � ��������� ���� ����������. }
  procedure WndProcListenerNotify(Msg: PCWPStruct;
   var theResult: Tl3HookProcResult);
 end;//Il3WndProcListener
 
 Il3MouseWheelListener = interface(Il3Listener)
  procedure MouseWheelListenerNotify(Msg: PMsg;
   var theResult: Tl3HookProcResult);
 end;//Il3MouseWheelListener
 
 Il3CBTListener = interface(Il3Listener)
  procedure CBTListenerNotify(Code: Integer;
   WParam: WPARAM;
   LParam: LPARAM;
   var theResult: Tl3HookProcResult);
 end;//Il3CBTListener
 
 Tl3Point = Tl3_Point;
 
 Tl3Rect = Tl3_Rect;
 
 Tl3SPoint = Tl3_SPoint;
 
implementation

uses
 l3ImplUses
 , l3Math
 , l3MinMax
;

end.
