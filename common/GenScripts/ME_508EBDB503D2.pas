unit nscTasksPanelRootNode;

interface

uses
 l3IntfUses
 , l3NodesModelPart
 , l3TreeInterfaces
 , l3Tree_TLB
;

type
 TnscTasksPanelRootNode = class(Tl3RootNode)
  function Make: Il3SimpleRootNode;
 end;//TnscTasksPanelRootNode
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , nscTaskPanelInterfaces
;

end.
