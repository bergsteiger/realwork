unit csTaskListening;

interface

uses
 l3IntfUses
 , ddTaskItemPrim
 , evdTaskTypes
 , l3ProtoDataContainer
;

type
 IcsTaskListener = interface
  procedure TaskChanged(aTask: TddTaskItemPrim;
   aStatus: TcsTaskStatus);
 end;//IcsTaskListener
 
 TcsTaskListeners = class(_l3InterfacePtrList_)
  procedure AddListener(const aListener: IcsTaskListener);
  procedure RemoveListener(const aListener: IcsTaskListener);
  function Exists: Boolean;
  procedure TaskChanged(aTask: TddTaskItemPrim;
   aStatus: TcsTaskStatus);
 end;//TcsTaskListeners
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
