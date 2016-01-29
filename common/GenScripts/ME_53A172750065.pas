unit ddServerTaskList;

interface

uses
 l3IntfUses
 , csProcessTask
 , l3ProtoObject
 , ddServerTaskListPrim
;

type
 csProcessTaskWorkuper_WorkupF_Action = function(anItem: TddProcessTask): Boolean;
  {* Тип подитеративной функции для csProcessTaskWorkuper.WorkupF }
 
 (*
 csProcessTaskWorkuper = interface
  procedure WorkupF;
 end;//csProcessTaskWorkuper
 *)
 
 TddServerTaskList = class(Tl3ProtoObject)
  function Pop: TddProcessTask;
  function Push(aTask: TddProcessTask): Integer;
  procedure WorkupF;
 end;//TddServerTaskList
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

end.
