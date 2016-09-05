unit vcmCustOpsRepGroupList;

// Модуль: "w:\common\components\gui\Garant\VCM\View\TasksPanel\vcmCustOpsRepGroupList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmCustOpsRepGroupList" MUID: (559F8C7A0213)

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmTaskPanelInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IvcmCustOpsRepGroup;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TvcmCustOpsRepGroupList = class(_l3InterfaceRefList_)
 end;//TvcmCustOpsRepGroupList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *559F8C7A0213impl_uses*
 //#UC END# *559F8C7A0213impl_uses*
;

type _Instance_R_ = TvcmCustOpsRepGroupList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
