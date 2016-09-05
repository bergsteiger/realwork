unit vcmFormDataSourceList;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormDataSourceList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmFormDataSourceList" MUID: (55C097250034)

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
 _ItemType_ = IvcmFormDataSource;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TvcmFormDataSourceList = class(_l3InterfaceRefList_)
 end;//TvcmFormDataSourceList
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *55C097250034impl_uses*
 //#UC END# *55C097250034impl_uses*
;

type _Instance_R_ = TvcmFormDataSourceList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
