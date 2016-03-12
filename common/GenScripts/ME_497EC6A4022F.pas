unit PrimTreeAttributeFirstLevel_Form;
 {* ������ ������� ������ ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimTreeAttributeFirstLevel_Form.pas"
// ���������: "VCMForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , TreeAttribute_Form
 , SearchLite_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , TreeInterfaces
 , QueryCardInterfaces
 , nscTreeViewWithAdapterDragDrop
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TreeInterfaces
 , DynamicTreeUnit
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimTreeAttributeFirstLevelForm = {abstract} class(TTreeAttributeForm)
  {* ������ ������� ������ ��������� }
  private
   f_FirstLevelContent: TnscTreeViewWithAdapterDragDrop;
    {* ���� ��� �������� FirstLevelContent }
  protected
   dsSimpleTree: IdsSimpleTree;
   dsTreeAttributeFirstLevel: IdsTreeAttributeFirstLevel;
   f_InternalMove: Integer;
  private
   function FirstLevelContentGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure FirstLevelContentCurrentChanged(aSender: TObject;
    aNewCurrent: Integer;
    aOldCurrent: Integer);
   procedure FirstLevelContentNewCharPressed(aChar: AnsiChar);
   procedure UpdateCurrent(const aNode: Il3SimpleNode);
  protected
   procedure CurrentChangedNotification(const aNode: Il3SimpleNode); override;
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* ��������� �������� ������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure AttributeTree_SetParent_Execute(const aParent: Il3SimpleNode);
   procedure AttributeTree_SetParent(const aParams: IvcmExecuteParamsPrim);
   procedure AttributeTree_ExtSetRoot_Execute(const aRoot: INodeBase);
   procedure AttributeTree_ExtSetRoot(const aParams: IvcmExecuteParamsPrim);
   procedure AttributeTree_SetRoot_Execute(const aTag: Il3CString);
   procedure AttributeTree_SetRoot(const aParams: IvcmExecuteParamsPrim);
   {$If NOT Defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
    {* ���������� ��� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
    {* �������� ��� }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property FirstLevelContent: TnscTreeViewWithAdapterDragDrop
    read f_FirstLevelContent;
 end;//TPrimTreeAttributeFirstLevelForm
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3Base
 , nsAttributeOneLevelTreeStruct
 , SearchRes
 , nsTypes
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ flSituationLocalConstants }
 str_flSituationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'flSituationCaption'; rValue : '�������� ������� ������ (�������)');
  {* ��������� ����������������� ���� "�������� ������� ������ (�������)" }
 str_flSituationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'flSituationSettingsCaption'; rValue : '�����: �������� ������� ������ (�������)');
  {* ��������� ����������������� ���� "�������� ������� ������ (�������)" ��� ��������� ������� ������������ }

function TPrimTreeAttributeFirstLevelForm.FirstLevelContentGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *52728D2A036D_497EC6A4022F_var*
{var
 l_l3Node    : Il3SimpleNode;
 l_Node      : INodeBase;}
//#UC END# *52728D2A036D_497EC6A4022F_var*
begin
//#UC START# *52728D2A036D_497EC6A4022F_impl*
 Result := siilFolderStart;
// !! ��� ���� ��������� ������ ������ � �������� ���������� �� ������� �����
// �.�. ���� � CreateOneLevelView ������ ���������� HasChild = 0
{ l_l3Node := FirstLevelContent.GetNode(Index);
 try
  if Supports(l_l3Node, INodeBase, l_Node) then
  begin
   if l_Node.HasChildren then
    Result := siilFolderStart
   else
    Result := siilElementStart;

   l_Node := nil;
  end;
 finally
  l_l3Node := nil;
 end;}
//#UC END# *52728D2A036D_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.FirstLevelContentGetItemImage

procedure TPrimTreeAttributeFirstLevelForm.FirstLevelContentCurrentChanged(aSender: TObject;
 aNewCurrent: Integer;
 aOldCurrent: Integer);
//#UC START# *52728D32009E_497EC6A4022F_var*
//#UC END# *52728D32009E_497EC6A4022F_var*
begin
//#UC START# *52728D32009E_497EC6A4022F_impl*
 if (aNewCurrent >= 0) and (f_InternalMove = 0) then
 begin
  if (dsSimpleTree <> nil) then
   dsSimpleTree.CurrentChanged(FirstLevelContent.GetNode(aNewCurrent));
  // ������������� �������������� ������, ��� ������ ����� ������������ �����
  // �� ������ ��������� ������� ����\�����
  FirstLevelContent.Update;
 end//if (aNewCurrent >= 0) and (f_InternalMove = 0) then
//#UC END# *52728D32009E_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.FirstLevelContentCurrentChanged

procedure TPrimTreeAttributeFirstLevelForm.FirstLevelContentNewCharPressed(aChar: AnsiChar);
//#UC START# *52728D3A0299_497EC6A4022F_var*
//#UC END# *52728D3A0299_497EC6A4022F_var*
begin
//#UC START# *52728D3A0299_497EC6A4022F_impl*
 op_AttributeTree_ExternalCharPressed.Call(Aggregate, nsCStr(aChar));
//#UC END# *52728D3A0299_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.FirstLevelContentNewCharPressed

procedure TPrimTreeAttributeFirstLevelForm.UpdateCurrent(const aNode: Il3SimpleNode);
//#UC START# *52728FBC02D2_497EC6A4022F_var*
//#UC END# *52728FBC02D2_497EC6A4022F_var*
begin
//#UC START# *52728FBC02D2_497EC6A4022F_impl*
 Inc(f_InternalMove);
 try
  if (FirstLevelContent.GetCurrentNode <> nil) and
     (FirstLevelContent.GetCurrentNode.IsSame(aNode)) then
   FirstLevelContent.vlbMakeItemVisible(FirstLevelContent.Current)
  else
   FirstLevelContent.GotoOnNode(aNode);
 finally
  Dec(f_InternalMove);
 end;
//#UC END# *52728FBC02D2_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.UpdateCurrent

procedure TPrimTreeAttributeFirstLevelForm.CurrentChangedNotification(const aNode: Il3SimpleNode);
//#UC START# *497465F501B7_497EC6A4022F_var*
//#UC END# *497465F501B7_497EC6A4022F_var*
begin
//#UC START# *497465F501B7_497EC6A4022F_impl*
 UpdateCurrent(aNode);
//#UC END# *497465F501B7_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.CurrentChangedNotification

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_SetParent_Execute(const aParent: Il3SimpleNode);
//#UC START# *4AEF129601AC_497EC6A4022Fexec_var*
//#UC END# *4AEF129601AC_497EC6A4022Fexec_var*
begin
//#UC START# *4AEF129601AC_497EC6A4022Fexec_impl*
 UpdateCurrent(aParent);
//#UC END# *4AEF129601AC_497EC6A4022Fexec_impl*
end;//TPrimTreeAttributeFirstLevelForm.AttributeTree_SetParent_Execute

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_SetParent(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IAttributeTree_SetParent_Params) do
  Self.AttributeTree_SetParent_Execute(Parent);
end;//TPrimTreeAttributeFirstLevelForm.AttributeTree_SetParent

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_ExtSetRoot_Execute(const aRoot: INodeBase);
//#UC START# *4AEF14460025_497EC6A4022Fexec_var*
//#UC END# *4AEF14460025_497EC6A4022Fexec_var*
begin
//#UC START# *4AEF14460025_497EC6A4022Fexec_impl*
 Inc(f_InternalMove);
 try
  with FirstLevelContent do
   if (TreeStruct <> nil) then
   begin
    Changing;
    try
     TreeStruct := TnsAttributeOneLevelTreeStruct.Make(aRoot, TreeStruct);
    finally
     Changed;
    end;//try..finally
   end//TreeStruct <> nil
   else // � ��� ����� �������� �� ������
    Assert(False);
  CCaption := l3CStr(FirstLevelContent.TreeStruct.RootNode);
 finally
  Dec(f_InternalMove);
 end;//try..finally
//#UC END# *4AEF14460025_497EC6A4022Fexec_impl*
end;//TPrimTreeAttributeFirstLevelForm.AttributeTree_ExtSetRoot_Execute

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_ExtSetRoot(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IAttributeTree_ExtSetRoot_Params) do
  Self.AttributeTree_ExtSetRoot_Execute(Root);
end;//TPrimTreeAttributeFirstLevelForm.AttributeTree_ExtSetRoot

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_SetRoot_Execute(const aTag: Il3CString);
//#UC START# *4AF3EBC001C4_497EC6A4022Fexec_var*
//#UC END# *4AF3EBC001C4_497EC6A4022Fexec_var*
begin
//#UC START# *4AF3EBC001C4_497EC6A4022Fexec_impl*
 Inc(f_InternalMove);
 try
  FirstLevelContent.TreeStruct :=
   TnsAttributeOneLevelTreeStruct.Make(aTag,
                                       FirstLevelContent.ShowRoot,
                                       True);
  if Assigned(FirstLevelContent.TreeStruct.RootNode) then
   CCaption := l3CStr(FirstLevelContent.TreeStruct.RootNode);
 finally
  Dec(f_InternalMove);
 end;//try..finally
//#UC END# *4AF3EBC001C4_497EC6A4022Fexec_impl*
end;//TPrimTreeAttributeFirstLevelForm.AttributeTree_SetRoot_Execute

procedure TPrimTreeAttributeFirstLevelForm.AttributeTree_SetRoot(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IAttributeTree_SetRoot_Params) do
  Self.AttributeTree_SetRoot_Execute(Tag);
end;//TPrimTreeAttributeFirstLevelForm.AttributeTree_SetRoot

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeFirstLevelForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
 {* ���������� ��� }
//#UC START# *4BDAF7880236_497EC6A4022Ftest_var*
//#UC END# *4BDAF7880236_497EC6A4022Ftest_var*
begin
//#UC START# *4BDAF7880236_497EC6A4022Ftest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7880236_497EC6A4022Ftest_impl*
end;//TPrimTreeAttributeFirstLevelForm.Tree_ExpandAll_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeFirstLevelForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
 {* �������� ��� }
//#UC START# *4BDAF7A2005C_497EC6A4022Ftest_var*
//#UC END# *4BDAF7A2005C_497EC6A4022Ftest_var*
begin
//#UC START# *4BDAF7A2005C_497EC6A4022Ftest_impl*
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4BDAF7A2005C_497EC6A4022Ftest_impl*
end;//TPrimTreeAttributeFirstLevelForm.Tree_CollapseAll_Test
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimTreeAttributeFirstLevelForm.InitFields;
//#UC START# *47A042E100E2_497EC6A4022F_var*
//#UC END# *47A042E100E2_497EC6A4022F_var*
begin
//#UC START# *47A042E100E2_497EC6A4022F_impl*
 inherited;
 FirstLevelContent.Images := nsSearchRes.SearchItemsImageList;
 ActiveControl := FirstLevelContent;
//#UC END# *47A042E100E2_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.InitFields

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeFirstLevelForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* ��������� �������� ������. ��� ���������� � �������� }
//#UC START# *497469C90140_497EC6A4022F_var*
//#UC END# *497469C90140_497EC6A4022F_var*
begin
//#UC START# *497469C90140_497EC6A4022F_impl*
 inherited;
 if (dsTreeAttributeFirstLevel <> nil) then
 begin
  CCaption := dsTreeAttributeFirstLevel.DisplayName;
  // ������ � �������� vs. ������� vs. _datasource
  if not Dispatcher.History.InBF then
   FirstLevelContent.TreeStruct := dsTreeAttributeFirstLevel.SimpleTree;
 end;//(dsTreeAttributeFirstLevel <> nil)
//#UC END# *497469C90140_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.NotifyDataSourceChanged
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimTreeAttributeFirstLevelForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_497EC6A4022F_var*
//#UC END# *4A8E8F2E0195_497EC6A4022F_var*
begin
//#UC START# *4A8E8F2E0195_497EC6A4022F_impl*
 inherited;
 with FirstLevelContent do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  ViewOptions := [voShowIcons];
  OnGetItemImage := FirstLevelContentGetItemImage;
  OnCurrentChanged := FirstLevelContentCurrentChanged;
  OnNewCharPressed := FirstLevelContentNewCharPressed;
  SettingId := 'stidFirstLevelContent';
 end;
//#UC END# *4A8E8F2E0195_497EC6A4022F_impl*
end;//TPrimTreeAttributeFirstLevelForm.InitControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_flSituationCaption.Init;
 {* ������������� str_flSituationCaption }
 str_flSituationSettingsCaption.Init;
 {* ������������� str_flSituationSettingsCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimTreeAttributeFirstLevelForm);
 {* ����������� PrimTreeAttributeFirstLevel }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
