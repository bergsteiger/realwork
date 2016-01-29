unit ncsTaskSendExecutorFactory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsMessageInterfaces
 , csProcessTask
 , ncsMessage
;

type
 TncsTaskSendExecutorFactory = class(Tl3ProtoObject, IncsMessageExecutorFactory)
  procedure Create(aTask: TddProcessTask);
  function Make(aTask: TddProcessTask): IncsMessageExecutorFactory;
  function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
 end;//TncsTaskSendExecutorFactory
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ncsGetPartialTaskDescription
 , ncsGetFilePart
 , ncsGetPartialTaskDescriptionExecutor
 , ncsGetFilePartExecutor
;

end.
