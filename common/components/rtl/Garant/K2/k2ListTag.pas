unit k2ListTag;
 {* Ѕазовый тег, содержащий список других тегов (нелистьевой) }

// ћодуль: "w:\common\components\rtl\Garant\K2\k2ListTag.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "Tk2ListTag" MUID: (5320814702B4)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2NonAtomicTag
;

type
 Tk2ListTag = {abstract} class(Tk2NonAtomicTag)
  {* Ѕазовый тег, содержащий список других тегов (нелистьевой) }
 end;//Tk2ListTag

implementation

uses
 l3ImplUses
;

end.
