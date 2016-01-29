unit evHotSpotMisc;

interface

uses
 l3IntfUses
 , nevGUIInterfaces
 , nevTools
 , evInternalInterfaces
 , l3ProtoObject
 , afwInterfaces
 , l3Interfaces
;

type
 TevHotSpotWrap = class(Tl3ProtoObject, IevAdvancedHotSpot, IevHotSpot)
  procedure Create(const aHotSpot: IevAdvancedHotSpot;
   const aView: InevControlView); overload;
  function Make(const aHotSpot: IevAdvancedHotSpot;
   const aView: InevControlView): IevHotSpot; overload;
  procedure Create(const aHotSpot: IevAdvancedHotSpot;
   const aHotSpotSink: IevHotSpotSink); overload;
  function Make(const aHotSpot: IevAdvancedHotSpot;
   const aHotSpotSink: IevHotSpotSink): IevHotSpot; overload;
  procedure HitTest(const aView: InevControlView;
   const aState: TafwCursorState;
   var theInfo: TafwCursorInfo);
  function MouseAction(const aView: InevControlView;
   aButton: Tl3MouseButton;
   anAction: Tl3MouseAction;
   const Keys: TevMouseState;
   var Effect: TevMouseEffect): Boolean;
   {* ������������ ������� �� ����. ���������� true - ���� ����������, ����� - false }
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
  function CanDrag: Boolean;
 end;//TevHotSpotWrap
 
implementation

uses
 l3ImplUses
 , l3Base
 , Classes
 , l3InterfacesMisc
 , SysUtils
;

end.
