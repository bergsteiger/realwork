unit evDocumentPartHotSpotTester;

interface

uses
 l3IntfUses
 , evParaListHotSpotTester
 , nevGUIInterfaces
 , l3Interfaces
 , nevTools
 , afwInterfaces
 , l3Units
 , evInternalInterfaces
 , l3IID
;

type
 TevDocumentPartHotSpotTester = class(TevParaListHotSpotTester, IevAdvancedHotSpot)
  {* ��������� ���������� IevHotSpotTester � IevHotSpot ��� ����� ���������. }
  procedure CheckSub;
  function GetName: Il3CString;
  function GetHintPrefix(const aState: TafwCursorState): Il3CString;
  function DoDrop(const aView: InevControlView;
   const aPt: Tl3Point): Boolean;
   {* ������������ ����������� ����� �� aPt. }
  function CanChangeBorder(const aView: InevControlView;
   const aPt: Tl3Point): Boolean;
   {* ��������� ����� �� �������� ������� �����. }
  procedure ChangeBorder(const aView: InevControlView;
   const aPt: Tl3Point);
   {* �������� ������� �����. }
  function ShowParts(const aView: InevControlView): Boolean;
  function DoMouseAction(const aView: InevControlView;
   aButton: TevMouseButton;
   anAction: TevMouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
  function GetEdge(const aView: InevView;
   aTop: Boolean): InevBasePoint;
  function MouseAction(const aView: InevControlView;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� �� ����. ���������� true - ���� ����������, ����� - false }
  function CanDrag: Boolean;
 end;//TevDocumentPartHotSpotTester
 
implementation

uses
 l3ImplUses
 , evParaTools
 , evParaCollapser
 , k2Tags
 , l3Base
 , evDocumentPart
 , nevInterfaces
 , Classes
 , l3String
 , SysUtils
 , evOp
 , evHotSpotMisc
 , l3InterfacesMisc
 , Block_Const
 , ParaList_Const
 , l3Memory
 , nevBase
 , k2OpMisc
 , evMsgCode
 , evCursorTools
 , TextPara_Const
 , evTypes
 , evdInterfaces
 , TableCell_Const
;

end.
