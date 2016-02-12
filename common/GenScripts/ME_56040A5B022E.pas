unit vcmEntitiesCollectionItemList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmEntitiesCollectionItemList.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmEntitiesCollectionItem
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TvcmEntitiesCollectionItem;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TvcmEntitiesCollectionItemList = class(_l3ObjectPtrList_)
 end;//TvcmEntitiesCollectionItemList
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

type _Instance_R_ = TvcmEntitiesCollectionItemList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
