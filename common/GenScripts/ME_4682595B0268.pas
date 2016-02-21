unit l3TreeInterfaces;
 {* ���������� ������. }

// ������: "w:\common\components\rtl\Garant\L3\l3TreeInterfaces.pas"
// ���������: "Interfaces"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
;

const
 imExpandOnly = $01;
  {* ���������� ������ �������� ���� }
 imCheckResult = $02;
  {* ��������� ���������, ������������ �������������� �������� (��. Tl3NodeAction) }
 imOneLevel = $04;
  {* ��������� ������ ���� ������� }
 imParentNeed = $08;
  {* �������� RootSubNode � ������ ������������ }
 imNoSubRoot = $10;
  {* RootSubNode - ����� ������, �� �� ������, ��� �� ������������ ���� ������������� �� ��� �� ������, ��� � RootSubNode � ���� ���� }
 imChildsBefore = $20;
  {* ��������� ��� �������� ���� ����� �� ���������, �.�. ���� ������������ ������ }
 imNoChilds = $40;
  {* �� ���������� �������� ����, ������������ �� ���������� ���������� }
 imNoHidden = $80;
  {* �� ���������� ���������, �������������� ������ ����������� Tl3Tree }
 imLeavesOnly = $100;
  {* ���������� ������ "���������" ���� (� ������� ��� �����) }
 {* TNode.Flags const }
 nfSelected = $0001;
  {* ���� ������� }
 nfSelModified = $0002;
  {* ��������� ���� �������� }
 nfChildSelected = $0004;
  {* � ���� ���� ���������� �������� ���� }
 nfExpanded = $0008;
  {* ���� ������� }
 nfReadOnly = $0010;
  {* ���� �� ��� �������������� }
 nfHidden = $0020;
  {* ���� �� ������������ }
 nfItemModified = $00010000;
  {* ���� ������������� }
 nfHasChild = $00020000;
  {* � ���� ���� �������� ���� }
 nfWasDisappear = $00040000;
  {* ���� ��� ������, cm. IsDisappeared }
 nfUserDefined2 = $20000000;
  {* ���� ��� ������������� "�������������". ����� ������������ ���������� ����������� }
 nfUserDefined1 = $40000000;
  {* ���� ��� ������������� "�������������". ����� ������������ ���������� ����������� }
 l3_NeedCountView = -1;
 l3_DelayedCountView = -2;
 l3_NotChangeCountView = -3;

type
 Il3Base = l3Interfaces.Il3Base;
  {* ������� ������. }

 Pl3TreeData = ^Tl3TreeData;
  {* ��������� �� ������ � ������������ ������� }

 Il3Nodes = interface(Il3Base)
  {* ��������� ����� }
  ['{4A85EA5F-CCB1-4250-A410-635227213794}']
 end;//Il3Nodes

 Il3NotifySource = interface(Il3ChangeNotifier)
  {* ������, ����������� ����������� �� ��������� ���������. }
  ['{714F2774-DCFE-4ACE-B48B-1EE8885A6170}']
 end;//Il3NotifySource

 Il3SimpleNode = interface;

 Tl3TreeData = record
  {* ������ � ������� � ������������ ������� }
  rMultiSelection: Boolean;
   {* ������� ���� ��� ����� }
  rNode: Il3SimpleNode;
   {* ��������� ����. }
  rNodes: Il3Nodes;
   {* ��������� ���� }
 end;//Tl3TreeData

 Il3SimpleNode = interface(Il3Base)
  {* ���� ������. }
  ['{EA766D65-F343-4EF0-913E-70F7ACEAD59D}']
  function Get_Flags: Integer;
  function Get_ThisChildrenCount: Integer;
  function pm_GetIndexInParent: Integer;
  function Get_Text: Tl3PCharLenPrim;
  function Get_Parent: Il3SimpleNode;
  function Get_Child: Il3SimpleNode;
  function Get_Next: Il3SimpleNode;
  function Get_Flag(anIndex: Integer): Boolean;
  procedure Set_Flag(anIndex: Integer;
   aValue: Boolean);
  function Get_Prev: Il3SimpleNode;
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
  property Flags: Integer
   read Get_Flags;
  property ThisChildrenCount: Integer
   read Get_ThisChildrenCount;
   {* ����� �������� ���������, ��� ����� ���� ���������. }
  property IndexInParent: Integer
   read pm_GetIndexInParent;
   {* ������ ���� � ������������. }
  property Text: Tl3PCharLenPrim
   read Get_Text;
   {* ����� ����. }
  property Parent: Il3SimpleNode
   read Get_Parent;
   {* ������������ ����. }
  property Child: Il3SimpleNode
   read Get_Child;
   {* ������ �������� �������. }
  property Next: Il3SimpleNode
   read Get_Next;
   {* ��������� �����. }
  property Flag[anIndex: Integer]: Boolean
   read Get_Flag
   write Set_Flag;
  property Prev: Il3SimpleNode
   read Get_Prev;
   {* ���������� �����. }
 end;//Il3SimpleNode

 Il3SimpleRootNode = interface(Il3SimpleNode)
  ['{C15542CB-D1E5-4FC7-8303-3A3CB315C46D}']
  function CanExpandCollapseAll: Boolean;
  procedure ExpandCollapseAll(anExpand: Boolean);
 end;//Il3SimpleRootNode

 Tl3SimpleNodeAction = function(const Intf: Il3SimpleNode): Boolean;
  {* �������������� ������� ��� �������� ��������� ������. ���� ���������� true, �� ������� �������� ����� ������������. }

 Il3RootSource = interface(Il3NotifySource)
  {* �������� ����� ������. }
  ['{5E3068EC-8647-4D64-B5AD-F85B3B91CF7D}']
  function Get_RootNode: Il3SimpleRootNode;
  procedure Set_RootNode(const aValue: Il3SimpleRootNode);
  property RootNode: Il3SimpleRootNode
   read Get_RootNode
   write Set_RootNode;
   {* ������ ������. }
 end;//Il3RootSource

 Il3HandleNode = interface(Il3Base)
  {* ���� ������ � ������������� ���������������. }
  ['{C581B66C-0E13-4B43-B8D0-3BCD989E28CA}']
  function Get_Handle: Integer;
  procedure Set_Handle(aValue: Integer);
  property Handle: Integer
   read Get_Handle
   write Set_Handle;
   {* ������������� ����. }
 end;//Il3HandleNode

 Il3TreeFilters = interface(Il3Base)
  {* ������� ������� ������������� �� ������ }
  ['{949D1B99-493A-463D-A028-EFB087BD61D4}']
  function pm_GetContext: Il3CString;
  function SetContext(const aValue: Il3CString): Il3TreeFilters;
  function Clone: Il3TreeFilters;
  property Context: Il3CString
   read pm_GetContext;
 end;//Il3TreeFilters

 Il3ContextFilterParamsNotifier = interface(Il3Base)
  {* ����������� � ��� ��� ��������� ����������. }
  ['{7CFF12FA-1670-4D53-A10B-64E0870D7B54}']
  procedure ParamsChanged;
 end;//Il3ContextFilterParamsNotifier

 Il3ContextFilterTarget = interface(Il3Base)
  {* ��������� ��� �������� ��� �� �����. }
  ['{3A5CC96E-BA9A-44A8-970A-24D6D90B2211}']
  function IsSameContext(const aContext: Il3CString;
   out DiffStart: Cardinal): Boolean;
 end;//Il3ContextFilterTarget

 Il3ContextFilterParamsNotifySource = interface(Il3Base)
  {* �������� ����������� � ��� ��� ��������� ����������. }
  ['{D5B63786-ACB2-41F7-ABF7-67A7A0A3AD84}']
  procedure Subscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
  procedure UnSubscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
 end;//Il3ContextFilterParamsNotifySource

 Il3SimpleTree = interface(Il3RootSource)
  {* ������. }
  ['{CABAE851-B96A-4BD6-8310-3154F8C3D53F}']
  function Get_ShowRoot: Boolean;
  procedure Set_ShowRoot(aValue: Boolean);
  function Get_CountView: Integer;
  function Get_SelectCount: Integer;
  function Get_Flags(anIndex: Integer): Integer;
  function Get_Select(anIndex: Integer): Boolean;
  procedure Set_Select(anIndex: Integer;
   aValue: Boolean);
  function Get_Nodes(anIndex: Integer): Il3SimpleNode;
  procedure CursorTop;
   {* ����������� ������ �� ������ ������� �������. }
  function GetIndex(const aNode: Il3SimpleNode;
   const aSubRootNode: Il3SimpleNode = nil): Integer;
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
   aForceMode: Boolean = False): Boolean;
   {* ������ ������������� ����. }
  procedure ExpandSubDir(const aNode: Il3SimpleNode = nil;
   anExpand: Boolean = True;
   aDeepLevel: Byte = 0);
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
   IterMode: Integer = 0;
   const aSubRootNode: Il3SimpleNode = nil): Il3SimpleNode;
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
  property ShowRoot: Boolean
   read Get_ShowRoot
   write Set_ShowRoot;
   {* ���������� �� ������? }
  property CountView: Integer
   read Get_CountView;
   {* ������ ���������� ������� ���������. }
  property SelectCount: Integer
   read Get_SelectCount;
   {* ���������� ���������� �����. }
  property Flags[anIndex: Integer]: Integer
   read Get_Flags;
   {* ����� ����� �� �������� ������� [0..CountView-1]. }
  property Select[anIndex: Integer]: Boolean
   read Get_Select
   write Set_Select;
   {* ������� ��������� ����� �� �������� ������� [0..CountView-1]. }
  property Nodes[anIndex: Integer]: Il3SimpleNode
   read Get_Nodes;
   {* ���������� ���� �� �������� ������� [0..CountView-1]. }
 end;//Il3SimpleTree

 Il3RootSpy = interface(Il3Notify)
  {* ������, �������� �� ���������� �����. }
  ['{0C8B183A-508A-405D-938C-062F9BD183C3}']
  procedure RootChanged(const anOldRoot: Il3SimpleRootNode;
   const aNewRoot: Il3SimpleRootNode);
 end;//Il3RootSpy

 Il3NodeNotifyRecipient = interface(Il3Notify)
  {* ��������� ��� ��������� ����������� �� ��������. }
  ['{7C2B1160-C7E3-4D53-B3D3-E3787BE5650F}']
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode);
   {* ������ ��������. }
 end;//Il3NodeNotifyRecipient

 Il3FilterableTree = interface(Il3Base)
  {* ������ ������� ����������� �������. }
  ['{7AF1524E-84FD-4159-A755-DC621F06355E}']
  function CloneFilters: Il3TreeFilters;
  function MakeFiltered(const aFilters: Il3TreeFilters;
   const aCurrentNode: Il3SimpleNode;
   out aSyncIndex: Integer
   {* ���� ��� �������������. ������ ���� ���� �
                                   ������������� ���, ����� ��������� �
                                   ��������� sync_index. };
   aAutoOpen: Boolean = True
   {* ���������� ���� � �������� �������������.
                                   ����, ����� ����� ������� ��������������,
                                   ����� ������������� ������������. };
   CalcPartialContext: Boolean = False
   {* �������� ��������� ������������ ����������� ������,
                                   ������� ��� ������ ������ }): Il3SimpleTree;
 end;//Il3FilterableTree

 Il3ContextFilterParams = interface(Il3Base)
  {* ��������� � �������� ����� ������������� ����������� ������ }
  ['{1E1132A2-C8C3-4E5C-BDF6-4A139CAE0A71}']
  function WordPosition: Tl3WordPosition;
  function WordOrder: Tl3WordOrder;
  function TreeLevelDist: Tl3TreeLevelDist;
 end;//Il3ContextFilterParams

 Il3ContextFilterNotifier = interface(Il3Base)
  {* ����������� �� ��������� ������������ ������� }
  ['{EF53023B-C2D6-4224-A775-9A8EF7BE1814}']
  procedure RequestReapply;
   {* ���������� ������������� ������. }
  procedure RequestClearAndTurnOff;
   {* ������ ��������� �� ���� ������. }
  procedure RequestCheckValid;
   {* ������ ���������� - ����� ��������� ���������� �������. }
 end;//Il3ContextFilterNotifier

 Il3ContextFilterNotifySource = interface(Il3Base)
  {* �������� ����������� � ��� ��� ��������� ���������� }
  ['{92B574FC-96C1-4508-BC37-684311D65FE9}']
  procedure SubscribeToContextFilter(const aSubscriber: Il3ContextFilterNotifier);
  procedure UnSubscribeFromContextFilter(const aSubscriber: Il3ContextFilterNotifier);
 end;//Il3ContextFilterNotifySource

 Il3ContextFilterTargetContainer = interface(Il3Base)
  {* ��������� ��� ������������� }
  ['{8B89EA3D-277D-4AA6-A26F-462135D512CD}']
  function Unfold: Il3ContextFilterTarget;
 end;//Il3ContextFilterTargetContainer

 Il3Wake = interface(Il3Base)
  ['{DDC74AB7-2345-43E4-A26F-6BCC7C0781B1}']
  function Get_IsSleep: Boolean;
  function Wake: Boolean;
  property IsSleep: Boolean
   read Get_IsSleep;
 end;//Il3Wake

 Il3SimpleTreeSource = interface(Il3Base)
  ['{EA6A9D1A-ED3B-4B60-8F32-93F9558BF579}']
  function Get_Tree: Il3SimpleTree;
  procedure Set_Tree(const aValue: Il3SimpleTree);
  property Tree: Il3SimpleTree
   read Get_Tree
   write Set_Tree;
 end;//Il3SimpleTreeSource

 Il3CountViewChangeRecipient = interface(Il3Base)
  {* ��������� ��� ��������� ����������� �� ��������� ���������� ������� ���������. }
  ['{55350BB2-0AF6-4C25-8B69-85E2F918F722}']
  procedure CountViewChanged(aCountView: Integer);
   {* ������ ��������. }
 end;//Il3CountViewChangeRecipient

 Il3SimpleInternalNode = interface(Il3Base)
  ['{FD586615-B68E-4E35-BDB7-61F0E556D023}']
  procedure Set_Parent(const aValue: Il3SimpleNode);
  property Parent: Il3SimpleNode
   write Set_Parent;
   {* ������������ ����. }
 end;//Il3SimpleInternalNode

 Il3ExpandedSimpleTree = interface(Il3SimpleTree)
  {* ������ � ����������� �����������������. }
  ['{705500C4-0F50-4079-9A00-CAF8F9D01E69}']
  function FlagIterateF(Action: Tl3SimpleNodeAction;
   FlagMask: Word = 0;
   IterMode: Integer = 0;
   const aSubRootNode: Il3SimpleNode = nil;
   aCheckResult: Boolean = False): Il3SimpleNode;
   {* ��������� ��� ����, ��������������� FlagMask, � ���������� �������� ��� Action. IterMode: imCheckResult, imParentNeed }
 end;//Il3ExpandedSimpleTree

 Il3ExtItemNode = interface(Il3Base)
  {* ���� �� ���������� �������. � ����� �� �� � ���� ������? }
  ['{9A362763-3CCF-4E69-9B9D-1B92253D0A85}']
  function Get_Data: Pointer;
  procedure Set_Data(aValue: Pointer);
  function Get_DataSize: Integer;
  property Data: Pointer
   read Get_Data
   write Set_Data;
  property DataSize: Integer
   read Get_DataSize;
 end;//Il3ExtItemNode

implementation

uses
 l3ImplUses
;

end.
