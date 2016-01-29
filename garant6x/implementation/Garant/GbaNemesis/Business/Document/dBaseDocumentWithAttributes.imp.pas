{$IfNDef dBaseDocumentWithAttributes_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dBaseDocumentWithAttributes.imp.pas"
// Начат: 12.07.2006
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Core::Common::Business::BaseDocument::dBaseDocumentWithAttributes
//
// Данные документа с атрибутами
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dBaseDocumentWithAttributes_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include ..\Document\dBaseDocument.imp.pas}
 _dBaseDocumentWithAttributes_ = {mixin} class(_dBaseDocument_, IdBaseDocumentWithAttributes)
  {* Данные документа с атрибутами }
 private
 // private fields
   f_dsAttributesRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsAttributesRef}
   f_HasAttributes : Tl3Bool;
    {* Поле для свойства HasAttributes}
 protected
 // realized methods
   procedure ResetBooleans;
     {* очистить логические поля }
   function pm_GetDsAttributesRef: IvcmFormDataSourceRef;
   function pm_GetHasAttributes: Tl3Bool;
   procedure pm_SetHasAttributes(aValue: Tl3Bool);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 protected
 // protected methods
   procedure DoResetBooleans; virtual;
 end;//_dBaseDocumentWithAttributes_
{$Else}

 {$Include ..\Document\dBaseDocument.imp.pas}
 _dBaseDocumentWithAttributes_ = _dBaseDocument_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dBaseDocumentWithAttributes_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include ..\Document\dBaseDocument.imp.pas}

// start class _dBaseDocumentWithAttributes_

procedure _dBaseDocumentWithAttributes_.DoResetBooleans;
//#UC START# *4B18134E01F8_47F085A9004C_var*
//#UC END# *4B18134E01F8_47F085A9004C_var*
begin
//#UC START# *4B18134E01F8_47F085A9004C_impl*
 l3BoolReset(f_HasAttributes);
//#UC END# *4B18134E01F8_47F085A9004C_impl*
end;//_dBaseDocumentWithAttributes_.DoResetBooleans

procedure _dBaseDocumentWithAttributes_.ResetBooleans;
//#UC START# *4939245D0171_47F085A9004C_var*
//#UC END# *4939245D0171_47F085A9004C_var*
begin
//#UC START# *4939245D0171_47F085A9004C_impl*
 DoResetBooleans;
//#UC END# *4939245D0171_47F085A9004C_impl*
end;//_dBaseDocumentWithAttributes_.ResetBooleans

function _dBaseDocumentWithAttributes_.pm_GetDsAttributesRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsAttributesRef);
end;//_dBaseDocumentWithAttributes_.pm_GetDsAttributesRef

function _dBaseDocumentWithAttributes_.pm_GetHasAttributes: Tl3Bool;
 {-}
begin
 Result := f_HasAttributes;
end;//_dBaseDocumentWithAttributes_.pm_GetHasAttributes

procedure _dBaseDocumentWithAttributes_.pm_SetHasAttributes(aValue: Tl3Bool);
 {-}
begin
 f_HasAttributes := aValue;
end;//_dBaseDocumentWithAttributes_.pm_SetHasAttributes

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

procedure _dBaseDocumentWithAttributes_.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsAttributesRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//_dBaseDocumentWithAttributes_.ClearFields

{$IfEnd} //not Admin AND not Monitorings

{$EndIf dBaseDocumentWithAttributes_imp}
