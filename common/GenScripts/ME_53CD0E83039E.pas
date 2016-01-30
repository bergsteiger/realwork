unit NOT_FINISHED_dt_User;

// ������: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_dt_User.pas"
// ���������: "UtilityPack"

{$Include DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TUserManager = class
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TUserManager;
    {* ����� ��������� ���������� ���������� TUserManager }
 end;//TUserManager

var UserManager: TUserManager;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TUserManager: TUserManager = nil;
 {* ��������� ���������� TUserManager }

procedure TUserManagerFree;
 {* ����� ������������ ���������� ���������� TUserManager }
begin
 l3Free(g_TUserManager);
end;//TUserManagerFree

class function TUserManager.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TUserManager <> nil;
end;//TUserManager.Exists

class function TUserManager.Instance: TUserManager;
 {* ����� ��������� ���������� ���������� TUserManager }
begin
 if (g_TUserManager = nil) then
 begin
  l3System.AddExitProc(TUserManagerFree);
  g_TUserManager := Create;
 end;
 Result := g_TUserManager;
end;//TUserManager.Instance
{$IfEnd} // NOT Defined(Nemesis)

end.
