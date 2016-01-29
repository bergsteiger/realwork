{$IfNDef vcmFormDataSource_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmFormDataSource.imp.pas"
// Начат: 24.11.2008 18:42
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmFormDataSource
//
// Бизнес-объект формы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmFormDataSource_imp}
{$If not defined(NoVCM)}
 {$Include ..\implementation\vcmFormDataSourcePrim.imp.pas}
 _vcmFormDataSourceWithData_Parent_ = _vcmFormDataSourcePrim_;
 {$Include ..\implementation\vcmFormDataSourceWithData.imp.pas}
 _vcmFormDataSource_ = {mixin} class(_vcmFormDataSourceWithData_)
  {* Бизнес-объект формы }
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
