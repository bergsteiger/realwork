unit afwHintManager;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , ExtCtrls
 , Classes
 , Forms
 , Controls
 , Graphics
;

type
 THackApplication = class(TComponent)
 end;//THackApplication
 
 TafwHintManager = class(Tl3ProtoObject)
  procedure ActivateHint(const aPt: TPoint);
  procedure CancelHint;
  procedure TimerProc(Sender: TObject);
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TafwHintManager
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
