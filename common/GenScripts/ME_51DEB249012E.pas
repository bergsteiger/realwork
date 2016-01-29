unit IntegerList;

interface

uses
 l3IntfUses
;

type
 TIntegerList = class(_StandardAtomicList_)
  {* Список Integer'ов }
 end;//TIntegerList
 
implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

end.
