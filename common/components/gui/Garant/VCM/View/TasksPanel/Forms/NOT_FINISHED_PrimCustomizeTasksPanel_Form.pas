unit NOT_FINISHED_PrimCustomizeTasksPanel_Form;
 {* �������� ������ ����� }

// ������: "w:\common\components\gui\Garant\VCM\View\TasksPanel\Forms\NOT_FINISHED_PrimCustomizeTasksPanel_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimCustomizeTasksPanel" MUID: (4C8E4D21001F)
// ��� ����: "TPrimCustomizeTasksPanelForm"

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If NOT Defined(NoVCM)}
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
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Buttons
 {$IfEnd} // NOT Defined(NoVCL)
 , eeCheckBox
 , vcmInterfaces
 , l3Tree_TLB
 , l3Interfaces
 , l3TreeInterfaces
 , l3NodesModelPart
 , l3Types
 , l3IID
 , l3Tree
 , vcmExternalInterfaces
;

type
 TtpState = (
  {* ��������� ���� }
  sNone
  , sNew
  , sChanged
  , sDeleted
 );//TtpState

 TPrimCustomizeTasksPanelForm = class;

 ItpBaseNode = interface(Il3Node)
  {* ������� ���� ������ }
  ['{316EBEA8-258F-4BA9-8C9C-315CC00EE294}']
  function pm_GetState: TtpState;
  procedure pm_SetState(aValue: TtpState);
  procedure Save;
   {* ��������� ��������� }
  property State: TtpState
   read pm_GetState
   write pm_SetState;
 end;//ItpBaseNode

 ItpRepGroupNode = interface(ItpBaseNode)
  {* ���� ����������� ����� }
  ['{07E387B8-2DC6-4170-BA75-7EB4685ADFA1}']
  function Get_RepGroup: IvcmCustOpsRepGroup;
  procedure Set_RepGroup(const aValue: IvcmCustOpsRepGroup);
  property RepGroup: IvcmCustOpsRepGroup
   read Get_RepGroup
   write Set_RepGroup;
 end;//ItpRepGroupNode

 ItpTasksPanelNode = interface(ItpBaseNode)
  {* ���� ������ ����� }
  ['{2E263AEA-CDF1-4F37-AD18-DFFB9FCB1470}']
  function pm_GetPosition: Integer;
  procedure pm_SetPosition(aValue: Integer);
  property Position: Integer
   read pm_GetPosition
   write pm_SetPosition;
   {* ������� �������� }
 end;//ItpTasksPanelNode

 ItpGroup = interface(ItpTasksPanelNode)
  {* ������ ������ ����� }
  ['{BECD8B95-0021-4CED-BB78-50B1E85B2941}']
  function pm_GetRepGroup: IvcmCustOpsRepGroup;
  procedure pm_SetRepGroup(const aValue: IvcmCustOpsRepGroup);
  function pm_GetGroup: IvcmCustOpsGroup;
  procedure pm_SetGroup(const aValue: IvcmCustOpsGroup);
  property RepGroup: IvcmCustOpsRepGroup
   read pm_GetRepGroup
   write pm_SetRepGroup;
  property Group: IvcmCustOpsGroup
   read pm_GetGroup
   write pm_SetGroup;
 end;//ItpGroup

 ItpGroupOperation = interface(ItpTasksPanelNode)
  ['{C1668D24-8965-49AE-98EB-B1BE886AF588}']
  function pm_GetOp: IvcmCustOpsGroupOperation;
  procedure pm_SetOp(const aValue: IvcmCustOpsGroupOperation);
  function pm_GetRepOp: IvcmCustOpsRepOperation;
  procedure pm_SetRepOp(const aValue: IvcmCustOpsRepOperation);
  function pm_GetForAllUseCases: Boolean;
  procedure pm_SetForAllUseCases(aValue: Boolean);
  function pm_GetGroupChanged: Boolean;
  procedure pm_SetGroupChanged(aValue: Boolean);
  property Op: IvcmCustOpsGroupOperation
   read pm_GetOp
   write pm_SetOp;
  property RepOp: IvcmCustOpsRepOperation
   read pm_GetRepOp
   write pm_SetRepOp;
  property ForAllUseCases: Boolean
   read pm_GetForAllUseCases
   write pm_SetForAllUseCases;
   {* ������ ���������� � ������ ��� ������� �������� }
  property GroupChanged: Boolean
   read pm_GetGroupChanged
   write pm_SetGroupChanged;
 end;//ItpGroupOperation

 ItpRepGroupOperationsNode = interface(ItpBaseNode)
  {* ������ ����������� }
  ['{52E01144-72A4-4233-A459-18F530704F1F}']
  function pm_GetGroup: IvcmCustOpsRepGroupOperations;
  property Group: IvcmCustOpsRepGroupOperations
   read pm_GetGroup;
 end;//ItpRepGroupOperationsNode

 ItpRepOperationNode = interface(ItpBaseNode)
  ['{FAFFA0AB-E97B-4D96-958A-11621C2E37D7}']
  function pm_GetOp: IvcmCustOpsRepOperation;
  property Op: IvcmCustOpsRepOperation
   read pm_GetOp;
 end;//ItpRepOperationNode

 ItpTree = interface(Il3SimpleTree)
  {* ���������� ������ ����� }
  ['{8AE49184-028C-4160-A01A-89C7A17C9413}']
  procedure Save;
 end;//ItpTree

 TvcmBaseNode = class(Tl3UsualNode, ItpBaseNode)
  private
   f_State: TtpState;
    {* ���� ��� �������� State }
  protected
   procedure DoSave; virtual;
   procedure Remove;
    {* ������� ���� �� ������. }
   function Get_AllChildrenCount: Integer;
   function Get_NextNode: Il3Node;
   function Get_PrevNode: Il3Node;
   function Get_ParentNode: Il3Node;
   function Get_ChildNode: Il3Node;
   function pm_GetState: TtpState;
   procedure pm_SetState(aValue: TtpState);
   procedure Save;
    {* ��������� ��������� }
  public
   constructor Create; reintroduce;
  protected
   property State: TtpState
    read pm_GetState
    write pm_SetState;
 end;//TvcmBaseNode

 TvcmCustOpsRootNode = class(Tl3RootNode)
  protected
   procedure Remove;
    {* ������� ���� �� ������. }
   function Get_AllChildrenCount: Integer;
   function Get_NextNode: Il3Node;
   function Get_PrevNode: Il3Node;
   function Get_ParentNode: Il3Node;
   function Get_ChildNode: Il3Node;
 end;//TvcmCustOpsRootNode

 TvcmCustOpsNode = class(TvcmBaseNode, ItpTasksPanelNode)
  private
   f_Position: Integer;
    {* ���� ��� �������� Position }
  private
   procedure DoSetPosition(aValue: Integer); virtual; abstract;
  protected
   function pm_GetPosition: Integer;
   procedure pm_SetPosition(aValue: Integer);
  protected
   property Position: Integer
    read pm_GetPosition
    write pm_SetPosition;
 end;//TvcmCustOpsNode

 TvcmGroup = class(TvcmCustOpsNode, ItpGroup)
  {* ������ ������ ����� }
  private
   f_Group: IvcmCustOpsGroup;
    {* ���� ��� �������� Group }
   f_RepGroup: IvcmCustOpsRepGroup;
    {* ���� ��� �������� RepGroup }
  private
   procedure LoadOps;
  protected
   function pm_GetRepGroup: IvcmCustOpsRepGroup;
   procedure pm_SetRepGroup(const aValue: IvcmCustOpsRepGroup);
   function pm_GetGroup: IvcmCustOpsGroup;
   procedure pm_SetGroup(const aValue: IvcmCustOpsGroup);
   procedure DoSetPosition(aValue: Integer); override;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
   procedure ClearFields; override;
   procedure DoSave; override;
  public
   constructor Create(const aGroup: IvcmCustOpsGroup); reintroduce; overload;
   class function Make(const aGroup: IvcmCustOpsGroup): Il3Node; reintroduce; overload;
   constructor Create(const aText: Tl3PCharLenPrim;
    const aRepGroup: IvcmCustOpsRepGroup); reintroduce; overload;
   class function Make(const aText: Tl3PCharLenPrim;
    const aRepGroup: IvcmCustOpsRepGroup): Il3Node; reintroduce; overload;
  protected
   property Group: IvcmCustOpsGroup
    read f_Group;
   property RepGroup: IvcmCustOpsRepGroup
    read f_RepGroup;
 end;//TvcmGroup

 TvcmGroupOperation = class(TvcmCustOpsNode, ItpGroupOperation)
  private
   f_Op: IvcmCustOpsGroupOperation;
    {* ���� ��� �������� Op }
   f_RepOp: IvcmCustOpsRepOperation;
    {* ���� ��� �������� RepOp }
   f_ForAllUseCases: Boolean;
    {* ���� ��� �������� ForAllUseCases }
   f_GroupChanged: Boolean;
    {* ���� ��� �������� GroupChanged }
  protected
   function pm_GetGroup: ItpGroup;
   function pm_GetOp: IvcmCustOpsGroupOperation;
   procedure pm_SetOp(const aValue: IvcmCustOpsGroupOperation);
   function pm_GetRepOp: IvcmCustOpsRepOperation;
   procedure pm_SetRepOp(const aValue: IvcmCustOpsRepOperation);
   function pm_GetForAllUseCases: Boolean;
   procedure pm_SetForAllUseCases(aValue: Boolean);
   function pm_GetGroupChanged: Boolean;
   procedure pm_SetGroupChanged(aValue: Boolean);
   procedure DoSetPosition(aValue: Integer); override;
   procedure InitFields; override;
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* ���������� ������� ���������� }
   procedure ClearFields; override;
   procedure DoSave; override;
  public
   constructor Create(const aOp: IvcmCustOpsGroupOperation); reintroduce; overload;
   constructor Create(const aRepOp: IvcmCustOpsRepOperation); reintroduce; overload;
   class function Make(const aOp: IvcmCustOpsGroupOperation): Il3Node; reintroduce; overload;
   class function Make(const aRepOp: IvcmCustOpsRepOperation): Il3Node; reintroduce; overload;
  protected
   property Op: IvcmCustOpsGroupOperation
    read f_Op
    write f_Op;
   property RepOp: IvcmCustOpsRepOperation
    read f_RepOp
    write f_RepOp;
   property ForAllUseCases: Boolean
    read pm_GetForAllUseCases
    write pm_SetForAllUseCases;
   property GroupChanged: Boolean
    read pm_GetGroupChanged
    write pm_SetGroupChanged;
   property Group: ItpGroup
    read pm_GetGroup;
 end;//TvcmGroupOperation

 TvcmRepGroupOperationsNode = {final} class(TvcmBaseNode, ItpRepGroupOperationsNode)
  private
   f_Group: IvcmCustOpsRepGroupOperations;
    {* ���� ��� �������� Group }
  protected
   function pm_GetGroup: IvcmCustOpsRepGroupOperations;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure ClearFields; override;
  public
   constructor Create(const aGroup: IvcmCustOpsRepGroupOperations); reintroduce;
   class function Make(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node; reintroduce;
  protected
   property Group: IvcmCustOpsRepGroupOperations
    read f_Group;
 end;//TvcmRepGroupOperationsNode

 TvcmRepOperationNode = class(TvcmBaseNode, ItpRepOperationNode)
  private
   f_Op: IvcmCustOpsRepOperation;
    {* ���� ��� �������� Op }
  protected
   function pm_GetOp: IvcmCustOpsRepOperation;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure ClearFields; override;
  public
   constructor Create(const aOp: IvcmCustOpsRepOperation); reintroduce;
   class function Make(const aOp: IvcmCustOpsRepOperation): Il3Node; reintroduce;
  protected
   property Op: IvcmCustOpsRepOperation
    read f_Op;
 end;//TvcmRepOperationNode

 TvcmTree = class(Tl3Tree)
  protected
   procedure Save;
 end;//TvcmTree

 TvcmCustOpsTree = class(TvcmTree)
  private
   procedure LoadGroups;
  protected
   procedure InitFields; override;
 end;//TvcmCustOpsTree

 TvcmRepTree = class(TvcmTree)
  private
   procedure ReadRepGroups;
    {* ��������� ������ ����������� }
   procedure ReadRepGroup(const aGroup: IvcmCustOpsRepGroupOperations;
    const aGroupNode: Il3Node);
  protected
   procedure InitFields; override;
 end;//TvcmRepTree

 TvcmRepGroupsTree = class(TvcmTree)
  protected
   procedure InitFields; override;
 end;//TvcmRepGroupsTree

 TvcmRepGroupNode = class(TvcmBaseNode, ItpRepGroupNode)
  private
   f_RepGroup: IvcmCustOpsRepGroup;
    {* ���� ��� �������� RepGroup }
  protected
   function Get_RepGroup: IvcmCustOpsRepGroup;
   procedure Set_RepGroup(const aValue: IvcmCustOpsRepGroup);
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure DoSetAsPCharLen(const Value: Tl3PCharLen); override;
   procedure ClearFields; override;
   procedure DoSave; override;
  public
   constructor Create(const aCaption: Tl3PCharLenPrim;
    const aRepGroup: IvcmCustOpsRepGroup = nil); reintroduce;
   class function Make(const aCaption: Tl3PCharLenPrim;
    const aRepGroup: IvcmCustOpsRepGroup = nil): Il3Node; reintroduce;
  protected
   property RepGroup: IvcmCustOpsRepGroup
    read f_RepGroup
    write f_RepGroup;
 end;//TvcmRepGroupNode

 TPrimCustomizeTasksPanelForm = class(TvcmEntityForm)
  {* �������� ������ ����� }
  private
   f_spRight: TvtSplitter;
    {* ���� ��� �������� spRight }
   f_pnlBottom: TvtPanel;
    {* ���� ��� �������� pnlBottom }
   f_lblConfirmSave: TvtLabel;
    {* ���� ��� �������� lblConfirmSave }
   f_lblAvailableOpsCaption: TvtLabel;
    {* ���� ��� �������� lblAvailableOpsCaption }
   f_btOk: TvtButton;
    {* ���� ��� �������� btOk }
   f_btCancel: TvtButton;
    {* ���� ��� �������� btCancel }
   f_btApply: TvtButton;
    {* ���� ��� �������� btApply }
   f_pnlRep: TvtPanel;
    {* ���� ��� �������� pnlRep }
   f_splRep: TvtSplitter;
    {* ���� ��� �������� splRep }
   f_gbAvailableGroups: TvtGroupBox;
    {* ���� ��� �������� gbAvailableGroups }
   f_tvRepGroups: TeeTreeView;
    {* ���� ��� �������� tvRepGroups }
   f_vtPanel1: TvtPanel;
    {* ���� ��� �������� vtPanel1 }
   f_cbGroupName: TvtComboBox;
    {* ���� ��� �������� cbGroupName }
   f_btnAddGroup: TeeButton;
    {* ���� ��� �������� btnAddGroup }
   f_btnChangeGroup: TeeButton;
    {* ���� ��� �������� btnChangeGroup }
   f_btnDeleteGroup: TeeButton;
    {* ���� ��� �������� btnDeleteGroup }
   f_gbAvailableOperations: TvtGroupBox;
    {* ���� ��� �������� gbAvailableOperations }
   f_tvRepOps: TeeTreeView;
    {* ���� ��� �������� tvRepOps }
   f_pnlForms: TvtPanel;
    {* ���� ��� �������� pnlForms }
   f_lblForms: TvtLabel;
    {* ���� ��� �������� lblForms }
   f_cbForms: TComboBox;
    {* ���� ��� �������� cbForms }
   f_pnlMain: TvtPanel;
    {* ���� ��� �������� pnlMain }
   f_pnlLeft: TvtPanel;
    {* ���� ��� �������� pnlLeft }
   f_btnMoveOpToPanel: TBitBtn;
    {* ���� ��� �������� btnMoveOpToPanel }
   f_btnMoveOpToRep: TBitBtn;
    {* ���� ��� �������� btnMoveOpToRep }
   f_btnMoveGroupToPanel: TBitBtn;
    {* ���� ��� �������� btnMoveGroupToPanel }
   f_btnMoveGroupToRep: TBitBtn;
    {* ���� ��� �������� btnMoveGroupToRep }
   f_pnlTasksPanel: TvtPanel;
    {* ���� ��� �������� pnlTasksPanel }
   f_gbTasksPanel: TvtGroupBox;
    {* ���� ��� �������� gbTasksPanel }
   f_tvTasksPanel: TeeTreeView;
    {* ���� ��� �������� tvTasksPanel }
   f_vtGroupBox3: TvtGroupBox;
    {* ���� ��� �������� vtGroupBox3 }
   f_lblCaption: TvtLabel;
    {* ���� ��� �������� lblCaption }
   f_edChange: TvtComboBox;
    {* ���� ��� �������� edChange }
   f_cbForAllUseCases: TeeCheckBox;
    {* ���� ��� �������� cbForAllUseCases }
   f_btnChangeItem: TeeButton;
    {* ���� ��� �������� btnChangeItem }
   f_pnlOperationPos: TvtPanel;
    {* ���� ��� �������� pnlOperationPos }
   f_UpBitBtn: TBitBtn;
    {* ���� ��� �������� UpBitBtn }
   f_DownBitBtn: TBitBtn;
    {* ���� ��� �������� DownBitBtn }
   f_IsChanged: Boolean;
    {* ���� ��� �������� IsChanged }
  private
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
  protected
   function pm_GetTasksPanel: IvcmCustOps;
   procedure pm_SetTasksPanel(const aValue: IvcmCustOps);
   procedure pm_SetIsChanged(aValue: Boolean); virtual;
   class function vcmComparePostions(const aNode1: Il3Node;
    const aNode2: Il3Node): Integer;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   procedure MakeControls; override;
  public
   class function Make(const aPanel: IvcmCustOps): IvcmEntityForm; reintroduce;
    {* ������� }
  private
   property IsChanged: Boolean
    read f_IsChanged
    write pm_SetIsChanged;
  public
   property spRight: TvtSplitter
    read f_spRight;
   property pnlBottom: TvtPanel
    read f_pnlBottom;
   property pnlRep: TvtPanel
    read f_pnlRep;
   property pnlForms: TvtPanel
    read f_pnlForms;
   property pnlMain: TvtPanel
    read f_pnlMain;
   property TasksPanel: IvcmCustOps
    read pm_GetTasksPanel
    write pm_SetTasksPanel;
   property lblConfirmSave: TvtLabel
    read f_lblConfirmSave;
    {* ������ ������� �������. ��������� ���������? }
   property lblAvailableOpsCaption: TvtLabel
    read f_lblAvailableOpsCaption;
    {* �������� ��������� �������� ������ ������������ }
   property btOk: TvtButton
    read f_btOk;
    {* �� }
   property btCancel: TvtButton
    read f_btCancel;
    {* ������ }
   property btApply: TvtButton
    read f_btApply;
    {* ��������� }
   property splRep: TvtSplitter
    read f_splRep;
   property gbAvailableGroups: TvtGroupBox
    read f_gbAvailableGroups;
    {* ��������� ������: }
   property tvRepGroups: TeeTreeView
    read f_tvRepGroups;
   property vtPanel1: TvtPanel
    read f_vtPanel1;
   property cbGroupName: TvtComboBox
    read f_cbGroupName;
   property btnAddGroup: TeeButton
    read f_btnAddGroup;
    {* �������� }
   property btnChangeGroup: TeeButton
    read f_btnChangeGroup;
    {* �������� }
   property btnDeleteGroup: TeeButton
    read f_btnDeleteGroup;
    {* ������� }
   property gbAvailableOperations: TvtGroupBox
    read f_gbAvailableOperations;
    {* ��������� ��������: }
   property tvRepOps: TeeTreeView
    read f_tvRepOps;
   property lblForms: TvtLabel
    read f_lblForms;
    {* �������� �����: }
   property cbForms: TComboBox
    read f_cbForms;
   property pnlLeft: TvtPanel
    read f_pnlLeft;
   property btnMoveOpToPanel: TBitBtn
    read f_btnMoveOpToPanel;
   property btnMoveOpToRep: TBitBtn
    read f_btnMoveOpToRep;
   property btnMoveGroupToPanel: TBitBtn
    read f_btnMoveGroupToPanel;
   property btnMoveGroupToRep: TBitBtn
    read f_btnMoveGroupToRep;
   property pnlTasksPanel: TvtPanel
    read f_pnlTasksPanel;
   property gbTasksPanel: TvtGroupBox
    read f_gbTasksPanel;
    {* ������� ������ �����: }
   property tvTasksPanel: TeeTreeView
    read f_tvTasksPanel;
   property vtGroupBox3: TvtGroupBox
    read f_vtGroupBox3;
    {* ������� �������: }
   property lblCaption: TvtLabel
    read f_lblCaption;
    {* ��������: }
   property edChange: TvtComboBox
    read f_edChange;
   property cbForAllUseCases: TeeCheckBox
    read f_cbForAllUseCases;
    {* ��� ���� ������� ����� }
   property btnChangeItem: TeeButton
    read f_btnChangeItem;
    {* �������� }
   property pnlOperationPos: TvtPanel
    read f_pnlOperationPos;
   property UpBitBtn: TBitBtn
    read f_UpBitBtn;
   property DownBitBtn: TBitBtn
    read f_DownBitBtn;
 end;//TPrimCustomizeTasksPanelForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , CustomizeTasksPanelRes
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , InterfacedNodeWords
 {$IfEnd} // NOT Defined(NoScripts)
 , StdRes
 //#UC START# *4C8E4D21001Fimpl_uses*
 //#UC END# *4C8E4D21001Fimpl_uses*
;

procedure TvcmBaseNode.DoSave;
//#UC START# *53972500009A_5397246F0175_var*
//#UC END# *53972500009A_5397246F0175_var*
begin
//#UC START# *53972500009A_5397246F0175_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972500009A_5397246F0175_impl*
end;//TvcmBaseNode.DoSave

constructor TvcmBaseNode.Create;
//#UC START# *5397295A01BA_5397246F0175_var*
//#UC END# *5397295A01BA_5397246F0175_var*
begin
//#UC START# *5397295A01BA_5397246F0175_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397295A01BA_5397246F0175_impl*
end;//TvcmBaseNode.Create

procedure TvcmBaseNode.Remove;
 {* ������� ���� �� ������. }
//#UC START# *47710C6002AA_5397246F0175_var*
//#UC END# *47710C6002AA_5397246F0175_var*
begin
//#UC START# *47710C6002AA_5397246F0175_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710C6002AA_5397246F0175_impl*
end;//TvcmBaseNode.Remove

function TvcmBaseNode.Get_AllChildrenCount: Integer;
//#UC START# *47710E730361_5397246F0175get_var*
//#UC END# *47710E730361_5397246F0175get_var*
begin
//#UC START# *47710E730361_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710E730361_5397246F0175get_impl*
end;//TvcmBaseNode.Get_AllChildrenCount

function TvcmBaseNode.Get_NextNode: Il3Node;
//#UC START# *4771102F01C3_5397246F0175get_var*
//#UC END# *4771102F01C3_5397246F0175get_var*
begin
//#UC START# *4771102F01C3_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771102F01C3_5397246F0175get_impl*
end;//TvcmBaseNode.Get_NextNode

function TvcmBaseNode.Get_PrevNode: Il3Node;
//#UC START# *477110580184_5397246F0175get_var*
//#UC END# *477110580184_5397246F0175get_var*
begin
//#UC START# *477110580184_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110580184_5397246F0175get_impl*
end;//TvcmBaseNode.Get_PrevNode

function TvcmBaseNode.Get_ParentNode: Il3Node;
//#UC START# *4771108100D0_5397246F0175get_var*
//#UC END# *4771108100D0_5397246F0175get_var*
begin
//#UC START# *4771108100D0_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771108100D0_5397246F0175get_impl*
end;//TvcmBaseNode.Get_ParentNode

function TvcmBaseNode.Get_ChildNode: Il3Node;
//#UC START# *477110A2026C_5397246F0175get_var*
//#UC END# *477110A2026C_5397246F0175get_var*
begin
//#UC START# *477110A2026C_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110A2026C_5397246F0175get_impl*
end;//TvcmBaseNode.Get_ChildNode

function TvcmBaseNode.pm_GetState: TtpState;
//#UC START# *539720060390_5397246F0175get_var*
//#UC END# *539720060390_5397246F0175get_var*
begin
//#UC START# *539720060390_5397246F0175get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539720060390_5397246F0175get_impl*
end;//TvcmBaseNode.pm_GetState

procedure TvcmBaseNode.pm_SetState(aValue: TtpState);
//#UC START# *539720060390_5397246F0175set_var*
//#UC END# *539720060390_5397246F0175set_var*
begin
//#UC START# *539720060390_5397246F0175set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539720060390_5397246F0175set_impl*
end;//TvcmBaseNode.pm_SetState

procedure TvcmBaseNode.Save;
 {* ��������� ��������� }
//#UC START# *5397202C0298_5397246F0175_var*
//#UC END# *5397202C0298_5397246F0175_var*
begin
//#UC START# *5397202C0298_5397246F0175_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397202C0298_5397246F0175_impl*
end;//TvcmBaseNode.Save

procedure TvcmCustOpsRootNode.Remove;
 {* ������� ���� �� ������. }
//#UC START# *47710C6002AA_5397256F007A_var*
//#UC END# *47710C6002AA_5397256F007A_var*
begin
//#UC START# *47710C6002AA_5397256F007A_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710C6002AA_5397256F007A_impl*
end;//TvcmCustOpsRootNode.Remove

function TvcmCustOpsRootNode.Get_AllChildrenCount: Integer;
//#UC START# *47710E730361_5397256F007Aget_var*
//#UC END# *47710E730361_5397256F007Aget_var*
begin
//#UC START# *47710E730361_5397256F007Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710E730361_5397256F007Aget_impl*
end;//TvcmCustOpsRootNode.Get_AllChildrenCount

function TvcmCustOpsRootNode.Get_NextNode: Il3Node;
//#UC START# *4771102F01C3_5397256F007Aget_var*
//#UC END# *4771102F01C3_5397256F007Aget_var*
begin
//#UC START# *4771102F01C3_5397256F007Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771102F01C3_5397256F007Aget_impl*
end;//TvcmCustOpsRootNode.Get_NextNode

function TvcmCustOpsRootNode.Get_PrevNode: Il3Node;
//#UC START# *477110580184_5397256F007Aget_var*
//#UC END# *477110580184_5397256F007Aget_var*
begin
//#UC START# *477110580184_5397256F007Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110580184_5397256F007Aget_impl*
end;//TvcmCustOpsRootNode.Get_PrevNode

function TvcmCustOpsRootNode.Get_ParentNode: Il3Node;
//#UC START# *4771108100D0_5397256F007Aget_var*
//#UC END# *4771108100D0_5397256F007Aget_var*
begin
//#UC START# *4771108100D0_5397256F007Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771108100D0_5397256F007Aget_impl*
end;//TvcmCustOpsRootNode.Get_ParentNode

function TvcmCustOpsRootNode.Get_ChildNode: Il3Node;
//#UC START# *477110A2026C_5397256F007Aget_var*
//#UC END# *477110A2026C_5397256F007Aget_var*
begin
//#UC START# *477110A2026C_5397256F007Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110A2026C_5397256F007Aget_impl*
end;//TvcmCustOpsRootNode.Get_ChildNode

function TvcmCustOpsNode.pm_GetPosition: Integer;
//#UC START# *5397209700B8_539725B701B4get_var*
//#UC END# *5397209700B8_539725B701B4get_var*
begin
//#UC START# *5397209700B8_539725B701B4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397209700B8_539725B701B4get_impl*
end;//TvcmCustOpsNode.pm_GetPosition

procedure TvcmCustOpsNode.pm_SetPosition(aValue: Integer);
//#UC START# *5397209700B8_539725B701B4set_var*
//#UC END# *5397209700B8_539725B701B4set_var*
begin
//#UC START# *5397209700B8_539725B701B4set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397209700B8_539725B701B4set_impl*
end;//TvcmCustOpsNode.pm_SetPosition

procedure TvcmGroup.LoadOps;
//#UC START# *5397276701BB_539726940063_var*
//#UC END# *5397276701BB_539726940063_var*
begin
//#UC START# *5397276701BB_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397276701BB_539726940063_impl*
end;//TvcmGroup.LoadOps

constructor TvcmGroup.Create(const aGroup: IvcmCustOpsGroup);
//#UC START# *539728AF00C2_539726940063_var*
//#UC END# *539728AF00C2_539726940063_var*
begin
//#UC START# *539728AF00C2_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *539728AF00C2_539726940063_impl*
end;//TvcmGroup.Create

class function TvcmGroup.Make(const aGroup: IvcmCustOpsGroup): Il3Node;
var
 l_Inst : TvcmGroup;
begin
 l_Inst := Create(aGroup);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmGroup.Make

constructor TvcmGroup.Create(const aText: Tl3PCharLenPrim;
 const aRepGroup: IvcmCustOpsRepGroup);
//#UC START# *53972905022F_539726940063_var*
//#UC END# *53972905022F_539726940063_var*
begin
//#UC START# *53972905022F_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972905022F_539726940063_impl*
end;//TvcmGroup.Create

class function TvcmGroup.Make(const aText: Tl3PCharLenPrim;
 const aRepGroup: IvcmCustOpsRepGroup): Il3Node;
var
 l_Inst : TvcmGroup;
begin
 l_Inst := Create(aText, aRepGroup);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmGroup.Make

function TvcmGroup.pm_GetRepGroup: IvcmCustOpsRepGroup;
//#UC START# *539721310077_539726940063get_var*
//#UC END# *539721310077_539726940063get_var*
begin
//#UC START# *539721310077_539726940063get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721310077_539726940063get_impl*
end;//TvcmGroup.pm_GetRepGroup

procedure TvcmGroup.pm_SetRepGroup(const aValue: IvcmCustOpsRepGroup);
//#UC START# *539721310077_539726940063set_var*
//#UC END# *539721310077_539726940063set_var*
begin
//#UC START# *539721310077_539726940063set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721310077_539726940063set_impl*
end;//TvcmGroup.pm_SetRepGroup

function TvcmGroup.pm_GetGroup: IvcmCustOpsGroup;
//#UC START# *5397213B01F7_539726940063get_var*
//#UC END# *5397213B01F7_539726940063get_var*
begin
//#UC START# *5397213B01F7_539726940063get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397213B01F7_539726940063get_impl*
end;//TvcmGroup.pm_GetGroup

procedure TvcmGroup.pm_SetGroup(const aValue: IvcmCustOpsGroup);
//#UC START# *5397213B01F7_539726940063set_var*
//#UC END# *5397213B01F7_539726940063set_var*
begin
//#UC START# *5397213B01F7_539726940063set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397213B01F7_539726940063set_impl*
end;//TvcmGroup.pm_SetGroup

procedure TvcmGroup.DoSetPosition(aValue: Integer);
//#UC START# *5397264A01C8_539726940063_var*
//#UC END# *5397264A01C8_539726940063_var*
begin
//#UC START# *5397264A01C8_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397264A01C8_539726940063_impl*
end;//TvcmGroup.DoSetPosition

procedure TvcmGroup.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_539726940063_var*
//#UC END# *479731C50290_539726940063_var*
begin
//#UC START# *479731C50290_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_539726940063_impl*
end;//TvcmGroup.Cleanup

procedure TvcmGroup.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_539726940063_var*
//#UC END# *47A869D10074_539726940063_var*
begin
//#UC START# *47A869D10074_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A869D10074_539726940063_impl*
end;//TvcmGroup.DoSetAsPCharLen

procedure TvcmGroup.ClearFields;
begin
 f_Group := nil;
 f_RepGroup := nil;
 inherited;
end;//TvcmGroup.ClearFields

procedure TvcmGroup.DoSave;
//#UC START# *53972500009A_539726940063_var*
//#UC END# *53972500009A_539726940063_var*
begin
//#UC START# *53972500009A_539726940063_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972500009A_539726940063_impl*
end;//TvcmGroup.DoSave

function TvcmGroupOperation.pm_GetGroup: ItpGroup;
//#UC START# *53972F530397_539729990330get_var*
//#UC END# *53972F530397_539729990330get_var*
begin
//#UC START# *53972F530397_539729990330get_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972F530397_539729990330get_impl*
end;//TvcmGroupOperation.pm_GetGroup

constructor TvcmGroupOperation.Create(const aOp: IvcmCustOpsGroupOperation);
//#UC START# *5397303B0195_539729990330_var*
//#UC END# *5397303B0195_539729990330_var*
begin
//#UC START# *5397303B0195_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397303B0195_539729990330_impl*
end;//TvcmGroupOperation.Create

constructor TvcmGroupOperation.Create(const aRepOp: IvcmCustOpsRepOperation);
//#UC START# *5397305603D4_539729990330_var*
//#UC END# *5397305603D4_539729990330_var*
begin
//#UC START# *5397305603D4_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397305603D4_539729990330_impl*
end;//TvcmGroupOperation.Create

class function TvcmGroupOperation.Make(const aOp: IvcmCustOpsGroupOperation): Il3Node;
var
 l_Inst : TvcmGroupOperation;
begin
 l_Inst := Create(aOp);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmGroupOperation.Make

class function TvcmGroupOperation.Make(const aRepOp: IvcmCustOpsRepOperation): Il3Node;
var
 l_Inst : TvcmGroupOperation;
begin
 l_Inst := Create(aRepOp);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmGroupOperation.Make

function TvcmGroupOperation.pm_GetOp: IvcmCustOpsGroupOperation;
//#UC START# *539721C90125_539729990330get_var*
//#UC END# *539721C90125_539729990330get_var*
begin
//#UC START# *539721C90125_539729990330get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721C90125_539729990330get_impl*
end;//TvcmGroupOperation.pm_GetOp

procedure TvcmGroupOperation.pm_SetOp(const aValue: IvcmCustOpsGroupOperation);
//#UC START# *539721C90125_539729990330set_var*
//#UC END# *539721C90125_539729990330set_var*
begin
//#UC START# *539721C90125_539729990330set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721C90125_539729990330set_impl*
end;//TvcmGroupOperation.pm_SetOp

function TvcmGroupOperation.pm_GetRepOp: IvcmCustOpsRepOperation;
//#UC START# *539721CC02A5_539729990330get_var*
//#UC END# *539721CC02A5_539729990330get_var*
begin
//#UC START# *539721CC02A5_539729990330get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721CC02A5_539729990330get_impl*
end;//TvcmGroupOperation.pm_GetRepOp

procedure TvcmGroupOperation.pm_SetRepOp(const aValue: IvcmCustOpsRepOperation);
//#UC START# *539721CC02A5_539729990330set_var*
//#UC END# *539721CC02A5_539729990330set_var*
begin
//#UC START# *539721CC02A5_539729990330set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721CC02A5_539729990330set_impl*
end;//TvcmGroupOperation.pm_SetRepOp

function TvcmGroupOperation.pm_GetForAllUseCases: Boolean;
//#UC START# *539721E6003F_539729990330get_var*
//#UC END# *539721E6003F_539729990330get_var*
begin
//#UC START# *539721E6003F_539729990330get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721E6003F_539729990330get_impl*
end;//TvcmGroupOperation.pm_GetForAllUseCases

procedure TvcmGroupOperation.pm_SetForAllUseCases(aValue: Boolean);
//#UC START# *539721E6003F_539729990330set_var*
//#UC END# *539721E6003F_539729990330set_var*
begin
//#UC START# *539721E6003F_539729990330set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539721E6003F_539729990330set_impl*
end;//TvcmGroupOperation.pm_SetForAllUseCases

function TvcmGroupOperation.pm_GetGroupChanged: Boolean;
//#UC START# *539722010052_539729990330get_var*
//#UC END# *539722010052_539729990330get_var*
begin
//#UC START# *539722010052_539729990330get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722010052_539729990330get_impl*
end;//TvcmGroupOperation.pm_GetGroupChanged

procedure TvcmGroupOperation.pm_SetGroupChanged(aValue: Boolean);
//#UC START# *539722010052_539729990330set_var*
//#UC END# *539722010052_539729990330set_var*
begin
//#UC START# *539722010052_539729990330set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722010052_539729990330set_impl*
end;//TvcmGroupOperation.pm_SetGroupChanged

procedure TvcmGroupOperation.DoSetPosition(aValue: Integer);
//#UC START# *5397264A01C8_539729990330_var*
//#UC END# *5397264A01C8_539729990330_var*
begin
//#UC START# *5397264A01C8_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397264A01C8_539729990330_impl*
end;//TvcmGroupOperation.DoSetPosition

procedure TvcmGroupOperation.InitFields;
//#UC START# *47A042E100E2_539729990330_var*
//#UC END# *47A042E100E2_539729990330_var*
begin
//#UC START# *47A042E100E2_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_539729990330_impl*
end;//TvcmGroupOperation.InitFields

procedure TvcmGroupOperation.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_539729990330_var*
//#UC END# *47A869D10074_539729990330_var*
begin
//#UC START# *47A869D10074_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A869D10074_539729990330_impl*
end;//TvcmGroupOperation.DoSetAsPCharLen

function TvcmGroupOperation.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* ���������� ������� ���������� }
//#UC START# *4A60B23E00C3_539729990330_var*
//#UC END# *4A60B23E00C3_539729990330_var*
begin
//#UC START# *4A60B23E00C3_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A60B23E00C3_539729990330_impl*
end;//TvcmGroupOperation.COMQueryInterface

procedure TvcmGroupOperation.ClearFields;
begin
 Op := nil;
 RepOp := nil;
 inherited;
end;//TvcmGroupOperation.ClearFields

procedure TvcmGroupOperation.DoSave;
//#UC START# *53972500009A_539729990330_var*
//#UC END# *53972500009A_539729990330_var*
begin
//#UC START# *53972500009A_539729990330_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972500009A_539729990330_impl*
end;//TvcmGroupOperation.DoSave

constructor TvcmRepGroupOperationsNode.Create(const aGroup: IvcmCustOpsRepGroupOperations);
//#UC START# *5397386402F9_539730BD0307_var*
//#UC END# *5397386402F9_539730BD0307_var*
begin
//#UC START# *5397386402F9_539730BD0307_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397386402F9_539730BD0307_impl*
end;//TvcmRepGroupOperationsNode.Create

class function TvcmRepGroupOperationsNode.Make(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node;
var
 l_Inst : TvcmRepGroupOperationsNode;
begin
 l_Inst := Create(aGroup);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmRepGroupOperationsNode.Make

function TvcmRepGroupOperationsNode.pm_GetGroup: IvcmCustOpsRepGroupOperations;
//#UC START# *539722450260_539730BD0307get_var*
//#UC END# *539722450260_539730BD0307get_var*
begin
//#UC START# *539722450260_539730BD0307get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722450260_539730BD0307get_impl*
end;//TvcmRepGroupOperationsNode.pm_GetGroup

procedure TvcmRepGroupOperationsNode.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_539730BD0307_var*
//#UC END# *479731C50290_539730BD0307_var*
begin
//#UC START# *479731C50290_539730BD0307_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_539730BD0307_impl*
end;//TvcmRepGroupOperationsNode.Cleanup

procedure TvcmRepGroupOperationsNode.ClearFields;
begin
 f_Group := nil;
 inherited;
end;//TvcmRepGroupOperationsNode.ClearFields

constructor TvcmRepOperationNode.Create(const aOp: IvcmCustOpsRepOperation);
//#UC START# *5397395D01D0_539738CD0281_var*
//#UC END# *5397395D01D0_539738CD0281_var*
begin
//#UC START# *5397395D01D0_539738CD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397395D01D0_539738CD0281_impl*
end;//TvcmRepOperationNode.Create

class function TvcmRepOperationNode.Make(const aOp: IvcmCustOpsRepOperation): Il3Node;
var
 l_Inst : TvcmRepOperationNode;
begin
 l_Inst := Create(aOp);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmRepOperationNode.Make

function TvcmRepOperationNode.pm_GetOp: IvcmCustOpsRepOperation;
//#UC START# *539722A401F2_539738CD0281get_var*
//#UC END# *539722A401F2_539738CD0281get_var*
begin
//#UC START# *539722A401F2_539738CD0281get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722A401F2_539738CD0281get_impl*
end;//TvcmRepOperationNode.pm_GetOp

procedure TvcmRepOperationNode.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_539738CD0281_var*
//#UC END# *479731C50290_539738CD0281_var*
begin
//#UC START# *479731C50290_539738CD0281_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_539738CD0281_impl*
end;//TvcmRepOperationNode.Cleanup

procedure TvcmRepOperationNode.ClearFields;
begin
 f_Op := nil;
 inherited;
end;//TvcmRepOperationNode.ClearFields

procedure TvcmTree.Save;
//#UC START# *539723610044_539739B2024F_var*
//#UC END# *539723610044_539739B2024F_var*
begin
//#UC START# *539723610044_539739B2024F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539723610044_539739B2024F_impl*
end;//TvcmTree.Save

procedure TvcmCustOpsTree.LoadGroups;
//#UC START# *53973A2E02CB_539739FB0026_var*
//#UC END# *53973A2E02CB_539739FB0026_var*
begin
//#UC START# *53973A2E02CB_539739FB0026_impl*
 !!! Needs to be implemented !!!
//#UC END# *53973A2E02CB_539739FB0026_impl*
end;//TvcmCustOpsTree.LoadGroups

procedure TvcmCustOpsTree.InitFields;
//#UC START# *47A042E100E2_539739FB0026_var*
//#UC END# *47A042E100E2_539739FB0026_var*
begin
//#UC START# *47A042E100E2_539739FB0026_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_539739FB0026_impl*
end;//TvcmCustOpsTree.InitFields

procedure TvcmRepTree.ReadRepGroups;
 {* ��������� ������ ����������� }
//#UC START# *53973AA903CB_53973A55033D_var*
//#UC END# *53973AA903CB_53973A55033D_var*
begin
//#UC START# *53973AA903CB_53973A55033D_impl*
 !!! Needs to be implemented !!!
//#UC END# *53973AA903CB_53973A55033D_impl*
end;//TvcmRepTree.ReadRepGroups

procedure TvcmRepTree.ReadRepGroup(const aGroup: IvcmCustOpsRepGroupOperations;
 const aGroupNode: Il3Node);
//#UC START# *53973ABF00D4_53973A55033D_var*
//#UC END# *53973ABF00D4_53973A55033D_var*
begin
//#UC START# *53973ABF00D4_53973A55033D_impl*
 !!! Needs to be implemented !!!
//#UC END# *53973ABF00D4_53973A55033D_impl*
end;//TvcmRepTree.ReadRepGroup

procedure TvcmRepTree.InitFields;
//#UC START# *47A042E100E2_53973A55033D_var*
//#UC END# *47A042E100E2_53973A55033D_var*
begin
//#UC START# *47A042E100E2_53973A55033D_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_53973A55033D_impl*
end;//TvcmRepTree.InitFields

procedure TvcmRepGroupsTree.InitFields;
//#UC START# *47A042E100E2_53973AEC028A_var*
//#UC END# *47A042E100E2_53973AEC028A_var*
begin
//#UC START# *47A042E100E2_53973AEC028A_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A042E100E2_53973AEC028A_impl*
end;//TvcmRepGroupsTree.InitFields

constructor TvcmRepGroupNode.Create(const aCaption: Tl3PCharLenPrim;
 const aRepGroup: IvcmCustOpsRepGroup = nil);
//#UC START# *53973BE603E6_53973B3F02F2_var*
//#UC END# *53973BE603E6_53973B3F02F2_var*
begin
//#UC START# *53973BE603E6_53973B3F02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *53973BE603E6_53973B3F02F2_impl*
end;//TvcmRepGroupNode.Create

class function TvcmRepGroupNode.Make(const aCaption: Tl3PCharLenPrim;
 const aRepGroup: IvcmCustOpsRepGroup = nil): Il3Node;
var
 l_Inst : TvcmRepGroupNode;
begin
 l_Inst := Create(aCaption, aRepGroup);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmRepGroupNode.Make

function TvcmRepGroupNode.Get_RepGroup: IvcmCustOpsRepGroup;
//#UC START# *539722EE0350_53973B3F02F2get_var*
//#UC END# *539722EE0350_53973B3F02F2get_var*
begin
//#UC START# *539722EE0350_53973B3F02F2get_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722EE0350_53973B3F02F2get_impl*
end;//TvcmRepGroupNode.Get_RepGroup

procedure TvcmRepGroupNode.Set_RepGroup(const aValue: IvcmCustOpsRepGroup);
//#UC START# *539722EE0350_53973B3F02F2set_var*
//#UC END# *539722EE0350_53973B3F02F2set_var*
begin
//#UC START# *539722EE0350_53973B3F02F2set_impl*
 !!! Needs to be implemented !!!
//#UC END# *539722EE0350_53973B3F02F2set_impl*
end;//TvcmRepGroupNode.Set_RepGroup

procedure TvcmRepGroupNode.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_53973B3F02F2_var*
//#UC END# *479731C50290_53973B3F02F2_var*
begin
//#UC START# *479731C50290_53973B3F02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_53973B3F02F2_impl*
end;//TvcmRepGroupNode.Cleanup

procedure TvcmRepGroupNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
//#UC START# *47A869D10074_53973B3F02F2_var*
//#UC END# *47A869D10074_53973B3F02F2_var*
begin
//#UC START# *47A869D10074_53973B3F02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *47A869D10074_53973B3F02F2_impl*
end;//TvcmRepGroupNode.DoSetAsPCharLen

procedure TvcmRepGroupNode.ClearFields;
begin
 RepGroup := nil;
 inherited;
end;//TvcmRepGroupNode.ClearFields

procedure TvcmRepGroupNode.DoSave;
//#UC START# *53972500009A_53973B3F02F2_var*
//#UC END# *53972500009A_53973B3F02F2_var*
begin
//#UC START# *53972500009A_53973B3F02F2_impl*
 !!! Needs to be implemented !!!
//#UC END# *53972500009A_53973B3F02F2_impl*
end;//TvcmRepGroupNode.DoSave

function TPrimCustomizeTasksPanelForm.pm_GetTasksPanel: IvcmCustOps;
//#UC START# *4C8E4F1702F8_4C8E4D21001Fget_var*
//#UC END# *4C8E4F1702F8_4C8E4D21001Fget_var*
begin
//#UC START# *4C8E4F1702F8_4C8E4D21001Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8E4F1702F8_4C8E4D21001Fget_impl*
end;//TPrimCustomizeTasksPanelForm.pm_GetTasksPanel

procedure TPrimCustomizeTasksPanelForm.pm_SetTasksPanel(const aValue: IvcmCustOps);
//#UC START# *4C8E4F1702F8_4C8E4D21001Fset_var*
//#UC END# *4C8E4F1702F8_4C8E4D21001Fset_var*
begin
//#UC START# *4C8E4F1702F8_4C8E4D21001Fset_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C8E4F1702F8_4C8E4D21001Fset_impl*
end;//TPrimCustomizeTasksPanelForm.pm_SetTasksPanel

procedure TPrimCustomizeTasksPanelForm.pm_SetIsChanged(aValue: Boolean);
//#UC START# *5397181C036E_4C8E4D21001Fset_var*
//#UC END# *5397181C036E_4C8E4D21001Fset_var*
begin
//#UC START# *5397181C036E_4C8E4D21001Fset_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397181C036E_4C8E4D21001Fset_impl*
end;//TPrimCustomizeTasksPanelForm.pm_SetIsChanged

class function TPrimCustomizeTasksPanelForm.Make(const aPanel: IvcmCustOps): IvcmEntityForm;
 {* ������� }
var
 l_Inst : TPrimCustomizeTasksPanelForm;
begin
 l_Inst := Create(aPanel);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TPrimCustomizeTasksPanelForm.Make

procedure TPrimCustomizeTasksPanelForm.tvRepOpsGetItemImage;
//#UC START# *5397160601D9_4C8E4D21001F_var*
//#UC END# *5397160601D9_4C8E4D21001F_var*
begin
//#UC START# *5397160601D9_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397160601D9_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.tvRepOpsGetItemImage

procedure TPrimCustomizeTasksPanelForm.cbGroupNameChange(Sender: TObject);
//#UC START# *5397162701C7_4C8E4D21001F_var*
//#UC END# *5397162701C7_4C8E4D21001F_var*
begin
//#UC START# *5397162701C7_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397162701C7_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.cbGroupNameChange

procedure TPrimCustomizeTasksPanelForm.btnAddGroupClick(Sender: TObject);
//#UC START# *5397163F0110_4C8E4D21001F_var*
//#UC END# *5397163F0110_4C8E4D21001F_var*
begin
//#UC START# *5397163F0110_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397163F0110_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.btnAddGroupClick

procedure TPrimCustomizeTasksPanelForm.btnChangeGroupClick(Sender: TObject);
//#UC START# *5397165B00E5_4C8E4D21001F_var*
//#UC END# *5397165B00E5_4C8E4D21001F_var*
begin
//#UC START# *5397165B00E5_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397165B00E5_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.btnChangeGroupClick

procedure TPrimCustomizeTasksPanelForm.tvRepGroupsCurrentChanged;
//#UC START# *5397166401F3_4C8E4D21001F_var*
//#UC END# *5397166401F3_4C8E4D21001F_var*
begin
//#UC START# *5397166401F3_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397166401F3_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.tvRepGroupsCurrentChanged

procedure TPrimCustomizeTasksPanelForm.btnDeleteGroupClick(Sender: TObject);
//#UC START# *5397166E0319_4C8E4D21001F_var*
//#UC END# *5397166E0319_4C8E4D21001F_var*
begin
//#UC START# *5397166E0319_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397166E0319_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.btnDeleteGroupClick

procedure TPrimCustomizeTasksPanelForm.btOkClick(Sender: TObject);
//#UC START# *53971677023D_4C8E4D21001F_var*
//#UC END# *53971677023D_4C8E4D21001F_var*
begin
//#UC START# *53971677023D_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971677023D_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.btOkClick

procedure TPrimCustomizeTasksPanelForm.btApplyClick(Sender: TObject);
//#UC START# *53971685025A_4C8E4D21001F_var*
//#UC END# *53971685025A_4C8E4D21001F_var*
begin
//#UC START# *53971685025A_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971685025A_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.btApplyClick

procedure TPrimCustomizeTasksPanelForm.btnMoveGroupToPanelClick(Sender: TObject);
//#UC START# *539716C1038C_4C8E4D21001F_var*
//#UC END# *539716C1038C_4C8E4D21001F_var*
begin
//#UC START# *539716C1038C_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716C1038C_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.btnMoveGroupToPanelClick

procedure TPrimCustomizeTasksPanelForm.tvRepOpsCurrentChanged;
//#UC START# *539716CB0215_4C8E4D21001F_var*
//#UC END# *539716CB0215_4C8E4D21001F_var*
begin
//#UC START# *539716CB0215_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716CB0215_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.tvRepOpsCurrentChanged

procedure TPrimCustomizeTasksPanelForm.tvTasksPanelCurrentChanged;
//#UC START# *539716D400B2_4C8E4D21001F_var*
//#UC END# *539716D400B2_4C8E4D21001F_var*
begin
//#UC START# *539716D400B2_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716D400B2_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.tvTasksPanelCurrentChanged

procedure TPrimCustomizeTasksPanelForm.btnMoveOpToPanelClick(Sender: TObject);
//#UC START# *539716DC0168_4C8E4D21001F_var*
//#UC END# *539716DC0168_4C8E4D21001F_var*
begin
//#UC START# *539716DC0168_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716DC0168_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.btnMoveOpToPanelClick

procedure TPrimCustomizeTasksPanelForm.tvTasksPanelGetItemImage;
//#UC START# *539716E6010C_4C8E4D21001F_var*
//#UC END# *539716E6010C_4C8E4D21001F_var*
begin
//#UC START# *539716E6010C_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716E6010C_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.tvTasksPanelGetItemImage

procedure TPrimCustomizeTasksPanelForm.btnChangeItemClick(Sender: TObject);
//#UC START# *539716F1001F_4C8E4D21001F_var*
//#UC END# *539716F1001F_4C8E4D21001F_var*
begin
//#UC START# *539716F1001F_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716F1001F_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.btnChangeItemClick

procedure TPrimCustomizeTasksPanelForm.btnMoveGroupToRepClick(Sender: TObject);
//#UC START# *539716F90347_4C8E4D21001F_var*
//#UC END# *539716F90347_4C8E4D21001F_var*
begin
//#UC START# *539716F90347_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539716F90347_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.btnMoveGroupToRepClick

procedure TPrimCustomizeTasksPanelForm.btnMoveOpToRepClick(Sender: TObject);
//#UC START# *53971707031F_4C8E4D21001F_var*
//#UC END# *53971707031F_4C8E4D21001F_var*
begin
//#UC START# *53971707031F_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971707031F_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.btnMoveOpToRepClick

procedure TPrimCustomizeTasksPanelForm.cbForAllUseCasesClick(Sender: TObject);
//#UC START# *53971712035F_4C8E4D21001F_var*
//#UC END# *53971712035F_4C8E4D21001F_var*
begin
//#UC START# *53971712035F_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971712035F_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.cbForAllUseCasesClick

procedure TPrimCustomizeTasksPanelForm.UpBitBtnClick(Sender: TObject);
//#UC START# *5397171D03AB_4C8E4D21001F_var*
//#UC END# *5397171D03AB_4C8E4D21001F_var*
begin
//#UC START# *5397171D03AB_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397171D03AB_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.UpBitBtnClick

procedure TPrimCustomizeTasksPanelForm.DownBitBtnClick(Sender: TObject);
//#UC START# *53971727008B_4C8E4D21001F_var*
//#UC END# *53971727008B_4C8E4D21001F_var*
begin
//#UC START# *53971727008B_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971727008B_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.DownBitBtnClick

procedure TPrimCustomizeTasksPanelForm.cbFormsChange(Sender: TObject);
//#UC START# *5397173100AF_4C8E4D21001F_var*
//#UC END# *5397173100AF_4C8E4D21001F_var*
begin
//#UC START# *5397173100AF_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397173100AF_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.cbFormsChange

procedure TPrimCustomizeTasksPanelForm.UpdateState;
//#UC START# *539719370059_4C8E4D21001F_var*
//#UC END# *539719370059_4C8E4D21001F_var*
begin
//#UC START# *539719370059_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539719370059_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.UpdateState

procedure TPrimCustomizeTasksPanelForm.Save;
//#UC START# *5397193E01AE_4C8E4D21001F_var*
//#UC END# *5397193E01AE_4C8E4D21001F_var*
begin
//#UC START# *5397193E01AE_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397193E01AE_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.Save

function TPrimCustomizeTasksPanelForm.FindRepGroupOps(const aGroup: IvcmCustOpsRepGroupOperations): Il3Node;
//#UC START# *5397194B015D_4C8E4D21001F_var*
//#UC END# *5397194B015D_4C8E4D21001F_var*
begin
//#UC START# *5397194B015D_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397194B015D_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.FindRepGroupOps

procedure TPrimCustomizeTasksPanelForm.UpdateControls;
//#UC START# *53971960001A_4C8E4D21001F_var*
//#UC END# *53971960001A_4C8E4D21001F_var*
begin
//#UC START# *53971960001A_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971960001A_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.UpdateControls

procedure TPrimCustomizeTasksPanelForm.MoveTasksPanelItem(aUp: Boolean;
 const aNewParent: Il3Node);
//#UC START# *5397196E005A_4C8E4D21001F_var*
//#UC END# *5397196E005A_4C8E4D21001F_var*
begin
//#UC START# *5397196E005A_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397196E005A_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.MoveTasksPanelItem

procedure TPrimCustomizeTasksPanelForm.UpdatePositions(const aParent: Il3Node);
//#UC START# *5397198300E4_4C8E4D21001F_var*
//#UC END# *5397198300E4_4C8E4D21001F_var*
begin
//#UC START# *5397198300E4_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5397198300E4_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.UpdatePositions

procedure TPrimCustomizeTasksPanelForm.RemoveGroup(const aGroup: Il3Node);
 {* ������� ������ ������ ����� }
//#UC START# *539719990176_4C8E4D21001F_var*
//#UC END# *539719990176_4C8E4D21001F_var*
begin
//#UC START# *539719990176_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539719990176_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.RemoveGroup

procedure TPrimCustomizeTasksPanelForm.RemoveNode(const aNode: Il3Node);
 {* ������� ���� ������ �����, ��� ������������ �������� ��� ��� ������ }
//#UC START# *539719B300A9_4C8E4D21001F_var*
//#UC END# *539719B300A9_4C8E4D21001F_var*
begin
//#UC START# *539719B300A9_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539719B300A9_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.RemoveNode

procedure TPrimCustomizeTasksPanelForm.DeleteOp(const aNode: Il3Node);
 {* ������� �������� ������ ����� }
//#UC START# *539719D803D8_4C8E4D21001F_var*
//#UC END# *539719D803D8_4C8E4D21001F_var*
begin
//#UC START# *539719D803D8_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539719D803D8_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.DeleteOp

procedure TPrimCustomizeTasksPanelForm.ReturnRepOp(const aRepOp: IvcmCustOpsRepOperation);
 {* ������� �������� � ����������� }
//#UC START# *539719F00157_4C8E4D21001F_var*
//#UC END# *539719F00157_4C8E4D21001F_var*
begin
//#UC START# *539719F00157_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *539719F00157_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.ReturnRepOp

function TPrimCustomizeTasksPanelForm.GetSelectedUserType: IvcmUserTypeDef;
//#UC START# *53971A0D001F_4C8E4D21001F_var*
//#UC END# *53971A0D001F_4C8E4D21001F_var*
begin
//#UC START# *53971A0D001F_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53971A0D001F_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.GetSelectedUserType

class function TPrimCustomizeTasksPanelForm.vcmComparePostions(const aNode1: Il3Node;
 const aNode2: Il3Node): Integer;
//#UC START# *53973C440228_4C8E4D21001F_var*
//#UC END# *53973C440228_4C8E4D21001F_var*
begin
//#UC START# *53973C440228_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *53973C440228_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.vcmComparePostions

procedure TPrimCustomizeTasksPanelForm.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_4C8E4D21001F_var*
//#UC END# *479731C50290_4C8E4D21001F_var*
begin
//#UC START# *479731C50290_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.Cleanup

procedure TPrimCustomizeTasksPanelForm.DoInit(aFromHistory: Boolean);
 {* ������������� �����. ��� ���������� � �������� }
//#UC START# *49803F5503AA_4C8E4D21001F_var*
//#UC END# *49803F5503AA_4C8E4D21001F_var*
begin
//#UC START# *49803F5503AA_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49803F5503AA_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.DoInit

procedure TPrimCustomizeTasksPanelForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4C8E4D21001F_var*
//#UC END# *4A8E8F2E0195_4C8E4D21001F_var*
begin
//#UC START# *4A8E8F2E0195_4C8E4D21001F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8E8F2E0195_4C8E4D21001F_impl*
end;//TPrimCustomizeTasksPanelForm.InitControls

procedure TPrimCustomizeTasksPanelForm.MakeControls;
begin
 inherited;
 f_spRight := TvtSplitter.Create(Self);
 f_spRight.Name := 'spRight';
 f_spRight.Parent := Self;
 f_pnlBottom := TvtPanel.Create(Self);
 f_pnlBottom.Name := 'pnlBottom';
 f_pnlBottom.Parent := Self;
 f_lblConfirmSave := TvtLabel.Create(Self);
 f_lblConfirmSave.Name := 'lblConfirmSave';
 f_lblConfirmSave.Parent := pnlBottom;
 f_lblConfirmSave.Caption := '������ ������� �������. ��������� ���������?';
 f_lblAvailableOpsCaption := TvtLabel.Create(Self);
 f_lblAvailableOpsCaption.Name := 'lblAvailableOpsCaption';
 f_lblAvailableOpsCaption.Parent := pnlBottom;
 f_lblAvailableOpsCaption.Caption := '�������� ��������� �������� ������ ������������';
 f_btOk := TvtButton.Create(Self);
 f_btOk.Name := 'btOk';
 f_btOk.Parent := pnlBottom;
 f_btOk.Caption := '��';
 f_btCancel := TvtButton.Create(Self);
 f_btCancel.Name := 'btCancel';
 f_btCancel.Parent := pnlBottom;
 f_btCancel.Caption := '������';
 f_btApply := TvtButton.Create(Self);
 f_btApply.Name := 'btApply';
 f_btApply.Parent := pnlBottom;
 f_btApply.Caption := '���������';
 f_pnlRep := TvtPanel.Create(Self);
 f_pnlRep.Name := 'pnlRep';
 f_pnlRep.Parent := Self;
 f_splRep := TvtSplitter.Create(Self);
 f_splRep.Name := 'splRep';
 f_splRep.Parent := pnlRep;
 f_gbAvailableGroups := TvtGroupBox.Create(Self);
 f_gbAvailableGroups.Name := 'gbAvailableGroups';
 f_gbAvailableGroups.Parent := pnlRep;
 f_gbAvailableGroups.Caption := '��������� ������:';
 f_tvRepGroups := TeeTreeView.Create(Self);
 f_tvRepGroups.Name := 'tvRepGroups';
 f_tvRepGroups.Parent := gbAvailableGroups;
 f_vtPanel1 := TvtPanel.Create(Self);
 f_vtPanel1.Name := 'vtPanel1';
 f_vtPanel1.Parent := gbAvailableGroups;
 f_cbGroupName := TvtComboBox.Create(Self);
 f_cbGroupName.Name := 'cbGroupName';
 f_cbGroupName.Parent := vtPanel1;
 f_btnAddGroup := TeeButton.Create(Self);
 f_btnAddGroup.Name := 'btnAddGroup';
 f_btnAddGroup.Parent := vtPanel1;
 f_btnAddGroup.Caption := '��������';
 f_btnChangeGroup := TeeButton.Create(Self);
 f_btnChangeGroup.Name := 'btnChangeGroup';
 f_btnChangeGroup.Parent := vtPanel1;
 f_btnChangeGroup.Caption := '��������';
 f_btnDeleteGroup := TeeButton.Create(Self);
 f_btnDeleteGroup.Name := 'btnDeleteGroup';
 f_btnDeleteGroup.Parent := vtPanel1;
 f_btnDeleteGroup.Caption := '�������';
 f_gbAvailableOperations := TvtGroupBox.Create(Self);
 f_gbAvailableOperations.Name := 'gbAvailableOperations';
 f_gbAvailableOperations.Parent := pnlRep;
 f_gbAvailableOperations.Caption := '��������� ��������:';
 f_tvRepOps := TeeTreeView.Create(Self);
 f_tvRepOps.Name := 'tvRepOps';
 f_tvRepOps.Parent := gbAvailableOperations;
 f_pnlForms := TvtPanel.Create(Self);
 f_pnlForms.Name := 'pnlForms';
 f_pnlForms.Parent := Self;
 f_lblForms := TvtLabel.Create(Self);
 f_lblForms.Name := 'lblForms';
 f_lblForms.Parent := pnlForms;
 f_lblForms.Caption := '�������� �����:';
 f_cbForms := TComboBox.Create(Self);
 f_cbForms.Name := 'cbForms';
 f_cbForms.Parent := pnlForms;
 f_pnlMain := TvtPanel.Create(Self);
 f_pnlMain.Name := 'pnlMain';
 f_pnlMain.Parent := Self;
 f_pnlLeft := TvtPanel.Create(Self);
 f_pnlLeft.Name := 'pnlLeft';
 f_pnlLeft.Parent := pnlMain;
 f_btnMoveOpToPanel := TBitBtn.Create(Self);
 f_btnMoveOpToPanel.Name := 'btnMoveOpToPanel';
 f_btnMoveOpToPanel.Parent := pnlLeft;
 f_btnMoveOpToRep := TBitBtn.Create(Self);
 f_btnMoveOpToRep.Name := 'btnMoveOpToRep';
 f_btnMoveOpToRep.Parent := pnlLeft;
 f_btnMoveGroupToPanel := TBitBtn.Create(Self);
 f_btnMoveGroupToPanel.Name := 'btnMoveGroupToPanel';
 f_btnMoveGroupToPanel.Parent := pnlLeft;
 f_btnMoveGroupToRep := TBitBtn.Create(Self);
 f_btnMoveGroupToRep.Name := 'btnMoveGroupToRep';
 f_btnMoveGroupToRep.Parent := pnlLeft;
 f_pnlTasksPanel := TvtPanel.Create(Self);
 f_pnlTasksPanel.Name := 'pnlTasksPanel';
 f_pnlTasksPanel.Parent := pnlMain;
 f_gbTasksPanel := TvtGroupBox.Create(Self);
 f_gbTasksPanel.Name := 'gbTasksPanel';
 f_gbTasksPanel.Parent := pnlTasksPanel;
 f_gbTasksPanel.Caption := '������� ������ �����:';
 f_tvTasksPanel := TeeTreeView.Create(Self);
 f_tvTasksPanel.Name := 'tvTasksPanel';
 f_tvTasksPanel.Parent := gbTasksPanel;
 f_vtGroupBox3 := TvtGroupBox.Create(Self);
 f_vtGroupBox3.Name := 'vtGroupBox3';
 f_vtGroupBox3.Parent := gbTasksPanel;
 f_vtGroupBox3.Caption := '������� �������:';
 f_lblCaption := TvtLabel.Create(Self);
 f_lblCaption.Name := 'lblCaption';
 f_lblCaption.Parent := vtGroupBox3;
 f_lblCaption.Caption := '��������:';
 f_edChange := TvtComboBox.Create(Self);
 f_edChange.Name := 'edChange';
 f_edChange.Parent := vtGroupBox3;
 f_cbForAllUseCases := TeeCheckBox.Create(Self);
 f_cbForAllUseCases.Name := 'cbForAllUseCases';
 f_cbForAllUseCases.Parent := vtGroupBox3;
 f_cbForAllUseCases.Caption := '��� ���� ������� �����';
 f_btnChangeItem := TeeButton.Create(Self);
 f_btnChangeItem.Name := 'btnChangeItem';
 f_btnChangeItem.Parent := vtGroupBox3;
 f_btnChangeItem.Caption := '��������';
 f_pnlOperationPos := TvtPanel.Create(Self);
 f_pnlOperationPos.Name := 'pnlOperationPos';
 f_pnlOperationPos.Parent := pnlTasksPanel;
 f_UpBitBtn := TBitBtn.Create(Self);
 f_UpBitBtn.Name := 'UpBitBtn';
 f_UpBitBtn.Parent := pnlOperationPos;
 f_DownBitBtn := TBitBtn.Create(Self);
 f_DownBitBtn.Name := 'DownBitBtn';
 f_DownBitBtn.Parent := pnlOperationPos;
end;//TPrimCustomizeTasksPanelForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimCustomizeTasksPanelForm);
 {* ����������� PrimCustomizeTasksPanel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
