unit l3IntegerToIntegerMap;

interface

uses
 l3IntfUses
;

type
 Tl3IntegerToIntegerMap = class(_l3Map_)
  function CompareKeys(const aA: _KeyType_;
   const aB: _KeyType_): Integer;
 end;//Tl3IntegerToIntegerMap
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
