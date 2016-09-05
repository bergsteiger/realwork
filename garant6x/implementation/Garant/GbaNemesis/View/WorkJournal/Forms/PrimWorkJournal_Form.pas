unit PrimWorkJournal_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\WorkJournal\Forms\PrimWorkJournal_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimWorkJournal" MUID: (4BD6D6EA0075)
// Имя типа: "TPrimWorkJournalForm"

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
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimWorkJournalForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_JournalTree: TnscTreeViewWithAdapterDragDrop;
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
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure SetupFormLayout; override;
    {* Тут можно настроить внешний вид формы }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
    {* Свернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure SavedQuery_OpenQuery_Test(const aParams: IvcmTestParamsPrim);
   procedure SavedQuery_OpenQuery_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SavedQuery_ExecuteQuery_Test(const aParams: IvcmTestParamsPrim);
   procedure SavedQuery_ExecuteQuery_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Journal_Clear_Test(const aParams: IvcmTestParamsPrim);
   procedure Journal_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
   {$If NOT Defined(NoVCM)}
   procedure SetActiveControl; override;
    {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimWorkJournal_utWorkJournal_UserType
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4BD6D6EA0075impl_uses*
 , l3ControlsTypes
 , Base_Operations_F1Services_Contracts
 //#UC END# *4BD6D6EA0075impl_uses*
;

{$If NOT Defined(NoVCM)}
procedure TPrimWorkJournalForm.JournalTreeMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *527D09DB0041_4BD6D6EA0075_var*
//#UC END# *527D09DB0041_4BD6D6EA0075_var*
begin
//#UC START# *527D09DB0041_4BD6D6EA0075_impl*
 theTree := TWorkJournalService.Instance.MakeWorkJournal.MakeTree;
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
 {* Удалить }
//#UC START# *494F89C30197_4BD6D6EA0075test_var*
//#UC END# *494F89C30197_4BD6D6EA0075test_var*
begin
//#UC START# *494F89C30197_4BD6D6EA0075test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := JournalTree.TreeView.Current >= 0;
//#UC END# *494F89C30197_4BD6D6EA0075test_impl*
end;//TPrimWorkJournalForm.Edit_Delete_Test

procedure TPrimWorkJournalForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Удалить }
//#UC START# *494F89C30197_4BD6D6EA0075exec_var*
//#UC END# *494F89C30197_4BD6D6EA0075exec_var*
begin
//#UC START# *494F89C30197_4BD6D6EA0075exec_impl*
 TWorkJournalService.Instance.MakeWorkJournal.Delete(JournalTree.GetCurrentNode);
//#UC END# *494F89C30197_4BD6D6EA0075exec_impl*
end;//TPrimWorkJournalForm.Edit_Delete_Execute

procedure TPrimWorkJournalForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
 {* Удалить }
//#UC START# *494F89C30197_4BD6D6EA0075getstate_var*
//#UC END# *494F89C30197_4BD6D6EA0075getstate_var*
begin
//#UC START# *494F89C30197_4BD6D6EA0075getstate_impl*
 // - ничего не делаем
//#UC END# *494F89C30197_4BD6D6EA0075getstate_impl*
end;//TPrimWorkJournalForm.Edit_Delete_GetState

procedure TPrimWorkJournalForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
 {* Развернуть все }
//#UC START# *4BDAF7880236_4BD6D6EA0075test_var*
//#UC END# *4BDAF7880236_4BD6D6EA0075test_var*
begin
//#UC START# *4BDAF7880236_4BD6D6EA0075test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := JournalTree.TreeView.Current >= 0;
//#UC END# *4BDAF7880236_4BD6D6EA0075test_impl*
end;//TPrimWorkJournalForm.Tree_ExpandAll_Test

procedure TPrimWorkJournalForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
 {* Свернуть все }
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
       exit; //TODO: нода "пропала" что делать?
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
       Exit; //TODO: нода "пропала" что делать?
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
 TWorkJournalService.Instance.MakeWorkJournal.Clear;
//#UC END# *4C3F348402AC_4BD6D6EA0075exec_impl*
end;//TPrimWorkJournalForm.Journal_Clear_Execute

procedure TPrimWorkJournalForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4BD6D6EA0075_var*
//#UC END# *49803F5503AA_4BD6D6EA0075_var*
begin
//#UC START# *49803F5503AA_4BD6D6EA0075_impl*
 inherited;
 JournalTree.Images := nsFoldersRes.FoldersItemImages;
//#UC END# *49803F5503AA_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.DoInit

procedure TPrimWorkJournalForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
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
 {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
//#UC START# *4AC3803A03CD_4BD6D6EA0075_var*
//#UC END# *4AC3803A03CD_4BD6D6EA0075_var*
begin
//#UC START# *4AC3803A03CD_4BD6D6EA0075_impl*
 Windows.SetFocus(JournalTree.Handle);
//#UC END# *4AC3803A03CD_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.SetActiveControl

procedure TPrimWorkJournalForm.SetupFormLayout;
 {* Тут можно настроить внешний вид формы }
//#UC START# *529332B40230_4BD6D6EA0075_var*
//#UC END# *529332B40230_4BD6D6EA0075_var*
begin
//#UC START# *529332B40230_4BD6D6EA0075_impl*
 inherited;
 Width := 286;
 Height := 478;
//#UC END# *529332B40230_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.SetupFormLayout

procedure TPrimWorkJournalForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_SavedQuery, nil);
  PublishFormEntity(en_Journal, nil);
  ContextMenuWeight(en_Tree, 1);
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, Edit_Delete_GetState);
  ShowInContextMenu(en_Edit, op_Delete, True);
  ShowInToolbar(en_Edit, op_Delete, True);
  PublishOp(en_Tree, op_ExpandAll, nil, Tree_ExpandAll_Test, nil);
  ShowInContextMenu(en_Tree, op_ExpandAll, True);
  ShowInToolbar(en_Tree, op_ExpandAll, True);
  PublishOp(en_Tree, op_CollapseAll, nil, Tree_CollapseAll_Test, nil);
  ShowInContextMenu(en_Tree, op_CollapseAll, True);
  ShowInToolbar(en_Tree, op_CollapseAll, True);
  PublishOp(en_SavedQuery, op_OpenQuery, SavedQuery_OpenQuery_Execute, SavedQuery_OpenQuery_Test, nil);
  ShowInContextMenu(en_SavedQuery, op_OpenQuery, True);
  PublishOp(en_SavedQuery, op_ExecuteQuery, SavedQuery_ExecuteQuery_Execute, SavedQuery_ExecuteQuery_Test, nil);
  ShowInContextMenu(en_SavedQuery, op_ExecuteQuery, True);
  PublishOp(en_Journal, op_Clear, Journal_Clear_Execute, Journal_Clear_Test, nil);
  ShowInContextMenu(en_Journal, op_Clear, True);
  ShowInToolbar(en_Journal, op_Clear, True);
 end;//with Entities.Entities
end;//TPrimWorkJournalForm.InitEntities

procedure TPrimWorkJournalForm.MakeControls;
begin
 inherited;
 with AddUsertype(utWorkJournalName,
  str_utWorkJournalCaption,
  str_utWorkJournalCaption,
  True,
  128,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utWorkJournalName
 f_JournalTree := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_JournalTree.Name := 'JournalTree';
 f_JournalTree.Parent := Self;
end;//TPrimWorkJournalForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimWorkJournalForm);
 {* Регистрация PrimWorkJournal }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
