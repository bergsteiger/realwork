unit l3StringList1;

// Модуль: "w:\common\components\rtl\Garant\L3\l3StringList1.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3StringList1" MUID: (47B9CBAA037F)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3StringListPrim
 , l3Interfaces
 , l3Types
;

type
 _l3DelphiStringSearcher_Parent_ = Tl3StringListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3DelphiStringSearcher.imp.pas}
 Tl3StringList1 = class(_l3DelphiStringSearcher_)
 end;//Tl3StringList1

implementation

uses
 l3ImplUses
 , l3String
 , l3Variant
 , l3Memory
 //#UC START# *47B9CBAA037Fimpl_uses*
 //#UC END# *47B9CBAA037Fimpl_uses*
;

type _Instance_R_ = Tl3StringList1;

{$Include w:\common\components\rtl\Garant\L3\l3DelphiStringSearcher.imp.pas}

end.
