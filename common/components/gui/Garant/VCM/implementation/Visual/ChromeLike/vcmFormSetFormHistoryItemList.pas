unit vcmFormSetFormHistoryItemList;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetFormHistoryItemList.pas"
// ���������: "SimpleClass"
// ������� ������: "TvcmFormSetFormHistoryItemList" MUID: (55A4B4120061)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IvcmFormSetFormHistoryItem;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TvcmFormSetFormHistoryItemList = class(_l3InterfaceRefList_)
 end;//TvcmFormSetFormHistoryItemList
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *55A4B4120061impl_uses*
 //#UC END# *55A4B4120061impl_uses*
;

type _Instance_R_ = TvcmFormSetFormHistoryItemList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
