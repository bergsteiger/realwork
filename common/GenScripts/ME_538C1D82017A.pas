unit dd_lcHiddenTextExtractor;

interface

uses
 l3IntfUses
 , evdLeafParaFilter
 , l3Variant
 , k2TagGen
;

type
 Tdd_lcHiddenTextExtractor = class(TevdLeafParaFilter)
  procedure WriteToLog(const aText: AnsiString;
   IsSeg: Boolean);
 end;//Tdd_lcHiddenTextExtractor
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Base
 , evdTypes
 , PageBreak_Const
;

end.
