unit nsCachedEventsProcessor;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsCachedEventsProcessor.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsPrimCachedEventsProcessor
 , LoggingInterfaces
;

type
 TnsCachedEventsProcessor = class(TnsPrimCachedEventsProcessor)
  public
   class function Make: InsCachedEventsProcessor; reintroduce;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsCachedEventsProcessor

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsCachedEventsProcessor: Pointer = nil;
 {* Экземпляр синглетона TnsCachedEventsProcessor }

procedure TnsCachedEventsProcessorFree;
 {* Метод освобождения экземпляра синглетона TnsCachedEventsProcessor }
begin
 IUnknown(g_TnsCachedEventsProcessor) := nil;
end;//TnsCachedEventsProcessorFree

class function TnsCachedEventsProcessor.Make: InsCachedEventsProcessor;
begin
 if (g_TnsCachedEventsProcessor = nil) then
 begin
  l3System.AddExitProc(TnsCachedEventsProcessorFree);
  InsCachedEventsProcessor(g_TnsCachedEventsProcessor) := inherited Make;
 end;
 Result := InsCachedEventsProcessor(g_TnsCachedEventsProcessor);
end;//TnsCachedEventsProcessor.Make

class function TnsCachedEventsProcessor.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsCachedEventsProcessor <> nil;
end;//TnsCachedEventsProcessor.Exists

end.
