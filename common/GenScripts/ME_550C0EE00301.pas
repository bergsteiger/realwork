unit fsInpharmMainMenu;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\fsInpharmMainMenu.pas"
// Стереотип: "VCMFormSetFactory"

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
 // Main

 Tfs_InpharmMainMenu = {final} class(TvcmFormSetFactory)
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Main_Parent_ut_mmmMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
    out aNew: IvcmFormDataSource;
    aSubUserType: TvcmUserType): Boolean;
    {* Обработчик OnNeedMakeForm для Main }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: Tfs_InpharmMainMenu;
    {* Метод получения экземпляра синглетона Tfs_InpharmMainMenu }
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

function Tfs_InpharmMainMenu.Main_Parent_ut_mmmMain_NeedMakeForm(const aDataSource: IvcmFormSetDataSource;
 out aNew: IvcmFormDataSource;
 aSubUserType: TvcmUserType): Boolean;
 {* Обработчик OnNeedMakeForm для Main }
//#UC START# *C1D9743E0694_550C0EE00301_var*
//#UC END# *C1D9743E0694_550C0EE00301_var*
begin
//#UC START# *C1D9743E0694_550C0EE00301_impl*
 !!! Needs to be implemented !!!
//#UC END# *C1D9743E0694_550C0EE00301_impl*
end;//Tfs_InpharmMainMenu.Main_Parent_ut_mmmMain_NeedMakeForm

class function Tfs_InpharmMainMenu.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_Tfs_InpharmMainMenu <> nil;
end;//Tfs_InpharmMainMenu.Exists

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

procedure Tfs_InpharmMainMenu.InitFields;
//#UC START# *47A042E100E2_550C0EE00301_var*
//#UC END# *47A042E100E2_550C0EE00301_var*
begin
//#UC START# *47A042E100E2_550C0EE00301_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_550C0EE00301_impl*
end;//Tfs_InpharmMainMenu.InitFields

class function Tfs_InpharmMainMenu.GetInstance: TvcmFormSetFactoryPrim;
//#UC START# *4FFE854A009B_550C0EE00301_var*
//#UC END# *4FFE854A009B_550C0EE00301_var*
begin
//#UC START# *4FFE854A009B_550C0EE00301_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFE854A009B_550C0EE00301_impl*
end;//Tfs_InpharmMainMenu.GetInstance
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
