unit sdsInpharmMainMenu;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "InpharmControllers"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/InpharmControllers/sdsInpharmMainMenu.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Core::Base Operations::InpharmControllers::InpharmMainMenuControllerRealization::TsdsInpharmMainMenu
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
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  InpharmInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _SetType_ = IsdsInpharmMainMenu;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}
 TsdsInpharmMainMenu = {ucc} class(_vcmTinyUseCaseController_, IsdsInpharmMainMenu)
 private
 // private fields
   f_dsInpharmMainMenuData : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsInpharmMainMenuData}
 protected
 // realized methods
   function pm_GetDsInpharmMainMenuData: IdsInpharmMainMenu;
   function DoGet_dsInpharmMainMenuData: IdsInpharmMainMenu;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
 end;//TsdsInpharmMainMenu
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsInpharmMainMenu
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3Base,
  SysUtils,
  vcmFormDataSourceRef {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsInpharmMainMenu;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}

// start class TsdsInpharmMainMenu

function TsdsInpharmMainMenu.pm_GetDsInpharmMainMenuData: IdsInpharmMainMenu;
//#UC START# *550C0D1A00CC_550AAEE001B7get_var*
//#UC END# *550C0D1A00CC_550AAEE001B7get_var*
begin
 if (f_dsInpharmMainMenuData = nil) then
 begin
  f_dsInpharmMainMenuData := TvcmViewAreaControllerRef.Make;
  //#UC START# *550C0D1A00CC_550AAEE001B7get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *550C0D1A00CC_550AAEE001B7get_init*
 end;//f_dsInpharmMainMenuData = nil
 if f_dsInpharmMainMenuData.IsEmpty
  //#UC START# *550C0D1A00CC_550AAEE001B7get_need*
  // - условие создания ViewArea
  //#UC END# *550C0D1A00CC_550AAEE001B7get_need*
  then
   f_dsInpharmMainMenuData.Referred := DoGet_dsInpharmMainMenuData;
 Result := IdsInpharmMainMenu(f_dsInpharmMainMenuData.Referred);
end;

function TsdsInpharmMainMenu.DoGet_dsInpharmMainMenuData: IdsInpharmMainMenu;
//#UC START# *550C0D1A00CC_550AAEE001B7area_var*
//#UC END# *550C0D1A00CC_550AAEE001B7area_var*
begin
//#UC START# *550C0D1A00CC_550AAEE001B7area_impl*
 Result := TdsInpharmMainMenu.Make(Self);
//#UC END# *550C0D1A00CC_550AAEE001B7area_impl*
end;//TsdsInpharmMainMenu.DoGet_dsInpharmMainMenuData

{$If not defined(NoVCM)}
procedure TsdsInpharmMainMenu.ClearAreas;
 {-}
begin
 if (f_dsInpharmMainMenuData <> nil) then f_dsInpharmMainMenuData.Referred := nil;
 inherited;
end;//TsdsInpharmMainMenu.ClearAreas
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.