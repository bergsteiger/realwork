unit l3ScriptService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3ScriptService = interface
  {* Контракт сервиса Tl3ScriptService }
  procedure EnterScript;
  procedure LeaveScript;
 end;//Ml3ScriptService
 *)
 
type
 Il3ScriptService = interface
  {* Интерфейс сервиса Tl3ScriptService }
  procedure EnterScript;
  procedure LeaveScript;
 end;//Il3ScriptService
 
 Tl3ScriptService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure EnterScript;
  procedure LeaveScript;
 end;//Tl3ScriptService
 
implementation

uses
 l3ImplUses
;

end.
