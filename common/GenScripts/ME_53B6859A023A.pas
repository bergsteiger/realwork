unit ddGetTaskRequestPrim;

interface

uses
 l3IntfUses
 , askRequest
 , GetTaskRequest_Const
 , k2Base
;

type
 TddGetTaskRequestPrim = class(TaskRequest)
  procedure SetTaskID(const aTaskID: AnsiString);
 end;//TddGetTaskRequestPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , StrUtils
 , DateUtils
;

end.
