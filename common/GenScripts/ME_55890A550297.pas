unit l3Timer;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Classes
 , Windows
 , Messages
;

type
 Tl3Timer = class(Tl3ProtoObject)
  procedure UpdateTimer;
  procedure WndProc(var Msg: TMessage);
  procedure DoOnTimer;
  procedure DoOnLocalTimeChange;
 end;//Tl3Timer
 
implementation

uses
 l3ImplUses
 , l3ExceptionHandler
;

end.
