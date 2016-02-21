unit csNotifyObjList;

// ������: "w:\common\components\rtl\Garant\cs\csNotifyObjList.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , csNotifyObj
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TcsNotifyObj;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TcsNotifyObjList = class(_l3UncomparabeObjectRefList_)
 end;//TcsNotifyObjList
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

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_52FB99AB03B8_var*
//#UC END# *47B2C42A0163_52FB99AB03B8_var*
begin
//#UC START# *47B2C42A0163_52FB99AB03B8_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FB99AB03B8_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_52FB99AB03B8_var*
//#UC END# *47B99D4503A2_52FB99AB03B8_var*
begin
//#UC START# *47B99D4503A2_52FB99AB03B8_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_52FB99AB03B8_impl*
end;//CompareExistingItems

type _Instance_R_ = TcsNotifyObjList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
