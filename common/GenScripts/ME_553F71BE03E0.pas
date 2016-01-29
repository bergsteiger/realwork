unit l3ModalService;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 TseModalExecute = (
  se_meUsual
  , se_meInLoop
  , se_meAfterLoop
 );//TseModalExecute
 
 (*
 Ml3ModalService = interface
  function HasModalWorker: Boolean;
  function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute): Boolean;
 end;//Ml3ModalService
 *)
 
 Il3ModalService = interface
  {* Интерфейс сервиса Tl3ModalService }
  function HasModalWorker: Boolean;
  function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute): Boolean;
 end;//Il3ModalService
 
 Tl3ModalService = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function HasModalWorker: Boolean;
  function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute): Boolean;
 end;//Tl3ModalService
 
implementation

uses
 l3ImplUses
;

end.
