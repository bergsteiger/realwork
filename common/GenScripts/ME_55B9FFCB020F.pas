unit nsLoggingTestService;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsLoggingTestService.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
 , LoggingWrapperInterfaces
 , l3Interfaces
;

type
 TnsLoggingTestService = class(Tl3SimpleObject, InsLoggingTestService)
  private
   f_Listening: Boolean;
   f_LogRecords: Il3StringsEx;
  protected
   procedure AddLogString(const aString: AnsiString);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure StartListening;
   procedure StopListening;
   function GetLogStrings: AnsiString;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsLoggingTestService;
    {* Метод получения экземпляра синглетона TnsLoggingTestService }
 end;//TnsLoggingTestService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3VCLStrings
 {$If NOT Defined(NoScripts)}
 , LoggingWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Base
;

var g_TnsLoggingTestService: TnsLoggingTestService = nil;
 {* Экземпляр синглетона TnsLoggingTestService }

procedure TnsLoggingTestServiceFree;
 {* Метод освобождения экземпляра синглетона TnsLoggingTestService }
begin
 l3Free(g_TnsLoggingTestService);
end;//TnsLoggingTestServiceFree

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

class function TnsLoggingTestService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsLoggingTestService <> nil;
end;//TnsLoggingTestService.Exists

procedure TnsLoggingTestService.AddLogString(const aString: AnsiString);
//#UC START# *566AEC8A0092_55B9FFCB020F_var*
//#UC END# *566AEC8A0092_55B9FFCB020F_var*
begin
//#UC START# *566AEC8A0092_55B9FFCB020F_impl*
 if f_Listening then
  f_LogRecords.Add(aString);
//#UC END# *566AEC8A0092_55B9FFCB020F_impl*
end;//TnsLoggingTestService.AddLogString

class function TnsLoggingTestService.Instance: TnsLoggingTestService;
 {* Метод получения экземпляра синглетона TnsLoggingTestService }
begin
 if (g_TnsLoggingTestService = nil) then
 begin
  l3System.AddExitProc(TnsLoggingTestServiceFree);
  g_TnsLoggingTestService := Create;
 end;
 Result := g_TnsLoggingTestService;
end;//TnsLoggingTestService.Instance

procedure TnsLoggingTestService.Cleanup;
 {* Функция очистки полей объекта. }
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
