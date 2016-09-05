unit evHugeParaListPrimWithFind;

// Модуль: "w:\common\components\rtl\Garant\K2\evHugeParaListPrimWithFind.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevHugeParaListPrimWithFind" MUID: (4A6062FE02AD)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , evHugeParaListPrim
 , l3Types
;

type
 _k2TagByIntegerSearcher_Parent_ = TevHugeParaListPrim;
 {$Include w:\common\components\rtl\Garant\K2\k2TagByIntegerSearcher.imp.pas}
 TevHugeParaListPrimWithFind = class(_k2TagByIntegerSearcher_)
 end;//TevHugeParaListPrimWithFind

implementation

uses
 l3ImplUses
 , l3Variant
 , l3Memory
 //#UC START# *4A6062FE02ADimpl_uses*
 //#UC END# *4A6062FE02ADimpl_uses*
;

type _Instance_R_ = TevHugeParaListPrimWithFind;

{$Include w:\common\components\rtl\Garant\K2\k2TagByIntegerSearcher.imp.pas}

end.
