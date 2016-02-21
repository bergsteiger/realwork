unit sdsList;
 {* Список }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\List\sdsList.pas"
// Стереотип: "UseCaseControllerImp"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkWithListInterfaces
 , PrimListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypes
 , l3TreeInterfaces
 , DocumentAndListInterfaces
 , l3Interfaces
 , DynamicDocListUnit
 , l3IID
 , DocumentInterfaces
 , DynamicTreeUnit
 , DocInfoInterfaces
 , ExternalObjectUnit
 , BaseDocumentWithAttributesInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3NotifyPtrList
 , afwInterfaces
 , bsInterfaces
 , nsTypes
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки Local }
 str_MissingAnalisisTree: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MissingAnalisisTree'; rValue : 'В вашем информационном банке отсутствуют данные, необходимые для работы функции "Анализ списка". Для устранения, пожалуйста, обратитесь в обслуживающую Вас организацию:' + #13#10 + #13#10 +
'%s');
  {* 'В вашем информационном банке отсутствуют данные, необходимые для работы функции "Анализ списка". Для устранения, пожалуйста, обратитесь в обслуживающую Вас организацию:' + #13#10 + #13#10 +
'%s' }

type
 _InitDataType_ = IdeDocumentList;
 _SetDataType_ = IdList;
 _SetType_ = IsdsList;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsDocInfo.imp.pas}
 _nsListWarningGenerator_Parent_ = _sdsDocInfo_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\PrimListControllers\nsListWarningGenerator.imp.pas}
 TsdsList = class(_nsListWarningGenerator_, IsdsList, IucpFilters, IucpNodeForPositioningHolder, IbsDataProducer, InsWarningGenerator, IucpBaseSearchSupportQuery, IsdsListPrim, IsdsListNameHolder)
  {* Список }
  private
   f_DisableAutoOpenAnnotation: Boolean;
   f_dsBaloonWarning: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsBaloonWarning }
   f_dsListAnalize: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsListAnalize }
   f_dsTextBaloonWarning: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsTextBaloonWarning }
  private
   procedure NeedMakeForFullCR(aId: TnsUserCRListId);
    {* установить состояние для СКР }
   function NeedMakeDSFullCR(aType: TlstCRType): Boolean;
    {* нужно ли создавать бизнес объект для полного СКР }
   function HasUserCRList(aId: TnsUserCRListId): Boolean;
    {* определим наличие пользовательского СКР }
  protected
   procedure OpenFilters;
    {* открыть форму фильтры }
   procedure ChangeSynchroForm(aSynchroForm: TList_SynchroView_Areas);
    {* Переключает форму синхронного просмотра }
   function As_IucpFilters: IucpFilters;
    {* Метод приведения нашего интерфейса к IucpFilters }
   function As_IucpNodeForPositioningHolder: IucpNodeForPositioningHolder;
    {* Метод приведения нашего интерфейса к IucpNodeForPositioningHolder }
   function As_IbsDataProducer: IbsDataProducer;
    {* Метод приведения нашего интерфейса к IbsDataProducer }
   function As_InsWarningGenerator: InsWarningGenerator;
    {* Метод приведения нашего интерфейса к InsWarningGenerator }
   function As_IucpBaseSearchSupportQuery: IucpBaseSearchSupportQuery;
    {* Метод приведения нашего интерфейса к IucpBaseSearchSupportQuery }
   function As_IsdsListPrim: IsdsListPrim;
    {* Метод приведения нашего интерфейса к IsdsListPrim }
   function As_IsdsListNameHolder: IsdsListNameHolder;
    {* Метод приведения нашего интерфейса к IsdsListNameHolder }
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
   {$IfEnd} // NOT Defined(NoVCM)
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
   function Get_dsListPrim: IdsList;
   function Get_IsShortList: Boolean;
   function MakeFullList(const aNodeForPositioning: Il3SimpleNode): IdeDocumentList;
   function pm_GetIsSnippet: Boolean;
   function MakeAnalizeTree: Il3SimpleTree;
   function pm_GetIsSimilarDocumentsActive: Boolean;
   procedure ReplaceList(const aList: IDynList);
   function pm_GetdsBaloonWarning: IdsWarning;
   function pm_GetdsListAnalize: IdsListAnalize;
   function pm_GetdsTextBaloonWarning: IdsWarning;
   function pm_GetdsList: IdsDocumentList;
   function pm_GetdsSynchroView: IdsSynchroView;
   function pm_GetdsListInfo: IdsListInfo;
   function pm_GetdsFilters: IdsFilters;
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
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - вызывается после получения данных инициализации. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DoOpenAttributes; override;
    {* - атрибуты. }
   function NeedMakeDSAttributes: Boolean; override;
    {* - необходимость создания БОФ атрибутов. }
   procedure ClearAllDS; override;
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
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
   {$If NOT Defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetDataForClone: _InitDataType_; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
    {* Реализация запроса интерфейса }
 end;//TsdsList
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsAnnotation
 , dsSynchroView
 , dsListInfo
 , dsMainList
 , dsFilters
 , dsDocument
 , dList
 , SysUtils
 , l3Base
 , DebugStr
 , afwFacade
 , nsConst
 , bsUtils
 , nsTreeStruct
 , nsINodeWrap
 , dsWarning
 , Document_Const
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , DataAdapter
 , l3Tree
 , l3NodesModelPart
 , BaseTypesUnit
 , l3String
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , dsListAnalize
 , dsSynchroViewWarning
 , dsSynchroViewDocument
 , nsTabbedInterfaceTypes
 , l3MessageID
 , dsDocumentListCR
 , dsDocumentList
 , dsDocumentWithFlash
 , bsFrozenNode
 , deDocumentListCR
 , deDocInfo
 , bsDataContainer
 , deDocumentList
 , bsUserCRListInfo
 , l3Types
 , l3Utils
 , nsUtils
 , dsTranslation
 , dsRelatedDoc
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , dsChronology
 , dsAttributes
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , afwSettingsChangePublisher
 , nsDocumentWarningGenerator
 , BaloonWarningUserTypes_remListModified_UserType
 , UnderControlInterfaces
 , nsListWarningGenerator
;

type _Instance_R_ = TsdsList;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsDocInfo.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\PrimListControllers\nsListWarningGenerator.imp.pas}

procedure TsdsList.NeedMakeForFullCR(aId: TnsUserCRListId);
 {* установить состояние для СКР }
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
 {* нужно ли создавать бизнес объект для полного СКР }
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
 {* определим наличие пользовательского СКР }
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
 {* открыть форму фильтры }
//#UC START# *493E7EAC0171_493E78640269_var*
//#UC END# *493E7EAC0171_493E78640269_var*
begin
//#UC START# *493E7EAC0171_493E78640269_impl*
 if SetData.dsFiltersRef.IsEmpty then
  UCFormSet.AsIucpFilters.Open;
//#UC END# *493E7EAC0171_493E78640269_impl*
end;//TsdsList.OpenFilters

procedure TsdsList.ChangeSynchroForm(aSynchroForm: TList_SynchroView_Areas);
 {* Переключает форму синхронного просмотра }
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

function TsdsList.As_IucpFilters: IucpFilters;
 {* Метод приведения нашего интерфейса к IucpFilters }
begin
 Result := Self;
end;//TsdsList.As_IucpFilters

function TsdsList.As_IucpNodeForPositioningHolder: IucpNodeForPositioningHolder;
 {* Метод приведения нашего интерфейса к IucpNodeForPositioningHolder }
begin
 Result := Self;
end;//TsdsList.As_IucpNodeForPositioningHolder

function TsdsList.As_IbsDataProducer: IbsDataProducer;
 {* Метод приведения нашего интерфейса к IbsDataProducer }
begin
 Result := Self;
end;//TsdsList.As_IbsDataProducer

function TsdsList.As_InsWarningGenerator: InsWarningGenerator;
 {* Метод приведения нашего интерфейса к InsWarningGenerator }
begin
 Result := Self;
end;//TsdsList.As_InsWarningGenerator

function TsdsList.As_IucpBaseSearchSupportQuery: IucpBaseSearchSupportQuery;
 {* Метод приведения нашего интерфейса к IucpBaseSearchSupportQuery }
begin
 Result := Self;
end;//TsdsList.As_IucpBaseSearchSupportQuery

function TsdsList.As_IsdsListPrim: IsdsListPrim;
 {* Метод приведения нашего интерфейса к IsdsListPrim }
begin
 Result := Self;
end;//TsdsList.As_IsdsListPrim

function TsdsList.As_IsdsListNameHolder: IsdsListNameHolder;
 {* Метод приведения нашего интерфейса к IsdsListNameHolder }
begin
 Result := Self;
end;//TsdsList.As_IsdsListNameHolder

{$If NOT Defined(NoVCM)}
function TsdsList.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_493E78640269_var*
//#UC END# *47F3778403D9_493E78640269_var*
begin
//#UC START# *47F3778403D9_493E78640269_impl*
 Result := TdList.Make;
//#UC END# *47F3778403D9_493E78640269_impl*
end;//TsdsList.MakeData
{$IfEnd} // NOT Defined(NoVCM)

procedure TsdsList.Open;
 {* открыть форму фильтры }
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
 {* - освободить узел для позиционирования. }
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
 {* обновляет информацию о списке }
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
 {* Вызывается при запросе данных у бизнес объекта формы. Результат определяет нужно ли возвращать данные форме }
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

function TsdsList.Get_dsListPrim: IdsList;
//#UC START# *49AE664F006B_493E78640269get_var*
//#UC END# *49AE664F006B_493E78640269get_var*
begin
//#UC START# *49AE664F006B_493E78640269get_impl*
 Result := pm_GetDsList;
//#UC END# *49AE664F006B_493E78640269get_impl*
end;//TsdsList.Get_dsListPrim

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

function TsdsList.pm_GetdsBaloonWarning: IdsWarning;
//#UC START# *4DB984CF00E5_493E78640269get_var*
//#UC END# *4DB984CF00E5_493E78640269get_var*
begin
//#UC START# *4DB984CF00E5_493E78640269get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DB984CF00E5_493E78640269get_impl*
end;//TsdsList.pm_GetdsBaloonWarning

function TsdsList.pm_GetdsListAnalize: IdsListAnalize;
//#UC START# *4E36899100B5_493E78640269get_var*
//#UC END# *4E36899100B5_493E78640269get_var*
begin
//#UC START# *4E36899100B5_493E78640269get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E36899100B5_493E78640269get_impl*
end;//TsdsList.pm_GetdsListAnalize

function TsdsList.pm_GetdsTextBaloonWarning: IdsWarning;
//#UC START# *4EFC594701E9_493E78640269get_var*
//#UC END# *4EFC594701E9_493E78640269get_var*
begin
//#UC START# *4EFC594701E9_493E78640269get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EFC594701E9_493E78640269get_impl*
end;//TsdsList.pm_GetdsTextBaloonWarning

function TsdsList.pm_GetdsList: IdsDocumentList;
//#UC START# *500CFA670146_493E78640269get_var*
//#UC END# *500CFA670146_493E78640269get_var*
begin
//#UC START# *500CFA670146_493E78640269get_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CFA670146_493E78640269get_impl*
end;//TsdsList.pm_GetdsList

function TsdsList.pm_GetdsSynchroView: IdsSynchroView;
//#UC START# *500CFA9800C8_493E78640269get_var*
//#UC END# *500CFA9800C8_493E78640269get_var*
begin
//#UC START# *500CFA9800C8_493E78640269get_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CFA9800C8_493E78640269get_impl*
end;//TsdsList.pm_GetdsSynchroView

function TsdsList.pm_GetdsListInfo: IdsListInfo;
//#UC START# *500CFABF0356_493E78640269get_var*
//#UC END# *500CFABF0356_493E78640269get_var*
begin
//#UC START# *500CFABF0356_493E78640269get_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CFABF0356_493E78640269get_impl*
end;//TsdsList.pm_GetdsListInfo

function TsdsList.pm_GetdsFilters: IdsFilters;
//#UC START# *500CFAE50070_493E78640269get_var*
//#UC END# *500CFAE50070_493E78640269get_var*
begin
//#UC START# *500CFAE50070_493E78640269get_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CFAE50070_493E78640269get_impl*
end;//TsdsList.pm_GetdsFilters

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
 {* Открывает ViewArea "атрибуты документа" }
//#UC START# *5BBD66420FA0_493E78640269_var*
//#UC END# *5BBD66420FA0_493E78640269_var*
begin
//#UC START# *5BBD66420FA0_493E78640269_impl*
 inherited OpenAttributes;
//#UC END# *5BBD66420FA0_493E78640269_impl*
end;//TsdsList.OpenAttributes

procedure TsdsList.OpenUserCR1;
 {* Открывает ViewArea "БОФ пользовательский СКР1" }
//#UC START# *6034AC85B7BF_493E78640269_var*
//#UC END# *6034AC85B7BF_493E78640269_var*
begin
//#UC START# *6034AC85B7BF_493E78640269_impl*
 NeedMakeForFullCR(ulFirst);
 ChangeSynchroForm(sva_List_SynchroView_UserCR1);
//#UC END# *6034AC85B7BF_493E78640269_impl*
end;//TsdsList.OpenUserCR1

procedure TsdsList.OpenSimilarDocuments;
 {* Открывает ViewArea "БОФ похожие документы" }
//#UC START# *6499B6E1DD77_493E78640269_var*
//#UC END# *6499B6E1DD77_493E78640269_var*
begin
//#UC START# *6499B6E1DD77_493E78640269_impl*
 UCFormSet.OpenSimilar;
 ChangeSynchroForm(sva_List_SynchroView_SimilarDocuments);
//#UC END# *6499B6E1DD77_493E78640269_impl*
end;//TsdsList.OpenSimilarDocuments

procedure TsdsList.OpenUserCR2;
 {* Открывает ViewArea "БОФ пользовательский СКР2" }
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
 {* Открывает ViewArea "справка к документу" }
//#UC START# *AFD62513C0A3_493E78640269_var*
//#UC END# *AFD62513C0A3_493E78640269_var*
begin
//#UC START# *AFD62513C0A3_493E78640269_impl*
 UCFormSet.OpenRelated;
 ChangeSynchroForm(sva_List_SynchroView_RelatedDoc);
//#UC END# *AFD62513C0A3_493E78640269_impl*
end;//TsdsList.OpenRelatedDoc

procedure TsdsList.OpenDocument;
 {* Открывает ViewArea "Собственно документ" }
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
 {* Открывает ViewArea "аннотация к документу" }
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

{$If NOT Defined(NoVCM)}
procedure TsdsList.DataExchange;
 {* - вызывается после получения данных инициализации. }
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
{$IfEnd} // NOT Defined(NoVCM)

procedure TsdsList.DoOpenAttributes;
 {* - атрибуты. }
//#UC START# *47FDDACC0101_493E78640269_var*
//#UC END# *47FDDACC0101_493E78640269_var*
begin
//#UC START# *47FDDACC0101_493E78640269_impl*
 UCFormSet.OpenAttributes;
 ChangeSynchroForm(sva_List_SynchroView_Attributes);
//#UC END# *47FDDACC0101_493E78640269_impl*
end;//TsdsList.DoOpenAttributes

function TsdsList.NeedMakeDSAttributes: Boolean;
 {* - необходимость создания БОФ атрибутов. }
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

{$If NOT Defined(NoVCM)}
procedure TsdsList.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_493E78640269_var*
//#UC END# *4938F7E702B7_493E78640269_var*
begin
//#UC START# *4938F7E702B7_493E78640269_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_493E78640269_impl*
end;//TsdsList.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

function TsdsList.NeedMakeDocument: Boolean;
 {* Определяет - нужно ли создавать область ввода для документа }
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
 {* вызывается при изменении типа корреспондентов/респондентов }
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
 {* Реализация запроса интерфейса }
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

{$If NOT Defined(NoVCM)}
function TsdsList.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_493E78640269_var*
//#UC END# *53B3BF9C00EF_493E78640269_var*
begin
//#UC START# *53B3BF9C00EF_493E78640269_impl*
 Result := nsTabIconIndex(titList);
//#UC END# *53B3BF9C00EF_493E78640269_impl*
end;//TsdsList.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TsdsList.GetDataForClone: _InitDataType_;
//#UC START# *55C1DD070354_493E78640269_var*
//#UC END# *55C1DD070354_493E78640269_var*
begin
//#UC START# *55C1DD070354_493E78640269_impl*
 Result := pm_GetDsList.NewList as IdeDocumentList;
//#UC END# *55C1DD070354_493E78640269_impl*
end;//TsdsList.GetDataForClone
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_MissingAnalisisTree.Init;
 {* Инициализация str_MissingAnalisisTree }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
