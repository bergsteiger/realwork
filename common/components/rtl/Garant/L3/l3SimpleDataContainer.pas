unit l3SimpleDataContainer;

// Модуль: "w:\common\components\rtl\Garant\L3\l3SimpleDataContainer.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

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
;

{$Include w:\common\components\rtl\Garant\L3\l3DataContainer.imp.pas}

end.
