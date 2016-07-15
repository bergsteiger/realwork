unit moRealCommon;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\moRealCommon.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "RealCommon" MUID: (4A92C0AB0155)
// Имя типа: "Tmo_RealCommon"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimCommon_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_RealCommon = {final} class(TPrimCommonModule)
 end;//Tmo_RealCommon

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmModulesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModuleOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
;

initialization
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_RealCommon, ''));

end.
