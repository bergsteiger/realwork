unit evEmptyTableEliminator;

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , l3Variant
 , k2Base
;

type
 TevEmptyTableEliminator = class(TevdBufferedFilter)
  {* Фильтр, выкидывающий пустые таблицы }
 end;//TevEmptyTableEliminator
 
implementation

uses
 l3ImplUses
 , LeafPara_Const
 , Table_Const
 , SBS_Const
 , k2Facade
 , ParaList_Const
 , TableCell_Const
;

end.
