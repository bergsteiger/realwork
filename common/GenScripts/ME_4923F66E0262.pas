unit dsSaveLoad;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\dsSaveLoad.pas"
// Стереотип: "ViewAreaControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , QueryCardInterfaces
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
 TdsSaveLoad = {final} class(_vcmFormDataSourcePrim_, IdsSaveLoad)
 end;//TdsSaveLoad
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

{$If not Declared(_UseCaseControllerType_)}type _UseCaseControllerType_ = IvcmFormSetDataSource;{$IfEnd}

type _Instance_R_ = TdsSaveLoad;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
{$IfEnd} // NOT Defined(Admin)

end.
