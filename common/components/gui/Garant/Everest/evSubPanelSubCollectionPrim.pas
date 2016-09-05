unit evSubPanelSubCollectionPrim;

// Модуль: "w:\common\components\gui\Garant\Everest\evSubPanelSubCollectionPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevSubPanelSubCollectionPrim" MUID: (4B87D2A7029B)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , evSubPanelSubArray
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TevSubPanelSubArray;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TevSubPanelSubCollectionPrim = {abstract} class(_l3UncomparabeObjectRefList_)
  private
   f_Owner: TWinControl;
  public
   constructor Create(anOwner: TWinControl); reintroduce;
  public
   property Owner: TWinControl
    read f_Owner;
 end;//TevSubPanelSubCollectionPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4B87D2A7029Bimpl_uses*
 //#UC END# *4B87D2A7029Bimpl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4B87D2A7029B_var*
//#UC END# *47B2C42A0163_4B87D2A7029B_var*
begin
//#UC START# *47B2C42A0163_4B87D2A7029B_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4B87D2A7029B_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4B87D2A7029B_var*
//#UC END# *47B99D4503A2_4B87D2A7029B_var*
begin
//#UC START# *47B99D4503A2_4B87D2A7029B_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA.Handle - CI.rB.Handle;
//#UC END# *47B99D4503A2_4B87D2A7029B_impl*
end;//CompareExistingItems

type _Instance_R_ = TevSubPanelSubCollectionPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

constructor TevSubPanelSubCollectionPrim.Create(anOwner: TWinControl);
//#UC START# *4B87ECA700CD_4B87D2A7029B_var*
//#UC END# *4B87ECA700CD_4B87D2A7029B_var*
begin
//#UC START# *4B87ECA700CD_4B87D2A7029B_impl*
 MakeSorted;
 f_Owner := anOwner;
//#UC END# *4B87ECA700CD_4B87D2A7029B_impl*
end;//TevSubPanelSubCollectionPrim.Create

end.
