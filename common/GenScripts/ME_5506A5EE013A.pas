unit ChromeLikeTabSetTypes;

interface

uses
 l3IntfUses
 , Graphics
 , GDIPOBJ
;

type
 TChromeLikeTabDirection = (
  drLeft
  , drRight
 );//TChromeLikeTabDirection
 
 TChromeLikeTabEaseType = (
  ttNone
  , ttLinearTween
  , ttEaseInQuad
  , ttEaseInOutQuad
  , ttEaseInCubic
  , ttEaseOutCubic
  , ttEaseInOutCubic
  , ttEaseInQuart
  , ttEaseOutQuart
  , ttEaseInOutQuart
  , ttEaseInQuint
  , ttEaseOutQuint
  , ttEaseInOutQuint
  , ttEaseInSine
  , ttEaseOutSine
  , ttEaseInOutSine
  , ttEaseInExpo
  , ttEaseOutExpo
  , ttEaseInOutExpo
  , ttEaseInCirc
  , ttEaseOutCirc
  , ttEaseInOutCirc
  , ttEaseOutQuad
 );//TChromeLikeTabEaseType
 
 IChromeLkeTabSetDrawingContext = interface
 end;//IChromeLkeTabSetDrawingContext
 
 TChromeLikeVisualObjectState = (
  cltcsNormal
  , cltcsHovered
  , cltcsSelected
 );//TChromeLikeVisualObjectState
 
 TChromeLikeVisualObjectBehaviour = (
  cltcbMovable
  , cltcbClickable
  , cltcbUndockable
  , cltcbAnimable
  , cltcbHoverable
  , cltcbSelectable
  , cltcbMiddleButtonClickable
 );//TChromeLikeVisualObjectBehaviour
 
 TChromeLikeTabSetHitTestResult = (
  htrInTab
  , htrClient
  , htrNowhere
 );//TChromeLikeTabSetHitTestResult
 
 TChromeLikeVisualObjectBehaviours = set of TChromeLikeVisualObjectBehaviour;
 
 TChromeLikeTabSetStyleElement = (
  tsseTabBackground
  , tsseTabBorderLeft
  , tsseTabBorderRight
  , tsseTabBorderBottom
  , tsseTabText
  , tsseTabCloseButtonCross
  , tsseNewTabButtonBackground
  , tsseNewTabButtonPlusSignBody
  , tsseNewTabButtonPlusSignOutline
 );//TChromeLikeTabSetStyleElement
 
 TChromeLikeTabSetElementState = (
  tsesNormal
  , tsesActive
  , tsesHot
 );//TChromeLikeTabSetElementState
 
 IChromeLikeTabSetAnimable = interface
  function AnimateMovement: Boolean;
  procedure FinishAnimationImmediately;
 end;//IChromeLikeTabSetAnimable
 
implementation

uses
 l3ImplUses
;

end.
