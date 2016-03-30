unit imeStampObjectManager;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\imeStampObjectManager.pas"
// ���������: "SimpleClass"
// ������� ������: "TimeStampObjectManager" MUID: (4614E03B02EE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 //#UC START# *4614E03B02EEintf_uses*
 //#UC END# *4614E03B02EEintf_uses*
;

type
 //#UC START# *4614E03B02EEci*
 //#UC END# *4614E03B02EEci*
 //#UC START# *4614E03B02EEcit*
 //#UC END# *4614E03B02EEcit*
 TimeStampObjectManager = class
  public
   class function Instance: TimeStampObjectManager;
    {* ����� ��������� ���������� ���������� TimeStampObjectManager }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 //#UC START# *4614E03B02EEpubl*
 //#UC END# *4614E03B02EEpubl*
 end;//TimeStampObjectManager

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *4614E03B02EEimpl_uses*
 //#UC END# *4614E03B02EEimpl_uses*
;

var g_TimeStampObjectManager: TimeStampObjectManager = nil;
 {* ��������� ���������� TimeStampObjectManager }

procedure TimeStampObjectManagerFree;
 {* ����� ������������ ���������� ���������� TimeStampObjectManager }
begin
 l3Free(g_TimeStampObjectManager);
end;//TimeStampObjectManagerFree

class function TimeStampObjectManager.Instance: TimeStampObjectManager;
 {* ����� ��������� ���������� ���������� TimeStampObjectManager }
begin
 if (g_TimeStampObjectManager = nil) then
 begin
  l3System.AddExitProc(TimeStampObjectManagerFree);
  g_TimeStampObjectManager := Create;
 end;
 Result := g_TimeStampObjectManager;
end;//TimeStampObjectManager.Instance

class function TimeStampObjectManager.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TimeStampObjectManager <> nil;
end;//TimeStampObjectManager.Exists

//#UC START# *4614E03B02EEimpl*
//#UC END# *4614E03B02EEimpl*

end.
