{$IfNDef vcmFormSetDataSourceWithoutData_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas"
// Стереотип: "Impurity"

{$Define vcmFormSetDataSourceWithoutData_imp}

{$If NOT Defined(NoVCM)}
 _SetDataType_ = IvcmData;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}
 _vcmFormSetDataSourceWithoutData_ = class(_vcmFormSetDataSource_)
  {* Бизнес объект сборки. Без "данных сборки" }
  protected
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
 end;//_vcmFormSetDataSourceWithoutData_

{$Else NOT Defined(NoVCM)}

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}
_vcmFormSetDataSourceWithoutData_ = _vcmFormSetDataSource_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmFormSetDataSourceWithoutData_imp}

{$IfNDef vcmFormSetDataSourceWithoutData_imp_impl}

{$Define vcmFormSetDataSourceWithoutData_imp_impl}

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas}

function _vcmFormSetDataSourceWithoutData_.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_49415C640079_var*
//#UC END# *47F3778403D9_49415C640079_var*
begin
//#UC START# *47F3778403D9_49415C640079_impl*
 Result := nil;
 // - механизм "данных сборки" не используется
//#UC END# *47F3778403D9_49415C640079_impl*
end;//_vcmFormSetDataSourceWithoutData_.MakeData
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmFormSetDataSourceWithoutData_imp_impl}

{$EndIf vcmFormSetDataSourceWithoutData_imp}

