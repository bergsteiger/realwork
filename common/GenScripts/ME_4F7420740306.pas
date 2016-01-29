unit l3MouseListenersList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Interfaces
;

type
 Tl3MouseListenersList = class(_l3InterfacePtrList_)
 end;//Tl3MouseListenersList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
