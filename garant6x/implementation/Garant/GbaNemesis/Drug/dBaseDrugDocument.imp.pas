{$IfNDef dBaseDrugDocument_imp}

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Drug\dBaseDrugDocument.imp.pas"
// ���������: "Impurity"
// ������� ������: "dBaseDrugDocument" MUID: (47F07A9F0098)
// ��� ����: "_dBaseDrugDocument_"

{$Define dBaseDrugDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
 _dBaseDrugDocument_ = class(_dBaseDocumentWithAttributes_, IdBaseDrugDocument)
  {* ������ �������� ���������. }
  private
   f_dsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef;
    {* ������ �� "������ ������ "�������� �� �������������� ��������"" }
   f_HasDrugInternationalNameSynonims: Tl3Bool;
    {* ���� �� "������ ������ "�������� �� �������������� ��������"" }
  protected
   function pm_GetDsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef;
   function pm_GetHasDrugInternationalNameSynonims: Tl3Bool;
   procedure pm_SetHasDrugInternationalNameSynonims(aValue: Tl3Bool);
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DoResetBooleans; override;
   procedure ClearFields; override;
 end;//_dBaseDrugDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
_dBaseDrugDocument_ = _dBaseDocumentWithAttributes_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dBaseDrugDocument_imp}

{$IfNDef dBaseDrugDocument_imp_impl}

{$Define dBaseDrugDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}

function _dBaseDrugDocument_.pm_GetDsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsDrugInternationalNameSynonimsRef);
end;//_dBaseDrugDocument_.pm_GetDsDrugInternationalNameSynonimsRef

function _dBaseDrugDocument_.pm_GetHasDrugInternationalNameSynonims: Tl3Bool;
begin
 Result := f_HasDrugInternationalNameSynonims;
end;//_dBaseDrugDocument_.pm_GetHasDrugInternationalNameSynonims

procedure _dBaseDrugDocument_.pm_SetHasDrugInternationalNameSynonims(aValue: Tl3Bool);
begin
 f_HasDrugInternationalNameSynonims := aValue;
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

