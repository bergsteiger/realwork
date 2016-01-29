unit ChromeLikeTabSetTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeTabSetTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeTabSet::ChromeLikeTabSetTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Graphics,
  GDIPOBJ
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

 IChromeLkeTabSetDrawingContext = interface(IUnknown)
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

 IChromeLikeTabSetAnimable = interface(IUnknown)
   ['{44A0B60F-470F-4E49-AE52-1B59DBCCD6D1}']
   function AnimateMovement: Boolean;
   procedure FinishAnimationImmediately;
 end;//IChromeLikeTabSetAnimable
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
end.