unit l3LongintList;
 {* Список целых чисел }

// Модуль: "w:\common\components\rtl\Garant\L3\l3LongintList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3LongintList" MUID: (47BB29D40117)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3LongintListPrim
;

type
 _ListType_ = Tl3LongintListPrim;
 _l3ListOperations_Parent_ = Tl3LongintListPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3ListOperations.imp.pas}
 Tl3LongintList = class(_l3ListOperations_)
  {* Список целых чисел }
 end;//Tl3LongintList

implementation

uses
 l3ImplUses
 , l3Memory
 //#UC START# *47BB29D40117impl_uses*
 //#UC END# *47BB29D40117impl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\l3ListOperations.imp.pas}

end.
