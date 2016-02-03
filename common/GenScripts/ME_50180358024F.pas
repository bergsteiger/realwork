{$IfNDef vcmFormDataSourceWithFlexUseCaseControllerType_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourceWithFlexUseCaseControllerType.imp.pas"
// Стереотип: "Impurity"

{$Define vcmFormDataSourceWithFlexUseCaseControllerType_imp}

{$If NOT Defined(NoVCM)}
 {$Include vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
 _vcmFormDataSourceWithData_Parent_ = _vcmFormDataSourcePrimWithFlexUseCaseControllerType_;
 {$Include vcmFormDataSourceWithData.imp.pas}
 _vcmFormDataSourceWithFlexUseCaseControllerType_ = class(_vcmFormDataSourceWithData_)
 end;//_vcmFormDataSourceWithFlexUseCaseControllerType_

{$Else NOT Defined(NoVCM)}

{$Include vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
_vcmFormDataSourceWithData_Parent_ = _vcmFormDataSourcePrimWithFlexUseCaseControllerType_;
{$Include vcmFormDataSourceWithData.imp.pas}
_vcmFormDataSourceWithFlexUseCaseControllerType_ = _vcmFormDataSourceWithData_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmFormDataSourceWithFlexUseCaseControllerType_imp}

{$IfNDef vcmFormDataSourceWithFlexUseCaseControllerType_imp_impl}

{$Define vcmFormDataSourceWithFlexUseCaseControllerType_imp_impl}

{$If NOT Defined(NoVCM)}
{$Include vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}

{$Include vcmFormDataSourceWithData.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmFormDataSourceWithFlexUseCaseControllerType_imp_impl}

{$EndIf vcmFormDataSourceWithFlexUseCaseControllerType_imp}

