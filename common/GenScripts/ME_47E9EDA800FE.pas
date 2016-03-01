{$IfNDef dsList_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsList.imp.pas"
// Стереотип: "ViewAreaControllerImp"

{$Define dsList_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}
 _dsBaseSearchSupportQuery_Parent_ = _dsSimpleTree_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseSearchSupportQuery.imp.pas}
 _dsList_ = {abstract} class(_dsBaseSearchSupportQuery_, Il3ItemNotifyRecipient, IdsList, IucbBaseSearchSupportQuery)
  {* Базовый бизнес объект для формы со списком }
  private
   f_AllDocumentFiltered: Boolean;
   f_IsChanged: Boolean;
   NodeForPositioningHolder: IucpNodeForPositioningHolder;
   f_InitialNeedApplyPermanentFilters: Boolean;
   f_Current: Il3SimpleNode;
    {* Поле для свойства Current }
   f_Document: IdeDocInfo;
    {* Поле для свойства Document }
   f_Preview: IafwComplexDocumentPreview;
    {* Поле для свойства Preview }
   f_PrintFirstLevel: Boolean;
    {* Поле для свойства PrintFirstLevel }
   f_CurrentEntryInfo: IListEntryInfo;
    {* Поле для свойства CurrentEntryInfo }
   f_ImpList: IDynList;
    {* Поле для свойства ImpList }
   f_SearchInfo: IdeSearchInfo;
    {* Поле для свойства SearchInfo }
   f_RootManager: TnsRootManager;
    {* Поле для свойства RootManager }
   f_ActiveFilters: IFiltersFromQuery;
    {* Поле для свойства ActiveFilters }
  protected
   BaseDocumentWithAttributes: IsdsBaseDocumentWithAttributes;
   BaseDocument: IsdsBaseDocument;
  private
   function DocumentPreview(aOnlyFirstLevel: Boolean = True): IafwDocumentPreview;
    {* - предварительный просмотр списка. }
   function InfoPreview: IafwDocumentPreview;
    {* - }
   function RightListNode: INodeBase;
    {* - даже если нажали на вхождение, то в качестве узла полжен быть           передан узел первого уровня, чтобы преход к пред\следующему            документу работал в списке, а не в ветке. }
   procedure FinishExporting;
    {* - закончить экспорт. }
   procedure ApplyFilters;
   procedure LoadActiveFilters(const aFilters: IFiltersFromQuery);
   function GetPermanentFilters: IFiltersFromQuery;
   function NeedApplyPermanentFilters: Boolean;
  protected
   function pm_GetCurrent: Il3SimpleNode;
   procedure pm_SetCurrent(const aValue: Il3SimpleNode);
   function pm_GetDocument: IdeDocInfo;
   procedure pm_SetDocument(const aValue: IdeDocInfo);
   function pm_GetPreview: IafwComplexDocumentPreview;
   procedure pm_SetPreview(const aValue: IafwComplexDocumentPreview);
   function pm_GetPrintFirstLevel: Boolean;
   procedure pm_SetPrintFirstLevel(aValue: Boolean);
   function pm_GetRoot: INodeBase;
   function pm_GetListNode: INodeBase;
   function pm_GetCurrentEntryInfo: IListEntryInfo;
   procedure pm_SetCurrentEntryInfo(const aValue: IListEntryInfo);
   function pm_GetImpList: IDynList;
   procedure pm_SetImpList(const aValue: IDynList);
   function pm_GetSearchInfo: IdeSearchInfo;
   function pm_GetRootManager: TnsRootManager;
   function MakeDocInfo(const aNode: INodeBase): IdeDocInfo; virtual;
    {* создать информацию о документе по узлу. }
   function NotifyAboutChangeCurrent: Boolean; virtual;
    {* уведомлять бизнес объект прецедента о смене текущего. }
   procedure ResetChildrenCount; virtual;
    {* - очищаем кеши при изменении дерева. }
   procedure RootIsMaked; virtual;
    {* - вызывается при получении корня у списка. }
   function DoOpenDocument(out theDataInfo: IdeDocInfo): Boolean; virtual;
    {* - возвращает SDS для открытия сборки документ. }
   function DataForNewList(const aNewList: IDynList;
    aAllDocumentsFiltered: Boolean = False): IdeList; virtual;
    {* - данные для открытия списка в новом окне. }
   function DoIsTimeMachineEnable: Boolean; virtual;
    {* - доступна ли работа с машиной времени. }
   function NeedTimeMachineOff: Boolean; virtual;
    {* - при открытии списка необходимо выключить машину времени. }
   procedure DoUpdateListInfo; virtual;
    {* - обновить информацию о списке. }
   procedure ClearCurrent;
    {* - очистить информацию о текущем. }
   procedure DoDeleteNodes; virtual;
    {* - удалить узлы. Для перекрытия в потомках. }
   procedure MarkDocumentsForExport(aOnlyFirstLevel: Boolean;
    aOnlySelection: Boolean);
    {* - пометить документы для экспорта. }
   procedure MarkNodeForExport(const aNode: Il3SimpleNode;
    aOnlyFirstLevel: Boolean); virtual;
    {* - пометить узел для экспорта. }
   function DoMakeDocumentPreview(const aDoc: IDocument): IafwComplexDocumentPreview;
    {* - предварительный просмотр для документа. }
   function DoListNodeType(const aNode: INodeBase): TbsListNodeType;
    {* - определить тип узла. }
   function DoOpenListFromSelectedNodes: IdeList; virtual;
    {* - открыть список из выделенных элементов. }
   function DoIsMain: Boolean; virtual;
    {* - определяет список в основной зоне приложения. }
   function DoApplyLogicOperation(const aList: IDynList;
    aOperation: TListLogicOperation): Boolean; virtual;
    {* - выполнить логическую операцию со списком. }
   function CanCreateBookmark: Boolean; virtual;
    {* - можно ли создать закладку на текущий документ }
   function MakeDocumentFromBookmark: IDocument; virtual;
    {* - получить документ для создания закладки. }
   procedure DoSetupNewSimpleTree(const aTree: Il3SimpleTree); virtual;
   function CheckFullList: Boolean; virtual;
   function As_IucbBaseSearchSupportQuery: IucbBaseSearchSupportQuery;
    {* Метод приведения нашего интерфейса к IucbBaseSearchSupportQuery }
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
    {* прошла операция. }
   function pm_GetIsSaved: Boolean;
   function pm_GetListName: Il3CString;
   function pm_GetShortListName: Il3CString;
   function pm_GetIsChanged: Boolean;
   function pm_GetIsFiltered: Boolean;
   procedure UpdatePreview;
    {* - обновить предварительный просмотр. }
   function MakePreview(aOnlyFirstLevel: Boolean = True): IafwComplexDocumentPreview;
    {* - формирует preview для списка. }
   function OpenDocument(out theDataInfo: IdeDocInfo): Boolean;
    {* - возвращает SDS для открытия сборки документ. }
   function NewListFromSelected: IDynList;
    {* - создать новый список из выделенных. }
   function pm_GetIsListEmpty: Boolean;
   function NewList: IdeList;
    {* - открыть список в окне. }
   function pm_GetIsTimeMachineEnable: Boolean;
   function pm_GetTimeMachineOff: Boolean;
   procedure UpdateListInfo;
    {* - обновляет информацию о списке. }
   function MakeSimpleTree: Il3SimpleTree; override;
    {* Создать данные дерева }
   function pm_GetListType: TbsListType;
   function CheckList(const aTree: Il3SimpleTree): Boolean;
    {* - определяет содержит ли aControl список. }
   function ApplyFilter(const aFilter: IFilterFromQuery;
    aAdd: Boolean = False): Boolean;
    {* - применить\отменить фильтр. }
   function ClearFilters: Boolean;
    {* - очистить фильтры. }
   procedure DeleteNodes;
    {* - удаляет выбранные узлы. }
   procedure ExportDocument(const aDocument: IDocument;
    const aFileName: Il3CString;
    aFormat: TnsFileFormat);
    {* - сохранить Указанный документ на диск в указанном формате. }
   function ExportDocuments(aOnlyFirstLevel: Boolean;
    aOnlySelection: Boolean;
    const aPath: Il3CString;
    aFormat: TnsFileFormat): Boolean;
    {* - сохранить выделенные документы на диск в указанном формате.
Возвращает признак того, что чего-то сохранили }
   function ListAsText(aSaveListKind: TbsSaveListKind;
    SaveSelection: Boolean): IStream;
    {* - получение списка в виде текта.  aOnlyFirstLevel - с\без вхождений. }
   function MergeDocuments(aOnlyFirstLevel: Boolean;
    aOnlySelection: Boolean;
    const aFileName: Il3CString;
    aFormat: TnsFileFormat;
    NeedPrintTopic: Boolean = True): Boolean;
    {* - сохранить выделенные документы в один файл в указанном формате. Разделяя, если указано, их фразой "Топик: <внутренний номер документа>".
Возвращает признак того, что чего-то сохранили }
   function RefreshFilters: Boolean;
    {* - переприменить фильтры. }
   function IsActiveFilter(const aFilter: IFilterFromQuery): Boolean;
    {* - является ли данный фильтр примененным. }
   function NodeId(const aNode: Il3SimpleNode): Integer;
    {* - получить идентификатор узла. }
   function MakeDocumentPreview: IafwComplexDocumentPreview;
    {* - предварительный просмотр для текущего документа. }
   function pm_GetList: IDynList;
   function ListNodeType(const aNode: Il3SimpleNode = nil): TbsListNodeType;
    {* - тип узла списка. }
   function OpenListFromSelectedNodes: IdeList;
    {* - открыть список из выделенных элементов. }
   function pm_GetIsMain: Boolean;
   function ApplyLogicOperation(const aList: IDynList;
    aOperation: TListLogicOperation): Boolean;
    {* - выполнить логическую операцию со списком. }
   function ApplyContextFilter(const aFilter: IContextFilter): INodeBase;
    {* - применить контекстный фильтр. }
   procedure SaveToFile(const aFileName: Tl3WString;
    aOnlySelected: Boolean);
    {* - при не успешном завершении возвращает ECannotSave. }
   function pm_GetNodeForPositioning: Il3SimpleNode;
   procedure ReleaseNodeForPositioning;
    {* - }
   function CreateBookmark: IBookmark;
    {* - добавить закладку на текущий документ. }
   function pm_GetAllDocumentFiltered: Boolean;
   function pm_GetHasAttributes: Boolean;
   function MakeSuperPreview(aOnlyFirstLevel: Boolean = True;
    WithTexts: Boolean = True): InsSuperComplexDocumentPreview;
    {* Создать суперкомплексное превью }
   function MakeMultiDocumentPreview(aOnlyFirstLevel: Boolean): IafwComplexDocumentPreview;
    {* Создать превью с текстами документов }
   function Get_ActiveFilters: IFiltersFromQuery;
   function ListAsString(aSaveListKind: TbsSaveListKind;
    SaveSelection: Boolean;
    aFormat: TnsFileFormat): Il3CString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure DoCurrentChanged(const aNode: Il3SimpleNode); override;
    {* сменился текущий. }
   procedure UpdateSimpleTree(const aOld: Il3SimpleTree;
    const aNew: Il3SimpleTree); override;
    {* - обновить данные дерева. }
   {$If NOT Defined(NoVCM)}
   procedure GotData; override;
    {* - данные изменились. }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoInit; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  private
   property PrintFirstLevel: Boolean
    read pm_GetPrintFirstLevel
    write pm_SetPrintFirstLevel;
  protected
   property Current: Il3SimpleNode
    read pm_GetCurrent
    write pm_SetCurrent;
    {* текущий узел списка. }
   property Document: IdeDocInfo
    read pm_GetDocument
    write pm_SetDocument;
   property Preview: IafwComplexDocumentPreview
    read pm_GetPreview
    write pm_SetPreview;
    {* - предварительный просмотр печати. }
   property Root: INodeBase
    read pm_GetRoot;
    {* - корень дерева списка. }
   property ListNode: INodeBase
    read pm_GetListNode;
    {* Текущий узел списка. }
   property CurrentEntryInfo: IListEntryInfo
    read pm_GetCurrentEntryInfo
    write pm_SetCurrentEntryInfo;
    {* - сущность текущего элемента списка. }
   property ImpList: IDynList
    read pm_GetImpList
    write pm_SetImpList;
    {* Список используемый в реализации. }
   property SearchInfo: IdeSearchInfo
    read pm_GetSearchInfo;
    {* Информация о поиске. }
   property RootManager: TnsRootManager
    read pm_GetRootManager;
  public
   property ActiveFilters: IFiltersFromQuery
    read f_ActiveFilters;
 end;//_dsList_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}
_dsBaseSearchSupportQuery_Parent_ = _dsSimpleTree_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseSearchSupportQuery.imp.pas}
_dsList_ = _dsBaseSearchSupportQuery_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dsList_imp}

{$IfNDef dsList_imp_impl}

{$Define dsList_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
const
 cExportFlag = DynamicTreeUnit.FM_FIRST_USER_FLAG;
  {* флаг, которым помечаются узлы для экспорта }

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseSearchSupportQuery.imp.pas}

function _dsList_.pm_GetCurrent: Il3SimpleNode;
//#UC START# *47F0CE0C02DC_47E9EDA800FEget_var*
//#UC END# *47F0CE0C02DC_47E9EDA800FEget_var*
begin
//#UC START# *47F0CE0C02DC_47E9EDA800FEget_impl*
 Result := f_Current
//#UC END# *47F0CE0C02DC_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetCurrent

procedure _dsList_.pm_SetCurrent(const aValue: Il3SimpleNode);
//#UC START# *47F0CE0C02DC_47E9EDA800FEset_var*
//#UC END# *47F0CE0C02DC_47E9EDA800FEset_var*
begin
//#UC START# *47F0CE0C02DC_47E9EDA800FEset_impl*
 f_Current := aValue
//#UC END# *47F0CE0C02DC_47E9EDA800FEset_impl*
end;//_dsList_.pm_SetCurrent

function _dsList_.pm_GetDocument: IdeDocInfo;
//#UC START# *47F0D13300F7_47E9EDA800FEget_var*
//#UC END# *47F0D13300F7_47E9EDA800FEget_var*
begin
//#UC START# *47F0D13300F7_47E9EDA800FEget_impl*
 Result := f_Document
//#UC END# *47F0D13300F7_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetDocument

procedure _dsList_.pm_SetDocument(const aValue: IdeDocInfo);
//#UC START# *47F0D13300F7_47E9EDA800FEset_var*
//#UC END# *47F0D13300F7_47E9EDA800FEset_var*
begin
//#UC START# *47F0D13300F7_47E9EDA800FEset_impl*
 f_Document := aValue
//#UC END# *47F0D13300F7_47E9EDA800FEset_impl*
end;//_dsList_.pm_SetDocument

function _dsList_.pm_GetPreview: IafwComplexDocumentPreview;
//#UC START# *47F227080106_47E9EDA800FEget_var*
//#UC END# *47F227080106_47E9EDA800FEget_var*
begin
//#UC START# *47F227080106_47E9EDA800FEget_impl*
 Result := f_Preview
//#UC END# *47F227080106_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetPreview

procedure _dsList_.pm_SetPreview(const aValue: IafwComplexDocumentPreview);
//#UC START# *47F227080106_47E9EDA800FEset_var*
//#UC END# *47F227080106_47E9EDA800FEset_var*
begin
//#UC START# *47F227080106_47E9EDA800FEset_impl*
 f_Preview := aValue
//#UC END# *47F227080106_47E9EDA800FEset_impl*
end;//_dsList_.pm_SetPreview

function _dsList_.pm_GetPrintFirstLevel: Boolean;
//#UC START# *47F24FFC018E_47E9EDA800FEget_var*
//#UC END# *47F24FFC018E_47E9EDA800FEget_var*
begin
//#UC START# *47F24FFC018E_47E9EDA800FEget_impl*
 Result := f_PrintFirstLevel
//#UC END# *47F24FFC018E_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetPrintFirstLevel

procedure _dsList_.pm_SetPrintFirstLevel(aValue: Boolean);
//#UC START# *47F24FFC018E_47E9EDA800FEset_var*
//#UC END# *47F24FFC018E_47E9EDA800FEset_var*
begin
//#UC START# *47F24FFC018E_47E9EDA800FEset_impl*
 f_PrintFirstLevel := aValue
//#UC END# *47F24FFC018E_47E9EDA800FEset_impl*
end;//_dsList_.pm_SetPrintFirstLevel

function _dsList_.pm_GetRoot: INodeBase;
//#UC START# *47F256CA03E5_47E9EDA800FEget_var*
  procedure lp_GetRoot;
  var
   l_Root: INodeBase;
  begin
   try
    ImpList.GetRoot(l_Root);
    try
     RootManager.RootNode := l_Root;
    finally
     l_Root := nil;
    end;//try..finally
   except
    on ECanNotFindData do
   end;{try..except}
  end;//lp_GetRoot
//#UC END# *47F256CA03E5_47E9EDA800FEget_var*
begin
//#UC START# *47F256CA03E5_47E9EDA800FEget_impl*
 if Assigned(ImpList) and not Assigned(RootManager.RootNode) then
 begin
  lp_GetRoot;
  if Assigned(RootManager.RootNode) then
   RootIsMaked;
 end;//if Assigned(ImpList)
 Result := RootManager.RootNode;
//#UC END# *47F256CA03E5_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetRoot

function _dsList_.pm_GetListNode: INodeBase;
//#UC START# *47F4E70C005E_47E9EDA800FEget_var*
//#UC END# *47F4E70C005E_47E9EDA800FEget_var*
begin
//#UC START# *47F4E70C005E_47E9EDA800FEget_impl*
 Supports(Current, INodeBase, Result);
//#UC END# *47F4E70C005E_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetListNode

function _dsList_.pm_GetCurrentEntryInfo: IListEntryInfo;
//#UC START# *47F4F3410242_47E9EDA800FEget_var*
//#UC END# *47F4F3410242_47E9EDA800FEget_var*
begin
//#UC START# *47F4F3410242_47E9EDA800FEget_impl*
 Result := f_CurrentEntryInfo;
//#UC END# *47F4F3410242_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetCurrentEntryInfo

procedure _dsList_.pm_SetCurrentEntryInfo(const aValue: IListEntryInfo);
//#UC START# *47F4F3410242_47E9EDA800FEset_var*
//#UC END# *47F4F3410242_47E9EDA800FEset_var*
begin
//#UC START# *47F4F3410242_47E9EDA800FEset_impl*
 f_CurrentEntryInfo := aValue;
//#UC END# *47F4F3410242_47E9EDA800FEset_impl*
end;//_dsList_.pm_SetCurrentEntryInfo

function _dsList_.pm_GetImpList: IDynList;
//#UC START# *47FAE9AE03A3_47E9EDA800FEget_var*
//#UC END# *47FAE9AE03A3_47E9EDA800FEget_var*
begin
//#UC START# *47FAE9AE03A3_47E9EDA800FEget_impl*
 Result := f_ImpList
//#UC END# *47FAE9AE03A3_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetImpList

procedure _dsList_.pm_SetImpList(const aValue: IDynList);
//#UC START# *47FAE9AE03A3_47E9EDA800FEset_var*
//#UC END# *47FAE9AE03A3_47E9EDA800FEset_var*
begin
//#UC START# *47FAE9AE03A3_47E9EDA800FEset_impl*
 f_ImpList := aValue
//#UC END# *47FAE9AE03A3_47E9EDA800FEset_impl*
end;//_dsList_.pm_SetImpList

function _dsList_.pm_GetSearchInfo: IdeSearchInfo;
//#UC START# *482297350070_47E9EDA800FEget_var*
//#UC END# *482297350070_47E9EDA800FEget_var*
begin
//#UC START# *482297350070_47E9EDA800FEget_impl*
 Result := f_SearchInfo
//#UC END# *482297350070_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetSearchInfo

function _dsList_.pm_GetRootManager: TnsRootManager;
//#UC START# *491DD1E703B5_47E9EDA800FEget_var*
//#UC END# *491DD1E703B5_47E9EDA800FEget_var*
begin
//#UC START# *491DD1E703B5_47E9EDA800FEget_impl*
 if (f_RootManager = nil) then
 begin
  f_RootManager := TnsRootManager.Create;
  Il3ChangeNotifier(f_RootManager).Subscribe(Il3ItemNotifyRecipient(Self));
 end;//f_RootManager = nil
 Result := f_RootManager;
//#UC END# *491DD1E703B5_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetRootManager

function _dsList_.MakeDocInfo(const aNode: INodeBase): IdeDocInfo;
 {* создать информацию о документе по узлу. }
//#UC START# *47F0C98F020C_47E9EDA800FE_var*
//#UC END# *47F0C98F020C_47E9EDA800FE_var*
begin
//#UC START# *47F0C98F020C_47E9EDA800FE_impl*
 CurrentEntryInfo := bsListEntryInfo(aNode);
 Result := nil;
//#UC END# *47F0C98F020C_47E9EDA800FE_impl*
end;//_dsList_.MakeDocInfo

function _dsList_.NotifyAboutChangeCurrent: Boolean;
 {* уведомлять бизнес объект прецедента о смене текущего. }
//#UC START# *47F0D913030D_47E9EDA800FE_var*
//#UC END# *47F0D913030D_47E9EDA800FE_var*
begin
//#UC START# *47F0D913030D_47E9EDA800FE_impl*
 Result := False;
//#UC END# *47F0D913030D_47E9EDA800FE_impl*
end;//_dsList_.NotifyAboutChangeCurrent

function _dsList_.DocumentPreview(aOnlyFirstLevel: Boolean = True): IafwDocumentPreview;
 {* - предварительный просмотр списка. }
//#UC START# *47F23393016B_47E9EDA800FE_var*
var
 l_Event: InsEventHolder;
//#UC END# *47F23393016B_47E9EDA800FE_var*
begin
//#UC START# *47F23393016B_47E9EDA800FE_impl*
 Result := nil;
 if not pm_GetIsListEmpty then
 begin
  Result := TnsDocumentPreview.Make(
             TnsIListDataObject.Make(ImpList, aOnlyFirstLevel),
             evDefaultPreviewCacheKey,
             TnsHAFPainter.Make(TnsListHAFMacroReplacer.Make(nil, ImpList)));
  if Supports(Result, InsEventHolder, l_Event) then
   l_Event.SetEvent(TnsListPrintEvent.Make(pm_GetList, Root.GetChildCount, False));
 end;
//#UC END# *47F23393016B_47E9EDA800FE_impl*
end;//_dsList_.DocumentPreview

procedure _dsList_.ResetChildrenCount;
 {* - очищаем кеши при изменении дерева. }
//#UC START# *47F2441D01B8_47E9EDA800FE_var*
//#UC END# *47F2441D01B8_47E9EDA800FE_var*
begin
//#UC START# *47F2441D01B8_47E9EDA800FE_impl*
  Current := nil;
  Preview := nil;
//#UC END# *47F2441D01B8_47E9EDA800FE_impl*
end;//_dsList_.ResetChildrenCount

function _dsList_.InfoPreview: IafwDocumentPreview;
 {* - }
//#UC START# *47F249D10121_47E9EDA800FE_var*
var
 l_String : IString;
//#UC END# *47F249D10121_47E9EDA800FE_var*
begin
//#UC START# *47F249D10121_47E9EDA800FE_impl*
 Result := nil;
 if not pm_GetIsListEmpty then
 begin
  ImpList.GetHistory(l_String);
  try
   Result := nil;
   TnsDocumentPreview.Make(
           TevHTMLDataObject.Make(Tl3StringStream.Make(nsWStr(l_String))),
           evDefaultPreviewCacheKey,
           TnsHAFPainter.Make(TevFormatHAFMacroReplacer.Make(TnsListHAFMacroReplacer.Make(nil, ImpList), str_nevmmReference.AsCStr)));
  finally
   l_String := nil;
  end;//try..finally
 end;//l_List <> nil
//#UC END# *47F249D10121_47E9EDA800FE_impl*
end;//_dsList_.InfoPreview

procedure _dsList_.RootIsMaked;
 {* - вызывается при получении корня у списка. }
//#UC START# *47F257CF00B6_47E9EDA800FE_var*
//#UC END# *47F257CF00B6_47E9EDA800FE_var*
begin
//#UC START# *47F257CF00B6_47E9EDA800FE_impl*
//#UC END# *47F257CF00B6_47E9EDA800FE_impl*
end;//_dsList_.RootIsMaked

function _dsList_.DoOpenDocument(out theDataInfo: IdeDocInfo): Boolean;
 {* - возвращает SDS для открытия сборки документ. }
//#UC START# *47F2661502C9_47E9EDA800FE_var*
//#UC END# *47F2661502C9_47E9EDA800FE_var*
begin
//#UC START# *47F2661502C9_47E9EDA800FE_impl*
 theDataInfo := nil;
 // Документ не может быть получен, выведем информацию:
 if (Document = nil) then
 begin
  Result := False;
  TbsDocumentMissingMessage.Show;
 end//Document = nil
 else
 begin
  Result := True;
  // Откроем документ:
  theDataInfo := Document.Clone;
  // Нам нужно это присвоение, потому что после пересортировки IsSame на
  // старом и новом узле скажет True, но нам нужен самый свежий узел:
  theDataInfo.InitListNode(Root, RightListNode);
 end;//Document = nil
//#UC END# *47F2661502C9_47E9EDA800FE_impl*
end;//_dsList_.DoOpenDocument

function _dsList_.DataForNewList(const aNewList: IDynList;
 aAllDocumentsFiltered: Boolean = False): IdeList;
 {* - данные для открытия списка в новом окне. }
//#UC START# *47F33B990105_47E9EDA800FE_var*
//#UC END# *47F33B990105_47E9EDA800FE_var*
begin
//#UC START# *47F33B990105_47E9EDA800FE_impl*
 Result := TdeList.Make(aNewList, true, wdAlwaysOpen, nil, nil,
  aAllDocumentsFiltered, False);
//#UC END# *47F33B990105_47E9EDA800FE_impl*
end;//_dsList_.DataForNewList

function _dsList_.DoIsTimeMachineEnable: Boolean;
 {* - доступна ли работа с машиной времени. }
//#UC START# *47F48E08017C_47E9EDA800FE_var*
//#UC END# *47F48E08017C_47E9EDA800FE_var*
begin
//#UC START# *47F48E08017C_47E9EDA800FE_impl*
 Result := False;
//#UC END# *47F48E08017C_47E9EDA800FE_impl*
end;//_dsList_.DoIsTimeMachineEnable

function _dsList_.NeedTimeMachineOff: Boolean;
 {* - при открытии списка необходимо выключить машину времени. }
//#UC START# *47F48E3D029F_47E9EDA800FE_var*
//#UC END# *47F48E3D029F_47E9EDA800FE_var*
begin
//#UC START# *47F48E3D029F_47E9EDA800FE_impl*
 Result := True;
//#UC END# *47F48E3D029F_47E9EDA800FE_impl*
end;//_dsList_.NeedTimeMachineOff

procedure _dsList_.DoUpdateListInfo;
 {* - обновить информацию о списке. }
//#UC START# *47F4BDDB026E_47E9EDA800FE_var*
//#UC END# *47F4BDDB026E_47E9EDA800FE_var*
begin
//#UC START# *47F4BDDB026E_47E9EDA800FE_impl*
 Assert(False);
  // - требует реализации в классах наследниках.
//#UC END# *47F4BDDB026E_47E9EDA800FE_impl*
end;//_dsList_.DoUpdateListInfo

function _dsList_.RightListNode: INodeBase;
 {* - даже если нажали на вхождение, то в качестве узла полжен быть           передан узел первого уровня, чтобы преход к пред\следующему            документу работал в списке, а не в ветке. }
//#UC START# *47F4E87D0040_47E9EDA800FE_var*
var
 l_Temp: INodeBase;
//#UC END# *47F4E87D0040_47E9EDA800FE_var*
begin
//#UC START# *47F4E87D0040_47E9EDA800FE_impl*
 Result := ListNode;
 if Assigned(Result) then
 begin
  Result.GetParent(l_Temp);
  try
   while not l_Temp.IsSameNode(Root) do
   begin
    Result := l_Temp;
    Result.GetParent(l_Temp);
   end;//while not l_Node.Parent.IsSame(Root) do
  finally
   l_Temp := nil;
  end;{try..finally}
 end;//if Assigned(Result) then
//#UC END# *47F4E87D0040_47E9EDA800FE_impl*
end;//_dsList_.RightListNode

procedure _dsList_.ClearCurrent;
 {* - очистить информацию о текущем. }
//#UC START# *47F4F4140263_47E9EDA800FE_var*
//#UC END# *47F4F4140263_47E9EDA800FE_var*
begin
//#UC START# *47F4F4140263_47E9EDA800FE_impl*
 Current := nil;
 CurrentEntryInfo := nil;
 Document := nil;
//#UC END# *47F4F4140263_47E9EDA800FE_impl*
end;//_dsList_.ClearCurrent

procedure _dsList_.DoDeleteNodes;
 {* - удалить узлы. Для перекрытия в потомках. }
//#UC START# *47F61AD5022A_47E9EDA800FE_var*
//#UC END# *47F61AD5022A_47E9EDA800FE_var*
begin
//#UC START# *47F61AD5022A_47E9EDA800FE_impl*
 if not pm_GetIsListEmpty and (Root.GetFlagCount(FM_SELECTION) > 0) then
 begin
  ClearCurrent;
  Root.DeleteNodes(FM_SELECTION);
  Preview := nil;
  UpdateListInfo;
 end;//if not pm_GetIsListEmpty
//#UC END# *47F61AD5022A_47E9EDA800FE_impl*
end;//_dsList_.DoDeleteNodes

procedure _dsList_.FinishExporting;
 {* - закончить экспорт. }
//#UC START# *47F61F910350_47E9EDA800FE_var*
//#UC END# *47F61F910350_47E9EDA800FE_var*
begin
//#UC START# *47F61F910350_47E9EDA800FE_impl*
 Root.SetAllFlag(cExportFlag, False);
//#UC END# *47F61F910350_47E9EDA800FE_impl*
end;//_dsList_.FinishExporting

procedure _dsList_.MarkDocumentsForExport(aOnlyFirstLevel: Boolean;
 aOnlySelection: Boolean);
 {* - пометить документы для экспорта. }
//#UC START# *47F620AB0178_47E9EDA800FE_var*

  function lpIterator(const aNode: Il3SimpleNode): Boolean;
  begin
   Result := False;
   MarkNodeForExport(aNode, aOnlyFirstLevel);
  end;//lpIterator

var
 l_Tree: Il3ExpandedSimpleTree;
 l_Flag: Word;
//#UC END# *47F620AB0178_47E9EDA800FE_var*
begin
//#UC START# *47F620AB0178_47E9EDA800FE_impl*
 if not (pm_GetIsListEmpty or not Supports(pm_GetSimpleTree, Il3ExpandedSimpleTree, l_Tree)) then
 try
  if aOnlySelection then
   l_Tree.FlagIterateF(l3L2SNA(@lpIterator), FM_SELECTION)
  else
  begin
   if aOnlyFirstLevel then
    l_Flag := imOneLevel
   else
    l_Flag := 0;
   l_Tree.SimpleIterateF(l3L2SNA(@lpIterator), l_Flag);
  end;
 finally
  l_Tree := nil;
 end;{try..finally}
//#UC END# *47F620AB0178_47E9EDA800FE_impl*
end;//_dsList_.MarkDocumentsForExport

procedure _dsList_.MarkNodeForExport(const aNode: Il3SimpleNode;
 aOnlyFirstLevel: Boolean);
 {* - пометить узел для экспорта. }
//#UC START# *47F9BFED004F_47E9EDA800FE_var*

  function lp_SelectNode: Il3SimpleNode;
  var
   l_SimpleNode: Il3SimpleNode;
  begin
   if aOnlyFirstLevel then
   begin
    l_SimpleNode := aNode;
    while l_SimpleNode.GetLevelFor(pm_GetSimpleTree.RootNode) > 1 do
     l_SimpleNode := l_SimpleNode.Parent;
   end//if aOnlyFirstLevel then
   else
    l_SimpleNode := aNode;
   // http://mdp.garant.ru/pages/viewpage.action?pageId=450293854
   Result := l_SimpleNode;
  end;//lp_SelectNode

var
 l_Node: INodeBase;
//#UC END# *47F9BFED004F_47E9EDA800FE_var*
begin
//#UC START# *47F9BFED004F_47E9EDA800FE_impl*
 if Supports(lp_SelectNode, INodeBase, l_Node) then
  l_Node.SetFlag(cExportFlag, True);
//#UC END# *47F9BFED004F_47E9EDA800FE_impl*
end;//_dsList_.MarkNodeForExport

function _dsList_.DoMakeDocumentPreview(const aDoc: IDocument): IafwComplexDocumentPreview;
 {* - предварительный просмотр для документа. }
//#UC START# *47FA022002B5_47E9EDA800FE_var*
//#UC END# *47FA022002B5_47E9EDA800FE_var*
begin
//#UC START# *47FA022002B5_47E9EDA800FE_impl*
 Result := nsGetDocumentPreview(nsChangeDocumentState(aDoc,
  DefDataAdapter.DocDefaultLang), True, True);
//#UC END# *47FA022002B5_47E9EDA800FE_impl*
end;//_dsList_.DoMakeDocumentPreview

function _dsList_.DoListNodeType(const aNode: INodeBase): TbsListNodeType;
 {* - определить тип узла. }
//#UC START# *47FAF882023E_47E9EDA800FE_var*
var
 l_Node: INodeBase;
//#UC END# *47FAF882023E_47E9EDA800FE_var*
begin
//#UC START# *47FAF882023E_47E9EDA800FE_impl*
 if aNode = nil then
  l_Node := ListNode
 else
  l_Node := aNode;
 if Assigned(l_Node) then
  Result := cbsListNodeTypeMap[TListNodeType(l_Node.GetType)]
 else
  Result := lntDocActive;
//#UC END# *47FAF882023E_47E9EDA800FE_impl*
end;//_dsList_.DoListNodeType

function _dsList_.DoOpenListFromSelectedNodes: IdeList;
 {* - открыть список из выделенных элементов. }
//#UC START# *47FAFE6F010D_47E9EDA800FE_var*
//#UC END# *47FAFE6F010D_47E9EDA800FE_var*
begin
//#UC START# *47FAFE6F010D_47E9EDA800FE_impl*
 Result := TdeList.Make(NewListFromSelected);
//#UC END# *47FAFE6F010D_47E9EDA800FE_impl*
end;//_dsList_.DoOpenListFromSelectedNodes

function _dsList_.DoIsMain: Boolean;
 {* - определяет список в основной зоне приложения. }
//#UC START# *47FB00640212_47E9EDA800FE_var*
//#UC END# *47FB00640212_47E9EDA800FE_var*
begin
//#UC START# *47FB00640212_47E9EDA800FE_impl*
 Result := False;
//#UC END# *47FB00640212_47E9EDA800FE_impl*
end;//_dsList_.DoIsMain

function _dsList_.DoApplyLogicOperation(const aList: IDynList;
 aOperation: TListLogicOperation): Boolean;
 {* - выполнить логическую операцию со списком. }
//#UC START# *47FB05B90024_47E9EDA800FE_var*
//#UC END# *47FB05B90024_47E9EDA800FE_var*
begin
//#UC START# *47FB05B90024_47E9EDA800FE_impl*
 if (ImpList <> nil) and (aList <> nil) and
  (ImpList.GetContentType = aList.GetContentType) then
 begin
  try
   case aOperation of
    LLO_OR:
     ImpList.MergeTree(aList);
    LLO_AND_NOT:
     ImpList.MinusTree(aList);
    LLO_AND:
     ImpList.IntersectTree(aList);
   end;//case aOperation of
   f_AllDocumentFiltered := False;
  except
   on EAllContentIsFiltered do
    f_AllDocumentFiltered := True;
  end;//try..except
  ClearCurrent;
  pm_SetSimpleTree(nil);
  Result := true;
 end//ImpList <> nil
 else
  Result := false;
//#UC END# *47FB05B90024_47E9EDA800FE_impl*
end;//_dsList_.DoApplyLogicOperation

function _dsList_.CanCreateBookmark: Boolean;
 {* - можно ли создать закладку на текущий документ }
//#UC START# *48034E6A01DD_47E9EDA800FE_var*
//#UC END# *48034E6A01DD_47E9EDA800FE_var*
begin
//#UC START# *48034E6A01DD_47E9EDA800FE_impl*
 Result := ListNode <> nil;
//#UC END# *48034E6A01DD_47E9EDA800FE_impl*
end;//_dsList_.CanCreateBookmark

function _dsList_.MakeDocumentFromBookmark: IDocument;
 {* - получить документ для создания закладки. }
//#UC START# *48034E86029A_47E9EDA800FE_var*
//#UC END# *48034E86029A_47E9EDA800FE_var*
begin
//#UC START# *48034E86029A_47E9EDA800FE_impl*
 Result := Document.Doc;
//#UC END# *48034E86029A_47E9EDA800FE_impl*
end;//_dsList_.MakeDocumentFromBookmark

procedure _dsList_.DoSetupNewSimpleTree(const aTree: Il3SimpleTree);
//#UC START# *4A4074FB0192_47E9EDA800FE_var*
//#UC END# *4A4074FB0192_47E9EDA800FE_var*
begin
//#UC START# *4A4074FB0192_47E9EDA800FE_impl*
// Do Nothing
//#UC END# *4A4074FB0192_47E9EDA800FE_impl*
end;//_dsList_.DoSetupNewSimpleTree

function _dsList_.CheckFullList: Boolean;
//#UC START# *4BFA427801B4_47E9EDA800FE_var*
//#UC END# *4BFA427801B4_47E9EDA800FE_var*
begin
//#UC START# *4BFA427801B4_47E9EDA800FE_impl*
 Result := False;
//#UC END# *4BFA427801B4_47E9EDA800FE_impl*
end;//_dsList_.CheckFullList

procedure _dsList_.ApplyFilters;
//#UC START# *525805880132_47E9EDA800FE_var*

 procedure lp_ApplyPermanentFilters;
 var
  l_Filterable : IFilterable;
  l_Filters    : IFiltersFromQuery;
 begin
  f_ActiveFilters := DefDataAdapter.NativeAdapter.MakeFiltersFromQuery;
  if ImpList = nil then
   Exit;

  l_Filters := GetPermanentFilters;
  if (l_Filters <> nil) AND (l_Filters.Count > 0) then
  begin
   CheckFullList;
   if Supports(f_ImpList, IFilterable, l_Filterable) then
   begin
    LoadActiveFilters(l_Filters);
    try
     l_Filterable.ApplyFilters(l_Filters);
     f_AllDocumentFiltered := False;
    except
     on EAllContentIsFiltered do
      f_AllDocumentFiltered := True;
     on ECannotFindData do
      f_AllDocumentFiltered := True;
    end;//try..except
   end;//Supports(f_ImpList, IFilterable, l_Filterable)
  end;//if (l_Filters.Count > 0) and
 end;//lp_ApplyPermanentFilters

var
 l_Filterable    : IFilterable;
 l_ActiveFilters : IFiltersFromQuery;
//#UC END# *525805880132_47E9EDA800FE_var*
begin
//#UC START# *525805880132_47E9EDA800FE_impl*
 // Применям фильтры здесь, а не в GotData потому, что
 // http://mdp.garant.ru/pages/viewpage.action?pageId=492601505

 // Применим постоянные фильтры:
 if NeedApplyPermanentFilters then lp_ApplyPermanentFilters;
//#UC END# *525805880132_47E9EDA800FE_impl*
end;//_dsList_.ApplyFilters

procedure _dsList_.LoadActiveFilters(const aFilters: IFiltersFromQuery);
//#UC START# *525BC48802E6_47E9EDA800FE_var*
var
 l_Index  : Integer;
 l_Filter : IFilterFromQuery;
//#UC END# *525BC48802E6_47E9EDA800FE_var*
begin
//#UC START# *525BC48802E6_47E9EDA800FE_impl*
 f_ActiveFilters := DefDataAdapter.NativeAdapter.MakeFiltersFromQuery;
 if (aFilters <> nil) and (aFilters.Count > 0) then
  for l_Index := 0 to Pred(aFilters.Count) do
  begin
   aFilters.pm_GetItem(l_Index, l_Filter);
   f_ActiveFilters.Add(l_Filter);
  end;//for l_Index := 0 to Pred(l_Count) do
//#UC END# *525BC48802E6_47E9EDA800FE_impl*
end;//_dsList_.LoadActiveFilters

function _dsList_.GetPermanentFilters: IFiltersFromQuery;
//#UC START# *52AEBAB800BF_47E9EDA800FE_var*
var
 l_Filters: IFiltersFromQuery;
 l_Index: Integer;
 l_Filter: IFilterFromQuery;
//#UC END# *52AEBAB800BF_47E9EDA800FE_var*
begin
//#UC START# *52AEBAB800BF_47E9EDA800FE_impl*
 Result := DefDataAdapter.NativeAdapter.MakeFiltersFromQuery;
 case pm_GetListType of
  bs_ltDocument: DefDataAdapter.NativeAdapter.MakeFiltersManager.GetLegalFilters(l_Filters);
  bs_ltDrug: DefDataAdapter.NativeAdapter.MakeFiltersManager.GetPharmFilters(l_Filters);
 end;
 for l_Index := 0 to l_Filters.Count - 1 do
 begin
  l_Filters.pm_GetItem(l_Index, l_Filter);
  if l_Filter.GetPermanent then
   Result.Add(l_Filter);
 end;
//#UC END# *52AEBAB800BF_47E9EDA800FE_impl*
end;//_dsList_.GetPermanentFilters

function _dsList_.NeedApplyPermanentFilters: Boolean;
//#UC START# *52AEBF77037F_47E9EDA800FE_var*
//#UC END# *52AEBF77037F_47E9EDA800FE_var*
begin
//#UC START# *52AEBF77037F_47E9EDA800FE_impl*
 Result := ((f_SearchInfo = nil) or f_SearchInfo.NeedApplyPermanentFilters) {and
  f_InitialNeedApplyPermanentFilters};
//#UC END# *52AEBF77037F_47E9EDA800FE_impl*
end;//_dsList_.NeedApplyPermanentFilters

function _dsList_.As_IucbBaseSearchSupportQuery: IucbBaseSearchSupportQuery;
 {* Метод приведения нашего интерфейса к IucbBaseSearchSupportQuery }
begin
 Result := Self;
end;//_dsList_.As_IucbBaseSearchSupportQuery

procedure _dsList_.Notify(const aNotifier: Il3ChangeNotifier;
 aOperation: Integer;
 aIndex: Integer);
 {* прошла операция. }
//#UC START# *46A4504B03C4_47E9EDA800FE_var*
//#UC END# *46A4504B03C4_47E9EDA800FE_var*
begin
//#UC START# *46A4504B03C4_47E9EDA800FE_impl*
 if aOperation = nne_ResetChildrenCount then
  ResetChildrenCount;
//#UC END# *46A4504B03C4_47E9EDA800FE_impl*
end;//_dsList_.Notify

function _dsList_.pm_GetIsSaved: Boolean;
//#UC START# *47F1E425028C_47E9EDA800FEget_var*
//#UC END# *47F1E425028C_47E9EDA800FEget_var*
begin
//#UC START# *47F1E425028C_47E9EDA800FEget_impl*
 Result := bsIsListSaved(ImpList);
//#UC END# *47F1E425028C_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetIsSaved

function _dsList_.pm_GetListName: Il3CString;
//#UC START# *47F1E48F03C7_47E9EDA800FEget_var*
//#UC END# *47F1E48F03C7_47E9EDA800FEget_var*
begin
//#UC START# *47F1E48F03C7_47E9EDA800FEget_impl*
 Result := bsListName(ImpList);
//#UC END# *47F1E48F03C7_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetListName

function _dsList_.pm_GetShortListName: Il3CString;
//#UC START# *47F1E4A901C7_47E9EDA800FEget_var*
//#UC END# *47F1E4A901C7_47E9EDA800FEget_var*
begin
//#UC START# *47F1E4A901C7_47E9EDA800FEget_impl*
 Result := bsShortListName(ImpList);
//#UC END# *47F1E4A901C7_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetShortListName

function _dsList_.pm_GetIsChanged: Boolean;
//#UC START# *47F1E7000276_47E9EDA800FEget_var*
//#UC END# *47F1E7000276_47E9EDA800FEget_var*
begin
//#UC START# *47F1E7000276_47E9EDA800FEget_impl*
 Result := bsIsListChanged(ImpList);
//#UC END# *47F1E7000276_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetIsChanged

function _dsList_.pm_GetIsFiltered: Boolean;
//#UC START# *47F1E722039F_47E9EDA800FEget_var*
//#UC END# *47F1E722039F_47E9EDA800FEget_var*
begin
//#UC START# *47F1E722039F_47E9EDA800FEget_impl*
 Result := False;
 if Assigned(ImpList) then
  Result := f_AllDocumentFiltered or ImpList.GetIsFiltered;
//#UC END# *47F1E722039F_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetIsFiltered

procedure _dsList_.UpdatePreview;
 {* - обновить предварительный просмотр. }
//#UC START# *47F1EDFC0318_47E9EDA800FE_var*
//#UC END# *47F1EDFC0318_47E9EDA800FE_var*
begin
//#UC START# *47F1EDFC0318_47E9EDA800FE_impl*
 if (Preview <> nil) then
 begin
  Preview.SetDocument(DocumentPreview);
  Preview.SetInfo(InfoPreview);
 end;//Preview <> nil
//#UC END# *47F1EDFC0318_47E9EDA800FE_impl*
end;//_dsList_.UpdatePreview

function _dsList_.MakePreview(aOnlyFirstLevel: Boolean = True): IafwComplexDocumentPreview;
 {* - формирует preview для списка. }
//#UC START# *47F1EE480019_47E9EDA800FE_var*
var
 l_Selection: IafwDocumentPreview;
 l_Nodes: INodesClipboard;
 l_Event: InsEventHolder;
//#UC END# *47F1EE480019_47E9EDA800FE_var*
begin
//#UC START# *47F1EE480019_47E9EDA800FE_impl*
 if (Preview = nil) or (PrintFirstLevel <> aOnlyFirstLevel) then
 begin
  Preview := TafwComplexDocumentPreview.Make(DocumentPreview(aOnlyFirstLevel),
                                              InfoPreview);
  PrintFirstLevel := aOnlyFirstLevel;
 end;
 if Root.GetFlagCount(FM_SELECTION) > 1 then
 begin
  l_Selection := nil;
  if not pm_GetIsListEmpty then
  begin
   Root.CopyNodes(FM_SELECTION, l_Nodes);
   l_Selection := TnsDocumentPreview.Make(
              TnsINodesClipboardDataObject.Make(l_Nodes, aOnlyFirstLevel),
              evDefaultPreviewCacheKey,
              TnsHAFPainter.Make(TevFormatHAFMacroReplacer.Make(TnsListHAFMacroReplacer.Make(nil, ImpList), vcmCStr(str_SaveSelectedListPrefix))));
   if Supports(l_Selection, InsEventHolder, l_Event) then
    l_Event.SetEvent(TnsListPrintEvent.Make(pm_GetList, Root.GetFlagCount(FM_SELECTION), True));
  end;
  Preview.SetSelection(l_Selection);
  if Assigned(l_Selection) then
   Preview.ContentKind := afw_pckSelection
  else
   Preview.ContentKind := afw_pckDocument;
 end
 else
 begin
  Preview.SetSelection(nil);
  Preview.ContentKind := afw_pckDocument;
 end;
 Result := Preview;
//#UC END# *47F1EE480019_47E9EDA800FE_impl*
end;//_dsList_.MakePreview

function _dsList_.OpenDocument(out theDataInfo: IdeDocInfo): Boolean;
 {* - возвращает SDS для открытия сборки документ. }
//#UC START# *47F1EE960312_47E9EDA800FE_var*
//#UC END# *47F1EE960312_47E9EDA800FE_var*
begin
//#UC START# *47F1EE960312_47E9EDA800FE_impl*
 Result := DoOpenDocument(theDataInfo);
//#UC END# *47F1EE960312_47E9EDA800FE_impl*
end;//_dsList_.OpenDocument

function _dsList_.NewListFromSelected: IDynList;
 {* - создать новый список из выделенных. }
//#UC START# *47F1EF0403E7_47E9EDA800FE_var*
var
 l_Nodes : INodesClipboard;
 l_CBase : ICatalogBase;
//#UC END# *47F1EF0403E7_47E9EDA800FE_var*
begin
//#UC START# *47F1EF0403E7_47E9EDA800FE_impl*
 Result := nil;
 if not pm_GetIsListEmpty then
 begin
  Root.CopyNodes(FM_SELECTION, l_Nodes);
  try
   ImpList.Create(l_Nodes, l_CBase);
   Supports(l_CBase, IDynList, Result);
   bsMakeNewListName(ImpList, Result, Root.GetFlagCount(FM_SELECTION));
  finally
   l_Nodes := nil;
  end;{try..finally}
 end;//if not pm_GetIsListEmpty then
//#UC END# *47F1EF0403E7_47E9EDA800FE_impl*
end;//_dsList_.NewListFromSelected

function _dsList_.pm_GetIsListEmpty: Boolean;
//#UC START# *47F272B40292_47E9EDA800FEget_var*
//#UC END# *47F272B40292_47E9EDA800FEget_var*
begin
//#UC START# *47F272B40292_47E9EDA800FEget_impl*
// if (ImpList <> nil) and (RootManager <> nil) and
//    (RootManager.RootNode = nil) then
//  pm_GetRoot;
//  - http://mdp.garant.ru/pages/viewpage.action?pageId=606109792

 Result := f_AllDocumentFiltered or (not ((ImpList <> nil) and
           (RootManager.RootNode <> nil) and RootManager.RootNode.HasChildren));
//#UC END# *47F272B40292_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetIsListEmpty

function _dsList_.NewList: IdeList;
 {* - открыть список в окне. }
//#UC START# *47F32E5D01B0_47E9EDA800FE_var*
var
 l_NewList: IDynList;
 l_AllDocumentsFiltered: Boolean;
//#UC END# *47F32E5D01B0_47E9EDA800FE_var*
begin
//#UC START# *47F32E5D01B0_47E9EDA800FE_impl*
 Result := nil;
 l_AllDocumentsFiltered := False;
 try
  l_NewList := bsListClone(ImpList);
  Assert(l_NewList <> nil);
  l_AllDocumentsFiltered := bsIsListEmpty(l_NewList) and
   l_NewList.GetIsFiltered and f_AllDocumentFiltered;
 except
  on EAllContentIsFiltered do
   l_AllDocumentsFiltered := True;
 end;
 if Assigned(l_NewList) then
 try
  Result := DataForNewList(l_NewList, l_AllDocumentsFiltered);
 finally
  l_NewList := nil;
 end;{try..finally}
//#UC END# *47F32E5D01B0_47E9EDA800FE_impl*
end;//_dsList_.NewList

function _dsList_.pm_GetIsTimeMachineEnable: Boolean;
//#UC START# *47F48D7C028E_47E9EDA800FEget_var*
//#UC END# *47F48D7C028E_47E9EDA800FEget_var*
begin
//#UC START# *47F48D7C028E_47E9EDA800FEget_impl*
 Result := DoIsTimeMachineEnable;
//#UC END# *47F48D7C028E_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetIsTimeMachineEnable

function _dsList_.pm_GetTimeMachineOff: Boolean;
//#UC START# *47F48DF603AF_47E9EDA800FEget_var*
//#UC END# *47F48DF603AF_47E9EDA800FEget_var*
begin
//#UC START# *47F48DF603AF_47E9EDA800FEget_impl*
 Result := pm_GetIsMain and NeedTimeMachineOff;
//#UC END# *47F48DF603AF_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetTimeMachineOff

procedure _dsList_.UpdateListInfo;
 {* - обновляет информацию о списке. }
//#UC START# *47F4BC8000F0_47E9EDA800FE_var*
//#UC END# *47F4BC8000F0_47E9EDA800FE_var*
begin
//#UC START# *47F4BC8000F0_47E9EDA800FE_impl*
 DoUpdateListInfo;
//#UC END# *47F4BC8000F0_47E9EDA800FE_impl*
end;//_dsList_.UpdateListInfo

function _dsList_.MakeSimpleTree: Il3SimpleTree;
 {* Создать данные дерева }
//#UC START# *47F4C2B9014A_47E9EDA800FE_var*
var
 l_ListTreeStruct: TbsListTreeStruct;
//#UC END# *47F4C2B9014A_47E9EDA800FE_var*
begin
//#UC START# *47F4C2B9014A_47E9EDA800FE_impl*
 Result := nil;
 if (ImpList <> nil) then
 begin
  RootManager.RootNode := nil;
  // Обновим справку к документу
  if not IsFirstMake then
  begin
   Result := TbsListTreeStruct.Make(Root, False);
   UpdateListInfo;
  end
  else
  begin
   // Применям фильтры здесь, а не в GotData потому, что
   // http://mdp.garant.ru/pages/viewpage.action?pageId=492601505
   ApplyFilters;
   Result := TbsListTreeStruct.Make(Root, False);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=506709931
   DoSetupNewSimpleTree(Result);
  end;
  // Обновим предварительный просмотр
  Preview := nil;
 end;//if (ImpList <> nil) then
//#UC END# *47F4C2B9014A_47E9EDA800FE_impl*
end;//_dsList_.MakeSimpleTree

function _dsList_.pm_GetListType: TbsListType;
//#UC START# *47F5C5050227_47E9EDA800FEget_var*
//#UC END# *47F5C5050227_47E9EDA800FEget_var*
begin
//#UC START# *47F5C5050227_47E9EDA800FEget_impl*
 Result := bsListType(ImpList);
//#UC END# *47F5C5050227_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetListType

function _dsList_.CheckList(const aTree: Il3SimpleTree): Boolean;
 {* - определяет содержит ли aControl список. }
//#UC START# *47F60913013E_47E9EDA800FE_var*
//#UC END# *47F60913013E_47E9EDA800FE_var*
begin
//#UC START# *47F60913013E_47E9EDA800FE_impl*
 Result := Supports(aTree, IDynList);
//#UC END# *47F60913013E_47E9EDA800FE_impl*
end;//_dsList_.CheckList

function _dsList_.ApplyFilter(const aFilter: IFilterFromQuery;
 aAdd: Boolean = False): Boolean;
 {* - применить\отменить фильтр. }
//#UC START# *47F60D510152_47E9EDA800FE_var*

  procedure lp_UpdateSimpleTree;
   {* Необходимо передать контекстный фильтр, чтобы не получилось, что после
      применения фильтра-запроса, контекст окрасится красным цветом. }
  var
   l_Tree    : Il3FilterableTree;
   l_IntTree : InsInternalFilterableTree;
  begin
   // Получим информацию о фильтрах дерева:
   Supports(pm_GetSimpleTree, Il3FilterableTree, l_Tree);
   // Обнулим дерево, для получения нового TreeStruct:
   pm_SetSimpleTree(nil);
   // Обновим фильтры:
   if (l_Tree <> nil) and
     Supports(pm_GetSimpleTree, InsInternalFilterableTree, l_IntTree) then
    l_IntTree.SetFilters(l_Tree.CloneFilters);
  end;

var
 l_Filterable: IFilterable;

  procedure lp_DeleteFromActiveFilters;
  var
   l_Index: Integer;
   l_Filter: IFilterFromQuery;
  begin
   l_Index := 0;
   while l_Index < f_ActiveFilters.Count do
   begin
    f_ActiveFilters.pm_GetItem(l_Index, l_Filter);
    if l_Filter.IsSame(aFilter) then
     f_ActiveFilters.Delete(l_Index)
    else
     Inc(l_Index);
   end;//while l_Index < f_ActiveFilters.Count
  end;//lp_DeleteFromActiveFilters

  procedure lp_DeleteFilter;
  begin
   lp_DeleteFromActiveFilters;
   try
    l_Filterable.DeleteFilter(aFilter, True);
    l_Filterable.ApplyFilters(f_ActiveFilters);
    f_AllDocumentFiltered := False;
   except
    on EAllContentIsFiltered do
     f_AllDocumentFiltered := True;
   end;//try..except
  end;//lp_DeleteFilter

  function lp_AddFilter: Boolean;

   function lp_HasFilter: Boolean;
   var
    l_Index : Integer;
    l_Filter: IFilterFromQuery;
   begin
    for l_Index := 0 to Pred(f_ActiveFilters.Count) do
    begin
     f_ActiveFilters.pm_GetItem(l_Index, l_Filter);
     if l_Filter.IsSame(aFilter) then
     begin
      Result := True;
      Exit;
     end;//l_Filter.IsSame(aFilter)
    end;//for l_Index
    Result := False;
   end;

  begin
   if lp_HasFilter then
    Result := False
   else
   begin
    Result := True;
    f_ActiveFilters.Add(aFilter);
    if not f_AllDocumentFiltered then
    try
     l_Filterable.AddFilter(aFilter, True);
    except
     on EAllContentIsFiltered do
      f_AllDocumentFiltered := True;
     on ENotAllAttributesRestored do
     begin
      lp_DeleteFromActiveFilters;
      raise;
     end;
    end;//try..except
   end;//if lp_HasFilter then
  end;//lp_AddFilter

var
 l_NeedResetTree: Boolean;
 
const
 c_MaxListLengthToFilter = 1000000;
//#UC END# *47F60D510152_47E9EDA800FE_var*
begin
//#UC START# *47F60D510152_47E9EDA800FE_impl*
 Result := False;
 l_NeedResetTree := CheckFullList;

 if not DefDataAdapter.IsInternal then
  if (Assigned(Root) and (Root.GetChildCount > c_MaxListLengthToFilter)) (*or
     (Assigned(ImpList) and (ImpList.GetFullListSize > c_MaxListLengthToFilter))*) then
   raise EListIsTooLong.Create('');

 if Supports(ImpList, IFilterable, l_Filterable) then
 try
  // Добавить:
  if aAdd then
  begin
   Result := lp_AddFilter;
   if not Result  then
    Exit;
  end//if aAdd then
  // Удалить:
  else
   lp_DeleteFilter;
  // Обновим дерево, если фильтры применились:
  if l_NeedResetTree or (not f_AllDocumentFiltered) then
   lp_UpdateSimpleTree;
  Result := True;
 finally
  l_Filterable := nil;
 end;//try..finally
//#UC END# *47F60D510152_47E9EDA800FE_impl*
end;//_dsList_.ApplyFilter

function _dsList_.ClearFilters: Boolean;
 {* - очистить фильтры. }
//#UC START# *47F6121700FE_47E9EDA800FE_var*
var
 l_Filterable    : IFilterable;
 l_ActiveFilters : IFiltersFromQuery;
//#UC END# *47F6121700FE_47E9EDA800FE_var*
begin
//#UC START# *47F6121700FE_47E9EDA800FE_impl*
 Result := False;
 if Supports(ImpList, IFilterable, l_Filterable) then
 try
  f_ActiveFilters := DefDataAdapter.NativeAdapter.MakeFiltersFromQuery;
   // - сбросим список примененных фильтров.
  l_Filterable.GetActiveFilters(l_ActiveFilters);
  if True {(l_ActiveFilters <> nil) and (l_ActiveFilters.Count > 0)} then
  // ^^^ http://mdp.garant.ru/pages/viewpage.action?pageId=294589669
  begin
    try
      l_Filterable.ClearFilters;
    except
      // http://mdp.garant.ru/pages/viewpage.action?pageId=289276518
      on ECanNotFindData do ;
    end;{try..except}
    f_AllDocumentFiltered := False;
    pm_SetSimpleTree(nil);
    Result := True;
  end//if (l_ActiveFilters <> nil) and (l_ActiveFilters.Count > 0) then
  else
   if f_AllDocumentFiltered then
   begin
    f_AllDocumentFiltered := False;
    Result := True;
   end;//if f_AllDocumentFiltered then
 finally
  l_Filterable := nil;
 end;{try..finally}
//#UC END# *47F6121700FE_47E9EDA800FE_impl*
end;//_dsList_.ClearFilters

procedure _dsList_.DeleteNodes;
 {* - удаляет выбранные узлы. }
//#UC START# *47F6180E0359_47E9EDA800FE_var*
//#UC END# *47F6180E0359_47E9EDA800FE_var*
begin
//#UC START# *47F6180E0359_47E9EDA800FE_impl*
 DoDeleteNodes;
//#UC END# *47F6180E0359_47E9EDA800FE_impl*
end;//_dsList_.DeleteNodes

procedure _dsList_.ExportDocument(const aDocument: IDocument;
 const aFileName: Il3CString;
 aFormat: TnsFileFormat);
 {* - сохранить Указанный документ на диск в указанном формате. }
//#UC START# *47F61C3D03DE_47E9EDA800FE_var*
var
 l_Name: Il3CString;
//#UC END# *47F61C3D03DE_47E9EDA800FE_var*
begin
//#UC START# *47F61C3D03DE_47E9EDA800FE_impl*
 if Assigned(aDocument) then
 begin
  l_Name := aFileName;
  DocumentSaveAs(aDocument, l_Name, True, aFormat);
 end;
//#UC END# *47F61C3D03DE_47E9EDA800FE_impl*
end;//_dsList_.ExportDocument

function _dsList_.ExportDocuments(aOnlyFirstLevel: Boolean;
 aOnlySelection: Boolean;
 const aPath: Il3CString;
 aFormat: TnsFileFormat): Boolean;
 {* - сохранить выделенные документы на диск в указанном формате.
Возвращает признак того, что чего-то сохранили }
//#UC START# *47F61FC00314_47E9EDA800FE_var*
var
 l_Result: Boolean absolute Result;

  function lp_ExportDocument(const aNode: Il3SimpleNode): Boolean;
  var
   l_PathName : Il3CString;
   l_Index    : Integer;
   l_Document : IDocument;
   l_NB       : INodeBase;
  begin
   Result := False;
   if Supports(aNode, INodeBase, l_NB) then
   try
     l_Document := bsExtractDocument(l_NB);
     if (l_Document <> nil) and (l_Document.GetDocType <> DT_FLASH) then
     try
      l_PathName := l3Cat([l3Cat(aPath, '\'), CreateFileName(l_Document)]);
      // Уникальность сохраняемого файла
      if FileExists(l3PStr(l3Cat(l_PathName, nsGetFileFormatExt(aFormat)))) then
      begin
       l_Index := 1;
       while FileExists(l3PStr(l3Cat(l_PathName, IntToStr(l_Index) + nsGetFileFormatExt(aFormat)))) do
        Inc(l_Index);
       l_PathName := l3Cat(l_PathName, IntToStr(l_Index) + nsGetFileFormatExt(aFormat));
      end
      else
       l_PathName := l3Cat(l_PathName, nsGetFileFormatExt(aFormat));
      // Сохраним
      DocumentSaveAs(l_Document, l_PathName, True, aFormat);
      l_Result := True;
     finally
      l_Document := nil
     end;//try..finally
   finally
    l_NB := nil;
   end;//try..finally
  end;

var
 l_Tree: Il3ExpandedSimpleTree;
//#UC END# *47F61FC00314_47E9EDA800FE_var*
begin
//#UC START# *47F61FC00314_47E9EDA800FE_impl*
 Result := False;
 MarkDocumentsForExport(aOnlyFirstLevel, aOnlySelection);
 try
  if Supports(pm_GetSimpleTree, Il3ExpandedSimpleTree, l_Tree) then
   l_Tree.FlagIterateF(l3L2SNA(@lp_ExportDocument), cExportFlag);
 finally
  FinishExporting;
 end;
//#UC END# *47F61FC00314_47E9EDA800FE_impl*
end;//_dsList_.ExportDocuments

function _dsList_.ListAsText(aSaveListKind: TbsSaveListKind;
 SaveSelection: Boolean): IStream;
 {* - получение списка в виде текта.  aOnlyFirstLevel - с\без вхождений. }
//#UC START# *47F9CA3103AC_47E9EDA800FE_var*
var
 l_Selection : INodesClipboard;
//#UC END# *47F9CA3103AC_47E9EDA800FE_var*
begin
//#UC START# *47F9CA3103AC_47E9EDA800FE_impl*
 Result := nil;
 if SaveSelection then
 begin
  Root.CopyNodes(FM_SELECTION, l_Selection);
  try
   l_Selection.AsEVD(bsBusinessToAdapter(aSaveListKind), Result);
  finally
   l_Selection := nil
  end;//try..finally
 end//SaveSelection
 else
 if Assigned(ImpList) then
  ImpList.AsEvd(bsBusinessToAdapter(aSaveListKind), Result);
//#UC END# *47F9CA3103AC_47E9EDA800FE_impl*
end;//_dsList_.ListAsText

function _dsList_.MergeDocuments(aOnlyFirstLevel: Boolean;
 aOnlySelection: Boolean;
 const aFileName: Il3CString;
 aFormat: TnsFileFormat;
 NeedPrintTopic: Boolean = True): Boolean;
 {* - сохранить выделенные документы в один файл в указанном формате. Разделяя, если указано, их фразой "Топик: <внутренний номер документа>".
Возвращает признак того, что чего-то сохранили }
//#UC START# *47F9D29C02D7_47E9EDA800FE_var*
var
 l_Tree : Il3ExpandedSimpleTree;
 l_Documents: TnsDocumentStreamList;

  function lp_ExportDocument(const aNode: Il3SimpleNode): Boolean;
  var
   l_NB       : INodeBase;
   l_Document : IDocument;
  begin
   // Рассмотрим все узлы
   Result := False;
   if Supports(aNode, INodeBase, l_NB) then
   begin
    l_Document := bsExtractDocument(aNode);
    try
     if (l_Document <> nil) and (l_Document.GetDocType <> DT_FLASH) then
      l_Documents.Add(TnsDocumentStreamWrapper.Make(l_Document));
    finally
     l_Document := nil;
    end;
   end;
  end;//lpIterator

//#UC END# *47F9D29C02D7_47E9EDA800FE_var*
begin
//#UC START# *47F9D29C02D7_47E9EDA800FE_impl*
 MarkDocumentsForExport(aOnlyFirstLevel, aOnlySelection);
 try
  if Supports(pm_GetSimpleTree, Il3ExpandedSimpleTree, l_Tree) then
  begin
   // Сохраняем конкретный документ
   l_Documents := TnsDocumentStreamList.Create;
   try
    l_Tree.FlagIterateF(l3L2SNA(@lp_ExportDocument), cExportFlag);
    Result := l_Documents.Count > 0;
    if Result then
     nsSaveMultiplyDocuments(l_Documents, aFileName, aFormat, NeedPrintTopic, True);
   finally
    vcmFree(l_Documents);
   end;
  end
  else
   Result := False;
 finally
  FinishExporting;
 end;
//#UC END# *47F9D29C02D7_47E9EDA800FE_impl*
end;//_dsList_.MergeDocuments

function _dsList_.RefreshFilters: Boolean;
 {* - переприменить фильтры. }
//#UC START# *47F9F86A0108_47E9EDA800FE_var*
var
 l_Filterable    : IFilterable;
 l_ActiveFilters : IFiltersFromQuery;
//#UC END# *47F9F86A0108_47E9EDA800FE_var*
begin
//#UC START# *47F9F86A0108_47E9EDA800FE_impl*
 Result := False;
 if Assigned(ImpList) and Supports(ImpList, IFilterable, l_Filterable) then
 try
  l_Filterable.GetActiveFilters(l_ActiveFilters);
  if Assigned(l_ActiveFilters) then
  try
   if l_ActiveFilters.Count > 0 then
   begin
    try
     l_Filterable.RefreshFilters;
     // Обновим список
     pm_SetSimpleTree(nil);
     Result := True;
    except
     on EAllContentIsFiltered do
      ;
    end;{try..except}
   end;//if l_ActiveFilters.GetCount > 0 then
  finally
   l_ActiveFilters := nil;
  end;{try..finally}
 finally
  l_Filterable := nil;
 end;{try..finally}
//#UC END# *47F9F86A0108_47E9EDA800FE_impl*
end;//_dsList_.RefreshFilters

function _dsList_.IsActiveFilter(const aFilter: IFilterFromQuery): Boolean;
 {* - является ли данный фильтр примененным. }
//#UC START# *47F9FABC001D_47E9EDA800FE_var*
var
 l_Filterable: IFilterable;
 l_ActiveFilters: IFiltersFromQuery;
 i,
 l_Count: LongInt;
 l_Filter: IFilterFromQuery;
//#UC END# *47F9FABC001D_47E9EDA800FE_var*
begin
//#UC START# *47F9FABC001D_47E9EDA800FE_impl*
 Result := False;
 if Assigned(ImpList) and Supports(ImpList, IFilterable, l_Filterable) then
 try
  l_Filterable.GetActiveFilters(l_ActiveFilters);
  if Assigned(l_ActiveFilters) then
  try
   l_Count := l_ActiveFilters.Count;
   if l_Count > 0 then
    for i := 0 to Pred(l_Count) do
    begin
     l_ActiveFilters.pm_GetItem(I, l_Filter);
     Result := aFilter.IsSame(l_Filter);
     if Result then
      break;
    end;//for i := 0 to Pred(l_Count) do
  finally
   l_ActiveFilters := nil;
  end;{try..finally}
 finally
  l_Filterable := nil;
 end;//if Supports(ImpList, IFilterable, l_Filterable) then
//#UC END# *47F9FABC001D_47E9EDA800FE_impl*
end;//_dsList_.IsActiveFilter

function _dsList_.NodeId(const aNode: Il3SimpleNode): Integer;
 {* - получить идентификатор узла. }
//#UC START# *47F9FADF033F_47E9EDA800FE_var*
var
 lNode : INodeBase;
//#UC END# *47F9FADF033F_47E9EDA800FE_var*
begin
//#UC START# *47F9FADF033F_47E9EDA800FE_impl*
 Result := 0;
 if Supports(aNode, INodeBase, lNode) then
 try
  Result := lNode.GetNodeId;
 finally
  lNode := nil;
 end;
//#UC END# *47F9FADF033F_47E9EDA800FE_impl*
end;//_dsList_.NodeId

function _dsList_.MakeDocumentPreview: IafwComplexDocumentPreview;
 {* - предварительный просмотр для текущего документа. }
//#UC START# *47FA0191035A_47E9EDA800FE_var*
//#UC END# *47FA0191035A_47E9EDA800FE_var*
begin
//#UC START# *47FA0191035A_47E9EDA800FE_impl*
 Result := nil;
 if Assigned(Document) then
  Result := DoMakeDocumentPreview(Document.Doc);
//#UC END# *47FA0191035A_47E9EDA800FE_impl*
end;//_dsList_.MakeDocumentPreview

function _dsList_.pm_GetList: IDynList;
//#UC START# *47FA168B01FB_47E9EDA800FEget_var*
//#UC END# *47FA168B01FB_47E9EDA800FEget_var*
begin
//#UC START# *47FA168B01FB_47E9EDA800FEget_impl*
 Result := ImpList;
//#UC END# *47FA168B01FB_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetList

function _dsList_.ListNodeType(const aNode: Il3SimpleNode = nil): TbsListNodeType;
 {* - тип узла списка. }
//#UC START# *47FAF80A0182_47E9EDA800FE_var*
var
 l_Node: INodeBase;
//#UC END# *47FAF80A0182_47E9EDA800FE_var*
begin
//#UC START# *47FAF80A0182_47E9EDA800FE_impl*
 Supports(aNode, INodeBase, l_Node);
 try
  Result := DoListNodeType(l_Node);
 finally
  l_Node := nil;
 end;
//#UC END# *47FAF80A0182_47E9EDA800FE_impl*
end;//_dsList_.ListNodeType

function _dsList_.OpenListFromSelectedNodes: IdeList;
 {* - открыть список из выделенных элементов. }
//#UC START# *47FAFE3B0226_47E9EDA800FE_var*
//#UC END# *47FAFE3B0226_47E9EDA800FE_var*
begin
//#UC START# *47FAFE3B0226_47E9EDA800FE_impl*
 Result := DoOpenListFromSelectedNodes;
//#UC END# *47FAFE3B0226_47E9EDA800FE_impl*
end;//_dsList_.OpenListFromSelectedNodes

function _dsList_.pm_GetIsMain: Boolean;
//#UC START# *47FB001703CE_47E9EDA800FEget_var*
//#UC END# *47FB001703CE_47E9EDA800FEget_var*
begin
//#UC START# *47FB001703CE_47E9EDA800FEget_impl*
 Result := DoIsMain;
//#UC END# *47FB001703CE_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetIsMain

function _dsList_.ApplyLogicOperation(const aList: IDynList;
 aOperation: TListLogicOperation): Boolean;
 {* - выполнить логическую операцию со списком. }
//#UC START# *47FB059C02A3_47E9EDA800FE_var*
//#UC END# *47FB059C02A3_47E9EDA800FE_var*
begin
//#UC START# *47FB059C02A3_47E9EDA800FE_impl*
 Result := DoApplyLogicOperation(aList, aOperation);
//#UC END# *47FB059C02A3_47E9EDA800FE_impl*
end;//_dsList_.ApplyLogicOperation

function _dsList_.ApplyContextFilter(const aFilter: IContextFilter): INodeBase;
 {* - применить контекстный фильтр. }
//#UC START# *47FC76D302A2_47E9EDA800FE_var*
//#UC END# *47FC76D302A2_47E9EDA800FE_var*
begin
//#UC START# *47FC76D302A2_47E9EDA800FE_impl*
 Result := nil;
 if ImpList <> nil then
 begin
  ImpList.SetContextFilter(aFilter);
  RootManager.RootNode := nil;
  Result := Root;
 end;//if ImpList <> nil then
//#UC END# *47FC76D302A2_47E9EDA800FE_impl*
end;//_dsList_.ApplyContextFilter

procedure _dsList_.SaveToFile(const aFileName: Tl3WString;
 aOnlySelected: Boolean);
 {* - при не успешном завершении возвращает ECannotSave. }
//#UC START# *47FC90B50037_47E9EDA800FE_var*
var
 l_Nodes: INodesClipboard;
//#UC END# *47FC90B50037_47E9EDA800FE_var*
begin
//#UC START# *47FC90B50037_47E9EDA800FE_impl*
 if not pm_GetIsListEmpty then
 begin
  if aOnlySelected and (Root.GetFlagCount(FM_SELECTION) > 0) then
   Root.CopyNodes(FM_SELECTION, l_Nodes);
  ImpList.SaveToFile(nsAStr(aFileName).S, l_Nodes);
 end;//if not pm_GetIsListEmpty then
//#UC END# *47FC90B50037_47E9EDA800FE_impl*
end;//_dsList_.SaveToFile

function _dsList_.pm_GetNodeForPositioning: Il3SimpleNode;
//#UC START# *47FF178F033D_47E9EDA800FEget_var*
//#UC END# *47FF178F033D_47E9EDA800FEget_var*
begin
//#UC START# *47FF178F033D_47E9EDA800FEget_impl*
 if (ucc_NodeForPositioningHolder <> nil) then
  Result := ucc_NodeForPositioningHolder.NodeForPositioning
 else
  Result := nil;
//#UC END# *47FF178F033D_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetNodeForPositioning

procedure _dsList_.ReleaseNodeForPositioning;
 {* - }
//#UC START# *47FF44F20247_47E9EDA800FE_var*
//#UC END# *47FF44F20247_47E9EDA800FE_var*
begin
//#UC START# *47FF44F20247_47E9EDA800FE_impl*
 if (ucc_NodeForPositioningHolder <> nil) then
  ucc_NodeForPositioningHolder.ReleaseNodeForPositioning
 else
  Assert(False);
   // - нужно поддержать интерфейс IucpNodeForPositioningHolder.
//#UC END# *47FF44F20247_47E9EDA800FE_impl*
end;//_dsList_.ReleaseNodeForPositioning

function _dsList_.CreateBookmark: IBookmark;
 {* - добавить закладку на текущий документ. }
//#UC START# *48034EC0013B_47E9EDA800FE_var*
var
 l_Document: IDocument;
//#UC END# *48034EC0013B_47E9EDA800FE_var*
begin
//#UC START# *48034EC0013B_47E9EDA800FE_impl*
 if CanCreateBookmark then
 begin
  l_Document := MakeDocumentFromBookmark;
  if l_Document <> nil then
  begin
   nsDocumentTools.CreateBookmark(l_Document,
                                  Document.Pos.rPos,
                                  Document.Pos.rRefType = dptPara,
                                  Result);
   Exit;
  end;//if l_Document <> nil then
 end;//if CanCreateBookmark then
 Result := nil;
//#UC END# *48034EC0013B_47E9EDA800FE_impl*
end;//_dsList_.CreateBookmark

function _dsList_.pm_GetAllDocumentFiltered: Boolean;
//#UC START# *4827DF180028_47E9EDA800FEget_var*
//#UC END# *4827DF180028_47E9EDA800FEget_var*
begin
//#UC START# *4827DF180028_47E9EDA800FEget_impl*
 Result := f_AllDocumentFiltered;
//#UC END# *4827DF180028_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetAllDocumentFiltered

function _dsList_.pm_GetHasAttributes: Boolean;
//#UC START# *4875E7B60332_47E9EDA800FEget_var*
//#UC END# *4875E7B60332_47E9EDA800FEget_var*
begin
//#UC START# *4875E7B60332_47E9EDA800FEget_impl*
 Result := (ucc_BaseDocumentWithAttributes <> nil) and ucc_BaseDocumentWithAttributes.HasAttributes;
//#UC END# *4875E7B60332_47E9EDA800FEget_impl*
end;//_dsList_.pm_GetHasAttributes

function _dsList_.MakeSuperPreview(aOnlyFirstLevel: Boolean = True;
 WithTexts: Boolean = True): InsSuperComplexDocumentPreview;
 {* Создать суперкомплексное превью }
//#UC START# *489015E10252_47E9EDA800FE_var*
var
 l_Preview: IafwComplexDocumentPreview;
//#UC END# *489015E10252_47E9EDA800FE_var*
begin
//#UC START# *489015E10252_47E9EDA800FE_impl*
 Result := TnsSuperComplexDocumentPreview.Make(MakePreview(aOnlyFirstLevel));
 if WithTexts then
  l_Preview := MakeMultiDocumentPreview(aOnlyFirstLevel)
 else
  l_Preview := nil;
 Result.DocumentTexts := l_Preview;
//#UC END# *489015E10252_47E9EDA800FE_impl*
end;//_dsList_.MakeSuperPreview

function _dsList_.MakeMultiDocumentPreview(aOnlyFirstLevel: Boolean): IafwComplexDocumentPreview;
 {* Создать превью с текстами документов }
//#UC START# *48902C750320_47E9EDA800FE_var*
var
 l_Tree    : Il3ExpandedSimpleTree;
 l_FullPreview : IafwDocumentPreview;
 l_SelectedPreview: IafwDocumentPreview;
//#UC END# *48902C750320_47E9EDA800FE_var*
begin
//#UC START# *48902C750320_47E9EDA800FE_impl*
 if Supports(pm_GetSimpleTree, Il3ExpandedSimpleTree, l_Tree) then
 try
  l_FullPreview := TnsTreeMultiDocumentPreviewContainer.Make(l_Tree, False, aOnlyFirstLevel);
  l_SelectedPreview := TnsTreeMultiDocumentPreviewContainer.Make(l_Tree, True, aOnlyFirstLevel);
  try
   Result := TafwComplexDocumentPreview.Make(l_FullPreview);
   Result.SetSelection(l_SelectedPreview);
   if Assigned(l_SelectedPreview) then
    Result.ContentKind := afw_pckSelection;
  finally
   l_FullPreview := nil;
   l_SelectedPreview := nil;
  end;{try..finally}
 finally
  l_Tree := nil;
 end{try..finally}
 else
  Result := nil;
//#UC END# *48902C750320_47E9EDA800FE_impl*
end;//_dsList_.MakeMultiDocumentPreview

function _dsList_.Get_ActiveFilters: IFiltersFromQuery;
//#UC START# *4AEEE80202AD_47E9EDA800FEget_var*
//#UC END# *4AEEE80202AD_47E9EDA800FEget_var*
begin
//#UC START# *4AEEE80202AD_47E9EDA800FEget_impl*
 if (f_ActiveFilters = nil) then
  f_ActiveFilters := DefDataAdapter.NativeAdapter.MakeFiltersFromQuery;
 Result := f_ActiveFilters;
//#UC END# *4AEEE80202AD_47E9EDA800FEget_impl*
end;//_dsList_.Get_ActiveFilters

function _dsList_.ListAsString(aSaveListKind: TbsSaveListKind;
 SaveSelection: Boolean;
 aFormat: TnsFileFormat): Il3CString;
//#UC START# *512B22E20169_47E9EDA800FE_var*
var
 l_Stream: IStream;
 l_OutputStream: Tl3StringStream;
 l_Output: TnsGetGenOutputStruct;
//#UC END# *512B22E20169_47E9EDA800FE_var*
begin
//#UC START# *512B22E20169_47E9EDA800FE_impl*
 l_Stream := ListAsText(aSaveListKind, SaveSelection);
 try
  l_OutputStream := Tl3StringStream.Create;
  try
   l_Output := TnsGetGenOutputStruct_Create(l_OutputStream);
   nsEvdStreamSaveAs(l_Stream, l_Output, aFormat, True);
   Result := l3CStr(l_OutputStream._String);
  finally
   FreeAndNil(l_OutputStream);
  end;
 finally
  l_Stream := nil;
 end;
//#UC END# *512B22E20169_47E9EDA800FE_impl*
end;//_dsList_.ListAsString

procedure _dsList_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47E9EDA800FE_var*
//#UC END# *479731C50290_47E9EDA800FE_var*
begin
//#UC START# *479731C50290_47E9EDA800FE_impl*
 f_ActiveFilters := nil;
 f_Current := nil;
 f_Preview := nil;
 f_CurrentEntryInfo := nil;
 Document := nil;
 if (f_RootManager <> nil) then
  Il3ChangeNotifier(f_RootManager).Unsubscribe(Il3ItemNotifyRecipient(Self));
 FreeAndNil(f_RootManager);
 ImpList := nil;
 inherited;
//#UC END# *479731C50290_47E9EDA800FE_impl*
end;//_dsList_.Cleanup

procedure _dsList_.DoCurrentChanged(const aNode: Il3SimpleNode);
 {* сменился текущий. }
//#UC START# *47F0C1BF0314_47E9EDA800FE_var*

  procedure lp_ShowDocument(const aNode: INodeBase);

   function lp_CloneDocument: IdeDocInfo;
   begin
    if Document <> nil then
     Result := Document.Clone
    else
     Result := nil;
   end;

  begin
   Document := MakeDocInfo(aNode);
   if NotifyAboutChangeCurrent and
    (ucc_BaseDocument <> nil) then
    ucc_BaseDocument.ChangeDocument(lp_CloneDocument);
   // Обновим строку состояния (информация о выделенных в списке текущем и т.д.)
   g_Dispatcher.UpdateStatus;
  end;//lp_ShowDocument

var
 l_Node : INodeBase;
//#UC END# *47F0C1BF0314_47E9EDA800FE_var*
begin
//#UC START# *47F0C1BF0314_47E9EDA800FE_impl*
 if Supports(aNode, INodeBase, l_Node) and
  (not Assigned(Current) or not Current.IsSame(aNode)) then
 try
  lp_ShowDocument(l_Node);
 finally
  l_Node := nil;
 end{try..finally}
 else
  // Почистим зону синхронного просмотра, очищен список документов:
  if not Assigned(Current) and
    (ucc_BaseDocument <> nil) and
    (ucc_BaseDocument.DocInfo <> nil) then
   lp_ShowDocument(nil);
 // Всегда запоминаем потому, что узлы от разных View с точки зрения IsSame
 // одинаковые, но для навигации из документа по списку нужен узел от текущего
 // View списка
 Current := aNode;
//#UC END# *47F0C1BF0314_47E9EDA800FE_impl*
end;//_dsList_.DoCurrentChanged

procedure _dsList_.UpdateSimpleTree(const aOld: Il3SimpleTree;
 const aNew: Il3SimpleTree);
 {* - обновить данные дерева. }
//#UC START# *47FC718400FA_47E9EDA800FE_var*
var
 l_ListTreeStruct: IbsListTreeStruct;
//#UC END# *47FC718400FA_47E9EDA800FE_var*
begin
//#UC START# *47FC718400FA_47E9EDA800FE_impl*
 inherited;
 if Supports(aOld, IbsListTreeStruct, l_ListTreeStruct) then
  l_ListTreeStruct.dsList := nil;
 if Supports(aNew, IbsListTreeStruct, l_ListTreeStruct) then
  l_ListTreeStruct.dsList := Self;
//#UC END# *47FC718400FA_47E9EDA800FE_impl*
end;//_dsList_.UpdateSimpleTree

{$If NOT Defined(NoVCM)}
procedure _dsList_.GotData;
 {* - данные изменились. }
//#UC START# *492ACF630072_47E9EDA800FE_var*
var
 l_Filterable    : IFilterable;
 l_ActiveFilters : IFiltersFromQuery;
 l_PermanentFilters: IFiltersFromQuery;
//#UC END# *492ACF630072_47E9EDA800FE_var*
begin
//#UC START# *492ACF630072_47E9EDA800FE_impl*
 inherited;
 ImpList := PartData.List;
 f_SearchInfo := PartData.SearchInfo;

 if Supports(ImpList, IFilterable, l_Filterable) then
 try
  l_Filterable.GetActiveFilters(l_ActiveFilters);
  LoadActiveFilters(l_ActiveFilters);
  //http://mdp.garant.ru/pages/viewpage.action?pageId=506709931
  if NeedApplyPermanentFilters then
  try
   l_PermanentFilters := GetPermanentFilters;
   LoadActiveFilters(l_PermanentFilters);
  finally
   l_PermanentFilters := nil;
  end;
 finally
  l_ActiveFilters := nil;
  l_Filterable := nil;
 end;
//#UC END# *492ACF630072_47E9EDA800FE_impl*
end;//_dsList_.GotData
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _dsList_.DoInit;
//#UC START# *492BF7900310_47E9EDA800FE_var*
//#UC END# *492BF7900310_47E9EDA800FE_var*
begin
//#UC START# *492BF7900310_47E9EDA800FE_impl*
 inherited;
 f_AllDocumentFiltered := PartData.AllDocumentsFiltered;
 f_InitialNeedApplyPermanentFilters := PartData.NeedApplyPermanentFilters;
 PrintFirstLevel := True;
//#UC END# *492BF7900310_47E9EDA800FE_impl*
end;//_dsList_.DoInit
{$IfEnd} // NOT Defined(NoVCM)

procedure _dsList_.ClearFields;
begin
 Current := nil;
 Document := nil;
 Preview := nil;
 ImpList := nil;
 f_SearchInfo := nil;
 inherited;
end;//_dsList_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dsList_imp_impl}

{$EndIf dsList_imp}

