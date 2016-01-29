unit l3NotifyPtrList;

interface

uses
 l3IntfUses
 , l3DataContainerWithoutIUnknownPrim
 , l3Interfaces
;

type
 Tl3NotifyPtrList = class(_l3InterfacePtrList_)
 end;//Tl3NotifyPtrList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
