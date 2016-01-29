unit ddServerTask;

interface

uses
 l3IntfUses
 , ddTaskItemPrim
 , dt_Types
 , Classes
;

type
 TddTaskItem = class(TddTaskItemPrim)
  procedure AssignFrom(P: TddTaskItem);
  procedure Create(aUserID: TUserID);
  procedure DoSaveTo(aStream: TStream;
   aIsPipe: Boolean);
  procedure DoLoadFrom(aStream: TStream;
   aIsPipe: Boolean);
  function GetDescription: AnsiString;
 end;//TddTaskItem
 
 TddTaskClass = class of TddTaskItem;
 
implementation

uses
 l3ImplUses
 , ddTaskClassManager
 , csTaskListening
;

end.
