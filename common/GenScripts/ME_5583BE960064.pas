unit csTaskChangeHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 McsTaskChangeHelper = interface
  {* Контракт сервиса TcsTaskChangeHelper }
  procedure TaskGotErrorStatus;
 end;//McsTaskChangeHelper
 *)
 
type
 IcsTaskChangeHelper = interface
  {* Интерфейс сервиса TcsTaskChangeHelper }
  procedure TaskGotErrorStatus;
 end;//IcsTaskChangeHelper
 
 TcsTaskChangeHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure TaskGotErrorStatus;
 end;//TcsTaskChangeHelper
 
implementation

uses
 l3ImplUses
;

end.
