{$IfNDef vcmFormDataSource_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmFormDataSource.imp.pas"
// �����: 24.11.2008 18:42
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmFormDataSource
//
// ������-������ �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmFormDataSource_imp}
{$If not defined(NoVCM)}
 {$Include ..\implementation\vcmFormDataSourcePrim.imp.pas}
 _vcmFormDataSourceWithData_Parent_ = _vcmFormDataSourcePrim_;
 {$Include ..\implementation\vcmFormDataSourceWithData.imp.pas}
 _vcmFormDataSource_ = {mixin} class(_vcmFormDataSourceWithData_)
  {* ������-������ ����� }
 end;//_vcmFormDataSource_
{$Else}

 {$Include ..\implementation\vcmFormDataSourcePrim.imp.pas}
 _vcmFormDataSourceWithData_Parent_ = _vcmFormDataSourcePrim_;
 {$Include ..\implementation\vcmFormDataSourceWithData.imp.pas}
 _vcmFormDataSource_ = _vcmFormDataSourceWithData_;

{$IfEnd} //not NoVCM

{$Else vcmFormDataSource_imp}

{$If not defined(NoVCM)}


{$Include ..\implementation\vcmFormDataSourcePrim.imp.pas}

{$Include ..\implementation\vcmFormDataSourceWithData.imp.pas}


{$IfEnd} //not NoVCM

{$EndIf vcmFormDataSource_imp}
