unit npNavigatorList;
 {* список навигаторов созданных в приложении. Список используется для рассылки сообщений }

// Модуль: "w:\common\components\gui\Garant\VT\npNavigatorList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnpNavigatorList" MUID: (4F61E03003CF)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , npNavigatorListCBT
 , l3Interfaces
 , l3Core
 , Windows
;

type
 TnpNavigatorList = class(TnpNavigatorListCBT, Il3WndProcListener, Il3GetMessageListener)
  {* список навигаторов созданных в приложении. Список используется для рассылки сообщений }
  protected
   procedure GetMessageListenerNotify(Code: Integer;
    aWParam: WPARAM;
    Msg: PMsg;
    var theResult: Tl3HookProcResult);
   procedure WndProcListenerNotify(Msg: PCWPStruct;
    var theResult: Tl3HookProcResult);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function Instance: TnpNavigatorList;
    {* Метод получения экземпляра синглетона TnpNavigatorList }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnpNavigatorList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3ListenersManager
 , Messages
 , SysUtils
 , l3Base
 //#UC START# *4F61E03003CFimpl_uses*
 //#UC END# *4F61E03003CFimpl_uses*
;

var g_TnpNavigatorList: TnpNavigatorList = nil;
 {* Экземпляр синглетона TnpNavigatorList }

procedure TnpNavigatorListFree;
 {* Метод освобождения экземпляра синглетона TnpNavigatorList }
begin
 l3Free(g_TnpNavigatorList);
end;//TnpNavigatorListFree

procedure TnpNavigatorList.GetMessageListenerNotify(Code: Integer;
 aWParam: WPARAM;
 Msg: PMsg;
 var theResult: Tl3HookProcResult);
//#UC START# *4F62032D0058_4F61E03003CF_var*
var
 l_Index : Integer;
//#UC END# *4F62032D0058_4F61E03003CF_var*
begin
//#UC START# *4F62032D0058_4F61E03003CF_impl*
 case Msg.message of
  WM_MOUSEMOVE, WM_LBUTTONUP, WM_LBUTTONDOWN :
   for l_Index := 0 to Pred(Count) do
    Items[l_Index].hGetMessage(Msg);
 end;//case Msg.message
//#UC END# *4F62032D0058_4F61E03003CF_impl*
end;//TnpNavigatorList.GetMessageListenerNotify

procedure TnpNavigatorList.WndProcListenerNotify(Msg: PCWPStruct;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79CF3400BB_4F61E03003CF_var*
var
 l_Index : Integer;
 l_Msg: TMsg;
//#UC END# *4F79CF3400BB_4F61E03003CF_var*
begin
//#UC START# *4F79CF3400BB_4F61E03003CF_impl*
 l3FillChar(l_Msg, SizeOf(TMsg));
 l_Msg.hwnd    := Msg.hwnd;
 l_Msg.lParam  := Msg.lParam;
 l_Msg.message := Msg.message;
 l_Msg.wParam  := Msg.wParam;
 for l_Index := 0 to Pred(Count) do
  Items[l_Index].hGetMessage(@l_Msg);
//#UC END# *4F79CF3400BB_4F61E03003CF_impl*
end;//TnpNavigatorList.WndProcListenerNotify

class function TnpNavigatorList.Instance: TnpNavigatorList;
 {* Метод получения экземпляра синглетона TnpNavigatorList }
begin
 if (g_TnpNavigatorList = nil) then
 begin
  l3System.AddExitProc(TnpNavigatorListFree);
  g_TnpNavigatorList := Create;
 end;
 Result := g_TnpNavigatorList;
end;//TnpNavigatorList.Instance

class function TnpNavigatorList.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnpNavigatorList <> nil;
end;//TnpNavigatorList.Exists

procedure TnpNavigatorList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F61E03003CF_var*
//#UC END# *479731C50290_4F61E03003CF_var*
begin
//#UC START# *479731C50290_4F61E03003CF_impl*
 Tl3ListenersManager.RemoveWndProcListener(Self);
 Tl3ListenersManager.RemoveGetMessageListener(Self);
 inherited;
//#UC END# *479731C50290_4F61E03003CF_impl*
end;//TnpNavigatorList.Cleanup

procedure TnpNavigatorList.InitFields;
//#UC START# *47A042E100E2_4F61E03003CF_var*
//#UC END# *47A042E100E2_4F61E03003CF_var*
begin
//#UC START# *47A042E100E2_4F61E03003CF_impl*
 inherited;
 Tl3ListenersManager.AddWndProcListener(Self);
 Tl3ListenersManager.AddGetMessageListener(Self)
//#UC END# *47A042E100E2_4F61E03003CF_impl*
end;//TnpNavigatorList.InitFields
{$IfEnd} // NOT Defined(NoVCM)

end.
