unit evContentsSubNode;

interface

uses
 l3IntfUses
 , evContentsTagNode
 , l3Variant
 , l3Tree_TLB
 , evInternalInterfaces
 , l3Interfaces
 , l3IID
;

type
 TevContentsSubNode = class(TevContentsTagNode)
  procedure Create(aTag: Tl3Variant;
   aSub: Tl3Variant;
   const aFilter: InevContentsNodeFilter);
  function Make(aTag: Tl3Variant;
   aSub: Tl3Variant;
   const aFilter: InevContentsNodeFilter): Il3Node;
 end;//TevContentsSubNode
 
implementation

uses
 l3ImplUses
 , l3Base
 , nevTools
 , Sub_Const
 , evDocumentPart
 , k2Tags
 , SysUtils
;

end.
