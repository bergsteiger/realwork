unit evUnicodeConvertFilter;

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3Variant
;

type
 TevUnicodeConvertFilter = class(Tk2TagFilter)
  {* Фильтр, преобразующий Unicode в кодировку по умолчанию. }
 end;//TevUnicodeConvertFilter
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
 , l3StringEx
 , l3Interfaces
;

end.
