unit npNavigatorList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT$WithVCM"
// Модуль: "w:/common/components/gui/Garant/VT/npNavigatorList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VT$WithVCM::vtNavigator::TnpNavigatorList
//
// список навигаторов созданных в приложении. Список используется для рассылки сообщений
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  npNavigatorListCBT,
  l3Core,
  Windows
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TnpNavigatorList = class(TnpNavigatorListCBT, Il3WndProcListener, Il3GetMessageListener)
  {* список навигаторов созданных в приложении. Список используется для рассылки сообщений }
 protected
 // realized methods
   procedure GetMessageListenerNotify(Code: Integer;
     aWParam: WPARAM;
     Msg: PMsg;
     var theResult: Tl3HookProcResult);
   procedure WndProcListenerNotify(Msg: PCWPStruct;
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
   class function Instance: TnpNavigatorList;
    {- возвращает экземпляр синглетона. }
 end;//TnpNavigatorList
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base {a},
  l3ListenersManager,
  Messages
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}


// start class TnpNavigatorList

var g_TnpNavigatorList : TnpNavigatorList = nil;

procedure TnpNavigatorListFree;
begin
 l3Free(g_TnpNavigatorList);
end;

class function TnpNavigatorList.Instance: TnpNavigatorList;
begin
 if (g_TnpNavigatorList = nil) then
 begin
  l3System.AddExitProc(TnpNavigatorListFree);
  g_TnpNavigatorList := Create;
 end;
 Result := g_TnpNavigatorList;
end;


class function TnpNavigatorList.Exists: Boolean;
 {-}
begin
 Result := g_TnpNavigatorList <> nil;
end;//TnpNavigatorList.Exists

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

procedure TnpNavigatorList.Cleanup;
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

{$IfEnd} //not NoVCM

end.