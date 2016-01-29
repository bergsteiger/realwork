unit l3TabService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3TabService = interface
  {* Контракт сервиса Tl3TabService }
  function HasTabs: Boolean;
 end;//Ml3TabService
 *)
 
type
 Il3TabService = interface
  {* Интерфейс сервиса Tl3TabService }
  function HasTabs: Boolean;
 end;//Il3TabService
 
 Tl3TabService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function HasTabs: Boolean;
 end;//Tl3TabService
 
implementation

uses
 l3ImplUses
;

end.
