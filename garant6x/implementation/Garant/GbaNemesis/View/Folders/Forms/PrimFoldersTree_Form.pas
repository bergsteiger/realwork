unit PrimFoldersTree_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Folders/Forms/PrimFoldersTree_Form.pas"
// Начат: 26.01.2009 18:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Основные прецеденты::Folders::View::Folders::PrimFoldersTree
//
// Дерево папок
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
  l3Interfaces,
  l3TreeInterfaces,
  l3ControlsTypes,
  eeInterfaces,
  FoldersInterfaces,
  eeTreeView,
  FoldersDomainInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  nsTypes,
  Folders_Strange_Controls
  {$If not defined(NoVCL)}
  ,
  ImgList
  {$IfEnd} //not NoVCL
  ,
  l3StringIDEx,
  PrimFoldersTree_utFoldersTree_UserType,
  PrimFoldersTree_utSaveOpen_UserType,
  vtLister
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  vtOutliner,
  nscTreeViewWithAdapterDragDrop,
  FoldersUnit,
  BaseTreeSupportUnit,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  vcmControllers {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TPrimFoldersTreeForm = {form} class(TvcmEntityForm, Il3ItemNotifyRecipient, InsFolderNodeListener)
  {* Дерево папок }
 private
 // private fields
   f_FoldersTree : TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства FoldersTree}
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure InitEntities; override;
  procedure MakeControls; override;
 private
 // private methods
   function FoldersTreeGetItemIconHint(Sender: TObject;
     Index: LongInt): Il3CString;
     {* event to get Hint String; }
   procedure FoldersTreeMakeTreeSource(out theTree: Il3SimpleTree);
   function FoldersTreeGetItemImage(Sender: TObject;
     Index: Integer;
     var aImages: TCustomImageList): Integer;
     {* Event to get Index of Bitmap in ImageIndex. }
   function FoldersTreeGetItemTextHint(Sender: TObject;
     Index: LongInt): Il3CString;
     {* получение hint-а при задерке курсора над текстом. }
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
     {* event to get Font of the item cell
событие для получения шрифта элемента. }
 protected
 // property methods
   function pm_GetFoldersInfo: InsFoldersInfo;
 protected
 // realized methods
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
     {* прошла операция. }
   procedure ChildNodeAdded(const aNode: Il3SimpleNode);
     {* был добавлен дочерний узел }
   procedure FolderElement_InternalEditByFoldersNode_Execute(const aNode: IFoldersNode;
    aInternalCall: Boolean = true);
     {* Редактирование элемента }
   procedure FolderElement_InternalEditByFoldersNode(const aParams: IvcmExecuteParams);
     {* Редактирование элемента }
   function FolderElement_InternalDelete_Execute(const aNode: IFoldersNode;
    aAsk: Boolean = true): TnsDeleteResult;
     {* Удаляет элемент папок }
   procedure FolderElement_InternalDelete(const aParams: IvcmExecuteParams);
     {* Удаляет элемент папок }
   procedure FolderElement_InternalEdit_Execute(const aNode: IeeNode;
    aInternalCall: Boolean = true);
   procedure FolderElement_InternalEdit(const aParams: IvcmExecuteParams);
   procedure SavedQuery_SetFilterState_Execute(const aNode: INode);
   procedure SavedQuery_SetFilterState(const aParams: IvcmExecuteParams);
   procedure Folders_SetCurrent_Execute(const aNode: IeeNode);
   procedure Folders_SetCurrent(const aParams: IvcmExecuteParams);
   procedure Folders_FiltrateByFilterInfo_Execute(const anInfo: InsFolderFilterInfo);
   procedure Folders_FiltrateByFilterInfo(const aParams: IvcmExecuteParams);
   procedure FolderElement_DisableFilter_Execute;
   procedure FolderElement_DisableFilter(const aParams: IvcmExecuteParams);
   procedure Folders_TryOpenConsultationAnswer_Execute;
   procedure Folders_TryOpenConsultationAnswer(const aParams: IvcmExecuteParams);
   procedure Folders_OpenMyConsultations_Execute;
   procedure Folders_OpenMyConsultations(const aParams: IvcmExecuteParams);
   procedure Folders_SetInfoContent_Execute;
   procedure Folders_SetInfoContent(const aParams: IvcmExecuteParams);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   dsFoldersTree : IdsFoldersTree;
    {* Дерево папок}
   f_OldFilter : Integer;
 protected
 // protected methods
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
 protected
 // protected properties
   property FoldersInfo: InsFoldersInfo
     read pm_GetFoldersInfo;
 public
 // public properties
   property FoldersTree: TnscTreeViewWithAdapterDragDrop
     read f_FoldersTree;
 end;//TPrimFoldersTreeForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  nsTreeUtils
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3Tree_TLB,
  bsUtils,
  nsUtils
  {$If defined(Nemesis)}
  ,
  eeTreeMisc
  {$IfEnd} //Nemesis
  ,
  l3InternalInterfaces,
  OvcConst,
  nsFolders,
  nsNodes,
  FoldersRes,
  l3String,
  afwFacade,
  nsConst,
  nsOpenUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  nsManagers,
  nsFolderFilterInfo,
  Graphics,
  nsQuestionsWithChoices,
  bsTypes,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки utFoldersTreeLocalConstants }
  str_utFoldersTreeCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFoldersTreeCaption'; rValue : 'Мои документы (вкладка)');
   { Заголовок пользовательского типа "Мои документы (вкладка)" }

var
   { Локализуемые строки utSaveOpenLocalConstants }
  str_utSaveOpenCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utSaveOpenCaption'; rValue : 'Мои документы');
   { Заголовок пользовательского типа "Мои документы" }

// start class TPrimFoldersTreeForm

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

function TPrimFoldersTreeForm.pm_GetFoldersInfo: InsFoldersInfo;
//#UC START# *4C7E75040189_497DD4870291get_var*
//#UC END# *4C7E75040189_497DD4870291get_var*
begin
//#UC START# *4C7E75040189_497DD4870291get_impl*
 Supports(FoldersTree.TreeStruct, InsFoldersInfo, Result);
//#UC END# *4C7E75040189_497DD4870291get_impl*
end;//TPrimFoldersTreeForm.pm_GetFoldersInfo

procedure TPrimFoldersTreeForm.Notify(const aNotifier: Il3ChangeNotifier;
  aOperation: Integer;
  aIndex: Integer);
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
//#UC START# *49901C9600DD_497DD4870291_var*
//#UC END# *49901C9600DD_497DD4870291_var*
begin
//#UC START# *49901C9600DD_497DD4870291_impl*
 op_UsersRights_UpdateRights.Call(Aggregate, aNode As IeeNode);
 op_FolderElement_SetContent.Call(Aggregate, FoldersTree.TreeView.CurrentNode);
//#UC END# *49901C9600DD_497DD4870291_impl*
end;//TPrimFoldersTreeForm.ChildNodeAdded

procedure TPrimFoldersTreeForm.FolderElement_InternalEditByFoldersNode_Execute(const aNode: IFoldersNode;
  aInternalCall: Boolean = true);
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

procedure TPrimFoldersTreeForm.FolderElement_InternalEditByFoldersNode(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFolderElement_InternalEditByFoldersNode_Params) do
  FolderElement_InternalEditByFoldersNode_Execute(Node, InternalCall);
end;

function TPrimFoldersTreeForm.FolderElement_InternalDelete_Execute(const aNode: IFoldersNode;
  aAsk: Boolean = true): TnsDeleteResult;
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

procedure TPrimFoldersTreeForm.FolderElement_InternalDelete(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFolderElement_InternalDelete_Params) do
  ResultValue := FolderElement_InternalDelete_Execute(Node, Ask);
end;

procedure TPrimFoldersTreeForm.FolderElement_InternalEdit_Execute(const aNode: IeeNode;
  aInternalCall: Boolean = true);
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

procedure TPrimFoldersTreeForm.FolderElement_InternalEdit(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFolderElement_InternalEdit_Params) do
  FolderElement_InternalEdit_Execute(Node, InternalCall);
end;

procedure TPrimFoldersTreeForm.SavedQuery_SetFilterState_Execute(const aNode: INode);
//#UC START# *4AEEBF3B01CD_497DD4870291exec_var*
//#UC END# *4AEEBF3B01CD_497DD4870291exec_var*
begin
//#UC START# *4AEEBF3B01CD_497DD4870291exec_impl*
//#UC END# *4AEEBF3B01CD_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.SavedQuery_SetFilterState_Execute

procedure TPrimFoldersTreeForm.SavedQuery_SetFilterState(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As ISavedQuery_SetFilterState_Params) do
  SavedQuery_SetFilterState_Execute(Node);
end;

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

procedure TPrimFoldersTreeForm.Folders_SetCurrent(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFolders_SetCurrent_Params) do
  Folders_SetCurrent_Execute(Node);
end;

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

procedure TPrimFoldersTreeForm.Folders_FiltrateByFilterInfo(const aParams: IvcmExecuteParams);
begin
 with (aParams.Data As IFolders_FiltrateByFilterInfo_Params) do
  Folders_FiltrateByFilterInfo_Execute(nInfo);
end;

procedure TPrimFoldersTreeForm.FolderElement_DisableFilter_Execute;
//#UC START# *4AF4741300DA_497DD4870291exec_var*
//#UC END# *4AF4741300DA_497DD4870291exec_var*
begin
//#UC START# *4AF4741300DA_497DD4870291exec_impl*
 GetFoldersInfo.CantChangeFilter := True;
//#UC END# *4AF4741300DA_497DD4870291exec_impl*
end;//TPrimFoldersTreeForm.FolderElement_DisableFilter_Execute

procedure TPrimFoldersTreeForm.FolderElement_DisableFilter(const aParams: IvcmExecuteParams);
begin
 FolderElement_DisableFilter_Execute;
end;

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

procedure TPrimFoldersTreeForm.Folders_TryOpenConsultationAnswer(const aParams: IvcmExecuteParams);
begin
 Folders_TryOpenConsultationAnswer_Execute;
end;

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

procedure TPrimFoldersTreeForm.Folders_OpenMyConsultations(const aParams: IvcmExecuteParams);
begin
 Folders_OpenMyConsultations_Execute;
end;

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

procedure TPrimFoldersTreeForm.Folders_SetInfoContent(const aParams: IvcmExecuteParams);
begin
 Folders_SetInfoContent_Execute;
end;

procedure TPrimFoldersTreeForm.Cleanup;
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

{$If not defined(NoVCM)}
procedure TPrimFoldersTreeForm.DoInit(aFromHistory: Boolean);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimFoldersTreeForm.InitControls;
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
{$IfEnd} //not NoVCM

procedure TPrimFoldersTreeForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  dsFoldersTree := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsFoldersTree, dsFoldersTree);
 end;//aDsNew = nil
end;

procedure TPrimFoldersTreeForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_FolderElement, nil);
  PublishFormEntity(en_SavedQuery, nil);
  PublishFormEntity(en_Folders, nil);
  PublishOpWithResult(en_FolderElement, op_InternalEditByFoldersNode, FolderElement_InternalEditByFoldersNode, nil, nil);
  PublishOpWithResult(en_FolderElement, op_InternalDelete, FolderElement_InternalDelete, nil, nil);
  PublishOpWithResult(en_FolderElement, op_InternalEdit, FolderElement_InternalEdit, nil, nil);
  PublishOpWithResult(en_SavedQuery, op_SetFilterState, SavedQuery_SetFilterState, nil, nil);
  PublishOpWithResult(en_Folders, op_SetCurrent, Folders_SetCurrent, nil, nil);
  PublishOpWithResult(en_Folders, op_FiltrateByFilterInfo, Folders_FiltrateByFilterInfo, nil, nil);
  PublishOpWithResult(en_FolderElement, op_DisableFilter, FolderElement_DisableFilter, nil, nil);
  PublishOpWithResult(en_Folders, op_TryOpenConsultationAnswer, Folders_TryOpenConsultationAnswer, nil, nil);
  PublishOpWithResult(en_Folders, op_OpenMyConsultations, Folders_OpenMyConsultations, nil, nil);
  PublishOpWithResult(en_Folders, op_SetInfoContent, Folders_SetInfoContent, nil, nil);
 end;//with Entities.Entities
end;

procedure TPrimFoldersTreeForm.MakeControls;
begin
 inherited;
 f_FoldersTree := TnscTreeViewWithAdapterDragDrop.Create(Self);
 f_FoldersTree.Name := 'FoldersTree';
 f_FoldersTree.Parent := Self;
 with AddUsertype(utFoldersTreeName,
  str_utFoldersTreeCaption,
  str_utFoldersTreeCaption,
  false,
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
  true,
  65,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utSaveOpenName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utFoldersTreeCaption
 str_utFoldersTreeCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utSaveOpenCaption
 str_utSaveOpenCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimFoldersTree
 TtfwClassRef.Register(TPrimFoldersTreeForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.