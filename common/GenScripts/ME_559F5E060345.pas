unit tfwDictionaryPtrList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwDictionaryExPrim
;

 {$Define l3Items_NoSort}
 
 {$Define l3Items_NoChanging}
 
type
 TtfwDictionaryPtrList = class(_l3ObjectPtrList_)
 end;//TtfwDictionaryPtrList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
