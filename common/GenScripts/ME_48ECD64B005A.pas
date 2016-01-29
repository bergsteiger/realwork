unit evLeafParaMultiSelectionBlock;

interface

uses
 l3IntfUses
 , evMultiSelectionBlock
 , nevTools
 , l3Variant
 , nevRangeList
 , nevBase
 , evdInterfaces
;

type
 TevLeafParaMultiSelectionBlock = class(TevMultiSelectionBlock)
  procedure IterateX;
  function Make(aTagWrap: Tl3Variant;
   aBlocks: TnevRangeList): InevRange;
   {* список блоков выделения, д. б отсортирован по порядку следования параграфов, и по положению блока внутри параграфа }
 end;//TevLeafParaMultiSelectionBlock
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
