unit evUnblockEmptyParaFilter;

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , l3Variant
;

type
 TevUnblockEmptyParaFilter = class(TevdBufferedFilter)
  {* Фильтр ищет блоки с пустыми параграфами в самом начале и "вытаскивает" эти пустые параграфы наверх. См. [$228692043] }
 end;//TevUnblockEmptyParaFilter
 
implementation

uses
 l3ImplUses
 , l3String
 , k2Interfaces
 , k2Tags
 , Block_Const
 , LeafPara_Const
 , l3Base
;

end.
