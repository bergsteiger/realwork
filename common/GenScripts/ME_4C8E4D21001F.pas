unit PrimCustomizeTasksPanel_Form;

interface

uses
 l3IntfUses
 , vcmEntityForm
 , vcmTaskPanelInterfaces
 , vtCtrls
 , vtPanel
 , vtLabel
 , vtButton
 , vtGroupBox
 , eeTreeView
 , eeButton
 , StdCtrls
 , Buttons
 , eeCheckBox
 , l3Tree_TLB
 , vcmInterfaces
 , l3Interfaces
 , l3TreeInterfaces
 , l3NodesModelPart
 , l3Types
 , l3IID
 , l3Tree
;

type
 TtpState = (
  {* ��������� ���� }
  sNone
  , sNew
  , sChanged
  , sDeleted
 );//TtpState
 
 TPrimCustomizeTasksPanelForm = class(TvcmEntityForm)
  {* �������� ������ ����� }
  procedure Make(const aPanel: IvcmCustOps);
   {* ������� }
  procedure tvRepOpsGetItemImage;
  procedure cbGroupNameChange(Sender: TObject);
  procedure btnAddGroupClick(Sender: TObject);
  procedure btnChangeGroupClick(Sender: TObject);
  procedure tvRepGroupsCurrentChanged;
  procedure btnDeleteGroupClick(Sender: TObject);
  procedure btOkClick(Sender: TObject);
  procedure btApplyClick(Sender: TObject);
  procedure btnMoveGroupToPanelClick(Sender: TObject);
  procedure tvRepOpsCurrentChanged;
  procedure tvTasksPanelCurrentChanged;
  procedure btnMoveOpToPanelClick(Sender: TObject);
  procedure tvTasksPanelGetItemImage;
  procedure btnChangeItemClick(Sender: TObject);
  procedure btnMoveGroupToRepClick(Sender: TObject);
  procedure btnMoveOpToRepClick(Sender: TObject);
  procedure cbForAllUseCasesClick(Sender: TObject);
  procedure UpBitBtnClick(Sender: TObject);
  procedure DownBitBtnClick(Sender: TObject);
  procedure cbFormsChange(Sender: TObject);
  procedure UpdateState;
  procedure Save;
  function FindRepGroupOps(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node;
  procedure UpdateControls;
  procedure MoveTasksPanelItem(aUp: Boolean;
   const aNewParent: Il3Node);
  procedure UpdatePositions(const aParent: Il3Node);
  procedure RemoveGroup(const aGroup: Il3Node);
   {* ������� ������ ������ ����� }
  procedure RemoveNode(const aNode: Il3Node);
   {* ������� ���� ������ �����, ��� ������������ �������� ��� ��� ������ }
  procedure DeleteOp(const aNode: Il3Node);
   {* ������� �������� ������ ����� }
  procedure ReturnRepOp(const aRepOp: IvcmCustOpsRepOperation);
   {* ������� �������� � ����������� }
  function GetSelectedUserType: IvcmUserTypeDef;
  function vcmComparePostions(const aNode1: Il3Node;
   const aNode2: Il3Node): Integer;
 end;//TPrimCustomizeTasksPanelForm
 
implementation

uses
 l3ImplUses
 , CustomizeTasksPanelRes
 , TtfwClassRef_Proxy
;

type
 ItpBaseNode = interface(Il3Node)
  {* ������� ���� ������ }
  procedure Save;
   {* ��������� ��������� }
 end;//ItpBaseNode
 
 ItpRepGroupNode = interface(ItpBaseNode)
  {* ���� ����������� ����� }
 end;//ItpRepGroupNode
 
 ItpTasksPanelNode = interface(ItpBaseNode)
  {* ���� ������ ����� }
 end;//ItpTasksPanelNode
 
 ItpGroup = interface(ItpTasksPanelNode)
  {* ������ ������ ����� }
 end;//ItpGroup
 
 ItpGroupOperation = interface(ItpTasksPanelNode)
 end;//ItpGroupOperation
 
 ItpRepGroupOperationsNode = interface(ItpBaseNode)
  {* ������ ����������� }
 end;//ItpRepGroupOperationsNode
 
 ItpRepOperationNode = interface(ItpBaseNode)
 end;//ItpRepOperationNode
 
 ItpTree = interface(Il3SimpleTree)
  {* ���������� ������ ����� }
  procedure Save;
 end;//ItpTree
 
 TvcmBaseNode = class(Tl3UsualNode, ItpBaseNode)
  procedure DoSave;
  procedure Create;
  procedure Remove;
   {* ������� ���� �� ������. }
  function AllChildrenCount: Integer;
   {* ����� �������� ���������, ������� ��� ���������. }
  function NextNode: Il3Node;
   {* ��������� ���� ���� �� ������. }
  function PrevNode: Il3Node;
   {* ���������� ���� ���� �� ������. }
  function ParentNode: Il3Node;
   {* ������������ ����. }
  function ChildNode: Il3Node;
   {* ������ �������� �������. }
  function State: TtpState;
  procedure Save;
   {* ��������� ��������� }
 end;//TvcmBaseNode
 
 TvcmCustOpsRootNode = class(Tl3RootNode)
  procedure Remove;
   {* ������� ���� �� ������. }
  function AllChildrenCount: Integer;
   {* ����� �������� ���������, ������� ��� ���������. }
  function NextNode: Il3Node;
   {* ��������� ���� ���� �� ������. }
  function PrevNode: Il3Node;
   {* ���������� ���� ���� �� ������. }
  function ParentNode: Il3Node;
   {* ������������ ����. }
  function ChildNode: Il3Node;
   {* ������ �������� �������. }
 end;//TvcmCustOpsRootNode
 
 TvcmCustOpsNode = class(TvcmBaseNode, ItpTasksPanelNode)
  procedure DoSetPosition(aValue: Integer);
  function Position: Integer;
   {* ������� �������� }
 end;//TvcmCustOpsNode
 
 TvcmGroup = class(TvcmCustOpsNode, ItpGroup)
  {* ������ ������ ����� }
  procedure LoadOps;
  procedure Create(const aGroup: IvcmCustOpsGroup); overload;
  function Make(const aGroup: IvcmCustOpsGroup): Il3Node; overload;
  procedure Create(const aText: Tl3PCharLenPrim;
   const aRepGroup: IvcmCustOpsRepGroup); overload;
  function Make(const aText: Tl3PCharLenPrim;
   const aRepGroup: IvcmCustOpsRepGroup): Il3Node; overload;
  function RepGroup: IvcmCustOpsRepGroup;
  function Group: IvcmCustOpsGroup;
  procedure DoSetPosition(aValue: Integer);
 end;//TvcmGroup
 
 TvcmGroupOperation = class(TvcmCustOpsNode, ItpGroupOperation)
  procedure Create(const aOp: IvcmCustOpsGroupOperation); overload;
  procedure Create(const aRepOp: IvcmCustOpsRepOperation); overload;
  function Make(const aOp: IvcmCustOpsGroupOperation): Il3Node; overload;
  function Make(const aRepOp: IvcmCustOpsRepOperation): Il3Node; overload;
  function Op: IvcmCustOpsGroupOperation;
  function RepOp: IvcmCustOpsRepOperation;
  function ForAllUseCases: Boolean;
   {* ������ ���������� � ������ ��� ������� �������� }
  function GroupChanged: Boolean;
  procedure DoSetPosition(aValue: Integer);
 end;//TvcmGroupOperation
 
 TvcmRepGroupOperationsNode = class(TvcmBaseNode, ItpRepGroupOperationsNode)
  procedure Create(const aGroup: IvcmCustOpsRepGroupOperations);
  function Make(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node;
  function Group: IvcmCustOpsRepGroupOperations;
 end;//TvcmRepGroupOperationsNode
 
 TvcmRepOperationNode = class(TvcmBaseNode, ItpRepOperationNode)
  procedure Create(const aOp: IvcmCustOpsRepOperation);
  function Make(const aOp: IvcmCustOpsRepOperation): Il3Node;
  function Op: IvcmCustOpsRepOperation;
 end;//TvcmRepOperationNode
 
 TvcmTree = class(Tl3Tree)
  procedure Save;
 end;//TvcmTree
 
 TvcmCustOpsTree = class(TvcmTree)
  procedure LoadGroups;
 end;//TvcmCustOpsTree
 
 TvcmRepTree = class(TvcmTree)
  procedure ReadRepGroups;
   {* ��������� ������ ����������� }
  procedure ReadRepGroup(const aGroup: IvcmCustOpsRepGroupOperations;
   const aGroupNode: Il3Node);
 end;//TvcmRepTree
 
 TvcmRepGroupsTree = class(TvcmTree)
 end;//TvcmRepGroupsTree
 
 TvcmRepGroupNode = class(TvcmBaseNode, ItpRepGroupNode)
  procedure Create(const aCaption: Tl3PCharLenPrim;
   const aRepGroup: IvcmCustOpsRepGroup);
  function Make(const aCaption: Tl3PCharLenPrim;
   const aRepGroup: IvcmCustOpsRepGroup): Il3Node;
  function RepGroup: IvcmCustOpsRepGroup;
 end;//TvcmRepGroupNode
 
end.
