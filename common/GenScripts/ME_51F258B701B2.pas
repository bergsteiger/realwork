unit ddAutolinkArbitraryDocEntry;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ddAutolinkInterfaces
 , dt_Types
 , l3LongintList
;

type
 TddAutolinkArbitraryDocEntry = class(Tl3ProtoObject, IddAutolinkArbitraryDocEntry)
  procedure Create(aDocID: TDocID;
   aTypesList: Tl3LongintList);
  function Make(aDocID: TDocID;
   aTypesList: Tl3LongintList): IddAutolinkArbitraryDocEntry;
  function DocID: TDocID;
  function TypesList: Tl3LongintList;
 end;//TddAutolinkArbitraryDocEntry
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
