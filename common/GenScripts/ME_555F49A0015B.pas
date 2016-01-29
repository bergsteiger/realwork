unit l3EtalonsService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3EtalonsService = interface
  {* Контракт сервиса Tl3EtalonsService }
 end;//Ml3EtalonsService
 *)
 
type
 Il3EtalonsService = interface
  {* Интерфейс сервиса Tl3EtalonsService }
 end;//Il3EtalonsService
 
 Tl3EtalonsService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//Tl3EtalonsService
 
implementation

uses
 l3ImplUses
;

end.
