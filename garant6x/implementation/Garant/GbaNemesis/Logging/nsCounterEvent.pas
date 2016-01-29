unit nsCounterEvent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Logging"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Logging/nsCounterEvent.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Logging::Logging::TnsCounterEvent
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  LoggingUnit,
  nsPrimCachedEvent
  ;

type
 TnsCounterEvent = {abstract} class(TnsPrimCachedEvent)
 private
 // private fields
   f_Counter : Cardinal;
 protected
 // realized methods
   procedure DoFireLog; override;
 protected
 // protected methods
   function EventID: TLogEvent; virtual; abstract;
 public
 // public methods
   procedure Log;
 end;//TnsCounterEvent

implementation

uses
  LoggingWrapperInterfaces,
  nsLogEventData,
  nsLogManager
  ;

// start class TnsCounterEvent

procedure TnsCounterEvent.Log;
//#UC START# *4B13A5F10200_4B13A1A2000F_var*
//#UC END# *4B13A5F10200_4B13A1A2000F_var*
begin
//#UC START# *4B13A5F10200_4B13A1A2000F_impl*
 Inc(f_Counter);
 RequestWrite;
//#UC END# *4B13A5F10200_4B13A1A2000F_impl*
end;//TnsCounterEvent.Log

procedure TnsCounterEvent.DoFireLog;
//#UC START# *4B13A1F202D9_4B13A1A2000F_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B13A1F202D9_4B13A1A2000F_var*
begin
//#UC START# *4B13A1F202D9_4B13A1A2000F_impl*
 if f_Counter > 0 then
 begin
  l_Data := MakeParamsList;
  l_Data.AddULong(f_Counter);
  GetLogger.AddEvent(EventID, l_Data);
  f_Counter := 0;
 end;
//#UC END# *4B13A1F202D9_4B13A1A2000F_impl*
end;//TnsCounterEvent.DoFireLog

end.