unit PrimFoldersTreeOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTreeOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimFoldersTreeOptions" MUID: (4C7E651B0179)
// Имя типа: "TPrimFoldersTreeOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimFoldersTree_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , Base_Operations_Strange_Controls
 , Folders_Strange_Controls
 , L10nInterfaces
 , eeInterfaces
 , l3Interfaces
 , nsTypes
 , FoldersDomainInterfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimFoldersTreeOptionsForm = class(TPrimFoldersTreeForm)
  private
   f_FilterMap: InsIntegerValueMap;
  protected
   function IsInSaveLoadState: Boolean;
   function GetCurrentFolder(const aNode: IeeNode): IeeNode;
   function CreateUniqName(const aNode: IeeNode): Il3CString;
   procedure DoSetShare(const aNode: IeeNode);
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
    {* прошла операция. }
   procedure ChildNodeAdded(const aNode: Il3SimpleNode);
    {* был добавлен дочерний узел }
   function BeginEdit(const aNode: IeeNode;
    WithPositioning: Boolean = False;
    IsNewFolder: Boolean = False): Boolean; override;
   procedure EndEdit(const aNode: IeeNode); override;
   function DeleteNode(const aNode: IeeNode;
    aAskConfirmation: Boolean): TnsDeleteResult; override;
   function GetFoldersInfo: InsFoldersInfo; override;
   procedure DoFoldersTreeCurrentChanged(Sender: TObject;
    NewCurrent: Integer;
    OldCurrent: Integer); override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure InitEntities; override;
    {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   {$If NOT Defined(NoVCM)}
   procedure Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
    {* Развернуть все }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Tree_ExpandAll_Execute(const aParams: IvcmExecuteParamsPrim);
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
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure Folders_Filtrate_Test(const aParams: IvcmTestParamsPrim);
   procedure Folders_Filtrate_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Folder_New_Test(const aParams: IvcmTestParamsPrim);
   procedure Folder_New_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Folder_AddToControl_Test(const aParams: IvcmTestParamsPrim);
   procedure Folder_AddToControl_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Folder_DelFromControl_Test(const aParams: IvcmTestParamsPrim);
   procedure Folder_DelFromControl_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Folder_SetShare_Test(const aParams: IvcmTestParamsPrim);
   procedure Folder_SetShare_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Folder_ExportToXML_Test(const aParams: IvcmTestParamsPrim);
   procedure Folder_ExportToXML_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Folder_ImportFromXML_Test(const aParams: IvcmTestParamsPrim);
   procedure Folder_ImportFromXML_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_Edit_Test(const aParams: IvcmTestParamsPrim);
   procedure FolderElement_Edit_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_EditExt_Test(const aParams: IvcmTestParamsPrim);
   procedure FolderElement_EditExt_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_Open_Test(const aParams: IvcmTestParamsPrim);
   procedure FolderElement_Open_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
   procedure FolderElement_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_ControlStatus_Test(const aParams: IvcmTestParamsPrim);
   procedure FolderElement_ControlStatus_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_ExportForIntegration_Test(const aParams: IvcmTestParamsPrim);
   procedure FolderElement_ExportForIntegration_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Consultation_Open_Test(const aParams: IvcmTestParamsPrim);
   procedure Consultation_Open_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Consultation_GiveMark_Test(const aParams: IvcmTestParamsPrim);
   procedure Consultation_GiveMark_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Consultation_ShowConsultationInfo_Test(const aParams: IvcmTestParamsPrim);
   procedure Consultation_ShowConsultationInfo_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure Consultation_ImportConsultation_Test(const aParams: IvcmTestParamsPrim);
   procedure Consultation_ImportConsultation_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure SavedQuery_CreateFilter_Test(const aParams: IvcmTestParamsPrim);
    {* Создать фильтр... }
   procedure SavedQuery_CreateFilter_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Создать фильтр... }
   {$If NOT Defined(NoVCM)}
   procedure SetActiveControl; override;
    {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimFoldersTreeOptionsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , BaseTreeSupportUnit
 , SysUtils
 , FoldersUnit
 , BaseTypesUnit
 , nsOpenUtils
 , SearchUnit
 , nsValueMapsIDs
 , nsValueMaps
 , Graphics
 , nsConst
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , nsFolders
 , l3Tree_TLB
 , nsFolderNodes
 {$If Defined(Nemesis)}
 , eeTreeMisc
 {$IfEnd} // Defined(Nemesis)
 , vtSaveDialog
 , l3Base
 , l3String
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsExternalObjectPrim
 , DataAdapter
 , nsUtils
 , Windows
 , l3InterfacesMisc
 , IOUnit
 , nsFormCoordinates
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , bsTypes
 , nsFiltersContainer
 , UnderControlUnit
 , nsQuestionsWithChoices
 , nsQueryUtils
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4C7E651B0179impl_uses*
 //#UC END# *4C7E651B0179impl_uses*
;

function TPrimFoldersTreeOptionsForm.IsInSaveLoadState: Boolean;
//#UC START# *4C7E73BD019F_4C7E651B0179_var*
//#UC END# *4C7E73BD019F_4C7E651B0179_var*
begin
//#UC START# *4C7E73BD019F_4C7E651B0179_impl*
 Result := (Op_FolderElement_GetState.Call(Aggregate) in [fiLoad, fiSelect, fiSave]);
//#UC END# *4C7E73BD019F_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.IsInSaveLoadState

function TPrimFoldersTreeOptionsForm.GetCurrentFolder(const aNode: IeeNode): IeeNode;
//#UC START# *4C7E772A036F_4C7E651B0179_var*
var
 l_AdapterNode: INode;
//#UC END# *4C7E772A036F_4C7E651B0179_var*
begin
//#UC START# *4C7E772A036F_4C7E651B0179_impl*
 Result := nil;
 if Supports(aNode, INode, l_AdapterNode) then
  if TFoldersItemType(l_AdapterNode.GetObjectType) = FIT_FOLDER then
   Result := aNode
  else
   Result := aNode.ParentNode;
//#UC END# *4C7E772A036F_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.GetCurrentFolder

function TPrimFoldersTreeOptionsForm.CreateUniqName(const aNode: IeeNode): Il3CString;
//#UC START# *4C7E77D901C5_4C7E651B0179_var*
var
 l_Name : Il3CString;

 function FindNode(const anIntf: IeeNode) : Boolean;
 begin//FindNode
  Result := l3Same(l_Name, anIntf.Text);
 end;//FindNode

var
 l_Node : IeeNode;
 I  : Integer;
//#UC END# *4C7E77D901C5_4C7E651B0179_var*
begin
//#UC START# *4C7E77D901C5_4C7E651B0179_impl*
 I := 1;
 repeat
  l_Name := vcmFmt(str_NewFolderDefaultName, [I]);
  l_Node := aNode.IterateF(eeL2NA(@FindNode), imOneLevel or imCheckResult);
  Inc(I);
 until l_Node = nil;
 Result := l_Name;
//#UC END# *4C7E77D901C5_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.CreateUniqName

procedure TPrimFoldersTreeOptionsForm.DoSetShare(const aNode: IeeNode);
//#UC START# *4C7E7A8000F8_4C7E651B0179_var*
var
 lFolder : IFolder;
//#UC END# *4C7E7A8000F8_4C7E651B0179_var*
begin
//#UC START# *4C7E7A8000F8_4C7E651B0179_impl*
 lFolder := GetIFolderFromIeeNode(aNode);
 if Assigned(lFolder) then
 try
  // установим доступ по умному, см. описание SharedFolder
  SharedFolder(aNode, not lFolder.GetShared);
  // проинформируем об изменениях
  op_UsersRights_FolderShareChanged.Call(Aggregate);
 finally
  lFolder := nil;
 end;
//#UC END# *4C7E7A8000F8_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.DoSetShare

procedure TPrimFoldersTreeOptionsForm.Notify(const aNotifier: Il3ChangeNotifier;
 aOperation: Integer;
 aIndex: Integer);
 {* прошла операция. }
//#UC START# *46A4504B03C4_4C7E651B0179_var*
//#UC END# *46A4504B03C4_4C7E651B0179_var*
begin
//#UC START# *46A4504B03C4_4C7E651B0179_impl*
 case TbsNotification(aOperation) of
  nConsultation:
   case TbsConsultationOperation(aIndex) of
    coUnreadChanged:
     FoldersTree.Invalidate;
   end;//case TbsConsultationOperation(aIndex) of
 end;//case TbsNotification(aOperation) of
//#UC END# *46A4504B03C4_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.Notify

procedure TPrimFoldersTreeOptionsForm.ChildNodeAdded(const aNode: Il3SimpleNode);
 {* был добавлен дочерний узел }
//#UC START# *49901C9600DD_4C7E651B0179_var*
//#UC END# *49901C9600DD_4C7E651B0179_var*
begin
//#UC START# *49901C9600DD_4C7E651B0179_impl*
 op_UsersRights_UpdateRights.Call(Aggregate, aNode As IeeNode);
 op_FolderElement_SetContent.Call(Aggregate, FoldersTree.TreeView.CurrentNode);
//#UC END# *49901C9600DD_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.ChildNodeAdded

function TPrimFoldersTreeOptionsForm.BeginEdit(const aNode: IeeNode;
 WithPositioning: Boolean = False;
 IsNewFolder: Boolean = False): Boolean;
//#UC START# *4AE718F90254_4C7E651B0179_var*
var
 l_Coord  : TRect;
//#UC END# *4AE718F90254_4C7E651B0179_var*
begin
//#UC START# *4AE718F90254_4C7E651B0179_impl*
 Result := True;
 if (Aggregate <> nil) then
 begin
  if IsInSaveLoadState then
  begin
   //Assert(False, 'http://mdp.garant.ru/pages/viewpage.action?pageId=452373109&focusedCommentId=492624070#comment-492624070');
   //Нашлось:    http://mdp.garant.ru/pages/viewpage.action?pageId=506710748
   l_Coord  := FoldersTree.GetDrawTextRect(FoldersTree.TreeView.GoToNode(aNode));
   with l_Coord do
   begin
    TopLeft := FoldersTree.ClientToScreen(TopLeft);
    BottomRight := FoldersTree.ClientToScreen(BottomRight);
   end;
   Result := (TdmStdRes.EditInfoOpen(IsNewFolder, aNode, TnsFormCoordinates.Make(l_Coord)) = mrOk);
  end//IsInSaveLoadState
  else
  begin
   FoldersTree.Changing;
   try
    if IsNewFolder then
     Op_FolderElement_SetState.Call(Aggregate, fiNewFolder)
    else
     Op_FolderElement_SetState.Call(Aggregate, fiEdit);
    Op_FolderElement_SetContent.Call(Aggregate, aNode, IsNewFolder);
    Op_AdditionInfo_Show.Call(Aggregate);
    if WithPositioning then
     FoldersTree.TreeView.GoToNode(aNode);
   finally
    FoldersTree.Changed;
   end;//try..finally
  end;//IsInSaveLoadState
 end;//Aggregate <> nil
//#UC END# *4AE718F90254_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.BeginEdit

procedure TPrimFoldersTreeOptionsForm.EndEdit(const aNode: IeeNode);
//#UC START# *4AE7192B023C_4C7E651B0179_var*
//#UC END# *4AE7192B023C_4C7E651B0179_var*
begin
//#UC START# *4AE7192B023C_4C7E651B0179_impl*
 if Aggregate <> nil then
 begin
  op_FolderElement_SetContent.Call(Aggregate, aNode);
  Aggregate.Operation(TdmStdRes.opcode_AdditionInfo_Hide);
 end;//Aggregate <> nil
//#UC END# *4AE7192B023C_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.EndEdit

function TPrimFoldersTreeOptionsForm.DeleteNode(const aNode: IeeNode;
 aAskConfirmation: Boolean): TnsDeleteResult;
//#UC START# *4AE71F530142_4C7E651B0179_var*
var
 l_OldCurrent     : Integer;
 l_newCurrentNode : IeeNode;
 l_AdapterNode    : INode;
 l_Desision       : Boolean;
 l_String         : IString;
//#UC END# *4AE71F530142_4C7E651B0179_var*
begin
//#UC START# *4AE71F530142_4C7E651B0179_impl*
 Result := drCancel;
 if (dsFoldersTree <> nil) and
  dsFoldersTree.IsConsultation(aNode As Il3SimpleNode) then
 begin
  if Ask(qr_ObjectDelete, [aNode.Text]) then
  begin
   try
    dsFoldersTree.DeleteConsultation(aNode As Il3SimpleNode);
    Result := drOk;
   except
    on ECanNotFindData do
     Ask(inf_ConsultationAlreadyDelete);
   end;
  end;
 end//dsFoldersTree <> nil 
 else
  if CheckFolderElementRights(aNode, faDelete) then
   with FoldersTree.TreeView do
   begin
    Result := drCancel;
    if (aNode.NextNode <> nil) and
        not l3IEQ(aNode, aNode.NextNode) and
        not l3IEQ(aNode.ParentNode.ChildNode, aNode.NextNode) then
     l_newCurrentNode := aNode.NextNode
    else
     if (aNode.PrevNode <> nil) and
        not l3IEQ(aNode, aNode.PrevNode) then
      l_newCurrentNode := aNode.PrevNode
     else
      l_newCurrentNode := aNode.ParentNode;

    if aAskConfirmation then
    begin
     Supports(aNode, INode, l_AdapterNode);
     try
      if aNode.HasChild then
      begin
       {if (l_AdapterNode <> nil) and
          DefDataAdapter.Folders.IsLastUnderControl(l_AdapterNode as IFoldersNode) then
        l_Desision := Ask(qr_DeleteControlledFolder)
       else
       begin !STUB!  Это не нужно, т.к. теперь на контроле не связаны с папками}
        l_AdapterNode.GetCaption(l_String);
        try
         l_Desision := Ask(qr_ObjectDelete, [nsCStr(l_String)]);
        finally
         l_String := nil;
        end;//try..finally
       {end;}
      end//aNode.HasChild
      else
      if (l_AdapterNode <> nil) and
         (TFoldersItemType(l_AdapterNode.GetObjectType) <> FIT_FOLDER) then
      begin
       {if DefDataAdapter.Folders.IsLastUnderControl(l_AdapterNode as IFoldersNode) then
        l_Desision := Ask(qr_DeleteControlledObject, [l3CStr(aNode)])
       else !STUB!  Это не нужно, т.к. теперь на контроле не связаны с папками}
        l_Desision := Ask(qr_ObjectDelete, [aNode.Text]);
      end//l_AdapterNode <> nil..
      else
       l_Desision := Ask(qr_FolderEmptyQuery, [aNode.Text]);
     finally
      l_AdapterNode := nil;
     end;
    end
    else
     l_Desision := True;

    if l_Desision then
    begin
     aNode.Delete;
     Result := drOk;
    end;

    if (Result = drOk) and
       (l_newCurrentNode <> nil) then
    begin
     l_OldCurrent := Current;
     GoToNode(l_newCurrentNode);
     DoFoldersTreeCurrentChanged(self, Current, l_OldCurrent);
    end;
   end
  else
   Result := drDenied;
//#UC END# *4AE71F530142_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.DeleteNode

function TPrimFoldersTreeOptionsForm.GetFoldersInfo: InsFoldersInfo;
//#UC START# *4AF2F5E50289_4C7E651B0179_var*
//#UC END# *4AF2F5E50289_4C7E651B0179_var*
begin
//#UC START# *4AF2F5E50289_4C7E651B0179_impl*
 Result := FoldersInfo;
//#UC END# *4AF2F5E50289_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.GetFoldersInfo

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.Tree_ExpandAll_Test(const aParams: IvcmTestParamsPrim);
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C7E651B0179test_var*
//#UC END# *4BDAF7880236_4C7E651B0179test_var*
begin
//#UC START# *4BDAF7880236_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := FoldersTree.TreeView.Current >= 0;
//#UC END# *4BDAF7880236_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Tree_ExpandAll_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.Tree_ExpandAll_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Развернуть все }
//#UC START# *4BDAF7880236_4C7E651B0179exec_var*
//#UC END# *4BDAF7880236_4C7E651B0179exec_var*
begin
//#UC START# *4BDAF7880236_4C7E651B0179exec_impl*
 FoldersTree.TreeView.Tree.Changing;
 try
  aParams.CallControl;
 finally
  FoldersTree.TreeView.Tree.Changed;
 end;
//#UC END# *4BDAF7880236_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Tree_ExpandAll_Execute
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.Tree_CollapseAll_Test(const aParams: IvcmTestParamsPrim);
 {* Свернуть все }
//#UC START# *4BDAF7A2005C_4C7E651B0179test_var*
//#UC END# *4BDAF7A2005C_4C7E651B0179test_var*
begin
//#UC START# *4BDAF7A2005C_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := FoldersTree.TreeView.Current >= 0;
//#UC END# *4BDAF7A2005C_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Tree_CollapseAll_Test
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFoldersTreeOptionsForm.SavedQuery_OpenQuery_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3F3421036A_4C7E651B0179test_var*
var
 l_Node: INode;
//#UC END# *4C3F3421036A_4C7E651B0179test_var*
begin
//#UC START# *4C3F3421036A_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not IsInSaveLoadState and
  Supports(FoldersTree.TreeView.CurrentNode, INode, l_Node) and
  (TFoldersItemType(l_Node.GetObjectType) = FIT_QUERY) and
  (l_Node.GetFlags and NF_IN_COMMENTS = 0);
//#UC END# *4C3F3421036A_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.SavedQuery_OpenQuery_Test

procedure TPrimFoldersTreeOptionsForm.SavedQuery_OpenQuery_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3F3421036A_4C7E651B0179exec_var*
var
 l_eeNode      : IeeNode;
 l_AdapterNode : INode;
 l_BaseEntity  : IUnknown;
//#UC END# *4C3F3421036A_4C7E651B0179exec_var*
begin
//#UC START# *4C3F3421036A_4C7E651B0179exec_impl*
 with FoldersTree.TreeView do
 begin
  l_eeNode := CurrentNode;
  try
   if Supports(l_eeNode, INode, l_AdapterNode) then
    try
     try
      l_AdapterNode.Open(l_BaseEntity);
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
//#UC END# *4C3F3421036A_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.SavedQuery_OpenQuery_Execute

procedure TPrimFoldersTreeOptionsForm.SavedQuery_ExecuteQuery_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3F342E02AF_4C7E651B0179test_var*
//#UC END# *4C3F342E02AF_4C7E651B0179test_var*
begin
//#UC START# *4C3F342E02AF_4C7E651B0179test_impl*
 SavedQuery_OpenQuery_Test(aParams);
//#UC END# *4C3F342E02AF_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.SavedQuery_ExecuteQuery_Test

procedure TPrimFoldersTreeOptionsForm.SavedQuery_ExecuteQuery_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3F342E02AF_4C7E651B0179exec_var*
var
 l_eeNode : IeeNode;
 l_AdapterNode : INode;
 l_BaseEntity : IUnknown;
 l_Query: IQuery;
//#UC END# *4C3F342E02AF_4C7E651B0179exec_var*
begin
//#UC START# *4C3F342E02AF_4C7E651B0179exec_impl*
 with FoldersTree.TreeView do
 begin
  l_eeNode := CurrentNode;
  try
   if Supports(l_eeNode, INode, l_AdapterNode) then
    try
     try
      l_AdapterNode.Open(l_BaseEntity);
     except
      on ECanNotFindData do
       Exit; //TODO: нода "пропала" что делать?
     end;
     Assert(l_BaseEntity <> nil);
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
 end;//with FoldersTree.TreeView
//#UC END# *4C3F342E02AF_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.SavedQuery_ExecuteQuery_Execute

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C7E651B0179test_var*
//#UC END# *4C7D0CC90052_4C7E651B0179test_var*
begin
//#UC START# *4C7D0CC90052_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (dsFoldersTree <> nil) and dsFoldersTree.CanDelete(FoldersTree.GetCurrentNode);
//#UC END# *4C7D0CC90052_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Edit_Delete_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C7E651B0179exec_var*
//#UC END# *4C7D0CC90052_4C7E651B0179exec_var*
begin
//#UC START# *4C7D0CC90052_4C7E651B0179exec_impl*
 FolderElement_InternalDelete_Execute(nil);
//#UC END# *4C7D0CC90052_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Edit_Delete_Execute
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFoldersTreeOptionsForm.Folders_Filtrate_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E65DF016E_4C7E651B0179test_var*
var
 l_Strings     : IvcmStrings;
 l_FoldersInfo : InsFoldersInfo;
 l_StringSource: InsStringsSource;
//#UC END# *4C7E65DF016E_4C7E651B0179test_var*
begin
//#UC START# *4C7E65DF016E_4C7E651B0179test_impl*
 l_FoldersInfo := FoldersInfo;
 if l_FoldersInfo <> nil then
  try
   aParams.Op.Flag[vcm_ofEnabled] := not l_FoldersInfo.CantChangeFilter;
   if l_FoldersInfo.CantChangeFilter then
    aParams.Op.Font.ForeColor := clLtGray
   else
    aParams.Op.Font.ForeColor := clBlack;

   l_Strings := aParams.Op.SubItems;
   if (l_Strings <> nil) then
   begin
    aParams.Op.SelectedString := f_FilterMap.
     ValueToDisplayName(ord(l_FoldersInfo.FilterInfo.FilterType));
    if l_Strings.Count = 0 then
     if Supports(f_FilterMap, InsStringsSource, l_StringSource) then
      l_StringSource.FillStrings(l_Strings);
   end;
  finally
   l_FoldersInfo := nil;
  end
 else
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C7E65DF016E_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Folders_Filtrate_Test

procedure TPrimFoldersTreeOptionsForm.Folders_Filtrate_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E65DF016E_4C7E651B0179exec_var*
var
 l_FoldersInfo : InsFoldersInfo;
 l_Index       : Integer;
//#UC END# *4C7E65DF016E_4C7E651B0179exec_var*
begin
//#UC START# *4C7E65DF016E_4C7E651B0179exec_impl*
 l_FoldersInfo := FoldersInfo;
 if (l_FoldersInfo <> nil) then
  try
   l_Index := aParams.ItemIndex;
   if (l_Index >= 0) then
   begin
    l_FoldersInfo.CantChangeFilter := False;
    if (f_OldFilter = -1) then
     f_OldFilter := Byte(l_FoldersInfo.FilterInfo.FilterType);
    l_FoldersInfo.FilterInfo.FilterType := TnsFolderFilter(l_Index);
   end//l_Index >= 0
   else
    l_FoldersInfo.FilterInfo.FilterType := TnsFolderFilter(f_FilterMap.
     DisplayNameToValue(aParams.SelectedString));
   if (FoldersTree.TreeView.Current < 0) then
   // - если отфильтровалось все - то сбрасываем текущий у формы со свойствами.
    op_FolderElement_SetContent.Call(Aggregate, nil);
  finally
   l_FoldersInfo := nil;
  end;//try..finally
//#UC END# *4C7E65DF016E_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Folders_Filtrate_Execute

procedure TPrimFoldersTreeOptionsForm.Folder_New_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E66850144_4C7E651B0179test_var*
var
 l_eeNode : IeeNode;
//#UC END# *4C7E66850144_4C7E651B0179test_var*
begin
//#UC START# *4C7E66850144_4C7E651B0179test_impl*
 if Aggregate <> nil then
 begin
  if (Op_FolderElement_GetState.Call(Aggregate) in [fiLoad, fiSelect]) then
   aParams.Op.Flag[vcm_ofEnabled] := False
  else
   with FoldersTree.TreeView do
   begin
    l_eeNode := GetCurrentFolder(CurrentNode);
    try
     if (l_eeNode <> nil) and (l_eeNode.GetLevelForParent(Tree.Root) < cMaxFoldersDepth) then
      aParams.Op.Flag[vcm_ofEnabled] := CheckFolderElementRights(l_eeNode, faAddChild)
     else
      aParams.Op.Flag[vcm_ofEnabled] := False;
    finally
     l_eeNode := nil;
    end;
   end;
 end
 else
  aParams.Op.Flag[vcm_ofEnabled] := True;
//#UC END# *4C7E66850144_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_New_Test

procedure TPrimFoldersTreeOptionsForm.Folder_New_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E66850144_4C7E651B0179exec_var*
var
 l_CurFolder,
 l_CurRoot: IeeNode;
//#UC END# *4C7E66850144_4C7E651B0179exec_var*
begin
//#UC START# *4C7E66850144_4C7E651B0179exec_impl*
 with FoldersTree.TreeView do
 begin
  l_CurRoot := GetCurrentFolder(CurrentNode);
  if l_CurRoot = nil then
   l_CurRoot := Tree.Root;
  try
   l_CurFolder := UserFoldersTree.CreateFolder(CreateUniqName(l_CurRoot),
                                               l_CurRoot as Il3Node,
                                               nil,
                                               nsFindInsertPosition(l_CurRoot as Il3Node,
                                                                    nil,
                                                                    True)) as IeeNode;

   if l_CurFolder <> nil then
    try
     if not BeginEdit(l_CurFolder, True, True) then
      DeleteNode(l_CurFolder, False);
    finally
     l_CurFolder := nil;
    end;
  finally
   l_CurRoot := nil;
  end;
 end;
//#UC END# *4C7E66850144_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_New_Execute

procedure TPrimFoldersTreeOptionsForm.Folder_AddToControl_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E66990246_4C7E651B0179test_var*
var
 l_Node: INode;
//#UC END# *4C7E66990246_4C7E651B0179test_var*
begin
//#UC START# *4C7E66990246_4C7E651B0179test_impl*
 with FoldersTree.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := (Current < 0) and
   Assigned(Aggregate) and not IsInSaveLoadState and
   Supports(CurrentNode, INode, l_Node) and
   (TFoldersItemType(l_Node.GetObjectType) = FIT_FOLDER) and
   not nsHasNodeAnyFlag(CurrentNode, [affExternal, affInComment]);
//#UC END# *4C7E66990246_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_AddToControl_Test

procedure TPrimFoldersTreeOptionsForm.Folder_AddToControl_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E66990246_4C7E651B0179exec_var*

 function SetControlStatus(const anIntf: IeeNode) : Boolean;
 var
  l_FoldersNode : InsFoldersNode;
 begin
  if Supports(anIntf, InsFoldersNode, l_FoldersNode) then
   try
    l_FoldersNode.SetUnderControlStatus(True);
   finally
    l_FoldersNode := nil;
   end;

  Result := False;
 end;

//#UC END# *4C7E66990246_4C7E651B0179exec_var*
begin
//#UC START# *4C7E66990246_4C7E651B0179exec_impl*
 if Ask(qr_SetControlStatus) then
  FoldersTree.TreeView.CurrentNode.IterateF(eeL2NA(@SetControlStatus));
//#UC END# *4C7E66990246_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_AddToControl_Execute

procedure TPrimFoldersTreeOptionsForm.Folder_DelFromControl_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E66B102FB_4C7E651B0179test_var*
//#UC END# *4C7E66B102FB_4C7E651B0179test_var*
begin
//#UC START# *4C7E66B102FB_4C7E651B0179test_impl*
 Folder_AddToControl_Test(aParams);
//#UC END# *4C7E66B102FB_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_DelFromControl_Test

procedure TPrimFoldersTreeOptionsForm.Folder_DelFromControl_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E66B102FB_4C7E651B0179exec_var*

 function SetControlStatus(const anIntf: IeeNode) : Boolean;
 var
  l_FoldersNode : InsFoldersNode;
 begin
  if Supports(anIntf, InsFoldersNode, l_FoldersNode) then
   try
    l_FoldersNode.SetUnderControlStatus(False);
   finally
    l_FoldersNode := nil;
   end;

  Result := False;
 end;

//#UC END# *4C7E66B102FB_4C7E651B0179exec_var*
begin
//#UC START# *4C7E66B102FB_4C7E651B0179exec_impl*
 if Ask(qr_DelControlStatus) then
  FoldersTree.TreeView.CurrentNode.IterateF(eeL2NA(@SetControlStatus));
//#UC END# *4C7E66B102FB_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_DelFromControl_Execute

procedure TPrimFoldersTreeOptionsForm.Folder_SetShare_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E66C70264_4C7E651B0179test_var*
var
 l_Node: INode;
//#UC END# *4C7E66C70264_4C7E651B0179test_var*
begin
//#UC START# *4C7E66C70264_4C7E651B0179test_impl*
 // Enabled
 with FoldersTree.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := not IsInSaveLoadState and
   Supports(CurrentNode, INode, l_Node) and
   CheckFolderElementRights(CurrentNode, faChangeRights) and
   not (l_Node.GetFlags and NF_IN_SHARED = NF_IN_SHARED);
 // Checked
 if aParams.Op.Flag[vcm_ofEnabled] then
   aParams.Op.Flag[vcm_ofChecked] := (l_Node.GetFlags and NF_SHARED = NF_SHARED);
//#UC END# *4C7E66C70264_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_SetShare_Test

procedure TPrimFoldersTreeOptionsForm.Folder_SetShare_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E66C70264_4C7E651B0179exec_var*
var
 l_Node : INode;
//#UC END# *4C7E66C70264_4C7E651B0179exec_var*
begin
//#UC START# *4C7E66C70264_4C7E651B0179exec_impl*
 FoldersTree.Changing;
 try
  DoSetShare(FoldersTree.TreeView.CurrentNode);
  if Supports(FoldersTree.TreeView.CurrentNode, INode, l_Node) then
  try
   UserFoldersTree.DropUserRightsCache(l_Node);
  finally
   l_Node := nil;
  end;
 finally
  FoldersTree.Changed;
 end;
//#UC END# *4C7E66C70264_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_SetShare_Execute

procedure TPrimFoldersTreeOptionsForm.Folder_ExportToXML_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E66DC00F5_4C7E651B0179test_var*
//#UC END# *4C7E66DC00F5_4C7E651B0179test_var*
begin
//#UC START# *4C7E66DC00F5_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (dsFoldersTree <> nil) and
  dsFoldersTree.CanExportToXML(FoldersTree.GetCurrentNode);
//#UC END# *4C7E66DC00F5_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_ExportToXML_Test

procedure TPrimFoldersTreeOptionsForm.Folder_ExportToXML_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E66DC00F5_4C7E651B0179exec_var*
var
 l_FO : TOpenDialog;
//#UC END# *4C7E66DC00F5_4C7E651B0179exec_var*
begin
//#UC START# *4C7E66DC00F5_4C7E651B0179exec_impl*
 if (dsFoldersTree <> nil) then
 begin
  l_FO := TvtSaveDialog.Create(Self);
  try
   with l_FO do
   begin
    Options := Options + [ofOverwritePrompt, ofPathMustExist];
    Filter := vcmConstString(str_FolderFilter);
    Title := vcmConstString(str_ExportFolderTitle);
    DefaultExt := vcmConstString(str_XMLFileExtension);
    FilterIndex := 1;
    FileName := l3PStr(nsPrepareFileName(vcmFmt(vcmCStr(str_FolderFileNamePattern),[l3CStr(FoldersTree.GetCurrentNode)])));
   end;
   if l_FO.Execute then
   try
    dsFoldersTree.ExportToXML(FoldersTree.GetCurrentNode, l3PCharLen(l_FO.FileName));
   except
    on EAccessDenied do
     Say(err_ExportFolderError, [FoldersTree.GetCurrentNode]);
    on EInvalidEntityType do
     Say(err_ExportFolderError, [FoldersTree.GetCurrentNode]);
   end;//try..except
  finally
   FreeAndNil(l_FO);
  end;//try..except
 end;//dsFoldersTree <> nil
//#UC END# *4C7E66DC00F5_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_ExportToXML_Execute

procedure TPrimFoldersTreeOptionsForm.Folder_ImportFromXML_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E66F60347_4C7E651B0179test_var*
//#UC END# *4C7E66F60347_4C7E651B0179test_var*
begin
//#UC START# *4C7E66F60347_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (dsFoldersTree <> nil) and
  dsFoldersTree.CanImportFromXML(FoldersTree.GetCurrentNode);
//#UC END# *4C7E66F60347_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_ImportFromXML_Test

procedure TPrimFoldersTreeOptionsForm.Folder_ImportFromXML_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E66F60347_4C7E651B0179exec_var*
var
 l_FO : TOpenDialog;
//#UC END# *4C7E66F60347_4C7E651B0179exec_var*
begin
//#UC START# *4C7E66F60347_4C7E651B0179exec_impl*
 if (dsFoldersTree <> nil) then
 begin
  l_FO := TOpenDialog.Create(Self);
  try
   with l_FO do
   begin
    Filter := vcmConstString(str_FolderFilter);
    Title := vcmConstString(str_ImportFolderTitle);
    DefaultExt := vcmConstString(str_XMLFileExtension);
    FilterIndex := 1;
    FileName := '';
   end;
   if l_FO.Execute then
   try
    dsFoldersTree.ImportFromXML(FoldersTree.GetCurrentNode, l3PCharLen(l_FO.FileName));
   except
    on EAccessDenied do
     Say(err_ExportFolderError, [FoldersTree.GetCurrentNode]);
    on EInvalidEntityType do
     Say(err_ExportFolderError, [FoldersTree.GetCurrentNode]);
   end;//try..except
  finally
   FreeAndNil(l_FO);
  end;//try..except
 end;//dsFoldersTree <> nil
//#UC END# *4C7E66F60347_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Folder_ImportFromXML_Execute

procedure TPrimFoldersTreeOptionsForm.FolderElement_Edit_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E679702DA_4C7E651B0179test_var*
//#UC END# *4C7E679702DA_4C7E651B0179test_var*
begin
//#UC START# *4C7E679702DA_4C7E651B0179test_impl*
 if (FoldersTree.TreeView.Current < 0) then
  aParams.Op.Flag[vcm_ofEnabled] := False
 else
 if (Aggregate <> nil) then
 begin
  case Op_FolderElement_GetState.Call(Aggregate) of
   fiNone      : aParams.Op.Flag[vcm_ofChecked] := False;
   fiNewFolder : aParams.Op.Flag[vcm_ofEnabled] := False;
   fiEdit      : aParams.Op.Flag[vcm_ofChecked] := True;
   else
    aParams.Op.Flag[vcm_ofEnabled] := False;
  end//case Op_FolderElement_GetState.Call(Aggregate)
 end//Aggregate <> nil
 else
  aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *4C7E679702DA_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_Edit_Test

procedure TPrimFoldersTreeOptionsForm.FolderElement_Edit_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E679702DA_4C7E651B0179exec_var*
//#UC END# *4C7E679702DA_4C7E651B0179exec_var*
begin
//#UC START# *4C7E679702DA_4C7E651B0179exec_impl*
 FolderElement_InternalEdit_Execute(FoldersTree.TreeView.CurrentNode, false);
//#UC END# *4C7E679702DA_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_Edit_Execute

procedure TPrimFoldersTreeOptionsForm.FolderElement_EditExt_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E67B301FD_4C7E651B0179test_var*
//#UC END# *4C7E67B301FD_4C7E651B0179test_var*
begin
//#UC START# *4C7E67B301FD_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := not (FoldersTree.TreeView.Current < 0);
//#UC END# *4C7E67B301FD_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_EditExt_Test

procedure TPrimFoldersTreeOptionsForm.FolderElement_EditExt_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E67B301FD_4C7E651B0179exec_var*
//#UC END# *4C7E67B301FD_4C7E651B0179exec_var*
begin
//#UC START# *4C7E67B301FD_4C7E651B0179exec_impl*
 FolderElement_InternalEdit_Execute(FoldersTree.TreeView.CurrentNode, true);
//#UC END# *4C7E67B301FD_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_EditExt_Execute

procedure TPrimFoldersTreeOptionsForm.FolderElement_Open_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E67CE01CB_4C7E651B0179test_var*
var
 l_Node: INode;
//#UC END# *4C7E67CE01CB_4C7E651B0179test_var*
begin
//#UC START# *4C7E67CE01CB_4C7E651B0179test_impl*
 with FoldersTree.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := (Current < 0) and
   not IsInSaveLoadState and Supports(CurrentNode, INode, l_Node) and
   not (TFoldersItemType(l_Node.GetObjectType) in [FIT_FOLDER]);
//#UC END# *4C7E67CE01CB_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_Open_Test

procedure TPrimFoldersTreeOptionsForm.FolderElement_Open_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E67CE01CB_4C7E651B0179exec_var*
//#UC END# *4C7E67CE01CB_4C7E651B0179exec_var*
begin
//#UC START# *4C7E67CE01CB_4C7E651B0179exec_impl*
 OpenFolderElement(self.as_IvcmEntityForm, FoldersTree.GetCurrentNode, vcm_okInCurrentTab);
//#UC END# *4C7E67CE01CB_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_Open_Execute

procedure TPrimFoldersTreeOptionsForm.FolderElement_OpenNewWindow_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E685801E5_4C7E651B0179test_var*
var
 l_Node: INode;
//#UC END# *4C7E685801E5_4C7E651B0179test_var*
begin
//#UC START# *4C7E685801E5_4C7E651B0179test_impl*
 with FoldersTree.TreeView do
  aParams.Op.Flag[vcm_ofEnabled] := (Current < 0) and
   not IsInSaveLoadState and Supports(CurrentNode, INode, l_Node) and
   not (TFoldersItemType(l_Node.GetObjectType) in [FIT_FOLDER, FIT_OLD_HISTORY]);
//#UC END# *4C7E685801E5_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_OpenNewWindow_Test

procedure TPrimFoldersTreeOptionsForm.FolderElement_OpenNewWindow_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E685801E5_4C7E651B0179exec_var*
//#UC END# *4C7E685801E5_4C7E651B0179exec_var*
begin
//#UC START# *4C7E685801E5_4C7E651B0179exec_impl*
 OpenFolderElement(self.as_IvcmEntityForm, FoldersTree.GetCurrentNode, vcm_okInNewWindow);
//#UC END# *4C7E685801E5_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_OpenNewWindow_Execute

procedure TPrimFoldersTreeOptionsForm.FolderElement_ControlStatus_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E68D602DB_4C7E651B0179test_var*
var
 l_Node: INode;
 l_Controllable : IControllable;
//#UC END# *4C7E68D602DB_4C7E651B0179test_var*
begin
//#UC START# *4C7E68D602DB_4C7E651B0179test_impl*
 // Enabled
 aParams.Op.Flag[vcm_ofEnabled] := not IsInSaveLoadState;

 try
  if aParams.Op.Flag[vcm_ofEnabled] then
  begin
   if Supports(FoldersTree.TreeView.CurrentNode, INode, l_Node) then
   begin
    // Пока на контроль можно поставить только Закладки
    aParams.Op.Flag[vcm_ofEnabled] :=
     (TFoldersItemType(l_Node.GetObjectType) in
      [FIT_BOOKMARK, FIT_PHARM_BOOKMARK]) and
     not nsHasNodeAnyFlag(l_Node, [affInExternal]);

    if aParams.Op.Flag[vcm_ofEnabled] then
    begin
     // begin http://mdp.garant.ru/pages/viewpage.action?pageId=268346048
     if Supports(l_Node, IControllable, l_Controllable) then
      try
       Assert(l_Controllable <> nil);
       aParams.Op.Flag[vcm_ofEnabled] := (l_Controllable <> nil) AND
                                         l_Controllable.GetCanSetToControl;
      finally
       l_Controllable := nil;
      end//try..finally
     else
      aParams.Op.Flag[vcm_ofEnabled] := false;
     // end http://mdp.garant.ru/pages/viewpage.action?pageId=268346048
    end;//aParams.Op.Flag[vcm_ofEnabled]
   end//Supports(FoldersTree.TreeView.CurrentNode, INode, l_Node)
   else
    aParams.Op.Flag[vcm_ofEnabled] := false;
  end;//aParams.Op.Flag[vcm_ofEnabled]

  // Checked
  if aParams.Op.Flag[vcm_ofEnabled] then
   aParams.Op.Flag[vcm_ofChecked] :=
    (l_Node <> nil) AND
    ((l_Node.GetFlags and NF_CONTROLLED) = NF_CONTROLLED);
 finally
  l_Node := nil;
 end//try..finally
//#UC END# *4C7E68D602DB_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_ControlStatus_Test

procedure TPrimFoldersTreeOptionsForm.FolderElement_ControlStatus_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E68D602DB_4C7E651B0179exec_var*
var
 l_eeNode      : IeeNode;
 l_FoldersNode : InsFoldersNode;
//#UC END# *4C7E68D602DB_4C7E651B0179exec_var*
begin
//#UC START# *4C7E68D602DB_4C7E651B0179exec_impl*
 with FoldersTree.TreeView do
 begin
  l_eeNode := CurrentNode;
  try
   if Supports(l_eeNode, InsFoldersNode, l_FoldersNode) then
    try
     l_FoldersNode.ChangeUnderControlStatus;
    finally
     l_FoldersNode := nil;
    end;//try..finally
  finally
   l_eeNode := nil;
  end;//try..finally
 end;//with FoldersTree.TreeView
//#UC END# *4C7E68D602DB_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_ControlStatus_Execute

procedure TPrimFoldersTreeOptionsForm.FolderElement_ExportForIntegration_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E68E900DC_4C7E651B0179test_var*
//#UC END# *4C7E68E900DC_4C7E651B0179test_var*
begin
//#UC START# *4C7E68E900DC_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := defDataAdapter.IntergationExportEnabled and
  (dsFoldersTree <> nil) and
  dsFoldersTree.CanExportForIntegration(FoldersTree.GetCurrentNode);
//#UC END# *4C7E68E900DC_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_ExportForIntegration_Test

procedure TPrimFoldersTreeOptionsForm.FolderElement_ExportForIntegration_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E68E900DC_4C7E651B0179exec_var*
//#UC END# *4C7E68E900DC_4C7E651B0179exec_var*
begin
//#UC START# *4C7E68E900DC_4C7E651B0179exec_impl*
 if (dsFoldersTree <> nil) then
 try
  dsFoldersTree.ExportForIntegration(FoldersTree.GetCurrentNode);
 except
  on EInvalidEntityType do
   Say(err_CanNotExport);
 end;//try..except
//#UC END# *4C7E68E900DC_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.FolderElement_ExportForIntegration_Execute

procedure TPrimFoldersTreeOptionsForm.Consultation_Open_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E6AE10291_4C7E651B0179test_var*
//#UC END# *4C7E6AE10291_4C7E651B0179test_var*
begin
//#UC START# *4C7E6AE10291_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (dsFoldersTree <> nil) and
  dsFoldersTree.CanBeOpenAsConsultation(FoldersTree.GetCurrentNode);
//#UC END# *4C7E6AE10291_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Consultation_Open_Test

procedure TPrimFoldersTreeOptionsForm.Consultation_Open_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E6AE10291_4C7E651B0179exec_var*
//#UC END# *4C7E6AE10291_4C7E651B0179exec_var*
begin
//#UC START# *4C7E6AE10291_4C7E651B0179exec_impl*
 OpenFolderElement(self.as_IvcmEntityForm, FoldersTree.GetCurrentNode, vcm_okInCurrentTab);
//#UC END# *4C7E6AE10291_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Consultation_Open_Execute

procedure TPrimFoldersTreeOptionsForm.Consultation_GiveMark_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E6AF2031C_4C7E651B0179test_var*
//#UC END# *4C7E6AF2031C_4C7E651B0179test_var*
begin
//#UC START# *4C7E6AF2031C_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (dsFoldersTree <> nil) and
  dsFoldersTree.CanGiveMarkOnConsultation(FoldersTree.GetCurrentNode);
//#UC END# *4C7E6AF2031C_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Consultation_GiveMark_Test

procedure TPrimFoldersTreeOptionsForm.Consultation_GiveMark_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E6AF2031C_4C7E651B0179exec_var*
//#UC END# *4C7E6AF2031C_4C7E651B0179exec_var*
begin
//#UC START# *4C7E6AF2031C_4C7E651B0179exec_impl*
 if (dsFoldersTree <> nil) then
 begin
  if dsFoldersTree.CanGiveMarkOnConsultation(FoldersTree.GetCurrentNode) then
   TdmStdRes.GiveMarkOnConsultation(FoldersTree.GetCurrentNode);
 end;//dsFoldersTree <> nil
//#UC END# *4C7E6AF2031C_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Consultation_GiveMark_Execute

procedure TPrimFoldersTreeOptionsForm.Consultation_ShowConsultationInfo_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E6B1A019D_4C7E651B0179test_var*
//#UC END# *4C7E6B1A019D_4C7E651B0179test_var*
begin
//#UC START# *4C7E6B1A019D_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofVisible] := False;
  // - эта операция от которой нужен только ShortCut, показывать;
//#UC END# *4C7E6B1A019D_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Consultation_ShowConsultationInfo_Test

procedure TPrimFoldersTreeOptionsForm.Consultation_ShowConsultationInfo_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E6B1A019D_4C7E651B0179exec_var*
//#UC END# *4C7E6B1A019D_4C7E651B0179exec_var*
begin
//#UC START# *4C7E6B1A019D_4C7E651B0179exec_impl*
 nsWriteLetterAboutConsultation(FoldersTree.GetCurrentNode);
//#UC END# *4C7E6B1A019D_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Consultation_ShowConsultationInfo_Execute

procedure TPrimFoldersTreeOptionsForm.Consultation_ImportConsultation_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C7E6B310055_4C7E651B0179test_var*
//#UC END# *4C7E6B310055_4C7E651B0179test_var*
begin
//#UC START# *4C7E6B310055_4C7E651B0179test_impl*
 aParams.Op.Flag[vcm_ofEnabled] := (dsFoldersTree <> nil)
  and dsFoldersTree.CanImportConsultation(FoldersTree.GetCurrentNode);
//#UC END# *4C7E6B310055_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.Consultation_ImportConsultation_Test

procedure TPrimFoldersTreeOptionsForm.Consultation_ImportConsultation_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C7E6B310055_4C7E651B0179exec_var*
var
 l_FO : TOpenDialog;
//#UC END# *4C7E6B310055_4C7E651B0179exec_var*
begin
//#UC START# *4C7E6B310055_4C7E651B0179exec_impl*
 if (dsFoldersTree <> nil) then
 begin
  l_FO := TOpenDialog.Create(Self);
  try
   with l_FO do
   begin
    Filter := vcmConstString(str_ConsultationFilter);
    Title := vcmConstString(str_ImportConsultationCaption);
    DefaultExt := vcmConstString(str_XMLFileExtension);
    FilterIndex := 1;
   end;
   if l_FO.Execute then
   try
    dsFoldersTree.ImportConsultation(l3PCharLen(l_FO.FileName));
   except
    on EAccessDenied do
     Say(err_FileReadErrorF, [l_FO.FileName]);
    on EInvalidXMLType do
     Say(err_InvalidFileFormat);
   end;
  finally
   FreeAndNil(l_FO);
  end;
 end;//dsFoldersTree <> nil
//#UC END# *4C7E6B310055_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.Consultation_ImportConsultation_Execute

procedure TPrimFoldersTreeOptionsForm.DoFoldersTreeCurrentChanged(Sender: TObject;
 NewCurrent: Integer;
 OldCurrent: Integer);
//#UC START# *4C7E808A035E_4C7E651B0179_var*
var
 l_eeNode : IeeNode;
//#UC END# *4C7E808A035E_4C7E651B0179_var*
begin
//#UC START# *4C7E808A035E_4C7E651B0179_impl*
 if (Aggregate <> nil) and (NewCurrent <> -1) then
  with FoldersTree.TreeView do
  begin
   l_eeNode := GetNode(NewCurrent);
   try
    op_FolderElement_SetContent.Call(Aggregate, l_eeNode);
   finally
    l_eeNode := nil;
   end;//try..finally
  end;//with FoldersTree.TreeView
//#UC END# *4C7E808A035E_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.DoFoldersTreeCurrentChanged

procedure TPrimFoldersTreeOptionsForm.SavedQuery_CreateFilter_Test(const aParams: IvcmTestParamsPrim);
 {* Создать фильтр... }
//#UC START# *4CB5802D00CB_4C7E651B0179test_var*
//#UC END# *4CB5802D00CB_4C7E651B0179test_var*
begin
//#UC START# *4CB5802D00CB_4C7E651B0179test_impl*
 SavedQuery_OpenQuery_Test(aParams);
//#UC END# *4CB5802D00CB_4C7E651B0179test_impl*
end;//TPrimFoldersTreeOptionsForm.SavedQuery_CreateFilter_Test

procedure TPrimFoldersTreeOptionsForm.SavedQuery_CreateFilter_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Создать фильтр... }
//#UC START# *4CB5802D00CB_4C7E651B0179exec_var*
var
 l_eeNode      : IeeNode;
 l_AdapterNode : INode;
 l_BaseEntity  : IUnknown;
 l_Query: IQuery;
//#UC END# *4CB5802D00CB_4C7E651B0179exec_var*
begin
//#UC START# *4CB5802D00CB_4C7E651B0179exec_impl*
 with FoldersTree.TreeView do
 begin
  l_eeNode := CurrentNode;
  try
   if Supports(l_eeNode, INode, l_AdapterNode) then
    try
     try
      l_AdapterNode.Open(l_BaseEntity);
     except
      on ECanNotFindData do
       exit; //TODO: нода "пропала" что делать?
     end;//try..except
     try
      Supports(l_BaseEntity, IQuery, l_Query);
      Assert(Assigned(l_Query));
      TdmStdRes.CreateFilter(l_Query);
     finally
      l_BaseEntity := nil;
     end;//try..finally
    finally
     l_AdapterNode := nil;
    end;//try..finally
  finally
   l_eeNode := nil;
  end;//try..finally
 end;//with FoldersTree.TreeView
//#UC END# *4CB5802D00CB_4C7E651B0179exec_impl*
end;//TPrimFoldersTreeOptionsForm.SavedQuery_CreateFilter_Execute

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4C7E651B0179_var*
//#UC END# *49803F5503AA_4C7E651B0179_var*
begin
//#UC START# *49803F5503AA_4C7E651B0179_impl*
 inherited;
 f_FilterMap := nsIntegerMapManager.Map[imap_FolderFilters];
//#UC END# *49803F5503AA_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.SetActiveControl;
 {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
//#UC START# *4AC3803A03CD_4C7E651B0179_var*
//#UC END# *4AC3803A03CD_4C7E651B0179_var*
begin
//#UC START# *4AC3803A03CD_4C7E651B0179_impl*
 Windows.SetFocus(FoldersTree.Handle);
//#UC END# *4AC3803A03CD_4C7E651B0179_impl*
end;//TPrimFoldersTreeOptionsForm.SetActiveControl
{$IfEnd} // NOT Defined(NoVCM)

procedure TPrimFoldersTreeOptionsForm.ClearFields;
begin
 f_FilterMap := nil;
 inherited;
end;//TPrimFoldersTreeOptionsForm.ClearFields

{$If NOT Defined(NoVCM)}
procedure TPrimFoldersTreeOptionsForm.InitEntities;
 {* инициализирует сущности не из dfm.
             Нужно для перекрытия потомками при переносе VCM на модель }
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  PublishFormEntity(en_Tree, nil);
  PublishFormEntity(en_SavedQuery, nil);
  PublishFormEntity(en_Folders, nil);
  PublishFormEntity(en_Folder, nil);
  PublishFormEntity(en_FolderElement, nil);
  PublishFormEntity(en_Consultation, nil);
  ContextMenuWeight(en_Tree, 30);
  ContextMenuWeight(en_FolderElement, 20);
  ContextMenuWeight(en_Folder, 10);
  PublishOp(en_Tree, op_ExpandAll, Tree_ExpandAll_Execute, Tree_ExpandAll_Test, nil);
  ShowInContextMenu(en_Tree, op_ExpandAll, True);
  ShowInToolbar(en_Tree, op_ExpandAll, False);
  PublishOp(en_Tree, op_CollapseAll, nil, Tree_CollapseAll_Test, nil);
  PublishOp(en_SavedQuery, op_OpenQuery, SavedQuery_OpenQuery_Execute, SavedQuery_OpenQuery_Test, nil);
  ShowInContextMenu(en_SavedQuery, op_OpenQuery, True);
  ShowInToolbar(en_SavedQuery, op_OpenQuery, False);
  PublishOp(en_SavedQuery, op_ExecuteQuery, SavedQuery_ExecuteQuery_Execute, SavedQuery_ExecuteQuery_Test, nil);
  ShowInContextMenu(en_SavedQuery, op_ExecuteQuery, True);
  ShowInToolbar(en_SavedQuery, op_ExecuteQuery, False);
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, nil);
  ShowInContextMenu(en_Edit, op_Delete, True);
  ShowInToolbar(en_Edit, op_Delete, True);
  PublishOp(en_Folders, op_Filtrate, Folders_Filtrate_Execute, Folders_Filtrate_Test, nil);
  ShowInContextMenu(en_Folders, op_Filtrate, False);
  ShowInToolbar(en_Folders, op_Filtrate, True);
  PublishOp(en_Folder, op_New, Folder_New_Execute, Folder_New_Test, nil);
  ShowInContextMenu(en_Folder, op_New, True);
  ShowInToolbar(en_Folder, op_New, True);
  ContextMenuWeight(en_Folder, op_New, 10);
  PublishOp(en_Folder, op_AddToControl, Folder_AddToControl_Execute, Folder_AddToControl_Test, nil);
  ShowInContextMenu(en_Folder, op_AddToControl, True);
  ShowInToolbar(en_Folder, op_AddToControl, False);
  PublishOp(en_Folder, op_DelFromControl, Folder_DelFromControl_Execute, Folder_DelFromControl_Test, nil);
  ShowInContextMenu(en_Folder, op_DelFromControl, True);
  ShowInToolbar(en_Folder, op_DelFromControl, False);
  PublishOp(en_Folder, op_SetShare, Folder_SetShare_Execute, Folder_SetShare_Test, nil);
  ShowInContextMenu(en_Folder, op_SetShare, True);
  ShowInToolbar(en_Folder, op_SetShare, False);
  PublishOp(en_Folder, op_ExportToXML, Folder_ExportToXML_Execute, Folder_ExportToXML_Test, nil);
  ShowInContextMenu(en_Folder, op_ExportToXML, True);
  ShowInToolbar(en_Folder, op_ExportToXML, False);
  PublishOp(en_Folder, op_ImportFromXML, Folder_ImportFromXML_Execute, Folder_ImportFromXML_Test, nil);
  ShowInContextMenu(en_Folder, op_ImportFromXML, True);
  ShowInToolbar(en_Folder, op_ImportFromXML, False);
  ContextMenuWeight(en_Folder, op_ImportFromXML, 20);
  PublishOp(en_FolderElement, op_Edit, FolderElement_Edit_Execute, FolderElement_Edit_Test, nil);
  ShowInContextMenu(en_FolderElement, op_Edit, False);
  ShowInToolbar(en_FolderElement, op_Edit, True);
  PublishOp(en_FolderElement, op_EditExt, FolderElement_EditExt_Execute, FolderElement_EditExt_Test, nil);
  ShowInContextMenu(en_FolderElement, op_EditExt, True);
  ShowInToolbar(en_FolderElement, op_EditExt, False);
  PublishOp(en_FolderElement, op_Open, FolderElement_Open_Execute, FolderElement_Open_Test, nil);
  ShowInContextMenu(en_FolderElement, op_Open, True);
  ShowInToolbar(en_FolderElement, op_Open, False);
  PublishOp(en_FolderElement, op_OpenNewWindow, FolderElement_OpenNewWindow_Execute, FolderElement_OpenNewWindow_Test, nil);
  ShowInContextMenu(en_FolderElement, op_OpenNewWindow, True);
  ShowInToolbar(en_FolderElement, op_OpenNewWindow, False);
  PublishOp(en_FolderElement, op_ControlStatus, FolderElement_ControlStatus_Execute, FolderElement_ControlStatus_Test, nil);
  ShowInContextMenu(en_FolderElement, op_ControlStatus, True);
  ShowInToolbar(en_FolderElement, op_ControlStatus, False);
  PublishOp(en_FolderElement, op_ExportForIntegration, FolderElement_ExportForIntegration_Execute, FolderElement_ExportForIntegration_Test, nil);
  ShowInContextMenu(en_FolderElement, op_ExportForIntegration, True);
  ShowInToolbar(en_FolderElement, op_ExportForIntegration, False);
  PublishOp(en_Consultation, op_Open, Consultation_Open_Execute, Consultation_Open_Test, nil);
  ShowInContextMenu(en_Consultation, op_Open, True);
  ShowInToolbar(en_Consultation, op_Open, False);
  PublishOp(en_Consultation, op_GiveMark, Consultation_GiveMark_Execute, Consultation_GiveMark_Test, nil);
  ShowInContextMenu(en_Consultation, op_GiveMark, True);
  ShowInToolbar(en_Consultation, op_GiveMark, False);
  PublishOp(en_Consultation, op_ShowConsultationInfo, Consultation_ShowConsultationInfo_Execute, Consultation_ShowConsultationInfo_Test, nil);
  ShowInContextMenu(en_Consultation, op_ShowConsultationInfo, True);
  ShowInToolbar(en_Consultation, op_ShowConsultationInfo, False);
  PublishOp(en_Consultation, op_ImportConsultation, Consultation_ImportConsultation_Execute, Consultation_ImportConsultation_Test, nil);
  ShowInContextMenu(en_Consultation, op_ImportConsultation, True);
  ShowInToolbar(en_Consultation, op_ImportConsultation, False);
  PublishOp(en_SavedQuery, op_CreateFilter, SavedQuery_CreateFilter_Execute, SavedQuery_CreateFilter_Test, nil);
  ShowInContextMenu(en_SavedQuery, op_CreateFilter, True);
 end;//with Entities.Entities
end;//TPrimFoldersTreeOptionsForm.InitEntities
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersTreeOptionsForm);
 {* Регистрация PrimFoldersTreeOptions }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
