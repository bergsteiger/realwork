unit l3MessagesService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3MessagesService = interface
  {* Контракт сервиса Tl3MessagesService }
  procedure ProcessMessages;
 end;//Ml3MessagesService
 *)
 
type
 Il3MessagesService = interface
  {* Интерфейс сервиса Tl3MessagesService }
  procedure ProcessMessages;
 end;//Il3MessagesService
 
 Tl3MessagesService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure ProcessMessages;
 end;//Tl3MessagesService
 
implementation

uses
 l3ImplUses
;

end.
