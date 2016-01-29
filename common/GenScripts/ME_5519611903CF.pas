unit IterateableService;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Classes
;

type
 MIterateableService_IterateF_Action = function(anItem: TComponent): Boolean;
  {* Тип подитеративной функции для MIterateableService.IterateF }
 
 (*
 MIterateableService = interface
  {* Контракт сервиса TIterateableService }
  procedure IterateF;
 end;//MIterateableService
 *)
 
 IIterateableService = interface
  {* Интерфейс сервиса TIterateableService }
  procedure IterateF;
 end;//IIterateableService
 
 TIterateableService = class(Tl3ProtoObject)
  procedure Iterate;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure IterateF;
 end;//TIterateableService
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
