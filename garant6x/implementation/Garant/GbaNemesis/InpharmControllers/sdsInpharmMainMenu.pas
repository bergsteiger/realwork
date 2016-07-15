unit sdsInpharmMainMenu;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\InpharmControllers\sdsInpharmMainMenu.pas"
// Стереотип: "UseCaseControllerImp"
// Элемент модели: "TsdsInpharmMainMenu" MUID: (550AAEE001B7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , InpharmInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _SetType_ = IsdsInpharmMainMenu;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}
 TsdsInpharmMainMenu = class(_vcmTinyUseCaseController_, IsdsInpharmMainMenu)
  private
   f_dsInpharmMainMenuData: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsInpharmMainMenuData }
  protected
   function pm_GetDsInpharmMainMenuData: IdsInpharmMainMenu;
   function DoGet_DsInpharmMainMenuData: IdsInpharmMainMenu;
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsInpharmMainMenu
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsInpharmMainMenu
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
;

type _Instance_R_ = TsdsInpharmMainMenu;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmTinyUseCaseController.imp.pas}

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
end;//TsdsInpharmMainMenu.pm_GetDsInpharmMainMenuData

function TsdsInpharmMainMenu.DoGet_DsInpharmMainMenuData: IdsInpharmMainMenu;
//#UC START# *550C0D1A00CC_550AAEE001B7area_var*
//#UC END# *550C0D1A00CC_550AAEE001B7area_var*
begin
//#UC START# *550C0D1A00CC_550AAEE001B7area_impl*
 Result := TdsInpharmMainMenu.Make(Self);
//#UC END# *550C0D1A00CC_550AAEE001B7area_impl*
end;//TsdsInpharmMainMenu.DoGet_DsInpharmMainMenuData

procedure TsdsInpharmMainMenu.ClearFields;
begin
 f_dsInpharmMainMenuData := nil;
 inherited;
end;//TsdsInpharmMainMenu.ClearFields

{$If NOT Defined(NoVCM)}
procedure TsdsInpharmMainMenu.ClearAreas;
 {* Очищает ссылки на области ввода }
begin
 if (f_dsInpharmMainMenuData <> nil) then f_dsInpharmMainMenuData.Referred := nil;
 inherited;
end;//TsdsInpharmMainMenu.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
