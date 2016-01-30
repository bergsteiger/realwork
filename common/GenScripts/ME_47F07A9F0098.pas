{$IfNDef dBaseDrugDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Drug\dBaseDrugDocument.imp.pas"
// Стереотип: "Impurity"

{$Define dBaseDrugDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include dBaseDocumentWithAttributes.imp.pas}
 _dBaseDrugDocument_ = class(_dBaseDocumentWithAttributes_, IdBaseDrugDocument)
  {* Данные описания препарата. }
  private
   f_dsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsDrugInternationalNameSynonimsRef }
   f_HasDrugInternationalNameSynonims: Tl3Bool;
    {* Поле для свойства HasDrugInternationalNameSynonims }
  protected
   function pm_GetdsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef;
   function pm_GetHasDrugInternationalNameSynonims: Tl3Bool;
   procedure pm_SetHasDrugInternationalNameSynonims(aValue: Tl3Bool);
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DoResetBooleans; override;
   procedure ClearFields; override;
 end;//_dBaseDrugDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include dBaseDocumentWithAttributes.imp.pas}
_dBaseDrugDocument_ = _dBaseDocumentWithAttributes_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dBaseDrugDocument_imp}

{$IfNDef dBaseDrugDocument_imp_impl}

{$Define dBaseDrugDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
type _Instance_R_ = _dBaseDrugDocument_;

{$Include dBaseDocumentWithAttributes.imp.pas}

function _dBaseDrugDocument_.pm_GetdsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef;
//#UC START# *64B8F5213895_47F07A9F0098get_var*
//#UC END# *64B8F5213895_47F07A9F0098get_var*
begin
//#UC START# *64B8F5213895_47F07A9F0098get_impl*
 !!! Needs to be implemented !!!
//#UC END# *64B8F5213895_47F07A9F0098get_impl*
end;//_dBaseDrugDocument_.pm_GetdsDrugInternationalNameSynonimsRef

function _dBaseDrugDocument_.pm_GetHasDrugInternationalNameSynonims: Tl3Bool;
//#UC START# *B07FE8A09521_47F07A9F0098get_var*
//#UC END# *B07FE8A09521_47F07A9F0098get_var*
begin
//#UC START# *B07FE8A09521_47F07A9F0098get_impl*
 !!! Needs to be implemented !!!
//#UC END# *B07FE8A09521_47F07A9F0098get_impl*
end;//_dBaseDrugDocument_.pm_GetHasDrugInternationalNameSynonims

procedure _dBaseDrugDocument_.pm_SetHasDrugInternationalNameSynonims(aValue: Tl3Bool);
//#UC START# *B07FE8A09521_47F07A9F0098set_var*
//#UC END# *B07FE8A09521_47F07A9F0098set_var*
begin
//#UC START# *B07FE8A09521_47F07A9F0098set_impl*
 !!! Needs to be implemented !!!
//#UC END# *B07FE8A09521_47F07A9F0098set_impl*
end;//_dBaseDrugDocument_.pm_SetHasDrugInternationalNameSynonims

{$If NOT Defined(NoVCM)}
procedure _dBaseDrugDocument_.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_47F07A9F0098_var*
//#UC END# *4B16B8CF0307_47F07A9F0098_var*
begin
//#UC START# *4B16B8CF0307_47F07A9F0098_impl*
 pm_GetDsDrugInternationalNameSynonimsRef.Assign(aData.dsDrugInternationalNameSynonimsRef);
 pm_GetDsAttributesRef.Assign(aData.dsAttributesRef);
 f_HasAttributes := aData.HasAttributes;
 f_HasDrugInternationalNameSynonims := aData.HasDrugInternationalNameSynonims;
 inherited;
//#UC END# *4B16B8CF0307_47F07A9F0098_impl*
end;//_dBaseDrugDocument_.AssignData
{$IfEnd} // NOT Defined(NoVCM)

procedure _dBaseDrugDocument_.DoResetBooleans;
//#UC START# *4B18134E01F8_47F07A9F0098_var*
//#UC END# *4B18134E01F8_47F07A9F0098_var*
begin
//#UC START# *4B18134E01F8_47F07A9F0098_impl*
 inherited;
 l3BoolReset(f_HasDrugInternationalNameSynonims);
//#UC END# *4B18134E01F8_47F07A9F0098_impl*
end;//_dBaseDrugDocument_.DoResetBooleans

procedure _dBaseDrugDocument_.ClearFields;
begin
 f_dsDrugInternationalNameSynonimsRef := nil;
 inherited;
end;//_dBaseDrugDocument_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dBaseDrugDocument_imp_impl}

{$EndIf dBaseDrugDocument_imp}

