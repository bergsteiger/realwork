{$IfNDef dBaseDrugDocument_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Drug"
// Автор: Морозов М.А. 
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Drug/dBaseDrugDocument.imp.pas"
// Начат: 12.07.2006
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Встроенные продукты::Inpharm::Drug::DrugData::dBaseDrugDocument
//
// Данные описания препарата.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dBaseDrugDocument_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
 _dBaseDrugDocument_ = {mixin} class(_dBaseDocumentWithAttributes_, IdBaseDrugDocument)
  {* Данные описания препарата. }
 private
 // private fields
   f_dsDrugInternationalNameSynonimsRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsDrugInternationalNameSynonimsRef}
   f_HasDrugInternationalNameSynonims : Tl3Bool;
    {* Поле для свойства HasDrugInternationalNameSynonims}
 protected
 // realized methods
   function pm_GetDsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef;
   function pm_GetHasDrugInternationalNameSynonims: Tl3Bool;
   procedure pm_SetHasDrugInternationalNameSynonims(aValue: Tl3Bool);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} //not NoVCM
   procedure DoResetBooleans; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 end;//_dBaseDrugDocument_
{$Else}

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
 _dBaseDrugDocument_ = _dBaseDocumentWithAttributes_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dBaseDrugDocument_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}

// start class _dBaseDrugDocument_

function _dBaseDrugDocument_.pm_GetDsDrugInternationalNameSynonimsRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsDrugInternationalNameSynonimsRef);
end;//_dBaseDrugDocument_.pm_GetDsDrugInternationalNameSynonimsRef

function _dBaseDrugDocument_.pm_GetHasDrugInternationalNameSynonims: Tl3Bool;
 {-}
begin
 Result := f_HasDrugInternationalNameSynonims;
end;//_dBaseDrugDocument_.pm_GetHasDrugInternationalNameSynonims

procedure _dBaseDrugDocument_.pm_SetHasDrugInternationalNameSynonims(aValue: Tl3Bool);
 {-}
begin
 f_HasDrugInternationalNameSynonims := aValue;
end;//_dBaseDrugDocument_.pm_SetHasDrugInternationalNameSynonims

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

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
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsDrugInternationalNameSynonimsRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//_dBaseDrugDocument_.ClearFields

{$IfEnd} //not Admin AND not Monitorings

{$EndIf dBaseDrugDocument_imp}
