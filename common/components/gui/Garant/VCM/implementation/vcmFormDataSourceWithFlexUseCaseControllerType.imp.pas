{$IfNDef vcmFormDataSourceWithFlexUseCaseControllerType_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmFormDataSourceWithFlexUseCaseControllerType.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmFormDataSourceWithFlexUseCaseControllerType
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmFormDataSourceWithFlexUseCaseControllerType_imp}
{$If not defined(NoVCM)}
 {$Include ..\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
 _vcmFormDataSourceWithData_Parent_ = _vcmFormDataSourcePrimWithFlexUseCaseControllerType_;
 {$Include ..\implementation\vcmFormDataSourceWithData.imp.pas}
 _vcmFormDataSourceWithFlexUseCaseControllerType_ = {mixin} class(_vcmFormDataSourceWithData_)
 end;//_vcmFormDataSourceWithFlexUseCaseControllerType_
{$Else}

 {$Include ..\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
 _vcmFormDataSourceWithData_Parent_ = _vcmFormDataSourcePrimWithFlexUseCaseControllerType_;
 {$Include ..\implementation\vcmFormDataSourceWithData.imp.pas}
 _vcmFormDataSourceWithFlexUseCaseControllerType_ = _vcmFormDataSourceWithData_;

{$IfEnd} //not NoVCM

{$Else vcmFormDataSourceWithFlexUseCaseControllerType_imp}

{$If not defined(NoVCM)}


{$Include ..\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}

{$Include ..\implementation\vcmFormDataSourceWithData.imp.pas}


{$IfEnd} //not NoVCM

{$EndIf vcmFormDataSourceWithFlexUseCaseControllerType_imp}
