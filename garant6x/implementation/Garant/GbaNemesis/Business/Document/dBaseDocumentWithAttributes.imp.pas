{$IfNDef dBaseDocumentWithAttributes_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "dBaseDocumentWithAttributes" MUID: (47F085A9004C)
// Имя типа: "_dBaseDocumentWithAttributes_"

{$Define dBaseDocumentWithAttributes_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocument.imp.pas}
 _dBaseDocumentWithAttributes_ = class(_dBaseDocument_, IdBaseDocumentWithAttributes)
  {* Данные документа с атрибутами }
  private
   f_dsAttributesRef: IvcmFormDataSourceRef;
    {* Ссылка на "атрибуты документа" }
   f_HasAttributes: Tl3Bool;
    {* Есть ли "атрибуты документа" }
  protected
   procedure DoResetBooleans; virtual;
   procedure ResetBooleans;
    {* очистить логические поля }
   function pm_GetDsAttributesRef: IvcmFormDataSourceRef;
   function pm_GetHasAttributes: Tl3Bool;
   procedure pm_SetHasAttributes(aValue: Tl3Bool);
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
 end;//_dBaseDocumentWithAttributes_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocument.imp.pas}
_dBaseDocumentWithAttributes_ = _dBaseDocument_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dBaseDocumentWithAttributes_imp}

{$IfNDef dBaseDocumentWithAttributes_imp_impl}

{$Define dBaseDocumentWithAttributes_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocument.imp.pas}

procedure _dBaseDocumentWithAttributes_.DoResetBooleans;
//#UC START# *4B18134E01F8_47F085A9004C_var*
//#UC END# *4B18134E01F8_47F085A9004C_var*
begin
//#UC START# *4B18134E01F8_47F085A9004C_impl*
 l3BoolReset(f_HasAttributes);
//#UC END# *4B18134E01F8_47F085A9004C_impl*
end;//_dBaseDocumentWithAttributes_.DoResetBooleans

procedure _dBaseDocumentWithAttributes_.ResetBooleans;
 {* очистить логические поля }
//#UC START# *4939245D0171_47F085A9004C_var*
//#UC END# *4939245D0171_47F085A9004C_var*
begin
//#UC START# *4939245D0171_47F085A9004C_impl*
 DoResetBooleans;
//#UC END# *4939245D0171_47F085A9004C_impl*
end;//_dBaseDocumentWithAttributes_.ResetBooleans

function _dBaseDocumentWithAttributes_.pm_GetDsAttributesRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsAttributesRef);
end;//_dBaseDocumentWithAttributes_.pm_GetDsAttributesRef

function _dBaseDocumentWithAttributes_.pm_GetHasAttributes: Tl3Bool;
begin
 Result := f_HasAttributes;
end;//_dBaseDocumentWithAttributes_.pm_GetHasAttributes

procedure _dBaseDocumentWithAttributes_.pm_SetHasAttributes(aValue: Tl3Bool);
begin
 f_HasAttributes := aValue;
end;//_dBaseDocumentWithAttributes_.pm_SetHasAttributes

{$If NOT Defined(NoVCM)}
procedure _dBaseDocumentWithAttributes_.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_47F085A9004C_var*
//#UC END# *4B16B8CF0307_47F085A9004C_var*
begin
//#UC START# *4B16B8CF0307_47F085A9004C_impl*
 f_HasAttributes := aData.HasAttributes;
 pm_GetDsAttributesRef.Assign(aData.dsAttributesRef);
 inherited;
//#UC END# *4B16B8CF0307_47F085A9004C_impl*
end;//_dBaseDocumentWithAttributes_.AssignData
{$IfEnd} // NOT Defined(NoVCM)

procedure _dBaseDocumentWithAttributes_.ClearFields;
begin
 f_dsAttributesRef := nil;
 inherited;
end;//_dBaseDocumentWithAttributes_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dBaseDocumentWithAttributes_imp_impl}

{$EndIf dBaseDocumentWithAttributes_imp}

