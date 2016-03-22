{$IfNDef vcmFormDataSource_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "vcmFormDataSource" MUID: (492ACB4100B2)
// Имя типа: "_vcmFormDataSource_"

{$Define vcmFormDataSource_imp}

{$If NOT Defined(NoVCM)}
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 _vcmFormDataSourceWithData_Parent_ = _vcmFormDataSourcePrim_;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourceWithData.imp.pas}
 _vcmFormDataSource_ = class(_vcmFormDataSourceWithData_)
  {* Бизнес-объект формы }
 end;//_vcmFormDataSource_

{$Else NOT Defined(NoVCM)}

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
_vcmFormDataSourceWithData_Parent_ = _vcmFormDataSourcePrim_;
{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourceWithData.imp.pas}
_vcmFormDataSource_ = _vcmFormDataSourceWithData_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmFormDataSource_imp}

{$IfNDef vcmFormDataSource_imp_impl}

{$Define vcmFormDataSource_imp_impl}

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourceWithData.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmFormDataSource_imp_impl}

{$EndIf vcmFormDataSource_imp}

