unit evSegmentHotSpot;

interface

uses
 l3IntfUses
 , evHotSpot
 , afwNavigation
 , nevGUIInterfaces
 , nevTools
 , l3Variant
 , nevBase
 , afwInterfaces
 , l3Units
 , l3IID
;

type
 TevSegmentPlacement = (
  {* ��������� ������� ������������ �������� }
  ev_spNone
  , ev_spLeft
  , ev_spBody
  , ev_spRight
 );//TevSegmentPlacement
 
 TevSegmentHotSpot = class(TevHotSpot, IevMoniker, IevMouseMoveHandler, IevHotSpot)
  {* ������� ����� ��� �������� ���������� ���������� ��������� }
  function TryDoHyperlink(const aView: InevControlView;
   anEffects: TafwJumpToEffects): Boolean;
  function IsHyperlink: Boolean;
  procedure GetHyperLink;
   {* ���������� �����������, �� ����������� �� ������ �������� }
  function GetPlacement: TevSegmentPlacement;
  procedure ChangeBorder(const aTag: InevObject;
   aPosition: Integer;
   const aPack: InevOp);
  procedure CanChangeBorderPrim;
  function CanChangeBorder(const aView: InevControlView;
   const aPt: Tl3Point;
   out aPlacement: TevSegmentPlacement): Boolean;
  procedure TryToSelectHypelink(const aView: InevControlView);
  function GetDownPointPara: InevPara;
  procedure Create(const aDownPoint: InevBasePoint;
   aTarget: Tl3Variant;
   aLayerHandle: Integer;
   const aProcessor: InevProcessor);
  function Make(const aDownPoint: InevBasePoint;
   aTarget: Tl3Variant;
   aLayerHandle: Integer;
   const aProcessor: InevProcessor): IevHotSpot;
   {* ������ ������� ����� ��� �������� }
  function TransMouseMove(const aView: InevControlView;
   const aKeys: TevMouseState;
   out theActiveElement: InevActiveElement): Boolean;
   {* ���������� �������� MouseMove, ������������ ��������� }
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
 end;//TevSegmentHotSpot
 
implementation

uses
 l3ImplUses
 , nevNavigation
 , l3Base
 , evHotSpotMisc
 , nevInterfaces
 , evHyperlink
 , evInternalInterfaces
 , Classes
 , Segment_Const
 , evSegLst
 , l3Const
 , nevActiveHyperlink
 , evParaTools
 , evAACContentUtils
 , SysUtils
 , evdStyles
 , k2Tags
 , k2Base
 , evdTypes
 , HyperLink_Const
;

type
 TEffectMap = array [Boolean] of TafwJumpToEffects;
 
end.
