unit l3VirtualNode;

interface

uses
 l3IntfUses
 , l3NodesModelPart
 , l3Tree_TLB
 , l3TreeInterfaces
;

type
 Tl3CustomVirtualNode = class(Tl3CustomNode)
  procedure Set__ChildNode(const aValue: Il3Node);
  function ChildNodeClass: Rl3CustomVirtualNode;
  function ParentNodeClass: Rl3CustomVirtualNode;
  procedure Set__ParentNode(const aValue: Il3Node);
  procedure Set__PrevNode(const aValue: Il3Node);
  procedure Set__NextNode(const aValue: Il3Node);
  procedure Remove; overload;
   {* удалить узел из дерева. }
  function AllChildrenCount: Integer;
   {* число дочерних элементов, включая все вложенные. }
  function NextNode: Il3Node;
   {* следующий узел того же уровня. }
  function PrevNode: Il3Node;
   {* предыдущий узел того же уровня. }
  function ParentNode: Il3Node;
   {* родительский узел. }
  function ChildNode: Il3Node;
   {* первый дочерний элемент. }
  function DoGetIndexInParent: Integer;
  function Get__ParentNode: Il3Node;
  function Get__ChildNode: Il3Node;
  function Get__NextNode: Il3Node;
  function Get__PrevNode: Il3Node;
  function GetLevelForParent(const aNode: Il3SimpleNode): Integer;
  function Flag: Boolean;
  function IsFirstNode: Boolean;
  function IsLastNode: Boolean;
  procedure Remove; overload;
  function IterateChild(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
  function DoGetNumInParent(aOnlyOneLevel: Boolean): Integer;
  procedure DoReleaseChilds;
  procedure ReleaseChildsPrim;
  procedure DoIncAllChildrenCount(aInc: Integer);
  function DoGetChildByNumber(aNum: Integer): Il3Node;
  function DoIterate(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
  function DoInsertChildBefore(const aNextChild: Il3Node;
   const aChild: Il3Node): Il3Node;
 end;//Tl3CustomVirtualNode
 
 Rl3CustomVirtualNode = class of Tl3CustomVirtualNode;
 
 Tl3VirtualFlagsNode = class(Tl3CustomVirtualNode)
  procedure Set__ParentNode(const aValue: Il3Node);
  procedure Set__PrevNode(const aValue: Il3Node);
  procedure Set__NextNode(const aValue: Il3Node);
 end;//Tl3VirtualFlagsNode
 
implementation

uses
 l3ImplUses
;

end.
