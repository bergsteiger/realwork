unit l3Tree_TLB;
 {* ���������� ��� ������ � ���������. }

// ������: "w:\common\components\rtl\Garant\L3\l3Tree_TLB.pas"
// ���������: "Interfaces"

{$Include l3Define.inc}

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
  {* �������������� ������� ��� �������� ��������� ������. ���� ���������� true, �� ������� �������� ����� ������������. }

 Il3Node = interface(Il3SimpleNode)
  {* ���� ������. }
  ['{BDC2C857-504E-41EC-984D-89C2285E449D}']
  function Get_AllChildrenCount: Integer;
  function Get_ChildSorted: Boolean;
  procedure Set_ChildSorted(aValue: Boolean);
  function Get_ChildSortedFromParent: Boolean;
  procedure Set_ChildSortedFromParent(aValue: Boolean);
  function Get_Flags: Integer;
  procedure Set_Flags(aValue: Integer);
  function Get_Text: Tl3PCharLenPrim;
  procedure Set_Text(const aValue: Tl3PCharLenPrim);
  function Get_NextNode: Il3Node;
  function Get_PrevNode: Il3Node;
  function Get_ParentNode: Il3Node;
  function Get_ChildNode: Il3Node;
  function InsertChild(const aNode: Il3Node): Il3Node;
  function InsertChildBefore(const aNextChild: Il3Node;
   const aNode: Il3Node): Il3Node;
  function IsAcceptChild(const aChild: Il3Node): Boolean;
  function GetChildByNumber(aNum: Integer): Il3Node;
   {* �������� �������� ���� �� ������. }
  function GetNodeByNumber(aNum: Integer): Il3Node;
   {* �������� ���� �� ������. 0 = Self, ��������� ��������, }
  function GetNumInParent(aOnlyOneLevel: Boolean = False): Integer;
   {* �������� ���������� ����� ���� � ������������ ����.
          aOnlyOneLevel - ������� ������ ���������������� "�����",
          ��� ����� ��������� }
  procedure Notify(aOperation: Integer;
   const aNode: Il3Node);
   {* ����������� �� �������� ��� �����. anOperation ��. ntNone etc. }
  procedure IncAllChildrenCount(aInc: Integer);
  procedure Remove;
   {* ������� ���� �� ������. }
  function Move(aDirection: Tl3Direction): Boolean;
   {* ����������� ����. }
  function Iterate(Action: Tl3NodeAction;
   IterMode: Integer = 0;
   const aFromNode: Il3Node = nil): Il3Node;
   {* ��������� ��� �������� ����. IterMode ��. imExpandOnly etc. }
  function IterateF(Action: Tl3NodeAction;
   IterMode: Integer = 0;
   const aFromNode: Il3Node = nil): Il3Node;
   {* ��������� ��� �������� ���� � ���������� �������� ��� Action. }
  procedure ReleaseChilds;
   {* ���������� �������� ����. }
  function CompareChild(const aChildrenNode1: Il3Node;
   const aChildrenNode2: Il3Node): Integer;
   {* ���������� aChildrenNode1 � aChildrenNode2 (������ Text), ������������ ��� ���������� ����� ������. }
  procedure SortChilds(const aChild: Il3Node = nil);
   {* ����������������� aChild ������������ ������ Nodes �� ��� �� ������,
         ������ � ������ ��������� Text,
          ���� aChild = nil ����������������� ��� ����� (���� �������). }
  procedure Sort;
   {* ����������������� ���� ������������ ������ Nodes �� ��� �� ������. }
  procedure Changed;
   {* ����������� � ���������� ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
  procedure Changing;
   {* ����������� � ������ ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
  property AllChildrenCount: Integer
   read Get_AllChildrenCount;
   {* ����� �������� ���������, ������� ��� ���������. }
  property ChildSorted: Boolean
   read Get_ChildSorted
   write Set_ChildSorted;
   {* ����� �� ����������� ChildNode. }
  property ChildSortedFromParent: Boolean
   read Get_ChildSortedFromParent
   write Set_ChildSortedFromParent;
   {* ���������� ChildSorted � ParentNode. }
  property Flags: Integer
   read Get_Flags
   write Set_Flags;
   {* �����. }
  property Text: Tl3PCharLenPrim
   read Get_Text
   write Set_Text;
   {* ����� ����. }
  property NextNode: Il3Node
   read Get_NextNode;
   {* ��������� ���� ���� �� ������. }
  property PrevNode: Il3Node
   read Get_PrevNode;
   {* ���������� ���� ���� �� ������. }
  property ParentNode: Il3Node
   read Get_ParentNode;
   {* ������������ ����. }
  property ChildNode: Il3Node
   read Get_ChildNode;
   {* ������ �������� �������. }
 end;//Il3Node

 Il3RootNode = interface(Il3Node)
  {* �������� ���� }
  ['{42FD62D0-B4D4-4212-A282-1C78349A60F1}']
  function As_Il3ChangeNotifier: Il3ChangeNotifier;
   {* ����� ���������� ������ ���������� � Il3ChangeNotifier }
 end;//Il3RootNode

 Il3Tree = interface(Il3SimpleTree)
  {* ������. }
  ['{A8F1929F-0BDE-47C0-B307-46ABC8EB84C1}']
  function Get_CommonExpanded: Boolean;
  procedure Set_CommonExpanded(aValue: Boolean);
  function Get_SelModifiedCount: Integer;
  function Get_Modified: Boolean;
  procedure Set_Modified(aValue: Boolean);
  function Get_CNodes(Index: Integer): Il3Node;
  function Get_SelectedNode(const Node: Il3Node): Boolean;
  procedure Set_SelectedNode(const Node: Il3Node;
   aValue: Boolean);
  function Get_NodeFlags(const Node: Il3Node): Integer;
  procedure Set_NodeFlags(const Node: Il3Node;
   aValue: Integer);
  function Get_CRootNode: Il3RootNode;
  procedure Set_CRootNode(const aValue: Il3RootNode);
  function Get_Strings(anIndex: Integer): PAnsiChar;
  function GetFlagsByAbsIndex(aAbsIndex: Integer): Integer;
  procedure SetFlagsByAbsIndex(aAbsIndex: Integer;
   aValue: Integer);
  function GetNodeByAbsIndex(aAbsIndex: Integer): Il3Node;
  function GetAbsIndex(const aCurNode: Il3Node): Integer;
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode);
   {* ����������� �� �������� ��� �����. anOperation ��. ntNone etc. }
  function ChangeExpand(const RNode: Il3Node;
   Mode: Tl3SetBitType;
   aForceMode: Boolean = False): Boolean;
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
   {* ���������� ����, ����������� ��������������� ����� ��������� ���������� �� ��������. }
  function IterateF(Action: Tl3NodeAction;
   IterMode: Integer = 0;
   const aSubRootNode: Il3Node = nil;
   const aFromNode: Il3Node = nil): Il3Node;
   {* ��������� ��� ���� � ���������� �������� ��� Action. }
  procedure SetRootAndCountView(const aNode: Il3RootNode;
   aCountView: Integer);
   {* <?> �������� �� ��������. }
  procedure SetAllFlag(aMode: Tl3SetBitType;
   aFlags: Integer);
  procedure PrintTreeList(const aFileName: TFileName;
   aWithNumber: Boolean;
   aIterMode: Integer = 0;
   const aLevelIndent: AnsiString = ' ');
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
   {* �������� �������� ����. }
  function InsertNode(const aParentNode: Il3Node;
   const aNode: Il3Node): Il3Node;
   {* �������� ����� ����. }
  function InsertNodeBefore(const aNextNode: Il3Node;
   const aNode: Il3Node): Il3Node;
   {* �������� ����� ���� ����� ���������. }
  procedure SetLevelSlash(const aSt: AnsiString);
  function IsSelect(const aNode: Il3Node): Boolean;
   {* �������� �� ���� ����������. }
  function IsChildSelect(const aNode: Il3Node): Boolean;
  procedure Clear;
  function MoveSelectedNodes(aDirection: Tl3Direction): Boolean;
   {* ���������� ���������� ���� }
  function DeleteSelectedNodes: Boolean;
   {* ������� ���������� ����, }
  function GetNextSelect(const aCurNode: Il3Node): Il3Node;
  procedure ClearSelected;
  property CommonExpanded: Boolean
   read Get_CommonExpanded
   write Set_CommonExpanded;
  property SelModifiedCount: Integer
   read Get_SelModifiedCount;
  property Modified: Boolean
   read Get_Modified
   write Set_Modified;
   {* ������� ��������� ��������� ������. }
  property CNodes[Index: Integer]: Il3Node
   read Get_CNodes;
   {* ���� �� �������. }
  property SelectedNode[const Node: Il3Node]: Boolean
   read Get_SelectedNode
   write Set_SelectedNode;
   {* ���������� ����. }
  property NodeFlags[const Node: Il3Node]: Integer
   read Get_NodeFlags
   write Set_NodeFlags;
   {* ����� �����. (��. nfSelected etc) }
  property CRootNode: Il3RootNode
   read Get_CRootNode
   write Set_CRootNode;
   {* �������� ���� ������. }
  property Strings[anIndex: Integer]: PAnsiChar
   read Get_Strings;
   {* ������� ����� �� �������� ������� [0..CountView-1]. }
 end;//Il3Tree

 Il3InternalNode = interface(Il3Node)
  {* ���������� ������������� ���� ������. ��� ������ ������� � �����. }
  ['{6D78042F-D475-47B5-AA85-D90F0FE6CA9C}']
  function Get_ParentNode: Il3Node;
  procedure Set_ParentNode(const aValue: Il3Node);
  function Get_ChildNode: Il3Node;
  procedure Set_ChildNode(const aValue: Il3Node);
  function Get_NextNode: Il3Node;
  procedure Set_NextNode(const aValue: Il3Node);
  function Get_PrevNode: Il3Node;
  procedure Set_PrevNode(const aValue: Il3Node);
  property ParentNode: Il3Node
   read Get_ParentNode
   write Set_ParentNode;
   {* ������������ ����. }
  property ChildNode: Il3Node
   read Get_ChildNode
   write Set_ChildNode;
   {* ������ �������� �������. }
  property NextNode: Il3Node
   read Get_NextNode
   write Set_NextNode;
   {* ��������� ���� ���� �� ������. }
  property PrevNode: Il3Node
   read Get_PrevNode
   write Set_PrevNode;
   {* ���������� ���� ���� �� ������. }
 end;//Il3InternalNode

 Il3TreeWithLockRebuild = interface
  ['{B9824BFD-4B51-417E-A2F5-3201CE829601}']
  procedure LockRebuild;
  procedure UnlockRebuild;
  function IsRebuildLocked: Boolean;
 end;//Il3TreeWithLockRebuild

 Il3TreeSource = interface
  {* �������� ��������� ������. }
  ['{51C16453-58D7-4494-8A54-88554755533B}']
  function Get_Tree: Il3Tree;
  procedure Set_Tree(const aValue: Il3Tree);
  property Tree: Il3Tree
   read Get_Tree
   write Set_Tree;
   {* ������, ��������������� ����������. }
 end;//Il3TreeSource

implementation

uses
 l3ImplUses
;

end.
