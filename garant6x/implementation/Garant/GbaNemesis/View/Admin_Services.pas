unit Admin_Services;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin_Services.pas"
// Стереотип: "VCMContracts"
// Элемент модели: "Services" MUID: (57A351800138)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , AdminInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 MAdminService = interface
  {* Контракт сервиса TAdminService }
  function ShowRenameGroupDialog(const aData: IbsEditGroupName): Integer;
  procedure OpenUserList(const aContainer: IvcmContainer);
 end;//MAdminService
 *)

type
 IAdminService = interface
  {* Интерфейс сервиса TAdminService }
  function ShowRenameGroupDialog(const aData: IbsEditGroupName): Integer;
  procedure OpenUserList(const aContainer: IvcmContainer);
 end;//IAdminService

 TAdminService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IAdminService;
    {* Внешняя реализация сервиса IAdminService }
  protected
   procedure pm_SetAlien(const aValue: IAdminService);
   procedure ClearFields; override;
  public
   function ShowRenameGroupDialog(const aData: IbsEditGroupName): Integer;
   procedure OpenUserList(const aContainer: IvcmContainer);
   class function Instance: TAdminService;
    {* Метод получения экземпляра синглетона TAdminService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IAdminService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IAdminService }
 end;//TAdminService
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

var g_TAdminService: TAdminService = nil;
 {* Экземпляр синглетона TAdminService }

procedure TAdminServiceFree;
 {* Метод освобождения экземпляра синглетона TAdminService }
begin
 l3Free(g_TAdminService);
end;//TAdminServiceFree

procedure TAdminService.pm_SetAlien(const aValue: IAdminService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TAdminService.pm_SetAlien

function TAdminService.ShowRenameGroupDialog(const aData: IbsEditGroupName): Integer;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.ShowRenameGroupDialog(aData)
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TAdminService.ShowRenameGroupDialog

procedure TAdminService.OpenUserList(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenUserList(aContainer);
end;//TAdminService.OpenUserList

class function TAdminService.Instance: TAdminService;
 {* Метод получения экземпляра синглетона TAdminService }
begin
 if (g_TAdminService = nil) then
 begin
  l3System.AddExitProc(TAdminServiceFree);
  g_TAdminService := Create;
 end;
 Result := g_TAdminService;
end;//TAdminService.Instance

class function TAdminService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TAdminService <> nil;
end;//TAdminService.Exists

procedure TAdminService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TAdminService.ClearFields

initialization
{$IfEnd} // Defined(Admin)

end.
