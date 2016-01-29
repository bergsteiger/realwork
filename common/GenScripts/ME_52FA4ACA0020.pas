unit csRequestTask;

interface

uses
 l3IntfUses
 , ddServerTask
 , RequestTask_Const
 , CsDataPipe
 , k2Base
 , dt_Types
;

type
 TddRequestTask = class(TddTaskItem)
  procedure SaveRequestToPipe(aPipe: TCsDataPipe);
 end;//TddRequestTask
 
 TddRequestTaskAsTask = class(TddRequestTask)
  procedure SaveTaskToPipe(aPipe: TCsDataPipe);
 end;//TddRequestTaskAsTask
 
implementation

uses
 l3ImplUses
 , evdTaskTypes
 , l3Memory
 , SysUtils
;

end.
