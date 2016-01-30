unit nsLogManager;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsLogManager.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
 , LoggingWrapperInterfaces
 , LoggingUnit
;

type
 TnsLogManager = class(Tl3SimpleObject, InsLogManager)
  private
   f_LoggingTestService: InsLoggingTestService;
   f_LogManager: ILogManager;
    {* ���� ��� �������� LogManager }
  protected
   function pm_GetLogManager: ILogManager;
   procedure AddEvent(aLogEvent: TLogEvent;
    const aData: InsLogEventData);
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TnsLogManager;
    {* ����� ��������� ���������� ���������� TnsLogManager }
  protected
   property LogManager: ILogManager
    read pm_GetLogManager;
 end;//TnsLogManager

implementation

uses
 l3ImplUses
 , DataAdapter
 , nsLoggingTestService
 , TypInfo
 , SysUtils
 , l3Base
;

var g_TnsLogManager: TnsLogManager = nil;
 {* ��������� ���������� TnsLogManager }

procedure TnsLogManagerFree;
 {* ����� ������������ ���������� ���������� TnsLogManager }
begin
 l3Free(g_TnsLogManager);
end;//TnsLogManagerFree

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
 {* ��������� ������ ��������� ���������� ��� ��� }
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

class function TnsLogManager.Instance: TnsLogManager;
 {* ����� ��������� ���������� ���������� TnsLogManager }
begin
 if (g_TnsLogManager = nil) then
 begin
  l3System.AddExitProc(TnsLogManagerFree);
  g_TnsLogManager := Create;
 end;
 Result := g_TnsLogManager;
end;//TnsLogManager.Instance

procedure TnsLogManager.Cleanup;
 {* ������� ������� ����� �������. }
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

procedure TnsLogManager.ClearFields;
begin
 f_LogManager := nil;
 inherited;
end;//TnsLogManager.ClearFields

end.
