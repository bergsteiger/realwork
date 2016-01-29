unit sdsList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "List"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/List/sdsList.pas"
// Начат: 2005/08/09 10:25:31
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Работа с документом и списком документов::WorkWithList::List::List::TsdsList
//
// Список
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
  bsTypes
  {$If not defined(NoVCM)}
  ,
  vcmControllers
  {$IfEnd} //not NoVCM
  ,
  PrimListInterfaces,
  l3StringIDEx,
  WorkWithListInterfaces,
  DynamicDocListUnit,
  DynamicTreeUnit,
  DocInfoInterfaces,
  BaseDocumentWithAttributesInterfaces,
  DocumentUnit,
  DocumentAndListInterfaces,
  DocumentInterfaces,
  bsTypesNew
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3Interfaces,
  l3NotifyPtrList
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3IID,
  nevTools,
  afwInterfaces,
  FoldersDomainInterfaces,
  l3InternalInterfaces,
  l3TreeInterfaces,
  bsInterfaces,
  ExternalObjectUnit,
  evdInterfaces,
  l3Tree_TLB,
  PrimPrimListInterfaces,
  FiltersUnit,
  nsTypes,
  PreviewInterfaces,
  nevBase
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  SimpleListInterfaces {a},
  WorkWithDocumentInterfaces {a},

  fstListInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
var
  { Локализуемые строки Local }
 str_MissingAnalisisTree : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MissingAnalisisTree'; rValue : 'В вашем информационном банке отсутствуют данные, необходимые для работы функции "Анализ списка". Для устранения, пожалуйста, обратитесь в обслуживающую Вас организацию:' + #13#10 + #13#10 +
'%s');
  { 'В вашем информационном банке отсутствуют данные, необходимые для работы функции "Анализ списка". Для устранения, пожалуйста, обратитесь в обслуживающую Вас организацию:' + #13#10 + #13#10 +
'%s' }

type
 _InitDataType_ = IdeDocumentList;
 _SetDataType_ = IdList;
 _SetType_ = IsdsList;

 _FormSetType_ = IfstList;

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsDocInfoFS.imp.pas}
 _nsListWarningGenerator_Parent_ = _sdsDocInfo_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\PrimListControllers\nsListWarningGenerator.imp.pas}
 TsdsList = {ucc} class(_nsListWarningGenerator_, IsdsList, IucpFilters {from IsdsList}, IucpNodeForPositioningHolder {from IsdsList}, IbsDataProducer {from IsdsList}, InsWarningGenerator {from IsdsList}, IucpBaseSearchSupportQuery {from IsdsList}, IsdsListPrim {from IsdsList}, IsdsListNameHolder {from IsdsList})
  {* Список }
 private
 // private fields
   f_dsBaloonWarning : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsBaloonWarning}
   f_dsListAnalize : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsListAnalize}
   f_dsTextBaloonWarning : IvcmViewAreaControllerRef;
    {* Поле для области вывода dsTextBaloonWarning}
 private                          
 // private methods
   procedure NeedMakeForFullCR(aId: TnsUserCRListId);
     {* установить состояние для СКР }
   function NeedMakeDSFullCR(aType: TlstCRType): Boolean;
     {* нужно ли создавать бизнес объект для полного СКР }
   function HasUserCRList(aId: TnsUserCRListId): Boolean;
     {* определим наличие пользовательского СКР }
 protected
 // realized methods
   {$If not defined(NoVCM)}
   function MakeData: _SetDataType_; override;
     {* Данные сборки. }
   {$IfEnd} //not NoVCM
   procedure Open;
     {* открыть форму фильтры }
   function pm_GetNodeForPositioning: Il3SimpleNode;
   procedure ReleaseNodeForPositioning;
     {* - освободить узел для позиционирования. }
   function BaseDocumentClass: IdsBaseDocument; override;
   procedure UpdateListInfo;
     {* обновляет информацию о списке }
   function pm_GetHasUserCRList1: Boolean;
   function pm_GetHasUserCRList2: Boolean;
   function pm_GetHasDocument: Boolean;
   function XXXMakeData: Boolean;
     {* Вызывается при запросе данных у бизнес объекта формы. Результат определяет нужно ли возвращать данные форме }
   function Get_CanRunBaseSearch: Boolean;
   function Get_DsListPrim: IdsList;
   function Get_IsShortList: Boolean;
   function MakeFullList(const aNodeForPositioning: Il3SimpleNode): IdeDocumentList;
   function pm_GetIsSnippet: Boolean;
   function MakeAnalizeTree: Il3SimpleTree;
   function pm_GetIsSimilarDocumentsActive: Boolean;
   procedure ReplaceList(const aList: IDynList);
   function pm_GetDsBaloonWarning: IdsWarning;
   function DoGet_dsBaloonWarning: IdsWarning;
   function pm_GetDsListAnalize: IdsListAnalize;
   function DoGet_dsListAnalize: IdsListAnalize;
   function pm_GetDsTextBaloonWarning: IdsWarning;
   function DoGet_dsTextBaloonWarning: IdsWarning;
   function pm_GetDsList: IdsDocumentList;
   function DoGet_dsList: IdsDocumentList;
   function pm_GetdsListRef: IvcmViewAreaControllerRef;
   function pm_GetDsSynchroView: IdsSynchroView;
   function DoGet_dsSynchroView: IdsSynchroView;
   function pm_GetdsSynchroViewRef: IvcmViewAreaControllerRef;
   function pm_GetDsListInfo: IdsListInfo;
   function DoGet_dsListInfo: IdsListInfo;
   function pm_GetdsListInfoRef: IvcmViewAreaControllerRef;
   function pm_GetDsFilters: IdsFilters;
   function DoGet_dsFilters: IdsFilters;
   function pm_GetdsFiltersRef: IvcmViewAreaControllerRef;
   function pm_GetShortListName: Il3CString;
   function pm_GetListName: Il3CString;
   procedure OpenAttributes;
     {* Открывает ViewArea "атрибуты документа" }
   procedure OpenUserCR1;
     {* Открывает ViewArea "БОФ пользовательский СКР1" }
   procedure OpenSimilarDocuments;
     {* Открывает ViewArea "БОФ похожие документы" }
   procedure OpenUserCR2;
     {* Открывает ViewArea "БОФ пользовательский СКР2" }
   function pm_GetIsUserCR2Active: Boolean;
   function pm_GetIsUserCR1Active: Boolean;
   function pm_GetIsDocumentActive: Boolean;
   procedure OpenRelatedDoc;
     {* Открывает ViewArea "справка к документу" }
   procedure OpenDocument;
     {* Открывает ViewArea "Собственно документ" }
   function pm_GetIsRelatedDocActive: Boolean;
   function pm_GetIsAttributesActive: Boolean;
   procedure OpenAnnotation;
     {* Открывает ViewArea "аннотация к документу" }
   function pm_GetIsAnnotationActive: Boolean;
   procedure OpenCorrespondents; override;
   procedure OpenRespondents; override;
     {* атрибуты }
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DataExchange; override;
     {* - вызывается после получения данных инициализации. }
   {$IfEnd} //not NoVCM
   procedure DoOpenAttributes; override;
     {* - атрибуты. }
   function NeedMakeDSAttributes: Boolean; override;
     {* - необходимость создания БОФ атрибутов. }
   procedure ClearAllDS; override;
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; override;
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
   function NeedMakeDocument: Boolean; override;
     {* Определяет - нужно ли создавать область ввода для документа }
   function NeedMakeDSUserCRList1: Boolean; override;
   function NeedMakeDSUserCRList2: Boolean; override;
   function NeedMakeDSCorrespondents: Boolean; override;
   function NeedMakeDSRespondents: Boolean; override;
   function NeedMakeDocumentWithFlash: Boolean; override;
   function DoChangeCRType(const aNode: INodeBase;
    aType: TlstCRType;
    IsCRToPart: Boolean): Boolean; override;
     {* вызывается при изменении типа корреспондентов/респондентов }
   function NeedMakeRelatedDoc: Boolean; override;
   function NeedMakeAnnotation: Boolean; override;
   function NeedMakeSimilarDocuments: Boolean; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
    {$If not defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
    {$IfEnd} //not NoVCM
    {$If not defined(NoVCM)}
   function GetDataForClone: _InitDataType_; override;
    {$IfEnd} //not NoVCM
 protected
 // protected methods
   procedure OpenFilters;
     {* открыть форму фильтры }
   procedure ChangeSynchroForm(aSynchroForm: TList_SynchroView_Areas;
    aDoSaveToHistory: Boolean = True;
    aNeedRefresh: Boolean = True);
     {* Переключает форму синхронного просмотра }
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_IucpFilters: IucpFilters;
   function As_IucpNodeForPositioningHolder: IucpNodeForPositioningHolder;
   function As_IbsDataProducer: IbsDataProducer;
   function As_InsWarningGenerator: InsWarningGenerator;
   function As_IucpBaseSearchSupportQuery: IucpBaseSearchSupportQuery;
   function As_IsdsListPrim: IsdsListPrim;
   function As_IsdsListNameHolder: IsdsListNameHolder;
 end;//TsdsList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  dsAnnotation,
  dsChronology,
  dsSynchroView,
  dsListInfo,
  dsMainList,
  dsFilters,
  dsDocument,
  dList,
  SysUtils,
  l3Base,
  DebugStr,
  afwFacade,
  nsConst,
  bsUtils,
  nsTreeStruct,
  nsINodeWrap,
  dsWarning,
  WarningUserTypes_Warning_UserType,
  Document_Const
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  DataAdapter,
  l3Tree,
  l3Nodes,
  BaseTypesUnit,
  l3String,
  Dialogs,
  dsListAnalize,
  dsSynchroViewWarning,
  dsSynchroViewDocument,
  l3MessageID,
  dsDocumentListCR,
  dsDocumentList,
  dsDocumentWithFlash,
  bsFrozenNode,
  deDocumentListCR,
  deDocInfo,
  bsDataContainer,
  deDocumentList,
  bsUserCRListInfo,
  l3Types,
  l3Utils,
  nsUtils,
  dsTranslation,
  dsRelatedDoc
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  dsAttributes,
  Windows
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  afwSettingsChangePublisher,
  nsDocumentWarningGenerator,
  BaloonWarningUserTypes_remListModified_UserType,
  UnderControlInterfaces,
  nsListWarningGenerator,
  vcmFormDataSourceRef {a}
  ,
  nsTabbedInterfaceTypes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsList;
                                                                                 
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsDocInfoFS.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\PrimListControllers\nsListWarningGenerator.imp.pas}

// start class TsdsList

procedure TsdsList.NeedMakeForFullCR(aId: TnsUserCRListId);
//#UC START# *493E7C24005A_493E78640269_var*
//#UC END# *493E7C24005A_493E78640269_var*
begin
//#UC START# *493E7C24005A_493E78640269_impl*
 with SetData.UserCRListInfo[aId] do
  if KindOfList = bs_ulFullCR then
   UCFormSet.SetNeedMakeForFullCR(ListType);
//#UC END# *493E7C24005A_493E78640269_impl*
end;//TsdsList.NeedMakeForFullCR

function TsdsList.NeedMakeDSFullCR(aType: TlstCRType): Boolean;
//#UC START# *493E7C42007D_493E78640269_var*
//#UC END# *493E7C42007D_493E78640269_var*
begin
//#UC START# *493E7C42007D_493E78640269_impl*
 case UCFormSet.CurrentSynchroForm of
  sva_List_SynchroView_UserCR1:
   with SetData.UserCRListInfo[ulFirst] do
    Result := (KindOfList = bs_ulFullCR) and (ListType = aType);
  sva_List_SynchroView_UserCR2:
   with SetData.UserCRListInfo[ulSecond] do
    Result := (KindOfList = bs_ulFullCR) and (ListType = aType);
  else
   Result := False;
 end;//case SetData.SynchroForm of
//#UC END# *493E7C42007D_493E78640269_impl*
end;//TsdsList.NeedMakeDSFullCR

function TsdsList.HasUserCRList(aId: TnsUserCRListId): Boolean;
//#UC START# *493E7C6F01B3_493E78640269_var*
//#UC END# *493E7C6F01B3_493E78640269_var*
begin
//#UC START# *493E7C6F01B3_493E78640269_impl*
 with SetData.UserCRListInfo[aId] do
 begin
  Result := KindOfList = bs_ulFullCR;
  // У пользователя выбран режим все документы, в этом случае показываются
  // списки корр\респ с возможностью выбора типа:
  if Result then
   case ListType of
    crtCorrespondents:
     Result := pm_GetHasCorrespondents;
    crtRespondents:
     Result := pm_GetHasRespondents;
   end//case ListType of
  // Наличие пользовательского СКР:
  else
   Result := Has;
 end;//with SetData.UserCRListInfo[ulFirst] do
//#UC END# *493E7C6F01B3_493E78640269_impl*
end;//TsdsList.HasUserCRList

procedure TsdsList.OpenFilters;
//#UC START# *493E7EAC0171_493E78640269_var*
//#UC END# *493E7EAC0171_493E78640269_var*
begin
//#UC START# *493E7EAC0171_493E78640269_impl*
 if SetData.dsFiltersRef.IsEmpty then
  UCFormSet.AsIucpFilters.Open;
//#UC END# *493E7EAC0171_493E78640269_impl*
end;//TsdsList.OpenFilters

procedure TsdsList.ChangeSynchroForm(aSynchroForm: TList_SynchroView_Areas;
 aDoSaveToHistory: Boolean = True;
 aNeedRefresh: Boolean = True);
//#UC START# *D35F2F1E4DE1_493E78640269_var*
//#UC END# *D35F2F1E4DE1_493E78640269_var*
begin
//#UC START# *D35F2F1E4DE1_493E78640269_impl*
 if (aSynchroForm <> UCFormSet.CurrentSynchroForm) OR
  (aDoSaveToHistory and (SetData.List_SynchroView_Form <> aSynchroForm)) then
 begin
  ClearAllDS;
  if aDoSaveToHistory then
  begin
   SetData.List_SynchroView_Form := aSynchroForm;
   SetData.DisableAutoOpenAnnotation := aSynchroForm <> sva_List_SynchroView_Annotation;
  end;
  UCFormSet.CurrentSynchroForm := aSynchroForm;
  // При открытии документа сбрасываем типы корр/респ. CQ: 00018879
  if (UCFormSet.CurrentSynchroForm = sva_List_SynchroView_Document) then
  begin
   ChangeCorrType(nil);
   ChangeRespType(nil);
  end;//SetData.List_SynchroView_Form = sva_List_SynchroView_Document
  if aNeedRefresh then
   Refresh;
 end;//aSynchroForm <> SetData.List_SynchroView_Form
//#UC END# *D35F2F1E4DE1_493E78640269_impl*
end;//TsdsList.ChangeSynchroForm

{$If not defined(NoVCM)}
function TsdsList.MakeData: _SetDataType_;
//#UC START# *47F3778403D9_493E78640269_var*
//#UC END# *47F3778403D9_493E78640269_var*
begin
//#UC START# *47F3778403D9_493E78640269_impl*
 Result := TdList.Make;
//#UC END# *47F3778403D9_493E78640269_impl*
end;//TsdsList.MakeData
{$IfEnd} //not NoVCM

procedure TsdsList.Open;
//#UC START# *47FB2086026D_493E78640269_var*
//#UC END# *47FB2086026D_493E78640269_var*
begin
//#UC START# *47FB2086026D_493E78640269_impl*
 OpenFilters;
//#UC END# *47FB2086026D_493E78640269_impl*
end;//TsdsList.Open

function TsdsList.pm_GetNodeForPositioning: Il3SimpleNode;
//#UC START# *47FF2155021A_493E78640269get_var*
//#UC END# *47FF2155021A_493E78640269get_var*
begin
//#UC START# *47FF2155021A_493E78640269get_impl*
 Result := SetData.NodeForPositioning;
//#UC END# *47FF2155021A_493E78640269get_impl*
end;//TsdsList.pm_GetNodeForPositioning

procedure TsdsList.ReleaseNodeForPositioning;
//#UC START# *47FF44850384_493E78640269_var*
//#UC END# *47FF44850384_493E78640269_var*
begin
//#UC START# *47FF44850384_493E78640269_impl*
 SetData.NodeForPositioning := nil;
//#UC END# *47FF44850384_493E78640269_impl*
end;//TsdsList.ReleaseNodeForPositioning

function TsdsList.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_493E78640269_var*
//#UC END# *4925B1EC0100_493E78640269_var*
begin
//#UC START# *4925B1EC0100_493E78640269_impl*
 Result := TdsSynchroViewDocument.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_493E78640269_impl*
end;//TsdsList.BaseDocumentClass

procedure TsdsList.UpdateListInfo;
//#UC START# *49394AFE03CE_493E78640269_var*
//#UC END# *49394AFE03CE_493E78640269_var*
begin
//#UC START# *49394AFE03CE_493E78640269_impl*
 SetData.dsListInfoRef.Clear;
 Refresh;
//#UC END# *49394AFE03CE_493E78640269_impl*
end;//TsdsList.UpdateListInfo

function TsdsList.pm_GetHasUserCRList1: Boolean;
//#UC START# *49394C37008A_493E78640269get_var*
//#UC END# *49394C37008A_493E78640269get_var*
begin
//#UC START# *49394C37008A_493E78640269get_impl*
 Result := HasUserCRList(ulFirst);
//#UC END# *49394C37008A_493E78640269get_impl*
end;//TsdsList.pm_GetHasUserCRList1

function TsdsList.pm_GetHasUserCRList2: Boolean;
//#UC START# *49394C430125_493E78640269get_var*
//#UC END# *49394C430125_493E78640269get_var*
begin
//#UC START# *49394C430125_493E78640269get_impl*
 Result := HasUserCRList(ulSecond);
//#UC END# *49394C430125_493E78640269get_impl*
end;//TsdsList.pm_GetHasUserCRList2

function TsdsList.pm_GetHasDocument: Boolean;
//#UC START# *49394C91013A_493E78640269get_var*
//#UC END# *49394C91013A_493E78640269get_var*
begin
//#UC START# *49394C91013A_493E78640269get_impl*
 Result := (pm_GetDocInfo <> nil);
//#UC END# *49394C91013A_493E78640269get_impl*
end;//TsdsList.pm_GetHasDocument

function TsdsList.XXXMakeData: Boolean;
//#UC START# *493957960321_493E78640269_var*
//#UC END# *493957960321_493E78640269_var*
begin
//#UC START# *493957960321_493E78640269_impl*
 Result := True;
//#UC END# *493957960321_493E78640269_impl*
end;//TsdsList.XXXMakeData

function TsdsList.Get_CanRunBaseSearch: Boolean;
//#UC START# *496F344101D0_493E78640269get_var*
//#UC END# *496F344101D0_493E78640269get_var*
begin
//#UC START# *496F344101D0_493E78640269get_impl*
 Result := True;
//#UC END# *496F344101D0_493E78640269get_impl*
end;//TsdsList.Get_CanRunBaseSearch

function TsdsList.Get_DsListPrim: IdsList;
//#UC START# *49AE664F006B_493E78640269get_var*
//#UC END# *49AE664F006B_493E78640269get_var*
begin
//#UC START# *49AE664F006B_493E78640269get_impl*
 Result := pm_GetDsList;
//#UC END# *49AE664F006B_493E78640269get_impl*
end;//TsdsList.Get_DsListPrim

function TsdsList.Get_IsShortList: Boolean;
//#UC START# *4A2CD4640322_493E78640269get_var*
//#UC END# *4A2CD4640322_493E78640269get_var*
begin
//#UC START# *4A2CD4640322_493E78640269get_impl*
 Result := Assigned(SetData.List) and SetData.List.GetIsShort;
//#UC END# *4A2CD4640322_493E78640269get_impl*
end;//TsdsList.Get_IsShortList

function TsdsList.MakeFullList(const aNodeForPositioning: Il3SimpleNode): IdeDocumentList;
//#UC START# *4A2CD478017C_493E78640269_var*
var
 l_List: IDynList;
 l_Node: INodeBase;
 l_NewNode: INodeBase;
 l_RootNode: INodeBase;
 l_NodeForPosition: Il3SimpleNode;
//#UC END# *4A2CD478017C_493E78640269_var*
begin
//#UC START# *4A2CD478017C_493E78640269_impl*
 l_List := bsBuildFullList(SetData.List);
 if Supports(aNodeForPositioning, INodeBase, l_Node) then
 begin
  l_List.GetRoot(l_RootNode);
  l_RootNode.FindNode(l_Node, l_NewNode);
  l_NodeForPosition :=TnsINodeWrap.Make(l_NewNode);
 end//Supports(aNodeForPositioning, INodeBase, l_Node)
 else
  l_NodeForPosition := nil;
 Result := InitialUseCaseData.CloneWithReplace(l_List, l_NodeForPosition);
//#UC END# *4A2CD478017C_493E78640269_impl*
end;//TsdsList.MakeFullList

function TsdsList.pm_GetIsSnippet: Boolean;
//#UC START# *4A796E770249_493E78640269get_var*
//#UC END# *4A796E770249_493E78640269get_var*
begin
//#UC START# *4A796E770249_493E78640269get_impl*
 Result := Assigned(SetData.List) and SetData.List.GetIsSnippet;
//#UC END# *4A796E770249_493E78640269get_impl*
end;//TsdsList.pm_GetIsSnippet

function TsdsList.MakeAnalizeTree: Il3SimpleTree;
//#UC START# *4AA0EA61022D_493E78640269_var*
var
 l_Root : INodeBase;
 l_List : IDynList;
 //l_Fake : Tl3Tree;
//#UC END# *4AA0EA61022D_493E78640269_var*
begin
//#UC START# *4AA0EA61022D_493E78640269_impl*
 if SetData.List.GetIsShort then
  l_List := bsBuildFullList(SetData.List)
 else
  l_List := SetData.List;
 if Assigned(l_List) then
 begin
  try
   l_List.GetAnalysisTree(l_Root);
  except
   on ECannotFindData do
   begin
    Result := nil;
(*    l_Fake := Tl3Tree.Create;
    try
     Result := l_Fake;
     l_Fake.
      RootNode.
       InsertChild(
        MakeNode(l3PCharLen(vcmFmt(str_MissingAnalisisTree,
                                   [DefDataAdapter.GetDealerInfo]))));
     l_Fake.ShowRoot := false;
    finally
     FreeAndNil(l_Fake);
    end;//try..finally*)
    Exit;
   end;//on ECannotFindData
  end;//try..except
  Result := TnsTreeStruct.Make(l_Root, False);
 end//Assigned(l_List)
 else
  Result := nil;
//#UC END# *4AA0EA61022D_493E78640269_impl*
end;//TsdsList.MakeAnalizeTree

function TsdsList.pm_GetIsSimilarDocumentsActive: Boolean;
//#UC START# *4B1EA9069D74_493E78640269get_var*
//#UC END# *4B1EA9069D74_493E78640269get_var*
begin
//#UC START# *4B1EA9069D74_493E78640269get_impl*
 Result := UCFormSet.CurrentSynchroForm = sva_List_SynchroView_SimilarDocuments;
//#UC END# *4B1EA9069D74_493E78640269get_impl*
end;//TsdsList.pm_GetIsSimilarDocumentsActive

procedure TsdsList.ReplaceList(const aList: IDynList);
//#UC START# *4BFA28D4017F_493E78640269_var*
//#UC END# *4BFA28D4017F_493E78640269_var*
begin
//#UC START# *4BFA28D4017F_493E78640269_impl*
 SetData.List := aList;
//#UC END# *4BFA28D4017F_493E78640269_impl*
end;//TsdsList.ReplaceList

function TsdsList.pm_GetDsBaloonWarning: IdsWarning;
//#UC START# *4DB984CF00E5_493E78640269get_var*
//#UC END# *4DB984CF00E5_493E78640269get_var*
begin
 if (f_dsBaloonWarning = nil) then
 begin
  f_dsBaloonWarning := TvcmViewAreaControllerRef.Make;
  //#UC START# *4DB984CF00E5_493E78640269get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4DB984CF00E5_493E78640269get_init*
 end;//f_dsBaloonWarning = nil
 if f_dsBaloonWarning.IsEmpty
  //#UC START# *4DB984CF00E5_493E78640269get_need*
  // - условие создания ViewArea
  //#UC END# *4DB984CF00E5_493E78640269get_need*
  then
   f_dsBaloonWarning.Referred := DoGet_dsBaloonWarning;
 Result := IdsWarning(f_dsBaloonWarning.Referred);
end;

function TsdsList.DoGet_dsBaloonWarning: IdsWarning;
//#UC START# *4DB984CF00E5_493E78640269area_var*
//#UC END# *4DB984CF00E5_493E78640269area_var*
begin
//#UC START# *4DB984CF00E5_493E78640269area_impl*
 Result := TdsWarning.Make(Self);
//#UC END# *4DB984CF00E5_493E78640269area_impl*
end;//TsdsList.DoGet_dsBaloonWarning

function TsdsList.pm_GetDsListAnalize: IdsListAnalize;
//#UC START# *4E36899100B5_493E78640269get_var*
//#UC END# *4E36899100B5_493E78640269get_var*
begin
 if (f_dsListAnalize = nil) then
 begin
  f_dsListAnalize := TvcmViewAreaControllerRef.Make;
  //#UC START# *4E36899100B5_493E78640269get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4E36899100B5_493E78640269get_init*
 end;//f_dsListAnalize = nil
 if f_dsListAnalize.IsEmpty
  //#UC START# *4E36899100B5_493E78640269get_need*
  AND
  (pm_GetDsList <> nil) and
  not pm_GetDsList.IsListEmpty
  and pm_GetDsList.CanAnalize
  // - условие создания ViewArea
  //#UC END# *4E36899100B5_493E78640269get_need*
  then
   f_dsListAnalize.Referred := DoGet_dsListAnalize;
 Result := IdsListAnalize(f_dsListAnalize.Referred);
end;

function TsdsList.DoGet_dsListAnalize: IdsListAnalize;
//#UC START# *4E36899100B5_493E78640269area_var*
//#UC END# *4E36899100B5_493E78640269area_var*
begin
//#UC START# *4E36899100B5_493E78640269area_impl*
 Result := TdsListAnalize.Make(Self);
//#UC END# *4E36899100B5_493E78640269area_impl*
end;//TsdsList.DoGet_dsListAnalize

function TsdsList.pm_GetDsTextBaloonWarning: IdsWarning;
//#UC START# *4EFC594701E9_493E78640269get_var*
//#UC END# *4EFC594701E9_493E78640269get_var*
begin
 if (f_dsTextBaloonWarning = nil) then
 begin
  f_dsTextBaloonWarning := TvcmViewAreaControllerRef.Make;
  //#UC START# *4EFC594701E9_493E78640269get_init*
  // - код инициализации ссылки на ViewArea
  //#UC END# *4EFC594701E9_493E78640269get_init*
 end;//f_dsTextBaloonWarning = nil
 if f_dsTextBaloonWarning.IsEmpty
  //#UC START# *4EFC594701E9_493E78640269get_need*
  // - условие создания ViewArea
  //#UC END# *4EFC594701E9_493E78640269get_need*
  then
   f_dsTextBaloonWarning.Referred := DoGet_dsTextBaloonWarning;
 Result := IdsWarning(f_dsTextBaloonWarning.Referred);
end;

function TsdsList.DoGet_dsTextBaloonWarning: IdsWarning;
//#UC START# *4EFC594701E9_493E78640269area_var*
//#UC END# *4EFC594701E9_493E78640269area_var*
begin
//#UC START# *4EFC594701E9_493E78640269area_impl*
 Result := TdsSynchroViewWarning.Make(Self);
//#UC END# *4EFC594701E9_493E78640269area_impl*
end;//TsdsList.DoGet_dsTextBaloonWarning

function TsdsList.pm_GetDsList: IdsDocumentList;
//#UC START# *500CFA670146_493E78640269get_var*
//#UC END# *500CFA670146_493E78640269get_var*
begin
 with pm_GetdsListRef do
 begin
  if IsEmpty
   //#UC START# *500CFA670146_493E78640269get_need*
   // - условие создания ViewArea
  //#UC END# *500CFA670146_493E78640269get_need*
   then
    Referred := DoGet_dsList;
  Result := IdsDocumentList(Referred);
 end;//with pm_GetdsListRef
end;

function TsdsList.DoGet_dsList: IdsDocumentList;
//#UC START# *500CFA670146_493E78640269area_var*
//#UC END# *500CFA670146_493E78640269area_var*
begin
//#UC START# *500CFA670146_493E78640269area_impl*
 Result := TdsMainList.Make(Self, InitialUseCaseData);
//#UC END# *500CFA670146_493E78640269area_impl*
end;//TsdsList.DoGet_dsList

function TsdsList.pm_GetdsListRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsListRef;
end;

function TsdsList.pm_GetDsSynchroView: IdsSynchroView;
//#UC START# *500CFA9800C8_493E78640269get_var*
//#UC END# *500CFA9800C8_493E78640269get_var*
begin
 with pm_GetdsSynchroViewRef do
 begin
  if IsEmpty
   //#UC START# *500CFA9800C8_493E78640269get_need*
   // - условие создания ViewArea
  //#UC END# *500CFA9800C8_493E78640269get_need*
   then
    Referred := DoGet_dsSynchroView;
  Result := IdsSynchroView(Referred);
 end;//with pm_GetdsSynchroViewRef
end;

function TsdsList.DoGet_dsSynchroView: IdsSynchroView;
//#UC START# *500CFA9800C8_493E78640269area_var*
//#UC END# *500CFA9800C8_493E78640269area_var*
begin
//#UC START# *500CFA9800C8_493E78640269area_impl*
 Result := TdsSynchroView.Make(Self);
//#UC END# *500CFA9800C8_493E78640269area_impl*
end;//TsdsList.DoGet_dsSynchroView

function TsdsList.pm_GetdsSynchroViewRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsSynchroViewRef;
end;

function TsdsList.pm_GetDsListInfo: IdsListInfo;
//#UC START# *500CFABF0356_493E78640269get_var*
//#UC END# *500CFABF0356_493E78640269get_var*
begin
 with pm_GetdsListInfoRef do
 begin
  if IsEmpty
   //#UC START# *500CFABF0356_493E78640269get_need*
   // - условие создания ViewArea
  //#UC END# *500CFABF0356_493E78640269get_need*
   then
    Referred := DoGet_dsListInfo;
  Result := IdsListInfo(Referred);
 end;//with pm_GetdsListInfoRef
end;

function TsdsList.DoGet_dsListInfo: IdsListInfo;
//#UC START# *500CFABF0356_493E78640269area_var*
//#UC END# *500CFABF0356_493E78640269area_var*
begin
//#UC START# *500CFABF0356_493E78640269area_impl*
 Result := TdsListInfo.Make(Self, bsListCreationHistory(SetData.List));
//#UC END# *500CFABF0356_493E78640269area_impl*
end;//TsdsList.DoGet_dsListInfo

function TsdsList.pm_GetdsListInfoRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsListInfoRef;
end;

function TsdsList.pm_GetDsFilters: IdsFilters;
//#UC START# *500CFAE50070_493E78640269get_var*
//#UC END# *500CFAE50070_493E78640269get_var*
begin
 with pm_GetdsFiltersRef do
 begin
  if IsEmpty
   //#UC START# *500CFAE50070_493E78640269get_need*
     AND (UCFormSet.FiltersNeedMakeDS in [vcm_nmYes, vcm_nmForce])
   // - условие создания ViewArea
  //#UC END# *500CFAE50070_493E78640269get_need*
   then
    Referred := DoGet_dsFilters;
  Result := IdsFilters(Referred);
 end;//with pm_GetdsFiltersRef
end;

function TsdsList.DoGet_dsFilters: IdsFilters;
//#UC START# *500CFAE50070_493E78640269area_var*
//#UC END# *500CFAE50070_493E78640269area_var*
begin
//#UC START# *500CFAE50070_493E78640269area_impl*
 Result := TdsFilters.Make(Self);
//#UC END# *500CFAE50070_493E78640269area_impl*
end;//TsdsList.DoGet_dsFilters

function TsdsList.pm_GetdsFiltersRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsFiltersRef;
end;

function TsdsList.pm_GetShortListName: Il3CString;
//#UC START# *501806DE0323_493E78640269get_var*
//#UC END# *501806DE0323_493E78640269get_var*
begin
//#UC START# *501806DE0323_493E78640269get_impl*
 Result := bsShortListName(SetData.List);
//#UC END# *501806DE0323_493E78640269get_impl*
end;//TsdsList.pm_GetShortListName

function TsdsList.pm_GetListName: Il3CString;
//#UC START# *50180BA801C2_493E78640269get_var*
//#UC END# *50180BA801C2_493E78640269get_var*
begin
//#UC START# *50180BA801C2_493E78640269get_impl*
 Result := bsListName(SetData.List);
//#UC END# *50180BA801C2_493E78640269get_impl*
end;//TsdsList.pm_GetListName

procedure TsdsList.OpenAttributes;
//#UC START# *5BBD66420FA0_493E78640269_var*
//#UC END# *5BBD66420FA0_493E78640269_var*
begin
//#UC START# *5BBD66420FA0_493E78640269_impl*
 inherited OpenAttributes;
//#UC END# *5BBD66420FA0_493E78640269_impl*
end;//TsdsList.OpenAttributes

procedure TsdsList.OpenUserCR1;
//#UC START# *6034AC85B7BF_493E78640269_var*
//#UC END# *6034AC85B7BF_493E78640269_var*
begin
//#UC START# *6034AC85B7BF_493E78640269_impl*
 NeedMakeForFullCR(ulFirst);
 ChangeSynchroForm(sva_List_SynchroView_UserCR1);
//#UC END# *6034AC85B7BF_493E78640269_impl*
end;//TsdsList.OpenUserCR1

procedure TsdsList.OpenSimilarDocuments;
//#UC START# *6499B6E1DD77_493E78640269_var*
//#UC END# *6499B6E1DD77_493E78640269_var*
begin
//#UC START# *6499B6E1DD77_493E78640269_impl*
 UCFormSet.OpenSimilar;
 ChangeSynchroForm(sva_List_SynchroView_SimilarDocuments);
//#UC END# *6499B6E1DD77_493E78640269_impl*
end;//TsdsList.OpenSimilarDocuments

procedure TsdsList.OpenUserCR2;
//#UC START# *85D9023A0008_493E78640269_var*
//#UC END# *85D9023A0008_493E78640269_var*
begin
//#UC START# *85D9023A0008_493E78640269_impl*
 NeedMakeForFullCR(ulSecond);
 ChangeSynchroForm(sva_List_SynchroView_UserCR2);
//#UC END# *85D9023A0008_493E78640269_impl*
end;//TsdsList.OpenUserCR2

function TsdsList.pm_GetIsUserCR2Active: Boolean;
//#UC START# *8BB87AADAF20_493E78640269get_var*
//#UC END# *8BB87AADAF20_493E78640269get_var*
begin
//#UC START# *8BB87AADAF20_493E78640269get_impl*
 Result := UCFormSet.CurrentSynchroForm = sva_List_SynchroView_UserCR2;
//#UC END# *8BB87AADAF20_493E78640269get_impl*
end;//TsdsList.pm_GetIsUserCR2Active

function TsdsList.pm_GetIsUserCR1Active: Boolean;
//#UC START# *9CCDF86F498F_493E78640269get_var*
//#UC END# *9CCDF86F498F_493E78640269get_var*
begin
//#UC START# *9CCDF86F498F_493E78640269get_impl*
 Result := UCFormSet.CurrentSynchroForm = sva_List_SynchroView_UserCR1;
//#UC END# *9CCDF86F498F_493E78640269get_impl*
end;//TsdsList.pm_GetIsUserCR1Active

function TsdsList.pm_GetIsDocumentActive: Boolean;
//#UC START# *A6475CA40B39_493E78640269get_var*
//#UC END# *A6475CA40B39_493E78640269get_var*
begin
//#UC START# *A6475CA40B39_493E78640269get_impl*
 Result := UCFormSet.CurrentSynchroForm = sva_List_SynchroView_Document;
//#UC END# *A6475CA40B39_493E78640269get_impl*
end;//TsdsList.pm_GetIsDocumentActive

procedure TsdsList.OpenRelatedDoc;
//#UC START# *AFD62513C0A3_493E78640269_var*
//#UC END# *AFD62513C0A3_493E78640269_var*
begin
//#UC START# *AFD62513C0A3_493E78640269_impl*
 UCFormSet.OpenRelated;
 ChangeSynchroForm(sva_List_SynchroView_RelatedDoc);
//#UC END# *AFD62513C0A3_493E78640269_impl*
end;//TsdsList.OpenRelatedDoc

procedure TsdsList.OpenDocument;
//#UC START# *C6DFDCB71CD2_493E78640269_var*
//#UC END# *C6DFDCB71CD2_493E78640269_var*
begin
//#UC START# *C6DFDCB71CD2_493E78640269_impl*
 UCFormSet.OpenDocument;
 ChangeSynchroForm(sva_List_SynchroView_Document);
 SetData.DisableAutoOpenAnnotation := True;
//#UC END# *C6DFDCB71CD2_493E78640269_impl*
end;//TsdsList.OpenDocument

function TsdsList.pm_GetIsRelatedDocActive: Boolean;
//#UC START# *C79AA9D9E5A1_493E78640269get_var*
//#UC END# *C79AA9D9E5A1_493E78640269get_var*
begin
//#UC START# *C79AA9D9E5A1_493E78640269get_impl*
 Result := UCFormSet.CurrentSynchroForm = sva_List_SynchroView_RelatedDoc;
//#UC END# *C79AA9D9E5A1_493E78640269get_impl*
end;//TsdsList.pm_GetIsRelatedDocActive

function TsdsList.pm_GetIsAttributesActive: Boolean;
//#UC START# *D22CC2DAE849_493E78640269get_var*
//#UC END# *D22CC2DAE849_493E78640269get_var*
begin
//#UC START# *D22CC2DAE849_493E78640269get_impl*
 Result := UCFormSet.CurrentSynchroForm = sva_List_SynchroView_Attributes;
//#UC END# *D22CC2DAE849_493E78640269get_impl*
end;//TsdsList.pm_GetIsAttributesActive

procedure TsdsList.OpenAnnotation;
//#UC START# *E74EC4E20DB7_493E78640269_var*
//#UC END# *E74EC4E20DB7_493E78640269_var*
begin
//#UC START# *E74EC4E20DB7_493E78640269_impl*
 UCFormSet.OpenAnnotation;
 ChangeSynchroForm(sva_List_SynchroView_Annotation);
 SetData.DisableAutoOpenAnnotation := False;
//#UC END# *E74EC4E20DB7_493E78640269_impl*
end;//TsdsList.OpenAnnotation

function TsdsList.pm_GetIsAnnotationActive: Boolean;
//#UC START# *FB06C8ED7916_493E78640269get_var*
//#UC END# *FB06C8ED7916_493E78640269get_var*
begin
//#UC START# *FB06C8ED7916_493E78640269get_impl*
 Result := UCFormSet.CurrentSynchroForm = sva_List_SynchroView_Annotation;
//#UC END# *FB06C8ED7916_493E78640269get_impl*
end;//TsdsList.pm_GetIsAnnotationActive

procedure TsdsList.OpenCorrespondents;
begin
 if SetData.dsCorrespondentsRef.IsEmpty then
 begin
  UCFormSet.OpenCorrespondents;
  Refresh;
 end;
end;

procedure TsdsList.OpenRespondents;
begin
 if SetData.dsRespondentsRef.IsEmpty then
 begin
  UCFormSet.OpenRespondents;
  Refresh;
 end;
end;

{$If not defined(NoVCM)}
procedure TsdsList.DataExchange;
//#UC START# *47F37DF001FE_493E78640269_var*
var
 l_Data : IdeDocumentListSet;
//#UC END# *47F37DF001FE_493E78640269_var*
begin
//#UC START# *47F37DF001FE_493E78640269_impl*
 SetData.List := InitialUseCaseData.List;
 SetData.NodeForPositioning := InitialUseCaseData.NodeForPositioning;
 if Supports(InitialUseCaseData, IdeDocumentListSet, l_Data) then
 try
  SetData.List_SynchroView_Form := l_Data.List_SynchroView_Form;
 finally
  l_Data := nil;
 end;//try..finally
//#UC END# *47F37DF001FE_493E78640269_impl*
end;//TsdsList.DataExchange
{$IfEnd} //not NoVCM

procedure TsdsList.DoOpenAttributes;
//#UC START# *47FDDACC0101_493E78640269_var*
//#UC END# *47FDDACC0101_493E78640269_var*
begin
//#UC START# *47FDDACC0101_493E78640269_impl*
 UCFormSet.OpenAttributes;
 ChangeSynchroForm(sva_List_SynchroView_Attributes);
//#UC END# *47FDDACC0101_493E78640269_impl*
end;//TsdsList.DoOpenAttributes

function TsdsList.NeedMakeDSAttributes: Boolean;
//#UC START# *47FE03AE0225_493E78640269_var*
//#UC END# *47FE03AE0225_493E78640269_var*
begin
//#UC START# *47FE03AE0225_493E78640269_impl*
 Result := (UCFormSet.CurrentSynchroForm = sva_List_SynchroView_Attributes) AND
           inherited NeedMakeDSAttributes;
//#UC END# *47FE03AE0225_493E78640269_impl*
end;//TsdsList.NeedMakeDSAttributes

procedure TsdsList.ClearAllDS;
//#UC START# *4925B7F00156_493E78640269_var*
//#UC END# *4925B7F00156_493E78640269_var*
begin
//#UC START# *4925B7F00156_493E78640269_impl*
 inherited;
 if (f_dsBaloonWarning <> nil) then
  f_dsBaloonWarning.Referred := nil;
 if (f_dsTextBaloonWarning <> nil) then
  f_dsTextBaloonWarning.Referred := nil;

 pm_GetdsAttributesRef.Referred := nil;
//#UC END# *4925B7F00156_493E78640269_impl*
end;//TsdsList.ClearAllDS

function TsdsList.DoChangeDocument(const aDoc: IdeDocInfo): Boolean;
//#UC START# *4925B9370022_493E78640269_var*

 function lp_CurrentSynchroRefDS: IvcmFormDataSourceRef;

   function lp_DSUserCRList(const aDS : IvcmFormDataSourceRef;
                                  aId : TnsUserCRListId): IvcmFormDataSourceRef;
   begin
    with SetData.UserCRListInfo[aId] do
     if not bsIsCRNodeAreNotAllDocuments(Node) then
      case ListType of
       crtCorrespondents:
        Result := SetData.dsCorrespondentsRef;
       crtRespondents:
        Result := SetData.dsRespondentsRef;
      end//case ListType of
     else
      Result := aDS;
   end;//lp_DSUserCRList

 begin//lp_CurrentSynchroRefDS
  case UCFormSet.CurrentSynchroForm of
   sva_List_SynchroView_Document:
    Result := SetData.dsDocumentRef;
   sva_List_SynchroView_RelatedDoc:
    Result := SetData.dsRelatedDocRef;
   sva_List_SynchroView_UserCR1:
    Result := lp_DSUserCRList(SetData.dsUserCR1Ref, ulFirst);
   sva_List_SynchroView_UserCR2:
    Result := lp_DSUserCRList(SetData.dsUserCR2Ref, ulSecond);
   sva_List_SynchroView_Attributes:
    Result := SetData.dsAttributesRef;
   sva_List_SynchroView_Annotation:
    Result := SetData.dsAnnotationRef;
   sva_List_SynchroView_SimilarDocuments:
    Result := SetData.dsSimilarDocumentsRef;
   else
   begin
    Result := nil;
    Assert(False);
   end;
  end;//case SetData.SynchroForm of
 end;//lp_CurrentSynchroRefDS

 function lp_NeedAutoOpenAnnotation: Boolean;
 var
  l_RefDS: IvcmFormDataSourceRef;
 begin
  // Добавили f_disableAutoOpenAnnotation, для http://mdp.garant.ru/pages/viewpage.action?pageId=319488369
 if SetData.DisableAutoOpenAnnotation or
     (SetData.Default_List_SynchroView_Form <> sva_List_SynchroView_Annotation) then
  begin
   Result := False;
   Exit;
  end;//if f_disableAutoOpenAnnotation or (SetData.DefaultSynchroForm <> bs_lsfAnnotation) then
  l_RefDS := lp_CurrentSynchroRefDS;
  try
   Result := (l_RefDS <> nil);
  finally
   l_RefDS := nil;
  end;//try..finally
 end;//lp_NeedAutoOpenAnnotation

 function lp_CanOpenSynchroForm: Boolean;
 begin
  case SetData.List_SynchroView_Form of
   sva_List_SynchroView_None:
    begin
     Assert(False);
     Result := False;
    end;
   sva_List_SynchroView_Document:
    Result := pm_GetHasDocument;
   sva_List_SynchroView_RelatedDoc:
    Result := pm_GetHasRelatedDoc;
   sva_List_SynchroView_UserCR1,
   sva_List_SynchroView_UserCR2:
    Result := True;
   sva_List_SynchroView_Attributes:
    Result := pm_GetHasAttributes;
   sva_List_SynchroView_Annotation:
    Result := pm_GetHasAnnotation;
   sva_List_SynchroView_SimilarDocuments:
    Result := pm_GetHasSimilarDocuments;
  end;
 end;//lp_CanOpenSynchroForm

 function lp_GetDefaultSynchroForm: TList_SynchroView_Areas;
 begin
   if pm_GetHasAnnotation then
    Result := sva_List_SynchroView_Annotation
   else
    Result := UCFormSet.DefaultSynchroForm;
 end;//lp_GetDefaultSynchroForm

var
 l_SynchroForm: TList_SynchroView_Areas;
//#UC END# *4925B9370022_493E78640269_var*
begin
//#UC START# *4925B9370022_493E78640269_impl*
 ClearAllDS;
 Result := inherited DoChangeDocument(aDoc);
 if Result then
 begin
  // Если пользователь руками включил форму синхронного просмотра, то не
  // показываем аннотацию всегда, когда она есть (CQ: OIT5-26040):
  if lp_NeedAutoOpenAnnotation then
  begin
   // Если нужно показывать аннотацию и она есть - покажем ее. Если нет - покажем
   // форму синхронного просмотра по умолчанию.
   if pm_GetHasAnnotation then
    l_SynchroForm := sva_List_SynchroView_Annotation
   else
    l_SynchroForm := UCFormSet.DefaultSynchroForm;
   ChangeSynchroForm(l_SynchroForm, False, False);
  end
  else
  begin
   // Если выбранную форму синхронного просмотра показать нельзя - попробуем показать
   // аннотацию, а если и ее нельзя - форму по умолчанию
   if not lp_CanOpenSynchroForm then
    ChangeSynchroForm(lp_GetDefaultSynchroForm, False, False)
   else
   begin
    // Выбранную форму показать можно
    UCFormSet.CurrentSynchroForm := SetData.List_SynchroView_Form;
   end;
  end;//lp_NeedAutoOpenAnnotation
  Refresh;
 end;//Result
//#UC END# *4925B9370022_493E78640269_impl*
end;//TsdsList.DoChangeDocument

{$If not defined(NoVCM)}
procedure TsdsList.ClearAreas;
 {-}
begin
 if (f_dsBaloonWarning <> nil) then f_dsBaloonWarning.Referred := nil;
 if (f_dsListAnalize <> nil) then f_dsListAnalize.Referred := nil;
 if (f_dsTextBaloonWarning <> nil) then f_dsTextBaloonWarning.Referred := nil;
 pm_GetdsListRef.Referred := nil;
 pm_GetdsSynchroViewRef.Referred := nil;
 pm_GetdsListInfoRef.Referred := nil;
 pm_GetdsFiltersRef.Referred := nil;
 inherited;
end;//TsdsList.ClearAreas
{$IfEnd} //not NoVCM

function TsdsList.NeedMakeDocument: Boolean;
//#UC START# *493D1BE601B1_493E78640269_var*
//#UC END# *493D1BE601B1_493E78640269_var*
begin
//#UC START# *493D1BE601B1_493E78640269_impl*
 Result := (UCFormSet.CurrentSynchroForm = sva_List_SynchroView_Document) and
           not inherited NeedMakeDocumentWithFlash and
           inherited NeedMakeDocument;
//#UC END# *493D1BE601B1_493E78640269_impl*
end;//TsdsList.NeedMakeDocument

function TsdsList.NeedMakeDSUserCRList1: Boolean;
//#UC START# *493D51B00058_493E78640269_var*
//#UC END# *493D51B00058_493E78640269_var*
begin
//#UC START# *493D51B00058_493E78640269_impl*
 Result := (UCFormSet.CurrentSynchroForm = sva_List_SynchroView_UserCR1) and
  (SetData.UserCRListInfo[ulFirst].KindOfList = bs_ulUserCR);
//#UC END# *493D51B00058_493E78640269_impl*
end;//TsdsList.NeedMakeDSUserCRList1

function TsdsList.NeedMakeDSUserCRList2: Boolean;
//#UC START# *493D51BE03DC_493E78640269_var*
//#UC END# *493D51BE03DC_493E78640269_var*
begin
//#UC START# *493D51BE03DC_493E78640269_impl*
 Result := (UCFormSet.CurrentSynchroForm = sva_List_SynchroView_UserCR2) and
  (SetData.UserCRListInfo[ulSecond].KindOfList = bs_ulUserCR);
//#UC END# *493D51BE03DC_493E78640269_impl*
end;//TsdsList.NeedMakeDSUserCRList2

function TsdsList.NeedMakeDSCorrespondents: Boolean;
//#UC START# *493D51D0039B_493E78640269_var*
//#UC END# *493D51D0039B_493E78640269_var*
begin
//#UC START# *493D51D0039B_493E78640269_impl*
 Result := NeedMakeDSFullCR(crtCorrespondents);
//#UC END# *493D51D0039B_493E78640269_impl*
end;//TsdsList.NeedMakeDSCorrespondents

function TsdsList.NeedMakeDSRespondents: Boolean;
//#UC START# *493D51DF022F_493E78640269_var*
//#UC END# *493D51DF022F_493E78640269_var*
begin
//#UC START# *493D51DF022F_493E78640269_impl*
 Result := NeedMakeDSFullCR(crtRespondents);
//#UC END# *493D51DF022F_493E78640269_impl*
end;//TsdsList.NeedMakeDSRespondents

function TsdsList.NeedMakeDocumentWithFlash: Boolean;
//#UC START# *493D62FF02AF_493E78640269_var*
//#UC END# *493D62FF02AF_493E78640269_var*
begin
//#UC START# *493D62FF02AF_493E78640269_impl*
 Result := (UCFormSet.CurrentSynchroForm = sva_List_SynchroView_Document) and
  inherited NeedMakeDocumentWithFlash;
//#UC END# *493D62FF02AF_493E78640269_impl*
end;//TsdsList.NeedMakeDocumentWithFlash

function TsdsList.DoChangeCRType(const aNode: INodeBase;
  aType: TlstCRType;
  IsCRToPart: Boolean): Boolean;
//#UC START# *493D6B5B02DE_493E78640269_var*
//#UC END# *493D6B5B02DE_493E78640269_var*
begin
//#UC START# *493D6B5B02DE_493E78640269_impl*
 Result := False;
 if not IsCRToPart then
 begin
  if Assigned(aNode) then
  begin
   case aType of
    crtCorrespondents:
    begin
     Result := ChangeCorrType(aNode);
     // Это нужно потому, что в форме синхронного просмотра тип используется и
     // для респондентов и корреспондентов. Нужно по новому получать HasResp,
     // HasCorr.
     ChangeRespType(aNode);
    end;
    crtRespondents:
    begin
     Result := ChangeRespType(aNode);
     // Это нужно потому, что в форме синхронного просмотра тип используется и
     // для респондентов и корреспондентов. Нужно по новому получать HasResp,
     // HasCorr.
     ChangeCorrType(aNode);
    end;
   end;
   if Result then
    Refresh;
  end;//Assigned(aNode)
 end//not IsCRToPart
 else
  Assert(not IsCRToPart, caRespCorrestUnsupported);
//#UC END# *493D6B5B02DE_493E78640269_impl*
end;//TsdsList.DoChangeCRType

function TsdsList.NeedMakeRelatedDoc: Boolean;
//#UC START# *493D6E7E0282_493E78640269_var*
//#UC END# *493D6E7E0282_493E78640269_var*
begin
//#UC START# *493D6E7E0282_493E78640269_impl*
 Result := (UCFormSet.CurrentSynchroForm = sva_List_SynchroView_RelatedDoc) AND
           inherited NeedMakeRelatedDoc;
//#UC END# *493D6E7E0282_493E78640269_impl*
end;//TsdsList.NeedMakeRelatedDoc

function TsdsList.NeedMakeAnnotation: Boolean;
//#UC START# *493D6EAB0019_493E78640269_var*
//#UC END# *493D6EAB0019_493E78640269_var*
begin
//#UC START# *493D6EAB0019_493E78640269_impl*
 Result := (UCFormSet.CurrentSynchroForm = sva_List_SynchroView_Annotation) AND
  inherited NeedMakeAnnotation;
//#UC END# *493D6EAB0019_493E78640269_impl*
end;//TsdsList.NeedMakeAnnotation

function TsdsList.NeedMakeSimilarDocuments: Boolean;
//#UC START# *493D6EC40228_493E78640269_var*
//#UC END# *493D6EC40228_493E78640269_var*
begin
//#UC START# *493D6EC40228_493E78640269_impl*
 Result := (UCFormSet.CurrentSynchroForm = sva_List_SynchroView_SimilarDocuments) AND
  inherited NeedMakeSimilarDocuments;
//#UC END# *493D6EC40228_493E78640269_impl*
end;//TsdsList.NeedMakeSimilarDocuments

function TsdsList.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_493E78640269_var*
//#UC END# *4A60B23E00C3_493E78640269_var*
begin
//#UC START# *4A60B23E00C3_493E78640269_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
  if IID.EQ(IDynList) then
  begin
   Assert(false, 'Кому бы мог понадобиться такой запрос IDynList. Его надо вывести на атрибуты IsdsList');
   IDynList(Obj) := SetData.List;
   Result.SetOK;
  end;//IID.EQ(IDynList)
//#UC END# *4A60B23E00C3_493E78640269_impl*
end;//TsdsList.COMQueryInterface

{$If not defined(NoVCM)}
function TsdsList.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_493E78640269_var*
//#UC END# *53B3BF9C00EF_493E78640269_var*
begin
//#UC START# *53B3BF9C00EF_493E78640269_impl*
 Result := nsTabIconIndex(titList);
//#UC END# *53B3BF9C00EF_493E78640269_impl*
end;//TsdsList.DoGetFormSetImageIndex
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TsdsList.GetDataForClone: _InitDataType_;
//#UC START# *55C1DD070354_493E78640269_var*
//#UC END# *55C1DD070354_493E78640269_var*
begin
//#UC START# *55C1DD070354_493E78640269_impl*
 Result := pm_GetDsList.NewList as IdeDocumentList;
//#UC END# *55C1DD070354_493E78640269_impl*
end;//TsdsList.GetDataForClone
{$IfEnd} //not NoVCM

// Методы преобразования к реализуемым интерфейсам

function TsdsList.As_IucpFilters: IucpFilters;
begin
 Result := Self;
end;

function TsdsList.As_IucpNodeForPositioningHolder: IucpNodeForPositioningHolder;
begin
 Result := Self;
end;

function TsdsList.As_IbsDataProducer: IbsDataProducer;
begin
 Result := Self;
end;

function TsdsList.As_InsWarningGenerator: InsWarningGenerator;
begin
 Result := Self;
end;

function TsdsList.As_IucpBaseSearchSupportQuery: IucpBaseSearchSupportQuery;
begin
 Result := Self;
end;

function TsdsList.As_IsdsListPrim: IsdsListPrim;
begin
 Result := Self;
end;

function TsdsList.As_IsdsListNameHolder: IsdsListNameHolder;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_MissingAnalisisTree
 str_MissingAnalisisTree.Init;
{$IfEnd} //not Admin AND not Monitorings

end.