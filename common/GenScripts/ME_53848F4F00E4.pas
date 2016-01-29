unit ddTaskClassManager;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ddTaskRecordList
 , ddServerTask
 , csTaskTypes
;

type
 TddTaskClassManager = class(Tl3ProtoObject)
  function GetClass(aClassType: TcsTaskType;
   out aDescription: AnsiString): TddTaskClass;
  procedure RegisterClass(aType: TcsTaskType;
   aClass: TddTaskClass;
   const aDescription: AnsiString);
  function Registered(aTaskType: TcsTaskType): Boolean;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TddTaskClassManager
 
implementation

uses
 l3ImplUses
 , SysUtils
 , ddTaskRecord
;

end.
