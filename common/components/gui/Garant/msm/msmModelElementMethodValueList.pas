unit msmModelElementMethodValueList;

// Модуль: "w:\common\components\gui\Garant\msm\msmModelElementMethodValueList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmModelElementMethodValueList" MUID: (57B2E60E0244)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , tfwTypeInfo
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 TmsmModelElementMethodValue = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rWord: TtfwWord;
   rName: Il3CString;
   rValue: TtfwStackValue;
  public
   function Compare(const anOther: TmsmModelElementMethodValue): Integer;
 end;//TmsmModelElementMethodValue

 _ItemType_ = TmsmModelElementMethodValue;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TmsmModelElementMethodValueList = class(_l3RecordListPrim_)
  protected
   procedure InitFields; override;
 end;//TmsmModelElementMethodValueList

function TmsmModelElementMethodValue_C(aWord: TtfwWord;
 const aName: Il3CString): TmsmModelElementMethodValue;

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57B2E60E0244impl_uses*
 , l3String
 //#UC END# *57B2E60E0244impl_uses*
;

function TmsmModelElementMethodValue_C(aWord: TtfwWord;
 const aName: Il3CString): TmsmModelElementMethodValue;
//#UC START# *57B2E78200E3_57B2E68103BA_var*
//#UC END# *57B2E78200E3_57B2E68103BA_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57B2E78200E3_57B2E68103BA_impl*
 Result.rWord := aWord;
 Result.rName := aName;
//#UC END# *57B2E78200E3_57B2E68103BA_impl*
end;//TmsmModelElementMethodValue_C

function TmsmModelElementMethodValue.Compare(const anOther: TmsmModelElementMethodValue): Integer;
//#UC START# *57B2E73703A2_57B2E68103BA_var*
//#UC END# *57B2E73703A2_57B2E68103BA_var*
begin
//#UC START# *57B2E73703A2_57B2E68103BA_impl*
 if Integer(Self.rWord) > Integer(anOther.rWord) then
  Result := +1
 else
 if Integer(Self.rWord) < Integer(anOther.rWord) then
  Result := -1
 else
  Result := 0;
 if (Result = 0) then
  Result := l3Compare(l3PCharLen(Self.rName), l3PCharLen(anOther.rName));
//#UC END# *57B2E73703A2_57B2E68103BA_impl*
end;//TmsmModelElementMethodValue.Compare

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_57B2E60E0244_var*
//#UC END# *47B07CF403D0_57B2E60E0244_var*
begin
//#UC START# *47B07CF403D0_57B2E60E0244_impl*
 Result := (A.Compare(B) = 0);
//#UC END# *47B07CF403D0_57B2E60E0244_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57B2E60E0244_var*
//#UC END# *47B2C42A0163_57B2E60E0244_var*
begin
//#UC START# *47B2C42A0163_57B2E60E0244_impl*
 Assert(false);
//#UC END# *47B2C42A0163_57B2E60E0244_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57B2E60E0244_var*
//#UC END# *47B99D4503A2_57B2E60E0244_var*
begin
//#UC START# *47B99D4503A2_57B2E60E0244_impl*
 Result := CI.rA^.Compare(CI.rB^);
//#UC END# *47B99D4503A2_57B2E60E0244_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmModelElementMethodValueList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

procedure TmsmModelElementMethodValueList.InitFields;
//#UC START# *47A042E100E2_57B2E60E0244_var*
//#UC END# *47A042E100E2_57B2E60E0244_var*
begin
//#UC START# *47A042E100E2_57B2E60E0244_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_57B2E60E0244_impl*
end;//TmsmModelElementMethodValueList.InitFields

end.
