unit moParentAndChild;
 {* Поддержка работы с родительской и дочерней зонами }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\moParentAndChild.pas"
// Стереотип: "VCMFormsPack"
// Элемент модели: "ParentAndChild" MUID: (4F6B663803AE)
// Имя типа: "Tmo_ParentAndChild"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 , ParentAndChildPrim_Module
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmModule
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 Tmo_ParentAndChild = {final} class(TParentAndChildPrimModule)
  {* Поддержка работы с родительской и дочерней зонами }
 end;//Tmo_ParentAndChild

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
 TvcmModulesForRegister.AddModule(TvcmModuleForRegister_C(Tmo_ParentAndChild, 'Поддержка работы с родительской и дочерней зонами'));

end.
