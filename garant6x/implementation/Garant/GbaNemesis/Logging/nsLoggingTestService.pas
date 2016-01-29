unit nsLoggingTestService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Logging"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Logging/nsLoggingTestService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Logging::LoggingTestService::TnsLoggingTestService
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3Interfaces,
  l3SimpleObject
  ;

type
 TnsLoggingTestService = class(Tl3SimpleObject)
 private
 // private fields
   f_Listening : Boolean;
   f_LogRecords : Il3StringsEx;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   procedure StartListening;
     {* Сигнатура метода StartListening }
   procedure StopListening;
     {* Сигнатура метода StopListening }
   function GetLogStrings: AnsiString;
   procedure AddLogString(const aString: AnsiString);
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsLoggingTestService;
    {- возвращает экземпляр синглетона. }
 end;//TnsLoggingTestService

implementation

uses
  l3Base {a},
  SysUtils,
  l3VCLStrings
  {$If not defined(NoScripts)}
  ,
  LoggingWordsPack
  {$IfEnd} //not NoScripts
  
  ;


// start class TnsLoggingTestService

var g_TnsLoggingTestService : TnsLoggingTestService = nil;

procedure TnsLoggingTestServiceFree;
begin
 l3Free(g_TnsLoggingTestService);
end;

class function TnsLoggingTestService.Instance: TnsLoggingTestService;
begin
 if (g_TnsLoggingTestService = nil) then
 begin
  l3System.AddExitProc(TnsLoggingTestServiceFree);
  g_TnsLoggingTestService := Create;
 end;
 Result := g_TnsLoggingTestService;
end;


procedure TnsLoggingTestService.StartListening;
//#UC START# *55BA00C202EE_55B9FFCB020F_var*
//#UC END# *55BA00C202EE_55B9FFCB020F_var*
begin
//#UC START# *55BA00C202EE_55B9FFCB020F_impl*
 f_LogRecords.Clear;
 f_Listening := True;
//#UC END# *55BA00C202EE_55B9FFCB020F_impl*
end;//TnsLoggingTestService.StartListening

procedure TnsLoggingTestService.StopListening;
//#UC START# *55BA00CE00C0_55B9FFCB020F_var*
//#UC END# *55BA00CE00C0_55B9FFCB020F_var*
begin
//#UC START# *55BA00CE00C0_55B9FFCB020F_impl*
 f_Listening := False;
//#UC END# *55BA00CE00C0_55B9FFCB020F_impl*
end;//TnsLoggingTestService.StopListening

function TnsLoggingTestService.GetLogStrings: AnsiString;
//#UC START# *55BA01020317_55B9FFCB020F_var*
var
 I: Integer;
//#UC END# *55BA01020317_55B9FFCB020F_var*
begin
//#UC START# *55BA01020317_55B9FFCB020F_impl*
 Result := '';
 for I := 0 to f_LogRecords.Count - 1 do
 begin
  if I > 0 then
   Result := Result + #13#10;
  Result := Result + f_LogRecords.Item[I];
 end;
//#UC END# *55BA01020317_55B9FFCB020F_impl*
end;//TnsLoggingTestService.GetLogStrings

procedure TnsLoggingTestService.AddLogString(const aString: AnsiString);
//#UC START# *55BA022F011C_55B9FFCB020F_var*
//#UC END# *55BA022F011C_55B9FFCB020F_var*
begin
//#UC START# *55BA022F011C_55B9FFCB020F_impl*
 if f_Listening then
  f_LogRecords.Add(aString);
//#UC END# *55BA022F011C_55B9FFCB020F_impl*
end;//TnsLoggingTestService.AddLogString

class function TnsLoggingTestService.Exists: Boolean;
 {-}
begin
 Result := g_TnsLoggingTestService <> nil;
end;//TnsLoggingTestService.Exists

procedure TnsLoggingTestService.Cleanup;
//#UC START# *479731C50290_55B9FFCB020F_var*
//#UC END# *479731C50290_55B9FFCB020F_var*
begin
//#UC START# *479731C50290_55B9FFCB020F_impl*
 f_LogRecords := nil;
 inherited;
//#UC END# *479731C50290_55B9FFCB020F_impl*
end;//TnsLoggingTestService.Cleanup

procedure TnsLoggingTestService.InitFields;
//#UC START# *47A042E100E2_55B9FFCB020F_var*
//#UC END# *47A042E100E2_55B9FFCB020F_var*
begin
//#UC START# *47A042E100E2_55B9FFCB020F_impl*
 f_LogRecords := Tl3Strings.Make;
//#UC END# *47A042E100E2_55B9FFCB020F_impl*
end;//TnsLoggingTestService.InitFields

end.