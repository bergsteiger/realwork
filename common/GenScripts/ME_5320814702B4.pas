unit k2ListTag;

interface

uses
 l3IntfUses
 , k2NonAtomicTag
;

type
 Tk2ListTag = class(Tk2NonAtomicTag)
  {* Базовый тег, содержащий список других тегов (нелистьевой) }
 end;//Tk2ListTag
 
implementation

uses
 l3ImplUses
;

end.
