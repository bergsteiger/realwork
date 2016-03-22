unit l3ExecuteInMainThread;
 {* Перед использованием нужно вызывать init в главном потоке. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3ExecuteInMainThread.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3ExecuteInMainThread" MUID: (549BC58B0346)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3AsynkTaskList
 , Windows
 , l3AsyncTask
 , Messages
 , SyncObjs
;

type
 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 Tl3ExecuteInMainThread = class(_l3CriticalSectionHolder_)
  {* Перед использованием нужно вызывать init в главном потоке. }
  private
   f_Data: Tl3AsynkTaskList;
   f_Wnd: HWND;
   f_MsgID: THandle;
  private
   procedure WndProc(var Message: TMessage);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure Init;
   procedure AsyncExec(aTask: Tl3AsyncTask);
   procedure SyncExec(aTask: Tl3AsyncTask);
   class function Instance: Tl3ExecuteInMainThread;
    {* Метод получения экземпляра синглетона Tl3ExecuteInMainThread }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3ExecuteInMainThread

implementation

uses
 l3ImplUses
 , SysUtils
 , Classes
 , l3Utils
 , l3Base
;

type
 Tl3SynTask = {final} class(Tl3AsyncTask)
  private
   f_Task: Tl3AsyncTask;
   f_Event: TEvent;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aTask: Tl3AsyncTask); reintroduce;
   procedure WaitForExec;
   procedure Exec; override;
 end;//Tl3SynTask

var g_Tl3ExecuteInMainThread: Tl3ExecuteInMainThread = nil;
 {* Экземпляр синглетона Tl3ExecuteInMainThread }

procedure Tl3ExecuteInMainThreadFree;
 {* Метод освобождения экземпляра синглетона Tl3ExecuteInMainThread }
begin
 l3Free(g_Tl3ExecuteInMainThread);
end;//Tl3ExecuteInMainThreadFree

constructor Tl3SynTask.Create(aTask: Tl3AsyncTask);
//#UC START# *549BDAC601E8_549BDA9C0160_var*
//#UC END# *549BDAC601E8_549BDA9C0160_var*
begin
//#UC START# *549BDAC601E8_549BDA9C0160_impl*
 inherited Create;
 aTask.SetRefTo(f_Task);
 f_Event := TEvent.Create(nil, True, False, l3CreateStringGUID);
//#UC END# *549BDAC601E8_549BDA9C0160_impl*
end;//Tl3SynTask.Create

procedure Tl3SynTask.WaitForExec;
//#UC START# *549BDB15036E_549BDA9C0160_var*
//#UC END# *549BDB15036E_549BDA9C0160_var*
begin
//#UC START# *549BDB15036E_549BDA9C0160_impl*
 f_Event.WaitFor(INFINITE);
//#UC END# *549BDB15036E_549BDA9C0160_impl*
end;//Tl3SynTask.WaitForExec

procedure Tl3SynTask.Exec;
//#UC START# *549BC64F01DE_549BDA9C0160_var*
//#UC END# *549BC64F01DE_549BDA9C0160_var*
begin
//#UC START# *549BC64F01DE_549BDA9C0160_impl*
 f_Task.Exec;
 f_Event.SetEvent;
//#UC END# *549BC64F01DE_549BDA9C0160_impl*
end;//Tl3SynTask.Exec

procedure Tl3SynTask.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_549BDA9C0160_var*
//#UC END# *479731C50290_549BDA9C0160_var*
begin
//#UC START# *479731C50290_549BDA9C0160_impl*
 FreeAndNil(f_Task);
 FreeAndNil(f_Event);
 inherited;
//#UC END# *479731C50290_549BDA9C0160_impl*
end;//Tl3SynTask.Cleanup

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

procedure Tl3ExecuteInMainThread.WndProc(var Message: TMessage);
//#UC START# *549BD08302D8_549BC58B0346_var*
var
 l_Task: Tl3AsyncTask;
 l_NeedResend: Boolean;
//#UC END# *549BD08302D8_549BC58B0346_var*
begin
//#UC START# *549BD08302D8_549BC58B0346_impl*
 with Message do
  if msg = f_MsgID then
  begin
   l_NeedResend := False;
   l_Task := nil;
   try
    Lock;
    try
     if f_Data.Count > 0 then
     begin
      f_Data[0].SetRefTo(l_Task);
      f_Data.Delete(0);
      l_NeedResend := f_Data.Count > 0;
     end
     else
      l_Task := nil;
    finally
     Unlock;
    end;
    if Assigned(l_Task) then
    begin
     l_Task.Exec;
     if l_NeedResend then
      PostMessage(f_Wnd, f_MsgID, 0, 0);
    end;
   finally
    FreeAndNil(l_Task);
   end;
  end
  else
   DefWindowProc(f_Wnd, msg, wParam, lParam);
//#UC END# *549BD08302D8_549BC58B0346_impl*
end;//Tl3ExecuteInMainThread.WndProc

procedure Tl3ExecuteInMainThread.Init;
//#UC START# *549BE5C2006F_549BC58B0346_var*
//#UC END# *549BE5C2006F_549BC58B0346_var*
begin
//#UC START# *549BE5C2006F_549BC58B0346_impl*
// Do nothing - simple to allocate HWND
//#UC END# *549BE5C2006F_549BC58B0346_impl*
end;//Tl3ExecuteInMainThread.Init

procedure Tl3ExecuteInMainThread.AsyncExec(aTask: Tl3AsyncTask);
//#UC START# *549BC5F800ED_549BC58B0346_var*
//#UC END# *549BC5F800ED_549BC58B0346_var*
begin
//#UC START# *549BC5F800ED_549BC58B0346_impl*
 if MainThreadID = GetCurrentThreadID then
  aTask.Exec
 else
 begin
  Lock;
  try
   f_Data.Add(aTask);
  finally
   Unlock;
  end;
  PostMessage(f_Wnd, f_MsgID, 0, 0);
 end;
//#UC END# *549BC5F800ED_549BC58B0346_impl*
end;//Tl3ExecuteInMainThread.AsyncExec

procedure Tl3ExecuteInMainThread.SyncExec(aTask: Tl3AsyncTask);
//#UC START# *549BC61B009B_549BC58B0346_var*
var
 l_Task: Tl3SynTask;
//#UC END# *549BC61B009B_549BC58B0346_var*
begin
//#UC START# *549BC61B009B_549BC58B0346_impl*
 if MainThreadID = GetCurrentThreadID then
  aTask.Exec
 else
 begin
  l_Task := Tl3SynTask.Create(aTask);
  try
   Lock;
   try
    f_Data.Add(l_Task);
   finally
    Unlock;
   end;
   PostMessage(f_Wnd, f_MsgID, 0, 0);
   l_Task.WaitForExec;
  finally
   FreeAndNil(l_Task);
  end;
 end;
//#UC END# *549BC61B009B_549BC58B0346_impl*
end;//Tl3ExecuteInMainThread.SyncExec

class function Tl3ExecuteInMainThread.Instance: Tl3ExecuteInMainThread;
 {* Метод получения экземпляра синглетона Tl3ExecuteInMainThread }
begin
 if (g_Tl3ExecuteInMainThread = nil) then
 begin
  l3System.AddExitProc(Tl3ExecuteInMainThreadFree);
  g_Tl3ExecuteInMainThread := Create;
 end;
 Result := g_Tl3ExecuteInMainThread;
end;//Tl3ExecuteInMainThread.Instance

class function Tl3ExecuteInMainThread.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tl3ExecuteInMainThread <> nil;
end;//Tl3ExecuteInMainThread.Exists

procedure Tl3ExecuteInMainThread.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_549BC58B0346_var*
//#UC END# *479731C50290_549BC58B0346_var*
begin
//#UC START# *479731C50290_549BC58B0346_impl*
 DeallocateHWnd(f_Wnd);
 FreeAndNil(f_Data);
 inherited;
//#UC END# *479731C50290_549BC58B0346_impl*
end;//Tl3ExecuteInMainThread.Cleanup

procedure Tl3ExecuteInMainThread.InitFields;
//#UC START# *47A042E100E2_549BC58B0346_var*
//#UC END# *47A042E100E2_549BC58B0346_var*
begin
//#UC START# *47A042E100E2_549BC58B0346_impl*
 inherited;
 Assert(MainThreadID = GetCurrentThreadID, 'Перед использованием нужно вызывать init в главном потоке!');
 f_Data := Tl3AsynkTaskList.Make;
 f_Wnd := AllocateHWnd(WndProc);
 f_MsgID := RegisterWindowMessage(PChar(l3CreateStringGUID));
//#UC END# *47A042E100E2_549BC58B0346_impl*
end;//Tl3ExecuteInMainThread.InitFields

end.
