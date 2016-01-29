unit evdEmptyRowFilter;

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , l3Variant
;

type
 TevdEmptyRowFilter = class(TevdBufferedFilter)
 end;//TevdEmptyRowFilter
 
implementation

uses
 l3ImplUses
 , evdTypes
 , k2Tags
 , TableRow_Const
 , Table_Const
 , TableCell_Const
;

end.
