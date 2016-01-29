unit nsLogManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Logging"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Logging/nsLogManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Logging::LoggingWrapper::TnsLogManager
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
  l3SimpleObject,
  LoggingWrapperInterfaces
  ;

type
 TnsLogManager = class(Tl3SimpleObject, InsLogManager)
 private
 // private fields
   f_LogManager : ILogManager;
 protected
 // realized methods
   procedure AddEvent(aLogEvent: TLogEvent;
    const aData: InsLogEventData);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsLogManager;
    {- возвращает экземпляр синглетона. }
 end;//TnsLogManager

implementation

uses
  l3Base {a},
  DataAdapter,
  nsLoggingTestService,
  TypInfo
  ;


// start class TnsLogManager

var g_TnsLogManager : TnsLogManager = nil;

procedure TnsLogManagerFree;
begin
 l3Free(g_TnsLogManager);
end;

class function TnsLogManager.Instance: TnsLogManager;
begin
 if (g_TnsLogManager = nil) then
 begin
  l3System.AddExitProc(TnsLogManagerFree);
  g_TnsLogManager := Create;
 end;
 Result := g_TnsLogManager;
end;


class function TnsLogManager.Exists: Boolean;
 {-}
begin
 Result := g_TnsLogManager <> nil;
end;//TnsLogManager.Exists

procedure TnsLogManager.AddEvent(aLogEvent: TLogEvent;
  const aData: InsLogEventData);
//#UC START# *55B760550256_55B761180244_var*
var
 l_LogString: String;
//#UC END# *55B760550256_55B761180244_var*
begin
//#UC START# *55B760550256_55B761180244_impl*
 l_LogString := GetEnumName(TypeInfo(TLogEvent), Ord(aLogEvent)) + aData.AsString;
 TnsLoggingTestService.Instance.AddLogString(l_LogString);
 f_LogManager.AddEvent(aLogEvent, aData.AsLogEventData);
//#UC END# *55B760550256_55B761180244_impl*
end;//TnsLogManager.AddEvent

procedure TnsLogManager.Cleanup;
//#UC START# *479731C50290_55B761180244_var*
//#UC END# *479731C50290_55B761180244_var*
begin
//#UC START# *479731C50290_55B761180244_impl*
 f_LogManager := nil;
 inherited;
//#UC END# *479731C50290_55B761180244_impl*
end;//TnsLogManager.Cleanup

procedure TnsLogManager.InitFields;
//#UC START# *47A042E100E2_55B761180244_var*
//#UC END# *47A042E100E2_55B761180244_var*
begin
//#UC START# *47A042E100E2_55B761180244_impl*
 inherited;
 f_LogManager := DefDataAdapter.LogManager;
//#UC END# *47A042E100E2_55B761180244_impl*
end;//TnsLogManager.InitFields

end.