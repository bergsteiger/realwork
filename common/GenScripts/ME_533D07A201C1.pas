unit ChromeLikeBaseThemedWindowCaptionButton;

// Модуль: "w:\common\components\gui\Garant\ChromeLikeControls\ChromeLikeBaseThemedWindowCaptionButton.pas"
// Стереотип: "GuiControl"

interface

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , ChromeLikeBaseWindowCaptionButton
 , UxTheme
 , Messages
 , Classes
;

type
 TChromeLikeThemedWindowCaptionButtonPaintParams = record
  {* параметры отрисовки кнопок }
  rPartID: Integer;
  rStateID: Integer;
 end;//TChromeLikeThemedWindowCaptionButtonPaintParams

 TChromeLikeBaseThemedWindowCaptionButton = class(TChromeLikeBaseWindowCaptionButton)
  private
   f_Theme: HTHEME;
    {* Поле для свойства Theme }
  private
   procedure WMThemeChanged(var aMessage: TMessage); message WM_THEMECHANGED;
  protected
   function pm_GetTheme: HTHEME;
   function GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams; virtual;
   {$If NOT Defined(NoVCL)}
   procedure DestroyWnd; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure Paint; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(AOwner: TComponent); override;
  protected
   property Theme: HTHEME
    read pm_GetTheme;
 end;//TChromeLikeBaseThemedWindowCaptionButton
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , Windows
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Graphics
 , l3Base
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

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

function TChromeLikeBaseThemedWindowCaptionButton.GetPaintParams: TChromeLikeThemedWindowCaptionButtonPaintParams;
//#UC START# *533D091902B8_533D07A201C1_var*
//#UC END# *533D091902B8_533D07A201C1_var*
begin
//#UC START# *533D091902B8_533D07A201C1_impl*
 l3FillChar(Result, SizeOf(Result), 0);
//#UC END# *533D091902B8_533D07A201C1_impl*
end;//TChromeLikeBaseThemedWindowCaptionButton.GetPaintParams

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

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
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
{$IfEnd} // NOT Defined(NoVCL)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TChromeLikeBaseThemedWindowCaptionButton);
 {* Регистрация TChromeLikeBaseThemedWindowCaptionButton }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVGScene) AND NOT Defined(NoVCM) AND NOT Defined(NoTabs)

end.
