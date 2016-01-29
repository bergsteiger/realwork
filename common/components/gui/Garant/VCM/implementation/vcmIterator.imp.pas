{$IfNDef vcmIterator_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmIterator.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmIterator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmIterator_imp}
{$If not defined(NoVCM)}
 _vcmIterator_ = {mixin} class(TvcmCacheableBase)
 private
 // private fields
   f_List : _ListType_;
   f_Index : Integer;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   function GetNext: _ItemType_;
 public
 // public methods
   constructor Create(const aList: _ListType_); reintroduce;
 end;//_vcmIterator_
{$Else}

 _vcmIterator_ = TvcmCacheableBase;

{$IfEnd} //not NoVCM

{$Else vcmIterator_imp}

{$If not defined(NoVCM)}

// start class _vcmIterator_

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
//#UC START# *479731C50290_5582BCBE00C3_var*
//#UC END# *479731C50290_5582BCBE00C3_var*
begin
//#UC START# *479731C50290_5582BCBE00C3_impl*
 f_Index := 0;
 vcmFree(f_List);
 inherited;
//#UC END# *479731C50290_5582BCBE00C3_impl*
end;//_vcmIterator_.Cleanup

{$IfEnd} //not NoVCM

{$EndIf vcmIterator_imp}
