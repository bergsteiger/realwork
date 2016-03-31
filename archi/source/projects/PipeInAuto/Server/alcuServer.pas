unit alcuServer;

// ������: "w:\archi\source\projects\PipeInAuto\Server\alcuServer.pas"
// ���������: "SimpleClass"
// ������� ������: "TalcuServer" MUID: (52F8C9E00037)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
 , alcuAutoPipeServer
;

type
 TalcuServer = class(TalcuServerPrim)
  protected
   procedure AfterDestroyCalled; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TalcuServer;
    {* ����� ��������� ���������� ���������� TalcuServer }
 end;//TalcuServer
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
 , alcuStrings
 , l3Base
 , SysUtils
 , alcuTaskChangeHelper
;

var g_TalcuServer: TalcuServer = nil;
 {* ��������� ���������� TalcuServer }

procedure TalcuServerFree;
 {* ����� ������������ ���������� ���������� TalcuServer }
begin
 l3Free(g_TalcuServer);
end;//TalcuServerFree

class function TalcuServer.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TalcuServer <> nil;
end;//TalcuServer.Exists

class function TalcuServer.Instance: TalcuServer;
 {* ����� ��������� ���������� ���������� TalcuServer }
begin
 if (g_TalcuServer = nil) then
 begin
  l3System.AddExitProc(TalcuServerFree);
  g_TalcuServer := Create;
 end;
 Result := g_TalcuServer;
end;//TalcuServer.Instance

procedure TalcuServer.AfterDestroyCalled;
//#UC START# *52BC2B9401F3_52F8C9E00037_var*
//#UC END# *52BC2B9401F3_52F8C9E00037_var*
begin
//#UC START# *52BC2B9401F3_52F8C9E00037_impl*
 Assert(g_l3System <> nil);
 Tl3System(g_l3System).Str2Log(FormatDateTime(rsSessiyaostanovlenaDDMMYYYYvHhNn, Now));
 inherited;
//#UC END# *52BC2B9401F3_52F8C9E00037_impl*
end;//TalcuServer.AfterDestroyCalled
{$IfEnd} // Defined(AppServerSide)

end.
