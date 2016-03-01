{$IfNDef dsDocumentList_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\dsDocumentList.imp.pas"
// Стереотип: "ViewAreaControllerImp"

{$Define dsDocumentList_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _FormDataSourceType_ = IdsDocumentList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsList.imp.pas}
 _dsDocumentList_ = {abstract} class(_dsList_, IdsDocumentList, InsCRSimpleListTypeRootNodeListener)
  {* Список документов }
  private
   f_DocumentListType: TlstCRType;
   f_CRTypeNode: INodeBase;
    {* тип корреспондентов/респондентов выбранный пользователем }
   f_IsSortParamsRecieved: Boolean;
   f_SortOrder: TbsSortOrder;
   f_SortType: TbsSortType;
   f_ValidSortTypes: TbsValidSortTypes;
   f_OpenFrom: TbsListOpenFrom;
    {* откуда был открыт список }
   f_TimeMachineOff: Boolean;
   f_DocCount: Integer;
    {* Поле для свойства DocCount }
   f_CRTypeCurrent: Il3Node;
    {* Поле для свойства CRTypeCurrent }
  protected
   DocInfo: IsdsDocInfo;
   List: IsdsList;
  private
   procedure GetSortParams;
   procedure CheckDocumentUseCase;
   function Resort(const aTreeSource: Il3SimpleTree;
    const aCurrentNode: Il3SimpleNode): Il3SimpleTree;
    {* пересортировать текущий список }
   function FindParentDocNode(const aNode: Il3SimpleNode): Il3SimpleNode;
    {* Ищет родительскую ноду документа }
  protected
   function ToPart: Boolean; virtual;
   function DoGet_IsShortList: Boolean; virtual;
   function DoGet_IsSnippet: Boolean; virtual;
   function DoCanAnalize: Boolean; virtual;
   function pm_GetDocumentListType: TlstCRType;
   function pm_GetSortOrder: TbsSortOrder;
   function pm_GetSortType: TbsSortType;
   function pm_GetValidSortTypes: TbsValidSortTypes;
   function pm_GetHasSimilarDocuments: Boolean;
   function pm_GetHasAnnotation: Boolean;
   function pm_GetHasCorrespondents: Boolean;
   function pm_GetHasRelatedDoc: Boolean;
   function pm_GetHasRespondents: Boolean;
   function pm_GetIsUnderControl: Boolean;
   function pm_GetIsDocument: Boolean;
   function pm_GetCRTypeNode: Il3Node;
   function pm_GetCRTypeRoot: Il3Node;
   function pm_GetOpenFrom: TbsListOpenFrom;
   function pm_GetCRTypeName: Il3CString;
   function pm_GetIsListNotFull: Boolean;
   function pm_GetCurrentRelevance: Integer;
   function ChangeCRType(const aNode: Il3Node): Boolean;
    {* - вызывается при изменении типа корреспондентов/респондентов. }
   function ChangeSortOrder(const aTreeSource: Il3SimpleTree;
    const aCurrentNode: Il3SimpleNode): Il3SimpleTree;
    {* - изменить порядок сортировки. }
   function ChangeSortType(const aTreeSource: Il3SimpleTree;
    const aCurrentNode: Il3SimpleNode;
    aValue: TbsSortType): Il3SimpleTree;
    {* - изменить тип сортировки. }
   function Find(const aContext: Il3CString;
    const aFrom: Il3SimpleNode): Il3SimpleNode;
    {* - найти следующий узел начиная от поданного. }
   procedure AddToControl;
    {* - поставить документ на контроль. }
   procedure DelFromControl;
    {* - снять с контроля. }
   function CanAddToControl: Boolean;
    {* - Можно ли ставить на контроль. }
   procedure Updated;
    {* изменилось дерево }
   function pm_GetIsShortList: Boolean;
   function MakeFullList: IdeDocumentList;
    {* Переключится на полный список }
   function pm_GetIsSnippet: Boolean;
   function CanAnalize: Boolean;
   function MakeAnalizeTree: Il3SimpleTree;
   function Get_FullListCount: Integer;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function MakeDocInfo(const aNode: INodeBase): IdeDocInfo; override;
    {* создать информацию о документе по узлу. }
   procedure ResetChildrenCount; override;
    {* - очищаем кеши при изменении дерева. }
   procedure RootIsMaked; override;
    {* - вызывается при получении корня у списка. }
   function DoOpenDocument(out theDataInfo: IdeDocInfo): Boolean; override;
    {* - возвращает SDS для открытия сборки документ. }
   function DataForNewList(const aNewList: IDynList;
    aAllDocumentsFiltered: Boolean): IdeList; override;
    {* - данные для открытия списка в новом окне. }
   function MakeImageList: Il3ImageList; override;
    {* - создать иконки дерева. }
   function DoIsTimeMachineEnable: Boolean; override;
    {* - доступна ли работа с машиной времени. }
   function NeedTimeMachineOff: Boolean; override;
    {* - при открытии списка необходимо выключить машину времени. }
   procedure DoUpdateListInfo; override;
    {* - обновить информацию о списке. }
   procedure MarkNodeForExport(const aNode: Il3SimpleNode;
    aOnlyFirstLevel: Boolean); override;
    {* - пометить узел для экспорта. }
   function DoOpenListFromSelectedNodes: IdeList; override;
    {* - открыть список из выделенных элементов. }
   function DoApplyLogicOperation(const aList: IDynList;
    aOperation: TListLogicOperation): Boolean; override;
    {* - выполнить логическую операцию со списком. }
   function CanCreateBookmark: Boolean; override;
    {* - можно ли создать закладку на текущий документ }
   function MakeDocumentFromBookmark: IDocument; override;
    {* - получить документ для создания закладки. }
   procedure DoDataDropped; override;
   {$If NOT Defined(NoVCM)}
   procedure GotData; override;
    {* - данные изменились. }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
   function CheckFullList: Boolean; override;
   procedure ClearFields; override;
  protected
   property DocCount: Integer
    read f_DocCount;
    {* количество документов после получения Root. Необходимо для ответа на
           IsListNotFull }
   property CRTypeCurrent: Il3Node
    read f_CRTypeCurrent;
 end;//_dsDocumentList_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsList.imp.pas}
_dsDocumentList_ = _dsList_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dsDocumentList_imp}

{$IfNDef dsDocumentList_imp_impl}

{$Define dsDocumentList_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsList.imp.pas}

procedure _dsDocumentList_.GetSortParams;
//#UC START# *4926AA480044_47E9EDC602B2_var*
var
 l_CurrentSortParams: TSortParams;
//#UC END# *4926AA480044_47E9EDC602B2_var*
begin
//#UC START# *4926AA480044_47E9EDC602B2_impl*
 if Assigned(ImpList) then
  try
   ImpList.GetCurrentSortParams(l_CurrentSortParams);
   f_SortOrder := l_CurrentSortParams.rSortOrder;
   f_SortType := l_CurrentSortParams.rSortType;
  except
   on ECanNotFindData do
    ImpList :=  nil;
  end;

 f_IsSortParamsRecieved := True;
//#UC END# *4926AA480044_47E9EDC602B2_impl*
end;//_dsDocumentList_.GetSortParams

procedure _dsDocumentList_.CheckDocumentUseCase;
//#UC START# *4926AA6A014A_47E9EDC602B2_var*
//#UC END# *4926AA6A014A_47E9EDC602B2_var*
begin
//#UC START# *4926AA6A014A_47E9EDC602B2_impl*
 if pm_GetIsListEmpty and (ucc_List <> nil) and (ucc_List.dsList.IsSame(Self)) then
 begin
  ucc_List.ChangeDocument(nil);
  Current := nil;
 end;
//#UC END# *4926AA6A014A_47E9EDC602B2_impl*
end;//_dsDocumentList_.CheckDocumentUseCase

function _dsDocumentList_.Resort(const aTreeSource: Il3SimpleTree;
 const aCurrentNode: Il3SimpleNode): Il3SimpleTree;
 {* пересортировать текущий список }
//#UC START# *4926AA910057_47E9EDC602B2_var*
var
 l_SP : TSortParams;
//#UC END# *4926AA910057_47E9EDC602B2_var*
begin
//#UC START# *4926AA910057_47E9EDC602B2_impl*
 Result := nil;
 // Запоним параметры
 with l_SP do
 begin
  rSortOrder := f_SortOrder;
  rSortType := f_SortType;
 end;
 CheckFullList;
 // Пересортируем
 ImpList.Sort(l_SP);
 // Регистрация события сортировки:
 TnsListSortEvent.Log(ImpList, f_SortOrder, f_SortType);
 Result := RefreshSimpleTree;
 if DoGetIsSnippet then
  Result.ExpandSubDir(nil, True, 0);
//#UC END# *4926AA910057_47E9EDC602B2_impl*
end;//_dsDocumentList_.Resort

function _dsDocumentList_.FindParentDocNode(const aNode: Il3SimpleNode): Il3SimpleNode;
 {* Ищет родительскую ноду документа }
//#UC START# *4926AABE01B9_47E9EDC602B2_var*
//#UC END# *4926AABE01B9_47E9EDC602B2_var*
begin
//#UC START# *4926AABE01B9_47E9EDC602B2_impl*
 if Assigned(aNode) then
 begin
  Result := aNode.Parent;
  while Assigned(Result) and not (ListNodeType(Result) in [lntDocActive, lntDocPreActive,
   lntDocAbolished, lntRedaction]) do
   Result := Result.Parent;
 end
 else
  Result := nil;
//#UC END# *4926AABE01B9_47E9EDC602B2_impl*
end;//_dsDocumentList_.FindParentDocNode

function _dsDocumentList_.ToPart: Boolean;
//#UC START# *492D797E007F_47E9EDC602B2_var*
//#UC END# *492D797E007F_47E9EDC602B2_var*
begin
//#UC START# *492D797E007F_47E9EDC602B2_impl*
 Result := false;
//#UC END# *492D797E007F_47E9EDC602B2_impl*
end;//_dsDocumentList_.ToPart

function _dsDocumentList_.DoGet_IsShortList: Boolean;
//#UC START# *4A2D0838019C_47E9EDC602B2_var*
//#UC END# *4A2D0838019C_47E9EDC602B2_var*
begin
//#UC START# *4A2D0838019C_47E9EDC602B2_impl*
 Result := False;
//#UC END# *4A2D0838019C_47E9EDC602B2_impl*
end;//_dsDocumentList_.DoGet_IsShortList

function _dsDocumentList_.DoGet_IsSnippet: Boolean;
//#UC START# *4A796F46039D_47E9EDC602B2_var*
//#UC END# *4A796F46039D_47E9EDC602B2_var*
begin
//#UC START# *4A796F46039D_47E9EDC602B2_impl*
 Result := False;
//#UC END# *4A796F46039D_47E9EDC602B2_impl*
end;//_dsDocumentList_.DoGet_IsSnippet

function _dsDocumentList_.DoCanAnalize: Boolean;
//#UC START# *4AA0F2E70398_47E9EDC602B2_var*
//#UC END# *4AA0F2E70398_47E9EDC602B2_var*
begin
//#UC START# *4AA0F2E70398_47E9EDC602B2_impl*
 Result := False;
//#UC END# *4AA0F2E70398_47E9EDC602B2_impl*
end;//_dsDocumentList_.DoCanAnalize

function _dsDocumentList_.pm_GetDocumentListType: TlstCRType;
//#UC START# *47F1CDF60078_47E9EDC602B2get_var*
//#UC END# *47F1CDF60078_47E9EDC602B2get_var*
begin
//#UC START# *47F1CDF60078_47E9EDC602B2get_impl*
 Result := f_DocumentListType;
//#UC END# *47F1CDF60078_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetDocumentListType

function _dsDocumentList_.pm_GetSortOrder: TbsSortOrder;
//#UC START# *47F1DBA00097_47E9EDC602B2get_var*
//#UC END# *47F1DBA00097_47E9EDC602B2get_var*
begin
//#UC START# *47F1DBA00097_47E9EDC602B2get_impl*
 if not f_IsSortParamsRecieved then
  GetSortParams;

 Result := f_SortOrder;
//#UC END# *47F1DBA00097_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetSortOrder

function _dsDocumentList_.pm_GetSortType: TbsSortType;
//#UC START# *47F1E2DB03DA_47E9EDC602B2get_var*
//#UC END# *47F1E2DB03DA_47E9EDC602B2get_var*
begin
//#UC START# *47F1E2DB03DA_47E9EDC602B2get_impl*
 if not f_IsSortParamsRecieved then
  GetSortParams;

 Result := f_SortType;
//#UC END# *47F1E2DB03DA_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetSortType

function _dsDocumentList_.pm_GetValidSortTypes: TbsValidSortTypes;
//#UC START# *47F1E406013F_47E9EDC602B2get_var*
var
 lIndex : Integer;
 lTypes : ISortTypes;
//#UC END# *47F1E406013F_47E9EDC602B2get_var*
begin
//#UC START# *47F1E406013F_47E9EDC602B2get_impl*
 if (f_ValidSortTypes = []) and
    Assigned(ImpList) then
 begin
  ImpList.GetAvailableSortTypes(lTypes);
  if Assigned(lTypes) then
   try
    for lIndex := 0 to Pred(lTypes.Count) do
     Include(f_ValidSortTypes,lTypes[lIndex]);
   finally
    lTypes := nil;
   end;{try.finally}
 end;//if not Assigned(f_SortTypes) then
 Result := f_ValidSortTypes;
//#UC END# *47F1E406013F_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetValidSortTypes

function _dsDocumentList_.pm_GetHasSimilarDocuments: Boolean;
//#UC START# *47F1E7E70201_47E9EDC602B2get_var*
//#UC END# *47F1E7E70201_47E9EDC602B2get_var*
begin
//#UC START# *47F1E7E70201_47E9EDC602B2get_impl*
 Result := Assigned(ucc_DocInfo) and ucc_DocInfo.HasSimilarDocuments;
//#UC END# *47F1E7E70201_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetHasSimilarDocuments

function _dsDocumentList_.pm_GetHasAnnotation: Boolean;
//#UC START# *47F1E8060132_47E9EDC602B2get_var*
//#UC END# *47F1E8060132_47E9EDC602B2get_var*
begin
//#UC START# *47F1E8060132_47E9EDC602B2get_impl*
 Result := Assigned(ucc_DocInfo) and ucc_DocInfo.HasAnnotation;
//#UC END# *47F1E8060132_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetHasAnnotation

function _dsDocumentList_.pm_GetHasCorrespondents: Boolean;
//#UC START# *47F1E81E0324_47E9EDC602B2get_var*
//#UC END# *47F1E81E0324_47E9EDC602B2get_var*
begin
//#UC START# *47F1E81E0324_47E9EDC602B2get_impl*
 Result := Assigned(ucc_DocInfo) and ucc_DocInfo.HasCorrespondents;
//#UC END# *47F1E81E0324_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetHasCorrespondents

function _dsDocumentList_.pm_GetHasRelatedDoc: Boolean;
//#UC START# *47F1E832010D_47E9EDC602B2get_var*
//#UC END# *47F1E832010D_47E9EDC602B2get_var*
begin
//#UC START# *47F1E832010D_47E9EDC602B2get_impl*
 Result := Assigned(ucc_DocInfo)and ucc_DocInfo.HasRelatedDoc;
//#UC END# *47F1E832010D_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetHasRelatedDoc

function _dsDocumentList_.pm_GetHasRespondents: Boolean;
//#UC START# *47F1E8870093_47E9EDC602B2get_var*
//#UC END# *47F1E8870093_47E9EDC602B2get_var*
begin
//#UC START# *47F1E8870093_47E9EDC602B2get_impl*
 Result := Assigned(ucc_DocInfo) and ucc_DocInfo.HasRespondents;
//#UC END# *47F1E8870093_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetHasRespondents

function _dsDocumentList_.pm_GetIsUnderControl: Boolean;
//#UC START# *47F1E89D01B5_47E9EDC602B2get_var*
//#UC END# *47F1E89D01B5_47E9EDC602B2get_var*
begin
//#UC START# *47F1E89D01B5_47E9EDC602B2get_impl*
 Result := False;
 if Assigned(Document) then
  Result := TdmStdRes.IsUnderControl(Document.Doc)
//#UC END# *47F1E89D01B5_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetIsUnderControl

function _dsDocumentList_.pm_GetIsDocument: Boolean;
//#UC START# *47F1E8EB00BA_47E9EDC602B2get_var*
//#UC END# *47F1E8EB00BA_47E9EDC602B2get_var*
begin
//#UC START# *47F1E8EB00BA_47E9EDC602B2get_impl*
 if Assigned(ListNode) then
  Result := ListNodeType in cDocumentSet
 else
  Result := False;
//#UC END# *47F1E8EB00BA_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetIsDocument

function _dsDocumentList_.pm_GetCRTypeNode: Il3Node;
//#UC START# *47F1E96F02DC_47E9EDC602B2get_var*
var
 l_Root: Il3Node;
//#UC END# *47F1E96F02DC_47E9EDC602B2get_var*
begin
//#UC START# *47F1E96F02DC_47E9EDC602B2get_impl*
 Result := nil;
 if not Assigned(CRTypeCurrent) then
 begin
  l_Root := DefDataAdapter.CRSimpleListTypeRootNode;
  if Assigned(l_Root) then
  try
   if Assigned(f_CRTypeNode) then
    f_CRTypeCurrent := l3SearchByName(l_Root, pm_GetCRTypeName)
   else
    f_CRTypeCurrent := l_Root.ChildNode;
  finally
   l_Root := nil;
  end;{try..finally}
 end;//if not Assigned(CRTypeCurrent) then
 Result := CRTypeCurrent;
//#UC END# *47F1E96F02DC_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetCRTypeNode

function _dsDocumentList_.pm_GetCRTypeRoot: Il3Node;
//#UC START# *47F1E988002E_47E9EDC602B2get_var*
//#UC END# *47F1E988002E_47E9EDC602B2get_var*
begin
//#UC START# *47F1E988002E_47E9EDC602B2get_impl*
 Result := DefDataAdapter.CRSimpleListTypeRootNode;
//#UC END# *47F1E988002E_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetCRTypeRoot

function _dsDocumentList_.pm_GetOpenFrom: TbsListOpenFrom;
//#UC START# *47F1EA050290_47E9EDC602B2get_var*
//#UC END# *47F1EA050290_47E9EDC602B2get_var*
begin
//#UC START# *47F1EA050290_47E9EDC602B2get_impl*
 Result := f_OpenFrom;
//#UC END# *47F1EA050290_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetOpenFrom

function _dsDocumentList_.pm_GetCRTypeName: Il3CString;
//#UC START# *47F1EA1C002D_47E9EDC602B2get_var*
var
 lString : IString;
//#UC END# *47F1EA1C002D_47E9EDC602B2get_var*
begin
//#UC START# *47F1EA1C002D_47E9EDC602B2get_impl*
 if (f_CRTypeNode <> nil) then
  f_CRTypeNode.GetCaption(lString)
 else
  lString := nil;
 Result := nsCStr(lString);
//#UC END# *47F1EA1C002D_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetCRTypeName

function _dsDocumentList_.pm_GetIsListNotFull: Boolean;
//#UC START# *47F1EA570068_47E9EDC602B2get_var*
//#UC END# *47F1EA570068_47E9EDC602B2get_var*
begin
//#UC START# *47F1EA570068_47E9EDC602B2get_impl*
 Result := (f_DocumentListType <> crtNone) and not pm_GetIsListEmpty and
  (f_DocCount <= cMin_CR_List_Count);
//#UC END# *47F1EA570068_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetIsListNotFull

function _dsDocumentList_.pm_GetCurrentRelevance: Integer;
//#UC START# *47F1EA8502EE_47E9EDC602B2get_var*
//#UC END# *47F1EA8502EE_47E9EDC602B2get_var*
begin
//#UC START# *47F1EA8502EE_47E9EDC602B2get_impl*
 if CurrentEntryInfo <> nil then
  Result := CurrentEntryInfo.GetRelevance
 else
  Result := 0;
//#UC END# *47F1EA8502EE_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetCurrentRelevance

function _dsDocumentList_.ChangeCRType(const aNode: Il3Node): Boolean;
 {* - вызывается при изменении типа корреспондентов/респондентов. }
//#UC START# *47F1EE7202A6_47E9EDC602B2_var*
var
 lNode : INodeBase;
//#UC END# *47F1EE7202A6_47E9EDC602B2_var*
begin
//#UC START# *47F1EE7202A6_47E9EDC602B2_impl*
 Result := False;
 if Assigned(aNode) and Supports(aNode, INodeBase, lNode) then
 try
  if not Assigned(f_CRTypeNode) or not f_CRTypeNode.IsSameNode(lNode) then
   Result := ucc_DocInfo.ChangeCRType(lNode, f_DocumentListType, ToPart);
 finally
  lNode := nil;
 end;{try..finally}
//#UC END# *47F1EE7202A6_47E9EDC602B2_impl*
end;//_dsDocumentList_.ChangeCRType

function _dsDocumentList_.ChangeSortOrder(const aTreeSource: Il3SimpleTree;
 const aCurrentNode: Il3SimpleNode): Il3SimpleTree;
 {* - изменить порядок сортировки. }
//#UC START# *47F1EF4C03B2_47E9EDC602B2_var*
//#UC END# *47F1EF4C03B2_47E9EDC602B2_var*
begin
//#UC START# *47F1EF4C03B2_47E9EDC602B2_impl*
 if (f_SortOrder = SO_ASCENDING) then
  f_SortOrder := SO_DESCENDING
 else
  f_SortOrder := SO_ASCENDING;

 Result := Resort(aTreeSource, aCurrentNode);
//#UC END# *47F1EF4C03B2_47E9EDC602B2_impl*
end;//_dsDocumentList_.ChangeSortOrder

function _dsDocumentList_.ChangeSortType(const aTreeSource: Il3SimpleTree;
 const aCurrentNode: Il3SimpleNode;
 aValue: TbsSortType): Il3SimpleTree;
 {* - изменить тип сортировки. }
//#UC START# *47F1EF76022D_47E9EDC602B2_var*
//#UC END# *47F1EF76022D_47E9EDC602B2_var*
begin
//#UC START# *47F1EF76022D_47E9EDC602B2_impl*
 Result := nil;
 if aValue <> f_SortType then
 begin
  f_SortType := aValue;
  Result := Resort(aTreeSource, aCurrentNode);
 end;//if aValue <> f_SortType then
//#UC END# *47F1EF76022D_47E9EDC602B2_impl*
end;//_dsDocumentList_.ChangeSortType

function _dsDocumentList_.Find(const aContext: Il3CString;
 const aFrom: Il3SimpleNode): Il3SimpleNode;
 {* - найти следующий узел начиная от поданного. }
//#UC START# *47F1F3380317_47E9EDC602B2_var*
var
 l_Temp      : INodeBase;
 l_Path      : INodeIndexPath;
//#UC END# *47F1F3380317_47E9EDC602B2_var*
begin
//#UC START# *47F1F3380317_47E9EDC602B2_impl*
 Result := nil;
 if not pm_GetIsListEmpty then
 begin
  // Регистрируем событие поиска контекста в списке:
  TnsFindContextInListEvent.Log(ImpList, aContext);
  Supports(aFrom, INodeBase, l_Temp);
  if not Assigned(l_Temp) then
   l_Temp := Root;
  try
   l_Path := nil;
   l_Temp.GetFirstFit(nsMakeContextSearchFilterList(aContext,
                                                    DefDataAdapter.IsMorfoIndexExist,
                                                    False),
                      l_Path);
   if Assigned(l_Path) and (l_Path.Count > 0) then
   begin
    Root.GetNodeByPath(l_Path, l_Temp);
    if Assigned(l_Temp) then
     Result := TnsINodeWrap.Make(l_Temp)
    else
     Assert(False, caINodeIndexPathToINodeBaseFailed);
   end//if Result then
   // Выходим из цикла
   else
    l_Temp := nil;
  finally
   l_Temp := nil;
  end;{try..finally}
 end;//if Assigned(ImpList) then
//#UC END# *47F1F3380317_47E9EDC602B2_impl*
end;//_dsDocumentList_.Find

procedure _dsDocumentList_.AddToControl;
 {* - поставить документ на контроль. }
//#UC START# *47F2053B0244_47E9EDC602B2_var*
//#UC END# *47F2053B0244_47E9EDC602B2_var*
begin
//#UC START# *47F2053B0244_47E9EDC602B2_impl*
 if Assigned(Document) then
  TdmStdRes.AddDocumentToControl(Document.Doc);
//#UC END# *47F2053B0244_47E9EDC602B2_impl*
end;//_dsDocumentList_.AddToControl

procedure _dsDocumentList_.DelFromControl;
 {* - снять с контроля. }
//#UC START# *47F2054C001C_47E9EDC602B2_var*
//#UC END# *47F2054C001C_47E9EDC602B2_var*
begin
//#UC START# *47F2054C001C_47E9EDC602B2_impl*
 if Assigned(Document) then
  TdmStdRes.DeleteDocumentFromControl(Document.Doc);
//#UC END# *47F2054C001C_47E9EDC602B2_impl*
end;//_dsDocumentList_.DelFromControl

function _dsDocumentList_.CanAddToControl: Boolean;
 {* - Можно ли ставить на контроль. }
//#UC START# *47F2056400FD_47E9EDC602B2_var*
var
 l_Controllable: IControllable;
//#UC END# *47F2056400FD_47E9EDC602B2_var*
begin
//#UC START# *47F2056400FD_47E9EDC602B2_impl*
 Result := False;
 if Root.GetFlagCount(FM_SELECTION) > 1 then
  Result := True
 else
  if Assigned(Document) and Assigned(Document.Doc) and
     TdmStdRes.IsCurEditionActual(Document.Doc) then
   Result := Supports(Document.Doc, IControllable, l_Controllable) and
             l_Controllable.GetCanSetToControl;
//#UC END# *47F2056400FD_47E9EDC602B2_impl*
end;//_dsDocumentList_.CanAddToControl

procedure _dsDocumentList_.Updated;
 {* изменилось дерево }
//#UC START# *4926A3930339_47E9EDC602B2_var*
//#UC END# *4926A3930339_47E9EDC602B2_var*
begin
//#UC START# *4926A3930339_47E9EDC602B2_impl*
 f_CRTypeCurrent := nil;
 f_CRTypeNode := nil;
//#UC END# *4926A3930339_47E9EDC602B2_impl*
end;//_dsDocumentList_.Updated

function _dsDocumentList_.pm_GetIsShortList: Boolean;
//#UC START# *4A2CD019038B_47E9EDC602B2get_var*
//#UC END# *4A2CD019038B_47E9EDC602B2get_var*
begin
//#UC START# *4A2CD019038B_47E9EDC602B2get_impl*
 Result := DoGetIsShortList;
//#UC END# *4A2CD019038B_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetIsShortList

function _dsDocumentList_.MakeFullList: IdeDocumentList;
 {* Переключится на полный список }
//#UC START# *4A2CD04A013A_47E9EDC602B2_var*
var
 l_Node: Il3SimpleNode;
 l_BaseNode: INodeBase;
//#UC END# *4A2CD04A013A_47E9EDC602B2_var*
begin
//#UC START# *4A2CD04A013A_47E9EDC602B2_impl*
 if Assigned(ucc_List) then
 begin
  if Supports(Current, INodeBase, l_BaseNode) then
   l_Node := TnsINodeWrap.Make(l_BaseNode)
  else
   l_Node := Current;
  while Assigned(l_Node) and (l_Node.GetLevelFor(pm_GetSimpleTree.RootNode) > 1) do
   l_Node := l_Node.Parent;
  Result := ucc_List.MakeFullList(l_Node)
 end
 else
  Result := nil;
//#UC END# *4A2CD04A013A_47E9EDC602B2_impl*
end;//_dsDocumentList_.MakeFullList

function _dsDocumentList_.pm_GetIsSnippet: Boolean;
//#UC START# *4A796E570319_47E9EDC602B2get_var*
//#UC END# *4A796E570319_47E9EDC602B2get_var*
begin
//#UC START# *4A796E570319_47E9EDC602B2get_impl*
 Result := DoGetIsSnippet;
//#UC END# *4A796E570319_47E9EDC602B2get_impl*
end;//_dsDocumentList_.pm_GetIsSnippet

function _dsDocumentList_.CanAnalize: Boolean;
//#UC START# *4AA0E9F503B4_47E9EDC602B2_var*
//#UC END# *4AA0E9F503B4_47E9EDC602B2_var*
begin
//#UC START# *4AA0E9F503B4_47E9EDC602B2_impl*
 Result := DoCanAnalize;
//#UC END# *4AA0E9F503B4_47E9EDC602B2_impl*
end;//_dsDocumentList_.CanAnalize

function _dsDocumentList_.MakeAnalizeTree: Il3SimpleTree;
//#UC START# *4AA0EA29019C_47E9EDC602B2_var*
//#UC END# *4AA0EA29019C_47E9EDC602B2_var*
begin
//#UC START# *4AA0EA29019C_47E9EDC602B2_impl*
 if DoCanAnalize and Assigned(ucc_List) then
  Result := ucc_List.MakeAnalizeTree
 else
  Result := nil;
//#UC END# *4AA0EA29019C_47E9EDC602B2_impl*
end;//_dsDocumentList_.MakeAnalizeTree

function _dsDocumentList_.Get_FullListCount: Integer;
//#UC START# *4B58450403DD_47E9EDC602B2get_var*
//#UC END# *4B58450403DD_47E9EDC602B2get_var*
begin
//#UC START# *4B58450403DD_47E9EDC602B2get_impl*
 if pm_GetIsShortList then
  Result := ImpList.GetFullListSize
 else
  Result := 0;
//#UC END# *4B58450403DD_47E9EDC602B2get_impl*
end;//_dsDocumentList_.Get_FullListCount

procedure _dsDocumentList_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47E9EDC602B2_var*
//#UC END# *479731C50290_47E9EDC602B2_var*
begin
//#UC START# *479731C50290_47E9EDC602B2_impl*
 if (DefDataAdapter <> nil) then
  Il3ChangeNotifier(DefDataAdapter).Unsubscribe(InsCRSimpleListTypeRootNodeListener(Self));
 f_CRTypeCurrent := nil;
 inherited;
//#UC END# *479731C50290_47E9EDC602B2_impl*
end;//_dsDocumentList_.Cleanup

function _dsDocumentList_.MakeDocInfo(const aNode: INodeBase): IdeDocInfo;
 {* создать информацию о документе по узлу. }
//#UC START# *47F0C98F020C_47E9EDC602B2_var*
var
 l_Node: INodeBase;
//#UC END# *47F0C98F020C_47E9EDC602B2_var*
begin
//#UC START# *47F0C98F020C_47E9EDC602B2_impl*
 // Если выбран узел редакций, то показываем первую редакцию. Код временный,
 // нужно чтобы узел списка возвращал первую редакцию (CQ: OIT5-23368):
 if DoListNodeType(aNode) = lntRedactions then
  aNode.GetFirstChild(l_Node)
 else
  l_Node := aNode;
 inherited MakeDocInfo(l_Node);
 Result := bsDocInfoMake(CurrentEntryInfo,
                         l_Node,
                         ImpList,
                         LG_RUSSIAN,
                         Root,
                         {$IfNDef Monitorings}
                         False,
                         {$EndIf Monitorings}
                         SearchInfo);
//#UC END# *47F0C98F020C_47E9EDC602B2_impl*
end;//_dsDocumentList_.MakeDocInfo

procedure _dsDocumentList_.ResetChildrenCount;
 {* - очищаем кеши при изменении дерева. }
//#UC START# *47F2441D01B8_47E9EDC602B2_var*

  procedure lp_ResetFields;
  begin
   f_DocCount := 0;
   CurrentEntryInfo := nil;
  end;//lp_ResetFields

//#UC END# *47F2441D01B8_47E9EDC602B2_var*
begin
//#UC START# *47F2441D01B8_47E9EDC602B2_impl*
 inherited;
 lp_ResetFields;
 if (ucc_DocInfo <> nil) then
  ucc_DocInfo.ResetCacheAfterUpdate;
//#UC END# *47F2441D01B8_47E9EDC602B2_impl*
end;//_dsDocumentList_.ResetChildrenCount

procedure _dsDocumentList_.RootIsMaked;
 {* - вызывается при получении корня у списка. }
//#UC START# *47F257CF00B6_47E9EDC602B2_var*
//#UC END# *47F257CF00B6_47E9EDC602B2_var*
begin
//#UC START# *47F257CF00B6_47E9EDC602B2_impl*
 if not pm_GetIsListEmpty then
  f_DocCount := RootManager.RootNode.GetChildCount;
 CheckDocumentUseCase;
//#UC END# *47F257CF00B6_47E9EDC602B2_impl*
end;//_dsDocumentList_.RootIsMaked

function _dsDocumentList_.DoOpenDocument(out theDataInfo: IdeDocInfo): Boolean;
 {* - возвращает SDS для открытия сборки документ. }
//#UC START# *47F2661502C9_47E9EDC602B2_var*
//#UC END# *47F2661502C9_47E9EDC602B2_var*
begin
//#UC START# *47F2661502C9_47E9EDC602B2_impl*
 Result := inherited DoOpenDocument(theDataInfo);
 if Result then
 begin
  Assert(theDataInfo <> nil);
   // - dsList должен подготовить данные.
  with theDataInfo do
  begin
   Doc := defDataAdapter.TimeMachine.CorrectDocumentEdition(Document.Doc);
   SearchInfo := Self.SearchInfo;
  end;//with l_Temp do
 end;//if Result then
//#UC END# *47F2661502C9_47E9EDC602B2_impl*
end;//_dsDocumentList_.DoOpenDocument

function _dsDocumentList_.DataForNewList(const aNewList: IDynList;
 aAllDocumentsFiltered: Boolean): IdeList;
 {* - данные для открытия списка в новом окне. }
//#UC START# *47F33B990105_47E9EDC602B2_var*
var
 l_OpenFrom : TbsListOpenFrom;
//#UC END# *47F33B990105_47E9EDC602B2_var*
begin
//#UC START# *47F33B990105_47E9EDC602B2_impl*
 // Укажем откуда был открыт список
 if (f_DocumentListType <> crtNone) then
  l_OpenFrom := lofFullScreenCR
 else
 l_OpenFrom := lofNone;
 Result := TdeListSet.Make(aNewList,
                           wdOpenIfUserDefine,
                           l_OpenFrom,
                           True,
                           nil,
                           nil,
                           aAllDocumentsFiltered,
                           False);
//#UC END# *47F33B990105_47E9EDC602B2_impl*
end;//_dsDocumentList_.DataForNewList

function _dsDocumentList_.MakeImageList: Il3ImageList;
 {* - создать иконки дерева. }
//#UC START# *47F465F80149_47E9EDC602B2_var*
//#UC END# *47F465F80149_47E9EDC602B2_var*
begin
//#UC START# *47F465F80149_47E9EDC602B2_impl*
 Result := vtMakeImageListWrapper(nsListRes.ListItemsImageList);
//#UC END# *47F465F80149_47E9EDC602B2_impl*
end;//_dsDocumentList_.MakeImageList

function _dsDocumentList_.DoIsTimeMachineEnable: Boolean;
 {* - доступна ли работа с машиной времени. }
//#UC START# *47F48E08017C_47E9EDC602B2_var*
//#UC END# *47F48E08017C_47E9EDC602B2_var*
begin
//#UC START# *47F48E08017C_47E9EDC602B2_impl*
 Result := f_OpenFrom in [lofMultilink, lofFullScreenCR];
//#UC END# *47F48E08017C_47E9EDC602B2_impl*
end;//_dsDocumentList_.DoIsTimeMachineEnable

function _dsDocumentList_.NeedTimeMachineOff: Boolean;
 {* - при открытии списка необходимо выключить машину времени. }
//#UC START# *47F48E3D029F_47E9EDC602B2_var*
//#UC END# *47F48E3D029F_47E9EDC602B2_var*
begin
//#UC START# *47F48E3D029F_47E9EDC602B2_impl*
 Result := (f_DocumentListType = crtNone) and f_TimeMachineOff;
//#UC END# *47F48E3D029F_47E9EDC602B2_impl*
end;//_dsDocumentList_.NeedTimeMachineOff

procedure _dsDocumentList_.DoUpdateListInfo;
 {* - обновить информацию о списке. }
//#UC START# *47F4BDDB026E_47E9EDC602B2_var*
//#UC END# *47F4BDDB026E_47E9EDC602B2_var*
begin
//#UC START# *47F4BDDB026E_47E9EDC602B2_impl*
 if (f_DocumentListType = crtNone) and (ucc_List <> nil) then
  ucc_List.UpdateListInfo;
//#UC END# *47F4BDDB026E_47E9EDC602B2_impl*
end;//_dsDocumentList_.DoUpdateListInfo

procedure _dsDocumentList_.MarkNodeForExport(const aNode: Il3SimpleNode;
 aOnlyFirstLevel: Boolean);
 {* - пометить узел для экспорта. }
//#UC START# *47F9BFED004F_47E9EDC602B2_var*
var
 l_Level: Integer;
 l_Node: INodeBase;
//#UC END# *47F9BFED004F_47E9EDC602B2_var*
begin
//#UC START# *47F9BFED004F_47E9EDC602B2_impl*
 if Assigned(aNode) then
 begin
  case ListNodeType(aNode) of
   lntBlock,
   lntRedactions:
    MarkNodeForExport(FindParentDocNode(aNode), aOnlyFirstLevel);
   lntDocActive,
   lntDocPreActive,
   lntDocAbolished,
   lntRedaction:
   begin
    l_Level := aNode.GetLevelFor(pm_GetSimpleTree.RootNode);
    if (not aOnlyFirstLevel or (l_Level = 1)) and Supports(aNode, INodeBase, l_Node) then
     l_Node.SetFlag(cExportFlag, True);
    if l_Level > 1 then
     MarkNodeForExport(FindParentDocNode(aNode), aOnlyFirstLevel);
   end;
  end;//case ListNodeType(aNode) of
 end;//if Assigned(aNode) then
//#UC END# *47F9BFED004F_47E9EDC602B2_impl*
end;//_dsDocumentList_.MarkNodeForExport

function _dsDocumentList_.DoOpenListFromSelectedNodes: IdeList;
 {* - открыть список из выделенных элементов. }
//#UC START# *47FAFE6F010D_47E9EDC602B2_var*
//#UC END# *47FAFE6F010D_47E9EDC602B2_var*
begin
//#UC START# *47FAFE6F010D_47E9EDC602B2_impl*
 Result := TdeListSet.Make(NewListFromSelected);
//#UC END# *47FAFE6F010D_47E9EDC602B2_impl*
end;//_dsDocumentList_.DoOpenListFromSelectedNodes

function _dsDocumentList_.DoApplyLogicOperation(const aList: IDynList;
 aOperation: TListLogicOperation): Boolean;
 {* - выполнить логическую операцию со списком. }
//#UC START# *47FB05B90024_47E9EDC602B2_var*
//#UC END# *47FB05B90024_47E9EDC602B2_var*
begin
//#UC START# *47FB05B90024_47E9EDC602B2_impl*
 Result := inherited DoApplyLogicOperation(aList, aOperation);
 if Result then
 begin
  f_IsSortParamsRecieved := False;
  f_ValidSortTypes := [];
 end;//if Result then
//#UC END# *47FB05B90024_47E9EDC602B2_impl*
end;//_dsDocumentList_.DoApplyLogicOperation

function _dsDocumentList_.CanCreateBookmark: Boolean;
 {* - можно ли создать закладку на текущий документ }
//#UC START# *48034E6A01DD_47E9EDC602B2_var*
//#UC END# *48034E6A01DD_47E9EDC602B2_var*
begin
//#UC START# *48034E6A01DD_47E9EDC602B2_impl*
 Result := inherited CanCreateBookmark and pm_GetIsDocument;
//#UC END# *48034E6A01DD_47E9EDC602B2_impl*
end;//_dsDocumentList_.CanCreateBookmark

function _dsDocumentList_.MakeDocumentFromBookmark: IDocument;
 {* - получить документ для создания закладки. }
//#UC START# *48034E86029A_47E9EDC602B2_var*
//#UC END# *48034E86029A_47E9EDC602B2_var*
begin
//#UC START# *48034E86029A_47E9EDC602B2_impl*
 Result := defDataAdapter.TimeMachine.CorrectDocumentEdition(Document.Doc);
//#UC END# *48034E86029A_47E9EDC602B2_impl*
end;//_dsDocumentList_.MakeDocumentFromBookmark

procedure _dsDocumentList_.DoDataDropped;
//#UC START# *49215CE702B9_47E9EDC602B2_var*
//#UC END# *49215CE702B9_47E9EDC602B2_var*
begin
//#UC START# *49215CE702B9_47E9EDC602B2_impl*
 UpdateListInfo;
 TnsAddToListEvent.Log(ImpList);
//#UC END# *49215CE702B9_47E9EDC602B2_impl*
end;//_dsDocumentList_.DoDataDropped

{$If NOT Defined(NoVCM)}
procedure _dsDocumentList_.GotData;
 {* - данные изменились. }
//#UC START# *492ACF630072_47E9EDC602B2_var*
//#UC END# *492ACF630072_47E9EDC602B2_var*
begin
//#UC START# *492ACF630072_47E9EDC602B2_impl*
 inherited;
 f_OpenFrom := PartData.OpenFrom;
 f_TimeMachineOff := PartData.TimeMachineOff;
 f_DocumentListType := crtNone;
 f_CRTypeNode := nil;
//#UC END# *492ACF630072_47E9EDC602B2_impl*
end;//_dsDocumentList_.GotData
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _dsDocumentList_.DoInit;
//#UC START# *492BF7900310_47E9EDC602B2_var*
//#UC END# *492BF7900310_47E9EDC602B2_var*
begin
//#UC START# *492BF7900310_47E9EDC602B2_impl*
 inherited;
 f_DocumentListType := crtNone;
 f_IsSortParamsRecieved := False;
 f_DocCount := 0;
 f_OpenFrom := lofNone;
 f_ValidSortTypes := [];
 if (DefDataAdapter <> nil) then
  Il3ChangeNotifier(DefDataAdapter).Subscribe(InsCRSimpleListTypeRootNodeListener(Self));
//#UC END# *492BF7900310_47E9EDC602B2_impl*
end;//_dsDocumentList_.DoInit
{$IfEnd} // NOT Defined(NoVCM)

function _dsDocumentList_.COMQueryInterface(const IID: Tl3GUID;
 out Obj): Tl3HResult;
 {* Реализация запроса интерфейса }
//#UC START# *4A60B23E00C3_47E9EDC602B2_var*
//#UC END# *4A60B23E00C3_47E9EDC602B2_var*
begin
//#UC START# *4A60B23E00C3_47E9EDC602B2_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
 begin
  if IID.EQ(IDynList) then
  begin
   IDynList(Obj) := ImpList;
   Result.SetOK;
  end;//if IID.EQ(IDynList) then
 end;//Result.Fail then
//#UC END# *4A60B23E00C3_47E9EDC602B2_impl*
end;//_dsDocumentList_.COMQueryInterface

function _dsDocumentList_.CheckFullList: Boolean;
//#UC START# *4BFA427801B4_47E9EDC602B2_var*
//#UC END# *4BFA427801B4_47E9EDC602B2_var*
begin
//#UC START# *4BFA427801B4_47E9EDC602B2_impl*
 Result := DoGetIsSnippet;
 if Result then
 begin
  ImpList := bsBuildFullList(ImpList);
  ucc_List.ReplaceList(ImpList);
 end;
//#UC END# *4BFA427801B4_47E9EDC602B2_impl*
end;//_dsDocumentList_.CheckFullList

procedure _dsDocumentList_.ClearFields;
begin
 f_CRTypeCurrent := nil;
 inherited;
end;//_dsDocumentList_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dsDocumentList_imp_impl}

{$EndIf dsDocumentList_imp}

