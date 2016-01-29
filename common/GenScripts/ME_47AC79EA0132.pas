unit l3Dict;

interface

uses
 l3IntfUses
 , l3DictionaryPrim
;

 {$Define l3Items_NeedsBeforeFreeItem}
 
 {$Undef l3Items_NoSort}
 
type
 Tl3Dictionary = class(Tl3DictionaryPrim)
  {* Словарь. Используется для преобразования строки в идентификатор и наоборот. Имеет два индекса сортировки }
 end;//Tl3Dictionary
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3String
;

end.
