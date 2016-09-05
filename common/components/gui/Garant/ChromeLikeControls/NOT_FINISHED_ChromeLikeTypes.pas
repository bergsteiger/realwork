unit NOT_FINISHED_ChromeLikeTypes;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\NOT_FINISHED_ChromeLikeTypes.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ChromeLikeTypes" MUID: (53C4BB200287)

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , Types
 , Windows
;

const
 WM_GETTITLEBARINFOEX = $033F;
 WM_DWMCOMPOSITIONCHANGED = $031E;
 BS_INACTIVE = 5;
 SWP_STATECHANGED = $8000;

type
 PTitleBarInfoEx = ^TTitleBarInfoEx;

 tagTitleBarInfoEx = record
 end;//tagTitleBarInfoEx

 TITLEBARINFOEX = tagTitleBarInfoEx;

 TTitleBarInfoEx = TITLEBARINFOEX;

 TVistaWindowCaptionMetrics = record
  rTitleBarInfo: TTitleBarInfoEx;
  rWindowRect: TRect;
 end;//TVistaWindowCaptionMetrics

 TGradientDirection = (
  gdVertical
  , gdHorizontal
 );//TGradientDirection

 TWindowZOrderInfo = record
  rHWndBackground: HWND;
  rHWndForeground: HWND;
 end;//TWindowZOrderInfo
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 //#UC START# *53C4BB200287impl_uses*
 //#UC END# *53C4BB200287impl_uses*
;
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
