unit ncsServerFilesDelivererList;

// ������: "w:\common\components\rtl\Garant\cs\ncsServerFilesDelivererList.pas"
// ���������: "SimpleClass"
// ������� ������: "TncsServerFilesDelivererList" MUID: (5810A0FF0073)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsServerFilesDeliverer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TncsServerFilesDeliverer;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TncsServerFilesDelivererList = class(_l3UncomparabeObjectRefList_)
 end;//TncsServerFilesDelivererList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *5810A0FF0073impl_uses*
 //#UC END# *5810A0FF0073impl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_5810A0FF0073_var*
//#UC END# *47B2C42A0163_5810A0FF0073_var*
begin
//#UC START# *47B2C42A0163_5810A0FF0073_impl*
 Assert(False);
//#UC END# *47B2C42A0163_5810A0FF0073_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_5810A0FF0073_var*
//#UC END# *47B99D4503A2_5810A0FF0073_var*
begin
//#UC START# *47B99D4503A2_5810A0FF0073_impl*
 Assert(False);
 Result := 0;
//#UC END# *47B99D4503A2_5810A0FF0073_impl*
end;//CompareExistingItems

type _Instance_R_ = TncsServerFilesDelivererList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
