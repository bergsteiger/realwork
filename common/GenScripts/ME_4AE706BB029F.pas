unit PrimFoldersElementInfo_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\Forms\PrimFoldersElementInfo_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimFoldersElementInfo" MUID: (4AE706BB029F)
// Имя типа: "TPrimFoldersElementInfoForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , Folders_Strange_Controls
 , FoldersDomainInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , eeInterfaces
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Interfaces
 , nsTypes
 , nsFolders
 , vtPanel
 , eeMemoWithEditOperations
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBoxWithReadOnly
 {$IfEnd} // Defined(Nemesis)
 , vtCheckBox
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , FoldersUnit
 , BaseTypesUnit
;

type
 TTypeMap = array [TFoldersElementType] of TFoldersItemType;

 TPrimFoldersElementInfoForm = class({$If NOT Defined(NoVCM)}
 TvcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_EDoChangedAlreadyDoneFired: Boolean;
    {* Если для дерева при обработке CHanged вздернулись еще скобки Changing/Changed и возникло EDoChangedAlreadyDone - запоромнить это и после остальной обрабиотки переподнять его }
   f_CommentPanel: TvtPanel;
    {* Поле для свойства CommentPanel }
   f_ElementComment: TeeMemoWithEditOperations;
    {* Поле для свойства ElementComment }
   f_CaptionPanel: TvtPanel;
    {* Поле для свойства CaptionPanel }
   f_lblComment: TvtLabel;
    {* Поле для свойства lblComment }
   f_TopPanel: TvtPanel;
    {* Поле для свойства TopPanel }
   f_NamePanel: TvtPanel;
    {* Поле для свойства NamePanel }
   f_lblElementName: TvtLabel;
    {* Поле для свойства lblElementName }
   f_ElementName: TnscComboBoxWithReadOnly;
    {* Поле для свойства ElementName }
   f_cbShared: TvtCheckBox;
    {* Поле для свойства cbShared }
   f_InfoName: TvtLabel;
    {* Поле для свойства InfoName }
  protected
   f_CurType: TFoldersInfoType;
   f_UserLoadParam: IUnknown;
   f_RequestingForm: IvcmEntityForm;
   f_CurNode: IeeNode;
   f_SaveControlState: TCheckBoxState;
   f_SavedObjType: TFoldersElementType;
   f_SavedName: Il3CString;
   f_SavedComment: Il3CString;
   f_SavedObject: IUnknown;
   f_SaveAsFlag: Boolean;
   f_Op: TListLogicOperation;
   f_FolderSecurity: TFolderSecurity;
  private
   procedure NamePanelResize(Sender: TObject);
   procedure vcmEntityFormCloseQueryEx(Sender: TObject;
    var CanClose: Boolean;
    aCaller: TCustomForm);
   procedure RegisterSaveOperation;
    {* операция сохранения регистрируется в логе пользователя }
   procedure BeginSetCurInfo;
   procedure EndSetCurInfo;
   function IsDocumentAlive: Boolean;
  protected
   function SendChosenObject: Boolean;
   function SaveCurInfo(aCheckNameModifiers: Boolean = True;
    aNamesOnly: Boolean = False;
    const aNode: IeeNode = nil): Boolean;
    {* После вызова делаем всю необходимую обработку и после нее ОБЯЗАТЕЛЬНО надо вызвать AfterSaveExceptionCheck, чтобы при необходимости переподнять EDoChangedAlreadyDone }
   function SaveOrOverrideCurObj: Boolean;
   function DoSaveCurObj(const aFolderNode: IeeNode): Boolean;
   function DoOverrideCurObj(const aNode: IeeNode): Boolean;
   function CheckAdapterNodeType(const aNode: IeeNode;
    aType: TFoldersItemType): Boolean;
   function FindCorrespondingFolder(const aNode: IeeNode): IeeNode;
   function FindNodeByName(const aFolderNode: IeeNode;
    const aName: Il3CString;
    aType: TFoldersItemType): IeeNode;
   procedure AfterSaveExceptionCheck;
    {* Если для дерева при обработке CHanged вздернулись еще скобки Changing/Changed и возникло EDoChangedAlreadyDone - запоромнить это и после остальной обработки переподнять его }
   procedure ShowCurInfo(NeedSuppressComment: Boolean = False);
   procedure SetSavedInfo;
   procedure ShowSavedInfo;
   function SetSavedObjectName: Boolean;
   function CheckModifiedState: Boolean;
   procedure DropModifiedState;
   procedure SetReadOnlyState(aState: Boolean);
   procedure LoadFolderRights(const aTreeNode: IeeNode);
   function CheckUnsaved: Boolean;
    {* Проверить сохраннность изменений. Возвращает признак того, что не сохраненных изменений нет (при необходимости спрашивая пользователя и сохраняя изменения) }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   function FolderElement_GetState_Execute: TFoldersInfoType;
    {* Возвращает статус элемента }
   procedure FolderElement_GetState(const aParams: IvcmExecuteParamsPrim);
    {* Возвращает статус элемента }
   procedure FolderElement_SetLoadInfo_Execute(const aForm: IvcmEntityForm;
    const aFolderFilterInfo: InsFolderFilterInfo;
    const aCaption: Il3CString;
    const aData: IUnknown;
    anOp: TListLogicOperation);
    {* Устанавливает параметры элемента }
   procedure FolderElement_SetLoadInfo(const aParams: IvcmExecuteParamsPrim);
    {* Устанавливает параметры элемента }
   procedure FolderElement_SetContent_Execute(const aNode: IeeNode;
    aIsNewFolder: Boolean = False);
    {* SetContent }
   procedure FolderElement_SetContent(const aParams: IvcmExecuteParamsPrim);
    {* SetContent }
   procedure FolderElement_SetSaveInfo_Execute(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean);
   procedure FolderElement_SetSaveInfo(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_SetState_Execute(aInfoType: TFoldersInfoType);
   procedure FolderElement_SetState(const aParams: IvcmExecuteParamsPrim);
   procedure UsersRights_UpdateRights_Execute(const aNode: IeeNode);
   procedure UsersRights_UpdateRights(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_ResetModificationOnDelete_Execute(const aNode: IeeNode);
   procedure FolderElement_ResetModificationOnDelete(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_SetFocus_Execute;
   procedure FolderElement_SetFocus(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_Redraw_Execute;
   procedure FolderElement_Redraw(const aParams: IvcmExecuteParamsPrim);
   procedure Result_ExternalOk_Execute;
   procedure Result_ExternalOk(const aParams: IvcmExecuteParamsPrim);
   procedure UsersRights_FolderShareChanged_Execute;
   procedure UsersRights_FolderShareChanged(const aParams: IvcmExecuteParamsPrim);
   procedure FolderElement_DisableSecurityPage_Execute;
   procedure FolderElement_DisableSecurityPage(const aParams: IvcmExecuteParamsPrim);
   {$If NOT Defined(NoVCM)}
   procedure SetActiveControl; override;
    {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property CommentPanel: TvtPanel
    read f_CommentPanel;
   property TopPanel: TvtPanel
    read f_TopPanel;
   property InfoName: TvtLabel
    read f_InfoName;
    {* Название }
 end;//TPrimFoldersElementInfoForm

const
 FIT_BOOKMARK = FoldersUnit.FIT_BOOKMARK;
 cTypeMap: TTypeMap = (FIT_BOOKMARK, FIT_BOOKMARK, FIT_LIST, FIT_QUERY, {FIT_QUERY, }FIT_PHARM_BOOKMARK, FIT_PHARM_LIST);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , Search_Strange_Controls
 , l3InterfacesMisc
 , BaseTreeSupportUnit
 , DocumentUnit
 , DynamicDocListUnit
 , SearchUnit
 , nsDocumentTools
 , bsUtils
 , Windows
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , DataAdapter
 , l3String
 , Base_Operations_Strange_Controls
 , l3Types
 , nsFolderNodes
 , nsNodes
 , LoggingUnit
 , Graphics
 , nsQueryUtils
 , nsSaveQueryEvent
 , nsSaveDocumentToFoldersEvent
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , PrimFoldersElementInfo_utFoldersProperty_UserType
;

{$If NOT Defined(NoVCM)}
const
 {* Локализуемые строки utFoldersPropertyLocalConstants }
 str_utFoldersPropertyCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utFoldersPropertyCaption'; rValue : 'Панель свойств');
  {* Заголовок пользовательского типа "Панель свойств" }

function TPrimFoldersElementInfoForm.SendChosenObject: Boolean;
//#UC START# *4AE75C84001D_4AE706BB029F_var*
//#UC END# *4AE75C84001D_4AE706BB029F_var*
begin
//#UC START# *4AE75C84001D_4AE706BB029F_impl*
 Result := Op_Loadable_Load.Call(f_RequestingForm, f_CurNode, f_UserLoadParam, f_Op);
//#UC END# *4AE75C84001D_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.SendChosenObject

procedure TPrimFoldersElementInfoForm.NamePanelResize(Sender: TObject);
//#UC START# *51BECEAD0398_4AE706BB029F_var*
const
 cBorder = 7;
//#UC END# *51BECEAD0398_4AE706BB029F_var*
begin
//#UC START# *51BECEAD0398_4AE706BB029F_impl*
 ElementName.Width := NamePanel.Width - 2 * cBorder;
//#UC END# *51BECEAD0398_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.NamePanelResize

procedure TPrimFoldersElementInfoForm.vcmEntityFormCloseQueryEx(Sender: TObject;
 var CanClose: Boolean;
 aCaller: TCustomForm);
//#UC START# *51BECFEB023A_4AE706BB029F_var*
//#UC END# *51BECFEB023A_4AE706BB029F_var*
begin
//#UC START# *51BECFEB023A_4AE706BB029F_impl*
 if not defDataAdapter.InTerminateProcess then
  CheckUnsaved;
//#UC END# *51BECFEB023A_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.vcmEntityFormCloseQueryEx

procedure TPrimFoldersElementInfoForm.RegisterSaveOperation;
 {* операция сохранения регистрируется в логе пользователя }
//#UC START# *51BED096010D_4AE706BB029F_var*
var
 l_Bookmark: IBookmark;
 l_Document: IDocument;
//#UC END# *51BED096010D_4AE706BB029F_var*
begin
//#UC START# *51BED096010D_4AE706BB029F_impl*
 if (f_SavedObjType in [fetBookmark, fetDrugBookMark]) and
   Supports(f_SavedObject, IBookmark, l_Bookmark) then
 try
  l_Bookmark.GetDocument(l_Document);
  try
   TnsSaveDocumentToFoldersEvent.Log(l_Document);
  finally
   l_Document := nil;
  end;{try..finally}
 finally
  l_Bookmark := nil;
 end;{try..finally}
//#UC END# *51BED096010D_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.RegisterSaveOperation

procedure TPrimFoldersElementInfoForm.BeginSetCurInfo;
//#UC START# *51BED0FE017A_4AE706BB029F_var*
//#UC END# *51BED0FE017A_4AE706BB029F_var*
begin
//#UC START# *51BED0FE017A_4AE706BB029F_impl*
// nop
//#UC END# *51BED0FE017A_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.BeginSetCurInfo

procedure TPrimFoldersElementInfoForm.EndSetCurInfo;
//#UC START# *51BED1130294_4AE706BB029F_var*
//#UC END# *51BED1130294_4AE706BB029F_var*
begin
//#UC START# *51BED1130294_4AE706BB029F_impl*
 DropModifiedState;
//#UC END# *51BED1130294_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.EndSetCurInfo

function TPrimFoldersElementInfoForm.IsDocumentAlive: Boolean;
//#UC START# *51BED12403CA_4AE706BB029F_var*
var
 l_Bookmark: IBookmark;
 l_Document: IDocument;
//#UC END# *51BED12403CA_4AE706BB029F_var*
begin
//#UC START# *51BED12403CA_4AE706BB029F_impl*
 Result := False;
 if Supports(f_SavedObject, IBookmark, l_Bookmark) then
  try
   try
    l_Bookmark.GetDocument(l_Document);
   except
    on ECanNotFindData do
     l_Document := nil;
   end;
   Result := (l_Document <> nil) and l_Document.IsAlive;
   l_Document := nil;
  finally
   l_Bookmark := nil;
  end;
//#UC END# *51BED12403CA_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.IsDocumentAlive

function TPrimFoldersElementInfoForm.SaveCurInfo(aCheckNameModifiers: Boolean = True;
 aNamesOnly: Boolean = False;
 const aNode: IeeNode = nil): Boolean;
 {* После вызова делаем всю необходимую обработку и после нее ОБЯЗАТЕЛЬНО надо вызвать AfterSaveExceptionCheck, чтобы при необходимости переподнять EDoChangedAlreadyDone }
//#UC START# *51BED14D03C0_4AE706BB029F_var*
var
 l_Node: INode;
 l_NewName: Il3CString;
 l_BaseEntity: IUnknown;
 l_eeNode: IeeNode;
//#UC END# *51BED14D03C0_4AE706BB029F_var*
begin
//#UC START# *51BED14D03C0_4AE706BB029F_impl*
 l_eeNode := aNode;
 if l_eeNode = nil then
  l_eeNode := f_CurNode;
 Result := False;
 l_NewName := l3Trim(ElementName.Text);
 if not l3IsNil(l_NewName) then
 begin
  if Supports(l_eeNode, INode, l_Node) then
  try
   l_eeNode.Changing;
   try
    try
     if not aCheckNameModifiers or
        ElementName.Modified then
      l_Node.SetCaption(nsIStr(l_NewName));

     if not aNamesOnly and
        (TFoldersItemType(l_Node.GetObjectType) in [FIT_BOOKMARK, FIT_PHARM_BOOKMARK]) then
     begin
      try
       l_Node.Open(l_BaseEntity);
       try
        Op_Document_ModifyBookmarkNotify.Broadcast(l_BaseEntity);
       finally
        l_BaseEntity := nil;
       end;//try..finally
      except
       on ECanNotFindData do ;
      end;//try..except
     end;//not aNamesOnly
    except
     on EDuplicateNode do
     begin
      Say(err_DuplicateNameError);
      exit;
     end;//on EDuplicateNode
    end;//try..except
    l_eeNode.Text := l_NewName;
    if not aCheckNameModifiers or
       ElementComment.Modified then
     l_Node.SetHint(nsIStr(l3Trim(ElementComment.Buffer)));

    if not aNamesOnly then
    begin
     { Доступ на папку }
     f_FolderSecurity.Save;
    end;

   finally
    l_Node := nil;
    try
     l_eeNode.Changed;
     l_eeNode.ParentNode.RelocateChild(f_CurNode);
    except
     on EDoChangedAlreadyDone do f_EDoChangedAlreadyDoneFired := True;
    end;
   end;
  except
   on ECanNotFindData do exit;
  end;

  DropModifiedState;
  Result := True;
 end
 else
  Say(err_EmptyItemNameError);
//#UC END# *51BED14D03C0_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.SaveCurInfo

function TPrimFoldersElementInfoForm.SaveOrOverrideCurObj: Boolean;
//#UC START# *51BED197007E_4AE706BB029F_var*
var
 l_Folder: IeeNode;
 l_NodeToOverride: IeeNode;
//#UC END# *51BED197007E_4AE706BB029F_var*
begin
//#UC START# *51BED197007E_4AE706BB029F_impl*
 l_Folder := FindCorrespondingFolder(f_CurNode);
 Assert(Assigned(l_Folder));
 l_NodeToOverride := FindNodeByName(l_Folder, ElementName.Text, cTypeMap[f_SavedObjType]);
 if l_NodeToOverride = nil then
  Result := DoSaveCurObj(l_Folder)
 else
  Result := DoOverrideCurObj(l_NodeToOverride);
//#UC END# *51BED197007E_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.SaveOrOverrideCurObj

function TPrimFoldersElementInfoForm.DoSaveCurObj(const aFolderNode: IeeNode): Boolean;
//#UC START# *51BED25503AD_4AE706BB029F_var*
  procedure lp_RegisterSaveQuery;
  var
   l_Query: IQuery;
  begin
   if (f_SavedObjType = fetQuery) and
    Supports(f_SavedObject, IQuery, l_Query) then
   try
    TnsSaveQueryEvent.Log(l_Query);
   finally
    l_Query := nil;
   end;//try..finally
  end;//lp_RegisterSaveQuery

var
 l_NewNode: IeeNode;
 l_NewAdapterNode: INode;
 l_AdapterNode: INode;
 l_Entity: IEntityBase;
 l_EntityStorage: IEntityStorage;
//#UC END# *51BED25503AD_4AE706BB029F_var*
begin
//#UC START# *51BED25503AD_4AE706BB029F_impl*
 Result := True;
 l_NewNode := nil;
 if Supports(aFolderNode, INode, l_AdapterNode) then
 begin
  try
   if (TFoldersItemType(l_AdapterNode.GetObjectType) = FIT_FOLDER) then
   begin
    case f_SavedObjType of
     fetBookmark, fetDrugBookMark:
      UserFoldersTree.BookmarkSavedFolder := aFolderNode;
     fetList, fetDrugList:
      UserFoldersTree.ListSavedFolder := aFolderNode;
     fetQuery{, fetFilter}:
      UserFoldersTree.QuerySavedFolder := aFolderNode;
     else
      Assert(false); 
    end;//case f_SavedObjType of
    // Попытка сохранить закладку на отсутствующий после обновления документ
    if (f_SavedObjType in [fetBookmark, fetDrugBookMark]) and
       not IsDocumentAlive then
    begin
     Say(war_SaveMissingDocument);
     f_SavedObject := nil;
     Result := False;
     exit;
    end;//f_SavedObjType in [fetBookmark, fetDrugBookMark]

    if SetSavedObjectName then
    begin
     try
      lp_RegisterSaveQuery;
      if f_SaveAsFlag and
         Supports(f_SavedObject, IEntityBase, l_Entity) then
      begin
       l_Entity.SaveTo(l_AdapterNode, l_EntityStorage);
       Supports(l_EntityStorage, INode, l_NewAdapterNode);
      end//f_SaveAsFlag..
      else
       l_AdapterNode.AddChildNode(f_SavedObject, l_NewAdapterNode);
      RegisterSaveOperation;
     except
      on EDuplicateNode do
      begin
       Say(err_DuplicateNameError);
       Result := False;
       exit;
      end;//on EDuplicateNode
      on EAccessDenied do
      begin
       Say(err_SaveReadOnlyObject);
       Result := False;
       exit;
      end;//on EAccessDenied
      on ECanNotSave do
      begin
       Say(err_CannotSaveSomething);
       Result := False;
       exit;
      end;//on ECanNotSave
      on ENotSaved do
      begin
       Say(err_NotSaved);
       Result := False;
       exit;
      end;//on ENotSaved
     end;//try..execpt
     l_NewAdapterNode.SetHint(nsIStr(l3Trim(ElementComment.Buffer)));
     l_NewNode := aFolderNode.InsertChild(TnsFoldersNode.Make(l_NewAdapterNode) as IeeNode);
     try
      aFolderNode.SortChilds;
     finally
      l_NewNode := nil;
     end;//try..finally
(*     if (f_SavedObjType = fetFilter) then
      op_SavedQuery_SetFilterState.Call(Aggregate, l_NewAdapterNode);*)

     if (f_SavedObjType in [fetBookmark, fetDrugBookMark]) then
      defDataAdapter.DocumentCacheSinchronize(fotAdd, f_SavedObject);
    end//SetSavedObjectName
    else
    begin
     Say(err_EmptyItemNameError);
     Result := False;
    end;//SetSavedObjectName
   end//TFoldersItemType(l_AdapterNode.GetObjectType) = FIT_FOLDER
   else
    Result := DoOverrideCurObj(aFolderNode);
  finally
   l_AdapterNode := nil;
  end;//try..finally
 end;//Supports(aFolderNode, INode, l_AdapterNode)
//#UC END# *51BED25503AD_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.DoSaveCurObj

function TPrimFoldersElementInfoForm.DoOverrideCurObj(const aNode: IeeNode): Boolean;
//#UC START# *51BED29502DC_4AE706BB029F_var*
var
 l_AdapterNode: INode;
 l_Object: IUnknown;
 l_Entity: IEntityBase;
 l_Storage: IEntityStorage;
 l_Bookmark: IBookmark;
 l_Query: IQuery;
//#UC END# *51BED29502DC_4AE706BB029F_var*
begin
//#UC START# *51BED29502DC_4AE706BB029F_impl*
 Result := False;
 if Ask(qr_FolderSave, [aNode.Text]) AND
    SaveCurInfo(False, True, aNode) then
 begin
  if Supports(aNode, INode, l_AdapterNode) then
   try
    try
     l_AdapterNode.Open(l_Object);
    except
     on ECanNotFindData do
      exit; //TODO: нода "пропала" что делать?
    end;//try..except
    l_Query := nil;
    if not Supports(l_Object, IQuery, l_Query) then
    begin
     if Supports(f_SavedObject, IBookmark, l_Bookmark) then
      try
       // Меняем закладке имя
       l_Bookmark.SetName(nsIStr(l3Trim(ElementName.Text)));
       // Нотификация об удалении закладки, которая будет перезаписана
       defDataAdapter.DocumentCacheSinchronize(fotDelete, l_Object);
      finally
       l_Bookmark := nil;
      end;//try..finally
    end;//not Supports(l_Object, IQuery, l_Query)

    if Supports(f_SavedObject, IEntityBase, l_Entity) then
     try
      try
       l_Entity.SaveTo(l_AdapterNode, l_Storage);
       RegisterSaveOperation;
       Result := True;
      except
       on EDuplicateNode do
       begin
        Say(err_DuplicateNameError);
        exit;
       end;//on EDuplicateNode
       on EAccessDenied do
       begin
        Say(err_SaveReadOnlyObject);
        exit;
       end;//on EAccessDenied
       on ECanNotSave do
       begin
        Say(err_CannotSaveSomething);
        exit;
       end;//on ECanNotSave
       on ENotSaved do
       begin
        Say(err_NotSaved);
        exit;
       end;//on ENotSaved
      end;//try..except

      if (f_SavedObjType in [fetBookmark, fetDrugBookmark]) then
       defDataAdapter.DocumentCacheSinchronize(fotAdd, f_SavedObject);
     finally
      if (l_Query <> nil) then
       l_Query := nil;
     end;//try..finally

(*    if (f_SavedObjType = fetFilter) then
     op_SavedQuery_SetFilterState.Call(Aggregate, l_AdapterNode);*)

   finally
    l_AdapterNode := nil;
   end;//try..finally
 end;//Ask(qr_FolderSave, [aNode.Text])
//#UC END# *51BED29502DC_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.DoOverrideCurObj

function TPrimFoldersElementInfoForm.CheckAdapterNodeType(const aNode: IeeNode;
 aType: TFoldersItemType): Boolean;
//#UC START# *51BED2C201CC_4AE706BB029F_var*
var
 l_Node: INode;
//#UC END# *51BED2C201CC_4AE706BB029F_var*
begin
//#UC START# *51BED2C201CC_4AE706BB029F_impl*
 Result := Supports(aNode, INode, l_Node) and (TFoldersItemType(l_Node.GetObjectType) = aType);
//#UC END# *51BED2C201CC_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.CheckAdapterNodeType

function TPrimFoldersElementInfoForm.FindCorrespondingFolder(const aNode: IeeNode): IeeNode;
//#UC START# *51BED301019F_4AE706BB029F_var*
//#UC END# *51BED301019F_4AE706BB029F_var*
begin
//#UC START# *51BED301019F_4AE706BB029F_impl*
 Result := aNode;
 while Assigned(Result) and not CheckAdapterNodeType(Result, FIT_FOLDER) do
  Result := Result.ParentNode;
 if not Supports(Result, INode) then
  Result := nil;
//#UC END# *51BED301019F_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.FindCorrespondingFolder

function TPrimFoldersElementInfoForm.FindNodeByName(const aFolderNode: IeeNode;
 const aName: Il3CString;
 aType: TFoldersItemType): IeeNode;
//#UC START# *51BED32D01C5_4AE706BB029F_var*
//#UC END# *51BED32D01C5_4AE706BB029F_var*
begin
//#UC START# *51BED32D01C5_4AE706BB029F_impl*
 Result := aFolderNode.ChildNode;
 while Assigned(Result) and not (l3Same(Result.Text, aName) and CheckAdapterNodeType(Result, aType)) do
 begin
  if Result.IsLast then
   Result := nil
  else
   Result := Result.NextNode;
 end;
//#UC END# *51BED32D01C5_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.FindNodeByName

procedure TPrimFoldersElementInfoForm.AfterSaveExceptionCheck;
 {* Если для дерева при обработке CHanged вздернулись еще скобки Changing/Changed и возникло EDoChangedAlreadyDone - запоромнить это и после остальной обработки переподнять его }
//#UC START# *51BED38C01FC_4AE706BB029F_var*
//#UC END# *51BED38C01FC_4AE706BB029F_var*
begin
//#UC START# *51BED38C01FC_4AE706BB029F_impl*
 if f_EDoChangedAlreadyDoneFired then
 begin
  f_EDoChangedAlreadyDoneFired := False;
  raise EDoChangedAlreadyDone.Create('');
 end;
//#UC END# *51BED38C01FC_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.AfterSaveExceptionCheck

procedure TPrimFoldersElementInfoForm.ShowCurInfo(NeedSuppressComment: Boolean = False);
//#UC START# *51BED3EA03BB_4AE706BB029F_var*
var
 l_Node: INode;
//#UC END# *51BED3EA03BB_4AE706BB029F_var*
begin
//#UC START# *51BED3EA03BB_4AE706BB029F_impl*
 if f_CurType = fiEdit then
  if CheckFolderElementRights(f_CurNode, faModify) then
   SetReadOnlyState(False)
  else
   SetReadOnlyState(True);

 BeginSetCurInfo;
 try
  if (f_CurNode <> nil) then
  begin
   SetSavedInfo;
   ElementName.Text := f_CurNode.Text;
   ElementName.ClearUndoRedoLists;
   if Supports(f_CurNode, INode, l_Node) then
    try
     if not NeedSuppressComment then
      ElementComment.Buffer := nsGetHint(l_Node).AsWStr;

     { Доступ к папкам }
     LoadFolderRights(f_CurNode);
     
    finally
     l_Node := nil;
    end
   else
   begin
    ElementComment.Text := '';
   end;
  end;
 finally
  EndSetCurInfo;
 end;
//#UC END# *51BED3EA03BB_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.ShowCurInfo

procedure TPrimFoldersElementInfoForm.SetSavedInfo;
//#UC START# *51BED4720039_4AE706BB029F_var*
//#UC END# *51BED4720039_4AE706BB029F_var*
begin
//#UC START# *51BED4720039_4AE706BB029F_impl*
 if (f_CurType = fiSave) then
 begin
  if ElementName.Modified or ElementComment.Modified then
  begin
   f_SavedName := l3Trim(ElementName.Text);
   f_SavedComment := l3Trim(nsCStr(ElementComment.Buffer));
  end;//ElementName.Modified..
 end;
//#UC END# *51BED4720039_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.SetSavedInfo

procedure TPrimFoldersElementInfoForm.ShowSavedInfo;
//#UC START# *51BED482026B_4AE706BB029F_var*
//#UC END# *51BED482026B_4AE706BB029F_var*
begin
//#UC START# *51BED482026B_4AE706BB029F_impl*
 SetSavedInfo;

 ElementName.Text := f_SavedName;
 ElementName.Hint := l3Str(f_SavedName);
 ElementName.SelectAll;

 ElementComment.Buffer := nsWStr(f_SavedComment);

 DropModifiedState;
//#UC END# *51BED482026B_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.ShowSavedInfo

function TPrimFoldersElementInfoForm.SetSavedObjectName: Boolean;
//#UC START# *51BED493009F_4AE706BB029F_var*
var
 l_List: IDynList;
 l_Query: IQuery;
 l_Bookmark: IBookmark;
 l_ElementName: Il3CString;
//#UC END# *51BED493009F_4AE706BB029F_var*
begin
//#UC START# *51BED493009F_4AE706BB029F_impl*
 l_ElementName := l3Trim(ElementName.Text);
 Result := not l3IsNil(l_ElementName);
 if Result then
  case f_SavedObjType of
   fetBookmark, fetDrugBookMark :
    if Supports(f_SavedObject, IBookmark, l_Bookmark) then
     try
      l_Bookmark.SetName(nsIStr(l_ElementName));
     finally
      l_Bookmark := nil;
     end;//Supports(f_SavedObject, IBookmark, l_Bookmark)
   fetList, fetDrugList:
    if Supports(f_SavedObject, IDynList, l_List) then
     try
      l_List.SetName(nsIStr(l_ElementName));
     finally
      l_List := nil;
     end;//Supports(f_SavedObject, IDynList, l_List)
   fetQuery{, fetFilter}:
    if Supports(f_SavedObject, IQuery, l_Query) then
     try
      l_Query.SetName(nsIStr(l_ElementName));
     finally
      l_Query := nil;
     end;//Supports(f_SavedObject, IQuery, l_Query)
   else
    Assert(false);
  end;//case f_SavedObjType
//#UC END# *51BED493009F_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.SetSavedObjectName

function TPrimFoldersElementInfoForm.CheckModifiedState: Boolean;
//#UC START# *51BED50202F0_4AE706BB029F_var*
//#UC END# *51BED50202F0_4AE706BB029F_var*
begin
//#UC START# *51BED50202F0_4AE706BB029F_impl*
 if f_CurType in [fiNewFolder, fiEdit] then
 begin
  { Свойства папки }
  Result := ElementName.Modified or ElementComment.Modified;
  { Проверка изменения доступа }
  if not Result then
   Result := f_FolderSecurity.Modified;
 end
 else
  Result := False;
//#UC END# *51BED50202F0_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.CheckModifiedState

procedure TPrimFoldersElementInfoForm.DropModifiedState;
//#UC START# *51BED51F009F_4AE706BB029F_var*
//#UC END# *51BED51F009F_4AE706BB029F_var*
begin
//#UC START# *51BED51F009F_4AE706BB029F_impl*
 ElementName.Modified := False;
 ElementComment.Modified := False;
 f_FolderSecurity.Modified := False;
//#UC END# *51BED51F009F_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.DropModifiedState

procedure TPrimFoldersElementInfoForm.SetReadOnlyState(aState: Boolean);
//#UC START# *51BED52F0054_4AE706BB029F_var*
//#UC END# *51BED52F0054_4AE706BB029F_var*
begin
//#UC START# *51BED52F0054_4AE706BB029F_impl*
 ElementName.Enabled := not aState;
 ElementComment.ReadOnly := aState;
//#UC END# *51BED52F0054_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.SetReadOnlyState

procedure TPrimFoldersElementInfoForm.LoadFolderRights(const aTreeNode: IeeNode);
//#UC START# *51BED550018B_4AE706BB029F_var*
var
 lCursor: TCursor;
//#UC END# *51BED550018B_4AE706BB029F_var*
begin
//#UC START# *51BED550018B_4AE706BB029F_impl*
 lCursor := Screen.Cursor;
 try
  Screen.Cursor := crHourGlass;
  f_FolderSecurity.eeFolder := aTreeNode;
 finally
  Screen.Cursor := lCursor;
 end;
//#UC END# *51BED550018B_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.LoadFolderRights

function TPrimFoldersElementInfoForm.CheckUnsaved: Boolean;
 {* Проверить сохраннность изменений. Возвращает признак того, что не сохраненных изменений нет (при необходимости спрашивая пользователя и сохраняя изменения) }
//#UC START# *51BED56C0178_4AE706BB029F_var*
//#UC END# *51BED56C0178_4AE706BB029F_var*
begin
//#UC START# *51BED56C0178_4AE706BB029F_impl*
 Result := true;
 if CheckModifiedState then
 begin
  if Ask(qr_SaveItemQuery) then
  begin
   Result := SaveCurInfo;
   AfterSaveExceptionCheck;
  end
  else
   DropModifiedState;
 end;
//#UC END# *51BED56C0178_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.CheckUnsaved

function TPrimFoldersElementInfoForm.FolderElement_GetState_Execute: TFoldersInfoType;
 {* Возвращает статус элемента }
//#UC START# *4AE7073F0388_4AE706BB029Fexec_var*
//#UC END# *4AE7073F0388_4AE706BB029Fexec_var*
begin
//#UC START# *4AE7073F0388_4AE706BB029Fexec_impl*
 if (Parent = nil) or Parent.Visible then
  Result := f_CurType
 else
  Result := fiNone;
//#UC END# *4AE7073F0388_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.FolderElement_GetState_Execute

procedure TPrimFoldersElementInfoForm.FolderElement_GetState(const aParams: IvcmExecuteParamsPrim);
 {* Возвращает статус элемента }
begin
 with (aParams.Data As IFolderElement_GetState_Params) do
  ResultValue := Self.FolderElement_GetState_Execute;
end;//TPrimFoldersElementInfoForm.FolderElement_GetState

procedure TPrimFoldersElementInfoForm.FolderElement_SetLoadInfo_Execute(const aForm: IvcmEntityForm;
 const aFolderFilterInfo: InsFolderFilterInfo;
 const aCaption: Il3CString;
 const aData: IUnknown;
 anOp: TListLogicOperation);
 {* Устанавливает параметры элемента }
//#UC START# *4AE74E1C007F_4AE706BB029Fexec_var*
//#UC END# *4AE74E1C007F_4AE706BB029Fexec_var*
begin
//#UC START# *4AE74E1C007F_4AE706BB029Fexec_impl*
 f_RequestingForm := aForm;
 if (Aggregate <> nil) then
 begin
  op_Folders_FiltrateByFilterInfo.Call(Aggregate, aFolderFilterInfo);
  Op_FolderElement_DisableFilter.Call(Aggregate);

  if (aCaption <> nil) then
   Op_AdditionInfo_SetCaption.Call(Aggregate, aCaption)
  else
   Op_AdditionInfo_SetCaption.Call(Aggregate, vcmCStr(str_SelectCaption));
 end;//Aggregate <> nil

 f_UserLoadParam := aData;
 f_Op := anOp;
//#UC END# *4AE74E1C007F_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.FolderElement_SetLoadInfo_Execute

procedure TPrimFoldersElementInfoForm.FolderElement_SetLoadInfo(const aParams: IvcmExecuteParamsPrim);
 {* Устанавливает параметры элемента }
begin
 with (aParams.Data As IFolderElement_SetLoadInfo_Params) do
  Self.FolderElement_SetLoadInfo_Execute(Form, FolderFilterInfo, Caption, Data, nOp);
end;//TPrimFoldersElementInfoForm.FolderElement_SetLoadInfo

procedure TPrimFoldersElementInfoForm.FolderElement_SetContent_Execute(const aNode: IeeNode;
 aIsNewFolder: Boolean = False);
 {* SetContent }
//#UC START# *4AE85279013B_4AE706BB029Fexec_var*
var
 l_AdapterNode: INode;
//#UC END# *4AE85279013B_4AE706BB029Fexec_var*
begin
//#UC START# *4AE85279013B_4AE706BB029Fexec_impl*
 if (aNode <> nil) then
 begin
  if not l3IEQ(f_CurNode, aNode) then
  begin
   if CheckModifiedState then
   begin
    if Ask(qr_SaveItemQuery) then
     SaveCurInfo;
   end;
   f_CurNode := aNode;
  end
  else
   Exit;
 end//aNode <> nil
 else
  f_CurNode := nil;

 if (Parent = nil) or
    Parent.Visible then
 begin
  if not aIsNewFolder and
     (f_CurType = fiNewFolder) then
  begin
   f_CurType := fiEdit;
   InfoName.CCaption := vcmCStr(cInfoCaptions[f_CurType]^);
  end;

  if (f_CurType <> fiSave) then
   ShowCurInfo
  else
   if Supports(f_CurNode, INode, l_AdapterNode) and
      (TFoldersItemType(l_AdapterNode.GetObjectType) = FIT_FOLDER) then
    ShowSavedInfo
   else
   begin
    ShowCurInfo(TFoldersItemType(l_AdapterNode.GetObjectType) = cTypeMap[f_SavedObjType]);
   end;
 end;
 AfterSaveExceptionCheck;
//#UC END# *4AE85279013B_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.FolderElement_SetContent_Execute

procedure TPrimFoldersElementInfoForm.FolderElement_SetContent(const aParams: IvcmExecuteParamsPrim);
 {* SetContent }
begin
 with (aParams.Data As IFolderElement_SetContent_Params) do
  Self.FolderElement_SetContent_Execute(Node, IsNewFolder);
end;//TPrimFoldersElementInfoForm.FolderElement_SetContent

procedure TPrimFoldersElementInfoForm.FolderElement_SetSaveInfo_Execute(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean);
//#UC START# *4AE857EF0085_4AE706BB029Fexec_var*

 procedure lp_FoldersFiltrate;
 begin
  if (Aggregate <> nil) then
  begin
   Assert(aFilterInfo <> nil);
   Op_Folders_FiltrateByFilterInfo.Call(Aggregate, aFilterInfo);
  end;//Aggregate <> nil
 end;//procedure lp_FoldersFiltrate;

var
 l_List: IDynList;
 l_Query: IQuery;
 l_Bookmark: IBookmark;
 l_CurFolder: IeeNode;
//#UC END# *4AE857EF0085_4AE706BB029Fexec_var*
begin
//#UC START# *4AE857EF0085_4AE706BB029Fexec_impl*
 f_SaveControlState := cbUnChecked;
 f_SavedObjType := anElementType;
 case f_SavedObjType of
  fetBookmark, fetDrugBookMark :
   begin
    if Supports(anEntity, IBookmark, l_Bookmark) then
     try
      f_SavedName := nsGetBookmarkName(l_Bookmark);
      f_SavedComment := nsGetBookmarkComment(l_Bookmark);
     finally
      l_Bookmark := nil;
     end;
    l_CurFolder := UserFoldersTree.BookmarkSavedFolder;
   end;//fetBookmark, fetDrugBookMark
  fetList, fetDrugList:
   begin
    if Supports(anEntity, IDynList, l_List) then
     try
      f_SavedName := bsListName(l_List);
      f_SavedComment := nil;
     finally
      l_List := nil;
     end;
    l_CurFolder := UserFoldersTree.ListSavedFolder;
   end;//fetList, fetDrugList
  fetQuery    :
   begin
    if Supports(anEntity, IQuery, l_Query) then
     try
      f_SavedName := nsCreateQueryName(l_Query);
      f_SavedComment := nil;
     finally
      l_Query := nil;
     end;
    l_CurFolder := UserFoldersTree.QuerySavedFolder;
   end;//fetQuery
(*  fetFilter   :
   begin
    if Supports(anEntity, IQuery, l_Query) then
     try
      case l_Query.GetType of
       QT_KEYWORD:
        f_SavedName := vcmFmt(str_SituationFilterName, [DateTimeToStr(Now)]);
       QT_ATTRIBUTE{,
       QT_OLD_ATTRIBUTE}:
        f_SavedName := vcmFmt(str_AttributesFilterName, [DateTimeToStr(Now)]);
//       QT_OLD_FILTER:
//        f_SavedName := vcmFmt(str_SimpleFilterName, [DateTimeToStr(Now)]);
       QT_PUBLISHED_SOURCE:
        f_SavedName := vcmFmt(str_PublishSourceFilterName, [DateTimeToStr(Now)]);
       QT_BASE_SEARCH:
        f_SavedName := vcmFmt(str_BaseSearchFilterName, [DateTimeToStr(Now)]);
       QT_PHARM_SEARCH:
        f_SavedName := vcmFmt(str_InpharmSearchFilterName, [DateTimeToStr(Now)]);
       else
        Assert(false); 
      end;//case l_Query.GetType
      f_SavedComment := nil;
     finally
      l_Query := nil;
     end;//try..finally
    l_CurFolder := UserFoldersTree.QuerySavedFolder;
   end;//fetFilter*)
   else
    Assert(false);
 end;//case f_SavedObjType
 f_SavedObject := anEntity;
 f_SaveAsFlag := aSaveAs;
 if (l_CurFolder <> nil) then
  Op_Folders_SetCurrent.Call(Aggregate, l_CurFolder);
 f_RequestingForm := aForm;
 lp_FoldersFiltrate;
//#UC END# *4AE857EF0085_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.FolderElement_SetSaveInfo_Execute

procedure TPrimFoldersElementInfoForm.FolderElement_SetSaveInfo(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IFolderElement_SetSaveInfo_Params) do
  Self.FolderElement_SetSaveInfo_Execute(Form, FilterInfo, nElementType, nEntity, SaveAs);
end;//TPrimFoldersElementInfoForm.FolderElement_SetSaveInfo

procedure TPrimFoldersElementInfoForm.FolderElement_SetState_Execute(aInfoType: TFoldersInfoType);
//#UC START# *4AE9C01201BA_4AE706BB029Fexec_var*
//#UC END# *4AE9C01201BA_4AE706BB029Fexec_var*
begin
//#UC START# *4AE9C01201BA_4AE706BB029Fexec_impl*
 f_CurType := aInfoType;
 InfoName.CCaption := vcmCStr(cInfoCaptions[f_CurType]^);

 SetReadOnlyState(f_CurType in [fiNone, fiLoad, fiSelect]);

 if not ((f_CurType = fiNewFolder) or
         ((f_CurType = fiEdit) and (f_SavedObjType = fetNone) and
         CheckAdapterNodeType(f_CurNode, FIT_FOLDER))) then
  if (f_CurType = fiSave) then
   ShowSavedInfo;
//#UC END# *4AE9C01201BA_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.FolderElement_SetState_Execute

procedure TPrimFoldersElementInfoForm.FolderElement_SetState(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IFolderElement_SetState_Params) do
  Self.FolderElement_SetState_Execute(InfoType);
end;//TPrimFoldersElementInfoForm.FolderElement_SetState

procedure TPrimFoldersElementInfoForm.UsersRights_UpdateRights_Execute(const aNode: IeeNode);
//#UC START# *4AEEC5EA03DC_4AE706BB029Fexec_var*
//#UC END# *4AEEC5EA03DC_4AE706BB029Fexec_var*
begin
//#UC START# *4AEEC5EA03DC_4AE706BB029Fexec_impl*
 LoadFolderRights(aNode);
//#UC END# *4AEEC5EA03DC_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.UsersRights_UpdateRights_Execute

procedure TPrimFoldersElementInfoForm.UsersRights_UpdateRights(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IUsersRights_UpdateRights_Params) do
  Self.UsersRights_UpdateRights_Execute(Node);
end;//TPrimFoldersElementInfoForm.UsersRights_UpdateRights

procedure TPrimFoldersElementInfoForm.FolderElement_ResetModificationOnDelete_Execute(const aNode: IeeNode);
//#UC START# *4AEEC8810299_4AE706BB029Fexec_var*
//#UC END# *4AEEC8810299_4AE706BB029Fexec_var*
begin
//#UC START# *4AEEC8810299_4AE706BB029Fexec_impl*
 if l3IEQ(f_CurNode, aNode) and CheckModifiedState then
 begin
  DropModifiedState;
  FolderElement_SetContent_Execute(aNode);
 end;//l3IEQ(f_CurNode, aNode)..
//#UC END# *4AEEC8810299_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.FolderElement_ResetModificationOnDelete_Execute

procedure TPrimFoldersElementInfoForm.FolderElement_ResetModificationOnDelete(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IFolderElement_ResetModificationOnDelete_Params) do
  Self.FolderElement_ResetModificationOnDelete_Execute(Node);
end;//TPrimFoldersElementInfoForm.FolderElement_ResetModificationOnDelete

procedure TPrimFoldersElementInfoForm.FolderElement_SetFocus_Execute;
//#UC START# *4AF46E0C017F_4AE706BB029Fexec_var*
//#UC END# *4AF46E0C017F_4AE706BB029Fexec_var*
begin
//#UC START# *4AF46E0C017F_4AE706BB029Fexec_impl*
 Windows.SetFocus(ElementName.Handle);
//#UC END# *4AF46E0C017F_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.FolderElement_SetFocus_Execute

procedure TPrimFoldersElementInfoForm.FolderElement_SetFocus(const aParams: IvcmExecuteParamsPrim);
begin
 Self.FolderElement_SetFocus_Execute;
end;//TPrimFoldersElementInfoForm.FolderElement_SetFocus

procedure TPrimFoldersElementInfoForm.FolderElement_Redraw_Execute;
//#UC START# *4AF4727C0020_4AE706BB029Fexec_var*
var
 l_AdapterNode: INode;
//#UC END# *4AF4727C0020_4AE706BB029Fexec_var*
begin
//#UC START# *4AF4727C0020_4AE706BB029Fexec_impl*
 if (f_CurType <> fiSave) then
  ShowCurInfo
 else
 if Supports(f_CurNode, INode, l_AdapterNode) and
    (TFoldersItemType(l_AdapterNode.GetObjectType) = FIT_FOLDER) then
  ShowSavedInfo
 else
  ShowCurInfo;
//#UC END# *4AF4727C0020_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.FolderElement_Redraw_Execute

procedure TPrimFoldersElementInfoForm.FolderElement_Redraw(const aParams: IvcmExecuteParamsPrim);
begin
 Self.FolderElement_Redraw_Execute;
end;//TPrimFoldersElementInfoForm.FolderElement_Redraw

procedure TPrimFoldersElementInfoForm.Result_ExternalOk_Execute;
//#UC START# *4AF4768A0372_4AE706BB029Fexec_var*
var
 l_AdapterNode: INode;
 l_OpsResult: Boolean;
//#UC END# *4AF4768A0372_4AE706BB029Fexec_var*
begin
//#UC START# *4AF4768A0372_4AE706BB029Fexec_impl*
 if f_CurType in [fiLoad, fiSelect, fiSave] then
 begin
  case f_CurType of
   fiLoad,
   fiSelect:
      begin
       if Supports(f_CurNode, INode, l_AdapterNode) and
          (TFoldersItemType(l_AdapterNode.GetObjectType) <> FIT_FOLDER) then
        l_OpsResult := SendChosenObject
       else
        l_OpsResult := False;

       l_AdapterNode := nil;
      end;
   fiSave :
      begin
       if CheckFolderElementRights(f_CurNode, faModify) then
        l_OpsResult := SaveOrOverrideCurObj
       else
        l_OpsResult := False;

       l_AdapterNode := nil;
      end;
   else
    l_OpsResult := False;
  end;

  if l_OpsResult then
  begin
   if (Aggregate <> nil) then
    if Container.AsForm.ZoneType = vcm_ztManualModal then
     Op_AdditionInfo_Close.Call(Aggregate, mrOK)
    else
    begin
     f_CurType := fiNone;
     Container.Operation(TdmStdRes.opcode_AdditionInfo_Hide);
    end;
  end;
 end;
//#UC END# *4AF4768A0372_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.Result_ExternalOk_Execute

procedure TPrimFoldersElementInfoForm.Result_ExternalOk(const aParams: IvcmExecuteParamsPrim);
begin
 Self.Result_ExternalOk_Execute;
end;//TPrimFoldersElementInfoForm.Result_ExternalOk

procedure TPrimFoldersElementInfoForm.UsersRights_FolderShareChanged_Execute;
//#UC START# *4AF4797100E8_4AE706BB029Fexec_var*
//#UC END# *4AF4797100E8_4AE706BB029Fexec_var*
begin
//#UC START# *4AF4797100E8_4AE706BB029Fexec_impl*
 with f_FolderSecurity do
 begin
  ShareChanged;
  Modified := False;
 end;
//#UC END# *4AF4797100E8_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.UsersRights_FolderShareChanged_Execute

procedure TPrimFoldersElementInfoForm.UsersRights_FolderShareChanged(const aParams: IvcmExecuteParamsPrim);
begin
 Self.UsersRights_FolderShareChanged_Execute;
end;//TPrimFoldersElementInfoForm.UsersRights_FolderShareChanged

procedure TPrimFoldersElementInfoForm.FolderElement_DisableSecurityPage_Execute;
//#UC START# *4AF814650325_4AE706BB029Fexec_var*
//#UC END# *4AF814650325_4AE706BB029Fexec_var*
begin
//#UC START# *4AF814650325_4AE706BB029Fexec_impl*
 cbShared.Enabled := False;
//#UC END# *4AF814650325_4AE706BB029Fexec_impl*
end;//TPrimFoldersElementInfoForm.FolderElement_DisableSecurityPage_Execute

procedure TPrimFoldersElementInfoForm.FolderElement_DisableSecurityPage(const aParams: IvcmExecuteParamsPrim);
begin
 Self.FolderElement_DisableSecurityPage_Execute;
end;//TPrimFoldersElementInfoForm.FolderElement_DisableSecurityPage

procedure TPrimFoldersElementInfoForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AE706BB029F_var*
//#UC END# *479731C50290_4AE706BB029F_var*
begin
//#UC START# *479731C50290_4AE706BB029F_impl*
 f_SavedComment := nil;
 f_SavedName := nil;
 f_SavedObject := nil;
 vcmFree(f_FolderSecurity);
 inherited;
//#UC END# *479731C50290_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.Cleanup

procedure TPrimFoldersElementInfoForm.InitFields;
//#UC START# *47A042E100E2_4AE706BB029F_var*
//#UC END# *47A042E100E2_4AE706BB029F_var*
begin
//#UC START# *47A042E100E2_4AE706BB029F_impl*
 inherited;
 f_Op := LLO_NONE;
//#UC END# *47A042E100E2_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.InitFields

procedure TPrimFoldersElementInfoForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4AE706BB029F_var*
//#UC END# *49803F5503AA_4AE706BB029F_var*
begin
//#UC START# *49803F5503AA_4AE706BB029F_impl*
 f_FolderSecurity := TFolderSecurity.Create(cbShared);

 // http://mdp.garant.ru/pages/viewpage.action?pageId=303858572&focusedCommentId=305955493#comment-305955493
 // на всякий случай, т.к. ограничение только для оболочки
 {$If not defined(Admin) AND not defined(Monitorings)}
  if (DefDataAdapter <> nil) then
  begin
    //ElementName.DisableDragAndDropSupport := DefDataAdapter.IsTrialMode;
    //ElementComment.DisableDragAndDropSupport := DefDataAdapter.IsTrialMode;
  end;
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *49803F5503AA_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.DoInit

procedure TPrimFoldersElementInfoForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4AE706BB029F_var*
//#UC END# *4A8E8F2E0195_4AE706BB029F_var*
begin
//#UC START# *4A8E8F2E0195_4AE706BB029F_impl*
 BorderIcons := [biSystemMenu];
 BorderStyle := bsDialog;
 ClientHeight := 260;
 ClientWidth := 344;
 Scaled := False;
 OnCloseQueryEx := vcmEntityFormCloseQueryEx;

 with InfoName do
 begin
  Left := 0;
  Top := 0;
  Width := 344;
  Height := 15;
  Align := alTop;
  Font.Height := -12;
  Font.Style := [fsBold];
 end;
 with CommentPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  BorderWidth := 7;
  TabOrder := 1;
 end;
 with ElementComment do
 begin
  Align := alClient;
  BorderStyle := bsSingle;
  TabOrder := 0;
  TabStop := True;
 end;
 with CaptionPanel do
 begin
  Height := 18;
  Align := alTop;
  BevelOuter := bvNone;
  TabOrder := 1;
 end;
 with lblComment do
 begin
  Left := 0;
  Top := 0;
  Width := 78;
  Height := 16;
 end;
 with TopPanel do
 begin
  Height := 66;
  Align := alTop;
  BevelOuter := bvNone;
  TabOrder := 0;
 end;
 with NamePanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
  TabOrder := 0;
  OnResize := NamePanelResize;
 end;
 with lblElementName do
 begin
  Left := 8;
  Top := 1;
  Width := 29;
  Height := 16;
 end;
 with ElementName do
 begin
  Left := 7;
  Top := 17;
  Width := 326;
  Height := 22;
  Anchors := [akLeft, akTop, akRight];
  TabOrder := 0;
  ShowHint := True;
 end;
 with cbShared do
 begin
  Left := 8;
  Top := 48;
  Width := 321;
  Height := 17;
  TabOrder := 1;
 end;
//#UC END# *4A8E8F2E0195_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.InitControls

procedure TPrimFoldersElementInfoForm.SetActiveControl;
 {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
//#UC START# *4AC3803A03CD_4AE706BB029F_var*
//#UC END# *4AC3803A03CD_4AE706BB029F_var*
begin
//#UC START# *4AC3803A03CD_4AE706BB029F_impl*
 Windows.SetFocus(ElementName.Handle);
//#UC END# *4AC3803A03CD_4AE706BB029F_impl*
end;//TPrimFoldersElementInfoForm.SetActiveControl

procedure TPrimFoldersElementInfoForm.ClearFields;
begin
 f_UserLoadParam := nil;
 f_RequestingForm := nil;
 f_CurNode := nil;
 f_SavedName := nil;
 f_SavedComment := nil;
 f_SavedObject := nil;
 inherited;
end;//TPrimFoldersElementInfoForm.ClearFields

initialization
 str_utFoldersPropertyCaption.Init;
 {* Инициализация str_utFoldersPropertyCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimFoldersElementInfoForm);
 {* Регистрация PrimFoldersElementInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
