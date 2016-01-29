unit tfwInitedDictionariesList;

interface

uses
 l3IntfUses
 , tfwDictionaryExPrim
;

 {$Define l3Items_NoSort}
 
 {$Define l3Items_NoChanging}
 
type
 TtfwInitedDictionariesList = class(_tfwDictionaryList_)
 end;//TtfwInitedDictionariesList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
