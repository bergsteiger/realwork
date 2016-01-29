unit evCursor;

interface

uses
 l3IntfUses
 , nevTools
 , nevBase
 , l3Core
;

type
 TevCursor = class(_evCursor_, InevPoint, InevBasePoint)
  {* ������ }
  procedure DoCorrectMoveRight(const aView: InevView;
   const aPoint: InevBasePoint;
   const anOp: InevOp);
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
  function InnerFor(const aChild: InevObject;
   var aRealTop: InevBasePoint): InevBasePoint;
  function AfterEnd: Boolean;
  function AsLeaf: InevLeafPoint;
  function LinkedPoint: InevLinkedPoint;
  function AtEnd(const aView: InevView): Boolean;
  function AtStart: Boolean;
  function HasInner: Boolean;
   {* ���� �� �������� ����� }
  function ShowCollapsed: Boolean;
  function Compare(const aPoint: InevBasePoint): Integer;
  procedure CheckPos(const anOp: InevOp);
   {* ����������� �� ���������������� ������� ������� � ��������� ���������. �������� ������� }
  function ReadOnly: Boolean;
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
 end;//TevCursor
 
implementation

uses
 l3ImplUses
 , evOp
 , k2Base
 , l3InterfacesMisc
 , SysUtils
 , k2Tags
 , evdTypes
 , k2Const
;

end.
