unit dsListAnalize;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\List\dsListAnalize.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsListAnalize" MUID: (4E368C9A03AD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkWithListInterfaces
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
 _FormDataSourceType_ = IdsListAnalize;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsListAnalize = {final} class(_vcmFormDataSourcePrim_, IdsListAnalize)
 end;//TdsListAnalize
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

type _Instance_R_ = TdsListAnalize;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
