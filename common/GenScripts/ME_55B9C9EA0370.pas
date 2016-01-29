unit evExpandedTextFilter;

interface

uses
 l3IntfUses
 , k2TagFilter
 , l3LongintList
 , l3Variant
;

type
 TevExpandedTextFilter = class(Tk2TagFilter)
  {* Фильтр "дорисовывающий" отступы для вложенных параграфов. }
 end;//TevExpandedTextFilter
 
implementation

uses
 l3ImplUses
 , Block_Const
 , evdStyles
 , k2Tags
 , Document_Const
 , SysUtils
;

end.
