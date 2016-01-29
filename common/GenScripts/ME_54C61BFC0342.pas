unit l3NodesModelPart;

interface

uses
 l3IntfUses
 , SysUtils
 , l3CustomString
 , l3TreeInterfaces
 , l3Tree_TLB
 , l3Interfaces
 , l3LongintList
 , l3Base
 , l3IID
 , l3Types
 , Classes
 , l3DatLst
 , l3InternalInterfaces
;

type
 ESkipIterateChilds = class(Exception)
 end;//ESkipIterateChilds
 
 El3NodeExeption = class(Exception)
 end;//El3NodeExeption
 
 El3InsertDenied = class(El3NodeExeption)
 end;//El3InsertDenied
 
 Tl3PrimNode = class(Tl3CustomString, Il3SimpleNode, Il3SimpleRootNode, IUnknown)
  function DoGetIndexInParent: Integer;
  function Get__AllChildrenCount: Integer;
  function DoGetThisChildrenCount: Integer;
  function DoGetLevel: Integer;
  function GetIsSame(const aNode: Il3SimpleNode): Boolean;
  function Get__ParentNode: Il3Node;
  function Get__ChildNode: Il3Node;
  function Get__NextNode: Il3Node;
  function Get__PrevNode: Il3Node;
  function GetLevelForParent(const aNode: Il3SimpleNode): Integer;
  function IsFirstNode: Boolean;
  function IsLastNode: Boolean;
  function HasChildNode: Boolean;
  function GetMaybeChild: Boolean;
   {* может ли иметь дочерние узлы? }
  function GetIsDisappeared: Boolean;
   {* True если интерфейс на удаленную ноду, применяется в виртуальных нодах - указателях на данные. }
  procedure DoBeginMove(var theUserParam: Pointer);
  procedure DoEndMove(aUserParam: Pointer);
  procedure DoExpandCollapseAll(anExpand: Boolean);
  function GetCanExpandCollapseAll: Boolean;
  procedure DoDelete;
  procedure Remove;
  function GetCanAcceptData(const aData: Tl3TreeData): Boolean;
  function DoDropData(const aData: Tl3TreeData): Boolean;
  function GetCanMove: Boolean;
  function IsFirst: Boolean;
   {* это первый узел внутри родителя? }
  function IsLast: Boolean;
   {* это последний узел внутри родителя? }
  function HasChild: Boolean;
   {* есть ли дочерние узлы? }
  function MaybeChild: Boolean;
   {* может ли иметь дочерние узлы? }
  function GetLevel: Integer;
  function GetLevelFor(const aNode: Il3SimpleNode): Integer;
  function IsSame(const aNode: Il3SimpleNode): Boolean;
   {* сравнивает ноды. }
  function IsDisappeared: Boolean;
   {* True если интерфейс на удаленную ноду,
             применяется в виртуальных нодах - указателях на данные. }
  procedure BeginMove(var aUserParam: Pointer);
   {* начать перемещение узла. }
  procedure EndMove(aUserParam: Pointer);
   {* закончить перемещение узла. }
  procedure Delete;
   {* удалить узел из дерева, а его данные с постоянного носителя (например из БД) или связанные объекты. }
  function Text: Tl3PCharLenPrim;
   {* текст узла. }
  function Parent: Il3SimpleNode;
   {* родительский узел. }
  function Child: Il3SimpleNode;
   {* первый дочерний элемент. }
  function Next: Il3SimpleNode;
   {* Следующий сосед. }
  function Flag: Boolean;
  function Flags: Integer;
  function ThisChildrenCount: Integer;
   {* число дочерних элементов, БЕЗ детей всех вложенные. }
  function IndexInParent: Integer;
   {* индекс узла в родительском. }
  function CanExpandCollapseAll: Boolean;
  procedure ExpandCollapseAll(anExpand: Boolean);
  function CanAcceptData(const aData: Tl3TreeData): Boolean;
   {* может ли узел принять данные }
  function DropData(const aData: Tl3TreeData): Boolean;
   {* принять данные }
  function CanMove: Boolean;
   {* определяет возможность перемещения узла }
  function Prev: Il3SimpleNode;
   {* Предыдущий сосед. }
 end;//Tl3PrimNode
 
 Tl3CustomNode = class;
 
 Il3NodeWrap = interface(Il3Base)
  function GetSelf: Tl3CustomNode;
  function InheritFrom(aClassType: Tl3NodeClass): Boolean;
 end;//Il3NodeWrap
 
 Tl3CustomNode = class(Tl3PrimNode, Il3Node, Il3NodeWrap)
  function IterateChild(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
  function DoCompareChild(const aChildrenNode1: Il3Node;
   const aChildrenNode2: Il3Node): Integer;
  procedure DoSortChilds(const aChild: Il3Node);
  procedure DoSort;
  function DoGetNumInParent(aOnlyOneLevel: Boolean): Integer;
  procedure DoReleaseChilds;
  procedure ReleaseChildsPrim;
  procedure MovingStarted(var theUserParam: Pointer);
  procedure MovingStopped(aUserParam: Pointer);
  function DoMove(aDirection: Tl3Direction): Boolean;
  procedure DoIncAllChildrenCount(aInc: Integer);
  procedure DoNotify(aOperation: Integer;
   const aNode: Il3Node);
  function DoGetNodeByNumber(aNum: Integer): Il3Node;
  function DoGetChildByNumber(aNum: Integer): Il3Node;
  function DoIterate(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
  function DoInsertChildBefore(const aNextChild: Il3Node;
   const aChild: Il3Node): Il3Node;
  function GetIsAcceptChild(const aChild: Il3Node): Boolean;
  function InsertChild(const aNode: Il3Node): Il3Node;
  function InsertChildBefore(const aNextChild: Il3Node;
   const aNode: Il3Node): Il3Node;
  function IsAcceptChild(const aChild: Il3Node): Boolean;
  function GetChildByNumber(aNum: Integer): Il3Node;
   {* получить дочерний узел по номеру. }
  function GetNodeByNumber(aNum: Integer): Il3Node;
   {* получить узел по номеру. 0 = Self, остальные дочерние, }
  function GetNumInParent(aOnlyOneLevel: Boolean): Integer;
   {* получить порядковый номер узла в родительском узле.
          aOnlyOneLevel - считаем только непосредственных "детей",
          без учета вложенных }
  procedure Notify(aOperation: Integer;
   const aNode: Il3Node);
   {* нотификация об операции над узлом. anOperation см. ntNone etc. }
  procedure IncAllChildrenCount(aInc: Integer);
  function Move(aDirection: Tl3Direction): Boolean;
   {* переместить узел. }
  function Iterate(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
   {* перебрать все дочерние узлы. IterMode см. imExpandOnly etc. }
  function IterateF(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
   {* перебрать все дочерние узлы и освободить заглушку для Action. }
  procedure ReleaseChilds;
   {* освободить дочерние узлы. }
  function CompareChild(const aChildrenNode1: Il3Node;
   const aChildrenNode2: Il3Node): Integer;
   {* сравнивает aChildrenNode1 и aChildrenNode2 (обычно Text), используется при сортировке ветки дерева. }
  procedure SortChilds(const aChild: Il3Node);
   {* пересортировывает aChild относительно других Nodes на том же уровне,
         обычно в случае изменения Text,
          если aChild = nil пересортировывает всю ветку (один уровень). }
  procedure Sort;
   {* пересортировывает себя относительно других Nodes на том же уровне. }
  function Text: Tl3PCharLenPrim;
   {* текст узла. }
  function ChildSorted: Boolean;
   {* нужно ли сортировать ChildNode. }
  function ChildSortedFromParent: Boolean;
   {* спрашивать ChildSorted у ParentNode. }
  function Flags: Integer;
   {* Флаги. }
  function GetSelf: Tl3CustomNode;
  function InheritFrom(aClassType: Tl3NodeClass): Boolean;
  function Get__AllChildrenCount: Integer;
  function DoGetThisChildrenCount: Integer;
  function HasChildNode: Boolean;
  function GetIsDisappeared: Boolean;
   {* True если интерфейс на удаленную ноду, применяется в виртуальных нодах - указателях на данные. }
  procedure DoBeginMove(var theUserParam: Pointer);
  procedure DoEndMove(aUserParam: Pointer);
 end;//Tl3CustomNode
 
 Tl3Node = class(Tl3CustomNode, Il3ChangeNotifier, Il3RootNode)
  function IterateNoParent(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
  procedure Subscribe(const aRecipient: Il3Notify);
   {* подписка на извещения. }
  procedure Unsubscribe(const aRecipient: Il3Notify);
   {* "отписка" от извещений. }
  function DoGetIndexInParent: Integer;
  function Get__ParentNode: Il3Node;
  function Get__ChildNode: Il3Node;
  function Get__NextNode: Il3Node;
  function Get__PrevNode: Il3Node;
  function GetLevelForParent(const aNode: Il3SimpleNode): Integer;
  procedure Remove;
  function IterateChild(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
  function DoGetNumInParent(aOnlyOneLevel: Boolean): Integer;
  procedure DoReleaseChilds;
  procedure ReleaseChildsPrim;
  function DoGetChildByNumber(aNum: Integer): Il3Node;
  function DoIterate(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
  function DoInsertChildBefore(const aNextChild: Il3Node;
   const aChild: Il3Node): Il3Node;
 end;//Tl3Node
 
 Tl3NodeClass = class of Tl3Node;
 
 Tl3PlaceNode = class(Tl3Node)
  procedure Create;
  function Make: Il3Node;
  function Flag: Boolean;
  function IsFirstNode: Boolean;
  function IsLastNode: Boolean;
  procedure DoIncAllChildrenCount(aInc: Integer);
  function Next: Tl3Node;
  function Prev: Tl3Node;
  function Parent: Tl3Node;
  function Child: Tl3Node;
 end;//Tl3PlaceNode
 
 Tl3CacheableNode = class(Tl3PlaceNode)
  procedure Create(const anExternalNode: Il3SimpleNode);
  function Make(const anExternalNode: Il3SimpleNode): Il3Node;
 end;//Tl3CacheableNode
 
 Tl3HandleNode = class(Tl3PlaceNode, Il3HandleNode)
  function Handle: Integer;
   {* идентификатор узла. }
 end;//Tl3HandleNode
 
 Tl3UsualNode = class(Tl3HandleNode)
  function Handle: Integer;
 end;//Tl3UsualNode
 
 Tl3RootNode = Tl3UsualNode;
 
 Tl3ListItemNode = class;
 
 Tl3CustomListContainerNode = class(Tl3UsualNode, Il3ChangeRecipient, Il3ItemNotifyRecipient)
  {* Базовый узел - контейнер списков }
  function GetItemsCount: Integer;
  procedure DeleteChildItem(aIndex: Integer;
   const aDelete: Il3Node);
  procedure SubscribeChild(aChildNode: Tl3ListItemNode);
   {* подписка на извещения ноды - обертки вокруг элемента листа }
  procedure UnsubscribeChild(aChildNode: Tl3ListItemNode);
   {* "отписка" от извещений ноды - обертки вокруг элемента листа }
  function MakeChildNode: Tl3ListItemNode;
  procedure MoveChildItemPrim(aCurIndex: Integer;
   aNewIndex: Integer);
  function MoveChildItem(aChildNode: Tl3ListItemNode;
   aDirection: Tl3Direction): Boolean;
  procedure ItemNotify(const aNotifier: Il3ChangeNotifier;
   aOperation: Integer;
   aIndex: Integer);
  procedure Notify(const aNotifier: Il3ChangeNotifier;
   aOperation: Integer;
   aIndex: Integer);
   {* прошла операция. }
 end;//Tl3CustomListContainerNode
 
 Tl3ListItemNode = class(Tl3CustomNode, Il3HandleNode, Il3NodeNotifyRecipient)
  function Handle: Integer;
   {* идентификатор узла. }
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode);
   {* прошла операция. }
  function Get__ParentNode: Il3Node;
  function Get__ChildNode: Il3Node;
  function Get__NextNode: Il3Node;
  function Get__PrevNode: Il3Node;
  function GetLevelForParent(const aNode: Il3SimpleNode): Integer;
  function Flag: Boolean;
  function IsFirstNode: Boolean;
  function IsLastNode: Boolean;
  function DoGetNumInParent(aOnlyOneLevel: Boolean): Integer;
  function DoIterate(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
 end;//Tl3ListItemNode
 
 Tl3StrListItemNode = class(Tl3ListItemNode)
 end;//Tl3StrListItemNode
 
 Tl3ListContainerNode = class(Tl3CustomListContainerNode)
  procedure ListChanged(Sender: TObject);
  procedure ListChanging(Sender: TObject);
  function Strings: Tl3WString;
  function ItemParam: Integer;
  function ItemFlag: Integer;
  function GetItemsCount: Integer;
  function MakeChildNode: Tl3ListItemNode;
  procedure MoveChildItemPrim(aCurIndex: Integer;
   aNewIndex: Integer);
 end;//Tl3ListContainerNode
 
 Tl3DataListContainerNode = class(Tl3CustomListContainerNode)
  function Strings: Tl3WString;
  function ItemParam: Integer;
  function ItemFlag: Integer;
  function GetItemsCount: Integer;
  function MakeChildNode: Tl3ListItemNode;
  procedure MoveChildItemPrim(aCurIndex: Integer;
   aNewIndex: Integer);
 end;//Tl3DataListContainerNode
 
 Tl3IListContainerNode = class(Tl3CustomListContainerNode)
  procedure ListChanged(Sender: TObject);
  procedure ListChanging(Sender: TObject);
  function Strings: Tl3WString;
  function ItemParam: Integer;
  function ItemFlag: Integer;
  function GetItemsCount: Integer;
  function MakeChildNode: Tl3ListItemNode;
  procedure MoveChildItemPrim(aCurIndex: Integer;
   aNewIndex: Integer);
 end;//Tl3IListContainerNode
 
 Tl3DataListItemNode = class(Tl3ListItemNode)
 end;//Tl3DataListItemNode
 
 Tl3CustomUsualNode = Tl3Node;
 
implementation

uses
 l3ImplUses
 , l3Nodes
 , l3Chars
 , l3InterfacesMisc
 , l3String
 , l3Bits
;

end.
