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
   {* ����� �� ����� �������� ����? }
  function GetIsDisappeared: Boolean;
   {* True ���� ��������� �� ��������� ����, ����������� � ����������� ����� - ���������� �� ������. }
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
   {* ��� ������ ���� ������ ��������? }
  function IsLast: Boolean;
   {* ��� ��������� ���� ������ ��������? }
  function HasChild: Boolean;
   {* ���� �� �������� ����? }
  function MaybeChild: Boolean;
   {* ����� �� ����� �������� ����? }
  function GetLevel: Integer;
  function GetLevelFor(const aNode: Il3SimpleNode): Integer;
  function IsSame(const aNode: Il3SimpleNode): Boolean;
   {* ���������� ����. }
  function IsDisappeared: Boolean;
   {* True ���� ��������� �� ��������� ����,
             ����������� � ����������� ����� - ���������� �� ������. }
  procedure BeginMove(var aUserParam: Pointer);
   {* ������ ����������� ����. }
  procedure EndMove(aUserParam: Pointer);
   {* ��������� ����������� ����. }
  procedure Delete;
   {* ������� ���� �� ������, � ��� ������ � ����������� �������� (�������� �� ��) ��� ��������� �������. }
  function Text: Tl3PCharLenPrim;
   {* ����� ����. }
  function Parent: Il3SimpleNode;
   {* ������������ ����. }
  function Child: Il3SimpleNode;
   {* ������ �������� �������. }
  function Next: Il3SimpleNode;
   {* ��������� �����. }
  function Flag: Boolean;
  function Flags: Integer;
  function ThisChildrenCount: Integer;
   {* ����� �������� ���������, ��� ����� ���� ���������. }
  function IndexInParent: Integer;
   {* ������ ���� � ������������. }
  function CanExpandCollapseAll: Boolean;
  procedure ExpandCollapseAll(anExpand: Boolean);
  function CanAcceptData(const aData: Tl3TreeData): Boolean;
   {* ����� �� ���� ������� ������ }
  function DropData(const aData: Tl3TreeData): Boolean;
   {* ������� ������ }
  function CanMove: Boolean;
   {* ���������� ����������� ����������� ���� }
  function Prev: Il3SimpleNode;
   {* ���������� �����. }
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
   {* �������� �������� ���� �� ������. }
  function GetNodeByNumber(aNum: Integer): Il3Node;
   {* �������� ���� �� ������. 0 = Self, ��������� ��������, }
  function GetNumInParent(aOnlyOneLevel: Boolean): Integer;
   {* �������� ���������� ����� ���� � ������������ ����.
          aOnlyOneLevel - ������� ������ ���������������� "�����",
          ��� ����� ��������� }
  procedure Notify(aOperation: Integer;
   const aNode: Il3Node);
   {* ����������� �� �������� ��� �����. anOperation ��. ntNone etc. }
  procedure IncAllChildrenCount(aInc: Integer);
  function Move(aDirection: Tl3Direction): Boolean;
   {* ����������� ����. }
  function Iterate(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
   {* ��������� ��� �������� ����. IterMode ��. imExpandOnly etc. }
  function IterateF(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
   {* ��������� ��� �������� ���� � ���������� �������� ��� Action. }
  procedure ReleaseChilds;
   {* ���������� �������� ����. }
  function CompareChild(const aChildrenNode1: Il3Node;
   const aChildrenNode2: Il3Node): Integer;
   {* ���������� aChildrenNode1 � aChildrenNode2 (������ Text), ������������ ��� ���������� ����� ������. }
  procedure SortChilds(const aChild: Il3Node);
   {* ����������������� aChild ������������ ������ Nodes �� ��� �� ������,
         ������ � ������ ��������� Text,
          ���� aChild = nil ����������������� ��� ����� (���� �������). }
  procedure Sort;
   {* ����������������� ���� ������������ ������ Nodes �� ��� �� ������. }
  function Text: Tl3PCharLenPrim;
   {* ����� ����. }
  function ChildSorted: Boolean;
   {* ����� �� ����������� ChildNode. }
  function ChildSortedFromParent: Boolean;
   {* ���������� ChildSorted � ParentNode. }
  function Flags: Integer;
   {* �����. }
  function GetSelf: Tl3CustomNode;
  function InheritFrom(aClassType: Tl3NodeClass): Boolean;
  function Get__AllChildrenCount: Integer;
  function DoGetThisChildrenCount: Integer;
  function HasChildNode: Boolean;
  function GetIsDisappeared: Boolean;
   {* True ���� ��������� �� ��������� ����, ����������� � ����������� ����� - ���������� �� ������. }
  procedure DoBeginMove(var theUserParam: Pointer);
  procedure DoEndMove(aUserParam: Pointer);
 end;//Tl3CustomNode
 
 Tl3Node = class(Tl3CustomNode, Il3ChangeNotifier, Il3RootNode)
  function IterateNoParent(Action: Tl3NodeAction;
   IterMode: Integer;
   const aFromNode: Il3Node): Il3Node;
  procedure Subscribe(const aRecipient: Il3Notify);
   {* �������� �� ���������. }
  procedure Unsubscribe(const aRecipient: Il3Notify);
   {* "�������" �� ���������. }
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
   {* ������������� ����. }
 end;//Tl3HandleNode
 
 Tl3UsualNode = class(Tl3HandleNode)
  function Handle: Integer;
 end;//Tl3UsualNode
 
 Tl3RootNode = Tl3UsualNode;
 
 Tl3ListItemNode = class;
 
 Tl3CustomListContainerNode = class(Tl3UsualNode, Il3ChangeRecipient, Il3ItemNotifyRecipient)
  {* ������� ���� - ��������� ������� }
  function GetItemsCount: Integer;
  procedure DeleteChildItem(aIndex: Integer;
   const aDelete: Il3Node);
  procedure SubscribeChild(aChildNode: Tl3ListItemNode);
   {* �������� �� ��������� ���� - ������� ������ �������� ����� }
  procedure UnsubscribeChild(aChildNode: Tl3ListItemNode);
   {* "�������" �� ��������� ���� - ������� ������ �������� ����� }
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
   {* ������ ��������. }
 end;//Tl3CustomListContainerNode
 
 Tl3ListItemNode = class(Tl3CustomNode, Il3HandleNode, Il3NodeNotifyRecipient)
  function Handle: Integer;
   {* ������������� ����. }
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode);
   {* ������ ��������. }
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
