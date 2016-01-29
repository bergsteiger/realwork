unit l3MemorySizeUtilsPrim;

interface

uses
 l3IntfUses
;

type
 Tl3MemorySizeFunc = function(aPtr: Pointer): Integer;
  {* прототип функции для получения размера куска памяти }
 
implementation

uses
 l3ImplUses
 , l3MemorySizeUtils
;

end.
