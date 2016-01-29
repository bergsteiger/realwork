unit fsInpharmMainMenu;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/fsInpharmMainMenu.pas"
// Начат: 04.09.2009 12:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFormSetFactory::Class>> F1 Встроенные продукты::Inpharm::View::Inpharm::Inpharm::InpharmMainMenu
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactory
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  InpharmInterfaces,
  InpharmMainMenu_ut_mmmMain_UserType,
  Common_FormDefinitions_Controls
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFormsCollectionItemPrim
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmFormSetFactoryPrim
  {$IfEnd} //not NoVCM
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  Tfs_InpharmMainMenu = {final fsf} class(TvcmFormSetFactory)
  protected
  // overridden protected methods
   procedure InitFields; override;
    {$If not defined(NoVCM)}
   class function GetInstance: TvcmFormSetFactoryPrim; override;
    {$IfEnd} //not NoVCM
  public
  // public methods
   function MainParentUtMmmMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
      out aNew: IvcmFormDataSource;
      aSubUserType: TvcmUserType): Boolean;
     {* Обработчик OnNeedMakeForm для Main }
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
  public
  // singleton factory method
    class function Instance: Tfs_InpharmMainMenu;
     {- возвращает экземпляр синглетона. }
  end;//Tfs_InpharmMainMenu
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


// start class Tfs_InpharmMainMenu

var g_Tfs_InpharmMainMenu : Tfs_InpharmMainMenu = nil;

procedure Tfs_InpharmMainMenuFree;
begin
 l3Free(g_Tfs_InpharmMainMenu);
end;

class function Tfs_InpharmMainMenu.Instance: Tfs_InpharmMainMenu;
begin
 if (g_Tfs_InpharmMainMenu = nil) then
 begin
  l3System.AddExitProc(Tfs_InpharmMainMenuFree);
  g_Tfs_InpharmMainMenu := Create;
 end;
 Result := g_Tfs_InpharmMainMenu;
end;


function Tfs_InpharmMainMenu.MainParentUtMmmMainNeedMakeForm(const aDataSource: IvcmFormSetDataSource;
  out aNew: IvcmFormDataSource;
  aSubUserType: TvcmUserType): Boolean;
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

class function Tfs_InpharmMainMenu.Exists: Boolean;
 {-}
begin
 Result := g_Tfs_InpharmMainMenu <> nil;
end;//Tfs_InpharmMainMenu.Exists

procedure Tfs_InpharmMainMenu.InitFields;
 {-}
begin
 inherited;
 with AddZone('Main', vcm_ztParent, fm_en_MedicMainMenu) do
 begin
  UserType := ut_mmmMain;
  OnNeedMakeForm := MainParentUtMmmMainNeedMakeForm;
 end;
 OwnerForm := 0;
end;//Tfs_InpharmMainMenu.InitFields

{$If not defined(NoVCM)}
class function Tfs_InpharmMainMenu.GetInstance: TvcmFormSetFactoryPrim;
 {-}
begin
 Result := Self.Instance;
end;//Tfs_InpharmMainMenu.GetInstance
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.