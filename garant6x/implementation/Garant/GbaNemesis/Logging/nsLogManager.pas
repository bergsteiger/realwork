unit nsLogManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Logging"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Logging/nsLogManager.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Logging::LoggingWrapper::TnsLogManager
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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
   f_LoggingTestService : InsLoggingTestService;
   f_LogManager : ILogManager;
    {* ���� ��� �������� LogManager}
 protected
 // property methods
   function pm_GetLogManager: ILogManager;
 protected
 // realized methods
   procedure AddEvent(aLogEvent: TLogEvent;
    const aData: InsLogEventData);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure InitFields; override;
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 protected
 // protected properties
   property LogManager: ILogManager
     read pm_GetLogManager;
 public
 // singleton factory method
   class function Instance: TnsLogManager;
    {- ���������� ��������� ����������. }
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


function TnsLogManager.pm_GetLogManager: ILogManager;
//#UC START# *55B761D70223_55B761180244get_var*
//#UC END# *55B761D70223_55B761180244get_var*
begin
//#UC START# *55B761D70223_55B761180244get_impl*
 if not Assigned(f_LogManager) and Assigned(DefDataAdapter) then
  f_LogManager := DefDataAdapter.LogManager;
 Result := f_LogManager;
//#UC END# *55B761D70223_55B761180244get_impl*
end;//TnsLogManager.pm_GetLogManager

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
 f_LoggingTestService.AddLogString(l_LogString);
 LogManager.AddEvent(aLogEvent, aData.AsLogEventData);
//#UC END# *55B760550256_55B761180244_impl*
end;//TnsLogManager.AddEvent

procedure TnsLogManager.Cleanup;
//#UC START# *479731C50290_55B761180244_var*
//#UC END# *479731C50290_55B761180244_var*
begin
//#UC START# *479731C50290_55B761180244_impl*
 f_LogManager := nil;
 f_LoggingTestService := nil;
 inherited;
//#UC END# *479731C50290_55B761180244_impl*
end;//TnsLogManager.Cleanup

procedure TnsLogManager.InitFields;
//#UC START# *47A042E100E2_55B761180244_var*
//#UC END# *47A042E100E2_55B761180244_var*
begin
//#UC START# *47A042E100E2_55B761180244_impl*
 inherited;
 f_LogManager := nil;
 f_LoggingTestService := TnsLoggingTestService.Instance;
//#UC END# *47A042E100E2_55B761180244_impl*
end;//TnsLogManager.InitFields

procedure TnsLogManager.ClearFields;
 {-}
begin
 f_LogManager := nil;
 inherited;
end;//TnsLogManager.ClearFields

end.