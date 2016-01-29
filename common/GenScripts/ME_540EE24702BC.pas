unit l3ExceptionsLog;

interface

uses
 l3IntfUses
;

type
 Tl3ExceptionsLog = class(TObject)
  procedure SetOnException;
  procedure ResOnException;
  function NeedTime: Boolean;
 end;//Tl3ExceptionsLog
 
implementation

uses
 l3ImplUses
;

end.
