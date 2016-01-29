{$IfNDef dMedicFirmDocument_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/dMedicFirmDocument.imp.pas"
// Начат: 12.07.2006
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic::dMedicFirmDocument
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dMedicFirmDocument_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
 _dMedicFirmDocument_ = {mixin} class(_dBaseDocumentWithAttributes_, IdMedicFirmDocument)
 private
 // private fields
   f_dsDrugListRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsDrugListRef}
 protected
 // realized methods
   function pm_GetDsDrugListRef: IvcmFormDataSourceRef;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 end;//_dMedicFirmDocument_
{$Else}

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
 _dMedicFirmDocument_ = _dBaseDocumentWithAttributes_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dMedicFirmDocument_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}

// start class _dMedicFirmDocument_

function _dMedicFirmDocument_.pm_GetDsDrugListRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsDrugListRef);
end;//_dMedicFirmDocument_.pm_GetDsDrugListRef

{$If not defined(NoVCM)}
procedure _dMedicFirmDocument_.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_493965B600E9_var*
//#UC END# *4B16B8CF0307_493965B600E9_var*
begin
//#UC START# *4B16B8CF0307_493965B600E9_impl*
 pm_GetDsDrugListRef.Assign(aData.dsDrugListRef);
 inherited;
//#UC END# *4B16B8CF0307_493965B600E9_impl*
end;//_dMedicFirmDocument_.AssignData
{$IfEnd} //not NoVCM

procedure _dMedicFirmDocument_.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsDrugListRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//_dMedicFirmDocument_.ClearFields

{$IfEnd} //not Admin AND not Monitorings

{$EndIf dMedicFirmDocument_imp}
