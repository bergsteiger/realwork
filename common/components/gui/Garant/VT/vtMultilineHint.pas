unit vtMultilineHint;

// Модуль: "w:\common\components\gui\Garant\VT\vtMultilineHint.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvtMultilineHint" MUID: (50C61AAC00BF)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 , l3WinControlCanvas
 , l3FormattedLines
 , Types
 , Classes
 , Windows
;

type
 TvtMultilineHint = class({$If NOT Defined(NoVCL)}
 THintWindow
 {$IfEnd} // NOT Defined(NoVCL)
 )
  private
   f_Canvas: Tl3WinControlCanvas;
   f_FL: Tl3FormattedLines;
   f_NCMousePoint: LongInt;
   f_LastHint: Il3CString;
  protected
   {$If NOT Defined(NoVCL)}
   procedure CreateParams(var Params: TCreateParams); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure Paint; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   procedure ActivateHintEx(Rect: TRect;
    const AHint: Il3CString);
   class procedure vtActivateHint(aWindow: THintWindow;
    const Rect: TRect;
    const AHint: Il3CString);
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
   {$If NOT Defined(NoVCL)}
   procedure ActivateHint(Rect: TRect;
    const AHint: String); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   function IsHintMsg(var Msg: TMsg): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   property LastHint: Il3CString
    read f_LastHint;
 end;//TvtMultilineHint

implementation

uses
 l3ImplUses
 , vtHintManager
 , l3InternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3String
 , l3Chars
 , l3ScreenIC
 , l3Base
 , l3CustomControlCanvas
 , Messages
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *50C61AAC00BFimpl_uses*
 //#UC END# *50C61AAC00BFimpl_uses*
;

{$If NOT Defined(NoVCL)}
procedure TvtMultilineHint.ActivateHintEx(Rect: TRect;
 const AHint: Il3CString);
//#UC START# *50C61C8E015D_50C61AAC00BF_var*
var
 l_LeftWidth  : Integer;
 l_RigthWidth : Integer;
 l_Canvas     : Il3InfoCanvas;
 l_RigthHint  : Boolean;
 l_Rect       : TRect;
 l_Pos        : Integer;
 l_Monitor    : TMonitor;
//#UC END# *50C61C8E015D_50C61AAC00BF_var*
begin
//#UC START# *50C61C8E015D_50C61AAC00BF_impl*
 if not l3Same(f_LastHint, aHint) then
 begin
  l_Pos := l3Pos(aHint, #0); //Заплатка: иногда приходили хинты с мусором.
  if (l_Pos >= 0) then
   f_LastHint := l3Copy(aHint, 0, l_Pos)
  else
   f_LastHint := aHint;
(*  l_Pos := l3Pos(f_LastHint, cc_Tab);
  if (l_Pos >= 0) then
   l3Replace(f_LastHint, cc_Tab, ' ', l_Pos);//Заплатка при показе символов табуляции*)
   l3Replace(f_LastHint, cc_Tab, l3PCharLen(String(cc_HardSpace)));//Заплатка при показе символов табуляции
 end;//not l3Same(f_LastHint, aHint)
 l_Monitor := Screen.MonitorFromPoint(Mouse.CursorPos);
 l_RigthWidth := Rect.Left - l_Monitor.Left;
 l_LeftWidth := l_Monitor.Width - l_RigthWidth;
 //l_Monitor.Width + l_Monitor.Left - учет "мультимониторности", Rect.Left - 
 //в координатах desktop'а, а не монитора, т.е. м.б. больше, чем l_Monitor.Width!
 l_RigthHint := (l_LeftWidth < l_RigthWidth);//Здесь учитывается положение
 //hint'а на экране. Он может быть расположен далеко не оптимальным образом,
 //т.е. если просто провести разбиение, то он просто вытянется, вместо того,
 //чтобы сместиться влево или вправо.
 l_Canvas := l3CrtIC;
 l_Canvas.PasswordChar := #0;
 //l_Canvas.LineSpacing := def_LineSpacing;
 l_Canvas.Font.AssignFont(Canvas.Font);
 l_Rect := Rect;  //Запоминаем координаты, т.к. после пересчета они м.б. "испорчены".
 if (l_Rect.Right > l_Monitor.Width) and (l_Rect.Left < l_Monitor.Width) then //Вылезли за пределы текущего монитора,
 //поэтому "обрезаем" границу по щирине монитора. Будем считать, что мониторов 
 //м.б. только 2, т.к. уже за пределам 2-го монитора условие будет глючить.
  l_Rect.Right := l_Monitor.Width;
 if l_RigthHint then
  Rect.Right := Rect.Left + l_RigthWidth
 else
  Rect.Right := Rect.Left + l_LeftWidth;
 l_Canvas.DrawText(l3PCharLen(f_LastHint), Rect, DT_LEFT or DT_NOPREFIX or
  DT_CALCRECT or DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly, f_FL);
 if l_RigthHint then//После пересчета координаты "испорчены". Может быть
  //интересна только их разница!!!
 begin
  Dec(Rect.Left, 6);
  Rect.Left := l_Rect.Right - (Rect.Right - Rect.Left);
  Rect.Right := l_Rect.Right;
 end
 else
 begin
  Inc(Rect.Right, 6);
  Rect.Right := l_Rect.Left + (Rect.Right - Rect.Left);
  Rect.Left := l_Rect.Left;
 end;
 inherited ActivateHint(Rect, l3Str(f_LastHint));
//#UC END# *50C61C8E015D_50C61AAC00BF_impl*
end;//TvtMultilineHint.ActivateHintEx

class procedure TvtMultilineHint.vtActivateHint(aWindow: THintWindow;
 const Rect: TRect;
 const AHint: Il3CString);
//#UC START# *50C61F0B0392_50C61AAC00BF_var*
//#UC END# *50C61F0B0392_50C61AAC00BF_var*
begin
//#UC START# *50C61F0B0392_50C61AAC00BF_impl*
 if (aWindow is TvtMultilineHint) then
  TvtMultiLineHint(aWindow).ActivateHintEx(Rect, aHint)
 else
  aWindow.ActivateHint(Rect, l3Str(aHint));
//#UC END# *50C61F0B0392_50C61AAC00BF_impl*
end;//TvtMultilineHint.vtActivateHint

constructor TvtMultilineHint.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_50C61AAC00BF_var*
//#UC END# *47D1602000C6_50C61AAC00BF_var*
begin
//#UC START# *47D1602000C6_50C61AAC00BF_impl*
 inherited;
 f_FL := Tl3FormattedLines.Create;
 TvtHintManager.Instance.Add(Self);
//#UC END# *47D1602000C6_50C61AAC00BF_impl*
end;//TvtMultilineHint.Create

destructor TvtMultilineHint.Destroy;
//#UC START# *48077504027E_50C61AAC00BF_var*
//#UC END# *48077504027E_50C61AAC00BF_var*
begin
//#UC START# *48077504027E_50C61AAC00BF_impl*
 f_LastHint := nil;
 l3Free(f_FL);
 l3Free(f_Canvas);
 if TvtHintManager.Exists then
  TvtHintManager.Instance.Remove(Self);
 inherited;
//#UC END# *48077504027E_50C61AAC00BF_impl*
end;//TvtMultilineHint.Destroy

procedure TvtMultilineHint.CreateParams(var Params: TCreateParams);
//#UC START# *48C7925A02E5_50C61AAC00BF_var*
//#UC END# *48C7925A02E5_50C61AAC00BF_var*
begin
//#UC START# *48C7925A02E5_50C61AAC00BF_impl*
 inherited;
 with Params do
  WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
//#UC END# *48C7925A02E5_50C61AAC00BF_impl*
end;//TvtMultilineHint.CreateParams

procedure TvtMultilineHint.Paint;
//#UC START# *5028A60300AD_50C61AAC00BF_var*
var
 R: TRect;
//#UC END# *5028A60300AD_50C61AAC00BF_var*
begin
//#UC START# *5028A60300AD_50C61AAC00BF_impl*
 if (f_Canvas = nil) then
  f_Canvas := Tl3CustomControlCanvas.Create(Self);
 f_Canvas.BeginPaint;
 try
  f_Canvas.DrawEnabled := true;
  R := ClientRect;
  Inc(R.Left, 2);
  Inc(R.Top, 2);
  f_Canvas.Font.BackColor := Application.HintColor;//Bug fix: Менялся цвет hint'а
  f_Canvas.Font.ForeColor := Screen.HintFont.Color;//K: 266418322
  f_Canvas.DrawText(l3PCharLen(f_LastHint), R, DT_LEFT or DT_NOPREFIX
    or DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly, f_FL);
 finally
  f_Canvas.EndPaint;
 end;//try..finally
//#UC END# *5028A60300AD_50C61AAC00BF_impl*
end;//TvtMultilineHint.Paint

procedure TvtMultilineHint.ActivateHint(Rect: TRect;
 const AHint: String);
//#UC START# *50C61BA40123_50C61AAC00BF_var*
//#UC END# *50C61BA40123_50C61AAC00BF_var*
begin
//#UC START# *50C61BA40123_50C61AAC00BF_impl*
 ActivateHintEx(Rect, l3CStr(aHint));
//#UC END# *50C61BA40123_50C61AAC00BF_impl*
end;//TvtMultilineHint.ActivateHint

function TvtMultilineHint.IsHintMsg(var Msg: TMsg): Boolean;
//#UC START# *50C61BD700BF_50C61AAC00BF_var*
//#UC END# *50C61BD700BF_50C61AAC00BF_var*
begin
//#UC START# *50C61BD700BF_50C61AAC00BF_impl*
 if Msg.Message = WM_NCMOUSEMOVE then
 begin
  Result := Msg.lParam <> f_NCMousePoint;
  f_NCMousePoint := Msg.lParam;
 end
 else
  Result := inherited IsHintMsg(Msg);
//#UC END# *50C61BD700BF_50C61AAC00BF_impl*
end;//TvtMultilineHint.IsHintMsg

initialization
//#UC START# *50C61F7E02BE*
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtMultilineHint.pas initialization enter'); {$EndIf}
 HintWindowClass := TvtMultiLineHint;
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtMultilineHint.pas initialization leave'); {$EndIf}
//#UC END# *50C61F7E02BE*
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtMultilineHint);
 {* Регистрация TvtMultilineHint }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

end.
