unit ncsServerTransporterPtrList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsMessageInterfaces
;

type
 TncsServerTransporterPtrList = class(Tl3ProtoDataContainer)
 end;//TncsServerTransporterPtrList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
