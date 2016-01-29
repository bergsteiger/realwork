unit afwTypedIntegerValueMap;

interface

uses
 l3IntfUses
 , l3TypedIntegerValueMap
 , afwInterfaces
;

type
 TafwSimpleTypedIntegerValueMap = class(Tl3SimpleTypedIntegerValueMap, IafwStringsSource)
  procedure FillStrings(const aStrings: IafwStrings);
 end;//TafwSimpleTypedIntegerValueMap
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
