unit vcmOperationsCollectionItemList;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Components\vcmOperationsCollectionItemList.pas"
// ���������: "SimpleClass"
// ������� ������: "TvcmOperationsCollectionItemList" MUID: (5603F69F0035)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmOperationsCollectionItem
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TvcmOperationsCollectionItem;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TvcmOperationsCollectionItemList = class(_l3ObjectPtrList_)
 end;//TvcmOperationsCollectionItemList
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

type _Instance_R_ = TvcmOperationsCollectionItemList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
