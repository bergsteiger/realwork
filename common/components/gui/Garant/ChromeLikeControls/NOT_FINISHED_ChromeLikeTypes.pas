unit NOT_FINISHED_ChromeLikeTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ChromeLikeControls"
// ������: "w:/common/components/gui/Garant/ChromeLikeControls/NOT_FINISHED_ChromeLikeTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeWindowCaptionButtons::ChromeLikeTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

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