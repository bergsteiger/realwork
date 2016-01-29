unit vcmCalendarForm;
{* Форма выбора даты. }

{ Библиотека : "vcm"            }
{ Автор      : Марков. А.       }
{ Начат      : 14.03.2003 17:06 }
{ Версия     : $Id: vcmCalendarForm.pas,v 1.4 2012/03/21 18:08:43 lulin Exp $ }

// $Log: vcmCalendarForm.pas,v $
// Revision 1.4  2012/03/21 18:08:43  lulin
// {RequestLink:349116364}
//
// Revision 1.3  2009/10/01 14:58:33  lulin
// - убираем сферического коня в вакууме.
//
// Revision 1.2  2007/05/28 06:33:44  oman
// - Не собиралась библиотека
//
// Revision 1.1  2007/05/25 14:52:13  mmorozov
// - change: изменения связанные с использованием операции типа дата (vcm_otDate) в панели задач (CQ: OIT5-25342);
//

{$Include vcmDefine.inc}

interface

uses
  Controls,
  Messages,
  Forms,

  vtDateEdit
  ;

type
  TvcmCalendarForm = class(TvtCalendarForm)
  protected
   procedure CreateParams(var aParams: TCreateParams);
     override;
     {-}
   procedure WndProc(var aMessage: TMessage);
     override;
     {-}
   procedure DoClose(var Action: TCloseAction);
     override;
     {-}
  end;//TvcmCalendarForm

implementation

uses
  Classes,
  Windows
  ;
  
procedure TvcmCalendarForm.CreateParams(var aParams: TCreateParams);
begin
 inherited;
 if not (csDesigning in ComponentState) then
  with aParams do
  begin
   Style := Style and not(WS_MINIMIZEBOX) or WS_POPUP;
   ExStyle := ExStyle and not(WS_EX_TOOLWINDOW);
   if ((Owner <> nil) and (Owner is TWinControl)) then
    WndParent := (Owner as TWinControl).Handle;
  end;
end;

procedure TvcmCalendarForm.WndProc(var aMessage: TMessage);
const
 WM_REACTIVATE_FORM = WM_USER+$0900;
 //
 function IsActivateAppMessage: Boolean;
 begin
  Result := ((aMessage.Msg = WM_ACTIVATEAPP) and TWMActivateApp(aMessage).Active);
 end;
 //
 function IsDeactivateAppMessage: Boolean;
 begin
  Result := ((aMessage.Msg = WM_ACTIVATEAPP) and not(TWMActivateApp(aMessage).Active));
 end;
 //
 function IsReactivateFormMessage: Boolean;
 begin
  Result := ((aMessage.Msg = WM_REACTIVATE_FORM) and (GetActiveWindow <> Handle));
 end;
 //
function IsSetCursorByLeftButtonMessage: Boolean;
 begin
  Result := ((aMessage.Msg = WM_SETCURSOR) and (aMessage.LParamHi = WM_LBUTTONDOWN) and not(IsWindowEnabled(Handle)));
 end;
 //
 function HasFormModalState: Boolean;
 begin
  Result := ((fsModal in FormState) and IsWindowEnabled(Handle) and IsWindowVisible(Handle));
 end;
 //
 function IsMainMinimized : Boolean;
 var
  lPlacement: TWindowPlacement;
 begin
  Result := False;
  if (Application.MainForm = nil) then Exit;

  with Application.MainForm do
   if HandleAllocated then
   begin
    lPlacement.length := SizeOf(TWindowPlacement);
    GetWindowPlacement(Handle, @lPlacement);
    if lPlacement.showCmd = SW_SHOWMINIMIZED then
     Result := True;
   end;
 end;

begin
 if not(csDesigning in ComponentState) then
 begin
  if IsActivateAppMessage then
  begin
   if HasFormModalState then
   begin
    aMessage.Result := 0;
    PostMessage(Handle, WM_REACTIVATE_FORM, 0, 0);
    Exit;
   end
   else
    if False{HasFormFloatingZoneTypeAndVisible} then
     if not IsMainMinimized then
      SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW)
     else
      SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
  end
  else
   if IsDeactivateAppMessage then
   begin
    if False{HasFormFloatingZoneTypeAndVisible} then
     SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_HIDEWINDOW);
   end
   else
    if IsSetCursorByLeftButtonMessage then
    begin
     with Screen do
      if (ActiveForm <> nil) then
       with ActiveForm do
        if (Handle <> HWND(0)) and IsWindowEnabled(Handle) then
        begin
         PostMessage(Handle, WM_REACTIVATE_FORM, 0, 0);
         aMessage.Result := 0;
         Exit;
        end;
    end
    else
     if IsReactivateFormMessage then
     begin
      aMessage.Result := 0;
      SetWindowPos(Handle, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_NOACTIVATE or SWP_SHOWWINDOW);
      SetActiveWindow(Handle);
      Exit;
     end;
 end;
 //
 inherited;
end;

procedure TvcmCalendarForm.DoClose(var Action: TCloseAction);
 {-}
begin
 inherited;
 Action := caHide;
end;

end.