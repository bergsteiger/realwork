unit ncsExecutorFactoryList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsMessageInterfaces
;

type
 TncsExecutorFactoryList = class(Tl3ProtoDataContainer)
 end;//TncsExecutorFactoryList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
