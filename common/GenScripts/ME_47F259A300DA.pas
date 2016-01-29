unit evNode;

interface

uses
 l3IntfUses
 , nevBase
 , l3Variant
 , l3NodesModelPart
 , l3TreeInterfaces
 , l3Tree_TLB
;

type
 TevCustomNode = class(_k2TagHolder_, Il3HandleNode)
  function Handle: Integer;
   {* идентификатор узла. }
  procedure Remove;
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
 end;//TevCustomNode
 
implementation

uses
 l3ImplUses
 , SysUtils
 , k2NullTagImpl
 , k2Tags
 , k2Base
 , k2InterfaceFactory
;

end.
