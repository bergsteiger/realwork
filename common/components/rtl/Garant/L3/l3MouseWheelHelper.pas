unit l3MouseWheelHelper;

// Модуль: "w:\common\components\rtl\Garant\L3\l3MouseWheelHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3MouseWheelHelper" MUID: (4F7ACCBE02AF)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , Windows
;

type
 Tl3MouseWheelHelper = {final} class(Tl3ProtoObject, Il3MouseWheelListener)
  protected
   procedure MouseWheelListenerNotify(Msg: PMsg;
    var theResult: Tl3HookProcResult);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function Instance: Tl3MouseWheelHelper;
    {* Метод получения экземпляра синглетона Tl3MouseWheelHelper }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3MouseWheelHelper

implementation

uses
 l3ImplUses
 , l3ListenersManager
 , Messages
 , SysUtils
 , l3Base
 //#UC START# *4F7ACCBE02AFimpl_uses*
 //#UC END# *4F7ACCBE02AFimpl_uses*
;

var g_Tl3MouseWheelHelper: Tl3MouseWheelHelper = nil;
 {* Экземпляр синглетона Tl3MouseWheelHelper }

procedure Tl3MouseWheelHelperFree;
 {* Метод освобождения экземпляра синглетона Tl3MouseWheelHelper }
begin
 l3Free(g_Tl3MouseWheelHelper);
end;//Tl3MouseWheelHelperFree

procedure Tl3MouseWheelHelper.MouseWheelListenerNotify(Msg: PMsg;
 var theResult: Tl3HookProcResult);
//#UC START# *4F79D08A02C7_4F7ACCBE02AF_var*
var
 l_Pos: TPoint;
 l_Handle: HWND;
//#UC END# *4F79D08A02C7_4F7ACCBE02AF_var*
begin
//#UC START# *4F79D08A02C7_4F7ACCBE02AF_impl*
 GetCursorPos(l_Pos);
 l_Handle := WindowFromPoint(l_Pos);
 if l_Handle <> Msg.hwnd then
 begin
  PostMessage(l_Handle, Msg.Message, Msg.wParam, Msg.lParam);
  Msg.Message := 0;
  theResult.Result := 0;
  theResult.Handled := True; 
 end;
//#UC END# *4F79D08A02C7_4F7ACCBE02AF_impl*
end;//Tl3MouseWheelHelper.MouseWheelListenerNotify

class function Tl3MouseWheelHelper.Instance: Tl3MouseWheelHelper;
 {* Метод получения экземпляра синглетона Tl3MouseWheelHelper }
begin
 if (g_Tl3MouseWheelHelper = nil) then
 begin
  l3System.AddExitProc(Tl3MouseWheelHelperFree);
  g_Tl3MouseWheelHelper := Create;
 end;
 Result := g_Tl3MouseWheelHelper;
end;//Tl3MouseWheelHelper.Instance

class function Tl3MouseWheelHelper.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3MouseWheelHelper <> nil;
end;//Tl3MouseWheelHelper.Exists

procedure Tl3MouseWheelHelper.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F7ACCBE02AF_var*
//#UC END# *479731C50290_4F7ACCBE02AF_var*
begin
//#UC START# *479731C50290_4F7ACCBE02AF_impl*
 Tl3ListenersManager.RemoveMouseWheelListener(Self);
 inherited;
//#UC END# *479731C50290_4F7ACCBE02AF_impl*
end;//Tl3MouseWheelHelper.Cleanup

procedure Tl3MouseWheelHelper.InitFields;
//#UC START# *47A042E100E2_4F7ACCBE02AF_var*
//#UC END# *47A042E100E2_4F7ACCBE02AF_var*
begin
//#UC START# *47A042E100E2_4F7ACCBE02AF_impl*
 inherited;
 Tl3ListenersManager.AddMouseWheelListener(Self);
//#UC END# *47A042E100E2_4F7ACCBE02AF_impl*
end;//Tl3MouseWheelHelper.InitFields

initialization
//#UC START# *4F7ACD2301D6*
 Tl3MouseWheelHelper.Instance;
//#UC END# *4F7ACD2301D6*

end.
