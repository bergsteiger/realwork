unit k2ListTag;
 {* Базовый тег, содержащий список других тегов (нелистьевой) }

// Модуль: "w:\common\components\rtl\Garant\K2\k2ListTag.pas"
// Стереотип: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , k2NonAtomicTag
;

type
 Tk2ListTag = {abstract} class(Tk2NonAtomicTag)
  {* Базовый тег, содержащий список других тегов (нелистьевой) }
 end;//Tk2ListTag

implementation

uses
 l3ImplUses
;

end.
