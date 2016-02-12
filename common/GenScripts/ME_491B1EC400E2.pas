unit vcmFormDataSource;
 {* "Бизнес объект формы". Для поддержки старого нетипизированного подхода }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmControllers
 , vcmInterfaces
 , l3ProtoObjectWithCOMQI
 , vcmLocalInterfaces
 , vcmExternalInterfaces
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _InitDataType_ = IUnknown;
 _FormDataSourceType_ = IvcmViewAreaController;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 TvcmFormDataSource = class(_vcmFormDataSource_)
  {* "Бизнес объект формы". Для поддержки старого нетипизированного подхода }
 end;//TvcmFormDataSource
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3InterfacesMisc
 , SysUtils
 , l3Base
;

type _Instance_R_ = TvcmFormDataSource;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
