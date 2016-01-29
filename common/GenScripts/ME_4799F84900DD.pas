unit l3ScreenIC;

interface

uses
 l3IntfUses
 , l3InternalInterfaces
 , l3ProtoObject
 , l3ScreenService
;

type
 Tl3ScreenServiceDef = class(Tl3ProtoObject, Il3ScreenService)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function IC: Il3InfoCanvas;
 end;//Tl3ScreenServiceDef
 
implementation

uses
 l3ImplUses
 , l3Canvas
 , l3Base
;

end.
