unit l3BatchService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ModalService
 , l3ScriptService
;

type
 Tl3BatchScriptService = class(Tl3ProtoObject, Il3ScriptService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure EnterScript;
  procedure LeaveScript;
 end;//Tl3BatchScriptService
 
 (*
 Ml3BatchService = interface
  {* Контракт сервиса Tl3BatchService }
  function IsBatchMode: Boolean;
  procedure EnterBatchMode;
  procedure LeaveBatchMode;
  procedure PushAnswer(aValue: Integer);
  function PopAnswer: Integer;
  procedure SignalWasDialog;
  function CheckWasDialog: Boolean;
  procedure ClearAnswers;
 end;//Ml3BatchService
 *)
 
 Il3BatchService = interface
  {* Интерфейс сервиса Tl3BatchService }
  function IsBatchMode: Boolean;
  procedure EnterBatchMode;
  procedure LeaveBatchMode;
  procedure PushAnswer(aValue: Integer);
  function PopAnswer: Integer;
  procedure SignalWasDialog;
  function CheckWasDialog: Boolean;
  procedure ClearAnswers;
 end;//Il3BatchService
 
 Tl3BatchService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure PushAnswer(aValue: Integer);
  function CheckWasDialog: Boolean;
  procedure SignalWasDialog;
  procedure ClearAnswers;
  procedure EnterBatchMode;
  function HasModalWorker: Boolean;
  function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute): Boolean;
  function IsBatchMode: Boolean;
  function PopAnswer: Integer;
  procedure LeaveBatchMode;
 end;//Tl3BatchService
 
implementation

uses
 l3ImplUses
 , afwAnswer
 , Controls
;

end.
