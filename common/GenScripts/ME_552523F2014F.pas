unit daProgressProcHolder;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , l3Types
;

type
 TdaProgressProcHolder = class(Tl3ProtoObject, IdaProgressSubscriber)
  procedure Create(aProc: Tl3ProgressProc);
  function Make(aProc: Tl3ProgressProc): IdaProgressSubscriber;
  procedure DoProgressNotify(aState: Byte;
   aValue: Integer;
   const aMsg: AnsiString);
 end;//TdaProgressProcHolder
 
implementation

uses
 l3ImplUses
;

end.
