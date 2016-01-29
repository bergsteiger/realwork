unit eeNode;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , eeInterfaces
 , l3TreeInterfaces
 , l3Interfaces
 , l3IID
;

type
 TeeNode = class(Tl3CacheableBase, IeeNode)
  procedure Create(const aNode: Il3SimpleNode);
  function Make(const aNode: Il3SimpleNode): IeeNode;
  function Text: Il3CString;
  function ID: Integer;
  function HasChild: Boolean;
  function IsFirst: Boolean;
  function IsLast: Boolean;
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
 end;//TeeNode
 
implementation

uses
 l3ImplUses
 , eeNodeUtils
 , SysUtils
 , l3Base
 , l3Tree_TLB
 , l3Types
 , l3String
 , l3Nodes
 , l3InterfacesMisc
;

end.
