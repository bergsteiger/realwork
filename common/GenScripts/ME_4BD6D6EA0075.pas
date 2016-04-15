unit PrimWorkJournal_Form;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournal_Form.pas"
// ���������: "VCMForm"
// ������� ������: "PrimWorkJournal" MUID: (4BD6D6EA0075)
// ��� ����: "TPrimWorkJournalForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 , WorkJournal_Strange_Controls
 , nscTreeViewWithAdapterDragDrop
 , l3TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TPrimWorkJournalForm = class(TvcmEntityForm)
  private
   f_JournalTree: TnscTreeViewWithAdapterDragDrop;
    {* ���� ��� �������� JournalTree }
  private
   procedure JournalTreeMakeTreeSource(out theTree: Il3SimpleTree);
   function JournalTreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure JournalTreeActionElement(Sender: TObject;
    Index: LongInt);
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SetupFormLayout; override;
    {* ��� ����� ��������� ������� ��� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
    {* ������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
    {* ���������� ��� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
    {* �������� ��� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure SavedQuery_OpenQuery_Test(const aParams: IvcmTestParamsPrim);
   procedure SavedQuery_OpenQuery_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SavedQuery_ExecuteQuery_Test(const aParams: IvcmTestParamsPrim);
   procedure SavedQuery_ExecuteQuery_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Journal_Clear_Test(const aParams: IvcmTestParamsPrim);
   procedure Journal_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
   {$If NOT Defined(NoVCM)}
   procedure SetActiveControl; override;
    {* ������������� ������� �������. �����? ���� ����� ������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property JournalTree: TnscTreeViewWithAdapterDragDrop
    read f_JournalTree;
 end;//TPrimWorkJournalForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , FoldersRes
 , DynamicTreeUnit
 , SysUtils
 , UserJournalUnit
 , eeInterfaces
 , BaseTypesUnit
 , nsOpenUtils
 , nsQueryUtils
 , SearchUnit
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , evdTextStyle_Const
 , l3Interfaces
 , nsConst
 , afwFacade
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimWorkJournal_utWorkJournal_UserType
;

{$If NOT Defined(NoVCM)}
const
 {* ������������ ������ utWorkJournalLocalConstants }
 str_utWorkJournalCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utWorkJournalCaption'; rValue : '������ ������');
  {* ��������� ����������������� ���� "������ ������" }

procedure TPrimWorkJournalForm.JournalTreeMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *527D09DB0041_4BD6D6EA0075_var*
//#UC END# *527D09DB0041_4BD6D6EA0075_var*
begin
//#UC START# *527D09DB0041_4BD6D6EA0075_impl*
 theTree := TdmStdRes.MakeWorkJournal.MakeTree;
//#UC END# *527D09DB0041_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.JournalTreeMakeTreeSource

function TPrimWorkJournalForm.JournalTreeGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *527D09E502F1_4BD6D6EA0075_var*
var
 l_eeNode: IeeNode;
 l_AdapterNode: INodeBase;
//#UC END# *527D09E502F1_4BD6D6EA0075_var*
begin
//#UC START# *527D09E502F1_4BD6D6EA0075_impl*
 if Index >= 0 then
 begin
  l_eeNode := JournalTree.TreeView.GetNode(Index);
  try
   if Supports(l_eeNode, INodeBase, l_AdapterNode) then
   begin
    case TJournalObjectType(l_AdapterNode.GetType) of
     JOT_BOOKMARK: Result := BookmarkIcon;
     JOT_QUERY: Result := QueryIcon;
     JOT_FOLDER: Result := FolderIcon;
     else
      Result := 0;
    end;//case TJournalObjectType(l_AdapterNode.GetType) of
   end//if Supports(l_eeNode, INodeBase, l_AdapterNode) then
   else
    Result := FolderIcon;
  finally
   l_eeNode := nil;
  end;{try..finally}
 end//if Index >= 0 then
 else
  Result := 0;
//#UC END# *527D09E502F1_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.JournalTreeGetItemImage

procedure TPrimWorkJournalForm.JournalTreeActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *527D09F100BA_4BD6D6EA0075_var*
var
 //l_Params: IvcmExecuteParams;
 l_ItemType: TJournalObjectType;
 l_AdapterNode: INodeBase;
 l_eeNode: Il3SimpleNode;
//#UC END# *527D09F100BA_4BD6D6EA0075_var*
begin
//#UC START# *527D09F100BA_4BD6D6EA0075_impl*
 if (Container.AsForm.ZoneType <> vcm_ztManualModal) then
 begin
  l_eeNode := JournalTree.GetNode(Index);
  try
   if Supports(l_eeNode, INodeBase, l_AdapterNode) then
   try
    l_ItemType := TJournalObjectType(l_AdapterNode.GetType);
    if l_ItemType <> JOT_FOLDER then
     OpenJournalElement(self.as_IvcmEntityForm, l_eeNode, vcm_okInCurrentTab)
    else
    if l_eeNode.HasChild then
     JournalTree.TreeStruct.ChangeExpand(l_eeNode, sbInvert);
   finally
    l_AdapterNode := nil;
   end;
  finally
   l_eeNode := nil;
  end;//try..finally
 end//(Container.AsForm.ZoneType <> vcm_ztManualModal
//#UC END# *527D09F100BA_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.JournalTreeActionElement

procedure TPrimWorkJournalForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
 {* ������� }
//#UC START# *494F89C30197_4BD6D6EA0075test_var*
//#UC END# *494F89C30197_4BD6D6EA0075test_var*
begin
//#UC START# *494F89C30197_4BD6D6EA0075test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := JournalTree.TreeView.Current >= 0;
//#UC END# *494F89C30197_4BD6D6EA0075test_impl*
end;//TPrimWorkJournalForm.Edit_Delete_Test

procedure TPrimWorkJournalForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
 {* ������� }
//#UC START# *494F89C30197_4BD6D6EA0075exec_var*
//#UC END# *494F89C30197_4BD6D6EA0075exec_var*
begin
//#UC START# *494F89C30197_4BD6D6EA0075exec_impl*
 TdmStdRes.MakeWorkJournal.Delete(JournalTree.GetCurrentNode);
//#UC END# *494F89C30197_4BD6D6EA0075exec_impl*
end;//TPrimWorkJournalForm.Edit_Delete_Execute

procedure TPrimWorkJournalForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
 {* ������� }
//#UC START# *494F89C30197_4BD6D6EA0075getstate_var*
//#UC END# *494F89C30197_4BD6D6EA0075getstate_var*
begin
//#UC START# *494F89C30197_4BD6D6EA0075getstate_impl*
 // - ������ �� ������
//#UC END# *494F89C30197_4BD6D6EA0075getstate_impl*
end;//TPrimWorkJournalForm.Edit_Delete_GetState

procedure TPrimWorkJournalForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
 {* ���������� ��� }
//#UC START# *4BDAF7880236_4BD6D6EA0075test_var*
//#UC END# *4BDAF7880236_4BD6D6EA0075test_var*
begin
//#UC START# *4BDAF7880236_4BD6D6EA0075test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := JournalTree.TreeView.Current >= 0;
//#UC END# *4BDAF7880236_4BD6D6EA0075test_impl*
end;//TPrimWorkJournalForm.Tree_ExpandAll_Test

procedure TPrimWorkJournalForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
 {* �������� ��� }
//#UC START# *4BDAF7A2005C_4BD6D6EA0075test_var*
//#UC END# *4BDAF7A2005C_4BD6D6EA0075test_var*
begin
//#UC START# *4BDAF7A2005C_4BD6D6EA0075test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := JournalTree.TreeView.Current >= 0;
//#UC END# *4BDAF7A2005C_4BD6D6EA0075test_impl*
end;//TPrimWorkJournalForm.Tree_CollapseAll_Test

procedure TPrimWorkJournalForm.SavedQuery_OpenQuery_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3F3421036A_4BD6D6EA0075test_var*
var
 l_Node: INodeBase;
//#UC END# *4C3F3421036A_4BD6D6EA0075test_var*
begin
//#UC START# *4C3F3421036A_4BD6D6EA0075test_impl*
 aParams.Op.Flag[vcm_ofEnabled] :=
  Supports(JournalTree.TreeView.CurrentNode, INodeBase, l_Node) and
  (TJournalObjectType(l_Node.GetType) = JOT_QUERY);
//#UC END# *4C3F3421036A_4BD6D6EA0075test_impl*
end;//TPrimWorkJournalForm.SavedQuery_OpenQuery_Test

procedure TPrimWorkJournalForm.SavedQuery_OpenQuery_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3F3421036A_4BD6D6EA0075exec_var*
var
 l_eeNode      : IeeNode;
 l_AdapterNode : INodeBase;
 l_BaseEntity  : IUnknown;
//#UC END# *4C3F3421036A_4BD6D6EA0075exec_var*
begin
//#UC START# *4C3F3421036A_4BD6D6EA0075exec_impl*
 with JournalTree.TreeView do
 begin
  l_eeNode := CurrentNode;
  try
   if Supports(l_eeNode, INodeBase, l_AdapterNode) then
    try
     try
      l_AdapterNode.GetEntity(l_BaseEntity);
     except
      on ECanNotFindData do
       exit; //TODO: ���� "�������" ��� ������?
     end;
     try
      OpenQuery(l_BaseEntity);
     finally
      l_BaseEntity := nil;
     end;
    finally
     l_AdapterNode := nil;
    end;
  finally
   l_eeNode := nil;
  end;
 end;
//#UC END# *4C3F3421036A_4BD6D6EA0075exec_impl*
end;//TPrimWorkJournalForm.SavedQuery_OpenQuery_Execute

procedure TPrimWorkJournalForm.SavedQuery_ExecuteQuery_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3F342E02AF_4BD6D6EA0075test_var*
//#UC END# *4C3F342E02AF_4BD6D6EA0075test_var*
begin
//#UC START# *4C3F342E02AF_4BD6D6EA0075test_impl*
 SavedQuery_OpenQuery_Test(aParams);
//#UC END# *4C3F342E02AF_4BD6D6EA0075test_impl*
end;//TPrimWorkJournalForm.SavedQuery_ExecuteQuery_Test

procedure TPrimWorkJournalForm.SavedQuery_ExecuteQuery_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3F342E02AF_4BD6D6EA0075exec_var*
var
 l_eeNode : IeeNode;
 l_AdapterNode : INodeBase;
 l_BaseEntity : IUnknown;
 l_Query: IQuery;
//#UC END# *4C3F342E02AF_4BD6D6EA0075exec_var*
begin
//#UC START# *4C3F342E02AF_4BD6D6EA0075exec_impl*
 with JournalTree.TreeView do
 begin
  l_eeNode := CurrentNode;
  try
   if Supports(l_eeNode, INodeBase, l_AdapterNode) then
    try
     try
      l_AdapterNode.GetEntity(l_BaseEntity);
     except
      on ECanNotFindData do
       Exit; //TODO: ���� "�������" ��� ������?
     end;
     try
      l_Query := l_BaseEntity As IQuery;
      try
       if l_Query.GetType = QT_BASE_SEARCH then
        OpenQuery(l_Query);
       nsSearch(l_Query, nil, nil, NativeMainForm);
      finally
       l_Query := nil;
      end;
     finally
      l_BaseEntity := nil;
     end;//try..finally
    finally
     l_AdapterNode := nil;
    end;//try..finally
  finally
   l_eeNode := nil;
  end;//try..finally
 end;//with JournalTree.TreeView
//#UC END# *4C3F342E02AF_4BD6D6EA0075exec_impl*
end;//TPrimWorkJournalForm.SavedQuery_ExecuteQuery_Execute

procedure TPrimWorkJournalForm.Journal_Clear_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3F348402AC_4BD6D6EA0075test_var*
//#UC END# *4C3F348402AC_4BD6D6EA0075test_var*
begin
//#UC START# *4C3F348402AC_4BD6D6EA0075test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := JournalTree.TreeView.Current >= 0;
//#UC END# *4C3F348402AC_4BD6D6EA0075test_impl*
end;//TPrimWorkJournalForm.Journal_Clear_Test

procedure TPrimWorkJournalForm.Journal_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3F348402AC_4BD6D6EA0075exec_var*
//#UC END# *4C3F348402AC_4BD6D6EA0075exec_var*
begin
//#UC START# *4C3F348402AC_4BD6D6EA0075exec_impl*
 TdmStdRes.MakeWorkJournal.Clear;
//#UC END# *4C3F348402AC_4BD6D6EA0075exec_impl*
end;//TPrimWorkJournalForm.Journal_Clear_Execute

procedure TPrimWorkJournalForm.DoInit(aFromHistory: Boolean);
 {* ������������� �����. ��� ���������� � �������� }
//#UC START# *49803F5503AA_4BD6D6EA0075_var*
//#UC END# *49803F5503AA_4BD6D6EA0075_var*
begin
//#UC START# *49803F5503AA_4BD6D6EA0075_impl*
 inherited;
 JournalTree.Images := nsFoldersRes.FoldersItemImages;
//#UC END# *49803F5503AA_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.DoInit

procedure TPrimWorkJournalForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4BD6D6EA0075_var*
//#UC END# *4A8E8F2E0195_4BD6D6EA0075_var*
begin
//#UC START# *4A8E8F2E0195_4BD6D6EA0075_impl*
 inherited;
 ActiveControl := JournalTree;
 with JournalTree do
 begin
  BorderStyle := bsNone;
  Align := alClient;
  ShowHeader := False;
  PickedList := False;
  MultiSelect := False;
  MultiStrokeItem := False;
  ActionElementMode := l3_amSecondSingleClick;
  AllowWithoutCurrent := False;
  OnMakeTreeSource := JournalTreeMakeTreeSource;
  OnGetItemImage := JournalTreeGetItemImage;
  OnActionElement := JournalTreeActionElement;
  DragAndDropSupported := True;
  FooterVisible := False;

  StyleId := evd_saInterface;
  FooterStyleID := evd_saHyperLink;
  FooterActiveStyleID := evd_saActiveHyperLink;
  SettingId := 'stidJournalTree';
 end;
//#UC END# *4A8E8F2E0195_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.InitControls

procedure TPrimWorkJournalForm.SetActiveControl;
 {* ������������� ������� �������. �����? ���� ����� ������. ��� ���������� � �������� }
//#UC START# *4AC3803A03CD_4BD6D6EA0075_var*
//#UC END# *4AC3803A03CD_4BD6D6EA0075_var*
begin
//#UC START# *4AC3803A03CD_4BD6D6EA0075_impl*
 Windows.SetFocus(JournalTree.Handle);
//#UC END# *4AC3803A03CD_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.SetActiveControl

procedure TPrimWorkJournalForm.SetupFormLayout;
 {* ��� ����� ��������� ������� ��� ����� }
//#UC START# *529332B40230_4BD6D6EA0075_var*
//#UC END# *529332B40230_4BD6D6EA0075_var*
begin
//#UC START# *529332B40230_4BD6D6EA0075_impl*
 inherited;
 Width := 286;
 Height := 478;
//#UC END# *529332B40230_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.SetupFormLayout

initialization
 str_utWorkJournalCaption.Init;
 {* ������������� str_utWorkJournalCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimWorkJournalForm);
 {* ����������� PrimWorkJournal }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
