unit SyncObjs;

interface

uses
 l3IntfUses
;

type
 TCriticalSection = class
  {* TCriticalSection allows a thread in a multi-threaded application to temporarily block other threads from accessing a block of code. }
 end;//TCriticalSection
 
 TSimpleEvent = class
  {* TSimpleEvent represents an unnamed manual event object. }
 end;//TSimpleEvent
 
 TEvent = class
  {* TEvent represents an external event. }
 end;//TEvent
 
implementation

uses
 l3ImplUses
;

end.
