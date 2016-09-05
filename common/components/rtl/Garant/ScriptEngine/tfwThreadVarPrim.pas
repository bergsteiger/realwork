unit tfwThreadVarPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwThreadVarPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwThreadVarPrim" MUID: (57C4205F038D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , tfwTypeInfo
 , tfwScriptingInterfaces
;

type
 TtfwThreadVarRec = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rValue: TtfwStackValue;
   rWord: TtfwWord;
   rThreadID: Longword;
  public
   function Compare(const anOther: TtfwThreadVarRec): Integer;
 end;//TtfwThreadVarRec

 _ItemType_ = TtfwThreadVarRec;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TtfwThreadVarPrim = class(_l3RecordListPrim_)
 end;//TtfwThreadVarPrim

function TtfwThreadVarRec_C(aWord: TtfwWord;
 aThreadID: Longword): TtfwThreadVarRec;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57C4205F038Dimpl_uses*
 //#UC END# *57C4205F038Dimpl_uses*
;

function TtfwThreadVarRec_C(aWord: TtfwWord;
 aThreadID: Longword): TtfwThreadVarRec;
//#UC START# *57C41FC6012C_57C41EB1024E_var*
//#UC END# *57C41FC6012C_57C41EB1024E_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *57C41FC6012C_57C41EB1024E_impl*
 Result.rWord := aWord;
 Result.rThreadID := aThreadID;
//#UC END# *57C41FC6012C_57C41EB1024E_impl*
end;//TtfwThreadVarRec_C

function TtfwThreadVarRec.Compare(const anOther: TtfwThreadVarRec): Integer;
//#UC START# *57C41F090346_57C41EB1024E_var*
//#UC END# *57C41F090346_57C41EB1024E_var*
begin
//#UC START# *57C41F090346_57C41EB1024E_impl*
 if (Self.rThreadID > anOther.rThreadID) then
  Result := +1
 else
 if (Self.rThreadID < anOther.rThreadID) then
  Result := -1
 else
  Result := 0;
 if (Result = 0) then
 begin
  if PChar(Self.rWord) > PChar(anOther.rWord) then
   Result := +1
  else
  if PChar(Self.rWord) < PChar(anOther.rWord) then
   Result := -1
  else
   Result := 0;
 end;//Result = 0
//#UC END# *57C41F090346_57C41EB1024E_impl*
end;//TtfwThreadVarRec.Compare

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_57C4205F038D_var*
//#UC END# *47B07CF403D0_57C4205F038D_var*
begin
//#UC START# *47B07CF403D0_57C4205F038D_impl*
 Result := A.Compare(B) = 0;
//#UC END# *47B07CF403D0_57C4205F038D_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57C4205F038D_var*
//#UC END# *47B2C42A0163_57C4205F038D_var*
begin
//#UC START# *47B2C42A0163_57C4205F038D_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57C4205F038D_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57C4205F038D_var*
//#UC END# *47B99D4503A2_57C4205F038D_var*
begin
//#UC START# *47B99D4503A2_57C4205F038D_impl*
 Result := CI.rA.Compare(CI.rB^);
//#UC END# *47B99D4503A2_57C4205F038D_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwThreadVarPrim;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
