unit vcmUserFriendlyControlList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmUserFriendlyControlList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmUserFriendlyControlList" MUID: (559E5F080019)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmUserControls
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = IvcmUserFriendlyControl;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TvcmUserFriendlyControlList = class(_l3InterfaceRefList_)
 end;//TvcmUserFriendlyControlList
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

type _Instance_R_ = TvcmUserFriendlyControlList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
