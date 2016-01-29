unit nevTableRowBaseLineCommon.imp;

interface

uses
 l3IntfUses
 , nevTools
 , nevBasePointList
 , l3Variant
 , nevBase
 , l3Core
;

type
 _nevTableRowBaseLineCommon_ = class(_nevPrimPoint_, InevPoint, InevBasePoint)
  {* ����� ������ ��� ������� ����� }
  procedure InitHeadCells(const aView: InevView);
   {* �������������� ����� � ������������� �������� ��� ������� ������. }
  function GetCurrentPostion(const aView: InevView;
   aTableFI: TnevFormatInfoPrim;
   const anObject: InevObject): InevBasePoint;
   {* ������������� ����� ��� ����������� ������ � f_HeadCellList }
  function SimpleMode: Boolean;
  function GetInner4SimpleMode: InevBasePoint;
  function IsAnchor: Boolean;
  function InternalClonePoint(const aView: InevView;
   const aPoint: InevBasePoint): InevBasePoint;
  procedure Create(aRow: Tl3Variant);
  procedure DoSetInner(const aValue: InevBasePoint);
  procedure DoBottom(const aView: InevView);
  function DoIncLine(const aView: InevView;
   var theLine: Integer;
   aByLine: Boolean): Integer;
  procedure DoMergeTo(const aView: InevView;
   const aBaseLine: InevBasePoint);
  function DoInnerTop(const aChild: InevObject): InevBasePoint;
  procedure DoAddInner(const aView: InevView;
   const anInner: InevBaseLine4Anchor;
   anIndex: Integer;
   var aFirst: Boolean;
   aMode: TnevAddInnerMode);
  procedure DoCompareWithOtherInner(const aView: InevView;
   anMaxID: Integer);
  procedure DoInitBaseLineInner(const aView: InevView;
   const anItem: InevPara);
  procedure DoInitByCursor(const aView: InevView;
   const anInnerPoint: InevBasePoint);
  procedure DoCopyHeadParts(const aFrom: InevBasePoint);
  procedure DoAddHeadInner(const aHeadInner: InevBasePoint);
  function DoHasHeadPart: Boolean;
  function DoInnerHead(aPID: Integer): InevBasePoint;
  function DoDiff(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Integer;
  function CheckMaxID(aMaxID: Integer): InevBasePoint;
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
  procedure AssignPoint(const aView: InevView;
   const aPoint: InevBasePoint);
  procedure Bottom(const aView: InevView);
  function IncLine(const aView: InevView;
   var theLine: Integer;
   aByLine: Boolean): Integer;
   {* �������� ����� �� ��������� ����� �����. ���������� ���������� ���������� �� ������� ��������� �����. }
  function InnerFor(const aChild: InevObject;
   var aRealTop: InevBasePoint): InevBasePoint;
  function AfterEnd: Boolean;
  function AsLeaf: InevLeafPoint;
  function LinkedPoint: InevLinkedPoint;
  function AtEnd(const aView: InevView): Boolean;
  function AtStart: Boolean;
  function Diff(const aView: InevView;
   const aPoint: InevBasePoint;
   aMap: TnevFormatInfoPrim): Integer;
   {* ���������� ������ � "������" �� ���������. }
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
  function PartiallyVisible(const aView: InevView;
   const aPoint: InevBasePoint;
   const aMap: TnevFormatInfoPrim): Boolean;
   {* ���������� ����� �� ����� "�������� �������" ������������ ������ ����� (aPoint). ������� ��� ����������� ��������� ��������� ������ ������������ �����. }
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
 end;//_nevTableRowBaseLineCommon_
 
implementation

uses
 l3ImplUses
 , evdTypes
 , k2Tags
 , l3Base
 , evTableCellUtils
 , SysUtils
;

end.
