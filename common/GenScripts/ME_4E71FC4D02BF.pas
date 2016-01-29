unit nevStringCache;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , nevBase
;

type
 TnevStringCache = class(Tl3CProtoObject, InevStringCache)
  procedure Create;
  function Make: InevStringCache;
 end;//TnevStringCache
 
implementation

uses
 l3ImplUses
 , evParaString
 , SysUtils
;

end.
