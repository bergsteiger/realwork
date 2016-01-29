unit eeVirtualNode;

interface

uses
 l3IntfUses
 , l3VirtualNode
 , eeInterfaces
 , l3Interfaces
;

type
 TeeVirtualNode = class(Tl3VirtualFlagsNode, IeeNode)
  function Text: Il3CString;
  function ID: Integer;
  function HasChild: Boolean;
  function ChildNode: IeeNode;
  function ParentNode: IeeNode;
  function NextNode: IeeNode;
  function PrevNode: IeeNode;
  function AllChildrenCount: Integer;
  function ThisChildrenCount: Integer;
  function InsertChild(const aNode: IeeNode): IeeNode;
  function InsertChildBefore(const aNextChild: IeeNode;
   const aChild: IeeNode): IeeNode;
  procedure Changing;
  procedure Changed;
  procedure Remove;
  procedure Delete;
  procedure RemoveChildren;
  function Move(aDirection: TeeDirection): Boolean;
  procedure RelocateChild(const aChild: IeeNode);
   {* перемещает указанного ребенка, руководствуясь критериями сортировки относительно других детей (в пределах одного уровня) }
  procedure SortChilds;
  function GetLevelForParent(const aParent: IeeNode): Integer;
   {* Рассчитывает уровень текущей ноды относительно заданного Paretnt'а }
  function Iterate(anAction: TeeNodeAction;
   anIterMode: Integer;
   const aFromNode: IeeNode): IeeNode;
   {* перебрать все дочерние узлы. IterMode см. imExpandOnly etc. }
  function IterateF(anAction: TeeNodeAction;
   anIterMode: Integer;
   const aFromNode: IeeNode): IeeNode;
   {* перебрать все дочерние узлы и освободить заглушку для Action }
  function IsSameNode(const aNode: IeeNode): Boolean;
 end;//TeeVirtualNode
 
implementation

uses
 l3ImplUses
 , eeNodeUtils
 , SysUtils
 , eeNode
;

end.
