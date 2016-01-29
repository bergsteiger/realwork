unit l3SimpleTree;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3TreeInterfaces
 , l3Interfaces
;

type
 Tl3SimpleTree = class(Tl3CacheableBase, Il3SimpleTree)
  {* "�������" ������. }
  procedure Create(const aRoot: Il3SimpleRootNode);
  procedure Make(const aRoot: Il3SimpleRootNode);
  procedure RootChanged(const aOld: Il3SimpleRootNode;
   const aNew: Il3SimpleRootNode);
  function RootNode: Il3SimpleRootNode;
   {* ������ ������. }
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
 end;//Tl3SimpleTree
 
implementation

uses
 l3ImplUses
 , l3InterfacesMisc
 , l3Bits
 , l3Types
 , l3Base
 , SysUtils
;

end.
