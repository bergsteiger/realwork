unit l3Tree_TLB;

interface

uses
 l3IntfUses
 , l3TreeInterfaces
 , l3PureMixIns
 , l3Interfaces
 , SysUtils
;

type
 Il3Node = interface;
 
 Tl3NodeAction = function(const Intf: Il3Node): Boolean;
  {* ѕодитеративна€ функци€ дл€ перебора элементов дерева. ≈сли возвращает true, то процесс перебора узлов прекращаетс€. }
 
 Il3Node = interface(Il3SimpleNode)
  {* ”зел дерева. }
  function InsertChild(const aNode: Il3Node): Il3Node;
  function InsertChildBefore(const aNextChild: Il3Node;
   const aNode: Il3Node): Il3Node;
  function IsAcceptChild(const aChild: Il3Node): Boolean;
  function GetChildByNumber(aNum: Integer): Il3Node;
   {* получить дочерний узел по номеру. }
  function GetNodeByNumber(aNum: Integer): Il3Node;
   {* получить узел по номеру. 0 = Self, остальные дочерние, }
  function GetNumInParent(aOnlyOneLevel: Boolean): Integer;
   {* получить пор€дковый номер узла в родительском узле.
          aOnlyOneLevel - считаем только непосредственных "детей",
          без учета вложенных }
  procedure Notify(aOperation: Integer;
   const aNode: Il3Node);
   {* нотификаци€ об операции над узлом. anOperation см. ntNone etc. }
  procedure IncAllChildrenCount(aInc: Integer);
  procedure Remove;
   {* удалить узел из дерева. }
  function Move(aDirection: Tl3Direction): Boolean;
   {* переместить узел. }
  function Iterate(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
   {* перебрать все дочерние узлы. IterMode см. imExpandOnly etc. }
  function IterateF(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
   {* перебрать все дочерние узлы и освободить заглушку дл€ Action. }
  procedure ReleaseChilds;
   {* освободить дочерние узлы. }
  function CompareChild(const aChildrenNode1: Il3Node;
   const aChildrenNode2: Il3Node): Integer;
   {* сравнивает aChildrenNode1 и aChildrenNode2 (обычно Text), используетс€ при сортировке ветки дерева. }
  procedure SortChilds(const aChild: Il3Node);
   {* пересортировывает aChild относительно других Nodes на том же уровне,
         обычно в случае изменени€ Text,
          если aChild = nil пересортировывает всю ветку (один уровень). }
  procedure Sort;
   {* пересортировывает себ€ относительно других Nodes на том же уровне. }
  procedure Changed;
   {* нотификаци€ о завершении изменени€ состо€ни€ объекта. ƒл€ перекрыти€ и использовани€ в потомках. }
  procedure Changing;
   {* нотификаци€ о начале изменени€ состо€ни€ объекта. ƒл€ перекрыти€ и использовани€ в потомках. }
 end;//Il3Node
 
 Il3RootNode = interface(Il3Node)
  {*  орневой узел }
 end;//Il3RootNode
 
 Il3Tree = interface(Il3SimpleTree)
  {* ƒерево. }
  function GetFlagsByAbsIndex(aAbsIndex: Integer): Integer;
  procedure SetFlagsByAbsIndex(aAbsIndex: Integer;
   aValue: Integer);
  function GetNodeByAbsIndex(aAbsIndex: Integer): Il3Node;
  function GetAbsIndex(const aCurNode: Il3Node): Integer;
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode);
   {* нотификаци€ об операции над узлом. anOperation см. ntNone etc. }
  function ChangeExpand(const RNode: Il3Node;
   Mode: Tl3SetBitType;
   aForceMode: Boolean): Boolean;
  function TestFlagMask(const aNode: Il3Node;
   aFlagMask: Integer): Boolean; overload;
  function TestFlagMask(aAbsIndex: Integer;
   aFlagMask: Integer): Boolean; overload;
  procedure SetFlagMask(aAbsIndex: Integer;
   aFlagMask: Integer;
   aMode: Tl3SetBitType); overload;
  procedure SetFlagMask(const aRNode: Il3Node;
   aFlagMask: Integer;
   aMode: Tl3SetBitType); overload;
  function GetPrev(const aCurNode: Il3Node): Il3Node;
   {* возвращает узел, наход€щийс€ непосредственно перед указанным независимо от иерархии. }
  function IterateF(Action: Tl3NodeAction;
   IterMode: Integer;
   const aSubRootNode: Il3Node;
   const aFromNode: Il3Node): Il3Node;
   {* перебрать все узлы и освободить заглушку дл€ Action. }
  procedure SetRootAndCountView(const aNode: Il3RootNode;
   aCountView: Integer);
   {* <?>  андидат на удаление. }
  procedure SetAllFlag(aMode: Tl3SetBitType;
   aFlags: Integer);
  procedure PrintTreeList(const aFileName: TFileName;
   aWithNumber: Boolean;
   aIterMode: Integer;
   const aLevelIndent: AnsiString);
  function SearchByName(const aFirstNode: Il3Node;
   aNameStr: PAnsiChar;
   aIterMode: Integer): Il3Node;
  function FindNodeByParam(const Parent: Il3Node;
   Param: Integer;
   aIterMode: Integer): Il3Node;
  procedure ResetSelection;
  procedure LockSelModify;
  procedure UnLockSelModify;
  function GetNextSetFlag(const aCurNode: Il3Node;
   aFlag: Integer): Il3Node;
   {* //vvv }
  procedure ChangeName(const aNode: Il3Node;
   NewTitle: PAnsiChar);
   {* изменить название узла. }
  function InsertNode(const aParentNode: Il3Node;
   const aNode: Il3Node): Il3Node;
   {* вставить новый узел. }
  function InsertNodeBefore(const aNextNode: Il3Node;
   const aNode: Il3Node): Il3Node;
   {* вставить новый узел перед указанным. }
  procedure SetLevelSlash(const aSt: AnsiString);
  function IsSelect(const aNode: Il3Node): Boolean;
   {* €вл€етс€ ли узел отмеченным. }
  function IsChildSelect(const aNode: Il3Node): Boolean;
  procedure Clear;
  function MoveSelectedNodes(aDirection: Tl3Direction): Boolean;
   {* перместить выделенные узлы }
  function DeleteSelectedNodes: Boolean;
   {* ”далить выделенные узлы, }
  function GetNextSelect(const aCurNode: Il3Node): Il3Node;
  procedure ClearSelected;
 end;//Il3Tree
 
 Il3InternalNode = interface(Il3Node)
  {* ¬нутреннее представление узла дерева. ƒл€ записи соседей и детей. }
 end;//Il3InternalNode
 
 Il3TreeWithLockRebuild = interface
  procedure LockRebuild;
  procedure UnlockRebuild;
  function IsRebuildLocked: Boolean;
 end;//Il3TreeWithLockRebuild
 
 Il3TreeSource = interface
  {* »сточник структуры дерева. }
 end;//Il3TreeSource
 
implementation

uses
 l3ImplUses
;

end.
