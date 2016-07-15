unit fsInpharmMainMenu;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsInpharmMainMenu.pas"
// Стереотип: "VCMFormSetFactory"
// Элемент модели: "InpharmMainMenu" MUID: (550C0EE00301)
// Имя типа: "Tfs_InpharmMainMenu"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmFormSetFactoryPrim
 {$IfEnd} // NOT Defined(NoVCM)
 , InpharmMainMenu_ut_mmmMain_UserType
 , Common_FormDefinitions_Controls
 , InpharmInterfaces
;

type
 Tfs_InpharmMainMenu = {final} class({$If NOT Defined(NoVCM)}
 TvcmFormSetFactory
 {$IfEnd} // NOT Defined(NoVCM)
 )
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function MainParentUtMmmMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Main }
   class function Instance: Tfs_InpharmMainMenu;
    {* Метод получения экземпляра синглетона Tfs_InpharmMainMenu }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//Tfs_InpharmMainMenu
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
var g_Tfs_InpharmMainMenu: Tfs_InpharmMainMenu = nil;
 {* Экземпляр синглетона Tfs_InpharmMainMenu }

procedure Tfs_InpharmMainMenuFree;
 {* Метод освобождения экземпляра синглетона Tfs_InpharmMainMenu }
begin
 l3Free(g_Tfs_InpharmMainMenu);
end;//Tfs_InpharmMainMenuFree

function Tfs_InpharmMainMenu.MainParentUtMmmMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Main }
var
 l_UseCase : IsdsInpharmMainMenu;
begin
 if Supports(aDataSource, IsdsInpharmMainMenu, l_UseCase) then
  try
   aNew := l_UseCase.dsInpharmMainMenuData;
  finally
   l_UseCase := nil;
  end;//try..finally
 Result := (aNew <> nil);
end;//Tfs_InpharmMainMenu.MainParentUtMmmMainNeedMakeForm

class function Tfs_InpharmMainMenu.Instance: Tfs_InpharmMainMenu;
 {* Метод получения экземпляра синглетона Tfs_InpharmMainMenu }
begin
 if (g_Tfs_InpharmMainMenu = nil) then
 begin
  l3System.AddExitProc(Tfs_InpharmMainMenuFree);
  g_Tfs_InpharmMainMenu := Create;
 end;
 Result := g_Tfs_InpharmMainMenu;
end;//Tfs_InpharmMainMenu.Instance

class function Tfs_InpharmMainMenu.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_InpharmMainMenu <> nil;
end;//Tfs_InpharmMainMenu.Exists

procedure Tfs_InpharmMainMenu.InitFields;
begin
 inherited;
 with AddZone('Main', vcm_ztParent, fm_en_MedicMainMenu) do
 begin
  UserType := ut_mmmMain;
  OnNeedMakeForm := MainParentUtMmmMainNeedMakeForm;
 end;
 OwnerForm := 0;
end;//Tfs_InpharmMainMenu.InitFields

class function Tfs_InpharmMainMenu.GetInstance: TvcmFormSetFactoryPrim;
begin
 Result := Self.Instance;
end;//Tfs_InpharmMainMenu.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
