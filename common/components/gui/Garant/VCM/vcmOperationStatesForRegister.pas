unit vcmOperationStatesForRegister;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmOperationStatesForRegister.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmOperationStatesForRegister" MUID: (578614D202D9)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , vcmExternalInterfaces
;

type
 PvcmOperationStateIndex = ^TvcmOperationStateIndex;

 PvcmOperationStateForRegister = ^TvcmOperationStateForRegister;

 TvcmOperationStateFlag = (
  vcm_osfUndefined
  , vcm_osfFalse
  , vcm_osfTrue
 );//TvcmOperationStateFlag

 TvcmOperationStateForRegister = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rStateName: AnsiString;
   rVar: PvcmOperationStateIndex;
   rHint: AnsiString;
   rCaption: AnsiString;
   rImageIndex: Integer;
   rEnabled: TvcmOperationStateFlag;
   rVisible: TvcmOperationStateFlag;
   rChecked: TvcmOperationStateFlag;
  public
   function EQ(const anOther: TvcmOperationStateForRegister): Boolean;
 end;//TvcmOperationStateForRegister

 _ItemType_ = TvcmOperationStateForRegister;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TvcmOperationStatesForRegister = class(_l3RecordListPrim_)
  public
   function AddState(const aState: TvcmOperationStateForRegister): PvcmOperationStateForRegister;
 end;//TvcmOperationStatesForRegister

function TvcmOperationStateForRegister_C(const aName: AnsiString;
 var theVar: TvcmOperationStateIndex): TvcmOperationStateForRegister;
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function TvcmOperationStateForRegister_C(const aName: AnsiString;
 var theVar: TvcmOperationStateIndex): TvcmOperationStateForRegister;
//#UC START# *578615FD02BA_578614F1007E_var*
//#UC END# *578615FD02BA_578614F1007E_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *578615FD02BA_578614F1007E_impl*
 Result.rStateName := aName;
 Result.rVar := @theVar;
 Result.rImageIndex := -1;
//#UC END# *578615FD02BA_578614F1007E_impl*
end;//TvcmOperationStateForRegister_C

function TvcmOperationStateForRegister.EQ(const anOther: TvcmOperationStateForRegister): Boolean;
//#UC START# *578616150058_578614F1007E_var*
//#UC END# *578616150058_578614F1007E_var*
begin
//#UC START# *578616150058_578614F1007E_impl*
 Result := (rStateName = anOther.rStateName); 
//#UC END# *578616150058_578614F1007E_impl*
end;//TvcmOperationStateForRegister.EQ

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_578614D202D9_var*
//#UC END# *47B07CF403D0_578614D202D9_var*
begin
//#UC START# *47B07CF403D0_578614D202D9_impl*
 Result := A.EQ(B);
//#UC END# *47B07CF403D0_578614D202D9_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_578614D202D9_var*
//#UC END# *47B2C42A0163_578614D202D9_var*
begin
//#UC START# *47B2C42A0163_578614D202D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_578614D202D9_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_578614D202D9_var*
//#UC END# *47B99D4503A2_578614D202D9_var*
begin
//#UC START# *47B99D4503A2_578614D202D9_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_578614D202D9_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmOperationStatesForRegister;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

function TvcmOperationStatesForRegister.AddState(const aState: TvcmOperationStateForRegister): PvcmOperationStateForRegister;
//#UC START# *57861CED02AE_578614D202D9_var*
var
 l_Index : Integer;
//#UC END# *57861CED02AE_578614D202D9_var*
begin
//#UC START# *57861CED02AE_578614D202D9_impl*
 l_Index := IndexOf(aState);
 if (l_Index < 0) then
  l_Index := Add(aState);
 Result := ItemSlot(l_Index); 
//#UC END# *57861CED02AE_578614D202D9_impl*
end;//TvcmOperationStatesForRegister.AddState
{$IfEnd} // NOT Defined(NoVCM)

end.
