unit evOperationDispatcherEx;

interface

uses
 l3IntfUses
 , evDisp
;

type
 TevOperationDispatcherEx = class(TevOperationDispatcher)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TevOperationDispatcherEx
 
implementation

uses
 l3ImplUses
;

end.
