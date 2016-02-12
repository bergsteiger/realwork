unit dtFamilyInfoList;

// Модуль: "w:\common\components\rtl\Garant\DT\dtFamilyInfoList.pas"
// Стереотип: "SimpleClass"

{$Include DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , dtFamilyInfo
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TdtFamilyInfo;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TdtFamilyInfoList = class(_l3UncomparabeObjectRefList_)
 end;//TdtFamilyInfoList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_537F78F50118_var*
//#UC END# *47B2C42A0163_537F78F50118_var*
begin
//#UC START# *47B2C42A0163_537F78F50118_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_537F78F50118_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_537F78F50118_var*
//#UC END# *47B99D4503A2_537F78F50118_var*
begin
//#UC START# *47B99D4503A2_537F78F50118_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_537F78F50118_impl*
end;//CompareExistingItems

type _Instance_R_ = TdtFamilyInfoList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
