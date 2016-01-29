unit l3ScreenService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3InternalInterfaces
;

 (*
 Ml3ScreenService = interface
  {* Контракт сервиса Tl3ScreenService }
  function IC: Il3InfoCanvas;
 end;//Ml3ScreenService
 *)
 
type
 Il3ScreenService = interface
  {* Интерфейс сервиса Tl3ScreenService }
  function IC: Il3InfoCanvas;
 end;//Il3ScreenService
 
 Tl3ScreenService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function IC: Il3InfoCanvas;
 end;//Tl3ScreenService
 
implementation

uses
 l3ImplUses
;

end.
