unit evTextParaMultiSelectionBlock;

interface

uses
 l3IntfUses
 , evLeafParaMultiSelectionBlock
 , nevTools
 , nevBase
 , evdInterfaces
;

type
 TevTextParaMultiSelectionBlock = class(TevLeafParaMultiSelectionBlock, IevSelectionPairs)
  function PairsCount: Integer;
  function Pair: TevPair;
 end;//TevTextParaMultiSelectionBlock
 
implementation

uses
 l3ImplUses
 , evdSegmentsLayerJoiner
 , k2Tags
 , evTextParaPartFilter
 , l3Chars
 , l3String
 , l3CustomString
 , l3Types
 , l3_String
 , k2BaseTypes
 , l3Base
;

end.
