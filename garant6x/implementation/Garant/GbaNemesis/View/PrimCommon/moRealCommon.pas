unit moRealCommon;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\moRealCommon.pas"
// ���������: "VCMFormsPack"
// ������� ������: "RealCommon" MUID: (4A92C0AB0155)
// ��� ����: "Tmo_RealCommon"

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
