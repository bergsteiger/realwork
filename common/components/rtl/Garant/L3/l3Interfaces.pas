unit l3Interfaces;

{$IfDef DesignTimeLibrary}
{.$WEAKPACKAGEUNIT ON}
{$EndIf DesignTimeLibrary}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$Domain"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3Interfaces.pas"
// �����: 30.12.2004 13:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi ���������� � �������������� �����������::L3$Domain::l3Interfaces
//
// ������� ����������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  ActiveX,
  l3Core,
  l3PureMixIns,
  Windows
  ;

type
 Il3Base = interface
  {* ������� ��������� ���������� L3 }
   ['{7A76D305-0172-42D6-8C6E-2A6267750F01}']
  // Ml3CheckStamp
   function CheckStamp(const aGUID: TGUID): Boolean;
     {* ��������� ����� ���������� ����������. �������� ��� ����, ����� ������, ��� ���������� ���� "������". }
 end;//Il3Base

 Tl3WString = packed object
  {* ������ � ���������� � � ������. }
 public
   S : PAnsiChar; // ���������� ������.
   SLen : Integer; // �����.
   SCodePage : SmallInt; // ������� ��������.
 end;//Tl3WString

 Il3CString = interface(Il3Base)
  {* ����������� ������ }
   ['{D1D21F4B-3909-4E95-B2BF-99D984D6A370}']
   function pm_GetAsWStr: Tl3WString;
   property AsWStr: Tl3WString
     read pm_GetAsWStr;
     {* ���������� ������ ������. }
 end;//Il3CString

 TGUID = System.TGUID;
  {* GUID }

 Il3Reader = interface(Il3Base)
  {* �������� �����. }
   ['{9080D562-DFC8-467B-A62A-ECB0B370792D}']
   procedure Execute;
     {* ��������� ������� ������ �����. }
 end;//Il3Reader

 Il3Notify = interface(Il3Base)
  {* ����������� ���������. }
   ['{BD9E942A-5B81-4927-B487-BE9193746EED}']
 end;//Il3Notify

 Il3CaretOwner = interface(Il3Base)
  {* �������� ������� �����. }
   ['{ED9D7EAB-B87A-4788-8998-5E51002EB93E}']
   procedure RedrawCaret;
 end;//Il3CaretOwner

 Il3Lock = interface(Il3Base)
  {* �����. }
   ['{0E8AB787-7B9A-47A1-8CF2-BC4F3AFD270F}']
   procedure Lock(const aLocker: IUnknown);
     {* �������. }
   procedure Unlock(const aLocker: IUnknown);
     {* �������. }
 end;//Il3Lock

 Il3FrameTextPainter = interface(Il3Base)
  {* ���������� ������ �����. }
   ['{4EDE16E5-96D3-4E4F-9E21-9A89150CD723}']
   procedure DrawFrameText(aTop: Boolean);
     {* ������ ����� �����. }
 end;//Il3FrameTextPainter

 IDataObject = ActiveX.IDataObject;
  {* ������ �������������� ������ ��� ������ ������ ��� drag-and-drop. }

 Il3ChangeNotifier = interface(Il3Base)
  {* ���������� �� ��������� ������. }
   ['{613526DF-81A1-4548-ADBE-8A97593688DB}']
   procedure Subscribe(const aRecipient: Il3Notify);
     {* �������� �� ���������. }
   procedure Unsubscribe(const aRecipient: Il3Notify);
     {* "�������" �� ���������. }
 end;//Il3ChangeNotifier

 Il3Tool = interface(Il3Base)
  {* ����������, ����������� � ��������. }
   ['{E1F4F520-30EC-4BED-BE0B-F41528266A50}']
   procedure OwnerDead;
     {* ����������� � ������ ��������. }
 end;//Il3Tool

 Il3ItemNotifyRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������. }
   ['{A52C2668-35F7-43F4-9654-D717F139AD6A}']
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
     {* ������ ��������. }
 end;//Il3ItemNotifyRecipient

 Il3ChangeRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������� ������. }
   ['{AC06EE86-0C9B-4105-A832-9DCA8518AB3B}']
  // Ml3ChangingChanged
   procedure Changed;
     {* ����������� � ���������� ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
   procedure Changing;
     {* ����������� � ������ ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
 end;//Il3ChangeRecipient

 TPoint = l3Core.TPoint;
  {* �����. }

 IEnumFormatEtc = ActiveX.IEnumFORMATETC;
  {* �������� �� ������ ������ IDataObject. }

 Il3DataObjectInfo = interface(Il3Base)
  {* ���������� �� ������� ������������ � ������ ������. }
   ['{F24E118B-0387-4B9A-BAE1-048111FE62F5}']
   function pm_GetIsQuestionNeedBeforeFlush: Boolean;
   property IsQuestionNeedBeforeFlush: Boolean
     read pm_GetIsQuestionNeedBeforeFlush;
 end;//Il3DataObjectInfo

 Tl3PCharLenPrim = Tl3WString;
  {* ������ � �������. }

 Tl3FontIndex = (
  {* ������ ������. }
   l3_fiNone // ���.
 , l3_fiSub // ������.
 , l3_fiSuper // �������.
 , l3_fiObject // ������
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
   ev_orNone // ������������.
 , ev_orHorizontal // �������������.
 , ev_orVertical // �����������.
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

 Tl3StoragePlace = ActiveX.TStgMedium;
  {* �������� ������. }

 Tl3Color = l3Core.Tl3Color;

 LCID = l3Core.LCID;
  {* ������������� ������. }

 Il3LocaleInfo = interface(Il3Base)
  {* ���������� � ������. }
   ['{A6A938EE-5484-44D0-8ABF-8656D371EC8F}']
   function pm_GetLanguage: AnsiString;
   function pm_GetSubLanguage: AnsiString;
   function pm_GetName: AnsiString;
   function pm_GetId: LCID;
   property Language: AnsiString
     read pm_GetLanguage;
     {* ����. }
   property SubLanguage: AnsiString
     read pm_GetSubLanguage;
     {* �������. }
   property Name: AnsiString
     read pm_GetName;
     {* ������. }
   property Id: LCID
     read pm_GetId;
     {* ������������� �����. }
 end;//Il3LocaleInfo

 Il3SelectCountChangedRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������� ���������� ���������� ���������. }
   ['{A865FB69-3BBB-400E-9FFA-E3F98403D262}']
   procedure SelectCountChanged(anOldCount: Integer;
    aNewCount: Integer);
     {* ������ ��������. }
 end;//Il3SelectCountChangedRecipient

 Il3ExternalTreeChangedRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������� ���������� ������� ���������. }
   ['{8CE94C75-432F-494F-A880-4A4F6F196197}']
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

 Il3MultipartText = interface(Il3Base)
  {* ��������� ��� ��������� ������ � ���� �������� (��� ��������������� ����, � ���������). }
   ['{DC345D60-7A9B-41C3-9C67-C1D0D065E6E6}']
   function GetTextPart(aIndex: Integer): Tl3PCharLenPrim;
     {* ���������� ����� ������ �� �������. }
 end;//Il3MultipartText

 Il3XMLWriter = interface(Il3Base)
  {* ��������� XML. }
   ['{045E85B3-BF7A-4A23-B51A-40D62463ECD2}']
   procedure PutData(const aString: AnsiString); overload; 
   procedure PutData(const aString: Il3CString); overload; 
   procedure PutData(const aString: Tl3WString); overload; 
   procedure OpenLevel(const aString: AnsiString); overload; 
     {* ��������� ����� ���. }
   procedure OpenLevel(const aString: AnsiString;
    const aSuffix: AnsiString); overload; 
     {* ��������� ����� ���. aSuffix - �������� ����. }
   procedure OpenSubLevel(const aSuffix: AnsiString = '');
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

 Il3AString = interface(Il3Base)
  {* ANSI-������. }
   ['{7D1E5ACA-59D7-4F51-BDE9-00D47573380C}']
   function S: PAnsiChar;
     {* ���������� ������. }
 end;//Il3AString

 Il3RangeManager = interface(Il3Base)
  {* �������� �������. }
   ['{F4BA4E32-1669-425F-91C5-CEF753EA52B0}']
   function Get_Count: Integer;
   function Get_Pages(anIndex: Integer): Integer;
   function Get_IndexOfPage(Page: Integer): Integer;
   function HasPage(anIndex: Integer): Boolean;
     {* �������� �� �������� ��������� ��������. }
   property Count: Integer
     read Get_Count;
     {* ���������� ������������� �������. }
   property Pages[anIndex: Integer]: Integer
     read Get_Pages;
   property IndexOfPage[Page: Integer]: Integer
     read Get_IndexOfPage;
     {* ����� ������������ � ������� ��������� ��������� ��������. }
 end;//Il3RangeManager

 TStrings = l3Core.TStrings;
  {* ������ �����. }

 hDC = l3Core.hDC;
  {* �������� ���������� ������. }

 Tl3PageOrientation = (
  {* ���������� ��������. }
   l3_poPortrait // �������.
 , l3_poLandscape // ���������.
 );//Tl3PageOrientation

 Il3Strings = interface(Il3Base)
  {* ������ �����. }
   ['{441A093F-AEB6-4A99-ADC7-473B3E7967B9}']
   function Get_Items: TStrings;
   property Items: TStrings
     read Get_Items;
     {* ������. }
 end;//Il3Strings

 Il3StringsEx = interface(Il3Strings)
  {* ������ �����. }
   ['{0D64840F-9658-471A-BF2A-2CB3DA6A95D2}']
   function Get_Count: Integer;
   function pm_GetSorted: Boolean;
   procedure pm_SetSorted(aValue: Boolean);
   function Get_Items: TStrings;
   procedure Set_Items(aValue: TStrings);
   function Get_Item(anIndex: Integer): AnsiString;
   procedure Set_Item(anIndex: Integer; const aValue: AnsiString);
   function Get_ItemC(anIndex: Integer): Il3CString;
   procedure Set_ItemC(anIndex: Integer; const aValue: Il3CString);
   function Get_Objects(anIndex: Integer): TObject;
   procedure Set_Objects(anIndex: Integer; aValue: TObject);
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
   property Count: Integer
     read Get_Count;
     {* ���������� ���������. }
   property Sorted: Boolean
     read pm_GetSorted
     write pm_SetSorted;
   property Items: TStrings
     read Get_Items
     write Set_Items;
     {* �������� ������. }
   property Item[anIndex: Integer]: AnsiString
     read Get_Item
     write Set_Item;
     {* �������� ������. }
   property ItemC[anIndex: Integer]: Il3CString
     read Get_ItemC
     write Set_ItemC;
     default;
     {* �������� ������. }
   property Objects[anIndex: Integer]: TObject
     read Get_Objects
     write Set_Objects;
     {* �������, ��������������� �� ��������. }
 end;//Il3StringsEx

 Tl3OrientationSet = set of Tl3Orientation;
  {* ��������� ���������� �������. }

 Tl3Orientation1 = ev_orHorizontal..ev_orVertical;
  {* ���������� �������. }

 Tl3Inch = Integer;
  {* ����. }

 Tl3_PointXY = packed record
   X : Tl3Inch;
   Y : Tl3Inch;
 end;//Tl3_PointXY

 Tl3InchOArray = array [Tl3Orientation1] of Tl3Inch;

 Tl3InchBArray = array [Boolean] of Tl3Inch;

 Tl3PointSF = packed record
   Start : Tl3Inch;
   Finish : Tl3Inch;
 end;//Tl3PointSF

 Tl3_PointUnion = packed record
  Case Byte of
   0: (X: Tl3Inch;
 Y: Tl3Inch;);
   1: (oPt: Tl3InchOArray);
   2: (bPt: Tl3InchBArray);
   3: (Start: Tl3Inch;
 Finish: Tl3Inch;);
   4: (Border: Tl3InchBArray);
 end;//Tl3_PointUnion

//#UC START# *46A480790259ci*
//#UC END# *46A480790259ci*
 Tl3_Point = packed {$IfDef XE4}record{$Else}object{$EndIf}
  {* ������� ����� � ������������ � ������ (������� ����������). }
 public
   P : Tl3_PointUnion;
 public
   property X: Tl3Inch 
     read P.X 
     write P.X;
   property Y: Tl3Inch 
     read P.Y 
     write P.Y;
   property Start: Tl3Inch 
     read P.Start 
     write P.Start;
   property Finish: Tl3Inch 
     read P.Finish 
     write P.Finish;

//#UC START# *46A480790259publ*
    public
    // public methods
      procedure Init(aX, aY: Tl3Inch);
        {* - �������������� �����. }
      function  IsNull: Boolean;
        {-}
      function Add(const Pt: Tl3_Point): Tl3_Point;
        {* - ���������� Self � P � ���������� ���������� ��������. }
      function Sub(const Pt: Tl3_Point): Tl3_Point;
        {* - �������� P �� Self � ���������� ���������� ��������. }
      function Mul(const Pt: Tl3_Point): Tl3_Point;
        {* - �������� Self �� P � ���������� ���������� ��������. }
      function Divide(const Pt: Tl3_Point): Tl3_Point;
      function EQ(const Pt: Tl3_Point): Boolean;
        {* - ��������� ��������� ���� �����. }
      function Neg: Tl3_Point;
        {* - ���������� ����� ���������� ����� ������ ���������. }
      function e(aVert: Boolean): Tl3_Point;
        {-}
      function eX: Tl3_Point;
        {* - ���������� ������ ������������ ��� X "������" Self.X. }
      function e_X: Tl3_Point;
        {* - ���������� ������ ������������ ��� X "������" -Self.X. }
      function eY: Tl3_Point;
        {* - ���������� ������ ������������ ��� Y "������" Self.Y. }
      function e_Y: Tl3_Point;
        {* - ���������� ������ ������������ ��� Y "������" -Self.Y. }
      function Zoom(Z: Integer): Tl3_Point;
        {* - ����������� ���������� ������� �� Z % � ���������� Result. }
      function Dezoom(Z: Integer): Tl3_Point;
        {* - ��������� ���������� ������� �� Z % � ���������� Result. }
      procedure MakeZoom(Z: Integer);
        {* - ����������� ���������� ������� �� Z %. }
//#UC END# *46A480790259publ*
 end;//Tl3_Point

 Tl3_RectLRTB = packed record
   Left : Tl3Inch;
   Top : Tl3Inch;
   Right : Tl3Inch;
   Bottom : Tl3Inch;
 end;//Tl3_RectLRTB

//#UC START# *46A4988D03E1ci*
  Tl3ConvertPointProc = function (const Pt: TPoint): TPoint of object;
    {* ��� �������� ��� ����������� �����. }

//#UC END# *46A4988D03E1ci*
 Tl3_SPoint = packed {$IfDef XE4}record{$Else}object{$EndIf}
  {* ������� ����� � ������������ � �������� (�� ������). }
 public
   P : Tl3_PointUnion;
 public
   property X: Tl3Inch 
     read P.X 
     write P.X;
   property Y: Tl3Inch 
     read P.Y 
     write P.Y;
   property Start: Tl3Inch 
     read P.Start 
     write P.Start;
   property Finish: Tl3Inch 
     read P.Finish 
     write P.Finish;

//#UC START# *46A4988D03E1publ*
    public
    // public methods
      procedure Init(aX, aY: Integer);
        {* - �������������� �����. }
      procedure Inc(const Pt: Tl3_SPoint);
        {* - ���������� Pt � Self. }
      procedure Dec(const Pt: Tl3_SPoint);
        {* - �������� Pt �� Self. }
      function  Add(const Pt: Tl3_SPoint): Tl3_SPoint;
        {* - ���������� Self � P � ���������� ���������� ��������. }
      function  Sub(const Pt: Tl3_SPoint): Tl3_SPoint;
        {* - �������� P �� Self � ���������� ���������� ��������. }
      function EQ(const Pt: Tl3_SPoint): Boolean;
        {* - ��������� ��������� ���� �����. }
      function  Neg: Tl3_SPoint;
        {* - ���������� ����� ���������� ����� ������ ���������. }
      function  GetCursorPos: Boolean;
        {* - �������������� ����� ��������� ������ ��������� ������� ����. }
      function  Zoom(Z: Integer): Tl3_SPoint;
        {* - ����������� ���������� ������� �� Z % � ���������� Result. }
      function  Dezoom(Z: Integer): Tl3_SPoint;
        {* - ��������� ���������� ������� �� Z % � ���������� Result. }
      procedure MakeZoom(Z: Integer);
        {* - ����������� ���������� ������� �� Z %. }
      procedure MakeDezoom(Z: Integer);
        {* - ��������� ���������� ������� �� Z %. }
      function  Convert(CP: Tl3ConvertPointProc): Tl3_SPoint;
        {* - ������������ ����� ���������� CP. }
//#UC END# *46A4988D03E1publ*
 end;//Tl3_SPoint

 Tl3_RectTB = packed record
   TopLeft : Tl3_Point;
   BottomRight : Tl3_Point;
 end;//Tl3_RectTB

 Tl3PointBArray = array [Boolean] of Tl3_Point;

 Tl3_RectUnion = packed record
  Case Byte of
   0: (Left: Tl3Inch;
 Top: Tl3Inch;
 Right: Tl3Inch;
 Bottom: Tl3Inch;);
   1: (TopLeft: Tl3_Point;
 BottomRight: Tl3_Point;);
   2: (bRt: Tl3PointBArray);
 end;//Tl3_RectUnion

//#UC START# *46A498630097ci*
//#UC END# *46A498630097ci*
 Tl3_Rect = packed {$IfDef XE4}record{$Else}object{$EndIf}
  {* �������������. }
 public
   R : Tl3_RectUnion;
 public
   property Left: Tl3Inch 
     read R.Left 
     write R.Left;
   property Top: Tl3Inch 
     read R.Top 
     write R.Top;
   property Right: Tl3Inch 
     read R.Right 
     write R.Right;
   property Bottom: Tl3Inch 
     read R.Bottom 
     write R.Bottom;
   property TopLeft: Tl3_Point 
     read R.TopLeft 
     write R.TopLeft;
   property BottomRight: Tl3_Point 
     read R.BottomRight 
     write R.BottomRight;

//#UC START# *46A498630097publ*
(*    protected
    // property methods
      function  pm_GetTopLeft: Tl3_Point;
      procedure pm_SetTopLeft(const aValue: Tl3_Point);
        {-}
      function  pm_GetBottomRight: Tl3_Point;
      procedure pm_SetBottomRight(const aValue: Tl3_Point);
        {-}*)
    public
    // public methods
      procedure Inflate(const Pt: Tl3_Point);
        overload;
        {* - ����������� ������� �������������� �� P. }
      procedure Inflate(X, Y: Tl3Inch);
        overload;
        {* - ����������� ������� �������������� �� (X, Y). }
      procedure OffsetPt(const Pt: Tl3_Point);
        {* - �������� ������������� �� Pt. }
      procedure Offset(aX, aY: Tl3Inch);
        {* - �������� ������������� �� (X, Y). }
      function  ContainsPt(const Pt: Tl3_Point): Boolean;
        {* - �������� �� ������������� ����� Pt? }
      function  EQ(const Rt: Tl3_Rect): Boolean;
        {* - ��������� ��������� ���� ���������������. }
      function  AddPt(const Pt: Tl3_Point): Tl3_Rect;
        {* - �������� ������������� �� Pt � ������� Result. }
      function  SubPt(const Pt: Tl3_Point): Tl3_Rect;
        {* - �������� ������������� �� -Pt � ������� Result. }
      function  IntersectsWith(const Rt: Tl3_Rect): Boolean;
        {* - ��������� ����������� Self � Rt. }
      procedure MakeZoom(Z: Integer);
        {* - ����������� ���������� ������� �� Z %. }
(*    public
    // public properties
      property TopLeft: Tl3_Point
        read pm_GetTopLeft
        write pm_SetTopLeft;
        {-}
      property BottomRight: Tl3_Point
        read pm_GetBottomRight
        write pm_SetBottomRight;
        {-}*)
//#UC END# *46A498630097publ*
 end;//Tl3_Rect

const
   { ��������� ���������. }
  piStart = 0;
   { ������ ��������� ����������. }
  piCurrent = 1;
   { ��������� �������� ��������� ����������. }
  piEnd = 2;
   { ����� ��������� ����������. }

type
 Il3Meter = interface(Il3Base)
  {* ��������� ��������� }
   ['{7316F1A5-5B0A-4793-8560-FFD42CACFC0E}']
   procedure ProgressProc(aState: Byte;
    aValue: Integer;
    const aMsg: Il3CString);
   procedure FreeNotification(AComponent: TComponent);
   procedure RemoveFreeNotification(AComponent: TComponent);
 end;//Il3Meter

 Il3SimpleView = interface(Il3Base)
   ['{585E7A21-799B-48F6-8B10-7D8183E33FDC}']
   procedure Update;
 end;//Il3SimpleView

 Il3Window = interface(Il3Base)
  {* ����. }
   ['{27655C1A-009A-4E6E-8CC5-CE9643692649}']
   procedure Invalidate;
     {* ������ �� �����������. }
 end;//Il3Window

 IStream = ActiveX.IStream;
  {* �����. }

 Il3TempStream = interface(Il3Base)
  {* ��������� ��������� ������. }
   ['{FC91E498-D4DF-4505-B934-A1FEEA2B9DEA}']
   function MakeForWrite(aNeedCompression: Boolean = true): IStream;
     {* ������� ����� ��� ������. }
   function MakeForRead: IStream;
     {* ������� ����� ��� ������. }
 end;//Il3TempStream

 Il3DropTarget = interface(Il3Base)
  {* ����� ���� ����� �������� ������. }
   ['{A3826B61-5116-41BE-BA79-CAD580E8C4B4}']
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
   Handled : Boolean;
   Result : LRESULT;
 end;//Tl3HookProcResult

 LPARAM = l3Core.LPARAM;

 WPARAM = l3Core.WPARAM;

 Il3Listener = interface(Il3Base)
   ['{73009AD0-0995-413A-A06F-07032D2AD3B0}']
 end;//Il3Listener

 Il3ToolOwner = interface(Il3Base)
  {* �������� ������������. }
   ['{C87DCBEF-76F2-4F61-80FB-5791B8D1DC72}']
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
   l3_cbUnchecked // �� ������.
 , l3_cbChecked // ������.
 , l3_cbGrayed // ��������.
 );//Tl3CheckBoxState

 Tl3ButtonState = (
  {* ��������� ������. }
   l3_bsUp // ������.
 , l3_bsDisabled // ���������.
 , l3_bsDown // ������.
 , l3_bsExclusive // <?> �������, ��� ���?
 );//Tl3ButtonState

 Tl3Alignment = (
  {* ������������. }
   l3_taLeftJustify // �����.
 , l3_taRightJustify // ������.
 , l3_taCenter // �� ������.
 );//Tl3Alignment

 Tl3ValueMapID = record
  {* ������������� ����. }
   rName : AnsiString; // ��� ��� ��������.
   rID : Integer; // ID �� �������� ���� ������.
 end;//Tl3ValueMapID

 Il3ValueMap = interface(Il3Base)
  {* ������ ��������� ��� ��� "������"-�����. }
   ['{5B5D3EFE-D0A8-4323-BC6B-E1279A72A52D}']
   function pm_GetMapID: Tl3ValueMapID;
   procedure GetDisplayNames(const aList: Il3StringsEx);
     {* ��������� ������ ���������� "UI-������" }
   function MapSize: Integer;
     {* ���������� ��������� � ����. }
   property MapID: Tl3ValueMapID
     read pm_GetMapID;
     {* ������������� ����. }
 end;//Il3ValueMap

 Il3StringValueMap = interface(Il3ValueMap)
  {* ���� "������"-"������" ��� ��������. }
   ['{65B88CA2-C2EF-4AD1-84DF-73CD3B8CF37A}']
   function DisplayNameToValue(const aDisplayName: Il3CString): Il3CString;
   function ValueToDisplayName(const aValue: Il3CString): Il3CString;
 end;//Il3StringValueMap

 Il3ValueMapFactory = interface(Il3Base)
  {* ������� �������� ��� ����-��������. }
   ['{904AEFAB-12FA-47E4-B505-B6BB95C673BA}']
   function MakeMap(const aID: Tl3ValueMapID): Il3ValueMap;
 end;//Il3ValueMapFactory

 Il3StringValueMapFactory = interface(Il3ValueMapFactory)
  {* ������� ��� Il3StringValueMap. }
   ['{09492F08-0ADB-4BFC-A3A5-4F77555FD733}']
 end;//Il3StringValueMapFactory

 Il3IntegerValueMap = interface(Il3ValueMap)
  {* ���� "������"-"�����" ��� ��������. }
   ['{26FF877A-B255-4722-A3D0-AAF7CC9C7491}']
   function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
   function ValueToDisplayName(aValue: Integer): Il3CString;
 end;//Il3IntegerValueMap

 Il3IntegerValueMapFactory = interface(Il3ValueMapFactory)
  {* ������� ��� Il3IntegerValueMap. }
   ['{13A3DAE0-4289-45A2-9542-F4045CE55909}']
 end;//Il3IntegerValueMapFactory

 Il3IntegerValueMapManager = interface(Il3Base)
  {* ��������� ��� Il3IntegerValueMap. }
   ['{9DBBA83D-4561-44D8-8663-63EE9125DE24}']
   function pm_GetMap(const aID: Tl3ValueMapID): Il3IntegerValueMap;
   procedure RegisterFactory(const aFactory: Il3IntegerValueMapFactory;
    aPreferred: Boolean);
     {* aPreferred - ������� ����� ���������� ��� ����� ������. }
   procedure UnRegisterFactory(const aFactory: Il3IntegerValueMapFactory);
   property Map[const aID: Tl3ValueMapID]: Il3IntegerValueMap
     read pm_GetMap;
     {* ���� �� ID. }
 end;//Il3IntegerValueMapManager

 Tl3LinePartDrawType = (
  {* ��� ����� �����. }
   lpdDraw // ����� �������� ������.
 , lpdSpecialDraw // ��������� ����� (������ ��� ����������� ������� ���������).
 , lpdHidden // ������ �� ����� �����������.
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
   rColor : Tl3Color;
   rWidth : Tl3Inch; // ������.
   rSpaceBefore : Tl3Inch; // ������ ��.
   rSpaceAfter : Tl3Inch; // ������ �����.
   rDrawType : Tl3LinePartDrawType; // ��� �����.
 end;//Tl3FramePart

 Tl3FramePartArray = array [Tl3FramePartIndex] of Tl3FramePart;
  {* ������ ��������� �����. }

 Il3Lines = interface(Il3Base)
  {* ������ �����. }
   ['{F96A93D1-3995-4C76-A5E0-35BA43D43D71}']
   function Get_Count: Integer;
   function AsObject: TObject;
   property Count: Integer
     read Get_Count;
 end;//Il3Lines

 Il3MultiLines = interface(Il3Base)
   ['{0D98A185-3E13-4C2F-BA52-31B2A80EBB01}']
   function IsSingle: Boolean;
   function HasBreakInWord: Boolean;
 end;//Il3MultiLines

 Il3List = interface(Il3Base)
  {* ������. }
   ['{ABBC1BC6-F386-4852-9F70-658316FC8BEC}']
   function pm_GetCount: Integer;
   procedure pm_SetCount(aValue: Integer);
   procedure Clear;
     {* �������� ������. }
   procedure Delete(anIndex: Integer);
     {* ������� ������� �� ������� Index. }
   property Count: Integer
     read pm_GetCount
     write pm_SetCount;
     {* ����� ��������� � ���������. }
 end;//Il3List

 Il3InterfaceList = interface(Il3List)
  {* ������ �����������. }
   ['{558A8787-D783-4C77-8E1D-D9B02138461F}']
   function Add(const anItem: IUnknown): Integer;
     {* ��������� �������. ���������� �� ������. }
   procedure Insert(anIndex: Integer;
    const anItem: IUnknown);
     {* ��������� ������� Item �� ������� Index. }
   procedure AssignList(const aList: Il3InterfaceList);
  // Ml3List
   function pm_GetEmpty: Boolean;
   function pm_GetFirst: IUnknown;
   function pm_GetLast: IUnknown;
   function pm_GetItems(anIndex: Integer): IUnknown;
   property Empty: Boolean
     read pm_GetEmpty;
   property First: IUnknown
     read pm_GetFirst;
     {* ������ �������. }
   property Last: IUnknown
     read pm_GetLast;
     {* ��������� �������. }
   property Items[anIndex: Integer]: IUnknown
     read pm_GetItems;
     default;
  // Ml3CountHolder
   function pm_GetCount: Integer;
   property Count: Integer
     read pm_GetCount;
     {* ����� ���������. }
 end;//Il3InterfaceList

 Tl3FontIndexes = set of Tl3FontIndex;
  {* ��������� �������� ������. }

 TFontName = l3Core.TFontName;
  {* ��������� ������. }

 TFontPitch = l3Core.TFontPitch;

 Il3FontInfo = interface(Il3Base)
  {* ���������� � ������. }
   ['{22CB828C-4170-4A1A-87DC-01FA0F1A621F}']
   function Get_Size: Integer;
   function Get_Bold: Boolean;
   function Get_Italic: Boolean;
   function Get_Underline: Boolean;
   function Get_Strikeout: Boolean;
   function Get_ForeColor: Tl3Color;
   function Get_BackColor: Tl3Color;
   function Get_Name: TFontName;
   function Get_Pitch: TFontPitch;
   function Get_Index: Tl3FontIndex;
   property Size: Integer
     read Get_Size;
     {* �����. }
   property Bold: Boolean
     read Get_Bold;
     {* ������? }
   property Italic: Boolean
     read Get_Italic;
     {* ������? }
   property Underline: Boolean
     read Get_Underline;
     {* ������������? }
   property Strikeout: Boolean
     read Get_Strikeout;
     {* �����������. }
   property ForeColor: Tl3Color
     read Get_ForeColor;
     {* ���� ������. }
   property BackColor: Tl3Color
     read Get_BackColor;
     {* ���� ����. }
   property Name: TFontName
     read Get_Name;
     {* ����������. }
   property Pitch: TFontPitch
     read Get_Pitch;
     {* �������. }
   property Index: Tl3FontIndex
     read Get_Index;
     {* ������. }
 end;//Il3FontInfo

 TFontStyles = l3Core.TFontStyles;

 Il3FontPrim = interface(Il3FontInfo)
  {* ����� �������. }
   ['{18B472EA-1D0E-42BD-8795-D26C26CB8B14}']
   function Get_ForeColor: Tl3Color;
   procedure Set_ForeColor(aValue: Tl3Color);
   function Get_BackColor: Tl3Color;
   procedure Set_BackColor(aValue: Tl3Color);
   function Get_Size: Integer;
   procedure Set_Size(aValue: Integer);
   function Get_Bold: Boolean;
   procedure Set_Bold(aValue: Boolean);
   function Get_Italic: Boolean;
   procedure Set_Italic(aValue: Boolean);
   function Get_Underline: Boolean;
   procedure Set_Underline(aValue: Boolean);
   function Get_Strikeout: Boolean;
   procedure Set_Strikeout(aValue: Boolean);
   function Get_Name: TFontName;
   procedure Set_Name(const aValue: TFontName);
   function Get_Pitch: TFontPitch;
   procedure Set_Pitch(aValue: TFontPitch);
   function Get_Index: Tl3FontIndex;
   procedure Set_Index(aValue: Tl3FontIndex);
   function Get_Style: TFontStyles;
   procedure Set_Style(aValue: TFontStyles);
   property ForeColor: Tl3Color
     read Get_ForeColor
     write Set_ForeColor;
     {* ���� ������. }
   property BackColor: Tl3Color
     read Get_BackColor
     write Set_BackColor;
     {* ���� ����. }
   property Size: Integer
     read Get_Size
     write Set_Size;
     {* ������ �����. }
   property Bold: Boolean
     read Get_Bold
     write Set_Bold;
     {* ������. }
   property Italic: Boolean
     read Get_Italic
     write Set_Italic;
     {* ������. }
   property Underline: Boolean
     read Get_Underline
     write Set_Underline;
     {* �������������. }
   property Strikeout: Boolean
     read Get_Strikeout
     write Set_Strikeout;
     {* ������������. }
   property Name: TFontName
     read Get_Name
     write Set_Name;
     {* ��� ������. }
   property Pitch: TFontPitch
     read Get_Pitch
     write Set_Pitch;
     {* �������. }
   property Index: Tl3FontIndex
     read Get_Index
     write Set_Index;
     {* ������ ������. }
   property Style: TFontStyles
     read Get_Style
     write Set_Style;
 end;//Il3FontPrim

 hFont = l3Core.hFont;

 TFont = l3Core.TFont;

 Il3FontMetrics = interface(Il3Base)
  {* ������� ������. }
   ['{D1251C22-1129-4298-A1D6-85E2084615E0}']
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
   wpAnyPathWord // � ����� ����� �����.
 , wpAtBeginWord // � ������ �����.
 , wpAtBeginString // � ������ ������.
 );//Tl3WordPosition

 Tl3WordOrder = (
  {* ������� ��������� ����. }
   woAnyOrder // � ����� �������.
 , woAsWrote // � ������ ������� ���������� ���������.
 );//Tl3WordOrder

 Tl3TreeLevelDist = (
  {* ������� ��� ������������� ��������. }
   tldAllLevels // �� ���� �������.
 , tldOneLevel // � �������� ������ ������.
 );//Tl3TreeLevelDist

 Tl3CStringArray = array of Il3CString;
  {* ������������ ������ �����. }

const
  { ��������� ��������. }
 CS_Ansi = Windows.ANSI_CHARSET;
 CS_OEM = Windows.OEM_CHARSET;
 CS_Default = DEFAULT_CHARSET;
 CS_Effective = RUSSIAN_CHARSET;
 CS_Russian = RUSSIAN_CHARSET;
  { ������� ��������. }
 CP_ANSI = Windows.CP_ACP;
  { ��������� �������������� ��������� ANSI. }
 CP_OEM = Windows.CP_OEMCP;
  { ��������� �������������� ��������� OEM. }
 CP_Unicode = -1;
  { ��������� �������������� ��������� Unicode. }
  { ������� ������ ������ ������. }
 CF_TEXT = Windows.CF_TEXT;
  { �����. }
 cf_OEMText = Windows.cf_OEMText;
  { OEM-�����. }
 CF_BITMAP = Windows.CF_BITMAP;
  { ��������. }
 CF_METAFILEPICT = Windows.CF_METAFILEPICT;
  { ��������. }
 CF_UNICODETEXT = Windows.CF_UNICODETEXT;
  { Unicode-�����. }
 CF_ENHMETAFILE = Windows.CF_ENHMETAFILE;
  { ����������� ��������. }
 CF_HDROP = Windows.CF_HDROP;
  { ������ drag'n'drop. }
  { �����. }
 l3_Point0 : Tl3_Point = (P: (X: 0; Y: 0));
  { ������ ���������. }
  { Key State Masks for Mouse Messages }
 MK_CONTROL = Windows.MK_CONTROL;
 MK_LButton = Windows.MK_LButton;
 MK_RBUTTON = Windows.MK_RBUTTON;
  { ���� ���������. }
 TYMED_NULL = ActiveX.TYMED_NULL;
 TYMED_HGLOBAL = ActiveX.TYMED_HGLOBAL;
 TYMED_ISTREAM = ActiveX.TYMED_ISTREAM;
 TYMED_GDI = ActiveX.TYMED_GDI;
 TYMED_MFPICT = ActiveX.TYMED_MFPICT;
  { DropEffects }
 DROPEFFECT_COPY = ActiveX.DROPEFFECT_COPY;
 DROPEFFECT_MOVE = ActiveX.DROPEFFECT_MOVE;
 DROPEFFECT_NONE = ActiveX.DROPEFFECT_NONE;
  { OleErrors }
 OLE_E_ADVISENOTSUPPORTED = Windows.OLE_E_ADVISENOTSUPPORTED;
 OLE_E_NotRunning = Windows.OLE_E_NOTRUNNING;
  { WindowsErrors }
 E_OutOfMemory = Windows.E_OUTOFMEMORY;
  { DragAndDropConstants }
 DRAGDROP_S_CANCEL = Windows.DRAGDROP_S_CANCEL;
 DRAGDROP_S_DROP = Windows.DRAGDROP_S_DROP;
 DRAGDROP_S_USEDEFAULTCURSORS = Windows.DRAGDROP_S_USEDEFAULTCURSORS;
 DATA_S_SAMEFORMATETC = Windows.DATA_S_SAMEFORMATETC;
  { DVConstants }
 DV_E_FORMATETC = Windows.DV_E_FORMATETC;
 DV_E_DVAspect = Windows.DV_E_DVASPECT;
 DV_E_LINDEX = Windows.DV_E_LINDEX;
  { ActiveXConstants }
 DATADIR_GET = ActiveX.DATADIR_GET;
 DVASPECT_CONTENT = ActiveX.DVASPECT_CONTENT;
  { WindowsConstants }
 GMEM_SHARE = Windows.GMEM_SHARE;
  { ������� �������������� �������. }
 nilObj : TObject = nil;
  { ������� ������� ������. }

type
 Tl3MemoryFlag = (
  {* ���� ������������� ������. }
   l3_mfNil // �� ������������.
 , l3_mfSmall // ������ 4-� ����.
 , l3_mfLocal // �������� �� GetMem.
 , l3_mfGlobal // �������� �� GlobalAlloc.
 );//Tl3MemoryFlag

 Tl3PtrRec = packed record
  Case Flag: Tl3MemoryFlag of
   l3_mfLocal: (Ptr: PAnsiChar);
   l3_mfGlobal: (H: THandle);
 end;//Tl3PtrRec

 Tl3PtrRecLen = packed record
  {* �������������� ������ � ���������� � ������. }
   S : Tl3PtrRec; // ������.
   SLen : Integer; // �����.
   SCodePage : SmallInt; // ������� ��������.
 end;//Tl3PtrRecLen

 Tl3WrappedWString = packed record
  {* ����������� ������. }
   Flag : Tl3MemoryFlag;
   WS : Tl3WString;
 end;//Tl3WrappedWString

 Tl3WStrCast = packed record
  Case Byte of
   0: (S: Tl3PtrRec;
 SLen: Integer;
 SCodePage: SmallInt;);
   1: (Flag: Tl3MemoryFlag;
 WS: Tl3WString;);
 end;//Tl3WStrCast

 Il3Console = interface(Il3Base)
  {* �������. }
   ['{78998D59-D791-4B3B-87A0-F58F71A161CC}']
   procedure Shift(aDelta: Integer);
     {* �������� ������ ������. }
   procedure Say(const aStr: Il3CString);
     {* ������� ������� �� �������. }
 end;//Il3Console

 Tl3Frame = record
  {* �����. }
   rRect : Tl3_Rect;
   rInfinite : Boolean;
   rP : Tl3FramePartArray; // �������� �����.
 end;//Tl3Frame

 Il3Font = interface(Il3FontPrim)
  {* ����� �������. }
   ['{2D98F431-0812-4E47-90C0-F526A4544716}']
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

 Tl3Index = 0..High(Integer);
  {* ������ ���������. }

 VCLBitmap = l3Core.VCLBitmap;
  {* ��������. }

 Tl3OperationCode = Cardinal;
  {* ������� ������������ ���������� � ���������� ������������ ��������� ShortCut-�� }

 IStorage = ActiveX.IStorage;

 Il3WordsSeq = interface(Il3Base)
  {* "������". }
   ['{F7F48D9A-CFAE-440C-87E7-258007F6C6CA}']
   function WordStart(Pos: Tl3Position): Tl3Position;
   function WordLeft(Pos: Tl3Position): Tl3Position;
   function WordFinish(Pos: Tl3Position): Tl3Position;
   function WordRight(Pos: Tl3Position): Tl3Position;
 end;//Il3WordsSeq

(*
 Ml3PageSetup = PureMixIn
  {* ���������� � �������� }
   function Get_Width: Tl3Inch;
   function Get_Height: Tl3Inch;
   function pm_GetPaperWidth: Tl3Inch;
   function pm_GetPaperHeight: Tl3Inch;
   function pm_GetMargins: Tl3_Rect;
   procedure pm_SetMargins(const aValue: Tl3_Rect);
   property Width: Tl3Inch
     read Get_Width;
     {* ������ ���������� �������. }
   property Height: Tl3Inch
     read Get_Height;
     {* ������ ���������� �������. }
   property PaperWidth: Tl3Inch
     read pm_GetPaperWidth;
     {* ������ ������. }
   property PaperHeight: Tl3Inch
     read pm_GetPaperHeight;
     {* ������ ������. }
   property Margins: Tl3_Rect
     read pm_GetMargins
     write pm_SetMargins;
     {* ���� �� ���� ����� (� ������ ������������ �������) }
 end;//Ml3PageSetup
*)

 WinBool = l3Core.WinBool;

 Il3Caret = interface(Il3Base)
   ['{D409967B-FA4F-4873-A088-68F330BB7487}']
   procedure Set_Extent(const aValue: TPoint);
   function Get_Position: Tl3_SPoint;
   procedure Set_Position(const aValue: Tl3_SPoint);
   function Get_Visible: Boolean;
   procedure pm_SetHidden(aValue: Boolean);
   function CheckHidden: Boolean;
   function CanHide: Boolean;
   property Extent: TPoint
     write Set_Extent;
   property Position: Tl3_SPoint
     read Get_Position
     write Set_Position;
   property Visible: Boolean
     read Get_Visible;
   property Hidden: Boolean
     write pm_SetHidden;
 end;//Il3Caret

 Il3ScrollCaret = interface(Il3Caret)
   ['{210DCE42-464B-41AC-8634-C559EEFF1BAF}']
   function IsInited: Boolean;
   function IsOnScreen: Boolean;
   procedure Scroll(const aOfs: Tl3_SPoint);
   procedure Reset;
 end;//Il3ScrollCaret

 Il3MemoryPool = interface(Il3Base)
  {* ����� ������. }
   ['{E197B378-25F6-4C94-8751-594C1F23CC5E}']
   function pm_GetSize: Integer;
   procedure pm_SetSize(aValue: Integer);
   property Size: Integer
     read pm_GetSize
     write pm_SetSize;
     {* ������� ������ ����� ������. }
 end;//Il3MemoryPool

 Il3HandleMemoryPool = interface(Il3MemoryPool)
  {* ����� ������ � Windows Handle. }
   ['{21932F64-424C-45E3-84B4-57EAEE9BEBFD}']
   function ReleaseHandle: THandle;
   function AsHandle: THandle;
     {* Windows Handle ����� ������. }
 end;//Il3HandleMemoryPool

 Il3StringValueMapManager = interface(Il3Base)
  {* ��������� ��� Il3StringValueMap. }
   ['{A3790411-6636-49FD-BB23-F3A51D8E285F}']
   function pm_GetMap(const aID: Tl3ValueMapID): Il3StringValueMap;
   procedure RegisterFactory(const aFactory: Il3StringValueMapFactory;
    aPreferred: Boolean);
     {* aPreferred - ������� ����� ���������� ��� ����� ������. }
   procedure UnRegisterFactory(const aFactory: Il3StringValueMapFactory);
   property Map[const aID: Tl3ValueMapID]: Il3StringValueMap
     read pm_GetMap;
     {* ���� �� �� ID. }
 end;//Il3StringValueMapManager

 Tl3CompareAction = function (I: Integer;
  J: Integer): Integer;

 PInteger = l3Core.PInteger;
  {* ��������� �� Integer. }

 Large = System.Int64;

 Il3Progress = interface(Il3Base)
  {* ��������� ��������. }
   ['{2FAC3F70-3190-4531-AD12-59AED4FCC444}']
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
   rPosition : Integer; // �������.
   rStyle : Tl3TabStopStyle; // �����.
   rFiller : Tl3WString; // ������-�����������.
 end;//Tl3TabStop

 Il3TabStops = interface(Il3Base)
  {* ������� ���������. }
   ['{9ED8F485-F1D5-487F-BED0-45D88650C9DA}']
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

 Il3ProgressSource = interface(Il3Base)
   ['{4EF88DA7-9EC2-421C-87F6-48E25E431D24}']
   function pm_GetProgress: Il3Progress;
   procedure pm_SetProgress(const aValue: Il3Progress);
   property Progress: Il3Progress
     read pm_GetProgress
     write pm_SetProgress;
 end;//Il3ProgressSource

 Il3DocIDSource = interface(Il3Base)
   ['{14CF52C1-C1AE-4026-9CAE-521101DE75AD}']
   function pm_GetDocID: Integer;
   procedure pm_SetDocID(aValue: Integer);
   property DocID: Integer
     read pm_GetDocID
     write pm_SetDocID;
 end;//Il3DocIDSource

 Il3TabInfo = interface(Il3Base)
  {* ���������� � ������� ��������� ���������. }
   ['{E41104DF-0DB6-4549-97C2-E616448B0B89}']
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

 Il3Rollback = interface(Il3Base)
  {* ������, ������� ���������� ������ }
   ['{B56D6AC5-3571-4537-AC3A-00D75CAED26F}']
   procedure Rollback;
     {* �������� ������ }
 end;//Il3Rollback

 Il3PageSetup = interface(Il3Base)
  {* ���������� � �������� }
   ['{2EA07723-49C9-4B22-BB90-074922621863}']
  // Ml3PageSetup
   function Get_Width: Tl3Inch;
   function Get_Height: Tl3Inch;
   function pm_GetPaperWidth: Tl3Inch;
   function pm_GetPaperHeight: Tl3Inch;
   function pm_GetMargins: Tl3_Rect;
   procedure pm_SetMargins(const aValue: Tl3_Rect);
   property Width: Tl3Inch
     read Get_Width;
     {* ������ ���������� �������. }
   property Height: Tl3Inch
     read Get_Height;
     {* ������ ���������� �������. }
   property PaperWidth: Tl3Inch
     read pm_GetPaperWidth;
     {* ������ ������. }
   property PaperHeight: Tl3Inch
     read pm_GetPaperHeight;
     {* ������ ������. }
   property Margins: Tl3_Rect
     read pm_GetMargins
     write pm_SetMargins;
     {* ���� �� ���� ����� (� ������ ������������ �������) }
 end;//Il3PageSetup

 Tl3StringID = object
 public
   rS : Integer;
 end;//Tl3StringID

 Pl3StringID = ^Tl3StringID;

 Il3ApplicationL10NStrings = interface(Il3Base)
  {* ������������ ������ ���������� }
   ['{717BCF75-F56A-4C93-8B05-DC8F9CAC81B6}']
   procedure Define(const aName: AnsiString;
    const aRus: AnsiString;
    const anAlien: AnsiString);
 end;//Il3ApplicationL10NStrings

 Il3IntegerList = interface(Il3Base)
  {* ������ ����� ����� }
   ['{0E167E1A-02B0-4F81-89D8-F97F8B3DB38A}']
  // Ml3List
   function pm_GetEmpty: Boolean;
   function pm_GetFirst: Integer;
   function pm_GetLast: Integer;
   function pm_GetItems(anIndex: Integer): Integer;
   property Empty: Boolean
     read pm_GetEmpty;
   property First: Integer
     read pm_GetFirst;
     {* ������ �������. }
   property Last: Integer
     read pm_GetLast;
     {* ��������� �������. }
   property Items[anIndex: Integer]: Integer
     read pm_GetItems;
     default;
  // Ml3CountHolder
   function pm_GetCount: Integer;
   property Count: Integer
     read pm_GetCount;
     {* ����� ���������. }
 end;//Il3IntegerList

 Pl3WString = ^Tl3WString;

 Il3GetMessageListener = interface(Il3Listener)
   ['{BBFB4E66-A01B-449B-B2CF-BE82E016E2F7}']
   procedure GetMessageListenerNotify(Code: Integer;
     aWParam: WPARAM;
     Msg: PMsg;
     var theResult: Tl3HookProcResult);
 end;//Il3GetMessageListener

 Il3WndProcRetListener = interface(Il3Listener)
   ['{A9039EC6-7C9C-43EC-884C-C9F9E32182EB}']
   procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
     var theResult: Tl3HookProcResult);
 end;//Il3WndProcRetListener

 Il3MouseListener = interface(Il3Listener)
   ['{2345687C-7F80-480E-9801-6A7279F6FE52}']
   procedure MouseListenerNotify(aMouseMessage: WPARAM;
     aHookStruct: PMouseHookStruct;
     var theResult: Tl3HookProcResult);
 end;//Il3MouseListener

 Il3WndProcListener = interface(Il3Listener)
  {* ���������, ���������� ����������� � ����������� ��������� � ��������� ���� ����������. }
   ['{0F4402A7-7507-46D0-BD65-21526DD10A54}']
   procedure WndProcListenerNotify(Msg: PCWPStruct;
     var theResult: Tl3HookProcResult);
 end;//Il3WndProcListener

 Il3MouseWheelListener = interface(Il3Listener)
   ['{AF4CDF98-292C-4FB2-9CE9-B26773539917}']
   procedure MouseWheelListenerNotify(Msg: PMsg;
     var theResult: Tl3HookProcResult);
 end;//Il3MouseWheelListener

 Il3CBTListener = interface(Il3Listener)
   ['{C2ED0EC7-EE30-49D4-846E-BA6FC7E41481}']
   procedure CBTListenerNotify(Code: Integer;
     WParam: WPARAM;
     LParam: LPARAM;
     var theResult: Tl3HookProcResult);
 end;//Il3CBTListener

 Tl3Point = Tl3_Point;

 Tl3Rect = Tl3_Rect;

 Tl3SPoint = Tl3_SPoint;


function Tl3_Point_C(aX: Integer;
    aY: Integer): Tl3_Point;

function Tl3_SPoint_C(anX: Integer;
     anY: Integer): Tl3_SPoint;

implementation

uses
  l3Math,
  l3MinMax
  ;


function Tl3_Point_C(aX: Integer;
      aY: Integer): Tl3_Point;
//#UC START# *47E0FA3E03CA_46A480790259_var*
//#UC END# *47E0FA3E03CA_46A480790259_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *47E0FA3E03CA_46A480790259_impl*
 Result.X := aX;
 Result.Y := aY;
//#UC END# *47E0FA3E03CA_46A480790259_impl*
end;//Tl3_Point.C


//#UC START# *46A480790259impl*
// start object Tl3_Point

procedure Tl3_Point.Init(aX, aY: Integer);
  {-�������������� �����}
begin
 P.X := aX;
 P.Y := aY;
end;

function Tl3_Point.IsNull: Boolean;
  {-}
begin
 Result := (P.X = 0) AND (P.Y = 0);
end;

function Tl3_Point.Add(const Pt: Tl3_Point): Tl3_Point;
  {-���������� Self � P}
begin
 Result.P.X := P.X + Pt.P.X;
 Result.P.Y := P.Y + Pt.P.Y;
end;

function Tl3_Point.Sub(const Pt: Tl3_Point): Tl3_Point;
  {-�������� P �� Self � ���������� ���������� ��������}
begin
 Result.P.X := P.X - Pt.P.X;
 Result.P.Y := P.Y - Pt.P.Y;
end;

function Tl3_Point.Mul(const Pt: Tl3_Point): Tl3_Point;
  {-�������� Self �� P � ���������� ���������� ��������}
begin
 Result.Init(P.X * Pt.P.X, P.Y * Pt.P.Y);
end;

function Tl3_Point.Divide(const Pt: Tl3_Point): Tl3_Point;
begin
 Result.Init(P.X div Pt.P.X, P.Y div Pt.P.Y);
end;

function Tl3_Point.EQ(const Pt: Tl3_Point): Boolean;
  {-��������� ��������� ���� �����}
begin
 Result := (P.X = Pt.P.X) AND (P.Y = Pt.P.Y);
end;

function Tl3_Point.Neg: Tl3_Point;
  {-���������� ����� ���������� ����� ������ ���������}
begin
 Result.Init(-P.X, -P.Y);
end;

function Tl3_Point.e(aVert: Boolean): Tl3_Point;
  {-}
begin
 Result.P.bPt[aVert] := P.bPt[aVert];
 Result.P.bPt[not aVert] := 0;
end;
  
function Tl3_Point.eX: Tl3_Point;
  {-���������� ������ ������������ ��� X "������" Self.X}
begin
 Result.Init(P.X, 0);
end;

function Tl3_Point.e_X: Tl3_Point;
  {-���������� ������ ������������ ��� X "������" -Self.X}
begin
 Result.Init(-P.X, 0);
end;

function Tl3_Point.eY: Tl3_Point;
  {-���������� ������ ������������ ��� X "������" Self.Y}
begin
 Result.Init(0, P.Y);
end;

function Tl3_Point.e_Y: Tl3_Point;
  {-���������� ������ ������������ ��� X "������" -Self.Y}
begin
 Result.Init(0, -P.Y);
end;

function evZoom(Zoom: Integer; Value: Integer): Integer;
begin
 if (Zoom <> 100) then
  Result := l3MulDiv(Value, Zoom, 100)
 else
  Result := Value;
end;

function evDezoom(Zoom: Integer; Value: Integer): Integer;
begin
 if (Zoom <> 100) AND (Zoom > 0) then
  Result := l3MulDiv(Value, 100, Zoom)
 else
  Result := Value;
end;

function Tl3_Point.Zoom(Z: Integer): Tl3_Point;
  {-����������� ���������� ������� �� Z % � ���������� Result}
begin
 Result.Init(evZoom(Z, P.X), evZoom(Z, P.Y));
end;

function Tl3_Point.Dezoom(Z: Integer): Tl3_Point;
  {-��������� ���������� ������� �� Z % � ���������� Result}
begin
 Result.Init(evDezoom(Z, P.X), evDezoom(Z, P.Y));
end;

procedure Tl3_Point.MakeZoom(Z: Integer);
  {-����������� ���������� ������� �� Z %}
begin
 P.X := evZoom(Z, P.X);
 P.Y := evZoom(Z, P.Y);
end;
//#UC END# *46A480790259impl*

function Tl3_SPoint_C(anX: Integer;
       anY: Integer): Tl3_SPoint;
//#UC START# *537B842903A3_46A4988D03E1_var*
//#UC END# *537B842903A3_46A4988D03E1_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *537B842903A3_46A4988D03E1_impl*
 Result.X := anX;
 Result.Y := anY;
//#UC END# *537B842903A3_46A4988D03E1_impl*
end;//Tl3_SPoint.C


//#UC START# *46A4988D03E1impl*
// start object Tl3_SPoint

procedure Tl3_SPoint.Init(aX, aY: Integer);
  {-�������������� �����}
begin
 P.X := aX;
 P.Y := aY;
end;

procedure Tl3_SPoint.Inc(const Pt: Tl3_SPoint);
  {-���������� Pt � Self}
begin
 System.Inc(P.X, Pt.P.X);
 System.Inc(P.Y, Pt.P.Y);
end;

procedure Tl3_SPoint.Dec(const Pt: Tl3_SPoint);
  {-�������� Pt �� Self}
begin
 System.Dec(P.X, Pt.P.X);
 System.Dec(P.Y, Pt.P.Y);
end;

function Tl3_SPoint.Add(const Pt: Tl3_SPoint): Tl3_SPoint;
  {-���������� Self � P � ���������� ���������� ��������}
begin
 if (P.X = High(P.X)) then
  Result.P.X := P.X
 else
  Result.P.X := P.X + Pt.P.X;
 if (P.Y = High(P.Y)) then
  Result.P.Y := P.Y
 else
  Result.P.Y := P.Y + Pt.P.Y;
end;

function Tl3_SPoint.Sub(const Pt: Tl3_SPoint): Tl3_SPoint;
  {-�������� P �� Self � ���������� ���������� ��������}
begin
 Result.P.X := P.X - Pt.P.X;
 Result.P.Y := P.Y - Pt.P.Y;
end;

function Tl3_SPoint.EQ(const Pt: Tl3_SPoint): Boolean;
  {-��������� ��������� ���� �����}
begin
 Result := (P.X = Pt.P.X) AND (P.Y = Pt.P.Y);
end;

function Tl3_SPoint.Neg: Tl3_SPoint;
  {-���������� ����� ���������� ����� ������ ���������}
begin
 Result.P.X := -P.X;
 Result.P.Y := -P.Y;
end;

function Tl3_SPoint.GetCursorPos: Boolean;
  {-�������������� ����� ��������� ������ ��������� ������� ����}
var
 WP : TPoint;
begin
 Windows.GetCursorPos(WP);
 Self := Tl3_SPoint_C(WP.X, WP.Y);
 Result := true;
end;

function Tl3_SPoint.Zoom(Z: Integer): Tl3_SPoint;
  {-����������� ���������� ������� �� Z % � ���������� Result}
begin
 Result.Init(evZoom(Z, P.X), evZoom(Z, P.Y));
end;

function Tl3_SPoint.Dezoom(Z: Integer): Tl3_SPoint;
  {-��������� ���������� ������� �� Z % � ���������� Result}
begin
 Result.Init(evDezoom(Z, P.X), evDezoom(Z, P.Y));
end;

procedure Tl3_SPoint.MakeZoom(Z: Integer);
  {-����������� ���������� ������� �� Z %}
begin
 P.X := evZoom(Z, P.X);
 P.Y := evZoom(Z, P.Y);
end;

procedure Tl3_SPoint.MakeDezoom(Z: Integer);
  {-��������� ���������� ������� �� Z %}
begin
 P.X := evDezoom(Z, P.X);
 P.Y := evDezoom(Z, P.Y);
end;

function Tl3_SPoint.Convert(CP: Tl3ConvertPointProc): Tl3_SPoint;
  {-������������ ����� ���������� CP}
begin
 with CP(TPoint(Self)) do
  Self := Tl3_SPoint_C(X, Y);
 Result := Self;
end;
//#UC END# *46A4988D03E1impl*

//#UC START# *46A498630097impl*
// start object Tl3_Rect

procedure Tl3_Rect.Inflate(const Pt: Tl3_Point);
  {overload;}
  {-����������� ������� �������������� �� P}
begin
 TopLeft := Tl3_Point(R.TopLeft).Sub(Pt);
 BottomRight := Tl3_Point(R.BottomRight).Add(Pt);
end;

procedure Tl3_Rect.Inflate(X, Y: Integer);
  {overload;}
  {-����������� ������� �������������� �� (X, Y)}
begin
 Dec(R.Left, X);
 Inc(R.Right, X);
 Dec(R.Top, Y);
 Inc(R.Bottom, Y);
end;

procedure Tl3_Rect.OffsetPt(const Pt: Tl3_Point);
  {-�������� ������������� �� Pt}
begin
 TopLeft := Tl3_Point(R.TopLeft).Add(Pt);
 BottomRight := Tl3_Point(R.BottomRight).Add(Pt);
end;

procedure Tl3_Rect.Offset(aX, aY: Integer);
  {-�������� ������������� �� (X, Y)}
begin
 Inc(R.Top, aY);
 Inc(R.Bottom, aY);
 Inc(R.Left, aX);
 Inc(R.Right, aX);
end;

function Tl3_Rect.ContainsPt(const Pt: Tl3_Point): Boolean;
  {-�������� �� ������������� ����� Pt}
begin
 with Pt do
  Result := ((P.X >= R.Left) AND (P.Y >= R.Top)) AND ((P.X < R.Right) AND (P.Y < R.Bottom));
end;

function Tl3_Rect.EQ(const Rt: Tl3_Rect): Boolean;
  {-��������� ��������� ���� ���������������}
begin
 Result := Tl3_Point(R.TopLeft).EQ(Rt.R.TopLeft) AND Tl3_Point(R.BottomRight).EQ(Rt.R.BottomRight);
end;

function Tl3_Rect.AddPt(const Pt: Tl3_Point): Tl3_Rect;
  {-�������� ������������� �� Pt � ������� Result}
begin
 Result.R.Left := R.Left + Pt.P.X;
 Result.R.Right := R.Right + Pt.P.X;
 Result.R.Top := R.Top + Pt.P.Y;
 if R.Bottom = High(MaxInt) then
  Result.R.Bottom := High(Integer)
 else 
  Result.R.Bottom := R.Bottom + Pt.P.Y;
end;

function Tl3_Rect.SubPt(const Pt: Tl3_Point): Tl3_Rect;
  {-�������� ������������� �� -Pt � ������� Result}
begin
 Result.R.Left := R.Left - Pt.P.X;
 Result.R.Right := R.Right - Pt.P.X;
 Result.R.Top := R.Top - Pt.P.Y;
 Result.R.Bottom := R.Bottom - Pt.P.Y;
end;

function evIntersectRect(var DR: Tl3Rect; const SR1, SR2: Tl3Rect): Boolean;
begin
 with DR do
 begin
  R.Top := Max(SR1.R.Top, SR2.R.Top);
  R.Bottom := Min(SR1.R.Bottom, SR2.R.Bottom);
  Result := (R.Top < R.Bottom);
  if Result then
  begin
   R.Left := Max(SR1.R.Left, SR2.R.Left);
   R.Right := Min(SR1.R.Right, SR2.R.Right);
   Result := (R.Left < R.Right);
  end;//Result
  if not Result then
   FillChar(DR, SizeOf(DR), 0);
 end;//with DR
end;

function Tl3_Rect.IntersectsWith(const Rt: Tl3_Rect): Boolean;
  {-��������� ����������� Self � Rt}
var
 OutR : Tl3_Rect;
begin
 Result := evIntersectRect(OutR, Self, Tl3_Rect(Rt));
end;

(*function Tl3_Rect.pm_GetTopLeft: Tl3_Point;
  {-}
begin
 Result := Tl3_Point(R.TopLeft);
end;

procedure Tl3_Rect.pm_SetTopLeft(const aValue: Tl3_Point);
  {-}
begin
 R.TopLeft := aValue;
end;

function Tl3_Rect.pm_GetBottomRight: Tl3_Point;
  {-}
begin
 Result := Tl3_Point(R.BottomRight);
end;

procedure Tl3_Rect.pm_SetBottomRight(const aValue: Tl3_Point);
  {-}
begin
 R.BottomRight := aValue;
end;*)

procedure Tl3_Rect.MakeZoom(Z: Integer);
begin
 Top := evZoom(Z, Top);
 Left := evZoom(Z, Left);
 Right := evZoom(Z, Right);
 Bottom := evZoom(Z, Bottom);
end;
//#UC END# *46A498630097impl*
end.