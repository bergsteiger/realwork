unit l3TabService;

// ������: "w:\common\components\rtl\Garant\L3\l3TabService.pas"
// ���������: "Service"
// ������� ������: "Tl3TabService" MUID: (550AE937003B)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
;

 (*
 Ml3TabService = interface
  {* �������� ������� Tl3TabService }
  function HasTabs: Boolean;
 end;//Ml3TabService
 *)

type
 Il3TabService = interface
  {* ��������� ������� Tl3TabService }
  ['{D4A2A5A2-FB9C-4ECA-B050-7914DC032822}']
  function HasTabs: Boolean;
 end;//Il3TabService

 Tl3TabService = {final} class(Tl3ProtoObject)
  private
   f_Alien: Il3TabService;
    {* ������� ���������� ������� Il3TabService }
  protected
   procedure pm_SetAlien(const aValue: Il3TabService);
   procedure ClearFields; override;
  public
   function HasTabs: Boolean;
   class function Instance: Tl3TabService;
    {* ����� ��������� ���������� ���������� Tl3TabService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: Il3TabService
    write pm_SetAlien;
    {* ������� ���������� ������� Il3TabService }
 end;//Tl3TabService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_Tl3TabService: Tl3TabService = nil;
 {* ��������� ���������� Tl3TabService }

procedure Tl3TabServiceFree;
 {* ����� ������������ ���������� ���������� Tl3TabService }
begin
 l3Free(g_Tl3TabService);
end;//Tl3TabServiceFree

procedure Tl3TabService.pm_SetAlien(const aValue: Il3TabService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//Tl3TabService.pm_SetAlien

function Tl3TabService.HasTabs: Boolean;
//#UC START# *A8AF111E1F35_550AE937003B_var*
//#UC END# *A8AF111E1F35_550AE937003B_var*
begin
//#UC START# *A8AF111E1F35_550AE937003B_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.HasTabs
 else
  Result := false;
//#UC END# *A8AF111E1F35_550AE937003B_impl*
end;//Tl3TabService.HasTabs

class function Tl3TabService.Instance: Tl3TabService;
 {* ����� ��������� ���������� ���������� Tl3TabService }
begin
 if (g_Tl3TabService = nil) then
 begin
  l3System.AddExitProc(Tl3TabServiceFree);
  g_Tl3TabService := Create;
 end;
 Result := g_Tl3TabService;
end;//Tl3TabService.Instance

class function Tl3TabService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_Tl3TabService <> nil;
end;//Tl3TabService.Exists

procedure Tl3TabService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//Tl3TabService.ClearFields

end.
