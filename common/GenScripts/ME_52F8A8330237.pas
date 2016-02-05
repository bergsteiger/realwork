{$IfNDef vcmFormSetDataSourceWithFlexFormSetType_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithFlexFormSetType.imp.pas"
// Стереотип: "Impurity"

{$Define vcmFormSetDataSourceWithFlexFormSetType_imp}

{$If NOT Defined(NoVCM)}
 // _FormSetType_

 {$Include vcmFormSetDataSource.imp.pas}
 _vcmFormSetDataSourceWithFlexFormSetType_ = class(_vcmFormSetDataSource_)
  {* Бизнес-объект сборки, параметризуемый типом сборки }
  protected
   function pm_GetUCFormSet: _FormSetType_; virtual;
  protected
   property UCFormSet: _FormSetType_
    read pm_GetUCFormSet;
 end;//_vcmFormSetDataSourceWithFlexFormSetType_

{$Else NOT Defined(NoVCM)}

{$Include vcmFormSetDataSource.imp.pas}
_vcmFormSetDataSourceWithFlexFormSetType_ = _vcmFormSetDataSource_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmFormSetDataSourceWithFlexFormSetType_imp}

{$IfNDef vcmFormSetDataSourceWithFlexFormSetType_imp_impl}

{$Define vcmFormSetDataSourceWithFlexFormSetType_imp_impl}

{$If NOT Defined(NoVCM)}
{$Include vcmFormSetDataSource.imp.pas}

function _vcmFormSetDataSourceWithFlexFormSetType_.pm_GetUCFormSet: _FormSetType_;
//#UC START# *52F8A952021E_52F8A8330237get_var*
var
 l_FormSet: _FormSetType_;
//#UC END# *52F8A952021E_52F8A8330237get_var*
begin
//#UC START# *52F8A952021E_52F8A8330237get_impl*
 Result := nil;
 if (FormSet <> nil) and FormSet.CastFS(_FormSetType_, l_FormSet) then
 try
  Result := l_FormSet;
 finally
  l_FormSet := nil;
 end;
//#UC END# *52F8A952021E_52F8A8330237get_impl*
end;//_vcmFormSetDataSourceWithFlexFormSetType_.pm_GetUCFormSet
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmFormSetDataSourceWithFlexFormSetType_imp_impl}

{$EndIf vcmFormSetDataSourceWithFlexFormSetType_imp}

