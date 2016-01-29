unit nsCachedEventsProcessor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Logging"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Logging/nsCachedEventsProcessor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Logging::Logging::TnsCachedEventsProcessor
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  LoggingInterfaces,
  nsPrimCachedEventsProcessor
  ;

type
 TnsCachedEventsProcessor = class(TnsPrimCachedEventsProcessor)
 public
 // public methods
   class function Make: InsCachedEventsProcessor; reintroduce;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsCachedEventsProcessor

implementation

uses
  l3Base {a}
  ;

// start class TnsCachedEventsProcessor

var g_TnsCachedEventsProcessor : Pointer = nil;

procedure TnsCachedEventsProcessorFree;
begin
 IUnknown(g_TnsCachedEventsProcessor) := nil;
end;


class function TnsCachedEventsProcessor.Make: InsCachedEventsProcessor;
begin
 if (g_TnsCachedEventsProcessor = nil) then
 begin
  l3System.AddExitProc(TnsCachedEventsProcessorFree);
  InsCachedEventsProcessor(g_TnsCachedEventsProcessor) := inherited Make;
 end;
 Result := InsCachedEventsProcessor(g_TnsCachedEventsProcessor);
end;

class function TnsCachedEventsProcessor.Exists: Boolean;
 {-}
begin
 Result := g_TnsCachedEventsProcessor <> nil;
end;//TnsCachedEventsProcessor.Exists

end.