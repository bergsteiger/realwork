{$IfNDef l3DictionaryPrimPrim_imp}

// Модуль: "w:\common\components\rtl\Garant\L3\l3DictionaryPrimPrim.imp.pas"
// Стереотип: "Impurity"

{$Define l3DictionaryPrimPrim_imp}

type
 // _StringType_

 _l3DelphiStringSearcherPrim_Parent_ = _l3DictionaryPrimPrim_Parent_;
 {$Include l3DelphiStringSearcherPrim.imp.pas}
 _l3DictionaryPrimPrim_ = {abstract} class(_l3DelphiStringSearcherPrim_)
  private
   f_Default: _StringType_;
    {* Поле для свойства Default }
  protected
   procedure pm_SetDefault(const aValue: _StringType_); virtual;
   function pm_GetDRByName(const aName: AnsiString): _StringType_; virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   property Default: _StringType_
    read f_Default
    write pm_SetDefault;
    {* Элемент по умолчанию }
   property DRByName[const aName: AnsiString]: _StringType_
    read pm_GetDRByName;
    {* Элемент по имени }
 end;//_l3DictionaryPrimPrim_

{$Else l3DictionaryPrimPrim_imp}

{$IfNDef l3DictionaryPrimPrim_imp_impl}

{$Define l3DictionaryPrimPrim_imp_impl}

type _Instance_R_ = _l3DictionaryPrimPrim_;

{$Include l3DelphiStringSearcherPrim.imp.pas}

procedure _l3DictionaryPrimPrim_.pm_SetDefault(const aValue: _StringType_);
//#UC START# *5314900300F1_53148D6A00AEset_var*
//#UC END# *5314900300F1_53148D6A00AEset_var*
begin
//#UC START# *5314900300F1_53148D6A00AEset_impl*
 if (f_Default <> aValue) then
 begin
  FreeSlot(f_Default);
  FillSlot(f_Default, aValue);
 end;//f_Default <> aValue
 //l3Set(f_Default, aValue);
//#UC END# *5314900300F1_53148D6A00AEset_impl*
end;//_l3DictionaryPrimPrim_.pm_SetDefault

function _l3DictionaryPrimPrim_.pm_GetDRByName(const aName: AnsiString): _StringType_;
//#UC START# *531490200099_53148D6A00AEget_var*
var
 i : Integer;
//#UC END# *531490200099_53148D6A00AEget_var*
begin
//#UC START# *531490200099_53148D6A00AEget_impl*
 if FindData(aName, i, SortIndex) then
  Result := Items[i]
 else
  Result := Default;
//#UC END# *531490200099_53148D6A00AEget_impl*
end;//_l3DictionaryPrimPrim_.pm_GetDRByName

procedure _l3DictionaryPrimPrim_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_53148D6A00AE_var*
//#UC END# *479731C50290_53148D6A00AE_var*
begin
//#UC START# *479731C50290_53148D6A00AE_impl*
 Default := nil;
 inherited;
//#UC END# *479731C50290_53148D6A00AE_impl*
end;//_l3DictionaryPrimPrim_.Cleanup

procedure _l3DictionaryPrimPrim_.InitFields;
//#UC START# *47A042E100E2_53148D6A00AE_var*
//#UC END# *47A042E100E2_53148D6A00AE_var*
begin
//#UC START# *47A042E100E2_53148D6A00AE_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_53148D6A00AE_impl*
end;//_l3DictionaryPrimPrim_.InitFields

{$EndIf l3DictionaryPrimPrim_imp_impl}

{$EndIf l3DictionaryPrimPrim_imp}

