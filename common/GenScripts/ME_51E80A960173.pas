unit IUnknownRefList;

interface

uses
 l3IntfUses
 , Refcounted
;

type
 TIUnknownRefList = class(TRefcounted)
  {* Список ССЫЛОК на IUnknown }
 end;//TIUnknownRefList
 
implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

end.
