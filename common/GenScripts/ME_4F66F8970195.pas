unit l3GetMessageListenersList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Interfaces
;

type
 Tl3GetMessageListenersList = class(_l3InterfacePtrList_)
 end;//Tl3GetMessageListenersList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
