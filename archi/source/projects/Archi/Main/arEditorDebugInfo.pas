unit arEditorDebugInfo;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Main"
// Модуль: "w:/archi/source/projects/Archi/Main/arEditorDebugInfo.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi::Main::MainWindows::TarEditorDebugInfo
//
// Класс для вывода информаци о состоянии редактора в лог.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  l3Interfaces,
  l3ProtoObject,
  l3Core
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}
type
 TarEditorDebugInfo = class(Tl3ProtoObject, Il3GetMessageListener)
  {* Класс для вывода информаци о состоянии редактора в лог. }
 protected
 // realized methods
   procedure GetMessageListenerNotify(Code: Integer;
     aWParam: WPARAM;
     Msg: PMsg;
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
   class function Instance: TarEditorDebugInfo;
    {- возвращает экземпляр синглетона. }
 end;//TarEditorDebugInfo
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  l3Base {a},
  Main,
  CustEditWin,
  Windows,
  Messages
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  Classes,
  l3ListenersManager
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}


// start class TarEditorDebugInfo

var g_TarEditorDebugInfo : TarEditorDebugInfo = nil;

procedure TarEditorDebugInfoFree;
begin
 l3Free(g_TarEditorDebugInfo);
end;

class function TarEditorDebugInfo.Instance: TarEditorDebugInfo;
begin
 if (g_TarEditorDebugInfo = nil) then
 begin
  l3System.AddExitProc(TarEditorDebugInfoFree);
  g_TarEditorDebugInfo := Create;
 end;
 Result := g_TarEditorDebugInfo;
end;


class function TarEditorDebugInfo.Exists: Boolean;
 {-}
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

procedure TarEditorDebugInfo.Cleanup;
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

{$IfEnd} //AppClientSide

initialization
{$If defined(AppClientSide)}
//#UC START# *52A81A6E009E*
 TarEditorDebugInfo.Instance;
//#UC END# *52A81A6E009E*
{$IfEnd} //AppClientSide

end.