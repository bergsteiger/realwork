unit l3CardinalList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

type
 Tl3CardinalList = class(_l3AtomicList_)
  {* Список, содержащий Cardinal }
 end;//Tl3CardinalList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
