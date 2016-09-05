unit msmModelLoadingThreadPrimList;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelLoadingThreadPrimList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelLoadingThreadPrimList" MUID: (57C6876700B1)

{$Include w:\common\components\msm.inc}

interface

{$If Defined(seThreadSafe)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmModelLoadingThreadPrim
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , SyncObjs
;

type
 _ItemType_ = TmsmModelLoadingThreadPrim;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 _seCriticalSectionHolder_Parent_ = _l3UncomparabeObjectRefList_;
 {$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}
 TmsmModelLoadingThreadPrimList = class(_seCriticalSectionHolder_)
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure BeforeRelease; override;
  public
   procedure Add(anItem: TmsmModelLoadingThreadPrim);
   procedure Remove(anItem: TmsmModelLoadingThreadPrim);
 end;//TmsmModelLoadingThreadPrimList
{$IfEnd} // Defined(seThreadSafe)

implementation

{$If Defined(seThreadSafe)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57C6876700B1impl_uses*
 //#UC END# *57C6876700B1impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57C6876700B1_var*
//#UC END# *47B2C42A0163_57C6876700B1_var*
begin
//#UC START# *47B2C42A0163_57C6876700B1_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57C6876700B1_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57C6876700B1_var*
//#UC END# *47B99D4503A2_57C6876700B1_var*
begin
//#UC START# *47B99D4503A2_57C6876700B1_impl*
 Assert(CI.rA^ <> nil);
 Assert(CI.rB^ <> nil);
 Result := PChar(CI.rA.WordToLoad) - PChar(CI.rB.WordToLoad);
//#UC END# *47B99D4503A2_57C6876700B1_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmModelLoadingThreadPrimList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$Include w:\common\components\rtl\Garant\ScriptEngine\seCriticalSectionHolder.imp.pas}

procedure TmsmModelLoadingThreadPrimList.Add(anItem: TmsmModelLoadingThreadPrim);
//#UC START# *57C695CA0194_57C6876700B1_var*
//#UC END# *57C695CA0194_57C6876700B1_var*
begin
//#UC START# *57C695CA0194_57C6876700B1_impl*
 Lock;
 try
  inherited Add(anItem);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57C695CA0194_57C6876700B1_impl*
end;//TmsmModelLoadingThreadPrimList.Add

procedure TmsmModelLoadingThreadPrimList.Remove(anItem: TmsmModelLoadingThreadPrim);
//#UC START# *57C695E001D4_57C6876700B1_var*
//#UC END# *57C695E001D4_57C6876700B1_var*
begin
//#UC START# *57C695E001D4_57C6876700B1_impl*
 Lock;
 try
  inherited Remove(anItem);
 finally
  Unlock;
 end;//try..finally
//#UC END# *57C695E001D4_57C6876700B1_impl*
end;//TmsmModelLoadingThreadPrimList.Remove

procedure TmsmModelLoadingThreadPrimList.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57C6876700B1_var*
//#UC END# *479731C50290_57C6876700B1_var*
begin
//#UC START# *479731C50290_57C6876700B1_impl*
 inherited;
//#UC END# *479731C50290_57C6876700B1_impl*
end;//TmsmModelLoadingThreadPrimList.Cleanup

procedure TmsmModelLoadingThreadPrimList.InitFields;
//#UC START# *47A042E100E2_57C6876700B1_var*
//#UC END# *47A042E100E2_57C6876700B1_var*
begin
//#UC START# *47A042E100E2_57C6876700B1_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_57C6876700B1_impl*
end;//TmsmModelLoadingThreadPrimList.InitFields

procedure TmsmModelLoadingThreadPrimList.BeforeRelease;
//#UC START# *49BFC98902FF_57C6876700B1_var*
var
 l_Index : Integer;
//#UC END# *49BFC98902FF_57C6876700B1_var*
begin
//#UC START# *49BFC98902FF_57C6876700B1_impl*
 inherited;
 for l_Index := 0 to Pred(Count) do
  Items[l_Index].Terminate;
//#UC END# *49BFC98902FF_57C6876700B1_impl*
end;//TmsmModelLoadingThreadPrimList.BeforeRelease
{$IfEnd} // Defined(seThreadSafe)

end.
