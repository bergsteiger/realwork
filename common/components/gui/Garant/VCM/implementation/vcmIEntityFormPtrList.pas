unit vcmIEntityFormPtrList;
 {* Список указателей на IvcmEntityForm }

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmIEntityFormPtrList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmIEntityFormPtrList" MUID: (4AC4B82802E1)

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
 _ItemType_ = IvcmEntityForm;
 _l3InterfacePtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
 TvcmIEntityFormPtrList = class(_l3InterfacePtrList_)
  {* Список указателей на IvcmEntityForm }
 end;//TvcmIEntityFormPtrList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *4AC4B82802E1impl_uses*
 //#UC END# *4AC4B82802E1impl_uses*
;

type _Instance_R_ = TvcmIEntityFormPtrList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
