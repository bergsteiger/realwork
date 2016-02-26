unit arEditorDebugInfo;
 {* Класс для вывода информаци о состоянии редактора в лог. }

// Модуль: "w:\archi\source\projects\Archi\Main\arEditorDebugInfo.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , l3Core
;

type
 TarEditorDebugInfo = class(Tl3ProtoObject, Il3GetMessageListener)
  {* Класс для вывода информаци о состоянии редактора в лог. }
  protected
   procedure GetMessageListenerNotify(Code: Integer;
    aWParam: WPARAM;
    Msg: PMsg;
    var theResult: Tl3HookProcResult);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TarEditorDebugInfo;
    {* Метод получения экземпляра синглетона TarEditorDebugInfo }
 end;//TarEditorDebugInfo
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , Main
 , CustEditWin
 , Windows
 , Messages
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 , l3ListenersManager
 , SysUtils
 , l3Base
;

var g_TarEditorDebugInfo: TarEditorDebugInfo = nil;
 {* Экземпляр синглетона TarEditorDebugInfo }

procedure TarEditorDebugInfoFree;
 {* Метод освобождения экземпляра синглетона TarEditorDebugInfo }
begin
 l3Free(g_TarEditorDebugInfo);
end;//TarEditorDebugInfoFree

class function TarEditorDebugInfo.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TarEditorDebugInfo <> nil;
end;//TarEditorDebugInfo.Exists

procedure TarEditorDebugInfo.GetMessageListenerNotify(Code: Integer;
 aWParam: WPARAM;
 Msg: PMsg;
 var theResult: Tl3HookProcResult);
//#UC START# *4F62032D0058_52A7FD0E002D_var*
var
 l_Editor: TCustomEditorWindow;
//#UC END# *4F62032D0058_52A7FD0E002D_var*
begin
//#UC START# *4F62032D0058_52A7FD0E002D_impl*
 if (Msg.Message = WM_KEYDOWN) and (Msg.wParam = VK_F11) and (KeyDataToShiftState(Msg.lParam) = [ssShift, ssAlt, ssCtrl]) then
  if MainForm.ActiveMDIChild is TCustomEditorWindow then
  begin
   l_Editor := MainForm.ActiveMDIChild as TCustomEditorWindow;
   l_Editor.SaveState2Log;
  end; // if MainForm.ActiveMDIChild is TCustomEditorWindow then
//#UC END# *4F62032D0058_52A7FD0E002D_impl*
end;//TarEditorDebugInfo.GetMessageListenerNotify

class function TarEditorDebugInfo.Instance: TarEditorDebugInfo;
 {* Метод получения экземпляра синглетона TarEditorDebugInfo }
begin
 if (g_TarEditorDebugInfo = nil) then
 begin
  l3System.AddExitProc(TarEditorDebugInfoFree);
  g_TarEditorDebugInfo := Create;
 end;
 Result := g_TarEditorDebugInfo;
end;//TarEditorDebugInfo.Instance

procedure TarEditorDebugInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_52A7FD0E002D_var*
//#UC END# *479731C50290_52A7FD0E002D_var*
begin
//#UC START# *479731C50290_52A7FD0E002D_impl*
 Tl3ListenersManager.RemoveGetMessageListener(Self);
 inherited;
//#UC END# *479731C50290_52A7FD0E002D_impl*
end;//TarEditorDebugInfo.Cleanup

procedure TarEditorDebugInfo.InitFields;
//#UC START# *47A042E100E2_52A7FD0E002D_var*
//#UC END# *47A042E100E2_52A7FD0E002D_var*
begin
//#UC START# *47A042E100E2_52A7FD0E002D_impl*
 inherited;
 Tl3ListenersManager.AddGetMessageListener(Self);
//#UC END# *47A042E100E2_52A7FD0E002D_impl*
end;//TarEditorDebugInfo.InitFields

initialization
//#UC START# *52A81A6E009E*
 TarEditorDebugInfo.Instance;
//#UC END# *52A81A6E009E*
{$IfEnd} // Defined(AppClientSide)

end.
