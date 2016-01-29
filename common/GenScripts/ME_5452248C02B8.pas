unit ncsTransporterThread;

interface

uses
 l3IntfUses
 , l3Base
 , ncsMessageQueue
;

type
 TncsTransporterThread = class(Tl3ThreadContainer)
  procedure Create(anQueue: TncsMessageQueue);
  function TerminatedConnection: Boolean;
  procedure DoExecute;
   {* основная процедура нити. Для перекрытия в потомках }
 end;//TncsTransporterThread
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
