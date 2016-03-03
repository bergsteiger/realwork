unit evHugeParaListPrimWithFind;

// Модуль: "w:\common\components\rtl\Garant\K2\evHugeParaListPrimWithFind.pas"
// Стереотип: "SimpleClass"

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
;

type _Instance_R_ = TevHugeParaListPrimWithFind;

{$Include w:\common\components\rtl\Garant\K2\k2TagByIntegerSearcher.imp.pas}

end.
