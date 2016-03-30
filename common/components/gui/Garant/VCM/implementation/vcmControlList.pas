unit vcmControlList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmControlList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmControlList" MUID: (55F5814303D8)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TControl;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
 TvcmControlList = class(_l3ObjectPtrList_)
 end;//TvcmControlList
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

type _Instance_R_ = TvcmControlList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectPtrList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
