unit CsClientInfoList;

// Модуль: "w:\common\components\rtl\Garant\cs\CsClientInfoList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TCsClientInfoList" MUID: (537F4CAB01B2)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , CsClientInfo
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TCsClientInfo;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TCsClientInfoList = class(_l3UncomparabeObjectRefList_)
 end;//TCsClientInfoList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *537F4CAB01B2impl_uses*
 //#UC END# *537F4CAB01B2impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_537F4CAB01B2_var*
//#UC END# *47B2C42A0163_537F4CAB01B2_var*
begin
//#UC START# *47B2C42A0163_537F4CAB01B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_537F4CAB01B2_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_537F4CAB01B2_var*
//#UC END# *47B99D4503A2_537F4CAB01B2_var*
begin
//#UC START# *47B99D4503A2_537F4CAB01B2_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_537F4CAB01B2_impl*
end;//CompareExistingItems

type _Instance_R_ = TCsClientInfoList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
