{$IfNDef vcmFormDataSource_imp}

// ������: "w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas"
// ���������: "Impurity"

{$Define vcmFormDataSource_imp}

{$If NOT Defined(NoVCM)}
 {$Include vcmFormDataSourcePrim.imp.pas}
 _vcmFormDataSourceWithData_Parent_ = _vcmFormDataSourcePrim_;
 {$Include vcmFormDataSourceWithData.imp.pas}
 _vcmFormDataSource_ = class(_vcmFormDataSourceWithData_)
  {* ������-������ ����� }
 end;//_vcmFormDataSource_

{$Else NOT Defined(NoVCM)}

{$Include vcmFormDataSourcePrim.imp.pas}
_vcmFormDataSourceWithData_Parent_ = _vcmFormDataSourcePrim_;
{$Include vcmFormDataSourceWithData.imp.pas}
_vcmFormDataSource_ = _vcmFormDataSourceWithData_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmFormDataSource_imp}

{$IfNDef vcmFormDataSource_imp_impl}

{$Define vcmFormDataSource_imp_impl}

{$If NOT Defined(NoVCM)}
type _Instance_R_ = _vcmFormDataSource_;

{$Include vcmFormDataSourcePrim.imp.pas}

{$Include vcmFormDataSourceWithData.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmFormDataSource_imp_impl}

{$EndIf vcmFormDataSource_imp}

