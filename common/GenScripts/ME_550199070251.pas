unit l3MenuManagerHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3MenuManagerHelper = interface
  {* Контракт сервиса Tl3MenuManagerHelper }
  function CreateManager: Boolean;
  procedure FreeManager;
 end;//Ml3MenuManagerHelper
 *)
 
type
 Il3MenuManagerHelper = interface
  {* Интерфейс сервиса Tl3MenuManagerHelper }
  function CreateManager: Boolean;
  procedure FreeManager;
 end;//Il3MenuManagerHelper
 
 Tl3MenuManagerHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function CreateManager: Boolean;
  procedure FreeManager;
 end;//Tl3MenuManagerHelper
 
implementation

uses
 l3ImplUses
;

end.
