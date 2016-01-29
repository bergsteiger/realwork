unit seModalSupport;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3ModalService
 , l3ProtoObject
;

type
 TseModalService = class(Tl3ProtoObject, Il3ModalService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function HasModalWorker: Boolean;
  function ExecuteCurrentModalWorker(aModalExecute: TseModalExecute): Boolean;
 end;//TseModalService
 
implementation

uses
 l3ImplUses
 , seModalWorkerList
 , seModalWorker
 , l3AFWExceptions
 , l3BatchService
 , l3MessagesService
;

end.
