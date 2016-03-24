unit PrimContents_Form;
 {* Оглавление }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimContents_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimContents" MUID: (4979DFB700F8)
// Имя типа: "TPrimContentsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmEntityForm
 {$IfEnd} // NOT Defined(NoVCM)
 , bsInterfaces
 , Document_Strange_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Tree_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , LegalDomain_DocumentNotifications_Controls
 , TreeInterfaces
 , DocumentAndListInterfaces
 , DocumentInterfaces
 , vtPanel
 , vtLister
 , nscTreeViewWithAdapterDragDrop
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTasksPanelView
 {$IfEnd} // Defined(Nemesis)
 , l3TreeInterfaces
 , nevTools
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , eeInterfaces
 , nevContainers
 , afwInterfaces
 , l3Interfaces
 , DynamicTreeUnit
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , F1TagDataProviderInterface
 , Classes
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_ContentsPrintTitle: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ContentsPrintTitle'; rValue : '%s (оглавление)');
  {* '%s (оглавление)' }

type
 TMoveDirectionType = (
  mdtNone
  , mdtDown
  , mdtUp
 );//TMoveDirectionType

 TnsContentItem = (
  {* Типы элементов структуры }
  cltNone
  , cltBlock
  , cltBookmark
  , cltUserComment
  , cltPicture
  , cltPictureLink
  , cltRTF
  , cltMP3
  , cltXLS
  , cltEVD
  , cltPDF
 );//TnsContentItem

 TnsFilteredLists = array [TnsContentsListType] of IFiltered;

 TnsListForFiltering = array [TnsContentsListType] of TvtLister;

 _ContentsUserTypes_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes.imp.pas}
 TPrimContentsForm = class(_ContentsUserTypes_, InsTreeDataListener)
  {* Оглавление }
  private
   f_Filtered: TnsFilteredLists;
   f_ListForFiltering: TnsListForFiltering;
   f_CloseDisabled: Boolean;
   f_ContentsTreeLastUpdateTime: Longword;
    {* http://mdp.garant.ru/pages/viewpage.action?pageId=298682625 }
   f_ContextFilterDocInfo: IdeDocInfo;
   f_LastBlockIdForHasSimilar: Integer;
   f_LastHasSimilar: Boolean;
   f_BackgroundPanel: TvtPanel;
    {* Поле для свойства BackgroundPanel }
   f_lstBookmarks: TvtLister;
    {* Поле для свойства lstBookmarks }
   f_lstComments: TvtLister;
    {* Поле для свойства lstComments }
   f_lstExternalObjects: TvtLister;
    {* Поле для свойства lstExternalObjects }
   f_ContentsTree: TnscTreeViewWithAdapterDragDrop;
    {* Поле для свойства ContentsTree }
   f_ContextFilter: TnscContextFilter;
    {* Поле для свойства ContextFilter }
   f_Tasks: TnscTasksPanelView;
    {* Поле для свойства Tasks }
  protected
   SimpleTree: IdsSimpleTree;
   Contents: IdsContents;
   BaseContents: IdsBaseContents;
   f_InternalPositioning: Integer;
   {$If Defined(vcmUseProfilers)}
   f_FirstCurrentChanged: Boolean;
   {$IfEnd} // Defined(vcmUseProfilers)
  private
   procedure GetContentsListItem(Sender: TObject;
    Index: Integer;
    var ItemString: Il3CString);
   procedure InitLists;
   function GetBookmarksItemImage(Sender: TObject;
    Index: Integer): Integer;
   function GetCommentsItemImage(Sender: TObject;
    Index: Integer): Integer;
   function GetExternalObjectsItemImage(Sender: TObject;
    Index: Integer): Integer;
   procedure ContentsListActionElement(Sender: TObject;
    Index: Integer);
   procedure ContentsListCurrentChanged(Sender: TObject;
    aNewCurrent: Integer;
    aOldCurrent: Integer);
   procedure ContextFilterChange(Sender: TObject);
   procedure ContextFilterWrongContext(Sender: TObject);
   procedure ContentsTreeNewCharPressed(aChar: AnsiChar);
   procedure ContentsTreeCurrentChanged(Sender: TObject;
    NewCurrent: Integer;
    OldCurrent: Integer);
   function ContentsTreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
   procedure ContentsTreeTreeChanged(aSender: TObject;
    const anOldTree: Il3SimpleTree;
    const aNewTree: Il3SimpleTree);
   procedure ContentsTreeActionElement(Sender: TObject;
    Index: Integer);
   procedure ContentsTreeMakeTreeSource(out theTree: Il3SimpleTree);
   procedure ContentsTreeRootChanged(aSender: TObject;
    const anOldRoot: IeeNode;
    const aNewRoot: IeeNode);
   function CheckFilteredIndex(aSender: TObject;
    anIndex: Integer): TnsContentsListIndex;
   procedure GetIsContextWrong(aSender: TObject;
    var IsWrong: Boolean);
   procedure DoContentsListActionElement(Sender: TObject;
    Index: Integer;
    aNeedClose: Boolean);
   function FloatingHide: Boolean;
   procedure CheckFocus;
    {* Проверяет в форме ли фокус и если это не так, то ставит его на первый возможный контрол }
   procedure CheckActionElementMode;
   procedure StoreFloatingVisible(aValue: Boolean);
  protected
   function FindSubByID(anID: Integer): Il3SimpleNode;
   function IsMultiSelection: Boolean;
   procedure FillCRList(const aParams: IvcmTestParamsPrim);
   procedure enDocumentBlockTest(const aParams: IvcmTestParamsPrim;
    AllowMultiSelect: Boolean);
   function MakePositionList(const aNode: IeeNode = nil): IPositionList;
   function IsCurrentBlockOrSub: Boolean;
   function IsNodeBlockOrSub(const aNode: IeeNode): Boolean;
   function ContentItemType(const aNode: IeeNode = nil): TnsContentItem;
   function BuildSelectionList: InevFlatSubsList;
   function TextFormUserType: Byte;
   function CanPrintBlock: Boolean;
   function CanPreview: Boolean;
   function MakePreview: IafwDocumentPreview;
   function MakeEVD: InevStorable;
   function CanPrint: Boolean;
   procedure SendSynchroMessage(anIndex: Integer);
   function IsFloatingState: Boolean;
    {* Определяет - находится ли вкладка оглавления в плавающем состоянии }
   procedure ExpandFirstLevel;
   procedure Updated;
    {* данные дерева были обновлены. Реакция на обновление данных
            приложения }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
    const aNew: IvcmViewAreaController); override;
    {* Изменился источник данных. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure CheckFloatingVisibility; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   procedure Contents_SetCurrent_Execute(aSub: Integer);
   procedure Contents_SetCurrent(const aParams: IvcmExecuteParamsPrim);
   procedure Contents_MoveCurrent_Execute(aSub: Integer;
    aDown: Boolean);
   procedure Contents_MoveCurrent(const aParams: IvcmExecuteParamsPrim);
   procedure DocumentBlock_GetCorrespondentList_Test(const aParams: IvcmTestParamsPrim);
   procedure DocumentBlock_GetCorrespondentList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure DocumentBlock_GetRespondentList_Test(const aParams: IvcmTestParamsPrim);
   procedure DocumentBlock_GetRespondentList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure DocumentBlock_GetTypedCorrespondentList_Test(const aParams: IvcmTestParamsPrim);
   procedure DocumentBlock_GetTypedCorrespondentList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure DocumentBlock_GetTypedCorrespondentList_GetState(var State: TvcmOperationStateIndex);
   procedure DocumentBlock_GetTypedRespondentList_Test(const aParams: IvcmTestParamsPrim);
   procedure DocumentBlock_GetTypedRespondentList_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure DocumentBlockBookmarks_AddBookmark_Test(const aParams: IvcmTestParamsPrim);
    {* Установить закладку на фрагмент }
   procedure DocumentBlockBookmarks_AddBookmark_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Установить закладку на фрагмент }
   procedure DocumentBlock_ToMSWord_Test(const aParams: IvcmTestParamsPrim);
   procedure DocumentBlock_ToMSWord_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure DocumentBlock_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
   procedure DocumentBlock_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure DocumentBlock_Copy_Test(const aParams: IvcmTestParamsPrim);
   procedure DocumentBlock_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure DocumentBlock_Print_Test(const aParams: IvcmTestParamsPrim);
   procedure DocumentBlock_Print_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure DocumentBlock_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
   procedure DocumentBlock_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure DocumentBlock_Select_Test(const aParams: IvcmTestParamsPrim);
   procedure DocumentBlock_Select_Execute(const aParams: IvcmExecuteParamsPrim);
   function ContentsValidator_IsDocumentAdornmentsChanged_Execute(const aNew: InsDocumentAdornments): Boolean;
   procedure ContentsValidator_IsDocumentAdornmentsChanged(const aParams: IvcmExecuteParamsPrim);
   function Contents_HasUserComments_Execute: Boolean;
    {* Есть ли в оглавление пользовательские комментарии }
   procedure Contents_HasUserComments(const aParams: IvcmExecuteParamsPrim);
    {* Есть ли в оглавление пользовательские комментарии }
   function Contents_HasBookmarks_Execute: Boolean;
    {* Есть ли в оглавлении закладки }
   procedure Contents_HasBookmarks(const aParams: IvcmExecuteParamsPrim);
    {* Есть ли в оглавлении закладки }
   function Contents_ToggleContentsVisibility_Execute: Boolean;
    {* Переключает видимость ПЛАВАЮЩЕГО окна оглавления, возвращает true если переключение удалось }
   procedure Contents_ToggleContentsVisibility(const aParams: IvcmExecuteParamsPrim);
    {* Переключает видимость ПЛАВАЮЩЕГО окна оглавления, возвращает true если переключение удалось }
   function Contents_IsContentsVisible_Execute: Boolean;
    {* Возвращает состояние видимости ПЛАВАЮЩЕГО окна оглавления }
   procedure Contents_IsContentsVisible(const aParams: IvcmExecuteParamsPrim);
    {* Возвращает состояние видимости ПЛАВАЮЩЕГО окна оглавления }
   procedure Comment_Changed_Execute;
   procedure Comment_Changed(const aParams: IvcmExecuteParamsPrim);
   procedure DocumentBlock_GetSimilarDocsToBlock_Test(const aParams: IvcmTestParamsPrim);
   procedure DocumentBlock_GetSimilarDocsToBlock_Execute(const aParams: IvcmExecuteParamsPrim);
   constructor Create(AOwner: TComponent); override;
   {$If NOT Defined(NoVCM)}
   procedure DefaultQueryClose(aSender: TObject); override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function CanHaveCloseButtonInNavigator: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function CanHaveOwnCloseButtonInNavigator: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   property BackgroundPanel: TvtPanel
    read f_BackgroundPanel;
 end;//TPrimContentsForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsLogEvent
 , ContentsUserTypes_utDrugContents_UserType
 , eeTreeView
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nsContentsTreeStorable
 , nsConst
 , nsTrialSupport
 , nsToMSWordOp
 , Printers
 , nsHAFPainter
 , evFormatHAFMacroReplacer
 , nsDocInfoHAFMacroReplacer
 , nsDocumentPreview
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3ControlsTypes
 {$If Defined(Nemesis)}
 , nscTasksPanel
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTasksPanelGroupDescList
 {$IfEnd} // Defined(Nemesis)
 , MainMenuNewRes
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , nsUtils
 {$If Defined(Nemesis)}
 , eeTreeMisc
 {$IfEnd} // Defined(Nemesis)
 , nsContentsListForFiltering
 , Windows
 , l3SysUtils
 , l3Tree_TLB
 , evdTextStyle_Const
 , l3Base
 , Base_Operations_Strange_Controls
 , afwFacade
 , Graphics
 {$If NOT Defined(NoVCM)}
 , vcmRepOperationsCollectionItem
 {$IfEnd} // NOT Defined(NoVCM)
 , nsManagers
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , DataAdapter
 , ExternalObjectUnit
 , BaseTypesUnit
 , nevNavigation
 , BitmapPara_Const
 , nevFlatSubsList
 , l3Nodes
 , DocumentUserTypes_dftDocument_UserType
 , DocumentUserTypes_dftDrug_UserType
 , l3InternalInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nevBase
 , SysUtils
 , evdTypes
 , l3Variant
 , bsTypesNew
 , nsTypes
 , DocumentRes
 , nsFilterableTreeStruct
 , nsContextFilterParams
 , IOUnit
 , LoggingUnit
;

{$If NOT Defined(NoVCM)}
type
 TnsGetDocumentStructureEvent = {final} class(TnsLogEvent)
  public
   class procedure Log(const aDoc: IDocument);
 end;//TnsGetDocumentStructureEvent

 // DocumentBlockExcludeForInpharm

const
 {* Локализуемые строки ContentsGroups }
 str_cgContents: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cgContents'; rValue : 'Оглавление');
  {* 'Оглавление' }
 str_cgBookmarks: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cgBookmarks'; rValue : 'Закладки');
  {* 'Закладки' }
 str_cgComments: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cgComments'; rValue : 'Мои комментарии');
  {* 'Мои комментарии' }
 str_cgExternalObjects: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cgExternalObjects'; rValue : 'Встроенные объекты');
  {* 'Встроенные объекты' }

class procedure TnsGetDocumentStructureEvent.Log(const aDoc: IDocument);
//#UC START# *4B150E0B0174_4B150DFE035D_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B150E0B0174_4B150DFE035D_var*
begin
//#UC START# *4B150E0B0174_4B150DFE035D_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 GetLogger.AddEvent(LE_GET_DOCUMENT_STRUCTURE, l_Data);
//#UC END# *4B150E0B0174_4B150DFE035D_impl*
end;//TnsGetDocumentStructureEvent.Log

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\ContentsUserTypes.imp.pas}

function TPrimContentsForm.FindSubByID(anID: Integer): Il3SimpleNode;
var l_CurrentNode: Il3SimpleNode;
var l_Tree: InsContentsTree;

 function IsSubValid(const aNode: Il3SimpleNode): Boolean;
 var l_Sub: IevSub;
 //#UC START# *4A9D4CD30114__var*
 //#UC END# *4A9D4CD30114__var*
 begin
 //#UC START# *4A9D4CD30114__impl*
  Result := Supports(aNode, IevSub, l_Sub) and
            (l_Sub.LayerID = Ord(ev_sbtSub)) and
            (l_Sub.ID = anID);
 //#UC END# *4A9D4CD30114__impl*
 end;//IsSubValid

//#UC START# *4A9D4CAB00DD_4979DFB700F8_var*
//#UC END# *4A9D4CAB00DD_4979DFB700F8_var*
begin
//#UC START# *4A9D4CAB00DD_4979DFB700F8_impl*
 l_CurrentNode := ContentsTree.GetCurrentNode;
 if IsSubValid(l_CurrentNode) then
  Result := l_CurrentNode
 else
 if Supports(ContentsTree.TreeStruct, InsContentsTree, l_Tree) then
  Result := l_Tree.FindBlock(anID)
 else
  Result := nil;
//#UC END# *4A9D4CAB00DD_4979DFB700F8_impl*
end;//TPrimContentsForm.FindSubByID

function TPrimContentsForm.IsMultiSelection: Boolean;
//#UC START# *4C2AE9B7021E_4979DFB700F8_var*
//#UC END# *4C2AE9B7021E_4979DFB700F8_var*
begin
//#UC START# *4C2AE9B7021E_4979DFB700F8_impl*
 Result := ContentsTree.TreeView.Tree.SelectedCount > 1;
//#UC END# *4C2AE9B7021E_4979DFB700F8_impl*
end;//TPrimContentsForm.IsMultiSelection

procedure TPrimContentsForm.FillCRList(const aParams: IvcmTestParamsPrim);
var l_List: IvcmNodes;
//#UC START# *4C2AEAB600F4_4979DFB700F8_var*
//#UC END# *4C2AEAB600F4_4979DFB700F8_var*
begin
//#UC START# *4C2AEAB600F4_4979DFB700F8_impl*
 l_List := aParams.Op.SubNodes;
 if (l_List <> nil) then
 begin
  l_List.PlainLevel := 2;
  l_List.Clear;
  l_List.Add(DefDataAdapter.CRSimpleListTypeRootNode);
(*  l_Root := DefDataAdapter.CRSimpleListTypeRootNode;
  if (l_Root <> nil) then
  begin
   l_Child := l_Root.ChildNode;
   while (l_Child <> nil) do
   begin
    l_List.Add(l_Child);
    if l_Child.IsLast then
     break;
    l_Child := l_Child.NextNode;
   end;//l_Child <> nil
  end;//l_Root <> nil*)
 end;//l_List <> nil
//#UC END# *4C2AEAB600F4_4979DFB700F8_impl*
end;//TPrimContentsForm.FillCRList

procedure TPrimContentsForm.enDocumentBlockTest(const aParams: IvcmTestParamsPrim;
 AllowMultiSelect: Boolean);
//#UC START# *4C2AF3B20159_4979DFB700F8_var*
//#UC END# *4C2AF3B20159_4979DFB700F8_var*
begin
//#UC START# *4C2AF3B20159_4979DFB700F8_impl*
 if IsMultiSelection then
  aParams.Op.Flag[vcm_ofEnabled] := AllowMultiSelect
 else
  aParams.Op.Flag[vcm_ofEnabled] := IsCurrentBlockOrSub;
//#UC END# *4C2AF3B20159_4979DFB700F8_impl*
end;//TPrimContentsForm.enDocumentBlockTest

function TPrimContentsForm.MakePositionList(const aNode: IeeNode = nil): IPositionList;
//#UC START# *4C2AF5150266_4979DFB700F8_var*
var
 l_Node : IeeNode;
 l_Pos: DocumentUnit.TPosition;
//#UC END# *4C2AF5150266_4979DFB700F8_var*
begin
//#UC START# *4C2AF5150266_4979DFB700F8_impl*
 if (aNode = nil) then
  l_Node := ContentsTree.TreeView.CurrentNode
 else
  l_Node := aNode;
 if (l_Node <> nil) then
 begin
  Result := defDataAdapter.NativeAdapter.MakePositionList;
  with l_Pos do
  begin
   rType := PT_SUB;
   rPoint := l_Node.ID;
  end;
  Result.Add(l_Pos);
 end
 else
  Result := nil;
//#UC END# *4C2AF5150266_4979DFB700F8_impl*
end;//TPrimContentsForm.MakePositionList

function TPrimContentsForm.IsCurrentBlockOrSub: Boolean;
//#UC START# *4C2AF7D60169_4979DFB700F8_var*
//#UC END# *4C2AF7D60169_4979DFB700F8_var*
begin
//#UC START# *4C2AF7D60169_4979DFB700F8_impl*
 if (ContentsTree.Total <= 0) then
  Result := false
 else
  Result := true{IsNodeBlockOrSub(ContentsTree.TreeView.CurrentNode)};
 // - типа в оглавлении всегда блоки или сабы, иначе парни на сервере очень
 //   расстраиваются - http://mdp.garant.ru/pages/viewpage.action?pageId=254938079&focusedCommentId=254943602#comment-254943602
 //   мол оболочка их зачем-то "не по делу дёргает.. от работы отвлекает..."
//#UC END# *4C2AF7D60169_4979DFB700F8_impl*
end;//TPrimContentsForm.IsCurrentBlockOrSub

function TPrimContentsForm.IsNodeBlockOrSub(const aNode: IeeNode): Boolean;
var l_Block: IevDocumentPart;
var l_Sub: IevDocumentPart;

 function lp_IsNodeBlockOrSub(const aNode: IeeNode): Boolean;
 var l_ChildNode: IeeNode;
 //#UC START# *4C2AF8A4011C__var*
 //#UC END# *4C2AF8A4011C__var*
 begin
 //#UC START# *4C2AF8A4011C__impl*
  case ContentItemType(aNode) of
   cltNone :
   begin
    if aNode.HasChild then
    begin
     l_ChildNode := aNode.ChildNode;
     try
      Result := ContentItemType(l_ChildNode) = cltBlock;
     finally
      l_ChildNode := nil;
     end;//try..finally
    end//aNode.HasChild
    else
     Result := false;
   end;//cltNone
   cltBlock:
    Result := true;
   else
    Result := false;
  end;//case ContentItemType(aNode
 //#UC END# *4C2AF8A4011C__impl*
 end;//lp_IsNodeBlockOrSub

//#UC START# *4C2AF7F6023A_4979DFB700F8_var*
//#UC END# *4C2AF7F6023A_4979DFB700F8_var*
begin
//#UC START# *4C2AF7F6023A_4979DFB700F8_impl*
 Result := (Supports(aNode, IevDocumentPart, l_Block) or
  (Supports(aNode, IevSub, l_Sub) and
  (l_Sub.LayerID = Ord(ev_sbtSub)))) and lpIsNodeBlockOrSub(aNode);
//#UC END# *4C2AF7F6023A_4979DFB700F8_impl*
end;//TPrimContentsForm.IsNodeBlockOrSub

function TPrimContentsForm.ContentItemType(const aNode: IeeNode = nil): TnsContentItem;
//#UC START# *4C2AFA54035A_4979DFB700F8_var*
var
 l_Node: IeeNode;

 function lp_ItemObjectType: TnsContentItem;
 //var
  //l_DocTagNode: IDocTagNode;
  //l_Type: TExternalObjectType;
 begin
(*  if Supports(l_Node, IDocTagNode, l_DocTagNode) then
  try
   try
    l_Type := l_DocTagNode.GetExternalObjectType;
    case l_Type of
     EOT_RTF, EOT_DOC:
      Result := cltRTF;
     EOT_MP3:
      Result := cltMP3;
     EOT_XLS:
      Result := cltXLS;
     EOT_EVD:
      Result := cltEVD;
     EOT_PDF:
      Result := cltPDF;
     EOT_PIC, EOT_JPG, EOT_PNG, EOT_GIF, EOT_TIF, EOT_PPT, EOT_CDR:
      Result := cltPicture;
     else
      begin
       Result := cltRTF;
       Assert(False);
      end;//else
    end;//case l_DocTagNode.GetExternalObjectType of
   except
    on ECanNotFindData do
     Result := cltRTF;
   end;//try..except
  finally
   l_DocTagNode := nil;
  end//try..finally
  else*)
  begin
   Result := cltRTF;
   Assert(False);
  end;//Supports(l_Node, IDocTagNode, l_DocTagNode)
 end;//lp_ItemType

var
 l_Sub       : IevSub;
 l_TagWrap   : Il3TagRef;
 l_Hyperlink : IevHyperlink;
//#UC END# *4C2AFA54035A_4979DFB700F8_var*
begin
//#UC START# *4C2AFA54035A_4979DFB700F8_impl*
 Result := cltNone;
 if (aNode = nil) and
    (ContentsTree.TreeView.Current >= 0) then
  l_Node := ContentsTree.TreeView.CurrentNode
 else
  l_Node := aNode;
 try
  try
   if Supports(l_Node, IevSub, l_Sub) then
    try
     case l_Sub.LayerID of
      Ord(ev_sbtSub):
       Result := cltBlock;
      Ord(ev_sbtBookmark):
       Result := cltBookmark;
      Ord(ev_sbtMark):
       Result := cltUserComment;
     end;//case l_Sub.LayerID of
    finally
     l_Sub := nil;
    end//try..finally
   else
    if Supports(l_Node, Il3TagRef, l_TagWrap) then
     try
      if l_TagWrap.AsObject.IsKindOf(k2_typBitmapPara) then
       Result := cltPicture
      else
      begin
       if Supports(l_Node, IevHyperlink, l_Hyperlink) then
        try
         if l_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID = CI_PIC then
          Result := cltPictureLink
         else
          Result := lp_ItemObjectType;
        finally
         l_Hyperlink := nil;
        end//try..finally
       else
        Result := lp_ItemObjectType;
      end;//l_TagWrap..IsKindOf(ee_idBitmapPara)
     finally
      l_TagWrap := nil;
     end;//try..finally
  except
   on EIntfCastError do
    Result := cltNone;
  end;//try..except
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *4C2AFA54035A_4979DFB700F8_impl*
end;//TPrimContentsForm.ContentItemType

function TPrimContentsForm.BuildSelectionList: InevFlatSubsList;
//#UC START# *4C3B24C6008A_4979DFB700F8_var*
var
 l_Result: TnevFlatSubsList;

  function lp_Iterator(const aNode: Il3SimpleNode): Boolean;
  var
   l_Sub: IevSub;
   l_Node: INodeBase;
  begin
   Result := False;
   if Supports(aNode, INodeBase, l_Node) and l_Node.HasParentFlag(FM_SELECTION) then
    Exit;
   if Supports(aNode, IevSub, l_Sub) then
    l_Result.Add(l_Sub);
  end;//lpIterator

var
 l_Tree: Il3ExpandedSimpleTree;
//#UC END# *4C3B24C6008A_4979DFB700F8_var*
begin
//#UC START# *4C3B24C6008A_4979DFB700F8_impl*
 l_Result := TnevFlatSubsList.Make;
 try
  if Supports(ContentsTree.TreeStruct, Il3ExpandedSimpleTree, l_Tree) then
   l_Tree.FlagIterateF(l3L2SNA(@lp_Iterator), FM_SELECTION);
  if l_Result.Empty then
   Result := nil
  else
   Result := l_Result;
 finally
  FreeAndNil(l_Result);
 end;
//#UC END# *4C3B24C6008A_4979DFB700F8_impl*
end;//TPrimContentsForm.BuildSelectionList

function TPrimContentsForm.TextFormUserType: Byte;
//#UC START# *4C3B24EE0067_4979DFB700F8_var*
const
 cUserTypeMap: array [0 .. 1] of TvcmUserType = (dftDocument, dftDrug);
//#UC END# *4C3B24EE0067_4979DFB700F8_var*
begin
//#UC START# *4C3B24EE0067_4979DFB700F8_impl*
 Result := cUserTypeMap[UserType];
//#UC END# *4C3B24EE0067_4979DFB700F8_impl*
end;//TPrimContentsForm.TextFormUserType

function TPrimContentsForm.CanPrintBlock: Boolean;
//#UC START# *4C3B251A00EF_4979DFB700F8_var*
//#UC END# *4C3B251A00EF_4979DFB700F8_var*
begin
//#UC START# *4C3B251A00EF_4979DFB700F8_impl*
 Result := Assigned(afw) and Assigned(afw.Application.PrintManager) and
  afw.Application.PrintManager.CanPrint;
//#UC END# *4C3B251A00EF_4979DFB700F8_impl*
end;//TPrimContentsForm.CanPrintBlock

function TPrimContentsForm.CanPreview: Boolean;
//#UC START# *4C3B254A033F_4979DFB700F8_var*
//#UC END# *4C3B254A033F_4979DFB700F8_var*
begin
//#UC START# *4C3B254A033F_4979DFB700F8_impl*
 Result := (Printer.Printers.Count > 0) AND (ContentsTree.Total > 0)
//#UC END# *4C3B254A033F_4979DFB700F8_impl*
end;//TPrimContentsForm.CanPreview

function TPrimContentsForm.MakePreview: IafwDocumentPreview;
//#UC START# *4C87965D008F_4979DFB700F8_var*
var
 l_Painter: Il3HAFPainter;
//#UC END# *4C87965D008F_4979DFB700F8_var*
begin
//#UC START# *4C87965D008F_4979DFB700F8_impl*
 if (BaseContents <> nil) then
  l_Painter := TnsHAFPainter.Make(TevFormatHAFMacroReplacer.Make(TnsDocInfoHAFMacroReplacer.Make(nil, BaseContents.DocInfo), str_ContentsPrintTitle.AsCStr))
 else
  l_Painter := nil;
 Result := TnsDocumentPreview.Make(MakeEVD, evDefaultPreviewCacheKey, l_Painter);
//#UC END# *4C87965D008F_4979DFB700F8_impl*
end;//TPrimContentsForm.MakePreview

function TPrimContentsForm.MakeEVD: InevStorable;
//#UC START# *4C87968B002D_4979DFB700F8_var*
//#UC END# *4C87968B002D_4979DFB700F8_var*
begin
//#UC START# *4C87968B002D_4979DFB700F8_impl*
 Result := TnsContentsTreeStorable.Make(BaseContents.DocInfo.Doc,
                                        ContentsTree.TreeStruct,
                                        nil{ContentsTree.TreeStruct.RootNode.Child}{f_ContentsNode});
//#UC END# *4C87968B002D_4979DFB700F8_impl*
end;//TPrimContentsForm.MakeEVD

function TPrimContentsForm.CanPrint: Boolean;
//#UC START# *4C8796AE0140_4979DFB700F8_var*
//#UC END# *4C8796AE0140_4979DFB700F8_var*
begin
//#UC START# *4C8796AE0140_4979DFB700F8_impl*
 Result := CanPreview and Assigned(afw) and Assigned(afw.Application.PrintManager) and
  afw.Application.PrintManager.CanPrint;
//#UC END# *4C8796AE0140_4979DFB700F8_impl*
end;//TPrimContentsForm.CanPrint

procedure TPrimContentsForm.SendSynchroMessage(anIndex: Integer);
//#UC START# *4D2DA7CA00F6_4979DFB700F8_var*
var
 l_eeNode  : IeeNode;
 l_Sub     : IevSub;
 l_CurType : TDocumentPositionType;
 l_TagWrap : Il3TagRef;
//#UC END# *4D2DA7CA00F6_4979DFB700F8_var*
begin
//#UC START# *4D2DA7CA00F6_4979DFB700F8_impl*
 if (anIndex >= 0) AND
    not (f_InternalPositioning > 0) AND (Aggregate <> nil) then
 begin
  Inc(f_InternalPositioning);
  try
   l_eeNode := ContentsTree.TreeView.GetNode(anIndex);
   if Supports(l_eeNode, IevSub, l_Sub) then
    try
     case l_Sub.LayerID of
       Ord(ev_sbtSub):
        l_CurType := dptSub;
       Ord(ev_sbtBookmark):
        l_CurType := dptBookmark;
       Ord(ev_sbtMark):
        l_CurType := dptMark;
      else
       l_CurType := dptNone;
     end;//case l_Sub.LayerID
     if l_CurType <> dptNone then
      Op_Document_SetPosition.Call(Aggregate, l_eeNode.ID, l_CurType, TextFormUserType);
    finally
     l_Sub := nil;
    end//try..finally
   else
   if Supports(l_eeNode, Il3TagRef, l_TagWrap) then
    try
     Op_Document_GotoPara.Call(Aggregate, l_TagWrap, TextFormUserType);
    finally
     l_TagWrap := nil;
    end;//try..finally
  finally
   Dec(f_InternalPositioning);
  end;//try..finally
 end;//not (f_InternalPositioning > 0)
//#UC END# *4D2DA7CA00F6_4979DFB700F8_impl*
end;//TPrimContentsForm.SendSynchroMessage

procedure TPrimContentsForm.GetContentsListItem(Sender: TObject;
 Index: Integer;
 var ItemString: Il3CString);
//#UC START# *4D2DE4040157_4979DFB700F8_var*
//#UC END# *4D2DE4040157_4979DFB700F8_var*
begin
//#UC START# *4D2DE4040157_4979DFB700F8_impl*
 if (BaseContents = nil) then
  ItemString := l3CStr('')
 else
  ItemString := nsCStr(BaseContents.ContentsListItem[CheckFilteredIndex(Sender, Index)]);
//#UC END# *4D2DE4040157_4979DFB700F8_impl*
end;//TPrimContentsForm.GetContentsListItem

procedure TPrimContentsForm.InitLists;
//#UC START# *4D2DEC970359_4979DFB700F8_var*
var
 l_Tree: InsContentsTree;
//#UC END# *4D2DEC970359_4979DFB700F8_var*
begin
//#UC START# *4D2DEC970359_4979DFB700F8_impl*
 //Tasks.Visible := false;
 with Tasks do
 begin
  GroupImages := dmMainMenuNew.ilSmallIcons;
  CollapseGroupImage := 1;
  ExpandGroupImage := 0;
  ImageList := dmStdRes.SmallImageList;
  GroupColor := cGarant2011GradientStartColor{c_MainMenuColor};
 end;//with Tasks

 lstBookmarks.BorderStyle := bsNone;
 lstComments.BorderStyle := bsNone;
 lstExternalObjects.BorderStyle := bsNone;

 lstBookmarks.UseStyleTable := true;
 lstComments.UseStyleTable := true;
 lstExternalObjects.UseStyleTable := true;
 
 lstBookmarks.MultiStrokeItem := ContentsTree.MultiStrokeItem;
 lstComments.MultiStrokeItem := ContentsTree.MultiStrokeItem;
 lstExternalObjects.MultiStrokeItem := ContentsTree.MultiStrokeItem;

 CheckActionElementMode;

 if (BaseContents = nil) then
 begin
  lstBookmarks.Visible := false;
  lstComments.Visible := false;
  lstExternalObjects.Visible := false;
  ContentsTree.Visible := false;
 end//BaseContents = nil
 else
 begin
  if (BaseContents.Bookmarks = nil) then
   lstBookmarks.Total := 0
  else
   lstBookmarks.Total := BaseContents.Bookmarks.Count;
  if (BaseContents.Comments = nil) then
   lstComments.Total := 0
  else
   lstComments.Total := BaseContents.Comments.Count;
  if (BaseContents.ExternalObjects = nil) then
   lstExternalObjects.Total := 0
  else
   lstExternalObjects.Total := BaseContents.ExternalObjects.Count;

  lstBookmarks.Visible := (lstBookmarks.Total > 0);
  lstComments.Visible := (lstComments.Total > 0);
  lstExternalObjects.Visible := (lstExternalObjects.Total > 0);

  lstBookmarks.Align := alBottom;
  lstComments.Align := alBottom;
  lstExternalObjects.Align := alBottom;

  lstBookmarks.OnGetStrItem := GetContentsListItem;
  lstComments.OnGetStrItem := GetContentsListItem;
  lstExternalObjects.OnGetStrItem := GetContentsListItem;

  lstBookmarks.Images := BaseContents.ImageList.Hack;
  lstComments.Images := BaseContents.ImageList.Hack;
  lstExternalObjects.Images := BaseContents.ImageList.Hack;

  lstBookmarks.OnGetItemImageIndex := GetBookmarksItemImage;
  lstComments.OnGetItemImageIndex := GetCommentsItemImage;
  lstExternalObjects.OnGetItemImageIndex := GetExternalObjectsItemImage;

  lstBookmarks.OnActionElement := ContentsListActionElement;
  lstComments.OnActionElement := ContentsListActionElement;
  lstExternalObjects.OnActionElement := ContentsListActionElement;

  lstBookmarks.OnCurrentChanged := ContentsListCurrentChanged;
  lstComments.OnCurrentChanged := ContentsListCurrentChanged;
  lstExternalObjects.OnCurrentChanged := ContentsListCurrentChanged;

  with ContentsTree do
  begin
   Images := BaseContents.ImageList.Hack;
   if not Supports(TreeStruct, InsContentsTree, l_Tree) OR
      l_Tree.RootResetted then
   begin
    TreeStruct := BaseContents.SimpleTree;
    ExpandFirstLevel;
    Invalidate;
   end;//not Supports(TreeStruct, InsContentsTree, l_Tree)
  end;//with ContentsTree
  if (Dispatcher.History <> nil) AND
     // - http://mdp.garant.ru/pages/viewpage.action?pageId=557849585
     (not Dispatcher.History.InBF) AND
     ((f_ContextFilterDocInfo = nil) OR
     ((f_ContextFilterDocInfo <> nil) AND
      (not f_ContextFilterDocInfo.IsSame(BaseContents.DocInfo)))) then
  begin
   ContextFilter.AssignState(BaseContents.CurrentContextFilter);
   f_ContextFilterDocInfo := BaseContents.DocInfo;
  end;
  ContentsTree.Visible := (ContentsTree.Total > 0);
  Tasks.TasksPanel :=
   TnscTasksPanel.Make(ClassName,
                       [
                        TnscTasksPanelGroupDesc_C(@str_cgContents, ContentsTree),
                        TnscTasksPanelGroupDesc_C(@str_cgBookmarks, lstBookmarks),
                        TnscTasksPanelGroupDesc_C(@str_cgComments, lstComments),
                        TnscTasksPanelGroupDesc_C(@str_cgExternalObjects, lstExternalObjects)
                       ]);
  Tasks.MakeTasksPanel;
  Tasks.Visible := true;
  Tasks.Align := alClient;
 end;//BaseContents = nil
 Op_DocumentSubPanel_UpdateSubPanel.Call(Aggregate);
//#UC END# *4D2DEC970359_4979DFB700F8_impl*
end;//TPrimContentsForm.InitLists

function TPrimContentsForm.GetBookmarksItemImage(Sender: TObject;
 Index: Integer): Integer;
//#UC START# *4D2EDE4E0338_4979DFB700F8_var*
//#UC END# *4D2EDE4E0338_4979DFB700F8_var*
begin
//#UC START# *4D2EDE4E0338_4979DFB700F8_impl*
 Result := diilBookmarkIcon;
//#UC END# *4D2EDE4E0338_4979DFB700F8_impl*
end;//TPrimContentsForm.GetBookmarksItemImage

function TPrimContentsForm.GetCommentsItemImage(Sender: TObject;
 Index: Integer): Integer;
//#UC START# *4D2EDE8C005E_4979DFB700F8_var*
//#UC END# *4D2EDE8C005E_4979DFB700F8_var*
begin
//#UC START# *4D2EDE8C005E_4979DFB700F8_impl*
 Result := diilUserCommentIcon;
//#UC END# *4D2EDE8C005E_4979DFB700F8_impl*
end;//TPrimContentsForm.GetCommentsItemImage

function TPrimContentsForm.GetExternalObjectsItemImage(Sender: TObject;
 Index: Integer): Integer;
//#UC START# *4D2EDEBF001D_4979DFB700F8_var*
var
 l_D : TExternalObjectData;
//#UC END# *4D2EDEBF001D_4979DFB700F8_var*
begin
//#UC START# *4D2EDEBF001D_4979DFB700F8_impl*
 Result := -1;
 Index := CheckFilteredIndex(Sender, Index).rIndex;
 if (BaseContents.ExternalObjects <> nil) AND
    (Index < BaseContents.ExternalObjects.Count)  then
 begin
  BaseContents.ExternalObjects.pm_GetItem(Index, l_D);
  Case l_D.rType of
   EOT_PIC: // Картинка в формате BMP
    Result := diilPictureIcon;
   EOT_JPG:
    Result := diilPictureIcon;
   EOT_PNG:
    Result := diilPictureIcon;
   EOT_GIF:
    Result := diilPictureIcon;
   EOT_RTF, EOT_DOC, EOT_DOCX: // Документы Word, http://mdp.garant.ru/pages/viewpage.action?pageId=346757718
    Result := diilRTF;
   EOT_XLS, EOT_XLSX: // Таблица в формате XLS
    Result := diilExcel;
   EOT_MP3:
    Result := diilMusic;
   EOT_EVD:
    Result := diilDocumentIcon;
   EOT_TIF:
    Result := diilPictureIcon;
   EOT_PDF:
    Result := diilAcrobat;
   EOT_PPT: // Файлы PowerPoint
    Result := diilPictureIcon;
   EOT_CDR: // Файлы CorelDraw
    Result := diilPictureIcon;
   EOT_XML, EOT_XSD: // Документ XML
    Result := diilXMLIcon;
   else
    Result := diilUSRIcon;
  end;//Case l_D.rType
 end;//BaseContents.ExternalObjects <> nil
//#UC END# *4D2EDEBF001D_4979DFB700F8_impl*
end;//TPrimContentsForm.GetExternalObjectsItemImage

procedure TPrimContentsForm.ContentsListActionElement(Sender: TObject;
 Index: Integer);
//#UC START# *4D2EE8650170_4979DFB700F8_var*
//#UC END# *4D2EE8650170_4979DFB700F8_var*
begin
//#UC START# *4D2EE8650170_4979DFB700F8_impl*
 DoContentsListActionElement(Sender, Index, true);
//#UC END# *4D2EE8650170_4979DFB700F8_impl*
end;//TPrimContentsForm.ContentsListActionElement

procedure TPrimContentsForm.ContentsListCurrentChanged(Sender: TObject;
 aNewCurrent: Integer;
 aOldCurrent: Integer);
//#UC START# *4D2EECA201F1_4979DFB700F8_var*
//#UC END# *4D2EECA201F1_4979DFB700F8_var*
begin
//#UC START# *4D2EECA201F1_4979DFB700F8_impl*
 if (aOldCurrent <> -1) and
    (aOldCurrent <> aNewCurrent) then
  DoContentsListActionElement(Sender, aNewCurrent, false);
//#UC END# *4D2EECA201F1_4979DFB700F8_impl*
end;//TPrimContentsForm.ContentsListCurrentChanged

procedure TPrimContentsForm.ContextFilterChange(Sender: TObject);
var l_CF: IContextFilter;
//#UC START# *4D3719CB031B_4979DFB700F8_var*
var
 l_Filtered: Il3SimpleTree;
 l_Node: Il3SimpleNode;
 l_NewNodeIndex: Integer;
 l_LFF : IListForFiltering;
 l_ListType : TnsContentsListType;
//#UC END# *4D3719CB031B_4979DFB700F8_var*
begin
//#UC START# *4D3719CB031B_4979DFB700F8_impl*
 if (BaseContents <> nil) then
 begin
  Inc(f_InternalPositioning);
  try
   // - тут будем фильтровать списки
   l_CF := defDataAdapter.NativeAdapter.MakeContextFilter;
   if TnsFilterableTreeStruct.
       FillContextFilter(l_CF,
                         TnsContextFilterParams.Make(gi_cpContents),
                         ContextFilter.Context) then
   begin
    for l_ListType := Low(TnsContentsListType) to High(TnsContentsListType) do
    begin
     if f_ListForFiltering[l_ListType].Visible then
     begin
      l_LFF := TnsContentsListForFiltering.Make(l_ListType, BaseContents);
      l_CF.Filtrate(l_LFF, f_Filtered[l_ListType]);
      if (f_Filtered[l_ListType] = nil) then
       f_ListForFiltering[l_ListType].Total := 0
      else
       f_ListForFiltering[l_ListType].Total := f_Filtered[l_ListType].Count;
     end;//f_ListForFiltering[l_ListType].Visible
    end;//for l_ListType
   end//TnsFilterableTreeStruct.FillContextFilter
   else
   begin
    Finalize(f_Filtered);
    for l_ListType := Low(TnsContentsListType) to High(TnsContentsListType) do
     if f_ListForFiltering[l_ListType].Visible then
      f_ListForFiltering[l_ListType].Total := BaseContents.ContentsListCount[l_ListType];
   end;//TnsFilterableTreeStruct.FillContextFilter
   // - закончили фильтровать списки
   l_Node := ContentsTree.GetCurrentNode;
   try
    l_Filtered := BaseContents.FiltrateByContext(ContentsTree.TreeStruct, l_Node,
     ContextFilter.MakeState, l_NewNodeIndex);
    if Assigned(l_Filtered) and (l_Filtered.CountView > 0) then
    begin
     // Без Changing/Changed плющит позиционирование. К-135598249
     ContentsTree.Changing;
     try
      ContentsTree.TreeStruct := l_Filtered;
      if (l_Node <> nil) then
       ContentsTree.GotoOnNode(l_Node);
     finally
      ContentsTree.Changed;
     end;//try..finally
     // Если нода пропала встаем на самый первый видимый узел. К-135598249
     if not ContentsTree.GetCurrentNode.IsSame(l_Node) then
      ContentsTree.Current := 0;
    end;//Assigned(l_Filtered)
   finally
    l_Node := nil;
   end;//try..finally
  finally
   Dec(f_InternalPositioning);
  end;//try..finally
  SendSynchroMessage(ContentsTree.TreeView.Current);
 end;//BaseContents <> nil
 Op_DocumentSubPanel_UpdateSubPanel.Call(Aggregate);
//#UC END# *4D3719CB031B_4979DFB700F8_impl*
end;//TPrimContentsForm.ContextFilterChange

procedure TPrimContentsForm.ContextFilterWrongContext(Sender: TObject);
//#UC START# *4D371A00001E_4979DFB700F8_var*
//#UC END# *4D371A00001E_4979DFB700F8_var*
begin
//#UC START# *4D371A00001E_4979DFB700F8_impl*
 nsBeepWrongContext;
//#UC END# *4D371A00001E_4979DFB700F8_impl*
end;//TPrimContentsForm.ContextFilterWrongContext

procedure TPrimContentsForm.ContentsTreeNewCharPressed(aChar: AnsiChar);
//#UC START# *4D371DC703BB_4979DFB700F8_var*
//#UC END# *4D371DC703BB_4979DFB700F8_var*
begin
//#UC START# *4D371DC703BB_4979DFB700F8_impl*
 ContextFilter.PressChar(aChar);
//#UC END# *4D371DC703BB_4979DFB700F8_impl*
end;//TPrimContentsForm.ContentsTreeNewCharPressed

procedure TPrimContentsForm.ContentsTreeCurrentChanged(Sender: TObject;
 NewCurrent: Integer;
 OldCurrent: Integer);
//#UC START# *4D372007016B_4979DFB700F8_var*
//#UC END# *4D372007016B_4979DFB700F8_var*
begin
//#UC START# *4D372007016B_4979DFB700F8_impl*
 if (OldCurrent <> -1) and
    (OldCurrent <> NewCurrent) then
  SendSynchroMessage(NewCurrent);
//#UC END# *4D372007016B_4979DFB700F8_impl*
end;//TPrimContentsForm.ContentsTreeCurrentChanged

function TPrimContentsForm.ContentsTreeGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *4D37206D034E_4979DFB700F8_var*
const
 nsContentObjectItem = [cltRTF, cltMP3, cltXLS, cltEVD, cltPDF];
  {* Элементы структуры являющиеся объектами. }
var
 l_ChildNode : IeeNode;
 l_Node      : IeeNode;
 l_ItemType  : TnsContentItem;
//#UC END# *4D37206D034E_4979DFB700F8_var*
begin
//#UC START# *4D37206D034E_4979DFB700F8_impl*
 Result := -1;
 l_Node := ContentsTree.TreeView.GetNode(Index);
 try
  case ContentItemType(l_Node) of
   cltNone :
    begin
     if l_Node.HasChild then
     begin
      l_ChildNode := l_Node.ChildNode;
      try
       l_ItemType := ContentItemType(l_ChildNode);
       case l_ItemType of
        cltNone:
         Result := diilFolderIcon;
        cltBlock:
         Result := diilSubAndBlockIcon;
        cltBookmark:
         Result := diilFolderIcon;
        cltUserComment:
         Result := diilFolderIcon;
        cltPictureLink, cltPicture :
         Result := diilPictureFolderIcon;
        else
         if l_ItemType in nsContentObjectItem then
          Result := diilObjectFolderIcon
         else
          Assert(False);
       end//case ContentItemType(l_ChildNode) of
      finally
       l_ChildNode := nil;
      end;
     end
     else
      if l_Node.GetLevelForParent(ContentsTree.TreeView.Tree.Root) = 1 then
       Result := diilFolderIcon
      else
       Result := diilDocumentIcon;
    end;
   cltBlock:
    if l_Node.ID = 0 then
     Result := diilDocumentIcon
    else
     Result := diilSubAndBlockIcon;
   cltBookmark:
    Result := diilBookmarkIcon;
   cltUserComment:
    Result := diilUserCommentIcon;
   cltPicture:
    Result := diilPictureIcon;
   cltPictureLink:
    Result := diilPictureLinkIcon;
   cltMP3:
    Result := diilMusic;
   cltRTF:
    Result := diilRTF;
   cltXLS:
    Result := diilExcel;
   cltEVD:
    Result := diilDocumentIcon;
   cltPDF:
    Result := diilAcrobat;
   else
    Assert(False);
  end;//case ContentItemType(l_Node) of
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *4D37206D034E_4979DFB700F8_impl*
end;//TPrimContentsForm.ContentsTreeGetItemImage

procedure TPrimContentsForm.ContentsTreeTreeChanged(aSender: TObject;
 const anOldTree: Il3SimpleTree;
 const aNewTree: Il3SimpleTree);
//#UC START# *4D3720A5030E_4979DFB700F8_var*
//#UC END# *4D3720A5030E_4979DFB700F8_var*
begin
//#UC START# *4D3720A5030E_4979DFB700F8_impl*
 if (anOldTree <> nil) then
  anOldTree.Unsubscribe(InsTreeDataListener(Self));
 if (aNewTree <> nil) then
  aNewTree.Subscribe(InsTreeDataListener(Self));
 {$IfDef vcmUseProfilers}
 // Завершим работу профайлера по открытию документа:
 if not f_FirstCurrentChanged then
 begin
  ProfilersManager.Document.ContentsTreeOpened;
  f_FirstCurrentChanged := True;
 end;//not f_FirstCurrentChanged
 {$EndIf vcmUseProfilers}
 if (aNewTree <> nil) then
  ExpandFirstLevel;
//#UC END# *4D3720A5030E_4979DFB700F8_impl*
end;//TPrimContentsForm.ContentsTreeTreeChanged

procedure TPrimContentsForm.ContentsTreeActionElement(Sender: TObject;
 Index: Integer);
//#UC START# *4D3720DE0381_4979DFB700F8_var*
//#UC END# *4D3720DE0381_4979DFB700F8_var*
begin
//#UC START# *4D3720DE0381_4979DFB700F8_impl*
 SendSynchroMessage(ContentsTree.TreeView.Current);
 FloatingHide;
//#UC END# *4D3720DE0381_4979DFB700F8_impl*
end;//TPrimContentsForm.ContentsTreeActionElement

procedure TPrimContentsForm.ContentsTreeMakeTreeSource(out theTree: Il3SimpleTree);
//#UC START# *4D37210000EE_4979DFB700F8_var*
//#UC END# *4D37210000EE_4979DFB700F8_var*
begin
//#UC START# *4D37210000EE_4979DFB700F8_impl*
 if (SimpleTree <> nil) then
  theTree := SimpleTree.SimpleTree
 else
  theTree := nil;

 if not (csDestroying in ComponentState) then
  if (BaseContents <> nil) then
   TnsGetDocumentStructureEvent.Log(BaseContents.DocInfo.Doc);
//#UC END# *4D37210000EE_4979DFB700F8_impl*
end;//TPrimContentsForm.ContentsTreeMakeTreeSource

procedure TPrimContentsForm.ContentsTreeRootChanged(aSender: TObject;
 const anOldRoot: IeeNode;
 const aNewRoot: IeeNode);
//#UC START# *4D372122006B_4979DFB700F8_var*

(* function lp_FindBlockOrSub(const anIntf: IeeNode): Boolean;
 begin//lp_FindBlockOrSub
  Result := IsNodeBlockOrSub(anIntf);
 end;//lp_FindBlockOrSub*)

var
 l_Tree: InsContentsTree;
//#UC END# *4D372122006B_4979DFB700F8_var*
begin
//#UC START# *4D372122006B_4979DFB700F8_impl*
 // Скорей всего TreeStruct равен nil и последующее к нему обращение вызовет его создание...
 if aNewRoot = nil then
  Exit;
(* Supports(ContentsTree.TreeView.Tree.IterateF(eeL2NA(@lp_FindBlockOrSub),
                                              imCheckResult or imOneLevel),
          Il3SimpleNode,
          f_ContentsNode);*)
 if Supports(ContentsTree.TreeStruct, InsContentsTree, l_Tree) then
 begin
  if l_Tree.RootResetted then
   ExpandFirstLevel;
  l_Tree.DataReceived;
 end;//Supports(ContentsTree.TreeStruct, InsContentsTree, l_Tree)
//#UC END# *4D372122006B_4979DFB700F8_impl*
end;//TPrimContentsForm.ContentsTreeRootChanged

function TPrimContentsForm.CheckFilteredIndex(aSender: TObject;
 anIndex: Integer): TnsContentsListIndex;
//#UC START# *4D40508101A1_4979DFB700F8_var*
var
 l_Index : TnsContentsListType;
//#UC END# *4D40508101A1_4979DFB700F8_var*
begin
//#UC START# *4D40508101A1_4979DFB700F8_impl*
 Result.rIndex := anIndex;
 Byte(Result.rListType) := 255; 
 for l_Index := Low(TnsContentsListType) to High(TnsContentsListType) do
  if (f_ListForFiltering[l_Index] = aSender) then
  begin
   Result.rListType := l_Index;
   break;
  end;//f_ListForFiltering[l_Index] = aSender
 Assert(Byte(Result.rListType) <= Ord(High(TnsContentsListType)));
 if (f_Filtered[Result.rListType] <> nil) then
 begin
  Assert(Result.rIndex < f_Filtered[Result.rListType].Count);
  Result.rIndex  := f_Filtered[Result.rListType].Items[Result.rIndex];
 end;//f_Filtered[Result.rListType] <> nil
//#UC END# *4D40508101A1_4979DFB700F8_impl*
end;//TPrimContentsForm.CheckFilteredIndex

procedure TPrimContentsForm.GetIsContextWrong(aSender: TObject;
 var IsWrong: Boolean);
//#UC START# *4D42A67803C6_4979DFB700F8_var*
var
 l_Index : TnsContentsListType;
 l_SomeListVisible : Boolean;
//#UC END# *4D42A67803C6_4979DFB700F8_var*
begin
//#UC START# *4D42A67803C6_4979DFB700F8_impl*
 if IsWrong then
 begin
  for l_Index := Low(l_Index) to High(l_Index) do
   if f_ListForFiltering[l_Index].Visible AND
      (f_ListForFiltering[l_Index].Total > 0) then
   begin
    IsWrong := false;
    Exit;
   end;//f_ListForFiltering[l_Index].Visible
 end//IsWrong
 else
 begin
  if ContentsTree.Visible AND (ContentsTree.Total > 0) then
  // http://mdp.garant.ru/pages/viewpage.action?pageId=265396831
  // - типа в оглавлении всё хорошо - значит не надо и дёргаться
   Exit;
  l_SomeListVisible := false;
  for l_Index := Low(l_Index) to High(l_Index) do
   if f_ListForFiltering[l_Index].Visible then
   begin
    l_SomeListVisible := true;
    break;
   end;//f_ListForFiltering[l_Index].Visible
  if l_SomeListVisible then
  begin
   for l_Index := Low(l_Index) to High(l_Index) do
    if f_ListForFiltering[l_Index].Visible AND
       (f_ListForFiltering[l_Index].Total > 0) then
     Exit;
   IsWrong := true;
  end;//l_SomeListVisible
 end;//IsWrong
//#UC END# *4D42A67803C6_4979DFB700F8_impl*
end;//TPrimContentsForm.GetIsContextWrong

function TPrimContentsForm.IsFloatingState: Boolean;
 {* Определяет - находится ли вкладка оглавления в плавающем состоянии }
//#UC START# *4E79E72D00A5_4979DFB700F8_var*
var
 l_P : TafwCustomForm;
//#UC END# *4E79E72D00A5_4979DFB700F8_var*
begin
//#UC START# *4E79E72D00A5_4979DFB700F8_impl*
 f_CloseDisabled := false;
 Result := false;
 l_P := afw.GetAnotherParentForm(Self);
 if (l_P <> nil) AND (TForm(l_P).FormStyle = fsStayOnTop) then
 begin
  Result := true;
  f_CloseDisabled := true;
 end;//l_P <> nil
//#UC END# *4E79E72D00A5_4979DFB700F8_impl*
end;//TPrimContentsForm.IsFloatingState

procedure TPrimContentsForm.DoContentsListActionElement(Sender: TObject;
 Index: Integer;
 aNeedClose: Boolean);
//#UC START# *4E7B3A8F00D6_4979DFB700F8_var*
//#UC END# *4E7B3A8F00D6_4979DFB700F8_var*
begin
//#UC START# *4E7B3A8F00D6_4979DFB700F8_impl*
 Op_Document_SetPosition.Call(Aggregate,
                              BaseContents.
                               ContentsListParaID[CheckFilteredIndex(Sender, Index)],
                              dptPara,
                              TextFormUserType);
 if aNeedClose then
  FloatingHide;                             
//#UC END# *4E7B3A8F00D6_4979DFB700F8_impl*
end;//TPrimContentsForm.DoContentsListActionElement

function TPrimContentsForm.FloatingHide: Boolean;
//#UC START# *4E7B3D1A016A_4979DFB700F8_var*
var
 l_P : TafwCustomForm;
//#UC END# *4E7B3D1A016A_4979DFB700F8_var*
begin
//#UC START# *4E7B3D1A016A_4979DFB700F8_impl*
 Result := false;
 if IsFloatingState then
 begin
  l_P := afw.GetAnotherParentForm(Self);
  Assert(l_P <> nil);
  if (l_P <> nil) then
  begin
   l_P.Hide;
   StoreFloatingVisible(l_P.Visible);
   Result := true;
  end;//l_P <> nil
 end;//IsFloatingState
//#UC END# *4E7B3D1A016A_4979DFB700F8_impl*
end;//TPrimContentsForm.FloatingHide

procedure TPrimContentsForm.CheckFocus;
 {* Проверяет в форме ли фокус и если это не так, то ставит его на первый возможный контрол }
//#UC START# *4E7B450302F4_4979DFB700F8_var*
//#UC END# *4E7B450302F4_4979DFB700F8_var*
begin
//#UC START# *4E7B450302F4_4979DFB700F8_impl*
 if Self.FloatingVisible then
  if not Focused then
   if CanFocus then
   begin
    SetFocus;
    if ContentsTree.Visible AND ContentsTree.CanFocus then
     ContentsTree.SetFocus
    else
    if lstBookmarks.Visible AND lstBookmarks.CanFocus then
     lstBookmarks.SetFocus
    else
    if lstExternalObjects.Visible AND lstExternalObjects.CanFocus then
     lstExternalObjects.SetFocus
    else
    if lstComments.Visible AND lstComments.CanFocus then
     lstComments.SetFocus;
   end;//CanFocus
//#UC END# *4E7B450302F4_4979DFB700F8_impl*
end;//TPrimContentsForm.CheckFocus

procedure TPrimContentsForm.CheckActionElementMode;
//#UC START# *4E7B486801E4_4979DFB700F8_var*
//#UC END# *4E7B486801E4_4979DFB700F8_var*
begin
//#UC START# *4E7B486801E4_4979DFB700F8_impl*
 if IsFloatingState then
 begin
  ContentsTree.ActionElementMode := l3_amDoubleClick;
  lstBookmarks.ActionElementMode := l3_amDoubleClick;
  lstComments.ActionElementMode := l3_amDoubleClick;
  lstExternalObjects.ActionElementMode := l3_amDoubleClick;
 end//IsFloatingState
 else
 begin
  ContentsTree.ActionElementMode := l3_amSecondSingleClick;
  lstBookmarks.ActionElementMode := l3_amSecondSingleClick;
  lstComments.ActionElementMode := l3_amSecondSingleClick;
  lstExternalObjects.ActionElementMode := l3_amSecondSingleClick;
 end;//IsFloatingState
//#UC END# *4E7B486801E4_4979DFB700F8_impl*
end;//TPrimContentsForm.CheckActionElementMode

procedure TPrimContentsForm.StoreFloatingVisible(aValue: Boolean);
//#UC START# *4E7B54800149_4979DFB700F8_var*
//#UC END# *4E7B54800149_4979DFB700F8_var*
begin
//#UC START# *4E7B54800149_4979DFB700F8_impl*
 Self.FloatingVisible := aValue;
//#UC END# *4E7B54800149_4979DFB700F8_impl*
end;//TPrimContentsForm.StoreFloatingVisible

procedure TPrimContentsForm.ExpandFirstLevel;
//#UC START# *4AEF076A02D6_4979DFB700F8_var*
//#UC END# *4AEF076A02D6_4979DFB700F8_var*
begin
//#UC START# *4AEF076A02D6_4979DFB700F8_impl*
 with ContentsTree.TreeView.Tree do
  if Assigned(Root) and
     Assigned(Root.ChildNode) then
   ChangeExpand(Root, ee_sbSelect);
(*  if Assigned(Root) and
     Assigned(Root.ChildNode) and
     IsNodeBlockOrSub(Root.ChildNode) then
   ChangeExpand(Root.ChildNode, ee_sbSelect);*)
//#UC END# *4AEF076A02D6_4979DFB700F8_impl*
end;//TPrimContentsForm.ExpandFirstLevel

procedure TPrimContentsForm.Updated;
 {* данные дерева были обновлены. Реакция на обновление данных
            приложения }
//#UC START# *48FF6D200201_4979DFB700F8_var*
//#UC END# *48FF6D200201_4979DFB700F8_var*
begin
//#UC START# *48FF6D200201_4979DFB700F8_impl*
 ExpandFirstLevel;
//#UC END# *48FF6D200201_4979DFB700F8_impl*
end;//TPrimContentsForm.Updated

procedure TPrimContentsForm.Contents_SetCurrent_Execute(aSub: Integer);
//#UC START# *4A9D4A180253_4979DFB700F8exec_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *4A9D4A180253_4979DFB700F8exec_var*
begin
//#UC START# *4A9D4A180253_4979DFB700F8exec_impl*
 if not (f_InternalPositioning > 0) then
 begin
  Inc(f_InternalPositioning);
  try
   with ContentsTree.TreeView do
   begin
    if (CurrentNode <> nil) and
       (CurrentNode.ID <> aSub) then
    begin
     l_Node := FindSubByID(aSub);
     if (l_Node <> nil) then
      ContentsTree.GotoOnNode(l_Node);
    end;//CurrentNode <> nil
   end;//with ContentsTree.TreeView
  finally
   Dec(f_InternalPositioning);
  end;//try..finally
 end;//not (f_InternalPositioning > 0)
//#UC END# *4A9D4A180253_4979DFB700F8exec_impl*
end;//TPrimContentsForm.Contents_SetCurrent_Execute

procedure TPrimContentsForm.Contents_SetCurrent(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IContents_SetCurrent_Params) do
  Self.Contents_SetCurrent_Execute(Sub);
end;//TPrimContentsForm.Contents_SetCurrent

procedure TPrimContentsForm.Contents_MoveCurrent_Execute(aSub: Integer;
 aDown: Boolean);
//#UC START# *4A9D4A560164_4979DFB700F8exec_var*

 procedure PositionOnNode(const aNode: Il3SimpleNode);
 var
  l_CurrentChangedProc: TeeCurrentChanged;
 begin
  l_CurrentChangedProc := ContentsTree.OnCurrentChanged;
  ContentsTree.OnCurrentChanged := nil;
  try
   ContentsTree.GotoOnNode(aNode);
  finally
   ContentsTree.OnCurrentChanged := l_CurrentChangedProc;
  end;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=298682625
   if l3IsTimeElapsed(f_ContentsTreeLastUpdateTime, 500) then
   begin
    ContentsTree.Update; // http://mdp.garant.ru/pages/viewpage.action?pageId=297702510
    f_ContentsTreeLastUpdateTime := GetTickCount;
   end;
 end;

var
 l_RelativeIndex: Integer;
 l_CurrentNode: IeeNode;
 l_Node: Il3SimpleNode;
 l_Sub: IevSub;
 l_Direction: TMoveDirectionType;
//#UC END# *4A9D4A560164_4979DFB700F8exec_var*
begin
//#UC START# *4A9D4A560164_4979DFB700F8exec_impl*
 if not (f_InternalPositioning > 0) then
 begin
  l_CurrentNode := ContentsTree.TreeView.CurrentNode;
  if ((l_CurrentNode = nil) or (l_CurrentNode.ID <> aSub)) then
  begin
   l_Node := FindSubByID(aSub);
   if (l_Node <> nil) then
   begin
    if Supports(l_CurrentNode, IevSub, l_Sub) and
       (l_Sub.LayerID = Ord(ev_sbtSub)) then
    begin
     if aDown then
      l_Direction := mdtDown
     else
      l_Direction := mdtUp;
     l_RelativeIndex := ContentsTree.TreeStruct.GetIndex(l_Node, l_CurrentNode as Il3SimpleNode);
     if l_RelativeIndex = -1 then // Поскольку значение -1 является зарезервированным и возвращается для невидимых нод,
                                  // то пробуем сделать ноду видимой и еще раз рассчитывавем индекс
     begin
      ContentsTree.TreeStruct.MakeNodeVisible(l_Node);
      l_RelativeIndex := ContentsTree.TreeStruct.GetIndex(l_Node, l_CurrentNode as Il3SimpleNode);
     end;
     if (l_Direction <> mdtNone) and
        (((l_Direction = mdtDown) and (l_RelativeIndex > 0)) or
         ((l_Direction = mdtUp) and (l_RelativeIndex < 0))) then
      PositionOnNode(l_Node);
    end//Supports(l_CurrentNode, IevSub, l_Sub)
    else
     PositionOnNode(l_Node);
   end; //l_eeNode <> nil
  end;//l_CurrentNode <> nil..
 end;//not (f_InternalPositioning > 0)
//#UC END# *4A9D4A560164_4979DFB700F8exec_impl*
end;//TPrimContentsForm.Contents_MoveCurrent_Execute

procedure TPrimContentsForm.Contents_MoveCurrent(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IContents_MoveCurrent_Params) do
  Self.Contents_MoveCurrent_Execute(Sub, Down);
end;//TPrimContentsForm.Contents_MoveCurrent

procedure TPrimContentsForm.DocumentBlock_GetCorrespondentList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C2AEDB3003B_4979DFB700F8test_var*
//#UC END# *4C2AEDB3003B_4979DFB700F8test_var*
begin
//#UC START# *4C2AEDB3003B_4979DFB700F8test_impl*
 enDocumentBlockTest(aParams, False);
 if aParams.Op.Flag[vcm_ofEnabled] then
 begin
  if (Contents <> nil) then
   aParams.Op.Flag[vcm_ofEnabled] := Contents.HasCorrespondents;
  FillCRList(aParams);
 end;//aParams.Op.Flag[vcm_ofEnabled]
//#UC END# *4C2AEDB3003B_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlock_GetCorrespondentList_Test

procedure TPrimContentsForm.DocumentBlock_GetCorrespondentList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C2AEDB3003B_4979DFB700F8exec_var*
var
 l_PositionList: IPositionList;
//#UC END# *4C2AEDB3003B_4979DFB700F8exec_var*
begin
//#UC START# *4C2AEDB3003B_4979DFB700F8exec_impl*
 if (Aggregate <> nil) and (ContentsTree.TreeView.Current <> -1) then
 begin
  if (ContentsTree.TreeView.CurrentNode.ID = c_DocumentSubID) then
   Aggregate.Operation(TdmStdRes.opcode_Document_GetCorrespondentListExFrmAct)
  else
  begin
   l_PositionList := MakePositionList;
   if (l_PositionList <> nil) then
    op_Document_ShowCorrespondentListToPart.Call(Aggregate, l_PositionList);
  end;//ContentsTree.TreeView.CurrentNode.ID = c_DocumentSubID
 end;//Aggregate <> nil..
//#UC END# *4C2AEDB3003B_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlock_GetCorrespondentList_Execute

procedure TPrimContentsForm.DocumentBlock_GetRespondentList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C2AEDC503CC_4979DFB700F8test_var*
//#UC END# *4C2AEDC503CC_4979DFB700F8test_var*
begin
//#UC START# *4C2AEDC503CC_4979DFB700F8test_impl*
 enDocumentBlockTest(aParams, False);
 if aParams.Op.Flag[vcm_ofEnabled] then
  begin
   if (Contents <> nil) then
    aParams.Op.Flag[vcm_ofEnabled] := Contents.HasCorrespondents
   else
    aParams.Op.Flag[vcm_ofEnabled] := False;
  end;//aParams.Op.Flag[vcm_ofEnabled]
//#UC END# *4C2AEDC503CC_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlock_GetRespondentList_Test

procedure TPrimContentsForm.DocumentBlock_GetRespondentList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C2AEDC503CC_4979DFB700F8exec_var*
var
 l_PositionList: IPositionList;
//#UC END# *4C2AEDC503CC_4979DFB700F8exec_var*
begin
//#UC START# *4C2AEDC503CC_4979DFB700F8exec_impl*
 if (Aggregate <> nil) and (ContentsTree.TreeView.Current <> -1) then
 begin
  if (ContentsTree.TreeView.CurrentNode.ID = c_DocumentSubID) then
   Aggregate.Operation(TdmStdRes.opcode_Document_GetRespondentListExFrmAct)
  else
  begin
   l_PositionList := MakePositionList;
   if (l_PositionList <> nil) then
    op_Document_ShowRespondentListToPart.Call(Aggregate, l_PositionList);
  end;//ContentsTree.TreeView.CurrentNode.ID = c_DocumentSubID 
 end;//Aggregate <> nil..
//#UC END# *4C2AEDC503CC_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlock_GetRespondentList_Execute

procedure TPrimContentsForm.DocumentBlock_GetTypedCorrespondentList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C2AEDDA0335_4979DFB700F8test_var*
//#UC END# *4C2AEDDA0335_4979DFB700F8test_var*
begin
//#UC START# *4C2AEDDA0335_4979DFB700F8test_impl*
 enDocumentBlockTest(aParams, False);
 if aParams.Op.Flag[vcm_ofEnabled] then
 begin
  if (Contents <> nil) then
   aParams.Op.Flag[vcm_ofEnabled] := Contents.HasCorrespondents;
  FillCRList(aParams);
 end;//aParams.Op.Flag[vcm_ofEnabled]
//#UC END# *4C2AEDDA0335_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlock_GetTypedCorrespondentList_Test

procedure TPrimContentsForm.DocumentBlock_GetTypedCorrespondentList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C2AEDDA0335_4979DFB700F8exec_var*
var
 l_PositionList : IPositionList;
//#UC END# *4C2AEDDA0335_4979DFB700F8exec_var*
begin
//#UC START# *4C2AEDDA0335_4979DFB700F8exec_impl*
 if (Aggregate <> nil) and (ContentsTree.TreeView.Current <> -1) then
 begin
  if ContentsTree.TreeView.CurrentNode.ID = c_DocumentSubID then
   Aggregate.Operation(TdmStdRes.opcode_Document_GetCorrespondentListExFrmAct, aParams As IvcmExecuteParams)
  else
  begin
   l_PositionList := MakePositionList;
   if (l_PositionList <> nil) then
    op_Document_ShowCorrespondentListToPart.Call(Aggregate, l_PositionList, aParams.CurrentNode);
  end;
 end;//l_PositionList <> nil
//#UC END# *4C2AEDDA0335_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlock_GetTypedCorrespondentList_Execute

procedure TPrimContentsForm.DocumentBlock_GetTypedCorrespondentList_GetState(var State: TvcmOperationStateIndex);
//#UC START# *4C2AEDDA0335_4979DFB700F8getstate_var*
//#UC END# *4C2AEDDA0335_4979DFB700F8getstate_var*
begin
//#UC START# *4C2AEDDA0335_4979DFB700F8getstate_impl*
 // - ничего не делаем
//#UC END# *4C2AEDDA0335_4979DFB700F8getstate_impl*
end;//TPrimContentsForm.DocumentBlock_GetTypedCorrespondentList_GetState

procedure TPrimContentsForm.DocumentBlock_GetTypedRespondentList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C2AEDE7028C_4979DFB700F8test_var*
//#UC END# *4C2AEDE7028C_4979DFB700F8test_var*
begin
//#UC START# *4C2AEDE7028C_4979DFB700F8test_impl*
 enDocumentBlockTest(aParams, False);
 if aParams.Op.Flag[vcm_ofEnabled] then
 begin
  if (Contents <> nil) then
   aParams.Op.Flag[vcm_ofEnabled] := Contents.HasRespondents;
  FillCRList(aParams);
 end;//aParams.Op.Flag[vcm_ofEnabled]
//#UC END# *4C2AEDE7028C_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlock_GetTypedRespondentList_Test

procedure TPrimContentsForm.DocumentBlock_GetTypedRespondentList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C2AEDE7028C_4979DFB700F8exec_var*
var
 l_PositionList : IPositionList;
//#UC END# *4C2AEDE7028C_4979DFB700F8exec_var*
begin
//#UC START# *4C2AEDE7028C_4979DFB700F8exec_impl*
 if (Aggregate <> nil) and (ContentsTree.TreeView.Current <> -1) then
 begin
  if ContentsTree.TreeView.CurrentNode.ID = c_DocumentSubID then
   Aggregate.Operation(TdmStdRes.opcode_Document_GetRespondentListExFrmAct, aParams As IvcmExecuteParams)
  else
  begin
   l_PositionList := MakePositionList;
   if (l_PositionList <> nil) then
    op_Document_ShowRespondentListToPart.Call(Aggregate, l_PositionList, aParams.CurrentNode);
  end;
 end;//Aggregate <> nil
//#UC END# *4C2AEDE7028C_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlock_GetTypedRespondentList_Execute

procedure TPrimContentsForm.DocumentBlockBookmarks_AddBookmark_Test(const aParams: IvcmTestParamsPrim);
 {* Установить закладку на фрагмент }
//#UC START# *4C3B1AEA0127_4979DFB700F8test_var*
var
 l_Sub: IevSub;
//#UC END# *4C3B1AEA0127_4979DFB700F8test_var*
begin
//#UC START# *4C3B1AEA0127_4979DFB700F8test_impl*
 enDocumentBlockTest(aParams, False);
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := Supports(ContentsTree.TreeView.CurrentNode,
   IevSub, l_Sub) and (l_Sub.LayerID = Ord(ev_sbtSub));
//#UC END# *4C3B1AEA0127_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlockBookmarks_AddBookmark_Test

procedure TPrimContentsForm.DocumentBlockBookmarks_AddBookmark_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Установить закладку на фрагмент }
//#UC START# *4C3B1AEA0127_4979DFB700F8exec_var*
var
 l_eeNode: IeeNode;
 l_Sub: IevSub;
 l_TagWrap: Il3TagRef;
//#UC END# *4C3B1AEA0127_4979DFB700F8exec_var*
begin
//#UC START# *4C3B1AEA0127_4979DFB700F8exec_impl*
 with ContentsTree.TreeView do
  l_eeNode := GetNode(Current);
 try
  if Supports(l_eeNode, IevSub, l_Sub) then
   try
    op_Document_AddBookmarkFromContents.Call(Aggregate, l_Sub.LeafPara.AsRef);
   finally
    l_Sub := nil;
   end//try..finally
  else
   if Supports(l_eeNode, Il3TagRef, l_TagWrap) then
    try
     op_Document_AddBookmarkFromContents.Call(Aggregate, l_TagWrap);
    finally
     l_TagWrap := nil;
    end;//try..finally
 finally
  l_eeNode := nil;
 end;//try..finally
//#UC END# *4C3B1AEA0127_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlockBookmarks_AddBookmark_Execute

procedure TPrimContentsForm.DocumentBlock_ToMSWord_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3B1AFB0270_4979DFB700F8test_var*
//#UC END# *4C3B1AFB0270_4979DFB700F8test_var*
begin
//#UC START# *4C3B1AFB0270_4979DFB700F8test_impl*
 enDocumentBlockTest(aParams, True);
 //nsDisableOperationInTrialMode(aParams);
 TnsToMSWordOp.Test(aParams);
//#UC END# *4C3B1AFB0270_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlock_ToMSWord_Test

procedure TPrimContentsForm.DocumentBlock_ToMSWord_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3B1AFB0270_4979DFB700F8exec_var*
var
 l_Node  : IeeNode;
 l_Sub   : IevSub;
 l_List: InevFlatSubsList;
//#UC END# *4C3B1AFB0270_4979DFB700F8exec_var*
begin
//#UC START# *4C3B1AFB0270_4979DFB700F8exec_impl*
 if IsMultiSelection then
 begin
  l_List := BuildSelectionList;
  if Assigned(l_List) then
   op_Document_ExportBlock.Call(Aggregate, l_List, TextFormUserType, aParams.ItemIndex > 1)
  else
   Say(war_DocumentBlockNothingToExport);
 end//IsMultiSelection
 else
 begin
  l_Node := ContentsTree.TreeView.CurrentNode;
  if Supports(l_Node, IevSub, l_Sub) then
   op_Document_ExportBlock.Call(Aggregate, l_Sub, TextFormUserType, aParams.ItemIndex > 1);
 end;//IsMultiSelection
//#UC END# *4C3B1AFB0270_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlock_ToMSWord_Execute

procedure TPrimContentsForm.DocumentBlock_PrintDialog_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3B1B0F0237_4979DFB700F8test_var*
//#UC END# *4C3B1B0F0237_4979DFB700F8test_var*
begin
//#UC START# *4C3B1B0F0237_4979DFB700F8test_impl*
 enDocumentBlockTest(aParams, True);
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := CanPrintBlock;
//#UC END# *4C3B1B0F0237_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlock_PrintDialog_Test

procedure TPrimContentsForm.DocumentBlock_PrintDialog_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3B1B0F0237_4979DFB700F8exec_var*
var
 l_Node  : IeeNode;
 l_Sub     : IevSub;
 l_List: InevFlatSubsList;
//#UC END# *4C3B1B0F0237_4979DFB700F8exec_var*
begin
//#UC START# *4C3B1B0F0237_4979DFB700F8exec_impl*
 if IsMultiSelection then
 begin
  l_List := BuildSelectionList;
  if Assigned(l_List) then
   op_Document_PrintDialogBlock.Call(Aggregate, l_List, TextFormUserType)
  else
   Say(war_DocumentBlockNothingToPrint);
 end
 else
 begin
  l_Node := ContentsTree.TreeView.CurrentNode;
  if Supports(l_Node, IevSub, l_Sub) then
   op_Document_PrintDialogBlock.Call(Aggregate, l_Sub, TextFormUserType);
 end;
//#UC END# *4C3B1B0F0237_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlock_PrintDialog_Execute

procedure TPrimContentsForm.DocumentBlock_Copy_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3B1B1D003C_4979DFB700F8test_var*
//#UC END# *4C3B1B1D003C_4979DFB700F8test_var*
begin
//#UC START# *4C3B1B1D003C_4979DFB700F8test_impl*
 enDocumentBlockTest(aParams, True);
 //nsDisableOperationInTrialMode(aParams);
//#UC END# *4C3B1B1D003C_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlock_Copy_Test

procedure TPrimContentsForm.DocumentBlock_Copy_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3B1B1D003C_4979DFB700F8exec_var*
var
 l_Node  : IeeNode;
 l_Sub     : IevSub;
 l_List: InevFlatSubsList;
//#UC END# *4C3B1B1D003C_4979DFB700F8exec_var*
begin
//#UC START# *4C3B1B1D003C_4979DFB700F8exec_impl*
 if IsMultiSelection then
 begin
  l_List := BuildSelectionList;
  if Assigned(l_List) then
   Op_Document_CopyBlock.Call(Aggregate, l_List, TextFormUserType)
  else
   Say(war_DocumentBlockNothingToCopy);
 end
 else
 begin
  l_Node := ContentsTree.TreeView.CurrentNode;
  if Supports(l_Node, IevSub, l_Sub) then
   Op_Document_CopyBlock.Call(Aggregate, l_Sub, TextFormUserType);
 end;
//#UC END# *4C3B1B1D003C_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlock_Copy_Execute

procedure TPrimContentsForm.DocumentBlock_Print_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C3B241401AA_4979DFB700F8test_var*
//#UC END# *4C3B241401AA_4979DFB700F8test_var*
begin
//#UC START# *4C3B241401AA_4979DFB700F8test_impl*
 enDocumentBlockTest(aParams, True);
 if aParams.Op.Flag[vcm_ofEnabled] then
  aParams.Op.Flag[vcm_ofEnabled] := CanPrintBlock;
//#UC END# *4C3B241401AA_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlock_Print_Test

procedure TPrimContentsForm.DocumentBlock_Print_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C3B241401AA_4979DFB700F8exec_var*
var
 l_Node  : IeeNode;
 l_Sub     : IevSub;
 l_List: InevFlatSubsList;
//#UC END# *4C3B241401AA_4979DFB700F8exec_var*
begin
//#UC START# *4C3B241401AA_4979DFB700F8exec_impl*
 if IsMultiSelection then
 begin
  l_List := BuildSelectionList;
  if Assigned(l_List) then
   op_Document_PrintBlock.Call(Aggregate, l_List, TextFormUserType)
  else
   Say(war_DocumentBlockNothingToPrint);
 end
 else
 begin
  l_Node := ContentsTree.TreeView.CurrentNode;
  if Supports(l_Node, IevSub, l_Sub) then
   op_Document_PrintBlock.Call(Aggregate, l_Sub, TextFormUserType);
 end;
//#UC END# *4C3B241401AA_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlock_Print_Execute

procedure TPrimContentsForm.DocumentBlock_PrintPreview_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C879306001C_4979DFB700F8test_var*
//#UC END# *4C879306001C_4979DFB700F8test_var*
begin
//#UC START# *4C879306001C_4979DFB700F8test_impl*
 enDocumentBlockTest(aParams, True);
//#UC END# *4C879306001C_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlock_PrintPreview_Test

procedure TPrimContentsForm.DocumentBlock_PrintPreview_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C879306001C_4979DFB700F8exec_var*
var
 l_Node  : IeeNode;
 l_Sub     : IevSub;
 l_List: InevFlatSubsList;
//#UC END# *4C879306001C_4979DFB700F8exec_var*
begin
//#UC START# *4C879306001C_4979DFB700F8exec_impl*
 if IsMultiSelection then
 begin
  l_List := BuildSelectionList;
  if Assigned(l_List) then
   op_Document_PreviewBlock.Call(Aggregate, l_List, TextFormUserType)
  else
   Say(war_DocumentBlockNothingToPrint);
 end
 else
 begin
  l_Node := ContentsTree.TreeView.CurrentNode;
  if Supports(l_Node, IevSub, l_Sub) then
   op_Document_PreviewBlock.Call(Aggregate, l_Sub, TextFormUserType);
 end;
//#UC END# *4C879306001C_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlock_PrintPreview_Execute

procedure TPrimContentsForm.DocumentBlock_Select_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C87931D00FC_4979DFB700F8test_var*
//#UC END# *4C87931D00FC_4979DFB700F8test_var*
begin
//#UC START# *4C87931D00FC_4979DFB700F8test_impl*
 enDocumentBlockTest(aParams, True);
//#UC END# *4C87931D00FC_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlock_Select_Test

procedure TPrimContentsForm.DocumentBlock_Select_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C87931D00FC_4979DFB700F8exec_var*
var
 l_Node : IeeNode;
 l_Sub  : IevSub;
 l_List : InevFlatSubsList;
//#UC END# *4C87931D00FC_4979DFB700F8exec_var*
begin
//#UC START# *4C87931D00FC_4979DFB700F8exec_impl*
 if IsMultiSelection then
 begin
  l_List := BuildSelectionList;
  if Assigned(l_List) then
   Op_Document_SelectBlock.Call(Aggregate, l_List, TextFormUserType)
  else
   Say(war_DocumentBlockNothingToSelect);
 end//IsMultiSelection
 else
 begin
  l_Node := ContentsTree.TreeView.CurrentNode;
  if Supports(l_Node, IevSub, l_Sub) then
   Op_Document_SelectBlock.Call(Aggregate, l_Sub, TextFormUserType);
 end;//IsMultiSelection
//#UC END# *4C87931D00FC_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlock_Select_Execute

function TPrimContentsForm.ContentsValidator_IsDocumentAdornmentsChanged_Execute(const aNew: InsDocumentAdornments): Boolean;
//#UC START# *4D9B1F0A0335_4979DFB700F8exec_var*
//#UC END# *4D9B1F0A0335_4979DFB700F8exec_var*
begin
//#UC START# *4D9B1F0A0335_4979DFB700F8exec_impl*
 Assert(aNew <> nil);
 Result := false;
 if (aNew.Bookmarks = nil) then
  Result := Result OR (lstBookmarks.Total > 0)
 else
  Result := Result OR (lstBookmarks.Total <> aNew.Bookmarks.Count);
 if (aNew.Comments = nil) then
  Result := Result OR (lstComments.Total > 0)
 else
  Result := Result OR (lstComments.Total <> aNew.Comments.Count);
 if (aNew.ExternalObjects = nil) then
  Result := Result OR (lstExternalObjects.Total > 0)
 else
  Result := Result OR (lstExternalObjects.Total <> aNew.ExternalObjects.Count);
//#UC END# *4D9B1F0A0335_4979DFB700F8exec_impl*
end;//TPrimContentsForm.ContentsValidator_IsDocumentAdornmentsChanged_Execute

procedure TPrimContentsForm.ContentsValidator_IsDocumentAdornmentsChanged(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As IContentsValidator_IsDocumentAdornmentsChanged_Params) do
  ResultValue := Self.ContentsValidator_IsDocumentAdornmentsChanged_Execute(New);
end;//TPrimContentsForm.ContentsValidator_IsDocumentAdornmentsChanged

function TPrimContentsForm.Contents_HasUserComments_Execute: Boolean;
 {* Есть ли в оглавление пользовательские комментарии }
//#UC START# *4DF1FCA6008C_4979DFB700F8exec_var*
//#UC END# *4DF1FCA6008C_4979DFB700F8exec_var*
begin
//#UC START# *4DF1FCA6008C_4979DFB700F8exec_impl*
 Result := lstComments.Visible AND (lstComments.Total > 0);
//#UC END# *4DF1FCA6008C_4979DFB700F8exec_impl*
end;//TPrimContentsForm.Contents_HasUserComments_Execute

procedure TPrimContentsForm.Contents_HasUserComments(const aParams: IvcmExecuteParamsPrim);
 {* Есть ли в оглавление пользовательские комментарии }
begin
 with (aParams.Data As IContents_HasUserComments_Params) do
  ResultValue := Self.Contents_HasUserComments_Execute;
end;//TPrimContentsForm.Contents_HasUserComments

function TPrimContentsForm.Contents_HasBookmarks_Execute: Boolean;
 {* Есть ли в оглавлении закладки }
//#UC START# *4DF1FCC602EE_4979DFB700F8exec_var*
//#UC END# *4DF1FCC602EE_4979DFB700F8exec_var*
begin
//#UC START# *4DF1FCC602EE_4979DFB700F8exec_impl*
 Result := lstBookmarks.Visible AND (lstBookmarks.Total > 0);
//#UC END# *4DF1FCC602EE_4979DFB700F8exec_impl*
end;//TPrimContentsForm.Contents_HasBookmarks_Execute

procedure TPrimContentsForm.Contents_HasBookmarks(const aParams: IvcmExecuteParamsPrim);
 {* Есть ли в оглавлении закладки }
begin
 with (aParams.Data As IContents_HasBookmarks_Params) do
  ResultValue := Self.Contents_HasBookmarks_Execute;
end;//TPrimContentsForm.Contents_HasBookmarks

function TPrimContentsForm.Contents_ToggleContentsVisibility_Execute: Boolean;
 {* Переключает видимость ПЛАВАЮЩЕГО окна оглавления, возвращает true если переключение удалось }
//#UC START# *4E79E67402E7_4979DFB700F8exec_var*
var
 l_P : TafwCustomForm;
//#UC END# *4E79E67402E7_4979DFB700F8exec_var*
begin
//#UC START# *4E79E67402E7_4979DFB700F8exec_impl*
 Result := false;
 if IsFloatingState then
 begin
  l_P := afw.GetAnotherParentForm(Self);
  if (l_P <> nil) then
  begin
   Result := true;
   l_P.Visible := not l_P.Visible;
   StoreFloatingVisible(l_P.Visible);
   CheckFocus;
  end;//l_P <> nil
 end;//IsFloatingState
//#UC END# *4E79E67402E7_4979DFB700F8exec_impl*
end;//TPrimContentsForm.Contents_ToggleContentsVisibility_Execute

procedure TPrimContentsForm.Contents_ToggleContentsVisibility(const aParams: IvcmExecuteParamsPrim);
 {* Переключает видимость ПЛАВАЮЩЕГО окна оглавления, возвращает true если переключение удалось }
begin
 with (aParams.Data As IContents_ToggleContentsVisibility_Params) do
  ResultValue := Self.Contents_ToggleContentsVisibility_Execute;
end;//TPrimContentsForm.Contents_ToggleContentsVisibility

function TPrimContentsForm.Contents_IsContentsVisible_Execute: Boolean;
 {* Возвращает состояние видимости ПЛАВАЮЩЕГО окна оглавления }
//#UC START# *4E79E6C4018D_4979DFB700F8exec_var*
var
 l_P : TafwCustomForm;
//#UC END# *4E79E6C4018D_4979DFB700F8exec_var*
begin
//#UC START# *4E79E6C4018D_4979DFB700F8exec_impl*
 Result := false;
 if IsFloatingState then
 begin
  l_P := afw.GetAnotherParentForm(Self);
  if (l_P <> nil) then
  begin
   Result := l_P.Visible;
   StoreFloatingVisible(Result);
  end;//l_P <> nil
 end;//IsFloatingState
//#UC END# *4E79E6C4018D_4979DFB700F8exec_impl*
end;//TPrimContentsForm.Contents_IsContentsVisible_Execute

procedure TPrimContentsForm.Contents_IsContentsVisible(const aParams: IvcmExecuteParamsPrim);
 {* Возвращает состояние видимости ПЛАВАЮЩЕГО окна оглавления }
begin
 with (aParams.Data As IContents_IsContentsVisible_Params) do
  ResultValue := Self.Contents_IsContentsVisible_Execute;
end;//TPrimContentsForm.Contents_IsContentsVisible

procedure TPrimContentsForm.Comment_Changed_Execute;
//#UC START# *4EAAE5C40089_4979DFB700F8exec_var*
//#UC END# *4EAAE5C40089_4979DFB700F8exec_var*
begin
//#UC START# *4EAAE5C40089_4979DFB700F8exec_impl*
 if (lstComments <> nil) then
  lstComments.Invalidate;
//#UC END# *4EAAE5C40089_4979DFB700F8exec_impl*
end;//TPrimContentsForm.Comment_Changed_Execute

procedure TPrimContentsForm.Comment_Changed(const aParams: IvcmExecuteParamsPrim);
begin
 Self.Comment_Changed_Execute;
end;//TPrimContentsForm.Comment_Changed

procedure TPrimContentsForm.DocumentBlock_GetSimilarDocsToBlock_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *5587AA310201_4979DFB700F8test_var*
var
 l_Sub: IevSub;
//#UC END# *5587AA310201_4979DFB700F8test_var*
begin
//#UC START# *5587AA310201_4979DFB700F8test_impl*
 if (ContentsTree.TreeView.CurrentNode <> nil) then
  if Supports(ContentsTree.TreeView.CurrentNode, IevSub, l_Sub) and
     (l_Sub.LayerID = Ord(ev_sbtSub)) then
  begin
   if f_LastBlockIdForHasSimilar = l_Sub.Id then
    aParams.Op.Flag[vcm_ofEnabled] := f_LastHasSimilar
   else
   begin
    f_LastBlockIdForHasSimilar := l_Sub.Id;
    f_LastHasSimilar := Contents.HasSimilarToFragment(f_LastBlockIdForHasSimilar);
    aParams.Op.Flag[vcm_ofEnabled] := f_LastHasSimilar;
   end;
   Exit;
  end;
 aParams.Op.Flag[vcm_ofEnabled] := False;
//#UC END# *5587AA310201_4979DFB700F8test_impl*
end;//TPrimContentsForm.DocumentBlock_GetSimilarDocsToBlock_Test

procedure TPrimContentsForm.DocumentBlock_GetSimilarDocsToBlock_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *5587AA310201_4979DFB700F8exec_var*
//#UC END# *5587AA310201_4979DFB700F8exec_var*
begin
//#UC START# *5587AA310201_4979DFB700F8exec_impl*
 Contents.OpenSimilarDocumentsToFragment(f_LastBlockIdForHasSimilar);
// Op_ListSupport_ActivateSimilarDocumentsList.Broadcast;
//#UC END# *5587AA310201_4979DFB700F8exec_impl*
end;//TPrimContentsForm.DocumentBlock_GetSimilarDocsToBlock_Execute

procedure TPrimContentsForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4979DFB700F8_var*
//#UC END# *479731C50290_4979DFB700F8_var*
begin
//#UC START# *479731C50290_4979DFB700F8_impl*
 if (ContentsTree.TreeStruct <> nil) then
  ContentsTree.TreeStruct.Unsubscribe(InsTreeDataListener(Self));
 //f_ContentsNode := nil;
 Finalize(f_Filtered);
 inherited;
//#UC END# *479731C50290_4979DFB700F8_impl*
end;//TPrimContentsForm.Cleanup

procedure TPrimContentsForm.InitFields;
//#UC START# *47A042E100E2_4979DFB700F8_var*
//#UC END# *47A042E100E2_4979DFB700F8_var*
begin
//#UC START# *47A042E100E2_4979DFB700F8_impl*
 inherited;
 Color := clWhite;
//#UC END# *47A042E100E2_4979DFB700F8_impl*
end;//TPrimContentsForm.InitFields

constructor TPrimContentsForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4979DFB700F8_var*
//#UC END# *47D1602000C6_4979DFB700F8_var*
begin
//#UC START# *47D1602000C6_4979DFB700F8_impl*
 inherited;
 {$If not defined(Admin) AND not defined(Monitorings)}
 //http://mdp.garant.ru/pages/viewpage.action?pageId=515841696 
 with dmStdRes.MenuManager.GetItemByName('enDocumentBlock') do
 begin
  with TvcmRepOperationsCollectionItem(Operations.FindItemByName('opGetCorrespondentList')) do
   FormActivate.RepeatedActivationBehaviour := vcm_rabJustExecuteIfActive;
  with TvcmRepOperationsCollectionItem(Operations.FindItemByName('opGetTypedCorrespondentList')) do
   FormActivate.RepeatedActivationBehaviour := vcm_rabJustExecuteIfActive;
 end;
 {$IfEnd} //not Admin AND not Monitorings
//#UC END# *47D1602000C6_4979DFB700F8_impl*
end;//TPrimContentsForm.Create

procedure TPrimContentsForm.NotifyDataSourceChanged(const anOld: IvcmViewAreaController;
 const aNew: IvcmViewAreaController);
 {* Изменился источник данных. Для перекрытия в потомках }
//#UC START# *497469C90140_4979DFB700F8_var*
//#UC END# *497469C90140_4979DFB700F8_var*
begin
//#UC START# *497469C90140_4979DFB700F8_impl*
 inherited;
 {$IfDef vcmUseProfilers}
 f_FirstCurrentChanged := False;
 {$EndIf vcmUseProfilers}
 InitLists;
 ContextFilter.UpdateIsContextWrong;
 f_LastBlockIdForHasSimilar := -1;
 f_LastHasSimilar := False;
//#UC END# *497469C90140_4979DFB700F8_impl*
end;//TPrimContentsForm.NotifyDataSourceChanged

procedure TPrimContentsForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4979DFB700F8_var*
//#UC END# *4A8E8F2E0195_4979DFB700F8_var*
begin
//#UC START# *4A8E8F2E0195_4979DFB700F8_impl*
 inherited;

 Align := alClient;
 ActiveControl := ContentsTree;

 // begin http://mdp.garant.ru/pages/viewpage.action?pageId=336142662
 lstBookmarks.StyleId := evd_saTOC;
 lstBookmarks.UseStyleTable := true;
 lstComments.StyleId := evd_saTOC;
 lstComments.UseStyleTable := true;
 lstExternalObjects.StyleId := evd_saTOC;
 lstExternalObjects.UseStyleTable := true;
 // end http://mdp.garant.ru/pages/viewpage.action?pageId=336142662

 f_ListForFiltering[ns_cltBookmarks] := lstBookmarks;
 f_ListForFiltering[ns_cltComments] := lstComments;
 f_ListForFiltering[ns_cltExternalObjects] := lstExternalObjects;
 with BackgroundPanel do
 begin
  Align := alClient;
  BevelOuter := bvNone;
 end;
 with ContextFilter do
 begin
  Images := dmStdRes.SmallImageList;
  ImageIndex := 77;
  LabelVisible := False;
  ContextFilterTarget := ContentsTree;
  OnChange := Self.ContextFilterChange;
  OnWrongContext := Self.ContextFilterWrongContext;
  OnGetIsContextWrong := Self.GetIsContextWrong;
 end;//with ContextFilter
 with ContentsTree do
 begin
  Height := 245;
  Align := alClient;
  BorderStyle := bsNone;
  TabOrder := 1;
  ShowHeader := False;
  PickedList := False;
  MultiSelect := True;
  MultiStrokeItem := False;
  ActionElementMode := l3_amSecondSingleClick;
  AllowWithoutCurrent := False;
  DragAndDropSupported := True;
  FooterVisible := False;

  FooterStyleID := evd_saHyperLink;
  FooterActiveStyleID := evd_saActiveHyperLink;
  //StyleId := evd_saInterface;
  ContentsTree.StyleId := evd_saTOC;
  ContentsTree.UseStyleTable := True;
  SettingId := 'stidContentsTree';

  OnNewCharPressed := Self.ContentsTreeNewCharPressed;
  OnMakeTreeSource := Self.ContentsTreeMakeTreeSource;
  OnGetItemImage := Self.ContentsTreeGetItemImage;
  OnActionElement := Self.ContentsTreeActionElement;
  OnCurrentChanged := Self.ContentsTreeCurrentChanged;
  OnTreeChanged := Self.ContentsTreeTreeChanged;
  OnRootChanged := Self.ContentsTreeRootChanged;
 end;//with ContentsTree
 InitLists;
//#UC END# *4A8E8F2E0195_4979DFB700F8_impl*
end;//TPrimContentsForm.InitControls

procedure TPrimContentsForm.DefaultQueryClose(aSender: TObject);
//#UC START# *4E7A030702C6_4979DFB700F8_var*
var
 l_P : TafwCustomForm;
 l_FW : IafwFloatingWindow;
//#UC END# *4E7A030702C6_4979DFB700F8_var*
begin
//#UC START# *4E7A030702C6_4979DFB700F8_impl*
 if not f_CloseDisabled then
  inherited
 else
 if not FloatingHide then
  inherited;
 l_P := afw.GetAnotherParentForm(Self);
 if (l_P <> nil) AND (TForm(l_P).FormStyle = fsStayOnTop) then
  if Supports(l_P, IafwFloatingWindow, l_FW) then
  try
   l_FW.DisableReactivate;
   //l_FW.DisableClose;
  finally
   l_FW := nil;
  end;//try..finally
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=595963346
//#UC END# *4E7A030702C6_4979DFB700F8_impl*
end;//TPrimContentsForm.DefaultQueryClose

procedure TPrimContentsForm.CheckFloatingVisibility;
//#UC START# *4E7A13AE01BC_4979DFB700F8_var*
var
 l_P : TafwCustomForm;
//#UC END# *4E7A13AE01BC_4979DFB700F8_var*
begin
//#UC START# *4E7A13AE01BC_4979DFB700F8_impl*
 inherited;
 if IsFloatingState then
 begin
  l_P := afw.GetAnotherParentForm(Self);
  Assert(l_P <> nil);
  CheckActionElementMode;
  if (l_P <> nil) then
   if not Self.FloatingVisible then
    l_P.Hide
   else
    Self.CheckFocus; 
 end;//IsFloatingState
//#UC END# *4E7A13AE01BC_4979DFB700F8_impl*
end;//TPrimContentsForm.CheckFloatingVisibility

function TPrimContentsForm.CanHaveCloseButtonInNavigator: Boolean;
//#UC START# *4F619BCE008A_4979DFB700F8_var*
//#UC END# *4F619BCE008A_4979DFB700F8_var*
begin
//#UC START# *4F619BCE008A_4979DFB700F8_impl*
 Result := IsFloatingState{f_CloseDisabled};
 // - бред конечно, но так - правильно, а на самом деле f_CloseDisabled - должна называться f_IsFloatingNow
//#UC END# *4F619BCE008A_4979DFB700F8_impl*
end;//TPrimContentsForm.CanHaveCloseButtonInNavigator

function TPrimContentsForm.CanHaveOwnCloseButtonInNavigator: Boolean;
//#UC START# *4F6A0EE50047_4979DFB700F8_var*
//#UC END# *4F6A0EE50047_4979DFB700F8_var*
begin
//#UC START# *4F6A0EE50047_4979DFB700F8_impl*
 Result := false;
//#UC END# *4F6A0EE50047_4979DFB700F8_impl*
end;//TPrimContentsForm.CanHaveOwnCloseButtonInNavigator

procedure TPrimContentsForm.ClearFields;
begin
 Finalize(f_Filtered);
 Finalize(f_ListForFiltering);
 inherited;
end;//TPrimContentsForm.ClearFields

initialization
 str_ContentsPrintTitle.Init;
 {* Инициализация str_ContentsPrintTitle }
 str_cgContents.Init;
 {* Инициализация str_cgContents }
 str_cgBookmarks.Init;
 {* Инициализация str_cgBookmarks }
 str_cgComments.Init;
 {* Инициализация str_cgComments }
 str_cgExternalObjects.Init;
 {* Инициализация str_cgExternalObjects }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimContentsForm);
 {* Регистрация PrimContents }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
