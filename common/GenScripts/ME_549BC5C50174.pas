unit l3AsyncTask;

interface

uses
 l3IntfUses
 , l3ProtoObject
;

type
 Tl3AsyncTask = class(Tl3ProtoObject)
  procedure Exec;
 end;//Tl3AsyncTask
 
implementation

uses
 l3ImplUses
;

end.
