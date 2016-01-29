unit nsPrimCachedEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Logging"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Logging/nsPrimCachedEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Logging::Logging::TnsPrimCachedEvent
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
  nsLogEvent
  ;

type
 TnsPrimCachedEvent = {abstract} class(TnsLogEvent, InsDefferedEvent)
 protected
 // realized methods
   procedure FireLog;
 protected
 // protected methods
   procedure DoFireLog; virtual; abstract;
   procedure RequestWrite;
 public
 // public methods
   constructor Create; reintroduce;
 end;//TnsPrimCachedEvent

implementation

uses
  nsCachedEventsProcessor,
  nsLogEventData,
  nsLogManager,
  LoggingUnit,
  LoggingWrapperInterfaces
  ;

// start class TnsPrimCachedEvent

procedure TnsPrimCachedEvent.RequestWrite;
//#UC START# *4B13A22E0048_4B13A069037A_var*
//#UC END# *4B13A22E0048_4B13A069037A_var*
begin
//#UC START# *4B13A22E0048_4B13A069037A_impl*
 TnsCachedEventsProcessor.Make.RequestWriteCache;
//#UC END# *4B13A22E0048_4B13A069037A_impl*
end;//TnsPrimCachedEvent.RequestWrite

constructor TnsPrimCachedEvent.Create;
//#UC START# *4B13AB74036B_4B13A069037A_var*
//#UC END# *4B13AB74036B_4B13A069037A_var*
begin
//#UC START# *4B13AB74036B_4B13A069037A_impl*
 inherited Create;
 TnsCachedEventsProcessor.Make.RegisterEvent(Self);
//#UC END# *4B13AB74036B_4B13A069037A_impl*
end;//TnsPrimCachedEvent.Create

procedure TnsPrimCachedEvent.FireLog;
//#UC START# *4B0FA5CB0254_4B13A069037A_var*
//#UC END# *4B0FA5CB0254_4B13A069037A_var*
begin
//#UC START# *4B0FA5CB0254_4B13A069037A_impl*
 DoFireLog;
//#UC END# *4B0FA5CB0254_4B13A069037A_impl*
end;//TnsPrimCachedEvent.FireLog

end.