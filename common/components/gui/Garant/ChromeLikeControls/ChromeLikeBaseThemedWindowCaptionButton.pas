unit ChromeLikeBaseThemedWindowCaptionButton;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChromeLikeControls"
// Модуль: "w:/common/components/gui/Garant/ChromeLikeControls/ChromeLikeBaseThemedWindowCaptionButton.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::ChromeLikeControls::ChromeLikeWindowCaptionButtons::TChromeLikeBaseThemedWindowCaptionButton
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Messages,
  UxTheme,
  ChromeLikeBaseWindowCaptionButton,
  Classes
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
type
 TChromeLikeThemedWindowCaptionButtonPaintParams = record
  {* параметры отрисовки кнопок }
   rPartID : Integer;
   rStateID : Integer;
 end;//TChromeLikeThemedWindowCaptionButtonPaintParams

 TChromeLikeBaseThemedWindowCaptionButton = class(TChromeLikeBaseWindowCaptionButton)
 private
 // private fields
   f_Theme : HTHEME;
    {* Поле для свойства Theme}
 private
 // private methods
   procedure WMThemeChanged(var aMessage: TMessage); message WM_THEMECHANGED;
 protected
 // property methods
   function pm_GetTheme: HTHEME;
 protected
 // overridden protected methods
   {$If not defined(NoVCL)}
   procedure DestroyWnd; override;
   {$IfEnd} //not NoVCL
    {$If not defined(NoVCL)}
   procedure Paint; override;
     {* Сигнатура метода Paint }
    {$IfEnd} //not NoVCL
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
   function GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams; virtual;
 protected
 // protected properties
   property Theme: HTHEME
     read pm_GetTheme;
 end;//TChromeLikeBaseThemedWindowCaptionButton
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

implementation

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
uses
  Windows,
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  Graphics,
  l3Base
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

{$If not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}

// start class TChromeLikeBaseThemedWindowCaptionButton

function TChromeLikeBaseThemedWindowCaptionButton.GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams;
//#UC START# *533D091902B8_533D07A201C1_var*
//#UC END# *533D091902B8_533D07A201C1_var*
begin
//#UC START# *533D091902B8_533D07A201C1_impl*
 l3FillChar(Result, SizeOf(Result), 0);
//#UC END# *533D091902B8_533D07A201C1_impl*
end;//TChromeLikeBaseThemedWindowCaptionButton.GetPaintParams

function TChromeLikeBaseThemedWindowCaptionButton.pm_GetTheme: HTHEME;
//#UC START# *533D09010204_533D07A201C1get_var*
const
 cWndClassName: PWideChar = 'WINDOW';
//#UC END# *533D09010204_533D07A201C1get_var*
begin
//#UC START# *533D09010204_533D07A201C1get_impl*
 if (f_Theme = 0) then
  f_Theme := OpenThemeData(Handle, cWndClassName);
 Result := f_Theme;
//#UC END# *533D09010204_533D07A201C1get_impl*
end;//TChromeLikeBaseThemedWindowCaptionButton.pm_GetTheme

procedure TChromeLikeBaseThemedWindowCaptionButton.WMThemeChanged(var aMessage: TMessage);
//#UC START# *533D08600262_533D07A201C1_var*
//#UC END# *533D08600262_533D07A201C1_var*
begin
//#UC START# *533D08600262_533D07A201C1_impl*
 inherited;
 // Тема изменилась. Нужно закрыть старые данные темы, получить новые
 // и отрисоваться
 if (f_Theme <> 0) then
 begin
  CloseThemeData(f_Theme);
  f_Theme := 0;
 end;
 if IsAppThemed then
  Invalidate;
//#UC END# *533D08600262_533D07A201C1_impl*
end;//TChromeLikeBaseThemedWindowCaptionButton.WMThemeChanged

constructor TChromeLikeBaseThemedWindowCaptionButton.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_533D07A201C1_var*
//#UC END# *47D1602000C6_533D07A201C1_var*
begin
//#UC START# *47D1602000C6_533D07A201C1_impl*
 inherited Create(aOwner);
 f_Theme := HTHEME(0);
 DoubleBuffered := True;
//#UC END# *47D1602000C6_533D07A201C1_impl*
end;//TChromeLikeBaseThemedWindowCaptionButton.Create

{$If not defined(NoVCL)}
procedure TChromeLikeBaseThemedWindowCaptionButton.DestroyWnd;
//#UC START# *4CC841540158_533D07A201C1_var*
//#UC END# *4CC841540158_533D07A201C1_var*
begin
//#UC START# *4CC841540158_533D07A201C1_impl*
 if (f_Theme <> 0) then
  CloseThemeData(f_Theme);
 inherited;
//#UC END# *4CC841540158_533D07A201C1_impl*
end;//TChromeLikeBaseThemedWindowCaptionButton.DestroyWnd
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure TChromeLikeBaseThemedWindowCaptionButton.Paint;
//#UC START# *5028A60300AD_533D07A201C1_var*
const
 BS_INACTIVE = 5; // недокументированный флаг для рисования неактивной кнопки
                  // в заголовке окна
var
 l_PaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams;
 l_Rect: TRect;
//#UC END# *5028A60300AD_533D07A201C1_var*
begin
//#UC START# *5028A60300AD_533D07A201C1_impl*
 l_PaintParams := GetPaintParams;
 // Окно может быть неактивным. Кнопку для него нужно рисовать с отдельным флагом
 // BS_INACTIVE, если на нее не наведена мышь и если кнопка не нажата
 if (State = cbsNormal) and (not ParentForm.Active) then
  l_PaintParams.rStateID := BS_INACTIVE;
 Windows.GetClientRect(Handle, l_Rect);
 // кнопки на XP, Vista и W7 имеют скругления - под ними не должно быть серого фона,
 // нарисуем родительский фон (фон заголовка окна)
 if IsThemeBackgroundPartiallyTransparent(Theme, l_PaintParams.rPartID,
  l_PaintParams.rStateID) then
  DrawThemeParentBackground(Handle, Canvas.Handle, @l_Rect);
 DrawThemeBackground(Theme, Canvas.Handle, l_PaintParams.rPartID, l_PaintParams.rStateID,
  l_Rect, nil);
//#UC END# *5028A60300AD_533D07A201C1_impl*
end;//TChromeLikeBaseThemedWindowCaptionButton.Paint
{$IfEnd} //not NoVCL

{$IfEnd} //not NoTabs AND not NoVCM AND not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM) AND not defined(NoVGScene)}
// Регистрация TChromeLikeBaseThemedWindowCaptionButton
 TtfwClassRef.Register(TChromeLikeBaseThemedWindowCaptionButton);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM AND not NoVGScene

end.