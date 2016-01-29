unit daLongProcessSubscriberList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daInterfaces
 , daTypes
;

type
 TdaLongProcessSubscriberList = class(Tl3ProtoDataContainer)
  function LongProcessNotify(aState: TdaProcessState): Boolean;
 end;//TdaLongProcessSubscriberList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
