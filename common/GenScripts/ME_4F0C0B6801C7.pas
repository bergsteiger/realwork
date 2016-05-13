unit NOT_COMPLETED_DragData;

// Модуль: "w:\common\components\gui\Garant\VT\NOT_COMPLETED_DragData.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "DragData" MUID: (4F0C0B6801C7)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , Messages
 , Windows
 , l3Except
 , l3Base
 , l3Interfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
;

const
 wm_DropAccept = Messages.WM_USER + $100;
 wm_DropAccepted = Messages.WM_USER + $101;
 cnActiveState = [dsActive, dsPaused];

type
 TDragDataState = (
  dsPassive
  , dsActive
  , dsPaused
 );//TDragDataState

 TGetCursorByType = function(DDType: Integer): HCURSOR;

 EDragInProcess = class(El3NoLoggedException)
  public
   constructor Create; reintroduce;
 end;//EDragInProcess

 TDragDataSupport = class(Tl3Base, Il3WndProcListener, Il3WndProcRetListener, Il3MouseListener)
  private
   f_PrevMRecurse: Boolean;
   f_PrevWRecurse: Boolean;
   f_NeedStop: Boolean;
   f_DCursor: HCURSOR;
   f_DragDataType: Integer;
   f_DragData: Pointer;
   f_AnswerData: Pointer;
   f_SourceControl: TControl;
   f_DragState: TDragDataState;
   f_DragSuccess: Boolean;
   f_OnDragStop: TNotifyEvent;
   f_OnGetCursorByType: TGetCursorByType;
  private
   procedure InitListeners;
   procedure RemoveListeners;
  protected
   procedure pm_SetDragDataType(aValue: Integer);
   procedure pm_SetDragData(aValue: Pointer);
   procedure MouseListenerNotify(aMouseMessage: WPARAM;
    aHookStruct: PMouseHookStruct;
    var theResult: Tl3HookProcResult);
   procedure WndProcListenerNotify(Msg: PCWPStruct;
    var theResult: Tl3HookProcResult);
   procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
    var theResult: Tl3HookProcResult);
  public
   function DoDrop(aDestControl: TControl = nil): Boolean;
   function Execute(SrcControl: TControl): Boolean;
   procedure RunDragData(SrcControl: TControl);
   procedure Stop(aSuccess: Boolean);
   procedure Pause;
   procedure Restore;
   procedure CheckInProgress;
   class function Instance: TDragDataSupport;
    {* Метод получения экземпляра синглетона TDragDataSupport }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property DCursor: HCURSOR
    read f_DCursor
    write f_DCursor;
   property DragDataType: Integer
    read f_DragDataType
    write pm_SetDragDataType;
   property DragData: Pointer
    read f_DragData
    write pm_SetDragData;
   property AnswerData: Pointer
    read f_AnswerData
    write f_AnswerData;
   property SourceControl: TControl
    read f_SourceControl;
   property DragState: TDragDataState
    read f_DragState;
   property DragSuccess: Boolean
    read f_DragSuccess;
   property OnDragStop: TNotifyEvent
    read f_OnDragStop
    write f_OnDragStop;
   property OnGetCursorByType: TGetCursorByType
    read f_OnGetCursorByType
    write f_OnGetCursorByType;
 end;//TDragDataSupport

implementation

uses
 l3ImplUses
 , afwFacade
 , l3ListenersManager
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , kwVTControlsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , SysUtils
;

var g_TDragDataSupport: TDragDataSupport = nil;
 {* Экземпляр синглетона TDragDataSupport }

procedure TDragDataSupportFree;
 {* Метод освобождения экземпляра синглетона TDragDataSupport }
begin
 l3Free(g_TDragDataSupport);
end;//TDragDataSupportFree

constructor EDragInProcess.Create;
//#UC START# *5530C7180149_552FCE4601AC_var*
//#UC END# *5530C7180149_552FCE4601AC_var*
begin
//#UC START# *5530C7180149_552FCE4601AC_impl*
 inherited Create('Предыдущая операция переноса не завершена!');
//#UC END# *5530C7180149_552FCE4601AC_impl*
end;//EDragInProcess.Create

procedure TDragDataSupport.pm_SetDragDataType(aValue: Integer);
//#UC START# *552FD2B903C5_4F0C0B870141set_var*
var
 lCursor: HCURSOR;
//#UC END# *552FD2B903C5_4F0C0B870141set_var*
begin
//#UC START# *552FD2B903C5_4F0C0B870141set_impl*
 f_DragDataType := aValue;
 lCursor := 0;
 if Assigned(f_OnGetCursorByType) then
 begin
  lCursor := f_OnGetCursorByType(f_DragDataType);
  if lCursor > 0 then
   f_DCursor := lCursor;
 end;
 if lCursor = 0 then
  f_DCursor := Screen.Cursors[crDefault];
//#UC END# *552FD2B903C5_4F0C0B870141set_impl*
end;//TDragDataSupport.pm_SetDragDataType

procedure TDragDataSupport.pm_SetDragData(aValue: Pointer);
//#UC START# *552FD48A0290_4F0C0B870141set_var*
//#UC END# *552FD48A0290_4F0C0B870141set_var*
begin
//#UC START# *552FD48A0290_4F0C0B870141set_impl*
 CheckInProgress;
 Stop(False);
 f_DragData := aValue;
//#UC END# *552FD48A0290_4F0C0B870141set_impl*
end;//TDragDataSupport.pm_SetDragData

procedure TDragDataSupport.InitListeners;
//#UC START# *552FDEE30376_4F0C0B870141_var*
//#UC END# *552FDEE30376_4F0C0B870141_var*
begin
//#UC START# *552FDEE30376_4F0C0B870141_impl*
 if Win32Platform = VER_PLATFORM_WIN32_NT
  then Tl3ListenersManager.AddWndProcRetListener(Self)
  else Tl3ListenersManager.AddWndProcListener(Self);   
 Tl3ListenersManager.AddMouseListener(Self);
//#UC END# *552FDEE30376_4F0C0B870141_impl*
end;//TDragDataSupport.InitListeners

procedure TDragDataSupport.RemoveListeners;
//#UC START# *552FDEFB010E_4F0C0B870141_var*
//#UC END# *552FDEFB010E_4F0C0B870141_var*
begin
//#UC START# *552FDEFB010E_4F0C0B870141_impl*
 Tl3ListenersManager.RemoveWndProcRetListener(Self);
 Tl3ListenersManager.RemoveWndProcListener(Self);
 Tl3ListenersManager.RemoveMouseListener(Self);
//#UC END# *552FDEFB010E_4F0C0B870141_impl*
end;//TDragDataSupport.RemoveListeners

function TDragDataSupport.DoDrop(aDestControl: TControl = nil): Boolean;
//#UC START# *552FDF3003B5_4F0C0B870141_var*
var
 lParentForm: TCustomForm;
 lShiftMode: Boolean;
//#UC END# *552FDF3003B5_4F0C0B870141_var*
begin
//#UC START# *552FDF3003B5_4F0C0B870141_impl*
 Result := False;
 lShiftMode := GetKeyState(VK_SHIFT) < 0;

 if f_DragState = dsActive then
 try
  Windows.SetCursor(Screen.Cursors[crHourGlass]);
  if aDestControl <> nil then
  begin
   try
    Result := aDestControl.Perform(wm_DropAccept, DragDataType, Integer(Self)) <> 0;
   except
    Result := False;
   end;
   if not Result then
   begin
    lParentForm := GetParentForm(aDestControl);

    if lParentForm <> nil then
    try
     Result := lParentForm.Perform(wm_DropAccept, DragDataType, Integer(aDestControl)) > 0;
    except
     Result := False;
    end;
   end;
  end
  else
   Result := True;
  if Result and (f_SourceControl <> nil) then
  begin
   Pause;
   Result := f_SourceControl.Perform(wm_DropAccepted, DragDataType, Integer(Self)) >= 0;
  end;

  if Result and not lShiftMode then
   Stop(True);

 finally
  Restore; // if was paused
  Windows.SetCursor(DCursor);
 end;
//#UC END# *552FDF3003B5_4F0C0B870141_impl*
end;//TDragDataSupport.DoDrop

function TDragDataSupport.Execute(SrcControl: TControl): Boolean;
//#UC START# *552FDF5D03B3_4F0C0B870141_var*
//#UC END# *552FDF5D03B3_4F0C0B870141_var*
begin
//#UC START# *552FDF5D03B3_4F0C0B870141_impl*
 RunDragData(SrcControl);
 while f_DragState in cnActiveState do
  afw.ProcessMessages;
 Result := f_DragSuccess;
//#UC END# *552FDF5D03B3_4F0C0B870141_impl*
end;//TDragDataSupport.Execute

procedure TDragDataSupport.RunDragData(SrcControl: TControl);
//#UC START# *552FDF8E01C9_4F0C0B870141_var*
//#UC END# *552FDF8E01C9_4F0C0B870141_var*
begin
//#UC START# *552FDF8E01C9_4F0C0B870141_impl*
 f_PrevMRecurse := False;
 f_PrevWRecurse := False;
 f_NeedStop := False;

 CheckInProgress;
 f_SourceControl := SrcControl;
 InitListeners;
 Windows.SetCursor(DCursor);
 f_DragSuccess := False;
 f_DragState := dsActive;
//#UC END# *552FDF8E01C9_4F0C0B870141_impl*
end;//TDragDataSupport.RunDragData

procedure TDragDataSupport.Stop(aSuccess: Boolean);
//#UC START# *552FDFF10077_4F0C0B870141_var*
//#UC END# *552FDFF10077_4F0C0B870141_var*
begin
//#UC START# *552FDFF10077_4F0C0B870141_impl*
 if f_DragState in cnActiveState then
 begin
  f_DragState := dsPassive;
  f_DragSuccess := aSuccess;
  RemoveListeners;
  //SetCaptureControl(nil); //fix problem with csCaptureMouse
  DragDataType := 0;
  //Windows.SetCursor(Screen.Cursors[crDefault]);
  if Assigned(f_OnDragStop) then
   f_OnDragStop(Self);
 end;
//#UC END# *552FDFF10077_4F0C0B870141_impl*
end;//TDragDataSupport.Stop

procedure TDragDataSupport.Pause;
//#UC START# *552FE00B02AA_4F0C0B870141_var*
//#UC END# *552FE00B02AA_4F0C0B870141_var*
begin
//#UC START# *552FE00B02AA_4F0C0B870141_impl*
 if f_DragState = dsActive then
 begin
  f_DragState := dsPaused;
  RemoveListeners;
 end;
//#UC END# *552FE00B02AA_4F0C0B870141_impl*
end;//TDragDataSupport.Pause

procedure TDragDataSupport.Restore;
//#UC START# *552FE0130188_4F0C0B870141_var*
//#UC END# *552FE0130188_4F0C0B870141_var*
begin
//#UC START# *552FE0130188_4F0C0B870141_impl*
 if f_DragState = dsPaused then
 begin
  f_DragState := dsActive;
  InitListeners;
 end;
//#UC END# *552FE0130188_4F0C0B870141_impl*
end;//TDragDataSupport.Restore

procedure TDragDataSupport.CheckInProgress;
//#UC START# *552FE01A0138_4F0C0B870141_var*
//#UC END# *552FE01A0138_4F0C0B870141_var*
begin
//#UC START# *552FE01A0138_4F0C0B870141_impl*
 if f_DragState in cnActiveState then
  raise EDragInProcess.Create;
//#UC END# *552FE01A0138_4F0C0B870141_impl*
end;//TDragDataSupport.CheckInProgress

procedure TDragDataSupport.MouseListenerNotify(aMouseMessage: WPARAM;
 aHookStruct: PMouseHookStruct;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79CEDF005A_4F0C0B870141_var*
var
 DestCtrl: TControl;
//#UC END# *4F79CEDF005A_4F0C0B870141_var*
begin
//#UC START# *4F79CEDF005A_4F0C0B870141_impl*
 if ((aMouseMessage = WM_LBUTTONDOWN) or (aMouseMessage = WM_NCLBUTTONDOWN) or
     (aMouseMessage = WM_RBUTTONDOWN) or (aMouseMessage = WM_NCRBUTTONDOWN) or
     (aMouseMessage = WM_RBUTTONUP) or (aMouseMessage = WM_NCRBUTTONUP)) and
    f_PrevMRecurse then
  Exit;

 try
  f_PrevMRecurse := True;
  try
   if (aMouseMessage = WM_LBUTTONDOWN) or (aMouseMessage = WM_NCLBUTTONDOWN) then
    if GetKeyState(VK_MENU) < 0 then
    begin
     DestCtrl := FindDragTarget(aHookStruct.Pt, False);
     try
      If (DestCtrl <> nil) then Self.DoDrop(DestCtrl);
     except
      theResult.Result := 0;
     end;
     Exit;
    end;

   if (aMouseMessage = WM_RBUTTONDOWN) or (aMouseMessage = WM_NCRBUTTONDOWN) then
    if GetKeyState(VK_MENU) < 0 then
    begin
     f_NeedStop := True;
     theResult.Result := 1;
     theResult.Handled := True;
     Exit;
    end;

   if (aMouseMessage = WM_RBUTTONUP) or (aMouseMessage = WM_NCRBUTTONUP) then
   begin
    if f_NeedStop then
    begin
     f_NeedStop := False;
     if GetKeyState(VK_MENU) < 0 then
     begin
      Self.Stop(False);
      //PMouseHookStruct(LParam)^.hwnd := 0;
      theResult.Result := 1;
      theResult.Handled := True;
      Exit;
     end;
    end;
   end;
  finally
   f_PrevMRecurse := False;
  end;
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
//#UC END# *4F79CEDF005A_4F0C0B870141_impl*
end;//TDragDataSupport.MouseListenerNotify

procedure TDragDataSupport.WndProcListenerNotify(Msg: PCWPStruct;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79CF3400BB_4F0C0B870141_var*
//#UC END# *4F79CF3400BB_4F0C0B870141_var*
begin
//#UC START# *4F79CF3400BB_4F0C0B870141_impl*
 if (Msg.message = WM_SETCURSOR) and (SmallInt(Msg.lParam) = HTCLIENT) then
 try
  Windows.SetCursor(DCursor);
  Msg.message := WM_NULL;
  theResult.Result := 1;
  theResult.Handled := True;
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
//#UC END# *4F79CF3400BB_4F0C0B870141_impl*
end;//TDragDataSupport.WndProcListenerNotify

procedure TDragDataSupport.WndProcRetListenerNotify(Msg: PCWPRetStruct;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79CF9200A0_4F0C0B870141_var*
//#UC END# *4F79CF9200A0_4F0C0B870141_var*
begin
//#UC START# *4F79CF9200A0_4F0C0B870141_impl*
 if (Msg.message = WM_SETCURSOR) and (SmallInt(Msg.lParam) = HTCLIENT) then
 try
  Windows.SetCursor(DCursor);
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
//#UC END# *4F79CF9200A0_4F0C0B870141_impl*
end;//TDragDataSupport.WndProcRetListenerNotify

class function TDragDataSupport.Instance: TDragDataSupport;
 {* Метод получения экземпляра синглетона TDragDataSupport }
begin
 if (g_TDragDataSupport = nil) then
 begin
  l3System.AddExitProc(TDragDataSupportFree);
  g_TDragDataSupport := Create;
 end;
 Result := g_TDragDataSupport;
end;//TDragDataSupport.Instance

class function TDragDataSupport.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TDragDataSupport <> nil;
end;//TDragDataSupport.Exists

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(EDragInProcess);
 {* Регистрация EDragInProcess }
{$IfEnd} // NOT Defined(NoScripts)

end.
