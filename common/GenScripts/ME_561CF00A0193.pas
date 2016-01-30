unit alcuProcessingEnabledService;

// ������: "w:\archi\source\projects\PipeInAuto\Server\alcuProcessingEnabledService.pas"
// ���������: "ServiceImplementation"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3ProcessingEnabledService
;

type
 TalcuProcessingEnabledService = {final} class(Tl3ProtoObject, Il3ProcessingEnabledService)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   function Enabled: Boolean;
   class function Instance: TalcuProcessingEnabledService;
    {* ����� ��������� ���������� ���������� TalcuProcessingEnabledService }
 end;//TalcuProcessingEnabledService
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
 , alcuServer
 , SysUtils
 , l3Base
;

var g_TalcuProcessingEnabledService: TalcuProcessingEnabledService = nil;
 {* ��������� ���������� TalcuProcessingEnabledService }

procedure TalcuProcessingEnabledServiceFree;
 {* ����� ������������ ���������� ���������� TalcuProcessingEnabledService }
begin
 l3Free(g_TalcuProcessingEnabledService);
end;//TalcuProcessingEnabledServiceFree

class function TalcuProcessingEnabledService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TalcuProcessingEnabledService <> nil;
end;//TalcuProcessingEnabledService.Exists

function TalcuProcessingEnabledService.Enabled: Boolean;
//#UC START# *ECCF31CF8A24_561CF00A0193_var*
//#UC END# *ECCF31CF8A24_561CF00A0193_var*
begin
//#UC START# *ECCF31CF8A24_561CF00A0193_impl*
 Result := not TalcuServer.Instance.IsBaseLocked;
//#UC END# *ECCF31CF8A24_561CF00A0193_impl*
end;//TalcuProcessingEnabledService.Enabled

class function TalcuProcessingEnabledService.Instance: TalcuProcessingEnabledService;
 {* ����� ��������� ���������� ���������� TalcuProcessingEnabledService }
begin
 if (g_TalcuProcessingEnabledService = nil) then
 begin
  l3System.AddExitProc(TalcuProcessingEnabledServiceFree);
  g_TalcuProcessingEnabledService := Create;
 end;
 Result := g_TalcuProcessingEnabledService;
end;//TalcuProcessingEnabledService.Instance

initialization
 Tl3ProcessingEnabledService.Instance.Alien := TalcuProcessingEnabledService.Instance;
 {* ����������� TalcuProcessingEnabledService }
{$IfEnd} // Defined(AppServerSide)

end.
