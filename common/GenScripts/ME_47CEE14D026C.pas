unit evReqList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , evQueryCardInt
;

type
 TevReqList = class(_l3InterfaceRefList_)
 end;//TevReqList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
