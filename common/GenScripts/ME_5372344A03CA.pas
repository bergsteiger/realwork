unit l3ByteList;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
;

type
 Tl3ByteList = class(_l3AtomicList_)
 end;//Tl3ByteList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
