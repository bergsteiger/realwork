{$IfNDef vcmFormSetDataSourceWithFlexFormSetType_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmFormSetDataSourceWithFlexFormSetType.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmFormSetDataSourceWithFlexFormSetType
//
// ������-������ ������, ��������������� ����� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmFormSetDataSourceWithFlexFormSetType_imp}
{$If not defined(NoVCM)}
 {$Include ..\implementation\vcmFormSetDataSource.imp.pas}
 _vcmFormSetDataSourceWithFlexFormSetType_ = {mixin} class(_vcmFormSetDataSource_)
  {* ������-������ ������, ��������������� ����� ������ }
 protected
 // property methods
   function pm_GetUCFormSet: _FormSetType_; virtual;
 protected
 // protected properties
   property UCFormSet: _FormSetType_
     read pm_GetUCFormSet;
 end;//_vcmFormSetDataSourceWithFlexFormSetType_
{$Else}

 {$Include ..\implementation\vcmFormSetDataSource.imp.pas}
 _vcmFormSetDataSourceWithFlexFormSetType_ = _vcmFormSetDataSource_;

{$IfEnd} //not NoVCM

{$Else vcmFormSetDataSourceWithFlexFormSetType_imp}

{$If not defined(NoVCM)}


{$Include ..\implementation\vcmFormSetDataSource.imp.pas}

// start class _vcmFormSetDataSourceWithFlexFormSetType_

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

{$IfEnd} //not NoVCM

{$EndIf vcmFormSetDataSourceWithFlexFormSetType_imp}
