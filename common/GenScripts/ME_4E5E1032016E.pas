unit evTabStopsFilter;

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , l3Variant
 , k2Base
;

type
 TevTabStopsFilter = class(TevdBufferedFilter)
 end;//TevTabStopsFilter
 
implementation

uses
 l3ImplUses
 , TabStop_Const
 , TextPara_Const
 , k2Tags
 , l3Interfaces
 , TableCell_Const
 , Table_Const
 , l3String
;

end.
