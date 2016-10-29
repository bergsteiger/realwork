unit msmEvents;

// Модуль: "w:\common\components\gui\Garant\msm\msmEvents.pas"
// Стереотип: "Interfaces"
// Элемент модели: "msmEvents" MUID: (57B5730D0123)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
;

type
 TmsmSignal = {abstract} class
 end;//TmsmSignal

 TmsmEvent = {abstract} class(TmsmSignal)
 end;//TmsmEvent

 ImsmEventsSubscriber = interface
  ['{0B2E9EE0-2D64-480C-AE79-79CC1110ADA5}']
  procedure HandleEvent(anEvent: TmsmEvent);
 end;//ImsmEventsSubscriber

 (*
 MmsmEventsPublisher = interface
  procedure AddEventsSubscriber(const aListener: ImsmEventsSubscriber);
  procedure RemoveEventsSubscriber(const aListener: ImsmEventsSubscriber);
 end;//MmsmEventsPublisher
 *)

 (*
 MmsmEventFire = interface
  procedure Fire(anEvent: TmsmEvent);
 end;//MmsmEventFire
 *)

 (*
 MmsmEventsManaging = interface
  procedure DisableEvent(anEvent: TmsmEvent);
  procedure EnableEvent(anEvent: TmsmEvent);
 end;//MmsmEventsManaging
 *)

 ImsmEventsPublisher = interface
  ['{43C89C07-7F9C-42DF-9BB6-1503E8B64D25}']
  procedure AddEventsSubscriber(const aListener: ImsmEventsSubscriber);
  procedure RemoveEventsSubscriber(const aListener: ImsmEventsSubscriber);
 end;//ImsmEventsPublisher

 TmsmEventHandler = procedure(anEvent: TmsmEvent) of object;

implementation

uses
 l3ImplUses
;

end.
