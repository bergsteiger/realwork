unit PrimFoldersTree_Form;
 {* Дерево папок }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersTree_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimFoldersTree" MUID: (497DD4870291)
// Имя типа: "TPrimFoldersTreeForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3Interfaces
 , FoldersDomainInterfaces
 , Folders_Strange_Controls
 , nscTreeViewWithAdapterDragDrop
 , nsTypes
 , eeInterfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , FoldersUnit
 , BaseTreeSupportUnit
;

type
 TPrimFoldersTreeForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Il3ItemNotifyRecipient, InsFolderNodeListener)
  {* Дерево папок }
  private
   f_FoldersTree: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства FoldersTree }
  protected
   dsFoldersTree: ;
    {* Дерево папок }
   f_OldFilter: Integer;
  private
   function FoldersTreeGetItemIconHint(Sender: TObject;
    Index: LongInt): Il3CString;
   procedure FoldersTreeMakeTreeSource(out theTree: Il3SimpleTree);
   function FoldersTreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   function FoldersTreeGetItemTextHint(Sender: TObject;
    Index: LongInt): Il3CString;
   procedure FoldersTreeActionElement(Sender: TObject;
    Index: LongInt);
   procedure FoldersTreeCurrentChanged(Sender: TObject;
    aNewCurrent: LongInt;
    aOldCurrent: LongInt);
   procedure FoldersTreeTreeChanged(aSender: TObject;
    const anOldTree: Il3SimpleTree;
    const aNewTree: Il3SimpleTree);
   procedure FoldersTreeGetItemFont(Sender: TObject;
    Index: LongInt;
    const aFont: Il3Font);
  protected
   function pm_GetFoldersInfo: InsFoldersInfo;
   procedure DoFoldersTreeCurrentChanged(Sender: TObject;
    NewCurrent: Integer;
    OldCurrent: Integer); virtual; abstract;
   function BeginEdit(const aNode: IeeNode;
    WithPositioning: Boolean = False;
    IsNewFolder: Boolean = False): Boolean; virtual; abstract;
   procedure EndEdit(const aNode: IeeNode); virtual; abstract;
   function DeleteNode(const aNode: IeeNode;
    aAskConfirmation: Boolean): TnsDeleteResult; virtual; abstract;
   function GetFoldersInfo: InsFoldersInfo; virtual; abstract;
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
    {* прошла операция. }
   procedure ChildNodeAdded(const aNode: Il3SimpleNode);
    {* был добавлен дочерний узел }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure FolderElement_InternalEditByFoldersNode_Execute(const aNode: IFoldersNode;
    aInternalCall: Boolean = True);
    {* Редактирование элемента }
   procedure FolderElement_InternalEditByFoldersNode(const aParams: IvcmExecuteParamsPrim);
    {* Редактирование элемента }
   function FolderElement_InternalDelete_Execute(const aNode: IFoldersNode;
    aAsk: Boolean = True): TnsDeleteResult;
    {* Удаляет элемент папок }
   procedure FolderElement_InternalDelete(const aParams: IvcmExecuteParamsPrim);
    {* Удаляет элемент папок }
   procedure FolderElement_InternalEdit_Execute(const aNode: IeeNode;
    aInternalCall: Boolean = True);
   procedure FolderElement_InternalEdit(const aParams: IvcmExecuteParamsPrim);
   procedure SavedQuery_SetFilterState_Execute(const aNode: INode);
   procedure SavedQuery_SetFilterState(const aParams: IvcmExecuteParamsPrim);
   procedure Folders_SetCurrent_Execute(const aNode: IeeNode);
   procedure Folders_SetCurrent(const aParams: IvcmExecuteParamsPrim);
   procedure Folders_FiltrateByFilterInfo_Execute(const anInfo: InsFolderFilterInfo);
   procedure Folders_FiltrateByFilterInfo(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_DisableFilter_Execute;
   procedure FolderElement_DisableFilter(const aParams: IvcmExecuteParamsPrim);
   procedure Folders_TryOpenConsultationAnswer_Execute;
   procedure Folders_TryOpenConsultationAnswer(const aParams: IvcmExecuteParamsPrim);
   procedure Folders_OpenMyConsultations_Execute;
   procedure Folders_OpenMyConsultations(const aParams: IvcmExecuteParamsPrim);
   procedure Folders_SetInfoContent_Execute;
   procedure Folders_SetInfoContent(const aParams: IvcmExecuteParamsPrim);
  protected
   property FoldersInfo: InsFoldersInfo
    read pm_GetFoldersInfo;
  public
   property FoldersTree: TnscTreeViewWithAdapterDragDrop
    read f_FoldersTree;
 end;//TPrimFoldersTreeForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , nsTreeUtils
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Tree_TLB
 , bsUtils
 , nsUtils
 {$If Defined(Nemesis)}
 , eeTreeMisc
 {$IfEnd} // Defined(Nemesis)
 , l3InternalInterfaces
 , OvcConst
 , nsFolders
 , nsNodes
 , FoldersRes
 , l3String
 , afwFacade
 , nsConst
 , nsOpenUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nsManagers
 , nsFolderFilterInfo
 , Graphics
 , nsQuestionsWithChoices
 , bsTypes
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimFoldersTree_utFoldersTree_UserType
 , PrimFoldersTree_utSaveOpen_UserType
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки utFoldersTreeLocalConstants }
 str_utFoldersTreeCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFoldersTreeCaption'; rValue : 'Мои документы (вкладка)');
  {* Заголовок пользовательского типа "Мои документы (вкладка)" }
 {* Локализуемые строки utSaveOpenLocalConstants }
 str_utSaveOpenCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utSaveOpenCaption'; rValue : 'Мои документы');
  {* Заголовок пользовательского типа "Мои документы" }

function TPrimFoldersTreeForm.pm_GetFoldersInfo: InsFoldersInfo;
//#UC START# *4C7E75040189_497DD4870291get_var*
//#UC END# *4C7E75040189_497DD4870291get_var*
begin
//#UC START# *4C7E75040189_497DD4870291get_impl*
 Supports(FoldersTree.TreeStruct, InsFoldersInfo, Result);
//#UC END# *4C7E75040189_497DD4870291get_impl*
end;//TPrimFoldersTreeForm.pm_GetFoldersInfo

function TPrimFoldersTreeForm.FoldersTreeGetItemIconHint(Sender: TObject;
 Index: LongInt): Il3CString;
//#UC START# *51C414700399_497DD4870291_var*
var
 l_eeNode      : IeeNode;
 l_AdapterNode : INode;
//#UC END# *51C414700399_497DD4870291_var*
begin
//#UC START# *51C414700399_497DD4870291_impl*
 Result := nil;
 if (Index >= 0) then
 begin
  l_eeNode := FoldersTree.TreeView.GetNode(Index);
  try
   if Supports(l_eeNode, INode, l_AdapterNode) then
    Result := nsGetHint(l_AdapterNode);
  finally
   l_eeNode := nil;
  end;//try..finally
 end;//Index >= 0
//#UC END# *51C414700399_497DD4870291_impl*
end;//TPrimFoldersTreeForm.FoldersTreeGetItemIconHint

procedure TPrimFoldersTreeForm.FoldersTreeMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *51C4147A0009_497DD4870291_var*
//#UC END# *51C4147A0009_497DD4870291_var*
begin
//#UC START# *51C4147A0009_497DD4870291_impl*
 theTree := UserFoldersTree.AsyncTree;
//#UC END# *51C4147A0009_497DD4870291_impl*
end;//TPrimFoldersTreeForm.FoldersTreeMakeTreeSource

function TPrimFoldersTreeForm.FoldersTreeGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *51C4149F0381_497DD4870291_var*
var
 l_eeNode: IeeNode;
 l_AdapterNode: INode;
 l_Flags: LongInt;
//#UC END# *51C4149F0381_497DD4870291_var*
begin
//#UC START# *51C4149F0381_497DD4870291_impl*
 if Index >= 0 then
 begin
  l_eeNode := FoldersTree.TreeView.GetNode(Index);
  try
   if Supports(l_eeNode, INode, l_AdapterNode) then
   begin
    l_Flags := l_AdapterNode.GetFlags;
    case TFoldersItemType(l_AdapterNode.GetObjectType) of
     FIT_BOOKMARK,
     FIT_PHARM_BOOKMARK:
      if (l_Flags and NF_CONTROLLED = NF_CONTROLLED) then
       Result := BookmarkUnderControlIcon
      else
       Result := BookmarkIcon;
     FIT_LIST, FIT_PHARM_LIST:
      Result := ListIcon;
     FIT_QUERY:
// К Убиению     
{      if (l_Flags and NF_FILTER = NF_FILTER) then
       Result := FilterIcon <<<<
      else
       if (l_Flags and NF_GLOBAL_FILTER = NF_GLOBAL_FILTER) then
        Result := GlobalFilterIcon <<<<
       else}
        if (l_Flags and NF_IN_COMMENTS = NF_IN_COMMENTS) then
         Result := UserCommentsSearchIcon
        else
         Result := QueryIcon;
     FIT_FOLDER:
      if (l_Flags and NF_SHARED = NF_SHARED) then
       Result := SharedFolderIcon
      else
       if (l_Flags and NF_MY_CONSULTATIONS) = NF_MY_CONSULTATIONS then
        Result := ConsultingFolderIcon
       else
        Result := FolderIcon;
     FIT_OLD_HISTORY:
      Result := JournalFolderIcon;
     FIT_CONSULTATION:
      // Консультация прочитана
      if not bsHasFlag(l_Flags, NF_ANSWER_RECEIVED) and
          // - у импортированных консультаций устнавливается два статуса - оценена
          //   и не прочитана, для остальных консультаций порядок обработки не изменился. 
         bsHasFlag(l_Flags, [NF_ANSWER_READ,
                             NF_ESTIMATION_SENT,
                             NF_PAYMENT_CONFIRM,
                             NF_PAYMENT_REFUSAL]) then
       Result := ConsultationReadIcon
      else
       // Исходящий запрос
       if bsHasFlag(l_Flags, NF_DRAFTS) then
        Result := ConsultationSending
       else
        Result := ConsultationUnreadIcon;
     else
      Result := 0;
    end;//case TFoldersItemType(l_AdapterNode.GetObjectType) of
   end//if Supports(l_eeNode, INode, l_AdapterNode) then
   else
    Result := FolderIcon;
  finally
   l_eeNode := nil;
  end;{try..finally}
 end//if Index >= 0 then
 else
  Result := 0;
//#UC END# *51C4149F0381_497DD4870291_impl*
end;//TPrimFoldersTreeForm.FoldersTreeGetItemImage

function TPrimFoldersTreeForm.FoldersTreeGetItemTextHint(Sender: TObject;
 Index: LongInt): Il3CString;
//#UC START# *51C414AA021C_497DD4870291_var*
var
 l_eeNode      : IeeNode;
 l_AdapterNode : INode;
//#UC END# *51C414AA021C_497DD4870291_var*
begin
//#UC START# *51C414AA021C_497DD4870291_impl*
 Result := nil;
 if (Index >= 0) then
 begin
  l_eeNode := FoldersTree.TreeView.GetNode(Index);
  try
   if Supports(l_eeNode, INode, l_AdapterNode) then
   begin
    Result := nsGetHint(l_AdapterNode);
    if l3Same(Result, l_eeNode.Text) then
     Result := nil;
   end;
  finally
   l_eeNode := nil;
  end;//try..finally
 end;//Index >= 0
//#UC END# *51C414AA021C_497DD4870291_impl*
end;//TPrimFoldersTreeForm.FoldersTreeGetItemTextHint

procedure TPrimFoldersTreeForm.FoldersTreeActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *51C414B701C6_497DD4870291_var*
 function lp_CheckCanOpen(const aNode: Il3SimpleNode): Boolean;
 begin
  Result := False;
  if (dsFoldersTree <> nil) then
  begin
   try
    dsFoldersTree.CanBeOpen(aNode);
    Result := True;
   except
    on EdsConsultationInProcess do
     Say(inf_ConsultationInProcess);
    on EdsConsultationSending do
     Say(inf_ConsultationSending);
    on EdsOldRefusalConsultationFormat do
    begin
     Say(war_OldRefusalConsultationFormat);
     Result := True;
      // - мы выдаём сообщение и все равно показываем текст (CQ: OIT5-27021);
    end;//EdsOldRefusalConsultationFormat
   end;{try..except}
  end;//dsFoldersTree <> nil
 end;//lp_CheckCanOpen

var
 l_FoldersItemType : TFoldersItemType;
 l_AdapterNode     : INode;
 l_eeNode          : Il3SimpleNode;
 l_NewWindow       : Boolean;
//#UC END# *51C414B701C6_497DD4870291_var*
begin
//#UC START# *51C414B701C6_497DD4870291_impl*
 if (Container.AsForm.ZoneType <> vcm_ztManualModal) then
 begin
  l_eeNode := FoldersTree.GetNode(Index);
  try
   if lp_CheckCanOpen(l_eeNode) and
    Supports(l_eeNode, INode, l_AdapterNode) then
   try
    l_FoldersItemType := TFoldersItemType(l_AdapterNode.GetObjectType);
    case l_FoldersItemType of
     FIT_OLD_HISTORY:
      Dispatcher.ModuleOperation(TdmStdRes.mod_opcode_WorkJournal_OpenJournal);
     FIT_FOLDER:
      if FoldersInfo.NodeHasVisibleChildren(l_eeNode) then
       NodeInvertExpandedCollapsed(FoldersTree.TreeView)
      else
       if l_eeNode.HasChild then
        Say(inf_TryToExpandEmptyFolder, [vcmFmt(vcmCStr(str_TryToExpandFilteredFolder),[nsCStr(l_eeNode.Text)])])
       else
        Say(inf_TryToExpandEmptyFolder, [vcmFmt(vcmCStr(str_TryToExpandEmptyFolder),[nsCStr(l_eeNode.Text)])]);
    else
     OpenFolderElement(self.as_IvcmEntityForm, l_eeNode, vcm_okInCurrentTab);
    end;
   finally
    l_AdapterNode := nil;
   end;
  finally
   l_eeNode := nil;
  end;//try..finally
 end//(Container.AsForm.ZoneType <> vcm_ztManualModal
 else
 if (Aggregate <> nil) then
 begin
  if (Op_FolderElement_GetState.Call(Aggregate) in [fiLoad, fiSelect]) then
   op_Result_ExternalOk.Call(Aggregate);
 end;//Aggregate <> nil
//#UC END# *51C414B701C6_497DD4870291_impl*
end;//TPrimFoldersTreeForm.FoldersTreeActionElement

procedure TPrimFoldersTreeForm.FoldersTreeCurrentChanged(Sender: TObject;
 aNewCurrent: LongInt;
 aOldCurrent: LongInt);
//#UC START# *51C414C5000A_497DD4870291_var*
//#UC END# *51C414C5000A_497DD4870291_var*
begin
//#UC START# *51C414C5000A_497DD4870291_impl*
 DoFoldersTreeCurrentChanged(Sender, aNewCurrent, aOldCurrent);
//#UC END# *51C414C5000A_497DD4870291_impl*
end;//TPrimFoldersTreeForm.FoldersTreeCurrentChanged

procedure TPrimFoldersTreeForm.FoldersTreeTreeChanged(aSender: TObject;
 const anOldTree: Il3SimpleTree;
 const aNewTree: Il3SimpleTree);
//#UC START# *51C414CF0180_497DD4870291_var*
var
 l_Notify: InsFolderNodeNotify;
//#UC END# *51C414CF0180_497DD4870291_var*
begin
//#UC START# *51C414CF0180_497DD4870291_impl*
 if (anOldTree <> nil) and
   Supports(anOldTree.RootNode, InsFolderNodeNotify, l_Notify) then
  l_Notify.RemoveListener(InsFolderNodeListener(Self));
 if (aNewTree <> nil) and
   Supports(aNewTree.RootNode, InsFolderNodeNotify, l_Notify) then
  l_Notify.AddListener(InsFolderNodeListener(Self));
//#UC END# *51C414CF0180_497DD4870291_impl*
end;//TPrimFoldersTreeForm.FoldersTreeTreeChanged

procedure TPrimFoldersTreeForm.FoldersTreeGetItemFont(Sender: TObject;
 Index: LongInt;
 const aFont: Il3Font);
//#UC START# *51C414D901EA_497DD4870291_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *51C414D901EA_497DD4870291_var*
begin
//#UC START# *51C414D901EA_497DD4870291_impl*
 l_Node := FoldersTree.GetNode(Index);
 try
  // Консультация
  if bsCheckNodeType(l_Node, FIT_CONSULTATION) then
  begin
    if bsHasFlag(l_Node, [NF_ANSWER_RECEIVED]) or
      bsHasFlag(l_Node, [NF_CONSULTATION_SENT]) then
     aFont.Style := [fsBold];
  end//if bsCheckNodeType(aNode, FIT_CONSULTATION) then
  else
   ;
 finally
  l_Node := nil;
 end;{try..finally}
//#UC END# *51C414D901EA_497DD4870291_impl*
end;//TPrimFoldersTreeForm.FoldersTreeGetItemFont

procedure TPrimFoldersTreeForm.Notify(const aNotifier: Il3ChangeNotifier;
 aOperation: Integer;
 aIndex: Integer);
 {* прошла операция. }
//#UC START# *46A4504B03C4_497DD4870291_var*
//#UC END# *46A4504B03C4_497DD4870291_var*
begin
//#UC START# *46A4504B03C4_497DD4870291_impl*
 case TbsNotification(aOperation) of
  nConsultation:
   case TbsConsultationOperation(aIndex) of
    coUnreadChanged:
     FoldersTree.Invalidate;
   end;//case TbsConsultationOperation(aIndex) of
 end;//case TbsNotification(aOperation) of
//#UC END# *46A4504B03C4_497DD4870291_impl*
end;//TPrimFoldersTreeForm.Notify

procedure TPrimFoldersTreeForm.ChildNodeAdded(const aNode: Il3SimpleNode);
 {* был добавлен дочерний узел }
//#UC START# *49901C9600DD_497DD4870291_var*
//#UC END# *49901C9600DD_497DD4870291_var*
begin
//#UC START# *49901C9600DD_497DD4870291_impl*
 op_UsersRights_UpdateRights.Call(Aggregate, aNode As IeeNode);
 op_FolderElement_SetContent.Call(Aggregate, FoldersTree.TreeView.CurrentNode);
//#UC END# *49901C9600DD_497DD4870291_impl*
end;//TPrimFoldersTreeForm.ChildNodeAdded

procedure TPrimFoldersTreeForm.FolderElement_InternalEditByFoldersNode_Execute(const aNode: IFoldersNode;
 aInternalCall: Boolean = True);
 {* Редактирование элемента }
//#UC START# *4AE7060A03E7_497DD4870291exec_var*
var
 l_CurNode: IeeNode;
//#UC END# *4AE7060A03E7_497DD4870291exec_var*
begin
//#UC START# *4AE7060A03E7_497DD4870291exec_impl*
 if (Aggregate <> nil) then
  with FoldersTree.TreeView do
  begin
   if (aNode <> nil) then
   begin
    l_CurNode := FindOnAdapterNode(Tree, aNode);
    if (l_CurNode <> nil) then
     GoToNode(l_CurNode)
    else
     exit;
   end//aNode <> nil
   else
    exit;
   try
    FolderElement_InternalEdit_Execute(l_CurNode, aInternalCall);
   finally
    l_CurNode := nil;
   end;//try..finally
  end;//with FoldersTree.TreeView
//#UC END# *4AE7060A03E7_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.FolderElement_InternalEditByFoldersNode_Execute

procedure TPrimFoldersTreeForm.FolderElement_InternalEditByFoldersNode(const aParams: IvcmExecuteParamsPrim);
 {* Редактирование элемента }
begin
 with (aParams.Data As IFolderElement_InternalEditByFoldersNode_Params) do
  Self.FolderElement_InternalEditByFoldersNode_Execute(Node, InternalCall);
end;//TPrimFoldersTreeForm.FolderElement_InternalEditByFoldersNode

function TPrimFoldersTreeForm.FolderElement_InternalDelete_Execute(const aNode: IFoldersNode;
 aAsk: Boolean = True): TnsDeleteResult;
 {* Удаляет элемент папок }
//#UC START# *4AE7099B0136_497DD4870291exec_var*
var
 l_eeNode      : IeeNode;
//#UC END# *4AE7099B0136_497DD4870291exec_var*
begin
//#UC START# *4AE7099B0136_497DD4870291exec_impl*
 Result := drDenied;
 with FoldersTree.TreeView do
 begin
  if (aNode <> nil) then
  begin
   l_eeNode := FindOnAdapterNode(Tree, aNode);
   if (l_eeNode <> nil) then
    GoToNode(l_eeNode)
   else
    exit;
  end//aNode <> nil
  else
   l_eeNode := CurrentNode;

  op_FolderElement_ResetModificationOnDelete.Call(Aggregate, l_eeNode);

  try
   Result := DeleteNode(l_eeNode, aAsk);
  finally
   l_eeNode := nil;
  end;//try..finally
 end;//with FoldersTree.TreeView
//#UC END# *4AE7099B0136_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.FolderElement_InternalDelete_Execute

procedure TPrimFoldersTreeForm.FolderElement_InternalDelete(const aParams: IvcmExecuteParamsPrim);
 {* Удаляет элемент папок }
begin
 with (aParams.Data As IFolderElement_InternalDelete_Params) do
  ResultValue := Self.FolderElement_InternalDelete_Execute(Node, Ask);
end;//TPrimFoldersTreeForm.FolderElement_InternalDelete

procedure TPrimFoldersTreeForm.FolderElement_InternalEdit_Execute(const aNode: IeeNode;
 aInternalCall: Boolean = True);
//#UC START# *4AE7240E024C_497DD4870291exec_var*
//#UC END# *4AE7240E024C_497DD4870291exec_var*
begin
//#UC START# *4AE7240E024C_497DD4870291exec_impl*
 if (Op_FolderElement_GetState.Call(Aggregate) = fiEdit) then
 begin
  if not aInternalCall then
   EndEdit(aNode)
  else
   op_FolderElement_SetFocus.Call(Aggregate);
 end//Op_FolderElement_GetState.Call(Aggregate) = fiEdit
 else
  BeginEdit(aNode);
//#UC END# *4AE7240E024C_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.FolderElement_InternalEdit_Execute

procedure TPrimFoldersTreeForm.FolderElement_InternalEdit(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IFolderElement_InternalEdit_Params) do
  Self.FolderElement_InternalEdit_Execute(Node, InternalCall);
end;//TPrimFoldersTreeForm.FolderElement_InternalEdit

procedure TPrimFoldersTreeForm.SavedQuery_SetFilterState_Execute(const aNode: INode);
//#UC START# *4AEEBF3B01CD_497DD4870291exec_var*
//#UC END# *4AEEBF3B01CD_497DD4870291exec_var*
begin
//#UC START# *4AEEBF3B01CD_497DD4870291exec_impl*
//#UC END# *4AEEBF3B01CD_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.SavedQuery_SetFilterState_Execute

procedure TPrimFoldersTreeForm.SavedQuery_SetFilterState(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ISavedQuery_SetFilterState_Params) do
  Self.SavedQuery_SetFilterState_Execute(Node);
end;//TPrimFoldersTreeForm.SavedQuery_SetFilterState

procedure TPrimFoldersTreeForm.Folders_SetCurrent_Execute(const aNode: IeeNode);
//#UC START# *4AEEC3580234_497DD4870291exec_var*
//#UC END# *4AEEC3580234_497DD4870291exec_var*
begin
//#UC START# *4AEEC3580234_497DD4870291exec_impl*
 with FoldersTree.TreeView do
  if (GoToNode(aNode) > 0) then
   Tree.ChangeExpand(aNode, ee_sbSelect);
//#UC END# *4AEEC3580234_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.Folders_SetCurrent_Execute

procedure TPrimFoldersTreeForm.Folders_SetCurrent(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IFolders_SetCurrent_Params) do
  Self.Folders_SetCurrent_Execute(Node);
end;//TPrimFoldersTreeForm.Folders_SetCurrent

procedure TPrimFoldersTreeForm.Folders_FiltrateByFilterInfo_Execute(const anInfo: InsFolderFilterInfo);
//#UC START# *4AF2F57400D8_497DD4870291exec_var*
var
 l_FoldersInfo : InsFoldersInfo;
 l_Index       : Integer;
//#UC END# *4AF2F57400D8_497DD4870291exec_var*
begin
//#UC START# *4AF2F57400D8_497DD4870291exec_impl*
 l_FoldersInfo := GetFoldersInfo;
 if (l_FoldersInfo <> nil) then
  try
   l_Index := Ord(anInfo.FilterType);
   if (l_Index >= 0) then
   begin
    l_FoldersInfo.CantChangeFilter := False;
    if (f_OldFilter = -1) then
     f_OldFilter := Byte(l_FoldersInfo.FilterInfo.FilterType);
    if (anInfo <> nil) then
     l_FoldersInfo.FilterInfo := anInfo
    else
     Assert(false);
   end//l_Index >= 0
   else
    Assert(false);
   if (FoldersTree.TreeView.Current < 0) then
    // - если отфильтровалось все - то сбрасываем текущий у формы со свойствами.
    op_FolderElement_SetContent.Call(Aggregate, nil);
  finally
   l_FoldersInfo := nil;
  end;//try..finally
//#UC END# *4AF2F57400D8_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.Folders_FiltrateByFilterInfo_Execute

procedure TPrimFoldersTreeForm.Folders_FiltrateByFilterInfo(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IFolders_FiltrateByFilterInfo_Params) do
  Self.Folders_FiltrateByFilterInfo_Execute(nInfo);
end;//TPrimFoldersTreeForm.Folders_FiltrateByFilterInfo

procedure TPrimFoldersTreeForm.FolderElement_DisableFilter_Execute;
//#UC START# *4AF4741300DA_497DD4870291exec_var*
//#UC END# *4AF4741300DA_497DD4870291exec_var*
begin
//#UC START# *4AF4741300DA_497DD4870291exec_impl*
 GetFoldersInfo.CantChangeFilter := True;
//#UC END# *4AF4741300DA_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.FolderElement_DisableFilter_Execute

procedure TPrimFoldersTreeForm.FolderElement_DisableFilter(const aParams: IvcmExecuteParamsPrim);
begin
 Self.FolderElement_DisableFilter_Execute;
end;//TPrimFoldersTreeForm.FolderElement_DisableFilter

procedure TPrimFoldersTreeForm.Folders_TryOpenConsultationAnswer_Execute;
//#UC START# *4AF8170E0139_497DD4870291exec_var*

 function lp_TryOpenAnswer(aNode: Il3Node; aFlag: LongInt; OpenAnyway: Boolean): Boolean;

  function lp_FindOnlyAnswer(const anIntf: IeeNode) : Boolean;
  begin//FindOnlyAnswer
   Result := bsHasFlag(anIntf, [aFlag]);
  end;//FindOnlyAnswer

 var l_FirstUnread: IeeNode;
 var
  l_Node: IeeNode;
 begin
  Result := False;
  if Supports(aNode, IeeNode, l_Node) then
  try
   if OpenAnyway then
    nsSelectANDExpand(FoldersTree, l_Node, True);
   l_FirstUnread := l_Node.IterateF(eeL2NA(@lp_FindOnlyAnswer), imOneLevel or imCheckResult);
   if Assigned(l_FirstUnread) then
   begin
    nsSelectANDExpand(FoldersTree, l_Node, True);
    FoldersTree.TreeView.GoToNode(l_FirstUnread);
    Il3CommandTarget(FoldersTree).ProcessCommand(ccActionItem, True, 1);
    Result := True;
   end;
  finally
   l_Node := nil;
  end;{try..finally}
 end;

//#UC END# *4AF8170E0139_497DD4870291exec_var*
begin
//#UC START# *4AF8170E0139_497DD4870291exec_impl*
 if not lp_TryOpenAnswer(UserFoldersTree.ConsultationSentFolder, NF_PAYMENT_REQUEST, False) then
  lp_TryOpenAnswer(UserFoldersTree.ConsultationAnswerFolder, NF_ANSWER_RECEIVED, True);
//#UC END# *4AF8170E0139_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.Folders_TryOpenConsultationAnswer_Execute

procedure TPrimFoldersTreeForm.Folders_TryOpenConsultationAnswer(const aParams: IvcmExecuteParamsPrim);
begin
 Self.Folders_TryOpenConsultationAnswer_Execute;
end;//TPrimFoldersTreeForm.Folders_TryOpenConsultationAnswer

procedure TPrimFoldersTreeForm.Folders_OpenMyConsultations_Execute;
//#UC START# *4AF81CE50390_497DD4870291exec_var*
var
 l_Node: IeeNode;
//#UC END# *4AF81CE50390_497DD4870291exec_var*
begin
//#UC START# *4AF81CE50390_497DD4870291exec_impl*
 if Supports(UserFoldersTree.ConsultationsFolder, IeeNode, l_Node) then
 try
  nsSelectANDExpand(FoldersTree, l_Node, True);
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *4AF81CE50390_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.Folders_OpenMyConsultations_Execute

procedure TPrimFoldersTreeForm.Folders_OpenMyConsultations(const aParams: IvcmExecuteParamsPrim);
begin
 Self.Folders_OpenMyConsultations_Execute;
end;//TPrimFoldersTreeForm.Folders_OpenMyConsultations

procedure TPrimFoldersTreeForm.Folders_SetInfoContent_Execute;
//#UC START# *4AF81E1C012F_497DD4870291exec_var*
//#UC END# *4AF81E1C012F_497DD4870291exec_var*
begin
//#UC START# *4AF81E1C012F_497DD4870291exec_impl*
 if (Aggregate <> nil) then
 begin
  FoldersTree.TreeStruct; // !!! Это здесь нужно, т.к. иначе при вызове модальной формы
                          // дерево оказывается не прогружено
  op_FolderElement_SetContent.Call(Aggregate, FoldersTree.TreeView.CurrentNode);
 end;//Aggregate <> nil
//#UC END# *4AF81E1C012F_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.Folders_SetInfoContent_Execute

procedure TPrimFoldersTreeForm.Folders_SetInfoContent(const aParams: IvcmExecuteParamsPrim);
begin
 Self.Folders_SetInfoContent_Execute;
end;//TPrimFoldersTreeForm.Folders_SetInfoContent

procedure TPrimFoldersTreeForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_497DD4870291_var*
var
 l_Notify      : InsFolderNodeNotify;
 l_FoldersInfo : InsFoldersInfo;
//#UC END# *479731C50290_497DD4870291_var*
begin
//#UC START# *479731C50290_497DD4870291_impl*
 if FoldersTree.IsTreeAssign and
   Supports(FoldersTree.TreeStruct.RootNode, InsFolderNodeNotify, l_Notify) then
  l_Notify.RemoveListener(InsFolderNodeListener(Self));
 if (ConsultationManager <> nil) then
  ConsultationManager.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
 if FoldersTree.IsTreeAssign then
 begin
  l_FoldersInfo := FoldersInfo;
  if l_FoldersInfo <> nil then
   with l_FoldersInfo do
   begin
    FilterInfo.ShowFolders := sfAll;
    if f_OldFilter >= 0 then
    begin
     FilterInfo := TnsFolderFilterInfo.Make(TnsFolderFilter(f_OldFilter), ns_ffNone);
     CantChangeFilter := False;
    end
   end;
 end;
 inherited;
//#UC END# *479731C50290_497DD4870291_impl*
end;//TPrimFoldersTreeForm.Cleanup

procedure TPrimFoldersTreeForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_497DD4870291_var*
//#UC END# *49803F5503AA_497DD4870291_var*
begin
//#UC START# *49803F5503AA_497DD4870291_impl*
 FoldersTree.Images := nsFoldersRes.FoldersItemImages;
 f_OldFilter := -1;
 if (ConsultationManager <> nil) then
  ConsultationManager.As_Il3ChangeNotifier.Subscribe(Il3ItemNotifyRecipient(Self));
 FoldersTree.VJustify := vt_vjTop;
//#UC END# *49803F5503AA_497DD4870291_impl*
end;//TPrimFoldersTreeForm.DoInit

procedure TPrimFoldersTreeForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_497DD4870291_var*
//#UC END# *4A8E8F2E0195_497DD4870291_var*
begin
//#UC START# *4A8E8F2E0195_497DD4870291_impl*
 with FoldersTree do
 begin
  Align := alClient;
  BorderStyle := bsNone;
  ActionElementMode := l3_amSecondSingleClick;
  OnGetItemIconHint := FoldersTreeGetItemIconHint;
  OnMakeTreeSource := FoldersTreeMakeTreeSource;
  OnGetItemImage := FoldersTreeGetItemImage;
  OnGetItemTextHint := FoldersTreeGetItemTextHint;
  OnActionElement := FoldersTreeActionElement;
  OnCurrentChanged := FoldersTreeCurrentChanged;
  OnTreeChanged := FoldersTreeTreeChanged;
  OnGetItemFont := FoldersTreeGetItemFont;
  DragAndDropSupported := True;
  SettingId := 'stidFoldersTree';
 end;
//#UC END# *4A8E8F2E0195_497DD4870291_impl*
end;//TPrimFoldersTreeForm.InitControls

procedure TPrimFoldersTreeForm.MakeControls;
begin
 inherited;
 with AddUsertype(utFoldersTreeName,
  str_utFoldersTreeCaption,
  str_utFoldersTreeCaption,
  False,
  65,
  -1,
  utSaveOpenName,
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utFoldersTreeName
 with AddUsertype(utSaveOpenName,
  str_utSaveOpenCaption,
  str_utSaveOpenCaption,
  False,
  65,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utSaveOpenName
 f_FoldersTree := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_FoldersTree.Name := 'FoldersTree';
 f_FoldersTree.Parent := Self;
end;//TPrimFoldersTreeForm.MakeControls

initialization
 str_utFoldersTreeCaption.Init;
 {* Инициализация str_utFoldersTreeCaption }
 str_utSaveOpenCaption.Init;
 {* Инициализация str_utSaveOpenCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersTreeForm);
 {* Регистрация PrimFoldersTree }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
