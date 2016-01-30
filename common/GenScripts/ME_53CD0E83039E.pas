unit NOT_FINISHED_dt_User;

// Модуль: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_dt_User.pas"
// Стереотип: "UtilityPack"

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
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TUserManager;
    {* Метод получения экземпляра синглетона TUserManager }
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
 {* Экземпляр синглетона TUserManager }

procedure TUserManagerFree;
 {* Метод освобождения экземпляра синглетона TUserManager }
begin
 l3Free(g_TUserManager);
end;//TUserManagerFree

class function TUserManager.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TUserManager <> nil;
end;//TUserManager.Exists

class function TUserManager.Instance: TUserManager;
 {* Метод получения экземпляра синглетона TUserManager }
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
