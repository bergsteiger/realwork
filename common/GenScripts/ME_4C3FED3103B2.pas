unit evOEMTableFlagFilter;

interface

uses
 l3IntfUses
 , k2TagFilter
 , k2Base
 , l3Variant
;

type
 TevOEMTableFlagFilter = class(Tk2TagFilter)
  {* Фильтр выставления флага выливать в псевдографику таблицам. }
 end;//TevOEMTableFlagFilter
 
implementation

uses
 l3ImplUses
 , Table_Const
 , k2Tags
;

end.
