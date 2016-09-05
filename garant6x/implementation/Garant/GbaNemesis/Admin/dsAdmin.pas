unit dsAdmin;
 {* бизнес объект контейнера cfAdmin }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\dsAdmin.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsAdmin" MUID: (491D945A00C7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , AdminInterfaces
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
 _FormDataSourceType_ = IdsAdmin;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsAdmin = {final} class(_vcmFormDataSourcePrim_, IdsAdmin)
  {* бизнес объект контейнера cfAdmin }
 end;//TdsAdmin
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , l3Base
 //#UC START# *491D945A00C7impl_uses*
 //#UC END# *491D945A00C7impl_uses*
;

type _Instance_R_ = TdsAdmin;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
{$IfEnd} // Defined(Admin)

end.
