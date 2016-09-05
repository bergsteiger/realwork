unit dsChild;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dsChild.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsChild" MUID: (4D7A7ADE0122)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , CommonDictionInterfaces
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
 _FormDataSourceType_ = IdsChild;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsChild = {final} class(_vcmFormDataSourcePrim_, IdsChild)
 end;//TdsChild
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , l3Base
 //#UC START# *4D7A7ADE0122impl_uses*
 //#UC END# *4D7A7ADE0122impl_uses*
;

type _Instance_R_ = TdsChild;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
