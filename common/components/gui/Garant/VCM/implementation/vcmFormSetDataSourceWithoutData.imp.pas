{$IfNDef vcmFormSetDataSourceWithoutData_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmFormSetDataSourceWithoutData.imp.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmFormSetDataSourceWithoutData
//
// ������ ������ ������. ��� "������ ������"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmFormSetDataSourceWithoutData_imp}
{$If not defined(NoVCM)}
 _SetDataType_ = IvcmData;
 {$Include ..\implementation\vcmFormSetDataSource.imp.pas}
 _vcmFormSetDataSourceWithoutData_ = {mixin} class(_vcmFormSetDataSource_)
  {* ������ ������ ������. ��� "������ ������" }
 protected
 // realized methods
   function MakeData: _SetDataType_; override;
     {* ������ ������. }
 end;//_vcmFormSetDataSourceWithoutData_
{$Else}

 {$Include ..\implementation\vcmFormSetDataSource.imp.pas}
 _vcmFormSetDataSourceWithoutData_ = _vcmFormSetDataSource_;

{$IfEnd} //not NoVCM

{$Else vcmFormSetDataSourceWithoutData_imp}

{$If not defined(NoVCM)}


{$Include ..\implementation\vcmFormSetDataSource.imp.pas}

// start class _vcmFormSetDataSourceWithoutData_

function _vcmFormSetDataSourceWithoutData_.MakeData: _SetDataType_;
//#UC START# *47F3778403D9_49415C640079_var*
//#UC END# *47F3778403D9_49415C640079_var*
begin
//#UC START# *47F3778403D9_49415C640079_impl*
 Result := nil;
 // - �������� "������ ������" �� ������������
//#UC END# *47F3778403D9_49415C640079_impl*
end;//_vcmFormSetDataSourceWithoutData_.MakeData

{$IfEnd} //not NoVCM

{$EndIf vcmFormSetDataSourceWithoutData_imp}
