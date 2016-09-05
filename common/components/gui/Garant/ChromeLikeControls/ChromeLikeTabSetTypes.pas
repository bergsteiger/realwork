unit ChromeLikeTabSetTypes;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeTabSetTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ChromeLikeTabSetTypes" MUID: (5506A5EE013A)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
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
  ['{D01BB7A4-5E99-474B-9390-8D56F8090824}']
  function pm_GetCanvas: TCanvas;
  function pm_GetGraphics: TGPGraphics;
  property Canvas: TCanvas
   read pm_GetCanvas;
  property Graphics: TGPGraphics
   read pm_GetGraphics;
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
  ['{44A0B60F-470F-4E49-AE52-1B59DBCCD6D1}']
  function AnimateMovement: Boolean;
  procedure FinishAnimationImmediately;
 end;//IChromeLikeTabSetAnimable
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 //#UC START# *5506A5EE013Aimpl_uses*
 //#UC END# *5506A5EE013Aimpl_uses*
;
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
