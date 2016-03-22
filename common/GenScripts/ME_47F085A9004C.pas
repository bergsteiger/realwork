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
    {* Поле для свойства dsAttributesRef }
   f_HasAttributes: Tl3Bool;
    {* Поле для свойства HasAttributes }
  protected
   procedure DoResetBooleans; virtual;
   procedure ResetBooleans;
    {* очистить логические поля }
   function pm_GetdsAttributesRef: IvcmFormDataSourceRef;
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

function _dBaseDocumentWithAttributes_.pm_GetdsAttributesRef: IvcmFormDataSourceRef;
//#UC START# *958F281A6FD6_47F085A9004Cget_var*
//#UC END# *958F281A6FD6_47F085A9004Cget_var*
begin
//#UC START# *958F281A6FD6_47F085A9004Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *958F281A6FD6_47F085A9004Cget_impl*
end;//_dBaseDocumentWithAttributes_.pm_GetdsAttributesRef

function _dBaseDocumentWithAttributes_.pm_GetHasAttributes: Tl3Bool;
//#UC START# *E1561B99CC62_47F085A9004Cget_var*
//#UC END# *E1561B99CC62_47F085A9004Cget_var*
begin
//#UC START# *E1561B99CC62_47F085A9004Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *E1561B99CC62_47F085A9004Cget_impl*
end;//_dBaseDocumentWithAttributes_.pm_GetHasAttributes

procedure _dBaseDocumentWithAttributes_.pm_SetHasAttributes(aValue: Tl3Bool);
//#UC START# *E1561B99CC62_47F085A9004Cset_var*
//#UC END# *E1561B99CC62_47F085A9004Cset_var*
begin
//#UC START# *E1561B99CC62_47F085A9004Cset_impl*
 !!! Needs to be implemented !!!
//#UC END# *E1561B99CC62_47F085A9004Cset_impl*
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

