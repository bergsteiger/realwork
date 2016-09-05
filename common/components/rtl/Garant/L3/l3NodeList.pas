unit l3NodeList;
 {* Список узлов дерева. }

// Модуль: "w:\common\components\rtl\Garant\L3\l3NodeList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3NodeList" MUID: (47E2472B0064)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3Tree_TLB
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Il3Node;
 _l3InterfaceRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 Tl3NodeList = class(_l3InterfaceRefList_)
  {* Список узлов дерева. }
 end;//Tl3NodeList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *47E2472B0064impl_uses*
 //#UC END# *47E2472B0064impl_uses*
;

type _Instance_R_ = Tl3NodeList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
