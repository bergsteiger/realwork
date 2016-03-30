{$IfNDef vcmFormDataSourcePrim_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "vcmFormDataSourcePrim" MUID: (47ECE94D03D4)
// Имя типа: "_vcmFormDataSourcePrim_"

{$Define vcmFormDataSourcePrim_imp}

{$If NOT Defined(NoVCM)}
 _UseCaseControllerType_ = IvcmFormSetDataSource;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
 _vcmFormDataSourcePrim_ = class(_vcmFormDataSourcePrimWithFlexUseCaseControllerType_)
  {* Бизнес объект формы }
 end;//_vcmFormDataSourcePrim_

{$Else NOT Defined(NoVCM)}

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
_vcmFormDataSourcePrim_ = _vcmFormDataSourcePrimWithFlexUseCaseControllerType_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmFormDataSourcePrim_imp}

{$IfNDef vcmFormDataSourcePrim_imp_impl}

{$Define vcmFormDataSourcePrim_imp_impl}

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmFormDataSourcePrim_imp_impl}

{$EndIf vcmFormDataSourcePrim_imp}

