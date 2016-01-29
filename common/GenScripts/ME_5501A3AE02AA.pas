unit l3DispatcherHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3DispatcherHelper = interface
  {* Контракт сервиса Tl3DispatcherHelper }
  procedure ClearHistory;
 end;//Ml3DispatcherHelper
 *)
 
type
 Il3DispatcherHelper = interface
  {* Интерфейс сервиса Tl3DispatcherHelper }
  procedure ClearHistory;
 end;//Il3DispatcherHelper
 
 Tl3DispatcherHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure ClearHistory;
 end;//Tl3DispatcherHelper
 
implementation

uses
 l3ImplUses
;

end.
