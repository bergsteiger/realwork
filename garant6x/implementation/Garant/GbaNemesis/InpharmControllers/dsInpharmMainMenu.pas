unit dsInpharmMainMenu;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "InpharmControllers"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/InpharmControllers/dsInpharmMainMenu.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Base Operations::InpharmControllers::InpharmMainMenuControllerRealization::TdsInpharmMainMenu
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
  InpharmInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsInpharmMainMenu;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsInpharmMainMenu = {final vac} class(_vcmFormDataSourcePrim_, IdsInpharmMainMenu)
 protected
 // overridden protected methods
    {$If not defined(NoVCM)}
   function GetIsDataAvailable: Boolean; override;
     {* существуют ли данные }
    {$IfEnd} //not NoVCM
 end;//TdsInpharmMainMenu
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsInpharmMainMenu;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

// start class TdsInpharmMainMenu

{$If not defined(NoVCM)}
function TdsInpharmMainMenu.GetIsDataAvailable: Boolean;
//#UC START# *55097FF5008E_550C0DA5022E_var*
//#UC END# *55097FF5008E_550C0DA5022E_var*
begin
//#UC START# *55097FF5008E_550C0DA5022E_impl*
 Result := defDataAdapter.IsInpharmExists;
//#UC END# *55097FF5008E_550C0DA5022E_impl*
end;//TdsInpharmMainMenu.GetIsDataAvailable
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.