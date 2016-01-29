unit pgRenumerator;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
;

type
 TpgRenumerator = class(Tl3ProtoObject)
  procedure Create(const aFactory: IdaTableQueryFactory);
  function ConvertToRealNumber(aImpID: TdaDocID): TdaDocID;
 end;//TpgRenumerator
 
implementation

uses
 l3ImplUses
 , daScheme
;

end.
