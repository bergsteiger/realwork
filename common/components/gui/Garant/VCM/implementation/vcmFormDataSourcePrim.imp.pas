{$IfNDef vcmFormDataSourcePrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VCM"
// �����: ������� �.�.
// ������: "w:/common/components/gui/Garant/VCM/implementation/vcmFormDataSourcePrim.imp.pas"
// �����: 2005/07/29 10:44:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmFormDataSourcePrim
//
// ������ ������ �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmFormDataSourcePrim_imp}
{$If not defined(NoVCM)}
 _UseCaseControllerType_ = IvcmFormSetDataSource;
 {$Include ..\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
 _vcmFormDataSourcePrim_ = {mixin} class(_vcmFormDataSourcePrimWithFlexUseCaseControllerType_)
  {* ������ ������ ����� }
 end;//_vcmFormDataSourcePrim_
{$Else}

 {$Include ..\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
 _vcmFormDataSourcePrim_ = _vcmFormDataSourcePrimWithFlexUseCaseControllerType_;

{$IfEnd} //not NoVCM

{$Else vcmFormDataSourcePrim_imp}

{$If not defined(NoVCM)}


{$Include ..\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}


{$IfEnd} //not NoVCM

{$EndIf vcmFormDataSourcePrim_imp}
