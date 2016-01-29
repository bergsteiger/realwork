unit l3ProcessingEnabledService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3ProcessingEnabledService = interface
  {* Контракт сервиса Tl3ProcessingEnabledService }
  function Enabled: Boolean;
 end;//Ml3ProcessingEnabledService
 *)
 
type
 Il3ProcessingEnabledService = interface
  {* Интерфейс сервиса Tl3ProcessingEnabledService }
  function Enabled: Boolean;
 end;//Il3ProcessingEnabledService
 
 Tl3ProcessingEnabledService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function Enabled: Boolean;
 end;//Tl3ProcessingEnabledService
 
implementation

uses
 l3ImplUses
;

end.
