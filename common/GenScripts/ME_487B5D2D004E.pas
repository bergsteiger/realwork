unit evCursorController;

interface

uses
 l3IntfUses
 , l3_Base
 , nevTools
 , l3Variant
 , nevBase
 , l3IID
;

type
 TevCursorController = class(Tl3_Base, InevSelection, InevPointListener)
  {* ������ �� ��������. }
  procedure ForceStore;
  function DoGetBlock(const aDocument: InevObject): InevRange;
  procedure Create(const aView: InevInputView);
  function GetIsMulti: Boolean;
  function DoAddBlock(const aStart: InevBasePoint;
   const aFinish: InevBasePoint): Boolean;
  function GetContains(const C: InevBasePoint): Boolean;
  procedure DoCursorChanged(const aCursor: InevBasePoint);
  procedure DoAssignSel(const aView: InevView;
   const aSource: InevRange;
   AllowAddToMulti: Boolean);
  function Processor: InevProcessor;
  function DocumentPara: InevObject;
  procedure Lock;
   {* ��������� ����������� �� ���������� }
  procedure Unlock;
   {* ��������� ����������� �� ���������� }
  procedure DoSetDocument(aValue: Tl3Tag);
  function NeedUnselectOnSelectPoint(const aPoint: InevBasePoint): Boolean;
   {* ����� �� ���������� ��������� � SelectPoint }
  function DoUnselect: Boolean;
   {* ����� ��������� }
  procedure FreeCursor(var C: InevLinkedPoint); overload;
  procedure FreeCursor(var C: InevPoint); overload;
  function CheckCursor(var C: InevLinkedPoint): InevLinkedPoint; overload;
  function CheckCursor(var C: InevPoint): InevPoint; overload;
  function CheckCursor: InevLinkedPoint; overload;
  procedure LinkView(const aView: InevInputView);
  procedure FreeCursor(var C: InevBasePoint); overload;
  function Point: InevLinkedPoint;
  function IsMulti: Boolean;
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
  procedure CursorChanged(const aCursor: InevBasePoint);
   {* ������ aCursor ���������. }
  procedure ParaChanged(const aCursor: InevBasePoint);
   {* ������� �������� ���������. }
  function View: InevView;
 end;//TevCursorController
 
implementation

uses
 l3ImplUses
 , k2Base
 , evMsgCode
 , evOp
 , k2TagGen
 , l3InternalInterfaces
 , evDocumentPartGenerator
 , SysUtils
 , nevNavigation
 , l3InterfacesMisc
 , evdStyles
 , LeafPara_Const
 , k2Tags
 , evParaTools
;

end.
