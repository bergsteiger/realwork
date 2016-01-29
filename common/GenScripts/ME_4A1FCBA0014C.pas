unit nevGUIInterfaces;

interface

uses
 l3IntfUses
 , nevTools
 , afwInterfaces
 , l3Interfaces
;

 (*
 MnevHotSpotHint = interface
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
 end;//MnevHotSpotHint
 *)
 
type
 InevHotSpotHint = interface
  {* ��������� ��� ����� �������, ������� ����������� ��������� (Hint) }
  function CanDrag: Boolean;
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
 end;//InevHotSpotHint
 
 IevHotSpot = interface(InevHotSpotHint)
  {* ��������� ��� ����� �������, �������������� �������� �����.
      ��� �������� �������������. ������ ����� ������������ IevAdvancedHotSpot }
  function MouseMove(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ����������� ���� }
  function LButtonDown(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� ����� ������ ���� }
  function LButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ���������� ����� ������ ���� }
  function LButtonDoubleClick(const aView: InevControlView;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� ������� ����� ������ ���� }
  function RButtonDown(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ������� ������ ������ ���� }
  function RButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ���������� ������ ������� ���� }
  function MButtonDown(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ������� ������ ���� }
  function MButtonUp(const aView: InevControlView;
   const Keys: TevMouseState): Boolean;
   {* ������������ ���������� ������ ���� }
 end;//IevHotSpot
 
 InevHotSpotTester2 = interface
  {* ��������� ��� ��������� "������� �����" ([InevHotSpot]) }
  function GetAdvancedHotSpot(const aView: InevControlView;
   const aState: TevCursorState;
   const aPt: InevBasePoint;
   const aMap: InevMap;
   out theSpot: IevHotSpot): Boolean;
   {* ���������� "������� �����" }
 end;//InevHotSpotTester2
 
 IevMouseMoveHandler = interface
  {* ���������� �������� ���� }
  function TransMouseMove(const aView: InevControlView;
   const aKeys: TevMouseState;
   out theActiveElement: InevActiveElement): Boolean;
   {* ���������� �������� MouseMove, ������������ ��������� }
 end;//IevMouseMoveHandler
 
 TevObjectArea = (
  {* ����� ������� (� ��������� � ������� ������ �����) }
  ev_oaNone
  , ev_oaLeftEdge
  , ev_oaRightEdge
  , ev_oaTopEdge
  , ev_oaBottomEdge
  , ev_oaCollapse
  , ev_oaProperties
  , ev_oaDragPoint
  , ev_oaHeader
 );//TevObjectArea
 
 IevHotSpotDelta = interface
  {* �������� "������� �����" (IevAdvancedHotSpot) }
  function Delta: Integer;
   {* �������� }
 end;//IevHotSpotDelta
 
 IevAdvancedHotSpot = interface(InevHotSpotHint)
  {* ��������� ��� ����� �������, �������������� �������� ����� }
  function MouseAction(const aView: InevControlView;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� �� ����. ���������� true - ���� ����������, ����� - false }
 end;//IevAdvancedHotSpot
 
 IevHotSpotSink = interface
  {* Callback-���������, ������������ ���������������� ������� �� �������� ����� � �������� aHotSpot }
  function MouseAction(const aHotSpot: IevHotSpot;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TafwMouseState;
   var Effect: TafwMouseEffect): Boolean;
   {* ������������ �������� ����� ��� aHotSpot. ���������� true - ���� ����������, ����� - false }
 end;//IevHotSpotSink
 
implementation

uses
 l3ImplUses
;

end.
