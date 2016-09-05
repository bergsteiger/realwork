unit vcmFormSetRefList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormSetRefList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmFormSetRefList" MUID: (55E6A6BC0318)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
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
 _ItemType_ = IvcmFormSet;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TvcmFormSetRefList = class(_l3InterfacePtrList_)
 end;//TvcmFormSetRefList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *55E6A6BC0318impl_uses*
 //#UC END# *55E6A6BC0318impl_uses*
;

type _Instance_R_ = TvcmFormSetRefList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
