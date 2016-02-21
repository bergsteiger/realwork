unit LoggingInterfaces;
 {* Регистрация событий системы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Model\LoggingInterfaces.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 InsDefferedEvent = interface
  ['{DC0ACD6B-F180-4720-8CC0-500683B03458}']
  procedure FireLog;
 end;//InsDefferedEvent

 InsEventHolder = interface
  ['{E97E1666-E2E3-4661-B773-40EC6B8F6940}']
  procedure SetEvent(const anEvent: InsDefferedEvent);
 end;//InsEventHolder

 InsCachedEventsProcessor = interface
  ['{A5A50743-4275-4C7F-AD87-945799C7EF03}']
  procedure RegisterEvent(const aEvent: InsDefferedEvent);
  procedure RequestWriteCache;
 end;//InsCachedEventsProcessor

implementation

uses
 l3ImplUses
;

end.
