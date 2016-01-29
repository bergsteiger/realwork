unit evRootContentsNode;

interface

uses
 l3IntfUses
 , evContentsNode
 , l3Base
 , l3TreeInterfaces
 , l3Interfaces
 , l3Types
;

type
 TevRootContentsNode = class(TevContentsNode)
  function Make: Il3SimpleRootNode;
  procedure DoTryGetChildren;
 end;//TevRootContentsNode
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
