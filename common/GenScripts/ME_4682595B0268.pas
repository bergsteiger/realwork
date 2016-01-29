unit l3TreeInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 Il3Nodes = interface
  {* ��������� ����� }
 end;//Il3Nodes
 
 Il3NotifySource = interface(Il3ChangeNotifier)
  {* ������, ����������� ����������� �� ��������� ���������. }
 end;//Il3NotifySource
 
 Il3SimpleNode = interface;
 
 Tl3TreeData = record
  {* ������ � ������� � ������������ ������� }
 end;//Tl3TreeData
 
 Il3SimpleNode = interface
  {* ���� ������. }
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
  function CanAcceptData(const aData: Tl3TreeData): Boolean;
   {* ����� �� ���� ������� ������ }
  function DropData(const aData: Tl3TreeData): Boolean;
   {* ������� ������ }
  function CanMove: Boolean;
   {* ���������� ����������� ����������� ���� }
 end;//Il3SimpleNode
 
 Il3SimpleRootNode = interface(Il3SimpleNode)
  function CanExpandCollapseAll: Boolean;
  procedure ExpandCollapseAll(anExpand: Boolean);
 end;//Il3SimpleRootNode
 
 Tl3SimpleNodeAction = function(const Intf: Il3SimpleNode): Boolean;
  {* �������������� ������� ��� �������� ��������� ������. ���� ���������� true, �� ������� �������� ����� ������������. }
 
 Il3RootSource = interface(Il3NotifySource)
  {* �������� ����� ������. }
 end;//Il3RootSource
 
 Il3HandleNode = interface
  {* ���� ������ � ������������� ���������������. }
 end;//Il3HandleNode
 
 Il3TreeFilters = interface
  {* ������� ������� ������������� �� ������ }
  function SetContext(const aValue: Il3CString): Il3TreeFilters;
  function Clone: Il3TreeFilters;
 end;//Il3TreeFilters
 
 Il3ContextFilterParamsNotifier = interface
  {* ����������� � ��� ��� ��������� ����������. }
  procedure ParamsChanged;
 end;//Il3ContextFilterParamsNotifier
 
 Il3ContextFilterTarget = interface
  {* ��������� ��� �������� ��� �� �����. }
  function IsSameContext(const aContext: Il3CString;
   out DiffStart: Cardinal): Boolean;
 end;//Il3ContextFilterTarget
 
 Il3ContextFilterParamsNotifySource = interface
  {* �������� ����������� � ��� ��� ��������� ����������. }
  procedure Subscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
  procedure UnSubscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
 end;//Il3ContextFilterParamsNotifySource
 
 Il3Base = l3Interfaces.Il3Base;
  {* ������� ������. }
 
 Il3SimpleTree = interface(Il3RootSource)
  {* ������. }
  procedure CursorTop;
   {* ����������� ������ �� ������ ������� �������. }
  function GetIndex(const aNode: Il3SimpleNode;
   const aSubRootNode: Il3SimpleNode): Integer;
   {* ���������� ������� ������ aNode ������������ aSubRootNode ��� �����. }
  function GetLevel(const aNode: Il3SimpleNode): Integer;
   {* ���������� ������� ���� ������������ �����. }
  procedure SelectAllNodes(aMode: Tl3SetBitType);
   {* ��������/����������� ��� ����. }
  procedure SelectInterval(aFirstIndex: Integer;
   aLastIndex: Integer;
   aMode: Tl3SetBitType;
   aCleanOther: Boolean);
   {* ��������/����������� ���� �� ��������� ���������. }
  function ChangeExpand(const aNode: Il3SimpleNode;
   aMode: Tl3SetBitType;
   aForceMode: Boolean): Boolean;
   {* ������ ������������� ����. }
  procedure ExpandSubDir(const aNode: Il3SimpleNode;
   anExpand: Boolean;
   aDeepLevel: Byte);
   {* ����������/�������� ����. }
  procedure SetBranchFlag(const aParentNode: Il3SimpleNode;
   aMode: Tl3SetBitType;
   aFlagsMask: Integer;
   anIterMode: Integer);
   {* �����-�� ������������ ��������� � ExpandNode. }
  function CountViewItemsInSubDir(const aNode: Il3SimpleNode): Integer;
   {* �����-�� ������������ ��������� � ShowMoreChildrenOnScreen. }
  function IsRoot(const aNode: Il3SimpleNode): Boolean;
   {* �������� �� ���� �������� ��� ������. }
  function IsExpanded(const aNode: Il3SimpleNode): Boolean;
   {* ������� �� ����. }
  function IsFirstVis(const aNode: Il3SimpleNode): Boolean;
   {* �������� �� ���� ������ ������� � �����. }
  function IsLastVis(const aNode: Il3SimpleNode): Boolean;
   {* �������� �� ���� ��������� ������� � �����. }
  function HasVisibleChildren(const aNode: Il3SimpleNode): Boolean;
   {* ���� �� ������� ���� � aNode. }
  function GetLines(const aNode: Il3SimpleNode): Integer;
   {* ����� ��� ��������� ����� (���� �������� ����������). }
  function Wake: Boolean;
   {* ��������!!! ���� ������ ��������. }
  function MoveNode(const aNode: Il3SimpleNode;
   aDirection: Tl3Direction): Boolean;
   {* ����������� ����. }
  function SearchNameBegin(const aFirstNode: Il3SimpleNode;
   aSrchStr: PAnsiChar;
   aIterMode: Integer): Il3SimpleNode;
   {* �����-�� ������������ ��������� � CharToItem. }
  function SearchNameOccur(const aFirstNode: Il3SimpleNode;
   aSrchStr: PAnsiChar;
   aIterMode: Integer): Il3SimpleNode;
   {* �����-�� ������������ ��������� � SearchOccurStr,  ������� ������ ����� �� ������������. }
  function MakeNodeVisible(const aNode: Il3SimpleNode): Integer;
   {* �����-�� ������������ ��������� � CharToItem, ������ ��� ����������� ������� �� ����. }
  function GetPrev(const aNode: Il3SimpleNode): Il3SimpleNode;
   {* ���������� ����. �����-�� ������������ � CharToItem. }
  function SimpleIterateF(Action: Tl3SimpleNodeAction;
   IterMode: Integer;
   const aSubRootNode: Il3SimpleNode): Il3SimpleNode;
   {* ��������� ��� ���� � ���������� �������� ��� Action. IterMode: imCheckResult, imParentNeed }
  function IsChanging: Boolean;
   {* ������ ��������� � ���� ����������. }
  procedure Changing;
  procedure Changed;
  function MakeDataObject(const aNode: Il3SimpleNode;
   const aBitmap: IUnknown): IDataObject;
   {* ������� ������ ������ ������, ������������ ��� ����������� ��������� ������ � ������ ���������� }
  function CanAcceptData(const aTargetNode: Il3SimpleNode;
   const aData: Tl3TreeData): Boolean;
  function DropData(const aTargetNode: Il3SimpleNode;
   const aData: Tl3TreeData): Boolean;
 end;//Il3SimpleTree
 
 Il3RootSpy = interface(Il3Notify)
  {* ������, �������� �� ���������� �����. }
  procedure RootChanged(const anOldRoot: Il3SimpleRootNode;
   const aNewRoot: Il3SimpleRootNode);
 end;//Il3RootSpy
 
 Il3NodeNotifyRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������. }
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode);
   {* ������ ��������. }
 end;//Il3NodeNotifyRecipient
 
 Il3FilterableTree = interface
  {* ������ ������� ����������� �������. }
  function CloneFilters: Il3TreeFilters;
  function MakeFiltered(const aFilters: Il3TreeFilters;
   const aCurrentNode: Il3SimpleNode;
   out aSyncIndex: Integer {* ���� ��� �������������. ������ ���� ���� �
                                   ������������� ���, ����� ��������� �
                                   ��������� sync_index. };
   aAutoOpen: Boolean {* ���������� ���� � �������� �������������.
                                   ����, ����� ����� ������� ��������������,
                                   ����� ������������� ������������. };
   CalcPartialContext: Boolean {* �������� ��������� ������������ ����������� ������,
                                   ������� ��� ������ ������ }): Il3SimpleTree;
 end;//Il3FilterableTree
 
 Il3ContextFilterParams = interface
  {* ��������� � �������� ����� ������������� ����������� ������ }
  function WordPosition: Tl3WordPosition;
  function WordOrder: Tl3WordOrder;
  function TreeLevelDist: Tl3TreeLevelDist;
 end;//Il3ContextFilterParams
 
 Il3ContextFilterNotifier = interface
  {* ����������� �� ��������� ������������ ������� }
  procedure RequestReapply;
   {* ���������� ������������� ������. }
  procedure RequestClearAndTurnOff;
   {* ������ ��������� �� ���� ������. }
  procedure RequestCheckValid;
   {* ������ ���������� - ����� ��������� ���������� �������. }
 end;//Il3ContextFilterNotifier
 
 Il3ContextFilterNotifySource = interface
  {* �������� ����������� � ��� ��� ��������� ���������� }
  procedure SubscribeToContextFilter(const aSubscriber: Il3ContextFilterNotifier);
  procedure UnSubscribeFromContextFilter(const aSubscriber: Il3ContextFilterNotifier);
 end;//Il3ContextFilterNotifySource
 
 Il3ContextFilterTargetContainer = interface
  {* ��������� ��� ������������� }
  function Unfold: Il3ContextFilterTarget;
 end;//Il3ContextFilterTargetContainer
 
 Il3Wake = interface
  function Wake: Boolean;
 end;//Il3Wake
 
 Il3SimpleTreeSource = interface
 end;//Il3SimpleTreeSource
 
 Il3CountViewChangeRecipient = interface
  {* ��������� ��� ��������� ����������� �� ��������� ���������� ������� ���������. }
  procedure CountViewChanged(aCountView: Integer);
   {* ������ ��������. }
 end;//Il3CountViewChangeRecipient
 
 Il3SimpleInternalNode = interface
 end;//Il3SimpleInternalNode
 
 Pl3TreeData = ^Tl3TreeData;
  {* ��������� �� ������ � ������������ ������� }
 
 Il3ExpandedSimpleTree = interface(Il3SimpleTree)
  {* ������ � ����������� �����������������. }
  function FlagIterateF(Action: Tl3SimpleNodeAction;
   FlagMask: Word;
   IterMode: Integer;
   const aSubRootNode: Il3SimpleNode;
   aCheckResult: Boolean): Il3SimpleNode;
   {* ��������� ��� ����, ��������������� FlagMask, � ���������� �������� ��� Action. IterMode: imCheckResult, imParentNeed }
 end;//Il3ExpandedSimpleTree
 
 Il3ExtItemNode = interface
  {* ���� �� ���������� �������. � ����� �� �� � ���� ������? }
 end;//Il3ExtItemNode
 
implementation

uses
 l3ImplUses
;

end.
