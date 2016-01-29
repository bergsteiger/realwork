unit ChromeLikeBaseVisualObjectPrim;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ChromeLikeTabSetTypes
 , Types
 , Controls
 , Classes
;

type
 TChromeLikeMargins = class(Tl3ProtoObject)
  procedure Changed;
  procedure Create(aLeft: Integer;
   aTop: Integer;
   aRight: Integer;
   aBottom: Integer);
 end;//TChromeLikeMargins
 
 TChromeLikeBaseVisualObjectPrim = class(Tl3ProtoObject, IChromeLikeTabSetAnimable)
  procedure PaintChildren(const aContext: IChromeLkeTabSetDrawingContext);
  procedure LayoutChildren(const aRect: TRect);
  procedure RemoveChild(aIndex: Integer);
  procedure DeleteChildren;
  procedure DoOnMarginsChanged(aSender: TObject);
  procedure InsertObject(aObject: TChromeLikeBaseVisualObjectPrim);
  procedure Invalidate;
  procedure AnimationFinished;
  procedure DoPaint(const aContext: IChromeLkeTabSetDrawingContext);
  procedure DoMouseMove(const aPoint: TPoint);
  procedure DoClick(const aPoint: TPoint);
  procedure PositionChanged;
  procedure StateChanged;
  function IsMovable: Boolean;
  function IsUndockable: Boolean;
  function IsClickable: Boolean;
  function IsAnimable: Boolean;
  procedure Layout(var aRect: TRect);
  function MeasureSize: TSize;
  function MakeBehaviourParams: TChromeLikeVisualObjectBehaviours;
  procedure MakeChildControls;
  function DoGetCanMove(const aPoint: TPoint): Boolean;
  function CanMove(const aPoint: TPoint): Boolean;
  function DoAnimateMovement: Boolean;
  function HitTest(const aPoint: TPoint): TChromeLikeBaseVisualObjectPrim;
  procedure SetPosition(const aRect: TRect;
   aAnimationTime: Cardinal;
   aEaseType: TChromeLikeTabEaseType);
  procedure SetHeight(aValue: Integer;
   aAnimationTime: Cardinal;
   aEaseType: TChromeLikeTabEaseType);
  procedure SetWidth(aValue: Integer;
   aAnimationTime: Cardinal;
   aEaseType: TChromeLikeTabEaseType);
  procedure SetLeft(aValue: Integer;
   aAnimationTime: Cardinal;
   aEaseType: TChromeLikeTabEaseType);
  procedure SetTop(aValue: Integer;
   aAnimationTime: Cardinal;
   aEaseType: TChromeLikeTabEaseType);
  procedure Paint(const aContext: IChromeLkeTabSetDrawingContext);
  procedure MouseMove(const aPoint: TPoint);
  procedure Click(const aPoint: TPoint);
  procedure RequestLayoutChildren;
  procedure Create(aParent: TChromeLikeBaseVisualObjectPrim);
  function Intersects(const aPoint: TPoint): Boolean;
  procedure DoMouseLeave;
  procedure MouseLeave;
  procedure MiddleButtonClick(const aPoint: TPoint);
  procedure DoMiddleButtonClick(const aPoint: TPoint);
  function AnimateMovement: Boolean;
  procedure FinishAnimationImmediately;
 end;//TChromeLikeBaseVisualObjectPrim
 
implementation

uses
 l3ImplUses
 , ChromeLikeBaseVisualObject
 , SysUtils
 , ChromeLikeTabSetAnimationManager
 , Windows
 , ChromeLikeTabSetUtils
 , Math
;

end.
