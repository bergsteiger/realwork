unit ddProgressObj;

interface

uses
 l3IntfUses
;

type
 TddProgressObject = class
 end;//TddProgressObject
 
 TddProgressEvent = procedure(Sender: TObject;
  aTotalPercent: Integer) of object;
 
implementation

uses
 l3ImplUses
;

end.
