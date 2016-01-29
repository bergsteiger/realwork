unit ChromeLikeWinUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeWinUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeWindowCaptionButtons::ChromeLikeWinUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Types,
  Graphics,
  Windows,
  ChromeLikeTypes
  ;

procedure UpdateWindowFrame(aHWnd: HWND);
   {* Заставляет перерисовать неклиентскую область окна }
function FillGradient(aDC: hDC;
  const aRect: TRect;
  aColorCount: Integer;
  aStartColor: TColor;
  aEndColor: TColor;
  aDirection: TGradientDirection): Boolean;
function IsWindowsVistaOrLater: Boolean;
function IsWindowsXP: Boolean;
function GetVistaWindowCaptionMetrics(aParentHWnd: HWND): TVistaWindowCaptionMetrics;
   {* Получает размеры элементов заголовка окна для текущего оформления Windows Vista и новее }
function GetWindowZOrderInfo(aHWnd: HWND): TWindowZOrderInfo;
   {* Получает Z-Order окна }
procedure SetWindowZOrderInfo(aHWnd: HWND;
  const aZOrderInfo: TWindowZOrderInfo);
   {* Устанавливает Z-Order окну }
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  SysUtils,
  l3Base
  ;

// unit methods

procedure UpdateWindowFrame(aHWnd: HWND);
//#UC START# *53C4BE5F0029_533D33DC0092_var*
//#UC END# *53C4BE5F0029_533D33DC0092_var*
begin
//#UC START# *53C4BE5F0029_533D33DC0092_impl*
 SetWindowPos(aHWnd, 0, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE or SWP_NOZORDER or
  SWP_NOACTIVATE or SWP_FRAMECHANGED);
//#UC END# *53C4BE5F0029_533D33DC0092_impl*
end;//UpdateWindowFrame

function FillGradient(aDC: hDC;
  const aRect: TRect;
  aColorCount: Integer;
  aStartColor: TColor;
  aEndColor: TColor;
  aDirection: TGradientDirection): Boolean;
//#UC START# *53C4BE7000A3_533D33DC0092_var*
var
 l_StartRGB: array [0..2] of Byte;
 l_RGBKoef: array [0..2] of Double;
 l_Brush: HBRUSH;
 l_AreaWidth: Integer;
 l_AreaHeight: Integer;
 l_Index: Integer;
 l_ColorRect: TRect;
 l_RectOffset: Double;
//#UC END# *53C4BE7000A3_533D33DC0092_var*
begin
//#UC START# *53C4BE7000A3_533D33DC0092_impl*
 l_RectOffset := 0;
 Result := False;
 if (aColorCount < 1) then
  Exit;
 aStartColor := ColorToRGB(aStartColor);
 aEndColor := ColorToRGB(aEndColor);
 l_StartRGB[0] := GetRValue(aStartColor);
 l_StartRGB[1] := GetGValue(aStartColor);
 l_StartRGB[2] := GetBValue(aStartColor);
 l_RGBKoef[0] := (GetRValue(aEndColor) - l_StartRGB[0]) / aColorCount;
 l_RGBKoef[1] := (GetGValue(aEndColor) - l_StartRGB[1]) / aColorCount;
 l_RGBKoef[2] := (GetBValue(aEndColor) - l_StartRGB[2]) / aColorCount;
 l_AreaWidth := aRect.Right - aRect.Left;
 l_AreaHeight :=  aRect.Bottom - aRect.Top;
 case aDirection of
  gdHorizontal:
   l_RectOffset := l_AreaWidth / aColorCount;
  gdVertical:
   l_RectOffset := l_AreaHeight / aColorCount;
 end;
 for l_Index := 0 to Pred(aColorCount) do
 begin
  l_Brush := CreateSolidBrush(RGB(
   l_StartRGB[0] + Round((l_Index + 1) * l_RGBKoef[0]),
   l_StartRGB[1] + Round((l_Index + 1) * l_RGBKoef[1]),
   l_StartRGB[2] + Round((l_Index + 1) * l_RGBKoef[2])));
  case aDirection of
   gdHorizontal:
    SetRect(l_ColorRect, Round(l_RectOffset * l_Index), 0, Round(l_RectOffset * (l_Index + 1)), l_AreaHeight);
   gdVertical:
    SetRect(l_ColorRect, 0, Round(l_RectOffset * l_Index), l_AreaWidth, Round(l_RectOffset * (l_Index + 1)));
  end;
  OffsetRect(l_ColorRect, aRect.Left, aRect.Top);
  FillRect(aDC, l_ColorRect, l_Brush);
  DeleteObject(l_Brush);
 end;
 Result := True;
//#UC END# *53C4BE7000A3_533D33DC0092_impl*
end;//FillGradient

function IsWindowsVistaOrLater: Boolean;
//#UC START# *53C4BE7C00E6_533D33DC0092_var*
//#UC END# *53C4BE7C00E6_533D33DC0092_var*
begin
//#UC START# *53C4BE7C00E6_533D33DC0092_impl*
 Result := (Win32MajorVersion >= 6);
//#UC END# *53C4BE7C00E6_533D33DC0092_impl*
end;//IsWindowsVistaOrLater

function IsWindowsXP: Boolean;
//#UC START# *53C4BE8E00A8_533D33DC0092_var*
const
 cXP32Minor = 1;
 cXP64Minor = 2;
//#UC END# *53C4BE8E00A8_533D33DC0092_var*
begin
//#UC START# *53C4BE8E00A8_533D33DC0092_impl*
 Result := (Win32MajorVersion = 5) and (Win32MinorVersion in [cXP32Minor, cXP64Minor]);
//#UC END# *53C4BE8E00A8_533D33DC0092_impl*
end;//IsWindowsXP

function GetVistaWindowCaptionMetrics(aParentHWnd: HWND): TVistaWindowCaptionMetrics;
//#UC START# *53C4BE9B03E2_533D33DC0092_var*
const
 cWndClassName: PWideChar = 'ChromeLikeStyledUtilWindow';
 cWndName: PWideChar = '';
var
 l_WndClass: TWndClassW;
 l_Hwnd: HWND;
 l_Metrics: TTitleBarInfoEx;
 l_WndRect: TRect;
//#UC END# *53C4BE9B03E2_533D33DC0092_var*
begin
//#UC START# *53C4BE9B03E2_533D33DC0092_impl*
 Assert(IsWindow(aParentHWnd), 'GetVistaWindowCaptionMetrics: aParentHWnd = ' +
  IntToStr(aParentHWnd));

 l3FillChar(Result, SizeOf(Result), 0);
 l3FillChar(l_WndClass, SizeOf(l_WndClass), 0);
 l3FillChar(l_Metrics, SizeOf(l_Metrics), 0);
 l3FillChar(l_WndRect, SizeOf(l_WndRect), 0);

 l_Hwnd := 0;
 // Создадим временное невидимое окно с кнопками, чтобы получить настоящие
 // правильные размеры
 l_WndClass.lpfnWndProc   := @DefWindowProcW;
 l_WndClass.hInstance     := HInstance;
 l_WndClass.lpszClassName := cWndClassName;

 RegisterClassW(l_WndClass);
 // Создадим прозрачное дочернее поданному окно. Окно не покажется
 // на экране или таскабре. Это нужно потому, что в настоящем окне нет
 // виндовых кнопок, а потому Windows вернет нам неправильные размеры.
 l_Hwnd := CreateWindowExW(WS_EX_LAYERED, cWndClassName, cWndName,
  WS_OVERLAPPEDWINDOW, 0, 0, 0, 0, aParentHWnd, 0, HInstance, nil);
 Assert(IsWindow(l_Hwnd),
  'GetVistaWindowCaptionMetrics - не удалось создать окно. GetLastError = ' +
   IntToStr(GetLastError));
 ShowWindow(l_Hwnd, SW_SHOW);
 l_Metrics.cbSize := SizeOf(l_Metrics);
 SendMessage(l_Hwnd, WM_GETTITLEBARINFOEX, 0, LPARAM(@l_Metrics));

 GetWindowRect(l_Hwnd, l_WndRect);

 DestroyWindow(l_Hwnd);
 UnregisterClassW(cWndClassName, HInstance);

 // Могли прийти неправильные размеры - проверим, если что отдадим нули
 with l_Metrics do
  if (((rgrect[2].Right - rgrect[2].Left) = 0) OR
      ((rgrect[3].Right - rgrect[3].Left) = 0) OR
      ((rgrect[5].Right - rgrect[5].Left) = 0)) then
  begin
   Assert(False, 'WM_GETTITLEBARINFOEX: вернулись неправильные размеры кнопок.');
  end;
 Result.rTitleBarInfo := l_Metrics;
 Result.rWindowRect := l_WndRect;
//#UC END# *53C4BE9B03E2_533D33DC0092_impl*
end;//GetVistaWindowCaptionMetrics

function GetWindowZOrderInfo(aHWnd: HWND): TWindowZOrderInfo;
//#UC START# *53C4BEB2027A_533D33DC0092_var*
//#UC END# *53C4BEB2027A_533D33DC0092_var*
begin
//#UC START# *53C4BEB2027A_533D33DC0092_impl*
 l3FillChar(Result, SizeOf(Result), 0);
 Result.rHWndBackground := GetNextWindow(aHWnd, GW_HWNDNEXT);
 Result.rHWndForeground := GetNextWindow(aHWnd, GW_HWNDPREV);
//#UC END# *53C4BEB2027A_533D33DC0092_impl*
end;//GetWindowZOrderInfo

procedure SetWindowZOrderInfo(aHWnd: HWND;
  const aZOrderInfo: TWindowZOrderInfo);
//#UC START# *53C4BEBD012C_533D33DC0092_var*
//#UC END# *53C4BEBD012C_533D33DC0092_var*
begin
//#UC START# *53C4BEBD012C_533D33DC0092_impl*
 if (IsWindow(aZOrderInfo.rHWndForeground)) then
  SetWindowPos(aHWnd, aZOrderInfo.rHWndForeground, 0, 0, 0, 0, SWP_NOSIZE or
   SWP_NOMOVE or SWP_NOACTIVATE);
//#UC END# *53C4BEBD012C_533D33DC0092_impl*
end;//SetWindowZOrderInfo
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

end.