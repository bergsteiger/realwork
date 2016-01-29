unit ChromeLikeTabSetAnimationManager;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Classes
 , SyncObjs
 , l3LongintList
 , ChromeLikeTabSetTypes
;

type
 TChromeLikeThreadTimer = class(Tl3ProtoObject)
  procedure StartTimer;
  procedure StopTimer;
  procedure Create(aNeedAnimateEvent: TEvent);
 end;//TChromeLikeThreadTimer
 
 TChromeLikeTimerThread = class(TThread)
  procedure DoExecute;
  procedure Create(aTimer: TChromeLikeThreadTimer;
   aNeedAnimateEvent: TEvent);
  procedure Execute;
 end;//TChromeLikeTimerThread
 
 TChromeLikeTabSetAnimationManager = class(Tl3ProtoObject)
  procedure DoOnAnimationTimer(Sender: TObject);
  procedure AddAnimable(const aAnimable: IChromeLikeTabSetAnimable);
  procedure RemoveAnimable(const aAnimable: IChromeLikeTabSetAnimable);
  procedure Create;
  procedure CheckNeedAnimate;
  procedure FinishAllImmediately;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TChromeLikeTabSetAnimationManager
 
implementation

uses
 l3ImplUses
 , SysUtils
 , MMSystem
 , Windows
;

end.
