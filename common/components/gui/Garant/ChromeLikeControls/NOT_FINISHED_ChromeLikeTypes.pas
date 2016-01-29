unit NOT_FINISHED_ChromeLikeTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/NOT_FINISHED_ChromeLikeTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeWindowCaptionButtons::ChromeLikeTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Types,
  Windows
  ;

type
 tagTitleBarInfoEx = record
 end;//tagTitleBarInfoEx

 TITLEBARINFOEX = tagTitleBarInfoEx;

 TTitleBarInfoEx = TITLEBARINFOEX;

 PTitleBarInfoEx = ^TTitleBarInfoEx;

 TVistaWindowCaptionMetrics = record
   rTitleBarInfo : TTitleBarInfoEx;
   rWindowRect : TRect;
 end;//TVistaWindowCaptionMetrics

 TGradientDirection = (
   gdVertical
 , gdHorizontal
 );//TGradientDirection

 TWindowZOrderInfo = record
   rHWndBackground : HWND;
   rHWndForeground : HWND;
 end;//TWindowZOrderInfo

const
  { ChromeLikeTypesConsts }
 WM_GETTITLEBARINFOEX = $033F;
 WM_DWMCOMPOSITIONCHANGED = $031E;
 BS_INACTIVE = 5;
 SWP_STATECHANGED = $8000;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene
end.