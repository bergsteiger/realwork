unit l3ExecuteInMainThread;

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
 Tl3ExecuteInMainThread = class(Tl3ProtoObject)
  {* Перед использованием нужно вызывать init в главном потоке. }
  procedure WndProc(var Message: TMessage);
  procedure Init;
  procedure AsyncExec(aTask: Tl3AsyncTask);
  procedure SyncExec(aTask: Tl3AsyncTask);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3ExecuteInMainThread
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Classes
 , l3Utils
;

type
 Tl3SynTask = class(Tl3AsyncTask)
  procedure Create(aTask: Tl3AsyncTask);
  procedure WaitForExec;
  procedure Exec;
 end;//Tl3SynTask
 
end.
