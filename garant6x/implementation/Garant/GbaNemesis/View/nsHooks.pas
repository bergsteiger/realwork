unit nsHooks;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsHooks.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Оболочка Без Прецедентов::F1 Without Usecases::View::Hooks::nsHooks
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  l3ProtoObject,
  Windows
  ;

type
 TnsHooks = {final} class(Tl3ProtoObject, Il3WndProcRetListener, Il3MouseListener)
 protected
 // realized methods
   procedure MouseListenerNotify(aMouseMessage: WPARAM;
     aHookStruct: PMouseHookStruct;
     var theResult: Tl3HookProcResult);
   procedure WndProcRetListenerNotify(Msg: PCWPRetStruct;
     var theResult: Tl3HookProcResult);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsHooks;
    {- возвращает экземпляр синглетона. }
 end;//TnsHooks
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  Messages
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  DataAdapter,
  SysUtils,
  l3ListenersManager
  ;


// start class TnsHooks

var g_TnsHooks : TnsHooks = nil;

procedure TnsHooksFree;
begin
 l3Free(g_TnsHooks);
end;

class function TnsHooks.Instance: TnsHooks;
begin
 if (g_TnsHooks = nil) then
 begin
  l3System.AddExitProc(TnsHooksFree);
  g_TnsHooks := Create;
 end;
 Result := g_TnsHooks;
end;


class function TnsHooks.Exists: Boolean;
 {-}
begin
 Result := g_TnsHooks <> nil;
end;//TnsHooks.Exists

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

procedure TnsHooks.Cleanup;
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
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
//#UC START# *4F79540E0255*
 TnsHooks.Instance;
//#UC END# *4F79540E0255*
{$IfEnd} //not Admin AND not Monitorings

end.