unit nsHooks;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsHooks.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsHooks" MUID: (4AA8D62102F5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , Windows
;

type
 TnsHooks = {final} class(Tl3ProtoObject, Il3WndProcRetListener, Il3MouseListener)
  protected
   procedure MouseListenerNotify(aMouseMessage: WPARAM;
    aHookStruct: PMouseHookStruct;
    var theResult: Tl3HookProcResult);
   procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
    var theResult: Tl3HookProcResult);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function Instance: TnsHooks;
    {* Метод получения экземпляра синглетона TnsHooks }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsHooks
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , Messages
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , DataAdapter
 , SysUtils
 , l3ListenersManager
 , l3Base
;

var g_TnsHooks: TnsHooks = nil;
 {* Экземпляр синглетона TnsHooks }

procedure TnsHooksFree;
 {* Метод освобождения экземпляра синглетона TnsHooks }
begin
 l3Free(g_TnsHooks);
end;//TnsHooksFree

procedure TnsHooks.MouseListenerNotify(aMouseMessage: WPARAM;
 aHookStruct: PMouseHookStruct;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79CEDF005A_4F7951BC01DF_var*
const
 c_ServerNames: array [1..1] of string = ('Internet Explorer_Server');
var
 l_ClassName: array [0..255] of Char;
 l_Index: Integer;
//#UC END# *4F79CEDF005A_4F7951BC01DF_var*
begin
//#UC START# *4F79CEDF005A_4F7951BC01DF_impl*
 if (aMouseMessage = WM_RBUTTONDOWN) or (aMouseMessage = WM_RBUTTONUP) then
 begin
  GetClassName(aHookStruct.hwnd, l_ClassName, SizeOf(l_ClassName));
  for l_Index := Low(c_ServerNames) to High(c_ServerNames) do
   if (StrComp(@l_ClassName[0], PChar(c_ServerNames[l_Index])) = 0) then
   begin
    theResult.Result := HC_SKIP;
    theResult.Handled := True;
   end;//StrComp(@l_ClassName[0], PChar(c_ServerNames[l_Index])) = 0
 end;//(aMouseMessage = WM_RBUTTONDOWN) or (aMouseMessage = WM_RBUTTONUP)
//#UC END# *4F79CEDF005A_4F7951BC01DF_impl*
end;//TnsHooks.MouseListenerNotify

procedure TnsHooks.WndProcRetListenerNotify(Msg: PCWPRetStruct;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79CF9200A0_4F7951BC01DF_var*
//#UC END# *4F79CF9200A0_4F7951BC01DF_var*
begin
//#UC START# *4F79CF9200A0_4F7951BC01DF_impl*
 try
  if ((Msg.Message = WM_QUERYENDSESSION) and
      LongBool(Msg.lResult) and
      (Msg.hwnd = Application.Handle)) then
   try
    try
     g_ShowFinalSplash := False; // блокируем показ финального сплеша
     GlobalCrashCleanup;
    finally
     GlobalDone;
    end;//try..finally
   finally
    TerminateProcess(GetCurrentProcess, 255);
   end;//try..finally
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;//try..except
//#UC END# *4F79CF9200A0_4F7951BC01DF_impl*
end;//TnsHooks.WndProcRetListenerNotify

class function TnsHooks.Instance: TnsHooks;
 {* Метод получения экземпляра синглетона TnsHooks }
begin
 if (g_TnsHooks = nil) then
 begin
  l3System.AddExitProc(TnsHooksFree);
  g_TnsHooks := Create;
 end;
 Result := g_TnsHooks;
end;//TnsHooks.Instance

class function TnsHooks.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsHooks <> nil;
end;//TnsHooks.Exists

procedure TnsHooks.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F7951BC01DF_var*
//#UC END# *479731C50290_4F7951BC01DF_var*
begin
//#UC START# *479731C50290_4F7951BC01DF_impl*
 Tl3ListenersManager.RemoveMouseListener(Self);
 Tl3ListenersManager.RemoveWndProcRetListener(Self);
 inherited;
//#UC END# *479731C50290_4F7951BC01DF_impl*
end;//TnsHooks.Cleanup

procedure TnsHooks.InitFields;
//#UC START# *47A042E100E2_4F7951BC01DF_var*
//#UC END# *47A042E100E2_4F7951BC01DF_var*
begin
//#UC START# *47A042E100E2_4F7951BC01DF_impl*
 inherited;
 Tl3ListenersManager.AddMouseListener(Self);
 Tl3ListenersManager.AddWndProcRetListener(Self);
//#UC END# *47A042E100E2_4F7951BC01DF_impl*
end;//TnsHooks.InitFields

initialization
//#UC START# *4F79540E0255*
 TnsHooks.Instance;
//#UC END# *4F79540E0255*
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
