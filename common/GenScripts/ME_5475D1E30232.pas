unit l3ProcessMessagesManager;
 {* Список окон, которым надо обрабатывать сообщения в длинных процессах.
Используется в случаях, когда afw.ProcessMessages приводит к проблемам. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3ProcessMessagesManager.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
 , l3LongintList
 , Windows
;

type
 Tl3ProcessMessagesManager = class(Tl3SimpleObject)
  {* Список окон, которым надо обрабатывать сообщения в длинных процессах.
Используется в случаях, когда afw.ProcessMessages приводит к проблемам. }
  private
   f_Handles: Tl3LongintList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure Subscribe(aHandle: THandle);
   procedure Unsubscribe(aHandle: THandle);
   procedure ProcessMessages(wMsgFilterMin: LongWord;
    wMsgFilterMax: LongWord;
    wRemoveMsg: LongWord);
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tl3ProcessMessagesManager;
    {* Метод получения экземпляра синглетона Tl3ProcessMessagesManager }
 end;//Tl3ProcessMessagesManager

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
;

var g_Tl3ProcessMessagesManager: Tl3ProcessMessagesManager = nil;
 {* Экземпляр синглетона Tl3ProcessMessagesManager }

procedure Tl3ProcessMessagesManagerFree;
 {* Метод освобождения экземпляра синглетона Tl3ProcessMessagesManager }
begin
 l3Free(g_Tl3ProcessMessagesManager);
end;//Tl3ProcessMessagesManagerFree

procedure Tl3ProcessMessagesManager.Subscribe(aHandle: THandle);
//#UC START# *5475D2910227_5475D1E30232_var*
//#UC END# *5475D2910227_5475D1E30232_var*
begin
//#UC START# *5475D2910227_5475D1E30232_impl*
 if not Assigned(f_Handles) then
  f_Handles := Tl3LongintList.Create;
 f_Handles.Add(Integer(aHandle));
//#UC END# *5475D2910227_5475D1E30232_impl*
end;//Tl3ProcessMessagesManager.Subscribe

procedure Tl3ProcessMessagesManager.Unsubscribe(aHandle: THandle);
//#UC START# *5475D2C003A9_5475D1E30232_var*
//#UC END# *5475D2C003A9_5475D1E30232_var*
begin
//#UC START# *5475D2C003A9_5475D1E30232_impl*
 if Assigned(f_Handles) then
  f_Handles.Remove(Integer(aHandle));
//#UC END# *5475D2C003A9_5475D1E30232_impl*
end;//Tl3ProcessMessagesManager.Unsubscribe

procedure Tl3ProcessMessagesManager.ProcessMessages(wMsgFilterMin: LongWord;
 wMsgFilterMax: LongWord;
 wRemoveMsg: LongWord);
//#UC START# *5475D2D4032E_5475D1E30232_var*
{$IfDef l3HackedVCL}
var
 l_Msg: TMsg;
 I: Integer;
{$EndIf l3HackedVCL} 
//#UC END# *5475D2D4032E_5475D1E30232_var*
begin
//#UC START# *5475D2D4032E_5475D1E30232_impl*
 {$IfDef l3HackedVCL}
 if Assigned(f_Handles) then
  for I := 0 to f_Handles.Count - 1 do
   while PeekMessage(l_Msg, THandle(f_Handles[I]), wMsgFilterMin, wMsgFilterMax, wRemoveMsg) do
   begin
    {TranslateMessage(l_Msg);
    DispatchMessage(l_Msg);}
    Forms.Application.DoProcessMessage(l_Msg);
   end;
 {$EndIf l3HackedVCL}
//#UC END# *5475D2D4032E_5475D1E30232_impl*
end;//Tl3ProcessMessagesManager.ProcessMessages

class function Tl3ProcessMessagesManager.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3ProcessMessagesManager <> nil;
end;//Tl3ProcessMessagesManager.Exists

class function Tl3ProcessMessagesManager.Instance: Tl3ProcessMessagesManager;
 {* Метод получения экземпляра синглетона Tl3ProcessMessagesManager }
begin
 if (g_Tl3ProcessMessagesManager = nil) then
 begin
  l3System.AddExitProc(Tl3ProcessMessagesManagerFree);
  g_Tl3ProcessMessagesManager := Create;
 end;
 Result := g_Tl3ProcessMessagesManager;
end;//Tl3ProcessMessagesManager.Instance

procedure Tl3ProcessMessagesManager.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5475D1E30232_var*
//#UC END# *479731C50290_5475D1E30232_var*
begin
//#UC START# *479731C50290_5475D1E30232_impl*
 l3Free(f_Handles);
 inherited;
//#UC END# *479731C50290_5475D1E30232_impl*
end;//Tl3ProcessMessagesManager.Cleanup

end.
