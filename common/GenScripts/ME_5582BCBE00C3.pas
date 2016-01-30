{$IfNDef vcmIterator_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmIterator.imp.pas"
// Стереотип: "Impurity"

{$Define vcmIterator_imp}

{$If NOT Defined(NoVCM)}
 _vcmIterator_ = class(TvcmCacheableBase)
  private
   f_List: _ListType_;
   f_Index: Integer;
  protected
   function GetNext: _ItemType_;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aList: _ListType_); reintroduce;
 end;//_vcmIterator_

{$Else NOT Defined(NoVCM)}

_vcmIterator_ = TvcmCacheableBase;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmIterator_imp}

{$IfNDef vcmIterator_imp_impl}

{$Define vcmIterator_imp_impl}

{$If NOT Defined(NoVCM)}
function _vcmIterator_.GetNext: _ItemType_;
//#UC START# *5582BF2101BD_5582BCBE00C3_var*
//#UC END# *5582BF2101BD_5582BCBE00C3_var*
begin
//#UC START# *5582BF2101BD_5582BCBE00C3_impl*
 if (f_Index >= f_List.Count) then
  Result := nil
 else 
 begin
  Result := f_List[f_Index];
  Inc(f_Index);
 end;
//#UC END# *5582BF2101BD_5582BCBE00C3_impl*
end;//_vcmIterator_.GetNext

constructor _vcmIterator_.Create(const aList: _ListType_);
//#UC START# *5582C3550082_5582BCBE00C3_var*
//#UC END# *5582C3550082_5582BCBE00C3_var*
begin
//#UC START# *5582C3550082_5582BCBE00C3_impl*
 inherited Create;
 vcmSet(f_List, aList);
//#UC END# *5582C3550082_5582BCBE00C3_impl*
end;//_vcmIterator_.Create

procedure _vcmIterator_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5582BCBE00C3_var*
//#UC END# *479731C50290_5582BCBE00C3_var*
begin
//#UC START# *479731C50290_5582BCBE00C3_impl*
 f_Index := 0;
 vcmFree(f_List);
 inherited;
//#UC END# *479731C50290_5582BCBE00C3_impl*
end;//_vcmIterator_.Cleanup
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmIterator_imp_impl}

{$EndIf vcmIterator_imp}

