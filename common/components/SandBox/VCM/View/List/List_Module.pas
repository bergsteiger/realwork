unit List_Module;
 {* ������ }

// ������: "w:\common\components\SandBox\VCM\View\List\List_Module.pas"
// ���������: "VCMFormsPack"
// ������� ������: "List" MUID: (521DA6370197)
// ��� ����: "TListModule"

{$Include w:\common\components\SandBox\VCM\sbDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TListModule = class({$If NOT Defined(NoVCM)}
 TvcmModule
 {$IfEnd} // NOT Defined(NoVCM)
 )
  {* ������ }
 end;//TListModule

implementation

uses
 l3ImplUses
 //#UC START# *521DA6370197impl_uses*
 //#UC END# *521DA6370197impl_uses*
;

{$If NOT Defined(NoVCM)}
{$IfEnd} // NOT Defined(NoVCM)
end.
