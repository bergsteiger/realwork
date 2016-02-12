unit nevGUIInterfaces;
 {* ���������� ��� �������������� ������������ � ����������, ����� GUI Windows ��� ������ ��������� ����� (����������, ����) }

// ������: "w:\common\components\gui\Garant\Everest\new\nevGUIInterfaces.pas"
// ���������: "Interfaces"

{$Include evDefine.inc}

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
  ['{1C09A61F-FE78-4933-9B0C-DEED0E1CFE76}']
  function CanDrag: Boolean;
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
 end;//InevHotSpotHint

 IevHotSpot = interface(InevHotSpotHint)
  {* ��������� ��� ����� �������, �������������� �������� �����.
      ��� �������� �������������. ������ ����� ������������ IevAdvancedHotSpot }
  ['{3B6650BA-ECFE-4297-BE90-E0496B81408C}']
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
  ['{5F7707BE-8244-4CB4-8088-77E59D4DB7C6}']
  function GetAdvancedHotSpot(const aView: InevControlView;
   const aState: TevCursorState;
   const aPt: InevBasePoint;
   const aMap: InevMap;
   out theSpot: IevHotSpot): Boolean;
   {* ���������� "������� �����" }
 end;//InevHotSpotTester2

 IevAdvancedHotSpot = interface;

 IevMouseMoveHandler = interface
  {* ���������� �������� ���� }
  ['{5A0E02BF-F2CD-4553-856C-A28D78F48B01}']
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

 IevAdvancedHotSpot = interface;

 IevHotSpotDelta = interface
  {* �������� "������� �����" (IevAdvancedHotSpot) }
  ['{B3D20AE3-3E61-4212-AAEB-C38A98A58785}']
  function Delta: Integer;
   {* �������� }
 end;//IevHotSpotDelta

 IevAdvancedHotSpot = interface(InevHotSpotHint)
  {* ��������� ��� ����� �������, �������������� �������� ����� }
  ['{0EF1BDF3-4176-4780-8B6A-43FFE09407A7}']
  function MouseAction(const aView: InevControlView;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� �� ����. ���������� true - ���� ����������, ����� - false }
 end;//IevAdvancedHotSpot

 IevHotSpotSink = interface
  {* Callback-���������, ������������ ���������������� ������� �� �������� ����� � �������� aHotSpot }
  ['{184B8C13-1FDE-4879-8E4D-EF9853B945CD}']
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
