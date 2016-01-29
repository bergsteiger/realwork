unit ncsMessageExecutorFactory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ncsExecutorFactoryList
 , ncsMessageInterfaces
 , ncsMessage
;

type
 TncsDisconnectExecutor = class(Tl3ProtoObject, IncsExecutor, IncsMessageExecutorFactory)
  procedure Execute(const aContext: TncsExecuteContext);
  function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
 end;//TncsDisconnectExecutor
 
 TncsMessageExecutorFactory = class(Tl3ProtoObject)
  procedure Register(const aFactory: IncsMessageExecutorFactory);
  procedure UnRegister(const aFactory: IncsMessageExecutorFactory);
  function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TncsMessageExecutorFactory
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , evdNcsTypes
;

type
 TncsInvalidExecutor = class(Tl3ProtoObject, IncsExecutor)
  procedure Create;
  function Make: IncsExecutor;
  procedure Execute(const aContext: TncsExecuteContext);
 end;//TncsInvalidExecutor
 
end.
