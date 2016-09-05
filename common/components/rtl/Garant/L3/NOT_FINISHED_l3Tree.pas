unit NOT_FINISHED_l3Tree;
 {* ��������� ������ "������". ������������ ��� ������ ��� ������� ���������. }

// ������: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3Tree.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3Tree" MUID: (4804BDA10127)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

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

const
 DefLevelSlash: PAnsiChar = '\';

type
 Tl3Tree = class(Tl3ItemsStorage, Il3ObjectWrap, Il3Window, Il3Tree, Il3TreeSource, Il3NodeNotifyRecipient)
  {* ��������� ������ "������". ������������ ��� ������ ��� ������� ���������. }
  private
   f_fCountView: Integer;
   f_CurrentNode: Il3Node;
   f_CurrentItem: Integer;
  protected
   fRootNode: Il3RootNode;
   fCurrentAbsItem: Integer;
   fCurrentAbsNode: Il3Node;
  protected
   function Get_NodeFlags(const Node: Il3Node): integer; virtual;
   procedure Set_NodeFlags(const Node: Il3Node;
    aValue: integer); virtual;
   procedure pm_SetfCountView(aValue: Integer);
   function pm_GetCurrentItem: Integer;
   function Get_CRootNode: Il3RootNode; virtual;
   function Get_RootNode: Il3SimpleRootNode;
   procedure Set_RootNode(const aValue: Il3SimpleRootNode);
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
    aForceMode: Boolean = False): Boolean; overload;
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
   function Get_CNodes(Index: Integer): Il3Node;
   function Get_SelectedNode(const Node: Il3Node): Boolean;
   procedure Set_SelectedNode(const Node: Il3Node;
    aValue: Boolean);
   function Get_NodeFlags(const Node: Il3Node): Integer;
   procedure Set_NodeFlags(const Node: Il3Node;
    aValue: Integer);
   function Get_CRootNode: Il3RootNode;
   procedure Set_CRootNode(const aValue: Il3RootNode);
   function Get_CommonExpanded: Boolean;
   procedure Set_CommonExpanded(aValue: Boolean);
   function Get_SelModifiedCount: Integer;
   function Get_Modified: Boolean;
   procedure Set_Modified(aValue: Boolean);
   function Get_Strings(anIndex: Integer): PAnsiChar;
   function Get_Tree: Il3Tree;
   procedure Set_Tree(const aValue: Il3Tree);
   function GetNextSelect(const aCurNode: Il3Node): Il3Node;
   procedure Notify(aOperation: Integer;
    const aNode: Il3SimpleNode); overload;
    {* ������ ��������. }
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
    aForceMode: Boolean = False): Boolean; overload;
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
   function GetPrev(const aNode: Il3SimpleNode): Il3SimpleNode; overload;
    {* ���������� ����. �����-�� ������������ � CharToItem. }
   function SimpleIterateF(Action: Tl3SimpleNodeAction;
    IterMode: Integer = 0;
    const aSubRootNode: Il3SimpleNode = nil): Il3SimpleNode;
    {* ��������� ��� ���� � ���������� �������� ��� Action. IterMode: imCheckResult, imParentNeed }
   function IsChanging: Boolean;
    {* ������ ��������� � ���� ����������. }
   procedure Changing;
   procedure Changed;
   function Get_ShowRoot: Boolean;
   procedure Set_ShowRoot(aValue: Boolean);
   function Get_CountView: Integer;
   function Get_SelectCount: Integer;
   function Get_Flags(anIndex: Integer): Integer;
   function Get_Select(anIndex: Integer): Boolean;
   procedure Set_Select(anIndex: Integer;
    aValue: Boolean);
   function Get_Nodes(anIndex: Integer): Il3SimpleNode;
   function MakeDataObject(const aNode: Il3SimpleNode;
    const aBitmap: IUnknown): IDataObject;
    {* ������� ������ ������ ������, ������������ ��� ����������� ��������� ������ � ������ ���������� }
   function CanAcceptData(const aTargetNode: Il3SimpleNode;
    const aData: Tl3TreeData): Boolean;
   function DropData(const aTargetNode: Il3SimpleNode;
    const aData: Tl3TreeData): Boolean;
   procedure ClearSelected;
   procedure ClearFields; override;
  public
   procedure DoNotify(aOperation: Integer;
    const aNode: Il3SimpleNode); virtual;
  protected
   property fCountView: Integer
    read f_fCountView
    write pm_SetfCountView;
  public
   property NodeFlags[const Node: Il3Node]: integer
    read Get_NodeFlags
    write Set_NodeFlags;
   property CurrentNode: Il3Node
    read f_CurrentNode;
   property CurrentItem: Integer
    read pm_GetCurrentItem;
 end;//Tl3Tree

implementation

uses
 l3ImplUses
 //#UC START# *4804BDA10127impl_uses*
 //#UC END# *4804BDA10127impl_uses*
;

function Tl3Tree.Get_NodeFlags(const Node: Il3Node): integer;
//#UC START# *4FD9E16C027C_4804BDA10127get_var*
//#UC END# *4FD9E16C027C_4804BDA10127get_var*
begin
//#UC START# *4FD9E16C027C_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD9E16C027C_4804BDA10127get_impl*
end;//Tl3Tree.Get_NodeFlags

procedure Tl3Tree.Set_NodeFlags(const Node: Il3Node;
 aValue: integer);
//#UC START# *4FD9E16C027C_4804BDA10127set_var*
//#UC END# *4FD9E16C027C_4804BDA10127set_var*
begin
//#UC START# *4FD9E16C027C_4804BDA10127set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD9E16C027C_4804BDA10127set_impl*
end;//Tl3Tree.Set_NodeFlags

procedure Tl3Tree.pm_SetfCountView(aValue: Integer);
//#UC START# *4FD9F9A10237_4804BDA10127set_var*
//#UC END# *4FD9F9A10237_4804BDA10127set_var*
begin
//#UC START# *4FD9F9A10237_4804BDA10127set_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD9F9A10237_4804BDA10127set_impl*
end;//Tl3Tree.pm_SetfCountView

function Tl3Tree.pm_GetCurrentItem: Integer;
//#UC START# *4FD9FAB40003_4804BDA10127get_var*
//#UC END# *4FD9FAB40003_4804BDA10127get_var*
begin
//#UC START# *4FD9FAB40003_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FD9FAB40003_4804BDA10127get_impl*
end;//Tl3Tree.pm_GetCurrentItem

function Tl3Tree.Get_CRootNode: Il3RootNode;
//#UC START# *4FFC1D0502D0_4804BDA10127_var*
//#UC END# *4FFC1D0502D0_4804BDA10127_var*
begin
//#UC START# *4FFC1D0502D0_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FFC1D0502D0_4804BDA10127_impl*
end;//Tl3Tree.Get_CRootNode

procedure Tl3Tree.DoNotify(aOperation: Integer;
 const aNode: Il3SimpleNode);
//#UC START# *5329A20B0356_4804BDA10127_var*
//#UC END# *5329A20B0356_4804BDA10127_var*
begin
//#UC START# *5329A20B0356_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *5329A20B0356_4804BDA10127_impl*
end;//Tl3Tree.DoNotify

function Tl3Tree.Get_RootNode: Il3SimpleRootNode;
//#UC START# *46825CAA0125_4804BDA10127get_var*
//#UC END# *46825CAA0125_4804BDA10127get_var*
begin
//#UC START# *46825CAA0125_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *46825CAA0125_4804BDA10127get_impl*
end;//Tl3Tree.Get_RootNode

procedure Tl3Tree.Set_RootNode(const aValue: Il3SimpleRootNode);
//#UC START# *46825CAA0125_4804BDA10127set_var*
//#UC END# *46825CAA0125_4804BDA10127set_var*
begin
//#UC START# *46825CAA0125_4804BDA10127set_impl*
 !!! Needs to be implemented !!!
//#UC END# *46825CAA0125_4804BDA10127set_impl*
end;//Tl3Tree.Set_RootNode

procedure Tl3Tree.Invalidate;
 {* ������ �� �����������. }
//#UC START# *46A5AA4B003C_4804BDA10127_var*
//#UC END# *46A5AA4B003C_4804BDA10127_var*
begin
//#UC START# *46A5AA4B003C_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *46A5AA4B003C_4804BDA10127_impl*
end;//Tl3Tree.Invalidate

function Tl3Tree.GetObject: TObject;
 {* �������� ������ �� �������. }
//#UC START# *476F6F6F00EE_4804BDA10127_var*
//#UC END# *476F6F6F00EE_4804BDA10127_var*
begin
//#UC START# *476F6F6F00EE_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F6F6F00EE_4804BDA10127_impl*
end;//Tl3Tree.GetObject

function Tl3Tree.GetFlagsByAbsIndex(aAbsIndex: Integer): Integer;
//#UC START# *4771115902AA_4804BDA10127_var*
//#UC END# *4771115902AA_4804BDA10127_var*
begin
//#UC START# *4771115902AA_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771115902AA_4804BDA10127_impl*
end;//Tl3Tree.GetFlagsByAbsIndex

procedure Tl3Tree.SetFlagsByAbsIndex(aAbsIndex: Integer;
 aValue: Integer);
//#UC START# *4771117201D7_4804BDA10127_var*
//#UC END# *4771117201D7_4804BDA10127_var*
begin
//#UC START# *4771117201D7_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771117201D7_4804BDA10127_impl*
end;//Tl3Tree.SetFlagsByAbsIndex

function Tl3Tree.GetNodeByAbsIndex(aAbsIndex: Integer): Il3Node;
//#UC START# *4771117B0132_4804BDA10127_var*
//#UC END# *4771117B0132_4804BDA10127_var*
begin
//#UC START# *4771117B0132_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771117B0132_4804BDA10127_impl*
end;//Tl3Tree.GetNodeByAbsIndex

function Tl3Tree.GetAbsIndex(const aCurNode: Il3Node): Integer;
//#UC START# *477111820195_4804BDA10127_var*
//#UC END# *477111820195_4804BDA10127_var*
begin
//#UC START# *477111820195_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477111820195_4804BDA10127_impl*
end;//Tl3Tree.GetAbsIndex

procedure Tl3Tree.Notify(aOperation: Integer;
 const aNode: Il3SimpleNode);
 {* ����������� �� �������� ��� �����. anOperation ��. ntNone etc. }
//#UC START# *4771118F0051_4804BDA10127_var*
//#UC END# *4771118F0051_4804BDA10127_var*
begin
//#UC START# *4771118F0051_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771118F0051_4804BDA10127_impl*
end;//Tl3Tree.Notify

function Tl3Tree.ChangeExpand(const RNode: Il3Node;
 Mode: Tl3SetBitType;
 aForceMode: Boolean = False): Boolean;
//#UC START# *477111A90203_4804BDA10127_var*
//#UC END# *477111A90203_4804BDA10127_var*
begin
//#UC START# *477111A90203_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477111A90203_4804BDA10127_impl*
end;//Tl3Tree.ChangeExpand

function Tl3Tree.TestFlagMask(const aNode: Il3Node;
 aFlagMask: Integer): Boolean;
//#UC START# *47711208036F_4804BDA10127_var*
//#UC END# *47711208036F_4804BDA10127_var*
begin
//#UC START# *47711208036F_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711208036F_4804BDA10127_impl*
end;//Tl3Tree.TestFlagMask

function Tl3Tree.TestFlagMask(aAbsIndex: Integer;
 aFlagMask: Integer): Boolean;
//#UC START# *477112160055_4804BDA10127_var*
//#UC END# *477112160055_4804BDA10127_var*
begin
//#UC START# *477112160055_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477112160055_4804BDA10127_impl*
end;//Tl3Tree.TestFlagMask

procedure Tl3Tree.SetFlagMask(aAbsIndex: Integer;
 aFlagMask: Integer;
 aMode: Tl3SetBitType);
//#UC START# *4771123B00BD_4804BDA10127_var*
//#UC END# *4771123B00BD_4804BDA10127_var*
begin
//#UC START# *4771123B00BD_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771123B00BD_4804BDA10127_impl*
end;//Tl3Tree.SetFlagMask

procedure Tl3Tree.SetFlagMask(const aRNode: Il3Node;
 aFlagMask: Integer;
 aMode: Tl3SetBitType);
//#UC START# *4771125F0015_4804BDA10127_var*
//#UC END# *4771125F0015_4804BDA10127_var*
begin
//#UC START# *4771125F0015_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771125F0015_4804BDA10127_impl*
end;//Tl3Tree.SetFlagMask

function Tl3Tree.GetPrev(const aCurNode: Il3Node): Il3Node;
 {* ���������� ����, ����������� ��������������� ����� ��������� ���������� �� ��������. }
//#UC START# *4771128D013D_4804BDA10127_var*
//#UC END# *4771128D013D_4804BDA10127_var*
begin
//#UC START# *4771128D013D_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771128D013D_4804BDA10127_impl*
end;//Tl3Tree.GetPrev

function Tl3Tree.IterateF(Action: Tl3NodeAction;
 IterMode: Integer = 0;
 const aSubRootNode: Il3Node = nil;
 const aFromNode: Il3Node = nil): Il3Node;
 {* ��������� ��� ���� � ���������� �������� ��� Action. }
//#UC START# *477112F70265_4804BDA10127_var*
//#UC END# *477112F70265_4804BDA10127_var*
begin
//#UC START# *477112F70265_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477112F70265_4804BDA10127_impl*
end;//Tl3Tree.IterateF

procedure Tl3Tree.SetRootAndCountView(const aNode: Il3RootNode;
 aCountView: Integer);
 {* <?> �������� �� ��������. }
//#UC START# *477113440266_4804BDA10127_var*
//#UC END# *477113440266_4804BDA10127_var*
begin
//#UC START# *477113440266_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477113440266_4804BDA10127_impl*
end;//Tl3Tree.SetRootAndCountView

procedure Tl3Tree.SetAllFlag(aMode: Tl3SetBitType;
 aFlags: Integer);
//#UC START# *4771138300B3_4804BDA10127_var*
//#UC END# *4771138300B3_4804BDA10127_var*
begin
//#UC START# *4771138300B3_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771138300B3_4804BDA10127_impl*
end;//Tl3Tree.SetAllFlag

procedure Tl3Tree.PrintTreeList(const aFileName: TFileName;
 aWithNumber: Boolean;
 aIterMode: Integer = 0;
 const aLevelIndent: AnsiString = ' ');
//#UC START# *4771139800F2_4804BDA10127_var*
//#UC END# *4771139800F2_4804BDA10127_var*
begin
//#UC START# *4771139800F2_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771139800F2_4804BDA10127_impl*
end;//Tl3Tree.PrintTreeList

function Tl3Tree.SearchByName(const aFirstNode: Il3Node;
 aNameStr: PAnsiChar;
 aIterMode: Integer): Il3Node;
//#UC START# *477117C402D0_4804BDA10127_var*
//#UC END# *477117C402D0_4804BDA10127_var*
begin
//#UC START# *477117C402D0_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477117C402D0_4804BDA10127_impl*
end;//Tl3Tree.SearchByName

function Tl3Tree.FindNodeByParam(const Parent: Il3Node;
 Param: Integer;
 aIterMode: Integer): Il3Node;
//#UC START# *47711814010D_4804BDA10127_var*
//#UC END# *47711814010D_4804BDA10127_var*
begin
//#UC START# *47711814010D_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711814010D_4804BDA10127_impl*
end;//Tl3Tree.FindNodeByParam

procedure Tl3Tree.ResetSelection;
//#UC START# *47711821014D_4804BDA10127_var*
//#UC END# *47711821014D_4804BDA10127_var*
begin
//#UC START# *47711821014D_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711821014D_4804BDA10127_impl*
end;//Tl3Tree.ResetSelection

procedure Tl3Tree.LockSelModify;
//#UC START# *4771182A01D4_4804BDA10127_var*
//#UC END# *4771182A01D4_4804BDA10127_var*
begin
//#UC START# *4771182A01D4_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771182A01D4_4804BDA10127_impl*
end;//Tl3Tree.LockSelModify

procedure Tl3Tree.UnLockSelModify;
//#UC START# *4771183003C7_4804BDA10127_var*
//#UC END# *4771183003C7_4804BDA10127_var*
begin
//#UC START# *4771183003C7_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771183003C7_4804BDA10127_impl*
end;//Tl3Tree.UnLockSelModify

function Tl3Tree.GetNextSetFlag(const aCurNode: Il3Node;
 aFlag: Integer): Il3Node;
 {* //vvv }
//#UC START# *4771183E037B_4804BDA10127_var*
//#UC END# *4771183E037B_4804BDA10127_var*
begin
//#UC START# *4771183E037B_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771183E037B_4804BDA10127_impl*
end;//Tl3Tree.GetNextSetFlag

procedure Tl3Tree.ChangeName(const aNode: Il3Node;
 NewTitle: PAnsiChar);
 {* �������� �������� ����. }
//#UC START# *4771185B02D0_4804BDA10127_var*
//#UC END# *4771185B02D0_4804BDA10127_var*
begin
//#UC START# *4771185B02D0_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771185B02D0_4804BDA10127_impl*
end;//Tl3Tree.ChangeName

function Tl3Tree.InsertNode(const aParentNode: Il3Node;
 const aNode: Il3Node): Il3Node;
 {* �������� ����� ����. }
//#UC START# *4771187100EF_4804BDA10127_var*
//#UC END# *4771187100EF_4804BDA10127_var*
begin
//#UC START# *4771187100EF_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771187100EF_4804BDA10127_impl*
end;//Tl3Tree.InsertNode

function Tl3Tree.InsertNodeBefore(const aNextNode: Il3Node;
 const aNode: Il3Node): Il3Node;
 {* �������� ����� ���� ����� ���������. }
//#UC START# *4771188A012C_4804BDA10127_var*
//#UC END# *4771188A012C_4804BDA10127_var*
begin
//#UC START# *4771188A012C_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771188A012C_4804BDA10127_impl*
end;//Tl3Tree.InsertNodeBefore

procedure Tl3Tree.SetLevelSlash(const aSt: AnsiString);
//#UC START# *477118A00158_4804BDA10127_var*
//#UC END# *477118A00158_4804BDA10127_var*
begin
//#UC START# *477118A00158_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477118A00158_4804BDA10127_impl*
end;//Tl3Tree.SetLevelSlash

function Tl3Tree.IsSelect(const aNode: Il3Node): Boolean;
 {* �������� �� ���� ����������. }
//#UC START# *477118AC0111_4804BDA10127_var*
//#UC END# *477118AC0111_4804BDA10127_var*
begin
//#UC START# *477118AC0111_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477118AC0111_4804BDA10127_impl*
end;//Tl3Tree.IsSelect

function Tl3Tree.IsChildSelect(const aNode: Il3Node): Boolean;
//#UC START# *477118BE0229_4804BDA10127_var*
//#UC END# *477118BE0229_4804BDA10127_var*
begin
//#UC START# *477118BE0229_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477118BE0229_4804BDA10127_impl*
end;//Tl3Tree.IsChildSelect

procedure Tl3Tree.Clear;
//#UC START# *477118C900E7_4804BDA10127_var*
//#UC END# *477118C900E7_4804BDA10127_var*
begin
//#UC START# *477118C900E7_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477118C900E7_4804BDA10127_impl*
end;//Tl3Tree.Clear

function Tl3Tree.MoveSelectedNodes(aDirection: Tl3Direction): Boolean;
 {* ���������� ���������� ���� }
//#UC START# *477118D20258_4804BDA10127_var*
//#UC END# *477118D20258_4804BDA10127_var*
begin
//#UC START# *477118D20258_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477118D20258_4804BDA10127_impl*
end;//Tl3Tree.MoveSelectedNodes

function Tl3Tree.DeleteSelectedNodes: Boolean;
 {* ������� ���������� ����, }
//#UC START# *477118E303A3_4804BDA10127_var*
//#UC END# *477118E303A3_4804BDA10127_var*
begin
//#UC START# *477118E303A3_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477118E303A3_4804BDA10127_impl*
end;//Tl3Tree.DeleteSelectedNodes

function Tl3Tree.Get_CNodes(Index: Integer): Il3Node;
//#UC START# *4771190501F8_4804BDA10127get_var*
//#UC END# *4771190501F8_4804BDA10127get_var*
begin
//#UC START# *4771190501F8_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771190501F8_4804BDA10127get_impl*
end;//Tl3Tree.Get_CNodes

function Tl3Tree.Get_SelectedNode(const Node: Il3Node): Boolean;
//#UC START# *477119460035_4804BDA10127get_var*
//#UC END# *477119460035_4804BDA10127get_var*
begin
//#UC START# *477119460035_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *477119460035_4804BDA10127get_impl*
end;//Tl3Tree.Get_SelectedNode

procedure Tl3Tree.Set_SelectedNode(const Node: Il3Node;
 aValue: Boolean);
//#UC START# *477119460035_4804BDA10127set_var*
//#UC END# *477119460035_4804BDA10127set_var*
begin
//#UC START# *477119460035_4804BDA10127set_impl*
 !!! Needs to be implemented !!!
//#UC END# *477119460035_4804BDA10127set_impl*
end;//Tl3Tree.Set_SelectedNode

function Tl3Tree.Get_NodeFlags(const Node: Il3Node): Integer;
//#UC START# *47711C11028E_4804BDA10127get_var*
//#UC END# *47711C11028E_4804BDA10127get_var*
begin
//#UC START# *47711C11028E_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711C11028E_4804BDA10127get_impl*
end;//Tl3Tree.Get_NodeFlags

procedure Tl3Tree.Set_NodeFlags(const Node: Il3Node;
 aValue: Integer);
//#UC START# *47711C11028E_4804BDA10127set_var*
//#UC END# *47711C11028E_4804BDA10127set_var*
begin
//#UC START# *47711C11028E_4804BDA10127set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711C11028E_4804BDA10127set_impl*
end;//Tl3Tree.Set_NodeFlags

function Tl3Tree.Get_CRootNode: Il3RootNode;
//#UC START# *47711C3D01EA_4804BDA10127get_var*
//#UC END# *47711C3D01EA_4804BDA10127get_var*
begin
//#UC START# *47711C3D01EA_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711C3D01EA_4804BDA10127get_impl*
end;//Tl3Tree.Get_CRootNode

procedure Tl3Tree.Set_CRootNode(const aValue: Il3RootNode);
//#UC START# *47711C3D01EA_4804BDA10127set_var*
//#UC END# *47711C3D01EA_4804BDA10127set_var*
begin
//#UC START# *47711C3D01EA_4804BDA10127set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711C3D01EA_4804BDA10127set_impl*
end;//Tl3Tree.Set_CRootNode

function Tl3Tree.Get_CommonExpanded: Boolean;
//#UC START# *47711C510141_4804BDA10127get_var*
//#UC END# *47711C510141_4804BDA10127get_var*
begin
//#UC START# *47711C510141_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711C510141_4804BDA10127get_impl*
end;//Tl3Tree.Get_CommonExpanded

procedure Tl3Tree.Set_CommonExpanded(aValue: Boolean);
//#UC START# *47711C510141_4804BDA10127set_var*
//#UC END# *47711C510141_4804BDA10127set_var*
begin
//#UC START# *47711C510141_4804BDA10127set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711C510141_4804BDA10127set_impl*
end;//Tl3Tree.Set_CommonExpanded

function Tl3Tree.Get_SelModifiedCount: Integer;
//#UC START# *47711C6C004D_4804BDA10127get_var*
//#UC END# *47711C6C004D_4804BDA10127get_var*
begin
//#UC START# *47711C6C004D_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711C6C004D_4804BDA10127get_impl*
end;//Tl3Tree.Get_SelModifiedCount

function Tl3Tree.Get_Modified: Boolean;
//#UC START# *47711C7D02D5_4804BDA10127get_var*
//#UC END# *47711C7D02D5_4804BDA10127get_var*
begin
//#UC START# *47711C7D02D5_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711C7D02D5_4804BDA10127get_impl*
end;//Tl3Tree.Get_Modified

procedure Tl3Tree.Set_Modified(aValue: Boolean);
//#UC START# *47711C7D02D5_4804BDA10127set_var*
//#UC END# *47711C7D02D5_4804BDA10127set_var*
begin
//#UC START# *47711C7D02D5_4804BDA10127set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711C7D02D5_4804BDA10127set_impl*
end;//Tl3Tree.Set_Modified

function Tl3Tree.Get_Strings(anIndex: Integer): PAnsiChar;
//#UC START# *47711CF10305_4804BDA10127get_var*
//#UC END# *47711CF10305_4804BDA10127get_var*
begin
//#UC START# *47711CF10305_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47711CF10305_4804BDA10127get_impl*
end;//Tl3Tree.Get_Strings

function Tl3Tree.Get_Tree: Il3Tree;
//#UC START# *477187FD0168_4804BDA10127get_var*
//#UC END# *477187FD0168_4804BDA10127get_var*
begin
//#UC START# *477187FD0168_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *477187FD0168_4804BDA10127get_impl*
end;//Tl3Tree.Get_Tree

procedure Tl3Tree.Set_Tree(const aValue: Il3Tree);
//#UC START# *477187FD0168_4804BDA10127set_var*
//#UC END# *477187FD0168_4804BDA10127set_var*
begin
//#UC START# *477187FD0168_4804BDA10127set_impl*
 !!! Needs to be implemented !!!
//#UC END# *477187FD0168_4804BDA10127set_impl*
end;//Tl3Tree.Set_Tree

function Tl3Tree.GetNextSelect(const aCurNode: Il3Node): Il3Node;
//#UC START# *4771927702DF_4804BDA10127_var*
//#UC END# *4771927702DF_4804BDA10127_var*
begin
//#UC START# *4771927702DF_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771927702DF_4804BDA10127_impl*
end;//Tl3Tree.GetNextSelect

procedure Tl3Tree.Notify(aOperation: Integer;
 const aNode: Il3SimpleNode);
 {* ������ ��������. }
//#UC START# *477244190062_4804BDA10127_var*
//#UC END# *477244190062_4804BDA10127_var*
begin
//#UC START# *477244190062_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477244190062_4804BDA10127_impl*
end;//Tl3Tree.Notify

procedure Tl3Tree.CursorTop;
 {* ����������� ������ �� ������ ������� �������. }
//#UC START# *4772448C01D2_4804BDA10127_var*
//#UC END# *4772448C01D2_4804BDA10127_var*
begin
//#UC START# *4772448C01D2_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4772448C01D2_4804BDA10127_impl*
end;//Tl3Tree.CursorTop

function Tl3Tree.GetIndex(const aNode: Il3SimpleNode;
 const aSubRootNode: Il3SimpleNode = nil): Integer;
 {* ���������� ������� ������ aNode ������������ aSubRootNode ��� �����. }
//#UC START# *4772449B00A1_4804BDA10127_var*
//#UC END# *4772449B00A1_4804BDA10127_var*
begin
//#UC START# *4772449B00A1_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4772449B00A1_4804BDA10127_impl*
end;//Tl3Tree.GetIndex

function Tl3Tree.GetLevel(const aNode: Il3SimpleNode): Integer;
 {* ���������� ������� ���� ������������ �����. }
//#UC START# *477244BA0074_4804BDA10127_var*
//#UC END# *477244BA0074_4804BDA10127_var*
begin
//#UC START# *477244BA0074_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477244BA0074_4804BDA10127_impl*
end;//Tl3Tree.GetLevel

procedure Tl3Tree.SelectAllNodes(aMode: Tl3SetBitType);
 {* ��������/����������� ��� ����. }
//#UC START# *477244CE02AE_4804BDA10127_var*
//#UC END# *477244CE02AE_4804BDA10127_var*
begin
//#UC START# *477244CE02AE_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477244CE02AE_4804BDA10127_impl*
end;//Tl3Tree.SelectAllNodes

procedure Tl3Tree.SelectInterval(aFirstIndex: Integer;
 aLastIndex: Integer;
 aMode: Tl3SetBitType;
 aCleanOther: Boolean);
 {* ��������/����������� ���� �� ��������� ���������. }
//#UC START# *477244DD0292_4804BDA10127_var*
//#UC END# *477244DD0292_4804BDA10127_var*
begin
//#UC START# *477244DD0292_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477244DD0292_4804BDA10127_impl*
end;//Tl3Tree.SelectInterval

function Tl3Tree.ChangeExpand(const aNode: Il3SimpleNode;
 aMode: Tl3SetBitType;
 aForceMode: Boolean = False): Boolean;
 {* ������ ������������� ����. }
//#UC START# *47724512002D_4804BDA10127_var*
//#UC END# *47724512002D_4804BDA10127_var*
begin
//#UC START# *47724512002D_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *47724512002D_4804BDA10127_impl*
end;//Tl3Tree.ChangeExpand

procedure Tl3Tree.ExpandSubDir(const aNode: Il3SimpleNode = nil;
 anExpand: Boolean = True;
 aDeepLevel: Byte = 0);
 {* ����������/�������� ����. }
//#UC START# *4772452E002D_4804BDA10127_var*
//#UC END# *4772452E002D_4804BDA10127_var*
begin
//#UC START# *4772452E002D_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4772452E002D_4804BDA10127_impl*
end;//Tl3Tree.ExpandSubDir

procedure Tl3Tree.SetBranchFlag(const aParentNode: Il3SimpleNode;
 aMode: Tl3SetBitType;
 aFlagsMask: Integer;
 anIterMode: Integer);
 {* �����-�� ������������ ��������� � ExpandNode. }
//#UC START# *477245520298_4804BDA10127_var*
//#UC END# *477245520298_4804BDA10127_var*
begin
//#UC START# *477245520298_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477245520298_4804BDA10127_impl*
end;//Tl3Tree.SetBranchFlag

function Tl3Tree.CountViewItemsInSubDir(const aNode: Il3SimpleNode): Integer;
 {* �����-�� ������������ ��������� � ShowMoreChildrenOnScreen. }
//#UC START# *4772457D032A_4804BDA10127_var*
//#UC END# *4772457D032A_4804BDA10127_var*
begin
//#UC START# *4772457D032A_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4772457D032A_4804BDA10127_impl*
end;//Tl3Tree.CountViewItemsInSubDir

function Tl3Tree.IsRoot(const aNode: Il3SimpleNode): Boolean;
 {* �������� �� ���� �������� ��� ������. }
//#UC START# *477245A20228_4804BDA10127_var*
//#UC END# *477245A20228_4804BDA10127_var*
begin
//#UC START# *477245A20228_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477245A20228_4804BDA10127_impl*
end;//Tl3Tree.IsRoot

function Tl3Tree.IsExpanded(const aNode: Il3SimpleNode): Boolean;
 {* ������� �� ����. }
//#UC START# *477245B301DE_4804BDA10127_var*
//#UC END# *477245B301DE_4804BDA10127_var*
begin
//#UC START# *477245B301DE_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477245B301DE_4804BDA10127_impl*
end;//Tl3Tree.IsExpanded

function Tl3Tree.IsFirstVis(const aNode: Il3SimpleNode): Boolean;
 {* �������� �� ���� ������ ������� � �����. }
//#UC START# *477245C40171_4804BDA10127_var*
//#UC END# *477245C40171_4804BDA10127_var*
begin
//#UC START# *477245C40171_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477245C40171_4804BDA10127_impl*
end;//Tl3Tree.IsFirstVis

function Tl3Tree.IsLastVis(const aNode: Il3SimpleNode): Boolean;
 {* �������� �� ���� ��������� ������� � �����. }
//#UC START# *477245D9031B_4804BDA10127_var*
//#UC END# *477245D9031B_4804BDA10127_var*
begin
//#UC START# *477245D9031B_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477245D9031B_4804BDA10127_impl*
end;//Tl3Tree.IsLastVis

function Tl3Tree.HasVisibleChildren(const aNode: Il3SimpleNode): Boolean;
 {* ���� �� ������� ���� � aNode. }
//#UC START# *477245F301AE_4804BDA10127_var*
//#UC END# *477245F301AE_4804BDA10127_var*
begin
//#UC START# *477245F301AE_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477245F301AE_4804BDA10127_impl*
end;//Tl3Tree.HasVisibleChildren

function Tl3Tree.GetLines(const aNode: Il3SimpleNode): Integer;
 {* ����� ��� ��������� ����� (���� �������� ����������). }
//#UC START# *477246040221_4804BDA10127_var*
//#UC END# *477246040221_4804BDA10127_var*
begin
//#UC START# *477246040221_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477246040221_4804BDA10127_impl*
end;//Tl3Tree.GetLines

function Tl3Tree.Wake: Boolean;
 {* ��������!!! ���� ������ ��������. }
//#UC START# *4772461601C6_4804BDA10127_var*
//#UC END# *4772461601C6_4804BDA10127_var*
begin
//#UC START# *4772461601C6_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4772461601C6_4804BDA10127_impl*
end;//Tl3Tree.Wake

function Tl3Tree.MoveNode(const aNode: Il3SimpleNode;
 aDirection: Tl3Direction): Boolean;
 {* ����������� ����. }
//#UC START# *477246270133_4804BDA10127_var*
//#UC END# *477246270133_4804BDA10127_var*
begin
//#UC START# *477246270133_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477246270133_4804BDA10127_impl*
end;//Tl3Tree.MoveNode

function Tl3Tree.SearchNameBegin(const aFirstNode: Il3SimpleNode;
 aSrchStr: PAnsiChar;
 aIterMode: Integer): Il3SimpleNode;
 {* �����-�� ������������ ��������� � CharToItem. }
//#UC START# *477246440037_4804BDA10127_var*
//#UC END# *477246440037_4804BDA10127_var*
begin
//#UC START# *477246440037_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477246440037_4804BDA10127_impl*
end;//Tl3Tree.SearchNameBegin

function Tl3Tree.SearchNameOccur(const aFirstNode: Il3SimpleNode;
 aSrchStr: PAnsiChar;
 aIterMode: Integer): Il3SimpleNode;
 {* �����-�� ������������ ��������� � SearchOccurStr,  ������� ������ ����� �� ������������. }
//#UC START# *4772465F0276_4804BDA10127_var*
//#UC END# *4772465F0276_4804BDA10127_var*
begin
//#UC START# *4772465F0276_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4772465F0276_4804BDA10127_impl*
end;//Tl3Tree.SearchNameOccur

function Tl3Tree.MakeNodeVisible(const aNode: Il3SimpleNode): Integer;
 {* �����-�� ������������ ��������� � CharToItem, ������ ��� ����������� ������� �� ����. }
//#UC START# *477246860169_4804BDA10127_var*
//#UC END# *477246860169_4804BDA10127_var*
begin
//#UC START# *477246860169_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477246860169_4804BDA10127_impl*
end;//Tl3Tree.MakeNodeVisible

function Tl3Tree.GetPrev(const aNode: Il3SimpleNode): Il3SimpleNode;
 {* ���������� ����. �����-�� ������������ � CharToItem. }
//#UC START# *477246A40174_4804BDA10127_var*
//#UC END# *477246A40174_4804BDA10127_var*
begin
//#UC START# *477246A40174_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477246A40174_4804BDA10127_impl*
end;//Tl3Tree.GetPrev

function Tl3Tree.SimpleIterateF(Action: Tl3SimpleNodeAction;
 IterMode: Integer = 0;
 const aSubRootNode: Il3SimpleNode = nil): Il3SimpleNode;
 {* ��������� ��� ���� � ���������� �������� ��� Action. IterMode: imCheckResult, imParentNeed }
//#UC START# *477246C70141_4804BDA10127_var*
//#UC END# *477246C70141_4804BDA10127_var*
begin
//#UC START# *477246C70141_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477246C70141_4804BDA10127_impl*
end;//Tl3Tree.SimpleIterateF

function Tl3Tree.IsChanging: Boolean;
 {* ������ ��������� � ���� ����������. }
//#UC START# *477246E802B1_4804BDA10127_var*
//#UC END# *477246E802B1_4804BDA10127_var*
begin
//#UC START# *477246E802B1_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477246E802B1_4804BDA10127_impl*
end;//Tl3Tree.IsChanging

procedure Tl3Tree.Changing;
//#UC START# *477246F7039B_4804BDA10127_var*
//#UC END# *477246F7039B_4804BDA10127_var*
begin
//#UC START# *477246F7039B_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *477246F7039B_4804BDA10127_impl*
end;//Tl3Tree.Changing

procedure Tl3Tree.Changed;
//#UC START# *4772470100BC_4804BDA10127_var*
//#UC END# *4772470100BC_4804BDA10127_var*
begin
//#UC START# *4772470100BC_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4772470100BC_4804BDA10127_impl*
end;//Tl3Tree.Changed

function Tl3Tree.Get_ShowRoot: Boolean;
//#UC START# *477248FE005A_4804BDA10127get_var*
//#UC END# *477248FE005A_4804BDA10127get_var*
begin
//#UC START# *477248FE005A_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *477248FE005A_4804BDA10127get_impl*
end;//Tl3Tree.Get_ShowRoot

procedure Tl3Tree.Set_ShowRoot(aValue: Boolean);
//#UC START# *477248FE005A_4804BDA10127set_var*
//#UC END# *477248FE005A_4804BDA10127set_var*
begin
//#UC START# *477248FE005A_4804BDA10127set_impl*
 !!! Needs to be implemented !!!
//#UC END# *477248FE005A_4804BDA10127set_impl*
end;//Tl3Tree.Set_ShowRoot

function Tl3Tree.Get_CountView: Integer;
//#UC START# *4772490E02F7_4804BDA10127get_var*
//#UC END# *4772490E02F7_4804BDA10127get_var*
begin
//#UC START# *4772490E02F7_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4772490E02F7_4804BDA10127get_impl*
end;//Tl3Tree.Get_CountView

function Tl3Tree.Get_SelectCount: Integer;
//#UC START# *4772491C01C5_4804BDA10127get_var*
//#UC END# *4772491C01C5_4804BDA10127get_var*
begin
//#UC START# *4772491C01C5_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4772491C01C5_4804BDA10127get_impl*
end;//Tl3Tree.Get_SelectCount

function Tl3Tree.Get_Flags(anIndex: Integer): Integer;
//#UC START# *4772495902EE_4804BDA10127get_var*
//#UC END# *4772495902EE_4804BDA10127get_var*
begin
//#UC START# *4772495902EE_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4772495902EE_4804BDA10127get_impl*
end;//Tl3Tree.Get_Flags

function Tl3Tree.Get_Select(anIndex: Integer): Boolean;
//#UC START# *477249AB0057_4804BDA10127get_var*
//#UC END# *477249AB0057_4804BDA10127get_var*
begin
//#UC START# *477249AB0057_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *477249AB0057_4804BDA10127get_impl*
end;//Tl3Tree.Get_Select

procedure Tl3Tree.Set_Select(anIndex: Integer;
 aValue: Boolean);
//#UC START# *477249AB0057_4804BDA10127set_var*
//#UC END# *477249AB0057_4804BDA10127set_var*
begin
//#UC START# *477249AB0057_4804BDA10127set_impl*
 !!! Needs to be implemented !!!
//#UC END# *477249AB0057_4804BDA10127set_impl*
end;//Tl3Tree.Set_Select

function Tl3Tree.Get_Nodes(anIndex: Integer): Il3SimpleNode;
//#UC START# *477249EB02D9_4804BDA10127get_var*
//#UC END# *477249EB02D9_4804BDA10127get_var*
begin
//#UC START# *477249EB02D9_4804BDA10127get_impl*
 !!! Needs to be implemented !!!
//#UC END# *477249EB02D9_4804BDA10127get_impl*
end;//Tl3Tree.Get_Nodes

function Tl3Tree.MakeDataObject(const aNode: Il3SimpleNode;
 const aBitmap: IUnknown): IDataObject;
 {* ������� ������ ������ ������, ������������ ��� ����������� ��������� ������ � ������ ���������� }
//#UC START# *47A86EA80292_4804BDA10127_var*
//#UC END# *47A86EA80292_4804BDA10127_var*
begin
//#UC START# *47A86EA80292_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A86EA80292_4804BDA10127_impl*
end;//Tl3Tree.MakeDataObject

function Tl3Tree.CanAcceptData(const aTargetNode: Il3SimpleNode;
 const aData: Tl3TreeData): Boolean;
//#UC START# *47BAD3080349_4804BDA10127_var*
//#UC END# *47BAD3080349_4804BDA10127_var*
begin
//#UC START# *47BAD3080349_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *47BAD3080349_4804BDA10127_impl*
end;//Tl3Tree.CanAcceptData

function Tl3Tree.DropData(const aTargetNode: Il3SimpleNode;
 const aData: Tl3TreeData): Boolean;
//#UC START# *47BAD32501E2_4804BDA10127_var*
//#UC END# *47BAD32501E2_4804BDA10127_var*
begin
//#UC START# *47BAD32501E2_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *47BAD32501E2_4804BDA10127_impl*
end;//Tl3Tree.DropData

procedure Tl3Tree.ClearSelected;
//#UC START# *4FDB205C023B_4804BDA10127_var*
//#UC END# *4FDB205C023B_4804BDA10127_var*
begin
//#UC START# *4FDB205C023B_4804BDA10127_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FDB205C023B_4804BDA10127_impl*
end;//Tl3Tree.ClearSelected

procedure Tl3Tree.ClearFields;
begin
 f_CurrentNode := nil;
 inherited;
end;//Tl3Tree.ClearFields

end.
