unit nevAnchor;

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
 , l3Variant
 , l3Core
;

type
 TnevAnchor = class(_nevAnchor_, InevBasePoint, InevAnchor)
  {* ����� ��� ������������ ��������� }
  function Make(aTag: Tl3Variant): InevAnchor;
  function GetAtStart: Boolean;
  function GetAtEnd(const aView: InevView): Boolean;
  function GetAsLeaf: InevLeafPoint;
  function GetPosition: TnevPosition;
  function GetVertPosition(const aView: InevView;
   aMap: TnevFormatInfoPrim): TnevParaIndex;
  function GetInner: InevBasePoint;
  procedure SetInner(const aValue: InevBasePoint);
  function GetInnerFor(const aChild: InevObject;
   var aRealTop: InevBasePoint): InevBasePoint;
  function DoHasBaseLine: Boolean;
  function DoGetInnerForChildThatNotAfterEnd(aFI: TnevFormatInfoPrim;
   aForDrawing: TnevInnerType): InevBasePoint;
  function GetInnerTop(const aChild: InevObject): InevBasePoint;
  procedure DoAssignPoint(const aView: InevView;
   const aPoint: InevBasePoint);
  procedure DoAddInner(const aView: InevView;
   const anInner: InevBaseLine4Anchor;
   anIndex: Integer;
   var aFirst: Boolean;
   aMode: TnevAddInnerMode);
  procedure DoCompareWithOtherInner(const aView: InevView;
   anMaxID: Integer);
  procedure DoInitByCursor(const aView: InevView;
   const anInnerPoint: InevBasePoint);
   {* �������������� ������� ����� �� �������. }
  function Range: InevRange;
  function Formatting: InevDataFormatting;
  function VertPosition(const aView: InevView;
   aMap: TnevFormatInfoPrim): TnevParaIndex;
  function NeedWindowsCaret: Boolean;
  function ClonePoint(const aView: InevView): InevBasePoint;
  function DeltaX(const aView: InevView;
   const aMap: InevMap): Integer;
  function Inner: InevBasePoint;
   {* �������� "�����". ������������ ������� - ������ ��������� ������� }
  function Position: TnevPosition;
   {* �������. }
  function LinkListener(const aView: InevScrollListener): InevScrollListener;
  procedure UnlinkListener(const aControl: InevScrollListener);
  procedure AssignPoint(const aView: InevView;
   const aPoint: InevBasePoint);
  function InnerFor(const aChild: InevObject;
   var aRealTop: InevBasePoint): InevBasePoint;
  function AfterEnd: Boolean;
  function AsLeaf: InevLeafPoint;
  function AtEnd(const aView: InevView): Boolean;
  function AtStart: Boolean;
  function Text: InevText;
  procedure DisableListener;
   {* ��������� ����������� �� ��������� }
  procedure EnableListener;
   {* �������� ����������� �� ��������� }
  function HasInner: Boolean;
   {* ���� �� �������� ����� }
  function ShowCollapsed: Boolean;
  function Compare(const aPoint: InevBasePoint): Integer;
  procedure CheckPos(const anOp: InevOp);
   {* ����������� �� ���������������� ������� ������� � ��������� ���������. �������� ������� }
  function ReadOnly: Boolean;
  function AsPoint: InevBasePoint;
  function AsCursor(const aView: InevView): InevPoint;
  function MarkersSource: IevMarkersSource;
   {* �������� ���������� � "��������" (� ��������� ��� �������) }
  function ProcessMessage(const aView: InevControlView;
   var aMessage: TMessage;
   aTime: Cardinal): Boolean;
  function Listener: InevPointListener;
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
  function BeforeStart: Boolean;
  procedure CorrectMoveRight(const aView: InevView;
   const aPoint: InevBasePoint;
   const anOp: InevOp);
 end;//TnevAnchor
 
implementation

uses
 l3ImplUses
 , afwInterfaces
 , k2Tags
 , SysUtils
;

end.
