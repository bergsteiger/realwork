unit l3GetComponentFromPointHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Types
 , Classes
 , Controls
;

 (*
 Ml3GetComponentFromPointHelper = interface
  {* Контракт сервиса Tl3GetComponentFromPointHelper }
  procedure GetComponent(const aPoint: TPoint;
   out aComponent: TComponent;
   out aBindedControl: TControl);
   {* aBindedControl - если найденный компонент - контрол, то равен этому контролу, если нет, то его родитель }
 end;//Ml3GetComponentFromPointHelper
 *)
 
type
 Il3GetComponentFromPointHelper = interface
  {* Интерфейс сервиса Tl3GetComponentFromPointHelper }
  procedure GetComponent(const aPoint: TPoint;
   out aComponent: TComponent;
   out aBindedControl: TControl);
   {* aBindedControl - если найденный компонент - контрол, то равен этому контролу, если нет, то его родитель }
 end;//Il3GetComponentFromPointHelper
 
 Tl3GetComponentFromPointHelper = class(Tl3ProtoObject)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure GetComponent(const aPoint: TPoint;
   out aComponent: TComponent;
   out aBindedControl: TControl);
   {* aBindedControl - если найденный компонент - контрол, то равен этому контролу, если нет, то его родитель }
 end;//Tl3GetComponentFromPointHelper
 
implementation

uses
 l3ImplUses
;

end.
