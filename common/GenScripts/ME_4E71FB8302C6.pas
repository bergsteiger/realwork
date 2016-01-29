unit nevStringCache.imp;

interface

uses
 l3IntfUses
 , nevBase
 , l3CustomString
;

type
 // TevParaStringsRange
 
 TevParaStrings = array [TevParaStringsRange] of Tl3CustomString;
 
 _nevStringCache_ = class(_nevStringCacheHackBecauseMl3Uknown_, Ml3Unknown)
  function CheckS(i: Integer): Tl3CustomString;
 end;//_nevStringCache_
 
implementation

uses
 l3ImplUses
 , evParaString
 , SysUtils
;

end.
