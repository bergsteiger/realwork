unit eeTreeViewExport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest Engine"
// ������: "w:/common/components/gui/Garant/Everest_Engine/eeTreeViewExport.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Everest Engine::Tree::TeeTreeViewExport
//
// ��������� ��� �������� ����������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  l3Interfaces,
  l3CacheableBase,
  afwInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3TreeInterfaces,
  Messages,
  eeInterfaces,
  eeInterfacesEx,
  vtOutlinerWithDragDrop,
  vtOutliner,
  Classes,
  l3IID
  ;

type
 TeeRootChangedEvent = procedure (aSender: TObject;
  const anOldRoot: IeeNode;
  const aNewRoot: IeeNode) of object;

 TeeFormatStatusInfo = procedure (aSender: TObject;
  var Info: Il3CString;
  aCurrent: Integer;
  aCount: Integer;
  aSelected: Integer) of object;

 TeeCurrentIndexChangedEvent = procedure (aNew: Integer;
  anOld: Integer) of object;

 TeeBT2L3BTMap = array [TeeSetBitType] of Tl3SetBitType;
const
  { eeTreeViewExport Private Const }
 eeBT2L3BT : TeeBT2L3BTMap = (sbSelect, sbDeselect, sbInvert);

type
 TeeTreeViewExportPrim = class(TvtOutlinerWithDragDrop {$If not defined(NoVCM)}, IvcmState{$IfEnd} //not NoVCM
 , IafwStatusElement, Il3RootSpy, Il3NodeNotifyRecipient {$If not defined(NoVCM)}, IvcmCloneableState{$IfEnd} //not NoVCM
 )
 private
 // private fields
   f_PrevNode : IeeNode;
   f_CurNode : IeeNode;
   f_TreeView : IeeTreeView;
    {* ���� ��� �������� TreeView}
   f_DblClickOnFolder : Boolean;
    {* ���� ��� �������� DblClickOnFolder}
   f_ClearTreeStructOnSaveState : Boolean;
    {* ���� ��� �������� ClearTreeStructOnSaveState}
   f_NeedStatus : Boolean;
    {* ���� ��� �������� NeedStatus}
   f_OnRootChanged : TeeRootChangedEvent;
    {* ���� ��� �������� OnRootChanged}
   f_OnFormatStatusInfo : TeeFormatStatusInfo;
    {* ���� ��� �������� OnFormatStatusInfo}
   f_OnCurrentIndexChanged : TeeCurrentIndexChangedEvent;
    {* ���� ��� �������� OnCurrentIndexChanged}
   f_LoadingCloneState : Boolean;
    {* ���� ��� �������� LoadingCloneState}
 private
 // private methods
   procedure WMLButtonDblClk(var Msg: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
 protected
 // property methods
   function pm_GetTreeView: IeeTreeView;
 protected
 // realized methods
  {$If not defined(NoVCM)}
   function SaveState(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  {$IfEnd} //not NoVCM
  {$If not defined(NoVCM)}
   function LoadState(const theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  {$IfEnd} //not NoVCM
   procedure GetStatusInfo(out theString: IafwCString;
   out theNeedProgress: Boolean);
   procedure Notify(aOperation: Integer;
   const aNode: Il3SimpleNode);
     {* ������ ��������. }
  {$If not defined(NoVCM)}
   function SaveStateForClone(out theState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  {$IfEnd} //not NoVCM
  {$If not defined(NoVCM)}
   function LoadCloneState(const aState: IUnknown;
   aStateType: TvcmStateType): Boolean;
  {$IfEnd} //not NoVCM
 protected
 // overridden property methods
   function pm_GetTreeStruct: Il3SimpleTree; override;
   procedure pm_SetTreeStruct(const aValue: Il3SimpleTree); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   function COMQueryInterface(const IID: Tl3GUID;
   out Obj): Tl3HResult; override;
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
   function NotifyIfNewCurrentEmpty: Boolean; override;
     {* ���������� ����� �� �������� ������� OnCurrentChanged � ������ ���� ������ NewCurrent = -1. }
   function DoDoProcessCommand(Cmd: Tl3OperationCode): Boolean; override;
   procedure CallCurrentChanged(aNewCurrent: LongInt;
     aOldCurrent: LongInt); override;
   procedure SubscribeTreeStruct(const aTreeStruct: Il3SimpleTree); override;
   procedure UnsubscribeTreeStruct(const aTreeStruct: Il3SimpleTree); override;
   procedure MakeTreeStructOnDraw; override;
     {* ���������� ����� ����������, ������ ��� �� ����� ������� ����� _TreeStruct �� �������, ���� ������� ��� ������. }
   function DoOnExpand(Expand: Boolean;
     const CNode: Il3SimpleNode): Boolean; override;
     {* ���� CNode = nil ������ ��������� �������� ��������\���������� ��� }
   procedure DoTreeChanged(const anOldTree: Il3SimpleTree;
     const aNewTree: Il3SimpleTree); override;
   procedure SetTreeStructFromHistory(const aTreeStruct: Il3SimpleTree;
     const aData: TvtOutlinerHystoryData); override;
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
   procedure DoCurrentIndexChanged(aNew: Integer;
     anOld: Integer);
    {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   function DoLoadState(const aState: IUnknown;
     aStateType: TvcmStateType;
     aForClone: Boolean): Boolean; virtual;
    {$IfEnd} //not DesignTimeLibrary AND not NoVCM
    {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   function DoSaveState(out aState: IUnknown;
     aStateType: TvcmStateType;
     aForClone: Boolean): Boolean; virtual;
    {$IfEnd} //not DesignTimeLibrary AND not NoVCM
   function GetSelectedCountForStatusbar: Integer; virtual;
   function IsTreeStructAssigned: Boolean;
   procedure RootChanged(const anOldRoot: Il3SimpleRootNode;
     const aNewRoot: Il3SimpleRootNode); overload;  virtual;
   procedure RootChanged(const anOldRoot: IeeNode;
     const aNewRoot: IeeNode); overload;  virtual;
   procedure UpdateStatus;
     {* ��� ��������� � ������ TreeStruct, TreeView ��������� ������ ���������. �� ������ ��������� �������� ����� ��������� ������ � ������ ������������� �� ��������� TreeStruct, TreeView (CQ: OIT500021361) }
 public
 // public methods
   procedure MakeItemVisible(aIndex: Integer);
     {* ������ ���� �������, ������ �� ��������� }
 protected
 // protected properties
   property TreeView: IeeTreeView
     read pm_GetTreeView;
   property LoadingCloneState: Boolean
     read f_LoadingCloneState;
 public
 // public properties
   property DblClickOnFolder: Boolean
     read f_DblClickOnFolder
     write f_DblClickOnFolder;
     {* default True }
   property ClearTreeStructOnSaveState: Boolean
     read f_ClearTreeStructOnSaveState
     write f_ClearTreeStructOnSaveState;
     {* default True }
   property NeedStatus: Boolean
     read f_NeedStatus
     write f_NeedStatus;
     {* default False }
   property OnRootChanged: TeeRootChangedEvent
     read f_OnRootChanged
     write f_OnRootChanged;
   property OnFormatStatusInfo: TeeFormatStatusInfo
     read f_OnFormatStatusInfo
     write f_OnFormatStatusInfo;
   property OnCurrentIndexChanged: TeeCurrentIndexChangedEvent
     read f_OnCurrentIndexChanged
     write f_OnCurrentIndexChanged;
 end;//TeeTreeViewExportPrim

 TeeTreeViewShadow = class(Tl3CacheableBase, IeeTree, IeeTreeView, IeeTool)
 private
 // private fields
   f_TreeView : TeeTreeViewExportPrim;
   f_UpdateCount : Integer;
 protected
 // realized methods
   procedure OwnerDead;
     {* ����������� � ������ ��������. }
   function Get_Root: IeeNode;
   procedure Set_Root(const aValue: IeeNode);
   function Get_SelectedCount: Integer;
   function Get_NodeFlags(const aNode: IeeNode): Integer;
   procedure Set_NodeFlags(const aNode: IeeNode; aValue: Integer);
   function Get_FlagsByAbsIndex(anAbsIndex: Integer): Integer;
   procedure Set_FlagsByAbsIndex(anAbsIndex: Integer; aValue: Integer);
   function TestFlagMask(aAbsIndex: LongInt;
    aFlagMask: Integer): Boolean;
   procedure SetFlagMask(aAbsIndex: LongInt;
    aFlagMask: Integer;
    aMode: TeeSetBitType); overload; 
   procedure SetFlagMask(const aRNode: IeeNode;
    aFlagMask: Integer;
    aMode: TeeSetBitType); overload; 
   procedure ExpandSubDir(const RNode: IeeNode = nil;
    Expand: Boolean = True;
    DeepLevel: Byte = 0);
     {* ����������/�������� ���� }
   function ChangeExpand(const RNode: IeeNode;
    Mode: TeeSetBitType;
    aForceMode: Boolean = False): Boolean;
   function IsChanging: Boolean;
     {* ������ ��������� � ���� ���������� }
   procedure Changing;
     {* ��������� ������ Changing }
   procedure Changed;
     {* ��������� ������ Changed }
   function GetAbsIndex(const aNode: IeeNode): Integer; overload; 
   function GetAbsIndex(anIndex: Integer): Integer; overload; 
   function Iterate(Action: TeeNodeAction;
    IterMode: Integer = 0;
    const aSubRootNode: IeeNode = nil;
    const aFromNode: IeeNode = nil): IeeNode;
     {* ��������� ��� ����. IterMode ��. imExpandOnly etc. }
   function IterateF(Action: TeeNodeAction;
    IterMode: Integer = 0;
    const aSubRootNode: IeeNode = nil;
    const aFromNode: IeeNode = nil): IeeNode;
     {* ��������� ��� ���� � ���������� �������� ��� Action }
   function GetNextSelected(const aCurNode: IeeNode): IeeNode;
   procedure ClearSelected;
     {* ��������� ������ ClearSelected }
   procedure SetAllFlags(aMode: TeeSetBitType;
    aFlags: Integer);
   function GetNode(anIndex: Integer): IeeNode;
   function GetNodeByAbsIndex(anAbsIndex: Integer): IeeNode;
   function Wake: Boolean;
   function IsExpanded(const aNode: IeeNode): Boolean;
   function Get_Tree: IeeTree;
   function Get_Current: Integer;
   procedure Set_Current(aValue: Integer);
   function Get_AbsCurrent: Integer;
   function Get_CurrentNode: IeeNode;
   function GetNodeIndex(const aNode: IeeNode): Integer;
   function GetNodeAbsIndex(const aNode: IeeNode): Integer;
   procedure ExpandAll;
     {* ��������� ������ ExpandAll }
   procedure CollapseAll;
     {* ��������� ������ CollapseAll }
   function GoToNode(const aNode: IeeNode): LongInt;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public methods
   constructor Create(aTreeView: TeeTreeViewExportPrim); reintroduce;
   class function Make(aTreeView: TeeTreeViewExportPrim): IeeTreeView; reintroduce;
     {* ��������� ������� TeeTreeViewShadow.Make }
 end;//TeeTreeViewShadow


{$If not defined(DesignTimeLibrary)}

 IeeTreeState = interface(IUnknown)
   ['{59A4C6CC-3B40-4206-B937-E5EB9D68D6FC}']
   function GetTree: Il3SimpleTree;
   procedure SetTree(const aValue: Il3SimpleTree;
     const aData: TvtOutlinerHystoryData);
   function GetData: TvtOutlinerHystoryData;
 end;//IeeTreeState

 TeeTreeState = class(Tl3CacheableBase, IeeTreeState)
 private
 // private fields
   f_Tree : Il3SimpleTree;
   f_Data : TvtOutlinerHystoryData;
 protected
 // realized methods
   function GetTree: Il3SimpleTree;
   procedure SetTree(const aValue: Il3SimpleTree;
      const aData: TvtOutlinerHystoryData);
   function GetData: TvtOutlinerHystoryData;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   function COMQueryInterface(const IID: Tl3GUID;
   out Obj): Tl3HResult; override;
     {* ���������� ������� ���������� }
 public
 // public methods
   constructor Create(const aTree: Il3SimpleTree;
     const aData: TvtOutlinerHystoryData); reintroduce;
   class function Make(const aTree: Il3SimpleTree;
     const aData: TvtOutlinerHystoryData): IeeTreeState; reintroduce;
     {* ��������� ������� TeeTreeState.Make }
 end;//TeeTreeState
{$IfEnd} //not DesignTimeLibrary

//#UC START# *499C0B7B012Eci*
//#UC END# *499C0B7B012Eci*
//#UC START# *499C0B7B012Ecit*
//#UC END# *499C0B7B012Ecit*
 TeeTreeViewExport = class(TeeTreeViewExportPrim)
  {* ��������� ��� �������� ����������� ������ }
//#UC START# *499C0B7B012Epubl*
 published
  property OnCountChanged;
  property OnAfterFirstPaint;
  property OnCurrentIndexChanged;
//#UC END# *499C0B7B012Epubl*
 end;//TeeTreeViewExport

implementation

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  eeNode,
  afwFacade,
  Windows,
  l3ControlsTypes,
  l3String,
  nevInterfaces,
  l3Types
  {$If not defined(DesignTimeLibrary)}
  ,
  evStyleTableSpy
  {$IfEnd} //not DesignTimeLibrary
  ,
  OvcConst,
  l3InterfacesMisc,
  l3Tree_TLB,
  l3Nodes,
  l3Base
  ;

// start class TeeTreeViewExportPrim

procedure TeeTreeViewExportPrim.DoCurrentIndexChanged(aNew: Integer;
  anOld: Integer);
//#UC START# *5319F25902B0_531DB14D03CC_var*
//#UC END# *5319F25902B0_531DB14D03CC_var*
begin
//#UC START# *5319F25902B0_531DB14D03CC_impl*
 if Assigned(f_OnCurrentIndexChanged) then
  f_OnCurrentIndexChanged(anOld, aNew);
//#UC END# *5319F25902B0_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.DoCurrentIndexChanged

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
function TeeTreeViewExportPrim.DoLoadState(const aState: IUnknown;
  aStateType: TvcmStateType;
  aForClone: Boolean): Boolean;
//#UC START# *52DD0F6F0223_531DB14D03CC_var*
var
 l_Tree: Il3SimpleTree;
 l_Data: TvtOutlinerHystoryData;
//#UC END# *52DD0F6F0223_531DB14D03CC_var*
begin
//#UC START# *52DD0F6F0223_531DB14D03CC_impl*
 f_LoadingCloneState := aForClone;
 case aStateType of
  vcm_stContent :
  begin
   Result := true;
   with (aState As IeeTreeState) do
   begin
    l_Data := GetData;
    l_Tree := GetTree;
    try
     // ��������� �� �����, ������ ��� �� ������ ������ �� ����� ��������� �
     // �������, �� ������ ����� �������� � ����� ����������� ����������, �.�.
     // � ��������� ������ ���������� �������� TreeStruct (������ ��� nil) �
     // ����������������� �� ������ �������, ����� ���������� ������, ����������
     // �� ������� � ���������� ��� ���������� ������ ������
     //  
     // SetTree(TreeStruct, GetHistoryData);
     //
     SetTreeStructFromHistory(l_Tree, l_Data);
    finally
     l_Tree := nil;
    end;//try..finally
   end;//with (aState As IeeTreeState) do
  end;//vcm_stContent
  else
   Result := false;
 end;//case aStateType
 f_LoadingCloneState := False; 
//#UC END# *52DD0F6F0223_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.DoLoadState
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
function TeeTreeViewExportPrim.DoSaveState(out aState: IUnknown;
  aStateType: TvcmStateType;
  aForClone: Boolean): Boolean;
//#UC START# *52DD0F440276_531DB14D03CC_var*
//#UC END# *52DD0F440276_531DB14D03CC_var*
begin
//#UC START# *52DD0F440276_531DB14D03CC_impl*
 case aStateType of
  vcm_stContent :
  begin
   if (f_TreeStruct = nil) OR (f_TreeStruct.RootNode = nil) {OR
      (not ShowRoot AND (f_TreeStruct.RootNode.AllChildrenCount = 0))} then
    Result := false
   else
   begin
    Result := true;
    aState := TeeTreeState.Make(TreeStruct, GetHistoryData);
    if f_ClearTreeStructOnSaveState and (not aForClone) then
    begin
     f_ChangingForHistory := True;
     try
      TreeStruct := nil;
     finally
      f_ChangingForHistory := False;
     end;
    end;//f_ClearTreeStructOnSaveState
   end;//f_TreeStruct = nil
  end;//vcm_stContent
  else
   Result := false;
 end;//case aStateType
//#UC END# *52DD0F440276_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.DoSaveState
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

function TeeTreeViewExportPrim.GetSelectedCountForStatusbar: Integer;
//#UC START# *51DBCA8C0206_531DB14D03CC_var*
//#UC END# *51DBCA8C0206_531DB14D03CC_var*
begin
//#UC START# *51DBCA8C0206_531DB14D03CC_impl*
 Result := TreeStruct.SelectCount;
//#UC END# *51DBCA8C0206_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.GetSelectedCountForStatusbar

function TeeTreeViewExportPrim.IsTreeStructAssigned: Boolean;
//#UC START# *5319F2CE0307_531DB14D03CC_var*
//#UC END# *5319F2CE0307_531DB14D03CC_var*
begin
//#UC START# *5319F2CE0307_531DB14D03CC_impl*
 Result := Assigned(f_TreeStruct);
//#UC END# *5319F2CE0307_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.IsTreeStructAssigned

procedure TeeTreeViewExportPrim.MakeItemVisible(aIndex: Integer);
//#UC START# *5319F2F10189_531DB14D03CC_var*
//#UC END# *5319F2F10189_531DB14D03CC_var*
begin
//#UC START# *5319F2F10189_531DB14D03CC_impl*
 vlbMakeItemVisible(aIndex);
//#UC END# *5319F2F10189_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.MakeItemVisible

procedure TeeTreeViewExportPrim.RootChanged(const anOldRoot: Il3SimpleRootNode;
  const aNewRoot: Il3SimpleRootNode);
//#UC START# *5319F116018F_531DB14D03CC_var*
//#UC END# *5319F116018F_531DB14D03CC_var*
begin
//#UC START# *5319F116018F_531DB14D03CC_impl*
 if not (csDestroying in ComponentState) then
 begin
  f_PrevNode := nil;
  f_CurNode := nil;
  RootChanged(TeeNode.Make(anOldRoot), TeeNode.Make(aNewRoot));
 end;//not (csDestroying in ComponentState)
//#UC END# *5319F116018F_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.RootChanged

procedure TeeTreeViewExportPrim.RootChanged(const anOldRoot: IeeNode;
  const aNewRoot: IeeNode);
//#UC START# *5319F17400EC_531DB14D03CC_var*
//#UC END# *5319F17400EC_531DB14D03CC_var*
begin
//#UC START# *5319F17400EC_531DB14D03CC_impl*
 if Assigned(f_OnRootChanged) then
  f_OnRootChanged(Self, anOldRoot, aNewRoot);
//#UC END# *5319F17400EC_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.RootChanged

procedure TeeTreeViewExportPrim.UpdateStatus;
//#UC START# *5319F2A101E6_531DB14D03CC_var*
//#UC END# *5319F2A101E6_531DB14D03CC_var*
begin
//#UC START# *5319F2A101E6_531DB14D03CC_impl*
 if (afw.Application <> nil) and
    (afw.Application.CurrentMainForm <> nil) then
  afw.Application.CurrentMainForm.Status.Update;
//#UC END# *5319F2A101E6_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.UpdateStatus

function TeeTreeViewExportPrim.pm_GetTreeView: IeeTreeView;
//#UC START# *5319ECD7006D_531DB14D03CCget_var*
//#UC END# *5319ECD7006D_531DB14D03CCget_var*
begin
//#UC START# *5319ECD7006D_531DB14D03CCget_impl*
 if (f_TreeView = nil) then
 begin
  f_TreeView := TeeTreeViewShadow.Make(Self);
  UpdateStatus;
 end;
 Result := f_TreeView;
//#UC END# *5319ECD7006D_531DB14D03CCget_impl*
end;//TeeTreeViewExportPrim.pm_GetTreeView

procedure TeeTreeViewExportPrim.WMLButtonDblClk(var Msg: TWMLButtonDblClk);
//#UC START# *531DB6C5003F_531DB14D03CC_var*
var
 N: Longint;
 l_Part: Byte;
//#UC END# *531DB6C5003F_531DB14D03CC_var*
begin
//#UC START# *531DB6C5003F_531DB14D03CC_impl*
 HitTest(SmallPointToPoint(Msg.Pos), N, l_Part);
 if (l_Part <> ihtIcon) OR DblClickOnFolder then
  inherited;
//#UC END# *531DB6C5003F_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.WMLButtonDblClk

{$If not defined(NoVCM)}
function TeeTreeViewExportPrim.SaveState(out theState: IUnknown;
  aStateType: TvcmStateType): Boolean;
//#UC START# *4683E75B01D8_531DB14D03CC_var*
//#UC END# *4683E75B01D8_531DB14D03CC_var*
begin
//#UC START# *4683E75B01D8_531DB14D03CC_impl*
{$If not defined(DesignTimeLibrary)}
 Result := DoSaveState(theState, aStateType, False);
{$ifend}
//#UC END# *4683E75B01D8_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.SaveState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TeeTreeViewExportPrim.LoadState(const theState: IUnknown;
  aStateType: TvcmStateType): Boolean;
//#UC START# *4683E79D0331_531DB14D03CC_var*
//#UC END# *4683E79D0331_531DB14D03CC_var*
begin
//#UC START# *4683E79D0331_531DB14D03CC_impl*
{$If not defined(DesignTimeLibrary)}
 Result := DoLoadState(theState, aStateType, False);
{$ifend}
//#UC END# *4683E79D0331_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.LoadState
{$IfEnd} //not NoVCM

procedure TeeTreeViewExportPrim.GetStatusInfo(out theString: IafwCString;
  out theNeedProgress: Boolean);
//#UC START# *475E9466022A_531DB14D03CC_var*
 function lp_IndexInParent: Integer;
 var
  l_Root: Il3SimpleNode;
  l_Node: Il3SimpleNode;
  l_Temp: Il3SimpleNode;
 begin
  l_Node := GetCurrentNode;
  if Assigned(l_Node) and
    Supports(TreeStruct.RootNode, Il3SimpleNode, l_Root) then
   while Assigned(l_Node) and not l_Root.IsSame(l_Node.Parent) do
   begin
    l_Temp := l_Node.Parent;
    l_Node := l_Temp;
   end;
  if Assigned(l_Node) then
   Result := Succ(l_Node.IndexInParent)
  else
   Result := Succ(Current);
 end;

 function lp_AmountElements: Integer;
 var
  l_Node: Il3SimpleNode;
 begin
  if Supports(TreeStruct.RootNode, Il3SimpleNode, l_Node) then
  try
   Result := l_Node.ThisChildrenCount;
  finally
   l_Node := nil;
  end
  else
   Result := Total;
 end;

var
 l_Wake: Il3Wake;
 l_Elements: Integer;
//#UC END# *475E9466022A_531DB14D03CC_var*
begin
//#UC START# *475E9466022A_531DB14D03CC_impl*
 theString := nil;
 theNeedProgress := False;
 if NeedStatus AND IsTreeAssign AND (TreeStruct <> nil) AND
  ((f_TreeView = nil) OR not f_TreeView.Tree.IsChanging) then
 begin
  with TreeStruct do
  begin
   if (RootNode <> nil) then
   begin
    if Supports(RootNode, Il3Wake, l_Wake) and l_Wake.IsSleep then
     Exit;
    l_Elements := lp_AmountElements;
    // ������������ ������

    if not afw.Application.IsInternal then
     theString := l3Fmt(str_nevmmDocumentCount.AsCStr,
                         [lp_IndexInParent,
                         l_Elements])
    // ���������� ������
    else
     theString := l3Fmt(str_nevmmDocumentCountInt.AsCStr,
                         [lp_IndexInParent,
                         l_Elements,
                         GetSelectedCountForStatusbar]);
    if Assigned(f_OnFormatStatusInfo) then
     f_OnFormatStatusInfo(self, theString, lp_IndexInParent, l_Elements, GetSelectedCountForStatusbar);
   end;//RootNode <> nil
  end;//with TreeStruct
 end //if NeedStatus
//#UC END# *475E9466022A_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.GetStatusInfo

procedure TeeTreeViewExportPrim.Notify(aOperation: Integer;
  const aNode: Il3SimpleNode);
//#UC START# *477244190062_531DB14D03CC_var*
//#UC END# *477244190062_531DB14D03CC_var*
begin
//#UC START# *477244190062_531DB14D03CC_impl*
 if (aOperation in [ntDelete, ntInsert]) then
  f_CurNode := nil;
//#UC END# *477244190062_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.Notify

{$If not defined(NoVCM)}
function TeeTreeViewExportPrim.SaveStateForClone(out theState: IUnknown;
  aStateType: TvcmStateType): Boolean;
//#UC START# *55DC1CFE018D_531DB14D03CC_var*
//#UC END# *55DC1CFE018D_531DB14D03CC_var*
begin
//#UC START# *55DC1CFE018D_531DB14D03CC_impl*
 Result := DoSaveState(theState, aStateType, True);
//#UC END# *55DC1CFE018D_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.SaveStateForClone
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TeeTreeViewExportPrim.LoadCloneState(const aState: IUnknown;
  aStateType: TvcmStateType): Boolean;
//#UC START# *55DC1D21005D_531DB14D03CC_var*
//#UC END# *55DC1D21005D_531DB14D03CC_var*
begin
//#UC START# *55DC1D21005D_531DB14D03CC_impl*
 f_LoadingCloneState := True;
 DoLoadState(aState, aStateType, True);
 f_LoadingCloneState := False; 
//#UC END# *55DC1D21005D_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.LoadCloneState
{$IfEnd} //not NoVCM

procedure TeeTreeViewExportPrim.Cleanup;
//#UC START# *479731C50290_531DB14D03CC_var*
var
 l_Tool: IeeTool;
//#UC END# *479731C50290_531DB14D03CC_var*
begin
//#UC START# *479731C50290_531DB14D03CC_impl*
 {$IfNDef DesignTimeLibrary}
 evDelStyleTableSpy(Self);
 {$EndIf  DesignTimeLibrary}
 f_PrevNode := nil;
 f_CurNode := nil;
 if Supports(f_TreeView, IeeTool, l_Tool) then
 try
  l_Tool.OwnerDead;
 finally
  l_Tool := nil;
 end;//try..finally
 f_TreeView := nil;
 inherited;
//#UC END# *479731C50290_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.Cleanup

constructor TeeTreeViewExportPrim.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_531DB14D03CC_var*
//#UC END# *47D1602000C6_531DB14D03CC_var*
begin
//#UC START# *47D1602000C6_531DB14D03CC_impl*
 inherited;
 f_ClearTreeStructOnSaveState := True;
 DblClickOnFolder := True;
 UseStyleTable := True;
//#UC END# *47D1602000C6_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.Create

function TeeTreeViewExportPrim.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *48C7C4990287_531DB14D03CC_var*
//#UC END# *48C7C4990287_531DB14D03CC_var*
begin
//#UC START# *48C7C4990287_531DB14D03CC_impl*
 if IID.SomeOf([IeeTreeView, IeeTree]) then
 begin
  if Supports(pm_GetTreeView, IID.IID, Obj) then
   Result.SetOk
  else
   Result.SetNoInterface;
 end//IID.SomeOf([IeeTreeView, IeeTree])
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *48C7C4990287_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.COMQueryInterface

procedure TeeTreeViewExportPrim.ClearFields;
 {-}
begin
 f_PrevNode := nil;
 f_CurNode := nil;
 f_TreeView := nil;
 inherited;
end;//TeeTreeViewExportPrim.ClearFields

function TeeTreeViewExportPrim.NotifyIfNewCurrentEmpty: Boolean;
//#UC START# *5151AE2202F5_531DB14D03CC_var*
{* - ���������� ����� �� �������� ������� OnCurrentChanged � ������ ���� ������ NewCurrent = -1. }
//#UC END# *5151AE2202F5_531DB14D03CC_var*
begin
//#UC START# *5151AE2202F5_531DB14D03CC_impl*
 Result := True;
//#UC END# *5151AE2202F5_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.NotifyIfNewCurrentEmpty

function TeeTreeViewExportPrim.DoDoProcessCommand(Cmd: Tl3OperationCode): Boolean;
//#UC START# *5152C93400EB_531DB14D03CC_var*
var
 l_Current: LongInt;
//#UC END# *5152C93400EB_531DB14D03CC_var*
begin
//#UC START# *5152C93400EB_531DB14D03CC_impl*
 Result := inherited DoDoProcessCommand(Cmd);
 if Result then
 case Cmd of
  ccHome, ccExtendHome,
  ccEnd, ccExtendEnd,
  ccPrevPage, ccExtendPgUp,
  ccNextPage, ccExtendPgDn:
   repeat
    l_Current := Current;
    vlbMakeItemVisiblePrim(l_Current);
   until l_Current = Current;
 end;
//#UC END# *5152C93400EB_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.DoDoProcessCommand

procedure TeeTreeViewExportPrim.CallCurrentChanged(aNewCurrent: LongInt;
  aOldCurrent: LongInt);
//#UC START# *5152CC6A0355_531DB14D03CC_var*
//#UC END# *5152CC6A0355_531DB14D03CC_var*
begin
//#UC START# *5152CC6A0355_531DB14D03CC_impl*
 f_CurNode := nil;
 // - ��� �����������, � ����� ������� �� ��, ��� ����� ��� GetNode(aNewCurent)
 if (aNewCurrent = -1) then
  f_PrevNode := nil;
 if aNewCurrent <> -1 then
  f_CurNode := (Self As IeeTreeView).GetNode(aNewCurrent);
 if (f_PrevNode = nil) OR not f_PrevNode.IsSameNode(f_CurNode) then
 begin
  f_PrevNode := f_CurNode;
  inherited;
 end;//f_PrevNode = nil
 DoCurrentIndexChanged(aNewCurrent, aOldCurrent);
//#UC END# *5152CC6A0355_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.CallCurrentChanged

function TeeTreeViewExportPrim.pm_GetTreeStruct: Il3SimpleTree;
//#UC START# *515EF27A028F_531DB14D03CCget_var*
//#UC END# *515EF27A028F_531DB14D03CCget_var*
begin
//#UC START# *515EF27A028F_531DB14D03CCget_impl*
 Result := inherited pm_GetTreeStruct;
//#UC END# *515EF27A028F_531DB14D03CCget_impl*
end;//TeeTreeViewExportPrim.pm_GetTreeStruct

procedure TeeTreeViewExportPrim.pm_SetTreeStruct(const aValue: Il3SimpleTree);
//#UC START# *515EF27A028F_531DB14D03CCset_var*
var
 l_OldRoot: Il3SimpleRootNode;
 l_NewRoot: Il3SimpleRootNode;
//#UC END# *515EF27A028F_531DB14D03CCset_var*
begin
//#UC START# *515EF27A028F_531DB14D03CCset_impl*
 if (f_TreeStruct <> aValue) then
 begin
  if (f_TreeStruct = nil) then
   l_OldRoot := nil
  else
  begin
   l_OldRoot := Il3SimpleTree(f_TreeStruct).RootNode;
//   f_TreeStruct.DelRootSpy(Self);
//   f_TreeStruct.DelNotifiedObj(Self); �����������, ���� RootSpy ����� ����� ���� ������� �� �������� NotifiedObj
  end;//f_TreeStruct = nil
  inherited;
  if (f_TreeStruct = nil) then
   l_NewRoot := nil
  else
  begin
   l_NewRoot := Il3SimpleTree(f_TreeStruct).RootNode;
//   f_TreeStruct.AddRootSpy(Self);
//   f_TreeStruct.AddNotifiedObj(Self); �����������, ���� RootSpy ����� ����� ���� ������� �� �������� NotifiedObj
  end;//f_TreeStruct = nil
  if not l3IEQ(l_OldRoot, l_NewRoot) then
   RootChanged(l_OldRoot, l_NewRoot);
 end;//f_TreeStruct <> aValue
//#UC END# *515EF27A028F_531DB14D03CCset_impl*
end;//TeeTreeViewExportPrim.pm_SetTreeStruct

procedure TeeTreeViewExportPrim.SubscribeTreeStruct(const aTreeStruct: Il3SimpleTree);
//#UC START# *516297E40319_531DB14D03CC_var*
//#UC END# *516297E40319_531DB14D03CC_var*
begin
//#UC START# *516297E40319_531DB14D03CC_impl*
 inherited;
 aTreeStruct.Subscribe(Il3SelectCountChangedRecipient(Self));
 aTreeStruct.Subscribe(Il3NodeNotifyRecipient(Self));
 aTreeStruct.Subscribe(Il3ExternalTreeChangedRecipient(Self));
 aTreeStruct.Subscribe(Il3RootSpy(Self));
//#UC END# *516297E40319_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.SubscribeTreeStruct

procedure TeeTreeViewExportPrim.UnsubscribeTreeStruct(const aTreeStruct: Il3SimpleTree);
//#UC START# *5162982100FB_531DB14D03CC_var*
//#UC END# *5162982100FB_531DB14D03CC_var*
begin
//#UC START# *5162982100FB_531DB14D03CC_impl*
 inherited;
 aTreeStruct.Unsubscribe(Il3SelectCountChangedRecipient(Self));
 aTreeStruct.Unsubscribe(Il3NodeNotifyRecipient(Self));
 aTreeStruct.Unsubscribe(Il3ExternalTreeChangedRecipient(Self));
 aTreeStruct.Unsubscribe(Il3RootSpy(Self));
//#UC END# *5162982100FB_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.UnsubscribeTreeStruct

procedure TeeTreeViewExportPrim.MakeTreeStructOnDraw;
//#UC START# *51629A880103_531DB14D03CC_var*
{* - ���������� ����� ����������, ������ ��� �� ����� ������� ����� TreeStruct �� �������, ���� ������� ��� ������. }
//#UC END# *51629A880103_531DB14D03CC_var*
begin
//#UC START# *51629A880103_531DB14D03CC_impl*
 if not Assigned(f_TreeStruct) then
  TreeStruct;
//#UC END# *51629A880103_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.MakeTreeStructOnDraw

function TeeTreeViewExportPrim.DoOnExpand(Expand: Boolean;
  const CNode: Il3SimpleNode): Boolean;
//#UC START# *51629C9B00C2_531DB14D03CC_var*
//#UC END# *51629C9B00C2_531DB14D03CC_var*
begin
//#UC START# *51629C9B00C2_531DB14D03CC_impl*
 // {������ �.�.} ��� ����� �������� Current �������������� ��� �������� ������������ �������������,
 // � ���������� CallCurrentChanged �� �������� � �������� ��������, ����� f_CurNode ���������� �� ��������.
 // ��������, ����� ������� ��� ������� � ������������� �����.
 if not Expand then
 begin
  f_CurNode := nil;
  f_PrevNode := nil;
 end;
 Result := inherited DoOnExpand(Expand, CNode);
//#UC END# *51629C9B00C2_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.DoOnExpand

procedure TeeTreeViewExportPrim.DoTreeChanged(const anOldTree: Il3SimpleTree;
  const aNewTree: Il3SimpleTree);
//#UC START# *51629D5D018A_531DB14D03CC_var*
//#UC END# *51629D5D018A_531DB14D03CC_var*
begin
//#UC START# *51629D5D018A_531DB14D03CC_impl*
 inherited;
 UpdateStatus;
//#UC END# *51629D5D018A_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.DoTreeChanged

procedure TeeTreeViewExportPrim.SetTreeStructFromHistory(const aTreeStruct: Il3SimpleTree;
  const aData: TvtOutlinerHystoryData);
//#UC START# *51629D8E02C8_531DB14D03CC_var*
var
 l_OldRoot: Il3SimpleRootNode;
 l_NewRoot: Il3SimpleRootNode;
//#UC END# *51629D8E02C8_531DB14D03CC_var*
begin
//#UC START# *51629D8E02C8_531DB14D03CC_impl*
 if (f_TreeStruct <> aTreeStruct) then
 begin
  if (f_TreeStruct = nil) then
   l_OldRoot := nil
  else
  begin
   l_OldRoot := Il3SimpleTree(f_TreeStruct).RootNode;
//   f_TreeStruct.DelRootSpy(Self);
//   f_TreeStruct.DelNotifiedObj(Self); �����������, ���� RootSpy ����� ����� ���� ������� �� �������� NotifiedObj
  end;//f_TreeStruct = nil
  inherited;
  if (f_TreeStruct = nil) then
   l_NewRoot := nil
  else
  begin
   l_NewRoot := Il3SimpleTree(f_TreeStruct).RootNode;
//   f_TreeStruct.AddRootSpy(Self);
//   f_TreeStruct.AddNotifiedObj(Self); �����������, ���� RootSpy ����� ����� ���� ������� �� �������� NotifiedObj
  end;//f_TreeStruct = nil

  if not l3IEQ(l_OldRoot, l_NewRoot) then
   RootChanged(l_OldRoot, l_NewRoot);

  if NeedAssignTreeStructFromHistory then
  begin
   f_CurNode := nil;
   f_CurNode := (Self as IeeTreeView).GetNode(aData.rCurrent);
   f_PrevNode := f_CurNode;
  end;
  //Current := aData.rCurrent;
 end;//f_TreeStruct <> aTreeStruct
//#UC END# *51629D8E02C8_531DB14D03CC_impl*
end;//TeeTreeViewExportPrim.SetTreeStructFromHistory
// start class TeeTreeViewShadow

constructor TeeTreeViewShadow.Create(aTreeView: TeeTreeViewExportPrim);
//#UC START# *531A0A5E017A_5319FAE701F7_var*
//#UC END# *531A0A5E017A_5319FAE701F7_var*
begin
//#UC START# *531A0A5E017A_5319FAE701F7_impl*
 inherited Create;
 f_TreeView := aTreeView;
 f_UpdateCount := 0;
//#UC END# *531A0A5E017A_5319FAE701F7_impl*
end;//TeeTreeViewShadow.Create

class function TeeTreeViewShadow.Make(aTreeView: TeeTreeViewExportPrim): IeeTreeView;
var
 l_Inst : TeeTreeViewShadow;
begin
 l_Inst := Create(aTreeView);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TeeTreeViewShadow.OwnerDead;
//#UC START# *46A5D4220369_5319FAE701F7_var*
//#UC END# *46A5D4220369_5319FAE701F7_var*
begin
//#UC START# *46A5D4220369_5319FAE701F7_impl*
 f_TreeView := nil;
//#UC END# *46A5D4220369_5319FAE701F7_impl*
end;//TeeTreeViewShadow.OwnerDead

function TeeTreeViewShadow.Get_Root: IeeNode;
//#UC START# *5319FFC90029_5319FAE701F7get_var*
//#UC END# *5319FFC90029_5319FAE701F7get_var*
begin
//#UC START# *5319FFC90029_5319FAE701F7get_impl*
 if (f_TreeView = nil) or (f_TreeView.TreeStruct = nil) then
  Result := nil
 else
  Result := TeeNode.Make(f_TreeView.TreeStruct.RootNode);
//#UC END# *5319FFC90029_5319FAE701F7get_impl*
end;//TeeTreeViewShadow.Get_Root

procedure TeeTreeViewShadow.Set_Root(const aValue: IeeNode);
//#UC START# *5319FFC90029_5319FAE701F7set_var*
var
 l_Node: Il3RootNode;
//#UC END# *5319FFC90029_5319FAE701F7set_var*
begin
//#UC START# *5319FFC90029_5319FAE701F7set_impl*
 if (f_TreeView <> nil) then
 begin
  f_TreeView.Changing;
  try
   f_TreeView.f_PrevNode := nil;
   f_TreeView.f_CurNode := nil;
   if (aValue = nil) then
    f_TreeView.TreeStruct.RootNode := nil
   else
   if Supports(aValue, Il3RootNode, l_Node) then
   try
    f_TreeView.CTree.SetRootAndCountView(l_Node, l3_DelayedCountView);
   finally
    l_Node := nil;
   end;//try..finally
   f_TreeView.InternalSetCurrent(0);
  finally
   f_TreeView.Changed;
  end;//try..finally
 end;//f_TreeView <> nil
//#UC END# *5319FFC90029_5319FAE701F7set_impl*
end;//TeeTreeViewShadow.Set_Root

function TeeTreeViewShadow.Get_SelectedCount: Integer;
//#UC START# *531A003602A7_5319FAE701F7get_var*
//#UC END# *531A003602A7_5319FAE701F7get_var*
begin
//#UC START# *531A003602A7_5319FAE701F7get_impl*
 if (f_TreeView = nil) then
  Result := 0
 else
  Result := f_TreeView.TreeStruct.SelectCount;
//#UC END# *531A003602A7_5319FAE701F7get_impl*
end;//TeeTreeViewShadow.Get_SelectedCount

function TeeTreeViewShadow.Get_NodeFlags(const aNode: IeeNode): Integer;
//#UC START# *531A005002E3_5319FAE701F7get_var*
var
 l_Node: Il3Node;
//#UC END# *531A005002E3_5319FAE701F7get_var*
begin
//#UC START# *531A005002E3_5319FAE701F7get_impl*
 if (f_TreeView = nil) then
  Result := 0
 else
 if Supports(aNode, Il3Node, l_Node) then
 try
  Result := f_TreeView.CTree.NodeFlags[l_Node];
 finally
  l_Node := nil;
 end else
  Result := 0;
//#UC END# *531A005002E3_5319FAE701F7get_impl*
end;//TeeTreeViewShadow.Get_NodeFlags

procedure TeeTreeViewShadow.Set_NodeFlags(const aNode: IeeNode; aValue: Integer);
//#UC START# *531A005002E3_5319FAE701F7set_var*
var
 l_Node: Il3Node;
//#UC END# *531A005002E3_5319FAE701F7set_var*
begin
//#UC START# *531A005002E3_5319FAE701F7set_impl*
 if (f_TreeView <> nil) then
  if Supports(aNode, Il3Node, l_Node) then
  try
   f_TreeView.CTree.NodeFlags[l_Node] := aValue;
  finally
   l_Node := nil;
  end;//try..finally
//#UC END# *531A005002E3_5319FAE701F7set_impl*
end;//TeeTreeViewShadow.Set_NodeFlags

function TeeTreeViewShadow.Get_FlagsByAbsIndex(anAbsIndex: Integer): Integer;
//#UC START# *531A007501D2_5319FAE701F7get_var*
//#UC END# *531A007501D2_5319FAE701F7get_var*
begin
//#UC START# *531A007501D2_5319FAE701F7get_impl*
 Result := f_TreeView.CTree.GetFlagsByAbsIndex(anAbsIndex);
//#UC END# *531A007501D2_5319FAE701F7get_impl*
end;//TeeTreeViewShadow.Get_FlagsByAbsIndex

procedure TeeTreeViewShadow.Set_FlagsByAbsIndex(anAbsIndex: Integer; aValue: Integer);
//#UC START# *531A007501D2_5319FAE701F7set_var*
//#UC END# *531A007501D2_5319FAE701F7set_var*
begin
//#UC START# *531A007501D2_5319FAE701F7set_impl*
 f_TreeView.CTree.SetFlagsByAbsIndex(anAbsIndex, aValue);
//#UC END# *531A007501D2_5319FAE701F7set_impl*
end;//TeeTreeViewShadow.Set_FlagsByAbsIndex

function TeeTreeViewShadow.TestFlagMask(aAbsIndex: LongInt;
  aFlagMask: Integer): Boolean;
//#UC START# *531A00CA0043_5319FAE701F7_var*
//#UC END# *531A00CA0043_5319FAE701F7_var*
begin
//#UC START# *531A00CA0043_5319FAE701F7_impl*
 if (f_TreeView = nil) then
  Result := False
 else
  Result := f_TreeView.CTree.TestFlagMask(aAbsIndex, aFlagMask);
//#UC END# *531A00CA0043_5319FAE701F7_impl*
end;//TeeTreeViewShadow.TestFlagMask

procedure TeeTreeViewShadow.SetFlagMask(aAbsIndex: LongInt;
  aFlagMask: Integer;
  aMode: TeeSetBitType);
//#UC START# *531A010F00A5_5319FAE701F7_var*
//#UC END# *531A010F00A5_5319FAE701F7_var*
begin
//#UC START# *531A010F00A5_5319FAE701F7_impl*
 if (f_TreeView <> nil) then
  f_TreeView.CTree.SetFlagMask(aAbsIndex, aFlagMask, eeBT2L3BT[aMode]);
//#UC END# *531A010F00A5_5319FAE701F7_impl*
end;//TeeTreeViewShadow.SetFlagMask

procedure TeeTreeViewShadow.SetFlagMask(const aRNode: IeeNode;
  aFlagMask: Integer;
  aMode: TeeSetBitType);
//#UC START# *531A01E70176_5319FAE701F7_var*
var
 l_Node: Il3Node;
//#UC END# *531A01E70176_5319FAE701F7_var*
begin
//#UC START# *531A01E70176_5319FAE701F7_impl*
 if (f_TreeView <> nil) then
  if Supports(aRNode, Il3Node, l_Node) then
  try
   f_TreeView.CTree.SetFlagMask(l_Node, aFlagMask, eeBT2L3BT[aMode]);
  finally
   l_Node := nil;
  end;//try..finally
//#UC END# *531A01E70176_5319FAE701F7_impl*
end;//TeeTreeViewShadow.SetFlagMask

procedure TeeTreeViewShadow.ExpandSubDir(const RNode: IeeNode = nil;
  Expand: Boolean = True;
  DeepLevel: Byte = 0);
//#UC START# *531A022A023F_5319FAE701F7_var*
var
 l_Node: Il3Node;
 l_SImpleNode: Il3SimpleNode;
//#UC END# *531A022A023F_5319FAE701F7_var*
begin
//#UC START# *531A022A023F_5319FAE701F7_impl*
 if (f_TreeView <> nil) then
 begin
  if (RNode = nil) then
   l_Node := nil
  else
  if Supports(RNode, Il3Node, l_Node) then
  try
   f_TreeView.TreeStruct.ExpandSubDir(l_Node, Expand, DeepLevel);
  finally
   l_Node := nil;
  end//try..finally
  else
  if Supports(RNode, Il3SimpleNode, l_SimpleNode) then
   f_TreeView.TreeStruct.ExpandSubDir(l_SimpleNode, Expand, DeepLevel);
 end;//f_TreeView <> nil
//#UC END# *531A022A023F_5319FAE701F7_impl*
end;//TeeTreeViewShadow.ExpandSubDir

function TeeTreeViewShadow.ChangeExpand(const RNode: IeeNode;
  Mode: TeeSetBitType;
  aForceMode: Boolean = False): Boolean;
//#UC START# *531A033D028D_5319FAE701F7_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *531A033D028D_5319FAE701F7_var*
begin
//#UC START# *531A033D028D_5319FAE701F7_impl*
 if (f_TreeView = nil) then
  Result := false
 else
 begin
  if Supports(RNode, Il3SimpleNode, l_Node) then
   try
    Result := f_TreeView.TreeStruct.ChangeExpand(l_Node, eeBT2L3BT[Mode], aForceMode);
   finally
    l_Node := nil;
   end//try..finally
  else
   Result := false; 
 end;//f_TreeView <> nil
//#UC END# *531A033D028D_5319FAE701F7_impl*
end;//TeeTreeViewShadow.ChangeExpand

function TeeTreeViewShadow.IsChanging: Boolean;
//#UC START# *531A04C30010_5319FAE701F7_var*
//#UC END# *531A04C30010_5319FAE701F7_var*
begin
//#UC START# *531A04C30010_5319FAE701F7_impl*
 Result := f_UpdateCount > 0;
//#UC END# *531A04C30010_5319FAE701F7_impl*
end;//TeeTreeViewShadow.IsChanging

procedure TeeTreeViewShadow.Changing;
//#UC START# *531A04DD0289_5319FAE701F7_var*
//#UC END# *531A04DD0289_5319FAE701F7_var*
begin
//#UC START# *531A04DD0289_5319FAE701F7_impl*
 if (f_TreeView <> nil) then
 begin
  f_TreeView.TreeStruct.Changing;
  Inc(f_UpdateCount);
 end;
//#UC END# *531A04DD0289_5319FAE701F7_impl*
end;//TeeTreeViewShadow.Changing

procedure TeeTreeViewShadow.Changed;
//#UC START# *531A04E70208_5319FAE701F7_var*
//#UC END# *531A04E70208_5319FAE701F7_var*
begin
//#UC START# *531A04E70208_5319FAE701F7_impl*
 if (f_TreeView <> nil) then
 begin
  f_TreeView.TreeStruct.Changed{Ex(aCountView)};
  Dec(f_UpdateCount);
 end;
//#UC END# *531A04E70208_5319FAE701F7_impl*
end;//TeeTreeViewShadow.Changed

function TeeTreeViewShadow.GetAbsIndex(const aNode: IeeNode): Integer;
//#UC START# *531A04F802C1_5319FAE701F7_var*
var
 l_Node: Il3Node;
//#UC END# *531A04F802C1_5319FAE701F7_var*
begin
//#UC START# *531A04F802C1_5319FAE701F7_impl*
 if (f_TreeView = nil) then
  Result := -1
 else
 if Supports(aNode, Il3Node, l_Node) then
 try
  Result := f_TreeView.CTree.GetAbsIndex(l_Node);
 finally
  l_Node := nil;
 end//try..finally
 else
  Result := -1;
//#UC END# *531A04F802C1_5319FAE701F7_impl*
end;//TeeTreeViewShadow.GetAbsIndex

function TeeTreeViewShadow.GetAbsIndex(anIndex: Integer): Integer;
//#UC START# *531A05120121_5319FAE701F7_var*
var
 l_Node: Il3Node;
//#UC END# *531A05120121_5319FAE701F7_var*
begin
//#UC START# *531A05120121_5319FAE701F7_impl*
 if (f_TreeView = nil) then
  Result := -1
 else
 begin
  Supports(f_TreeView.GetNode(anIndex), Il3Node, l_Node);
  if (l_Node = nil) then
   Result := -1
  else
   Result := f_TreeView.CTree.GetAbsIndex(l_Node);
 end;//f_TreeView = nil
//#UC END# *531A05120121_5319FAE701F7_impl*
end;//TeeTreeViewShadow.GetAbsIndex

function TeeTreeViewShadow.Iterate(Action: TeeNodeAction;
  IterMode: Integer = 0;
  const aSubRootNode: IeeNode = nil;
  const aFromNode: IeeNode = nil): IeeNode;
//#UC START# *531A060301BA_5319FAE701F7_var*
 function l_CheckNode(const aNode: Il3Node): Boolean;
 begin
  Result := Action(TeeNode.Make(aNode));
 end;

 function l_CheckSimpleNode(const aNode: Il3SimpleNode): Boolean;
 begin
  Result := Action(TeeNode.Make(aNode));
 end;

var
 l_SubRoot: Il3Node;
 l_FromNode: Il3Node;
 l_FromNodeS: Il3SimpleNode;
 l_Tree: Il3Tree;
//#UC END# *531A060301BA_5319FAE701F7_var*
begin
//#UC START# *531A060301BA_5319FAE701F7_impl*
 if (f_TreeView = nil) then
  Result := nil
 else
 begin
  if Supports(f_TreeView.TreeStruct, Il3Tree, l_Tree) then
  begin
   Supports(aSubRootNode, Il3Node, l_SubRoot);
   Supports(aFromNode, Il3Node, l_FromNode);
   Result := TeeNode.Make(l_Tree.IterateF(l3L2NA(@l_CheckNode), IterMode, l_SubRoot, l_FromNode));
  end//Supports(f_TreeView.TreeStruct, Il3Tree, l_Tree)
  else
  begin
   Supports(aSubRootNode, Il3SimpleNode, l_FromNodeS);
   Result := TeeNode.Make(f_TreeView.TreeStruct.SimpleIterateF(l3L2SNA(@l_CheckSimpleNode), IterMode, l_FromNodeS));
  end;//Supports(f_TreeView.TreeStruct, Il3Tree, l_Tree)
 end;//f_TreeView = nil
//#UC END# *531A060301BA_5319FAE701F7_impl*
end;//TeeTreeViewShadow.Iterate

function TeeTreeViewShadow.IterateF(Action: TeeNodeAction;
  IterMode: Integer = 0;
  const aSubRootNode: IeeNode = nil;
  const aFromNode: IeeNode = nil): IeeNode;
//#UC START# *531A064001BF_5319FAE701F7_var*
//#UC END# *531A064001BF_5319FAE701F7_var*
begin
//#UC START# *531A064001BF_5319FAE701F7_impl*
 try
  Result := Iterate(Action, IterMode, aSubRootNode, aFromNode);
 finally
  l3FreeFA(Tl3FreeAction(Action));
 end;//try..finally
//#UC END# *531A064001BF_5319FAE701F7_impl*
end;//TeeTreeViewShadow.IterateF

function TeeTreeViewShadow.GetNextSelected(const aCurNode: IeeNode): IeeNode;
//#UC START# *531A068302C5_5319FAE701F7_var*
var
 l_Tree: Il3Tree;
 l_Node: Il3Node;
//#UC END# *531A068302C5_5319FAE701F7_var*
begin
//#UC START# *531A068302C5_5319FAE701F7_impl*
 if (f_TreeView = nil) then
  Result := nil
 else
 begin
  if f_TreeView.MultiSelect then
  begin
   l_Tree := f_TreeView.CTree;
   if (aCurNode = nil) then
    Result := TeeNode.Make(l_Tree.GetNextSelect(nil))
   else if Supports(aCurNode, Il3Node, l_Node) then
    Result := TeeNode.Make(l_Tree.GetNextSelect(l_Node))
   else
    Result := nil;
  end//f_TreeView.MultiSelect
  else
  begin
   if Get_Root.IsSameNode(aCurNode) then
    Result := Get_CurrentNode
   else
    Result := nil;
  end;//f_TreeView.MultiSelect
 end;//f_TreeView = nil
//#UC END# *531A068302C5_5319FAE701F7_impl*
end;//TeeTreeViewShadow.GetNextSelected

procedure TeeTreeViewShadow.ClearSelected;
//#UC START# *531A06AC0398_5319FAE701F7_var*
var
 l_Tree: Il3Tree;
//#UC END# *531A06AC0398_5319FAE701F7_var*
begin
//#UC START# *531A06AC0398_5319FAE701F7_impl*
 if (f_TreeView <> nil) then
  f_TreeView.CTree.ClearSelected;
//#UC END# *531A06AC0398_5319FAE701F7_impl*
end;//TeeTreeViewShadow.ClearSelected

procedure TeeTreeViewShadow.SetAllFlags(aMode: TeeSetBitType;
  aFlags: Integer);
//#UC START# *531A06B90062_5319FAE701F7_var*
//#UC END# *531A06B90062_5319FAE701F7_var*
begin
//#UC START# *531A06B90062_5319FAE701F7_impl*
 if (f_TreeView <> nil) then
  f_TreeView.CTree.SetAllFlag(eeBT2L3BT[aMode], aFlags);
//#UC END# *531A06B90062_5319FAE701F7_impl*
end;//TeeTreeViewShadow.SetAllFlags

function TeeTreeViewShadow.GetNode(anIndex: Integer): IeeNode;
//#UC START# *531A06CB00A1_5319FAE701F7_var*
var
 l_Node: Il3Node;  
//#UC END# *531A06CB00A1_5319FAE701F7_var*
begin
//#UC START# *531A06CB00A1_5319FAE701F7_impl*
 if (f_TreeView = nil) OR (anIndex < 0) then
  Result := nil
 else
 begin
  if (f_TreeView.f_CurNode = nil) OR (anIndex <> Get_Current) then
  begin
(*   if (anIndex = 0) then
   begin
    l_Node := f_TreeView.TreeStruct.RootNode;
    if not f_TreeView.ShowRoot then
    begin
     if (l_Node <> nil) then
      l_Node := l_Node.ChildNode;
    end;//not f_TreeView.ShowRoot
   end//anIndex = 0
   else*) // - ��� ����������� ������, �.�. �� �������� � ������������� ��������
    Supports(f_TreeView.GetNode(anIndex), Il3SimpleNode, l_Node);
   Result := TeeNode.Make(l_Node)
  end//f_TreeView.f_CurNode = nil
  else
   Result := f_TreeView.f_CurNode;
 end;//f_TreeView = nil
//#UC END# *531A06CB00A1_5319FAE701F7_impl*
end;//TeeTreeViewShadow.GetNode

function TeeTreeViewShadow.GetNodeByAbsIndex(anAbsIndex: Integer): IeeNode;
//#UC START# *531A06DC0206_5319FAE701F7_var*
//#UC END# *531A06DC0206_5319FAE701F7_var*
begin
//#UC START# *531A06DC0206_5319FAE701F7_impl*
 if (f_TreeView = nil) OR (f_TreeView.TreeStruct = nil) then
  Result := nil
 else
  Result := TeeNode.Make(f_TreeView.CTree.GetNodeByAbsIndex(anAbsIndex));
//#UC END# *531A06DC0206_5319FAE701F7_impl*
end;//TeeTreeViewShadow.GetNodeByAbsIndex

function TeeTreeViewShadow.Wake: Boolean;
//#UC START# *531A06EE0061_5319FAE701F7_var*
//#UC END# *531A06EE0061_5319FAE701F7_var*
begin
//#UC START# *531A06EE0061_5319FAE701F7_impl*
 if (f_TreeView = nil) then
  Result := False
 else
  Result := f_TreeView.Wake;
//#UC END# *531A06EE0061_5319FAE701F7_impl*
end;//TeeTreeViewShadow.Wake

function TeeTreeViewShadow.IsExpanded(const aNode: IeeNode): Boolean;
//#UC START# *531A0701038A_5319FAE701F7_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *531A0701038A_5319FAE701F7_var*
begin
//#UC START# *531A0701038A_5319FAE701F7_impl*
 if (f_TreeView = nil) then
  Result := false
 else
 begin
  if Supports(aNode, Il3SimpleNode, l_Node) then
   try
    Result := f_TreeView.TreeStruct.IsExpanded(l_Node);
   finally
    l_Node := nil;
   end//try..finally
  else
   Result := false;
 end;//f_TreeView = nil
//#UC END# *531A0701038A_5319FAE701F7_impl*
end;//TeeTreeViewShadow.IsExpanded

function TeeTreeViewShadow.Get_Tree: IeeTree;
//#UC START# *531A07C3001B_5319FAE701F7get_var*
//#UC END# *531A07C3001B_5319FAE701F7get_var*
begin
//#UC START# *531A07C3001B_5319FAE701F7get_impl*
 Result := Self;
//#UC END# *531A07C3001B_5319FAE701F7get_impl*
end;//TeeTreeViewShadow.Get_Tree

function TeeTreeViewShadow.Get_Current: Integer;
//#UC START# *531A07D200DD_5319FAE701F7get_var*
//#UC END# *531A07D200DD_5319FAE701F7get_var*
begin
//#UC START# *531A07D200DD_5319FAE701F7get_impl*
 if (f_TreeView = nil) then
  Result := -1
 else
  Result := f_TreeView.Current;
//#UC END# *531A07D200DD_5319FAE701F7get_impl*
end;//TeeTreeViewShadow.Get_Current

procedure TeeTreeViewShadow.Set_Current(aValue: Integer);
//#UC START# *531A07D200DD_5319FAE701F7set_var*
//#UC END# *531A07D200DD_5319FAE701F7set_var*
begin
//#UC START# *531A07D200DD_5319FAE701F7set_impl*
 if (f_TreeView <> nil) then
  f_TreeView.Current := aValue;
//#UC END# *531A07D200DD_5319FAE701F7set_impl*
end;//TeeTreeViewShadow.Set_Current

function TeeTreeViewShadow.Get_AbsCurrent: Integer;
//#UC START# *531A07DB00DB_5319FAE701F7get_var*
var
 l_Node : Il3Node;
//#UC END# *531A07DB00DB_5319FAE701F7get_var*
begin
//#UC START# *531A07DB00DB_5319FAE701F7get_impl*
 if (f_TreeView = nil) then
  Result := -1
 else
 if Supports(Get_CurrentNode, Il3Node, l_Node) then
 try
  Result := f_TreeView.CTree.GetAbsIndex(l_Node);
 finally
  l_Node := nil;
 end//try..finally
 else
  Result := -1;
//#UC END# *531A07DB00DB_5319FAE701F7get_impl*
end;//TeeTreeViewShadow.Get_AbsCurrent

function TeeTreeViewShadow.Get_CurrentNode: IeeNode;
//#UC START# *531A080B0384_5319FAE701F7get_var*
//#UC END# *531A080B0384_5319FAE701F7get_var*
begin
//#UC START# *531A080B0384_5319FAE701F7get_impl*
 if (f_TreeView = nil) then
  Result := nil
 else
 if (Get_Current < 0) then
 begin
  f_TreeView.f_CurNode := nil;
  Result := nil;
 end//(Get_Current < 0)
 else
 if (f_TreeView.f_CurNode = nil) then
  Result := GetNode(Get_Current)
 else
  Result := f_TreeView.f_CurNode;
//#UC END# *531A080B0384_5319FAE701F7get_impl*
end;//TeeTreeViewShadow.Get_CurrentNode

function TeeTreeViewShadow.GetNodeIndex(const aNode: IeeNode): Integer;
//#UC START# *531A08350016_5319FAE701F7_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *531A08350016_5319FAE701F7_var*
begin
//#UC START# *531A08350016_5319FAE701F7_impl*
 if (f_TreeView = nil) then
  Result := -1
 else
 if Supports(aNode, Il3SimpleNode, l_Node) then
 try
  Result := f_TreeView.TreeStruct.GetIndex(l_Node);
 finally
  l_Node := nil;
 end//try..finally
 else
  Result := -1;
//#UC END# *531A08350016_5319FAE701F7_impl*
end;//TeeTreeViewShadow.GetNodeIndex

function TeeTreeViewShadow.GetNodeAbsIndex(const aNode: IeeNode): Integer;
//#UC START# *531A084E02CC_5319FAE701F7_var*
var
 l_Node: Il3Node;
//#UC END# *531A084E02CC_5319FAE701F7_var*
begin
//#UC START# *531A084E02CC_5319FAE701F7_impl*
 if (f_TreeView = nil) then
  Result := -1
 else
 if Supports(aNode, Il3Node, l_Node) then
 try
  Result := f_TreeView.CTree.GetAbsIndex(l_Node);
 finally
  l_Node := nil;
 end//try..finally
 else
  Result := -1;
//#UC END# *531A084E02CC_5319FAE701F7_impl*
end;//TeeTreeViewShadow.GetNodeAbsIndex

procedure TeeTreeViewShadow.ExpandAll;
//#UC START# *531A08620054_5319FAE701F7_var*
//#UC END# *531A08620054_5319FAE701F7_var*
begin
//#UC START# *531A08620054_5319FAE701F7_impl*
 if (f_TreeView <> nil) then
  f_TreeView.ExpandNodeOnDeep;
//#UC END# *531A08620054_5319FAE701F7_impl*
end;//TeeTreeViewShadow.ExpandAll

procedure TeeTreeViewShadow.CollapseAll;
//#UC START# *531A08680334_5319FAE701F7_var*
//#UC END# *531A08680334_5319FAE701F7_var*
begin
//#UC START# *531A08680334_5319FAE701F7_impl*
 if (f_TreeView <> nil) then
  f_TreeView.ExpandNodeOnDeep(nil, false);
//#UC END# *531A08680334_5319FAE701F7_impl*
end;//TeeTreeViewShadow.CollapseAll

function TeeTreeViewShadow.GoToNode(const aNode: IeeNode): LongInt;
//#UC START# *531A087102D4_5319FAE701F7_var*
 function CountLastVisible(const aNode: Il3Node) : Il3Node;
 var
  l_Current,
  l_Root     : Il3Node;
  l_AbsIndex : Integer;
 begin
  Result := nil;
  l_Current := aNode;
  try
   with f_TreeView do
   begin
    l_Root := TreeStruct.RootNode As Il3Node;
    try
     if l_Current.IsSame(l_Root) then
      Result := l_Current
     else
      while Assigned(l_Current) and
            not l_Current.IsSame(l_Root) do
      begin
       l_AbsIndex := CTree.GetAbsIndex(l_Current);
       if l_AbsIndex < 0 then // ��� ���������������� ������ Node �� �� �������� ������.
        Exit;
       if not CTree.TestFlagMask(l_AbsIndex, nfHidden) then
       begin
        if Result = nil then
         Result := l_Current;
       end
       else
        Result := nil;

       l_Current := l_Current.ParentNode;
      end;
    finally
     l_Root := nil;
    end;
   end;
  finally
   l_Current := nil;
  end;
 end;

var
 l_Visible, l_Node: Il3Node;
//#UC END# *531A087102D4_5319FAE701F7_var*
begin
//#UC START# *531A087102D4_5319FAE701F7_impl*
 if (f_TreeView = nil) then
  Result := -1
 else
 begin
  if Supports(aNode, Il3Node, l_Node) then
  try
   l_Visible := CountLastVisible(l_Node);
   if l_Visible = nil then
    Result := -1
   else
   try
    Result := f_TreeView.GotoOnNode(l_Visible);
   finally
    l_Visible := nil;
   end;
  finally
    l_Node := nil;
  end
 else
  Result := -1;
 end;//f_TreeView = nil
//#UC END# *531A087102D4_5319FAE701F7_impl*
end;//TeeTreeViewShadow.GoToNode

procedure TeeTreeViewShadow.Cleanup;
//#UC START# *479731C50290_5319FAE701F7_var*
//#UC END# *479731C50290_5319FAE701F7_var*
begin
//#UC START# *479731C50290_5319FAE701F7_impl*
 f_TreeView := nil;
 inherited;
//#UC END# *479731C50290_5319FAE701F7_impl*
end;//TeeTreeViewShadow.Cleanup
{$If not defined(DesignTimeLibrary)}

// start class TeeTreeState

constructor TeeTreeState.Create(const aTree: Il3SimpleTree;
  const aData: TvtOutlinerHystoryData);
//#UC START# *531F040903D7_531F03AA0018_var*
//#UC END# *531F040903D7_531F03AA0018_var*
begin
//#UC START# *531F040903D7_531F03AA0018_impl*
 inherited Create;
 SetTree(aTree, aData);
//#UC END# *531F040903D7_531F03AA0018_impl*
end;//TeeTreeState.Create

class function TeeTreeState.Make(const aTree: Il3SimpleTree;
  const aData: TvtOutlinerHystoryData): IeeTreeState;
var
 l_Inst : TeeTreeState;
begin
 l_Inst := Create(aTree, aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TeeTreeState.GetTree: Il3SimpleTree;
//#UC START# *531F034B00AA_531F03AA0018_var*
//#UC END# *531F034B00AA_531F03AA0018_var*
begin
//#UC START# *531F034B00AA_531F03AA0018_impl*
 Result := f_Tree;
//#UC END# *531F034B00AA_531F03AA0018_impl*
end;//TeeTreeState.GetTree

procedure TeeTreeState.SetTree(const aValue: Il3SimpleTree;
  const aData: TvtOutlinerHystoryData);
//#UC START# *531F036000C7_531F03AA0018_var*
//#UC END# *531F036000C7_531F03AA0018_var*
begin
//#UC START# *531F036000C7_531F03AA0018_impl*
 f_Tree := aValue;
 f_Data := aData;
//#UC END# *531F036000C7_531F03AA0018_impl*
end;//TeeTreeState.SetTree

function TeeTreeState.GetData: TvtOutlinerHystoryData;
//#UC START# *531F037602E5_531F03AA0018_var*
//#UC END# *531F037602E5_531F03AA0018_var*
begin
//#UC START# *531F037602E5_531F03AA0018_impl*
 Result := f_Data;
//#UC END# *531F037602E5_531F03AA0018_impl*
end;//TeeTreeState.GetData

procedure TeeTreeState.Cleanup;
//#UC START# *479731C50290_531F03AA0018_var*
//#UC END# *479731C50290_531F03AA0018_var*
begin
//#UC START# *479731C50290_531F03AA0018_impl*
 f_Tree := nil;
 inherited;
//#UC END# *479731C50290_531F03AA0018_impl*
end;//TeeTreeState.Cleanup

function TeeTreeState.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_531F03AA0018_var*
//#UC END# *4A60B23E00C3_531F03AA0018_var*
begin
//#UC START# *4A60B23E00C3_531F03AA0018_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if Supports(f_Tree, IID.IID, Obj) then
   Result.SetOk
  else
   Result.SetNoInterface;
//#UC END# *4A60B23E00C3_531F03AA0018_impl*
end;//TeeTreeState.COMQueryInterface

{$IfEnd} //not DesignTimeLibrary

//#UC START# *499C0B7B012Eimpl*
//#UC END# *499C0B7B012Eimpl*

initialization
{$If not defined(NoScripts)}
// ����������� TeeTreeViewExportPrim
 TtfwClassRef.Register(TeeTreeViewExportPrim);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� TeeTreeViewExport
 TtfwClassRef.Register(TeeTreeViewExport);
{$IfEnd} //not NoScripts

end.