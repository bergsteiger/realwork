unit nsWebBrowser;
 {* Наследник от стандартного компонента, для заточек в F1 }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\InternetAgent\nsWebBrowser.pas"
// Стереотип: "GuiControl"
// Элемент модели: "TnsWebBrowser" MUID: (49ECB8E002B0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsWebBrowserPrim
 , Windows
 , Messages
 , Classes
 , OvcController
 , afwInterfaces
;

type
 _afwShortcutsHandler_Parent_ = TnsWebBrowserPrim;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwShortcutsHandler.imp.pas}
 _evStyleTableListener_Parent_ = _afwShortcutsHandler_;
 {$Include w:\common\components\gui\Garant\Everest\evStyleTableListener.imp.pas}
 TnsWebBrowser = class(_evStyleTableListener_)
  {* Наследник от стандартного компонента, для заточек в F1 }
  private
   f_FPUCtrlWord: Word;
   f_RememberedWndHandle: hWnd;
   f_Scale: Integer;
    {* Масштаб }
   f_ScrollPos: Integer;
  private
   {$If NOT Defined(XE)}
   procedure DocumentComplete(Sender: TObject;
    const pDisp: IDispatch;
    var URL: OleVariant);
    {* Документ готов к работе }
   {$IfEnd} // NOT Defined(XE)
   procedure ApplyZoom;
    {* Выставляет Zoom из таблицы стилей }
   procedure DocumentCompleteXE(Sender: TObject;
    const pDisp: IDispatch;
    const URL: OleVariant);
   procedure ApplyScroll;
   procedure WMSize(var aMsg: TWMSize); message WM_Size;
  protected
   procedure pm_SetScale(aValue: Integer);
   function pm_GetScrollPos: Integer;
   procedure pm_SetScrollPos(aValue: Integer);
   {$If NOT Defined(DesignTimeLibrary)}
   procedure DoStyleTableChanged; override;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure InitFields; override;
   {$If NOT Defined(NoVCL)}
   procedure CreateWnd; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure DestroyWnd; override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   function ScaleDisabled: Boolean;
    {* Масштабирование запрещено }
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;
  public
   property Scale: Integer
    read f_Scale
    write pm_SetScale;
    {* Масштаб }
   property ScrollPos: Integer
    read pm_GetScrollPos
    write pm_SetScrollPos;
 end;//TnsWebBrowser
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsWebBrowserHelper
 , l3SysUtils
 , l3Base
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , OvcConst
 {$If NOT Defined(DesignTimeLibrary)}
 , evStyleTableSpy
 {$IfEnd} // NOT Defined(DesignTimeLibrary)
 , evStyleTableTools
 , Variants
 , StrUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$Include w:\common\components\gui\Garant\AFW\implementation\afwShortcutsHandler.imp.pas}

{$Include w:\common\components\gui\Garant\Everest\evStyleTableListener.imp.pas}

procedure TnsWebBrowser.pm_SetScale(aValue: Integer);
//#UC START# *4BB32FCD0157_49ECB8E002B0set_var*
//#UC END# *4BB32FCD0157_49ECB8E002B0set_var*
begin
//#UC START# *4BB32FCD0157_49ECB8E002B0set_impl*
 if (f_Scale <> aValue) then
 begin
  f_Scale := aValue;
  ApplyZoom;
 end;//f_Scale <> aValue
//#UC END# *4BB32FCD0157_49ECB8E002B0set_impl*
end;//TnsWebBrowser.pm_SetScale

function TnsWebBrowser.pm_GetScrollPos: Integer;
//#UC START# *5742C14900F5_49ECB8E002B0get_var*
//#UC END# *5742C14900F5_49ECB8E002B0get_var*
begin
//#UC START# *5742C14900F5_49ECB8E002B0get_impl*
 try
  if not VarIsClear(OleObject) then
   if not VarIsClear(OleObject.Document) then
    if not VarIsClear(OleObject.Document.documentElement) then
     f_ScrollPos := OleObject.Document.documentElement.ScrollTop;
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
 Result := f_ScrollPos;
//#UC END# *5742C14900F5_49ECB8E002B0get_impl*
end;//TnsWebBrowser.pm_GetScrollPos

procedure TnsWebBrowser.pm_SetScrollPos(aValue: Integer);
//#UC START# *5742C14900F5_49ECB8E002B0set_var*
//#UC END# *5742C14900F5_49ECB8E002B0set_var*
begin
//#UC START# *5742C14900F5_49ECB8E002B0set_impl*
 if (f_ScrollPos <> aValue) then
 begin
  f_ScrollPos := aValue;
  ApplyScroll;
 end;
//#UC END# *5742C14900F5_49ECB8E002B0set_impl*
end;//TnsWebBrowser.pm_SetScrollPos

{$If NOT Defined(XE)}
procedure TnsWebBrowser.DocumentComplete(Sender: TObject;
 const pDisp: IDispatch;
 var URL: OleVariant);
 {* Документ готов к работе }
//#UC START# *49F0457A016C_49ECB8E002B0_var*
//#UC END# *49F0457A016C_49ECB8E002B0_var*
begin
//#UC START# *49F0457A016C_49ECB8E002B0_impl*
 DocumentCompleteXE(Sender, pDisp, URL);
//#UC END# *49F0457A016C_49ECB8E002B0_impl*
end;//TnsWebBrowser.DocumentComplete
{$IfEnd} // NOT Defined(XE)

procedure TnsWebBrowser.ApplyZoom;
 {* Выставляет Zoom из таблицы стилей }
//#UC START# *49F062A50141_49ECB8E002B0_var*
//#UC END# *49F062A50141_49ECB8E002B0_var*
begin
//#UC START# *49F062A50141_49ECB8E002B0_impl*
 try
  if not VarIsClear{VarIsNull}(OleObject) AND
     not VarIsClear{VarIsNull}(OleObject.Document) then
   if not VarIsClear{VarIsNull}(OleObject.Document.Body) then
   begin
    if ScaleDisabled then
     OleObject.Document.Body.Style.Zoom := 1
    else
     OleObject.Document.Body.Style.Zoom := f_Scale / 100{evGetDefaultZoom(12)};
   end;//not VarIsClear{VarIsNull}(OleObject.Document.Body)
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
//#UC END# *49F062A50141_49ECB8E002B0_impl*
end;//TnsWebBrowser.ApplyZoom

function TnsWebBrowser.ScaleDisabled: Boolean;
 {* Масштабирование запрещено }
//#UC START# *4BB3665300BC_49ECB8E002B0_var*
//#UC END# *4BB3665300BC_49ECB8E002B0_var*
begin
//#UC START# *4BB3665300BC_49ECB8E002B0_impl*
 Result := ANSIStartsText('http://mirror2.garant.ru', LocationURL) OR
           ANSIStartsText('http://gim.garant.ru', LocationURL);
//#UC END# *4BB3665300BC_49ECB8E002B0_impl*
end;//TnsWebBrowser.ScaleDisabled

procedure TnsWebBrowser.DocumentCompleteXE(Sender: TObject;
 const pDisp: IDispatch;
 const URL: OleVariant);
//#UC START# *5175412302EE_49ECB8E002B0_var*
//#UC END# *5175412302EE_49ECB8E002B0_var*
begin
//#UC START# *5175412302EE_49ECB8E002B0_impl*
 ApplyZoom;
 ApplyScroll;
//#UC END# *5175412302EE_49ECB8E002B0_impl*
end;//TnsWebBrowser.DocumentCompleteXE

procedure TnsWebBrowser.ApplyScroll;
//#UC START# *5742C17A0340_49ECB8E002B0_var*
//#UC END# *5742C17A0340_49ECB8E002B0_var*
begin
//#UC START# *5742C17A0340_49ECB8E002B0_impl*
 if (f_ScrollPos <> -1) then //если значение по умолчанию, то не надо ничего делать
 try
  if not VarIsClear(OleObject) then
   if not VarIsClear(OleObject.Document) then
    if not VarIsClear(OleObject.Document.documentElement) then
     OleObject.Document.documentElement.ScrollTop := f_ScrollPos;
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
//#UC END# *5742C17A0340_49ECB8E002B0_impl*
end;//TnsWebBrowser.ApplyScroll

procedure TnsWebBrowser.WMSize(var aMsg: TWMSize);
//#UC START# *4E9574530051_49ECB8E002B0_var*
{$If not defined(DesignTimeLibrary)}
{$IfDef Never}
var
  Extent: TPoint;
  W, H: Integer;
  l_Res : HResult;
{$EndIf Never}
{$IfEnd}
//#UC END# *4E9574530051_49ECB8E002B0_var*
begin
//#UC START# *4E9574530051_49ECB8E002B0_impl*
 inherited;
 {$If not defined(DesignTimeLibrary)}
 {$IfDef Never}
 Exit;
 if VarIsClear{VarIsNull}(OleObject) OR
    VarIsClear{VarIsNull}(OleObject.Document) then
  Exit;
(* W := OleObject.Document.Body.OffsetWidth;
 H := OleObject.Document.Body.OffsetHeight;*)
(* W := OleObject.Document.Body.Width;
 H := OleObject.Document.Body.Height;*)
(* OleObject.Document.Body.OffsetWidth := Self.Width;
 OleObject.Document.Body.OffsetHeight := Self.Height;*)
(* W := OleObject.Document.{Window.}InnerWidth;
 H := OleObject.Document.{Window.}InnerHeight;*)
// Exit;
 if l3NeedsHackFor64System then
 begin
(*  EnumChildWindows(WindowHandle,
                   @EnumChildWindowProc,
                   LParam(LoWord(Width) + (LoWord(Height) shl 16))
                   {TMessage(aMsg).lParam});
  l_Res := THackOleControl(Self).FOleObject.GetExtent(DVASPECT_CONTENT, Extent);
  if (l_Res <> S_OK) then
   Assert(false);
  W := MulDiv(Extent.X, Screen.PixelsPerInch, 2540);
  H := MulDiv(Extent.Y, Screen.PixelsPerInch, 2540);
//  ControlInterface.Width := W;
//  ControlInterface.Height := H;
  ControlInterface.Width := Self.Width;
  ControlInterface.Height := Self.Height;*)
  ControlInterface.Refresh;
 end;//l3NeedsHackFor64System
 {$EndIf Never}
 {$IfEnd} //not DesignTimeLibrary
//#UC END# *4E9574530051_49ECB8E002B0_impl*
end;//TnsWebBrowser.WMSize

{$If NOT Defined(DesignTimeLibrary)}
procedure TnsWebBrowser.DoStyleTableChanged;
//#UC START# *4A485B710126_49ECB8E002B0_var*
//#UC END# *4A485B710126_49ECB8E002B0_var*
begin
//#UC START# *4A485B710126_49ECB8E002B0_impl*
 ApplyZoom;
//#UC END# *4A485B710126_49ECB8E002B0_impl*
end;//TnsWebBrowser.DoStyleTableChanged
{$IfEnd} // NOT Defined(DesignTimeLibrary)

constructor TnsWebBrowser.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_49ECB8E002B0_var*
//#UC END# *47D1602000C6_49ECB8E002B0_var*
begin
//#UC START# *47D1602000C6_49ECB8E002B0_impl*
 // Попытка лечения EZeroDivide из mshtml.dll от IE 10
 // http://mdp.garant.ru/pages/viewpage.action?pageId=475141873
 f_FPUCtrlWord := Get8087CW;
 Set8087CW($027F);
 inherited;
 OnDocumentComplete := {$IfDef XE}Self.DocumentCompleteXE{$Else}Self.DocumentComplete{$EndIf};
//#UC END# *47D1602000C6_49ECB8E002B0_impl*
end;//TnsWebBrowser.Create

destructor TnsWebBrowser.Destroy;
//#UC START# *48077504027E_49ECB8E002B0_var*
//#UC END# *48077504027E_49ECB8E002B0_var*
begin
//#UC START# *48077504027E_49ECB8E002B0_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=475141873
 Set8087CW(f_FPUCtrlWord);
 inherited;
//#UC END# *48077504027E_49ECB8E002B0_impl*
end;//TnsWebBrowser.Destroy

procedure TnsWebBrowser.InitFields;
//#UC START# *49F0577C02ED_49ECB8E002B0_var*
//#UC END# *49F0577C02ED_49ECB8E002B0_var*
begin
//#UC START# *49F0577C02ED_49ECB8E002B0_impl*
 inherited;
 f_Scale := 100;
 f_ScrollPos := -1;
//#UC END# *49F0577C02ED_49ECB8E002B0_impl*
end;//TnsWebBrowser.InitFields

{$If NOT Defined(NoVCL)}
procedure TnsWebBrowser.CreateWnd;
//#UC START# *4CC8414403B8_49ECB8E002B0_var*
var
 l_WinControl: TWinControl;
//#UC END# *4CC8414403B8_49ECB8E002B0_var*
begin
//#UC START# *4CC8414403B8_49ECB8E002B0_impl*
 if (f_RememberedWndHandle <> 0) then
 begin
  if (IsWindow(f_RememberedWndHandle)) then
  // - если окно с хэндлом, который запомнили ранее, существует, тогда не нужно
  // создавать его заново, а нужно присвоить в WindowHandle этот сохраненный хэндл.
  begin
   l_WinControl := TWinControl(Self);
   Assert(l_WinControl.Parent <> nil, 'У бразуера всегда должен быть Parent.');
   WindowHandle := f_RememberedWndHandle;
   f_RememberedWndHandle := 0;
   Windows.SetParent(WindowHandle,
                     l_WinControl.Parent.Handle);
   // - Ставим parent'а, иначе бразуер будет болтаться невидимым где-то в чайлдах
   // у десктопа.
   MoveWindow(WindowHandle, 0, 0, l_WinControl.Parent.Width,
                                  l_WinControl.Parent.Height, True);
   // - Чтобы произошел ресайз окна
   Exit;
   // - Реально окно создавать не нужно - оно и так есть
  end
 end;
 inherited;
//#UC END# *4CC8414403B8_49ECB8E002B0_impl*
end;//TnsWebBrowser.CreateWnd
{$IfEnd} // NOT Defined(NoVCL)

{$If NOT Defined(NoVCL)}
procedure TnsWebBrowser.DestroyWnd;
//#UC START# *4CC841540158_49ECB8E002B0_var*
//#UC END# *4CC841540158_49ECB8E002B0_var*
begin
//#UC START# *4CC841540158_49ECB8E002B0_impl*
 if (csDestroying in ComponentState) then
  inherited
 else
 begin
  // Поскольку при докинге TWebBrowser'у становится плохо - теряется Document,
  // уничтожается одно окно, а второе уезжает неведомо куда и делается невидимым,
  // ( http://mdp.garant.ru/pages/viewpage.action?pageId=556150130 )
  // Потому делаем вот аткой запил:
  // 1) На DestroyWnd ставим ему parent'ом TApplication
  // 2) Сохраняем хэндл окна в f_ActualHandle
  // 3) Обнуляем WindowHandle, чтобы вызвалось CreateWnd
  Windows.SetParent(WindowHandle, Forms.Application.Handle);
  f_RememberedWndHandle := WindowHandle;
  WindowHandle := 0;
 end;
//#UC END# *4CC841540158_49ECB8E002B0_impl*
end;//TnsWebBrowser.DestroyWnd
{$IfEnd} // NOT Defined(NoVCL)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnsWebBrowser);
 {* Регистрация TnsWebBrowser }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
