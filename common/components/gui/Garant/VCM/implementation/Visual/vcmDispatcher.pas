unit vcmDispatcher;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmDispatcher.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmDispatcher" MUID: (57D2C1600360)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBase
 , vcmFormDispatcherInterfaces
 , vcmInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmExternalInterfaces
 , l3Core
;

{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57D2C1600360impl_uses*
 //#UC END# *57D2C1600360impl_uses*
;

{$IfEnd} // NOT Defined(NoVCM)

end.
