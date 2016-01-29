unit seModalWorkerList;

interface

uses
 l3IntfUses
 , seModalWorkerListPrim
;

type
 TseModalWorkerList = class(TseModalWorkerListPrim)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TseModalWorkerList
 
implementation

uses
 l3ImplUses
;

end.
