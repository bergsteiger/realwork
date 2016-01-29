unit l3Tree;

interface

uses
 l3IntfUses
 , l3ItemsStorage
 , l3InternalInterfaces
 , l3Interfaces
 , l3Tree_TLB
 , l3TreeInterfaces
 , SysUtils
;

type
 Tl3Tree = class(Tl3ItemsStorage, Il3ObjectWrap, Il3Window, Il3Tree, Il3TreeSource, Il3NodeNotifyRecipient)
  {* ��������� ������ "������". ������������ ��� ������ ��� ������� ���������. }
  function Get__CRootNode: Il3RootNode;
  procedure DoNotify(aOperation: Integer;
   const aNode: Il3SimpleNode);
  function RootNode: Il3SimpleRootNode;
   {* ������ ������. }
  procedure Invalidate;
   {* ������ �� �����������. }
  function GetObject: TObject;
   {* �������� ������ �� �������. }
  function GetFlagsByAbsIndex(aAbsIndex: Integer): Integer;
  procedure SetFlagsByAbsIndex(aAbsIndex: Integer;
   aValue: Integer);
  function GetNodeByAbsIndex(aAbsIndex: Integer): Il3Node;
  function GetAbsIndex(const aCurNode: Il3Node): Integer;
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode); overload;
   {* ����������� �� �������� ��� �����. anOperation ��. ntNone etc. }
  function ChangeExpand(const RNode: Il3Node;
   Mode: Tl3SetBitType;
   aForceMode: Boolean): Boolean; overload;
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
  function GetPrev(const aCurNode: Il3Node): Il3Node; overload;
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
  function CNodes: Il3Node;
   {* ���� �� �������. }
  function SelectedNode: Boolean;
   {* ���������� ����. }
  function NodeFlags: Integer;
   {* ����� �����. (��. nfSelected etc) }
  function CRootNode: Il3RootNode;
   {* �������� ���� ������. }
  function CommonExpanded: Boolean;
  function SelModifiedCount: Integer;
  function Modified: Boolean;
   {* ������� ��������� ��������� ������. }
  function Strings: PAnsiChar;
   {* ������� ����� �� �������� ������� [0..CountView-1]. }
  function Tree: Il3Tree;
   {* ������, ��������������� ����������. }
  function GetNextSelect(const aCurNode: Il3Node): Il3Node;
  procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode); overload;
   {* ������ ��������. }
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
   aForceMode: Boolean): Boolean; overload;
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
  function GetPrev(const aNode: Il3SimpleNode): Il3SimpleNode; overload;
   {* ���������� ����. �����-�� ������������ � CharToItem. }
  function SimpleIterateF(Action: Tl3SimpleNodeAction;
   IterMode: Integer;
   const aSubRootNode: Il3SimpleNode): Il3SimpleNode;
   {* ��������� ��� ���� � ���������� �������� ��� Action. IterMode: imCheckResult, imParentNeed }
  function IsChanging: Boolean;
   {* ������ ��������� � ���� ����������. }
  procedure Changing;
  procedure Changed;
  function ShowRoot: Boolean;
   {* ���������� �� ������? }
  function CountView: Integer;
   {* ������ ���������� ������� ���������. }
  function SelectCount: Integer;
   {* ���������� ���������� �����. }
  function Flags: Integer;
   {* ����� ����� �� �������� ������� [0..CountView-1]. }
  function Select: Boolean;
   {* ������� ��������� ����� �� �������� ������� [0..CountView-1]. }
  function Nodes: Il3SimpleNode;
   {* ���������� ���� �� �������� ������� [0..CountView-1]. }
  function MakeDataObject(const aNode: Il3SimpleNode;
   const aBitmap: IUnknown): IDataObject;
   {* ������� ������ ������ ������, ������������ ��� ����������� ��������� ������ � ������ ���������� }
  function CanAcceptData(const aTargetNode: Il3SimpleNode;
   const aData: Tl3TreeData): Boolean;
  function DropData(const aTargetNode: Il3SimpleNode;
   const aData: Tl3TreeData): Boolean;
  procedure ClearSelected;
 end;//Tl3Tree
 
implementation

uses
 l3ImplUses
;

end.
