unit l3MouseWheelHelper;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , Windows
;

type
 Tl3MouseWheelHelper = class(Tl3ProtoObject, Il3MouseWheelListener)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  procedure MouseWheelListenerNotify(Msg: PMsg;
   var theResult: Tl3HookProcResult);
 end;//Tl3MouseWheelHelper
 
implementation

uses
 l3ImplUses
 , l3ListenersManager
 , Messages
;

end.
