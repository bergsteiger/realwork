unit nevViewList;
 {* Список InevView. }

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevViewList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevViewList" MUID: (47E8FF3701E4)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InevView;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnevViewList = class(_l3InterfaceRefList_)
  {* Список InevView. }
 end;//TnevViewList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *47E8FF3701E4impl_uses*
 //#UC END# *47E8FF3701E4impl_uses*
;

type _Instance_R_ = TnevViewList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
