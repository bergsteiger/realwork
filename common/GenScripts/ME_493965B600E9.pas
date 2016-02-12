{$IfNDef dMedicFirmDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\dMedicFirmDocument.imp.pas"
// Стереотип: "Impurity"

{$Define dMedicFirmDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
 _dMedicFirmDocument_ = class(_dBaseDocumentWithAttributes_, IdMedicFirmDocument)
  private
   f_dsDrugListRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsDrugListRef }
  protected
   function pm_GetdsDrugListRef: IvcmFormDataSourceRef;
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
 end;//_dMedicFirmDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
_dMedicFirmDocument_ = _dBaseDocumentWithAttributes_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dMedicFirmDocument_imp}

{$IfNDef dMedicFirmDocument_imp_impl}

{$Define dMedicFirmDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}

function _dMedicFirmDocument_.pm_GetdsDrugListRef: IvcmFormDataSourceRef;
//#UC START# *9FEBA868EC20_493965B600E9get_var*
//#UC END# *9FEBA868EC20_493965B600E9get_var*
begin
//#UC START# *9FEBA868EC20_493965B600E9get_impl*
 !!! Needs to be implemented !!!
//#UC END# *9FEBA868EC20_493965B600E9get_impl*
end;//_dMedicFirmDocument_.pm_GetdsDrugListRef

{$If NOT Defined(NoVCM)}
procedure _dMedicFirmDocument_.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_493965B600E9_var*
//#UC END# *4B16B8CF0307_493965B600E9_var*
begin
//#UC START# *4B16B8CF0307_493965B600E9_impl*
 pm_GetDsDrugListRef.Assign(aData.dsDrugListRef);
 inherited;
//#UC END# *4B16B8CF0307_493965B600E9_impl*
end;//_dMedicFirmDocument_.AssignData
{$IfEnd} // NOT Defined(NoVCM)

procedure _dMedicFirmDocument_.ClearFields;
begin
 f_dsDrugListRef := nil;
 inherited;
end;//_dMedicFirmDocument_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dMedicFirmDocument_imp_impl}

{$EndIf dMedicFirmDocument_imp}

