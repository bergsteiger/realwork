unit tfwWordInfoListPrim;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwWordInfoListPrim.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwWordInfoListPrim" MUID: (559F8232010B)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwScriptingInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TtfwWordInfoF;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TtfwWordInfoListPrim = class(_l3UncomparabeObjectRefList_)
 end;//TtfwWordInfoListPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
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
//#UC START# *47B2C42A0163_559F8232010B_var*
//#UC END# *47B2C42A0163_559F8232010B_var*
begin
//#UC START# *47B2C42A0163_559F8232010B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_559F8232010B_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_559F8232010B_var*
//#UC END# *47B99D4503A2_559F8232010B_var*
begin
//#UC START# *47B99D4503A2_559F8232010B_impl*
 Result := CI.rA.Compare(CI.rB^);
//#UC END# *47B99D4503A2_559F8232010B_impl*
end;//CompareExistingItems

type _Instance_R_ = TtfwWordInfoListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(NoScripts)

end.
