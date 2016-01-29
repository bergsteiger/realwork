unit IUnknownPtrList;

interface

uses
 l3IntfUses
 , Refcounted
;

type
 TIUnknownPtrList = class(TRefcounted)
  {* Список УКАЗАТЕЛЕЙ на IUnknown }
 end;//TIUnknownPtrList
 
implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

end.
