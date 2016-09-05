unit l3SimpleNodeList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3SimpleNodeList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3SimpleNodeList" MUID: (47E7B92D013D)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3TreeInterfaces
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Il3SimpleNode;
 _l3InterfaceRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 Tl3SimpleNodeList = class(_l3InterfaceRefList_)
 end;//Tl3SimpleNodeList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *47E7B92D013Dimpl_uses*
 //#UC END# *47E7B92D013Dimpl_uses*
;

type _Instance_R_ = Tl3SimpleNodeList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

end.
