unit ncsServerTransporterList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsMessageInterfaces
;

 {$Define l3Items_NoSort}
 
type
 TncsServerTransporterList = class(Tl3ProtoDataContainer)
 end;//TncsServerTransporterList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
