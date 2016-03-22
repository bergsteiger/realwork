unit dsInpharmMainMenu;

// ћодуль: "w:\garant6x\implementation\Garant\GbaNemesis\InpharmControllers\dsInpharmMainMenu.pas"
// —тереотип: "ViewAreaControllerImp"
// Ёлемент модели: "TdsInpharmMainMenu" MUID: (550C0DA5022E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , InpharmInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
;

type
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsInpharmMainMenu = {final} class(_vcmFormDataSourcePrim_, IdsInpharmMainMenu)
  protected
   {$If NOT Defined(NoVCM)}
   function GetIsDataAvailable: Boolean; override;
    {* существуют ли данные }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TdsInpharmMainMenu
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TdsInpharmMainMenu;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

function TdsInpharmMainMenu.GetIsDataAvailable: Boolean;
 {* существуют ли данные }
//#UC START# *55097FF5008E_550C0DA5022E_var*
//#UC END# *55097FF5008E_550C0DA5022E_var*
begin
//#UC START# *55097FF5008E_550C0DA5022E_impl*
 Result := defDataAdapter.IsInpharmExists;
//#UC END# *55097FF5008E_550C0DA5022E_impl*
end;//TdsInpharmMainMenu.GetIsDataAvailable
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
