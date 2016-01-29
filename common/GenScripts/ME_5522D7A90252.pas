unit l3GetComponentBoundsHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Types
 , Classes
;

 (*
 Ml3GetComponentBoundsHelper = interface
  {* Контракт сервиса Tl3GetComponentBoundsHelper }
  function GetBounds(aComponent: TComponent): TRect;
 end;//Ml3GetComponentBoundsHelper
 *)
 
type
 Il3GetComponentBoundsHelper = interface
  {* Интерфейс сервиса Tl3GetComponentBoundsHelper }
  function GetBounds(aComponent: TComponent): TRect;
 end;//Il3GetComponentBoundsHelper
 
 Tl3GetComponentBoundsHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function GetBounds(aComponent: TComponent): TRect;
 end;//Tl3GetComponentBoundsHelper
 
implementation

uses
 l3ImplUses
 , Controls
;

end.
