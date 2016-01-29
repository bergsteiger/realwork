unit l3ProtoObjectPtrList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3ProtoObject
;

type
 Tl3ProtoObjectPtrList = class(_l3ObjectPtrList_)
  {* Список УКАЗАТЕЛЕЙ на Tl3ProtoObject }
 end;//Tl3ProtoObjectPtrList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
