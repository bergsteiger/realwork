unit evTableFilter;

interface

uses
 l3IntfUses
 , evdBufferedFilter
 , evdTypes
 , k2Base
 , l3Variant
;

type
 TevTableFilter = class(TevdCustomChildBufferedFilter)
  {* ������� �� �����-����������� �������� ���������. }
 end;//TevTableFilter
 
implementation

uses
 l3ImplUses
 , TableCell_Const
 , TableRow_Const
 , k2Tags
;

end.
