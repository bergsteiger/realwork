{$IfNDef vcmFormDataSourcePrim_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Морозов М.А.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmFormDataSourcePrim.imp.pas"
// Начат: 2005/07/29 10:44:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmFormDataSourcePrim
//
// Бизнес объект формы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmFormDataSourcePrim_imp}
{$If not defined(NoVCM)}
 _UseCaseControllerType_ = IvcmFormSetDataSource;
 {$Include ..\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas}
 _vcmFormDataSourcePrim_ = {mixin} class(_vcmFormDataSourcePrimWithFlexUseCaseControllerType_)
  {* Бизнес объект формы }
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
