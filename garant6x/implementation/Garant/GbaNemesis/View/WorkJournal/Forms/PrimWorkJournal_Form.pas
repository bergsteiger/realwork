unit PrimWorkJournal_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkJournal/Forms/PrimWorkJournal_Form.pas"
// Начат: 27.04.2010 16:22
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Основные прецеденты::WorkJournal::View::WorkJournal::PrimWorkJournal
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3TreeInterfaces,
  l3ControlsTypes,
  eeTreeView
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmEntityForm
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  Base_Operations_Strange_Controls,
  Base_Operations_Editions_Controls
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  l3StringIDEx
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Tree_Controls
  {$IfEnd} //not NoVCM
  ,
  WorkJournal_Strange_Controls,
  vtLister
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  nscTreeViewWithAdapterDragDrop,
  PrimWorkJournal_utWorkJournal_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimWorkJournalForm = {form} class(TvcmEntityForm)
 private
 // private fields
   f_JournalTree : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства JournalTree}
 protected
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   procedure JournalTreeMakeTreeSource(out theTree: Il3SimpleTree);
   function JournalTreeGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
   procedure JournalTreeActionElement(Sender: TObject;
     Index: LongInt);
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_GetState(var State: TvcmOperationStateIndex);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
     {* Удалить }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
     {* Развернуть все }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
     {* Свернуть все }
   {$IfEnd} //not NoVCM
   procedure SavedQuery_OpenQuery_Test(const aParams: IvcmTestParamsPrim);
   procedure SavedQuery_OpenQuery_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SavedQuery_ExecuteQuery_Test(const aParams: IvcmTestParamsPrim);
   procedure SavedQuery_ExecuteQuery_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Journal_Clear_Test(const aParams: IvcmTestParamsPrim);
   procedure Journal_Clear_Execute(const aParams: IvcmExecuteParamsPrim);
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   procedure SetupFormLayout; override;
     {* Тут можно настроить внешний вид формы }
    {$IfEnd} //not NoVCM
 public
 // overridden public methods
   {$If not defined(NoVCM)}
   procedure SetActiveControl; override;
     {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 public
 // public properties
   property JournalTree: TnscTreeViewWithAdapterDragDrop
     read f_JournalTree;
 end;//TPrimWorkJournalForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  FoldersRes,
  DynamicTreeUnit,
  SysUtils,
  UserJournalUnit,
  eeInterfaces,
  BaseTypesUnit,
  nsOpenUtils,
  nsQueryUtils,
  SearchUnit,
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  evdTextStyle_Const,
  l3Interfaces,
  nsConst,
  afwFacade
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utWorkJournalLocalConstants }
  str_utWorkJournalCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utWorkJournalCaption'; rValue : 'Журнал работы');
   { Заголовок пользовательского типа "Журнал работы" }

// start class TPrimWorkJournalForm

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

{$If not defined(NoVCM)}
procedure TPrimWorkJournalForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *494F89C30197_4BD6D6EA0075test_var*
//#UC END# *494F89C30197_4BD6D6EA0075test_var*
begin
//#UC START# *494F89C30197_4BD6D6EA0075test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := JournalTree.TreeView.Current >= 0;
//#UC END# *494F89C30197_4BD6D6EA0075test_impl*
end;//TPrimWorkJournalForm.Edit_Delete_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimWorkJournalForm.Edit_Delete_GetState(var State: TvcmOperationStateIndex);
//#UC START# *494F89C30197_4BD6D6EA0075getstate_var*
//#UC END# *494F89C30197_4BD6D6EA0075getstate_var*
begin
//#UC START# *494F89C30197_4BD6D6EA0075getstate_impl*
 // - ничего не делаем
//#UC END# *494F89C30197_4BD6D6EA0075getstate_impl*
end;//TPrimWorkJournalForm.Edit_Delete_GetState
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimWorkJournalForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *494F89C30197_4BD6D6EA0075exec_var*
//#UC END# *494F89C30197_4BD6D6EA0075exec_var*
begin
//#UC START# *494F89C30197_4BD6D6EA0075exec_impl*
 TdmStdRes.MakeWorkJournal.Delete(JournalTree.GetCurrentNode);
//#UC END# *494F89C30197_4BD6D6EA0075exec_impl*
end;//TPrimWorkJournalForm.Edit_Delete_Execute
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimWorkJournalForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7880236_4BD6D6EA0075test_var*
//#UC END# *4BDAF7880236_4BD6D6EA0075test_var*
begin
//#UC START# *4BDAF7880236_4BD6D6EA0075test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := JournalTree.TreeView.Current >= 0;
//#UC END# *4BDAF7880236_4BD6D6EA0075test_impl*
end;//TPrimWorkJournalForm.Tree_ExpandAll_Test
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimWorkJournalForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4BDAF7A2005C_4BD6D6EA0075test_var*
//#UC END# *4BDAF7A2005C_4BD6D6EA0075test_var*
begin
//#UC START# *4BDAF7A2005C_4BD6D6EA0075test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := JournalTree.TreeView.Current >= 0;
//#UC END# *4BDAF7A2005C_4BD6D6EA0075test_impl*
end;//TPrimWorkJournalForm.Tree_CollapseAll_Test
{$IfEnd} //not NoVCM

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
 TdmStdRes.MakeWorkJournal.Clear;
//#UC END# *4C3F348402AC_4BD6D6EA0075exec_impl*
end;//TPrimWorkJournalForm.Journal_Clear_Execute

{$If not defined(NoVCM)}
procedure TPrimWorkJournalForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4BD6D6EA0075_var*
//#UC END# *49803F5503AA_4BD6D6EA0075_var*
begin
//#UC START# *49803F5503AA_4BD6D6EA0075_impl*
 inherited;
 JournalTree.Images := nsFoldersRes.FoldersItemImages;
//#UC END# *49803F5503AA_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.DoInit
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimWorkJournalForm.InitControls;
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimWorkJournalForm.SetActiveControl;
//#UC START# *4AC3803A03CD_4BD6D6EA0075_var*
//#UC END# *4AC3803A03CD_4BD6D6EA0075_var*
begin
//#UC START# *4AC3803A03CD_4BD6D6EA0075_impl*
 Windows.SetFocus(JournalTree.Handle);
//#UC END# *4AC3803A03CD_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.SetActiveControl
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimWorkJournalForm.SetupFormLayout;
//#UC START# *529332B40230_4BD6D6EA0075_var*
//#UC END# *529332B40230_4BD6D6EA0075_var*
begin
//#UC START# *529332B40230_4BD6D6EA0075_impl*
 inherited;
 Width := 286;
 Height := 478;
//#UC END# *529332B40230_4BD6D6EA0075_impl*
end;//TPrimWorkJournalForm.SetupFormLayout
{$IfEnd} //not NoVCM

procedure TPrimWorkJournalForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_SavedQuery, nil);
  PublishFormEntity(en_Journal, nil);
  ContextMenuWeight(en_Tree, 1);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, Edit_Delete_GetState);
  ShowInContextMenu(en_Edit, op_Delete, true);
  ShowInToolbar(en_Edit, op_Delete, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_ExpandAll, nil, Tree_ExpandAll_Test, nil);
  ShowInContextMenu(en_Tree, op_ExpandAll, true);
  ShowInToolbar(en_Tree, op_ExpandAll, true);
  {$IfEnd} //not NoVCM

  {$If not defined(NoVCM)}
  PublishOp(en_Tree, op_CollapseAll, nil, Tree_CollapseAll_Test, nil);
  ShowInContextMenu(en_Tree, op_CollapseAll, true);
  ShowInToolbar(en_Tree, op_CollapseAll, true);
  {$IfEnd} //not NoVCM

  PublishOp(en_SavedQuery, op_OpenQuery, SavedQuery_OpenQuery_Execute, SavedQuery_OpenQuery_Test, nil);
  ShowInContextMenu(en_SavedQuery, op_OpenQuery, true);
  PublishOp(en_SavedQuery, op_ExecuteQuery, SavedQuery_ExecuteQuery_Execute, SavedQuery_ExecuteQuery_Test, nil);
  ShowInContextMenu(en_SavedQuery, op_ExecuteQuery, true);
  PublishOp(en_Journal, op_Clear, Journal_Clear_Execute, Journal_Clear_Test, nil);
  ShowInContextMenu(en_Journal, op_Clear, true);
  ShowInToolbar(en_Journal, op_Clear, true);
 end;//with Entities.Entities
end;

procedure TPrimWorkJournalForm.MakeControls;
begin
 inherited;
 with AddUsertype(utWorkJournalName,
  str_utWorkJournalCaption,
  str_utWorkJournalCaption,
  true,
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
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utWorkJournalCaption
 str_utWorkJournalCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimWorkJournal
 TtfwClassRef.Register(TPrimWorkJournalForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.