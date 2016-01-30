unit vcmCustOpsRepGroupList;

// Модуль: "w:\common\components\gui\Garant\VCM\View\TasksPanel\vcmCustOpsRepGroupList.pas"
// Стереотип: "SimpleClass"

{$Include sdoDefine.inc}

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
 {$Include l3InterfaceRefList.imp.pas}
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
;

type _Instance_R_ = TvcmCustOpsRepGroupList;

{$Include l3InterfaceRefList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
