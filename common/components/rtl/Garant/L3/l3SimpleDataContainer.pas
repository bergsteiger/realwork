unit l3SimpleDataContainer;

// Модуль: "w:\common\components\rtl\Garant\L3\l3SimpleDataContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3SimpleDataContainer" MUID: (47BC3A07027F)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3SimpleObject
;

type
 _l3DataContainer_Parent_ = Tl3SimpleObject;
 {$Include w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas}
 Tl3SimpleDataContainer = {abstract} class(_l3DataContainer_)
 end;//Tl3SimpleDataContainer

implementation

uses
 l3ImplUses
 //#UC START# *47BC3A07027Fimpl_uses*
 //#UC END# *47BC3A07027Fimpl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas}

end.
