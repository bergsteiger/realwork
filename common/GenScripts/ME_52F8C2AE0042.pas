unit csProcessTask;

interface

uses
 l3IntfUses
 , ddProcessTaskPrim
 , csTaskResult
 , dt_Types
;

type
 TddProcessTask = class(TddProcessTaskPrim)
  procedure DoRun(const aContext: TddRunContext);
  procedure RegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor);
  procedure UnRegisterAbortProcessor (const aProcessor : IcsExternalTaskAbortProcessor);
  procedure GetTaskResultClass : TcsClassResultClass;
 end;//TddProcessTask
 
 IcsExternalTaskAbortProcessor = interface
  function ProcessAbort(const aTask: TddProcessTask): Boolean;
   {* Если успешно абортировала задачу вернет True. Тогда штатная обработка обключается }
 end;//IcsExternalTaskAbortProcessor
 
 IcsRunTaskServices = interface
  procedure AddActiveTask(const aTask: TddProcessTask);
  procedure SendTextMessage(anUserID: TUserID;
   const aMessage: AnsiString);
 end;//IcsRunTaskServices
 
 IcsFileTransferServices = interface
  function TransferFile(const aTargetFolder: AnsiString;
   const aSourceFileName: AnsiString;
   const aTargetFileName: AnsiString): Boolean;
 end;//IcsFileTransferServices
 
implementation

uses
 l3ImplUses
;

end.
