unit k2LeafTag;
 {* Базовый листьевой тег }

// Модуль: "w:\common\components\rtl\Garant\K2\k2LeafTag.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2NonAtomicTag
;

type
 Tk2LeafTag = {abstract} class(Tk2NonAtomicTag)
  {* Базовый листьевой тег }
 end;//Tk2LeafTag

implementation

uses
 l3ImplUses
;

end.
