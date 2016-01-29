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
  {* �������������� ������� ��� �������� ��������� ������. ���� ���������� true, �� ������� �������� ����� ������������. }
 
 Il3Node = interface(Il3SimpleNode)
  {* ���� ������. }
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
  procedure Remove;
   {* ������� ���� �� ������. }
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
  procedure Changed;
   {* ����������� � ���������� ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
  procedure Changing;
   {* ����������� � ������ ��������� ��������� �������. ��� ���������� � ������������� � ��������. }
 end;//Il3Node
 
 Il3RootNode = interface(Il3Node)
  {* �������� ���� }
 end;//Il3RootNode
 
 Il3Tree = interface(Il3SimpleTree)
  {* ������. }
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
   {* ���������� ����, ����������� ��������������� ����� ��������� ���������� �� ��������. }
  function IterateF(Action: Tl3NodeAction;
   IterMode: Integer;
   const aSubRootNode: Il3Node;
   const aFromNode: Il3Node): Il3Node;
   {* ��������� ��� ���� � ���������� �������� ��� Action. }
  procedure SetRootAndCountView(const aNode: Il3RootNode;
   aCountView: Integer);
   {* <?> �������� �� ��������. }
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
 end;//Il3Tree
 
 Il3InternalNode = interface(Il3Node)
  {* ���������� ������������� ���� ������. ��� ������ ������� � �����. }
 end;//Il3InternalNode
 
 Il3TreeWithLockRebuild = interface
  procedure LockRebuild;
  procedure UnlockRebuild;
  function IsRebuildLocked: Boolean;
 end;//Il3TreeWithLockRebuild
 
 Il3TreeSource = interface
  {* �������� ��������� ������. }
 end;//Il3TreeSource
 
implementation

uses
 l3ImplUses
;

end.
