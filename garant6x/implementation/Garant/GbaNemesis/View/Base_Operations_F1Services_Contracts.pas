unit Base_Operations_F1Services_Contracts;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_F1Services_Contracts.pas"
// ���������: "VCMContracts"
// ������� ������: "F1Services" MUID: (5795D66F0385)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaseTypesUnit
 , BaseTreeSupportUnit
 , DynamicDocListUnit
 , FoldersUnit
 , DocumentUnit
 , DynamicTreeUnit
 , FiltersUnit
 , MonitoringUnit
 , UnderControlUnit
 , SearchUnit
 , l3Interfaces
 , afwInterfaces
 , l3TreeInterfaces
 , nsQueryInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
 , l3Chars
 , bsTypes
 , eeInterfaces
 , DocumentAndListInterfaces
 , SimpleListInterfaces
 , PresentationInterfaces
 , FoldersDomainInterfaces
 , ConfigInterfaces
 , DocumentDomainInterfaces
 , ChatTypes
 , ChatInterfaces
 , WorkJournalInterfaces
 , BaseSearchInterfaces
 , ConsultationDomainInterfaces
 , PrimPrimListInterfaces
 , DocumentInterfaces
 , PrimBaseSearchInterfaces
 , MainMenuUnit
 , Common_F1CommonServices_Contracts
 , F1_Application_Template_Services
 , l3ProtoObject
 , Classes
 , nsTypes
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 , bsTypesNew
 , ddAppConfigTypes
 , l3StringIDEx
 , l3CProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ������������ ������ ChangeableMainMenuTypeName }
 str_ChangeableMainMenuType: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType'; rValue : '��� ���������� ����� ��������� ����');
  {* ��� ���������� ����� ��������� ���� }
 pi_TMainMenuService_ChangeableMainMenuType = '/��� ���������� ����� ��������� ����';
  {* ������������� ��������� "��� ���������� ����� ��������� ����" }
 dv_TMainMenuService_ChangeableMainMenuType = 0;
  {* �������� ��-��������� ��������� "��� ���������� ����� ��������� ����" }
 {* ������������ ������ ChangeableMainMenuTypeValues }
 str_ChangeableMainMenuType_ST_FINANCE: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_FINANCE'; rValue : '������ � �������');
  {* ������ � ������� }
 str_ChangeableMainMenuType_ST_HR: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_HR'; rValue : '������ ��� ����������');
  {* ������ ��� ���������� }
 str_ChangeableMainMenuType_ST_LEGAL: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_LEGAL'; rValue : '������ ��� �������');
  {* ������ ��� ������� }
 str_ChangeableMainMenuType_ST_BUDGET_ORGS: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ChangeableMainMenuType_ST_BUDGET_ORGS'; rValue : '��������� �����������');
  {* ��������� ����������� }
 {* ������������ ������ ShowChangesInfoName }
 str_ShowChangesInfo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo'; rValue : '���������� ������� ��������� � ���������');
  {* ���������� ������� ��������� � ��������� }
 pi_TDocumentService_ShowChangesInfo = '������ � ����������/���������� ������� ��������� � ���������';
  {* ������������� ��������� "���������� ������� ��������� � ���������" }
 dv_TDocumentService_ShowChangesInfo = False;
  {* �������� ��-��������� ��������� "���������� ������� ��������� � ���������" }
 {* ������������ ������ ShowChangesInfoValues }
 str_ShowChangesInfo_Collapsed: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo_Collapsed'; rValue : '� ��������� ����');
  {* � ��������� ���� }
 str_ShowChangesInfo_Expanded: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ShowChangesInfo_Expanded'; rValue : '� ����������� ����');
  {* � ����������� ���� }
 {* ����� �������������� �������������� ����� ShowChangesInfoValues }
 ShowChangesInfoValuesMap: array [Boolean] of Pl3StringIDEx = (
 @str_ShowChangesInfo_Collapsed
 , @str_ShowChangesInfo_Expanded
 );

 (*
 MChatService = interface
  {* �������� ������� TChatService }
  function MakeChatDispatcher: IbsChatDispatcher;
  function OpenAddUserDialog: IvcmEntityForm;
  function OpenChatWindow(anUID: TbsUserID;
   const aName: Il3CString): IvcmEntityForm;
  function OpenHistoryWindow(anUID: TbsUserID;
   const aName: Il3CString): IvcmEntityForm;
 end;//MChatService
 *)

type
 IChatService = interface
  {* ��������� ������� TChatService }
  function MakeChatDispatcher: IbsChatDispatcher;
  function OpenAddUserDialog: IvcmEntityForm;
  function OpenChatWindow(anUID: TbsUserID;
   const aName: Il3CString): IvcmEntityForm;
  function OpenHistoryWindow(anUID: TbsUserID;
   const aName: Il3CString): IvcmEntityForm;
 end;//IChatService

 TChatService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IChatService;
    {* ������� ���������� ������� IChatService }
  protected
   procedure pm_SetAlien(const aValue: IChatService);
   procedure ClearFields; override;
  public
   function MakeChatDispatcher: IbsChatDispatcher;
   function OpenAddUserDialog: IvcmEntityForm;
   function OpenChatWindow(anUID: TbsUserID;
    const aName: Il3CString): IvcmEntityForm;
   function OpenHistoryWindow(anUID: TbsUserID;
    const aName: Il3CString): IvcmEntityForm;
   class function Instance: TChatService;
    {* ����� ��������� ���������� ���������� TChatService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IChatService
    write pm_SetAlien;
    {* ������� ���������� ������� IChatService }
 end;//TChatService

 (*
 MDictionService = interface
  {* �������� ������� TDictionService }
  procedure OpenDictionary(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
   {* ��������� �������� ������� }
  procedure OpenTermByContext(const aContext: Il3CString;
   aLanguage: TbsLanguage);
   {* ��������� ������ �� ��������� }
 end;//MDictionService
 *)

 IDictionService = interface
  {* ��������� ������� TDictionService }
  procedure OpenDictionary(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
   {* ��������� �������� ������� }
  procedure OpenTermByContext(const aContext: Il3CString;
   aLanguage: TbsLanguage);
   {* ��������� ������ �� ��������� }
 end;//IDictionService

 TDictionService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IDictionService;
    {* ������� ���������� ������� IDictionService }
  protected
   procedure pm_SetAlien(const aValue: IDictionService);
   procedure ClearFields; override;
  public
   procedure OpenDictionary(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* ��������� �������� ������� }
   procedure OpenTermByContext(const aContext: Il3CString;
    aLanguage: TbsLanguage);
    {* ��������� ������ �� ��������� }
   class function Instance: TDictionService;
    {* ����� ��������� ���������� ���������� TDictionService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IDictionService
    write pm_SetAlien;
    {* ������� ���������� ������� IDictionService }
 end;//TDictionService

 (*
 MInpharmService = interface
  {* �������� ������� TInpharmService }
  procedure OpenDrugListIfNeeded(const aContainer: IvcmContainer);
  procedure OpenInpharmMainMenu(const aContainer: IvcmContainer);
  procedure MedicFirms(const aContainer: IvcmContainer);
  procedure OpenDrugDocument(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
  procedure OpenDrugList(const aList: IdeList;
   const aContainer: IvcmContainer);
  procedure OpenMedicDiction(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
  procedure OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
 end;//MInpharmService
 *)

 IInpharmService = interface
  {* ��������� ������� TInpharmService }
  procedure OpenDrugListIfNeeded(const aContainer: IvcmContainer);
  procedure OpenInpharmMainMenu(const aContainer: IvcmContainer);
  procedure MedicFirms(const aContainer: IvcmContainer);
  procedure OpenDrugDocument(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
  procedure OpenDrugList(const aList: IdeList;
   const aContainer: IvcmContainer);
  procedure OpenMedicDiction(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
  procedure OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
 end;//IInpharmService

 TInpharmService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IInpharmService;
    {* ������� ���������� ������� IInpharmService }
  protected
   procedure pm_SetAlien(const aValue: IInpharmService);
   procedure ClearFields; override;
  public
   procedure OpenDrugListIfNeeded(const aContainer: IvcmContainer);
   procedure OpenInpharmMainMenu(const aContainer: IvcmContainer);
   procedure MedicFirms(const aContainer: IvcmContainer);
   procedure OpenDrugDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenDrugList(const aList: IdeList;
    const aContainer: IvcmContainer);
   procedure OpenMedicDiction(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   procedure OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   class function Instance: TInpharmService;
    {* ����� ��������� ���������� ���������� TInpharmService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IInpharmService
    write pm_SetAlien;
    {* ������� ���������� ������� IInpharmService }
 end;//TInpharmService

 (*
 MInternetAgentService = interface
  {* �������� ������� TInternetAgentService }
  procedure MakeInternetAgent(const anURL: Il3CString;
   const aContainer: IvcmContainer);
   {* ������ ������� ������ ��������-������ }
 end;//MInternetAgentService
 *)

 IInternetAgentService = interface
  {* ��������� ������� TInternetAgentService }
  procedure MakeInternetAgent(const anURL: Il3CString;
   const aContainer: IvcmContainer);
   {* ������ ������� ������ ��������-������ }
 end;//IInternetAgentService

 TInternetAgentService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IInternetAgentService;
    {* ������� ���������� ������� IInternetAgentService }
  protected
   procedure pm_SetAlien(const aValue: IInternetAgentService);
   procedure ClearFields; override;
  public
   procedure MakeInternetAgent(const anURL: Il3CString;
    const aContainer: IvcmContainer);
    {* ������ ������� ������ ��������-������ }
   class function Instance: TInternetAgentService;
    {* ����� ��������� ���������� ���������� TInternetAgentService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IInternetAgentService
    write pm_SetAlien;
    {* ������� ���������� ������� IInternetAgentService }
 end;//TInternetAgentService

 (*
 MDayTipsService = interface
  {* �������� ������� TDayTipsService }
  function ShowDayTipsAtStartup: IvcmEntityForm;
  procedure OpenTip(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
   {* ��������� ����� ��� }
 end;//MDayTipsService
 *)

 IDayTipsService = interface
  {* ��������� ������� TDayTipsService }
  function ShowDayTipsAtStartup: IvcmEntityForm;
  procedure OpenTip(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
   {* ��������� ����� ��� }
 end;//IDayTipsService

 TDayTipsService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IDayTipsService;
    {* ������� ���������� ������� IDayTipsService }
  protected
   procedure pm_SetAlien(const aValue: IDayTipsService);
   procedure ClearFields; override;
  public
   function ShowDayTipsAtStartup: IvcmEntityForm;
   procedure OpenTip(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* ��������� ����� ��� }
   class function Instance: TDayTipsService;
    {* ����� ��������� ���������� ���������� TDayTipsService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IDayTipsService
    write pm_SetAlien;
    {* ������� ���������� ������� IDayTipsService }
 end;//TDayTipsService

 (*
 MDocumentListFromFileService = interface
  {* �������� ������� TDocumentListFromFileService }
 end;//MDocumentListFromFileService
 *)

 IDocumentListFromFileService = interface
  {* ��������� ������� TDocumentListFromFileService }
 end;//IDocumentListFromFileService

 TDocumentListFromFileService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IDocumentListFromFileService;
    {* ������� ���������� ������� IDocumentListFromFileService }
  protected
   procedure pm_SetAlien(const aValue: IDocumentListFromFileService);
   procedure ClearFields; override;
  public
   class function Instance: TDocumentListFromFileService;
    {* ����� ��������� ���������� ���������� TDocumentListFromFileService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IDocumentListFromFileService
    write pm_SetAlien;
    {* ������� ���������� ������� IDocumentListFromFileService }
 end;//TDocumentListFromFileService

 ChangeableMainMenuTypeEnum = (
  {* ����� ��� ��������� "��� ���������� ����� ��������� ����" }
  KEY_ChangeableMainMenuType_ST_FINANCE
   {* ������ � ������� }
  , KEY_ChangeableMainMenuType_ST_HR
   {* ������ ��� ���������� }
  , KEY_ChangeableMainMenuType_ST_LEGAL
   {* ������ ��� ������� }
  , KEY_ChangeableMainMenuType_ST_BUDGET_ORGS
   {* ��������� ����������� }
 );//ChangeableMainMenuTypeEnum

 ChangeableMainMenuTypeValuesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� ChangeableMainMenuTypeValuesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): ChangeableMainMenuTypeEnum;
    {* �������������� ���������� �������� � ����������� }
 end;//ChangeableMainMenuTypeValuesMapHelper

 TChangeableMainMenuTypeValuesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� ChangeableMainMenuTypeValuesMap }
  protected
   function pm_GetMapID: Tl3ValueMapID;
   procedure GetDisplayNames(const aList: Il3StringsEx);
    {* ��������� ������ ���������� "UI-������" }
   function MapSize: Integer;
    {* ���������� ��������� � ����. }
   function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
   function ValueToDisplayName(aValue: Integer): Il3CString;
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TChangeableMainMenuTypeValuesMapImplPrim }
 end;//TChangeableMainMenuTypeValuesMapImplPrim

 TChangeableMainMenuTypeValuesMapImpl = {final} class(TChangeableMainMenuTypeValuesMapImplPrim)
  {* ����� ��� ���������� ���� ��� ChangeableMainMenuTypeValuesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TChangeableMainMenuTypeValuesMapImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TChangeableMainMenuTypeValuesMapImpl

 (*
 MMainMenuService = interface
  {* �������� ������� TMainMenuService }
  procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
 end;//MMainMenuService
 *)

 IMainMenuService = interface
  {* ��������� ������� TMainMenuService }
  procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
 end;//IMainMenuService

 TMainMenuService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IMainMenuService;
    {* ������� ���������� ������� IMainMenuService }
  protected
   procedure pm_SetAlien(const aValue: IMainMenuService);
   procedure ClearFields; override;
  public
   class function ChangeableMainMenuTypeSetting: Integer;
    {* ����� ��� ��������� �������� ��������� "��� ���������� ����� ��������� ����" }
   class procedure WriteChangeableMainMenuTypeSetting(aValue: Integer);
    {* ����� ��� ������ �������� ��������� "��� ���������� ����� ��������� ����" }
   procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
   class function Instance: TMainMenuService;
    {* ����� ��������� ���������� ���������� TMainMenuService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IMainMenuService
    write pm_SetAlien;
    {* ������� ���������� ������� IMainMenuService }
 end;//TMainMenuService

 (*
 MBaseSearchService = interface
  {* �������� ������� TBaseSearchService }
  procedure BaseSearchCheckFindBack(const aContainer: IvcmContainer);
  procedure BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
  procedure CheckBaseSearchDataReady(const aContainer: IvcmContainer);
  procedure OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
   const aQuery: IQuery);
  procedure TryAnotherBaseSearch(const aContainer: IvcmContainer;
   const aProcessor: InsBaseSearchResultProcessor;
   TryFullList: Boolean = False);
  function MakeBaseSearchCard(const aContainer: IvcmContainer): IvcmEntityForm;
  function MakeBaseSearchWindow(const aContainer: IvcmContainer;
   const aData: InsBaseSearcherWindowData;
   aZoneType: TvcmZoneType): IvcmEntityForm;
 end;//MBaseSearchService
 *)

 IBaseSearchService = interface
  {* ��������� ������� TBaseSearchService }
  procedure BaseSearchCheckFindBack(const aContainer: IvcmContainer);
  procedure BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
  procedure CheckBaseSearchDataReady(const aContainer: IvcmContainer);
  procedure OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
   const aQuery: IQuery);
  procedure TryAnotherBaseSearch(const aContainer: IvcmContainer;
   const aProcessor: InsBaseSearchResultProcessor;
   TryFullList: Boolean = False);
  function MakeBaseSearchCard(const aContainer: IvcmContainer): IvcmEntityForm;
  function MakeBaseSearchWindow(const aContainer: IvcmContainer;
   const aData: InsBaseSearcherWindowData;
   aZoneType: TvcmZoneType): IvcmEntityForm;
 end;//IBaseSearchService

 TBaseSearchService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IBaseSearchService;
    {* ������� ���������� ������� IBaseSearchService }
  protected
   procedure pm_SetAlien(const aValue: IBaseSearchService);
   procedure ClearFields; override;
  public
   procedure BaseSearchCheckFindBack(const aContainer: IvcmContainer);
   procedure BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
   procedure CheckBaseSearchDataReady(const aContainer: IvcmContainer);
   procedure OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
    const aQuery: IQuery);
   procedure TryAnotherBaseSearch(const aContainer: IvcmContainer;
    const aProcessor: InsBaseSearchResultProcessor;
    TryFullList: Boolean = False);
   function MakeBaseSearchCard(const aContainer: IvcmContainer): IvcmEntityForm;
   function MakeBaseSearchWindow(const aContainer: IvcmContainer;
    const aData: InsBaseSearcherWindowData;
    aZoneType: TvcmZoneType): IvcmEntityForm;
   class function Instance: TBaseSearchService;
    {* ����� ��������� ���������� ���������� TBaseSearchService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IBaseSearchService
    write pm_SetAlien;
    {* ������� ���������� ������� IBaseSearchService }
 end;//TBaseSearchService

 (*
 MFiltersService = interface
  {* �������� ������� TFiltersService }
  function CreateFilter(const aQuery: IQuery): Integer;
  procedure FiltersOpen(const aData: IucpFilters);
  procedure OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer;
   anOwner: TComponent);
  procedure RenameFilter(const aFilter: IFilterFromQuery);
 end;//MFiltersService
 *)

 IFiltersService = interface
  {* ��������� ������� TFiltersService }
  function CreateFilter(const aQuery: IQuery): Integer;
  procedure FiltersOpen(const aData: IucpFilters);
  procedure OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer;
   anOwner: TComponent);
  procedure RenameFilter(const aFilter: IFilterFromQuery);
 end;//IFiltersService

 TFiltersService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IFiltersService;
    {* ������� ���������� ������� IFiltersService }
  protected
   procedure pm_SetAlien(const aValue: IFiltersService);
   procedure ClearFields; override;
  public
   function CreateFilter(const aQuery: IQuery): Integer;
   procedure FiltersOpen(const aData: IucpFilters);
   procedure OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer;
    anOwner: TComponent);
   procedure RenameFilter(const aFilter: IFilterFromQuery);
   class function Instance: TFiltersService;
    {* ����� ��������� ���������� ���������� TFiltersService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IFiltersService
    write pm_SetAlien;
    {* ������� ���������� ������� IFiltersService }
 end;//TFiltersService

 InsFormCoordinates = interface
  ['{19A17133-BBBB-44F6-8763-1D186621B75E}']
  function Get_Rect: TRect;
  property Rect: TRect
   read Get_Rect;
 end;//InsFormCoordinates

 (*
 MFoldersService = interface
  {* �������� ������� TFoldersService }
  procedure CloseFolders(const aContainer: IvcmContainer);
  procedure SelectOpenWithOperation(const aForm: IvcmEntityForm;
   const aFilterInfo: InsFolderFilterInfo;
   const aCaption: TvcmStringID;
   anOp: TListLogicOperation);
  function EditInfoOpen(aIsNewFolder: Boolean;
   const aNode: IeeNode;
   const aCoords: InsFormCoordinates): Integer;
  procedure SelectOpenWithUserData(const aForm: IvcmEntityForm;
   const aFilterInfo: InsFolderFilterInfo;
   const aCaption: TvcmStringID;
   const aUserData: IUnknown);
  procedure LoadOpen(const aForm: IvcmEntityForm;
   const aData: InsFolderFilterInfo);
  procedure TryOpenConsultationAnswer(const aContainer: IvcmContainer);
  procedure RefreshStructure(const aNode: INode;
   aStatus: TNotifyStatus);
  function OpenFolders(const aContainer: IvcmContainer;
   aCanCreate: Boolean): IvcmEntityForm;
  function SaveOpen(const aForm: IvcmEntityForm;
   const aFilterInfo: InsFolderFilterInfo;
   anElementType: TFoldersElementType;
   const anEntity: IEntityBase;
   aSaveAs: Boolean): Integer;
  procedure SelectOpen(const aForm: IvcmEntityForm;
   const aFilterInfo: InsFolderFilterInfo;
   const aCaption: TvcmStringID);
 end;//MFoldersService
 *)

 IFoldersService = interface
  {* ��������� ������� TFoldersService }
  procedure CloseFolders(const aContainer: IvcmContainer);
  procedure SelectOpenWithOperation(const aForm: IvcmEntityForm;
   const aFilterInfo: InsFolderFilterInfo;
   const aCaption: TvcmStringID;
   anOp: TListLogicOperation);
  function EditInfoOpen(aIsNewFolder: Boolean;
   const aNode: IeeNode;
   const aCoords: InsFormCoordinates): Integer;
  procedure SelectOpenWithUserData(const aForm: IvcmEntityForm;
   const aFilterInfo: InsFolderFilterInfo;
   const aCaption: TvcmStringID;
   const aUserData: IUnknown);
  procedure LoadOpen(const aForm: IvcmEntityForm;
   const aData: InsFolderFilterInfo);
  procedure TryOpenConsultationAnswer(const aContainer: IvcmContainer);
  procedure RefreshStructure(const aNode: INode;
   aStatus: TNotifyStatus);
  function OpenFolders(const aContainer: IvcmContainer;
   aCanCreate: Boolean): IvcmEntityForm;
  function SaveOpen(const aForm: IvcmEntityForm;
   const aFilterInfo: InsFolderFilterInfo;
   anElementType: TFoldersElementType;
   const anEntity: IEntityBase;
   aSaveAs: Boolean): Integer;
  procedure SelectOpen(const aForm: IvcmEntityForm;
   const aFilterInfo: InsFolderFilterInfo;
   const aCaption: TvcmStringID);
 end;//IFoldersService

 TFoldersService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IFoldersService;
    {* ������� ���������� ������� IFoldersService }
  protected
   procedure pm_SetAlien(const aValue: IFoldersService);
   procedure ClearFields; override;
  public
   procedure CloseFolders(const aContainer: IvcmContainer);
   procedure SelectOpenWithOperation(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    const aCaption: TvcmStringID;
    anOp: TListLogicOperation);
   function EditInfoOpen(aIsNewFolder: Boolean;
    const aNode: IeeNode;
    const aCoords: InsFormCoordinates): Integer;
   procedure SelectOpenWithUserData(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    const aCaption: TvcmStringID;
    const aUserData: IUnknown);
   procedure LoadOpen(const aForm: IvcmEntityForm;
    const aData: InsFolderFilterInfo);
   procedure TryOpenConsultationAnswer(const aContainer: IvcmContainer);
   procedure RefreshStructure(const aNode: INode;
    aStatus: TNotifyStatus);
   function OpenFolders(const aContainer: IvcmContainer;
    aCanCreate: Boolean): IvcmEntityForm;
   function SaveOpen(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    anElementType: TFoldersElementType;
    const anEntity: IEntityBase;
    aSaveAs: Boolean): Integer;
   procedure SelectOpen(const aForm: IvcmEntityForm;
    const aFilterInfo: InsFolderFilterInfo;
    const aCaption: TvcmStringID);
   class function Instance: TFoldersService;
    {* ����� ��������� ���������� ���������� TFoldersService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IFoldersService
    write pm_SetAlien;
    {* ������� ���������� ������� IFoldersService }
 end;//TFoldersService

 (*
 MRubricatorService = interface
  {* �������� ������� TRubricatorService }
  function OpenRubricator(const aNode: Il3SimpleNode;
   const aRootToKeep: INodeBase;
   const aMenuSectionItemToKeep: ISectionItem;
   aNeedsSheet: Boolean;
   const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer): IvcmEntityForm;
 end;//MRubricatorService
 *)

 IRubricatorService = interface
  {* ��������� ������� TRubricatorService }
  function OpenRubricator(const aNode: Il3SimpleNode;
   const aRootToKeep: INodeBase;
   const aMenuSectionItemToKeep: ISectionItem;
   aNeedsSheet: Boolean;
   const anAggregate: IvcmAggregate;
   const aContainer: IvcmContainer): IvcmEntityForm;
 end;//IRubricatorService

 TRubricatorService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IRubricatorService;
    {* ������� ���������� ������� IRubricatorService }
  protected
   procedure pm_SetAlien(const aValue: IRubricatorService);
   procedure ClearFields; override;
  public
   function OpenRubricator(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem;
    aNeedsSheet: Boolean;
    const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer): IvcmEntityForm;
   class function Instance: TRubricatorService;
    {* ����� ��������� ���������� ���������� TRubricatorService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IRubricatorService
    write pm_SetAlien;
    {* ������� ���������� ������� IRubricatorService }
 end;//TRubricatorService

 (*
 MSearchService = interface
  {* �������� ������� TSearchService }
  procedure AttributeSearch(const aQuery: IQuery;
   const aList: IDynList;
   const aContainer: IvcmContainer);
  procedure EditFilter(const aFilter: IdeFilter;
   anItemIndex: Integer);
   {* �������������� ������ }
  procedure InpharmSearch(const aQuery: IQuery;
   const aList: IDynList;
   const aContainer: IvcmContainer);
   {* ����� ������������� ������� }
  procedure MakeNewFilter(aListType: TbsListType);
   {* �������� ����� �������� ������ ������� }
  procedure OpenKeyWord(const aQuery: IQuery;
   const aContainer: IvcmContainer);
   {* ������� ��� }
  procedure OpenOldSituationCard(const aQuery: IQuery;
   const aContainer: IvcmContainer);
   {* ������� ��� 5.� }
  procedure OpenPharmLegislationReview;
  procedure OpenPharmPublishSearch;
  procedure OpenSituationCard(const aQuery: IQuery);
   {* ������� ��� 6.� }
  procedure OpenTaxesPublishSearch(const aPublishSearchTag: Il3CString);
   {* ��� �� ������� � �������� }
  procedure PublishSourceSearch(const aQuery: IQuery;
   const aList: IDynList);
  function DateQuery(const aCaller: IvcmEntityForm;
   const aData: IqaDateReqDataHolder): IvcmEntityForm;
  function OpenFiltersForm(const aData: IdeFilter): IvcmEntityForm;
   {* ��������� ����� �������� }
  function OpenLegislationReview(const aQuery: IQuery): IvcmEntityForm;
   {* ������� ����� ��������� ���������������� }
 end;//MSearchService
 *)

 ISearchService = interface
  {* ��������� ������� TSearchService }
  procedure AttributeSearch(const aQuery: IQuery;
   const aList: IDynList;
   const aContainer: IvcmContainer);
  procedure EditFilter(const aFilter: IdeFilter;
   anItemIndex: Integer);
   {* �������������� ������ }
  procedure InpharmSearch(const aQuery: IQuery;
   const aList: IDynList;
   const aContainer: IvcmContainer);
   {* ����� ������������� ������� }
  procedure MakeNewFilter(aListType: TbsListType);
   {* �������� ����� �������� ������ ������� }
  procedure OpenKeyWord(const aQuery: IQuery;
   const aContainer: IvcmContainer);
   {* ������� ��� }
  procedure OpenOldSituationCard(const aQuery: IQuery;
   const aContainer: IvcmContainer);
   {* ������� ��� 5.� }
  procedure OpenPharmLegislationReview;
  procedure OpenPharmPublishSearch;
  procedure OpenSituationCard(const aQuery: IQuery);
   {* ������� ��� 6.� }
  procedure OpenTaxesPublishSearch(const aPublishSearchTag: Il3CString);
   {* ��� �� ������� � �������� }
  procedure PublishSourceSearch(const aQuery: IQuery;
   const aList: IDynList);
  function DateQuery(const aCaller: IvcmEntityForm;
   const aData: IqaDateReqDataHolder): IvcmEntityForm;
  function OpenFiltersForm(const aData: IdeFilter): IvcmEntityForm;
   {* ��������� ����� �������� }
  function OpenLegislationReview(const aQuery: IQuery): IvcmEntityForm;
   {* ������� ����� ��������� ���������������� }
 end;//ISearchService

 TSearchService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ISearchService;
    {* ������� ���������� ������� ISearchService }
  protected
   procedure pm_SetAlien(const aValue: ISearchService);
   procedure ClearFields; override;
  public
   procedure AttributeSearch(const aQuery: IQuery;
    const aList: IDynList;
    const aContainer: IvcmContainer);
   procedure EditFilter(const aFilter: IdeFilter;
    anItemIndex: Integer);
    {* �������������� ������ }
   procedure InpharmSearch(const aQuery: IQuery;
    const aList: IDynList;
    const aContainer: IvcmContainer);
    {* ����� ������������� ������� }
   procedure MakeNewFilter(aListType: TbsListType);
    {* �������� ����� �������� ������ ������� }
   procedure OpenKeyWord(const aQuery: IQuery;
    const aContainer: IvcmContainer);
    {* ������� ��� }
   procedure OpenOldSituationCard(const aQuery: IQuery;
    const aContainer: IvcmContainer);
    {* ������� ��� 5.� }
   procedure OpenPharmLegislationReview;
   procedure OpenPharmPublishSearch;
   procedure OpenSituationCard(const aQuery: IQuery);
    {* ������� ��� 6.� }
   procedure OpenTaxesPublishSearch(const aPublishSearchTag: Il3CString);
    {* ��� �� ������� � �������� }
   procedure PublishSourceSearch(const aQuery: IQuery;
    const aList: IDynList);
   function DateQuery(const aCaller: IvcmEntityForm;
    const aData: IqaDateReqDataHolder): IvcmEntityForm;
   function OpenFiltersForm(const aData: IdeFilter): IvcmEntityForm;
    {* ��������� ����� �������� }
   function OpenLegislationReview(const aQuery: IQuery): IvcmEntityForm;
    {* ������� ����� ��������� ���������������� }
   class function Instance: TSearchService;
    {* ����� ��������� ���������� ���������� TSearchService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: ISearchService
    write pm_SetAlien;
    {* ������� ���������� ������� ISearchService }
 end;//TSearchService

 (*
 MSettingsService = interface
  {* �������� ������� TSettingsService }
  procedure CloseConfList(const aContainer: IvcmContainer);
   {* ������� ������ ������������ }
  procedure OpenConfList(const aContainer: IvcmContainer);
  function OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
  function LoadSettings(const anAggregate: IvcmAggregate;
   const aData: InsConfigSettingsInfo): IvcmEntityForm;
   {* ������� ��������� }
 end;//MSettingsService
 *)

 ISettingsService = interface
  {* ��������� ������� TSettingsService }
  procedure CloseConfList(const aContainer: IvcmContainer);
   {* ������� ������ ������������ }
  procedure OpenConfList(const aContainer: IvcmContainer);
  function OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
  function LoadSettings(const anAggregate: IvcmAggregate;
   const aData: InsConfigSettingsInfo): IvcmEntityForm;
   {* ������� ��������� }
 end;//ISettingsService

 TSettingsService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ISettingsService;
    {* ������� ���������� ������� ISettingsService }
  protected
   procedure pm_SetAlien(const aValue: ISettingsService);
   procedure ClearFields; override;
  public
   procedure CloseConfList(const aContainer: IvcmContainer);
    {* ������� ������ ������������ }
   procedure OpenConfList(const aContainer: IvcmContainer);
   function OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
   function LoadSettings(const anAggregate: IvcmAggregate;
    const aData: InsConfigSettingsInfo): IvcmEntityForm;
    {* ������� ��������� }
   class function Instance: TSettingsService;
    {* ����� ��������� ���������� ���������� TSettingsService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: ISettingsService
    write pm_SetAlien;
    {* ������� ���������� ������� ISettingsService }
 end;//TSettingsService

 (*
 MWorkJournalService = interface
  {* �������� ������� TWorkJournalService }
  function MakeWorkJournal: IbsWorkJournal;
 end;//MWorkJournalService
 *)

 IWorkJournalService = interface
  {* ��������� ������� TWorkJournalService }
  function MakeWorkJournal: IbsWorkJournal;
 end;//IWorkJournalService

 TWorkJournalService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IWorkJournalService;
    {* ������� ���������� ������� IWorkJournalService }
  protected
   procedure pm_SetAlien(const aValue: IWorkJournalService);
   procedure ClearFields; override;
  public
   function MakeWorkJournal: IbsWorkJournal;
   class function Instance: TWorkJournalService;
    {* ����� ��������� ���������� ���������� TWorkJournalService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IWorkJournalService
    write pm_SetAlien;
    {* ������� ���������� ������� IWorkJournalService }
 end;//TWorkJournalService

 ShowChangesInfoValuesMapHelper = {final} class
  {* ��������� ����� ��� �������������� �������� ShowChangesInfoValuesMap }
  public
   class procedure FillStrings(const aStrings: IafwStrings);
    {* ���������� ������ ����� ���������� }
   class function DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
    {* �������������� ���������� �������� � ����������� }
 end;//ShowChangesInfoValuesMapHelper

 TShowChangesInfoValuesMapImplPrim = {abstract} class(Tl3CProtoObject, Il3IntegerValueMap)
  {* ����� ��� ���������� ���� ��� ShowChangesInfoValuesMap }
  protected
   function pm_GetMapID: Tl3ValueMapID;
   procedure GetDisplayNames(const aList: Il3StringsEx);
    {* ��������� ������ ���������� "UI-������" }
   function MapSize: Integer;
    {* ���������� ��������� � ����. }
   function DisplayNameToValue(const aDisplayName: Il3CString): Integer;
   function ValueToDisplayName(aValue: Integer): Il3CString;
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TShowChangesInfoValuesMapImplPrim }
 end;//TShowChangesInfoValuesMapImplPrim

 TShowChangesInfoValuesMapImpl = {final} class(TShowChangesInfoValuesMapImplPrim)
  {* ����� ��� ���������� ���� ��� ShowChangesInfoValuesMap }
  public
   class function Make: Il3IntegerValueMap; reintroduce;
    {* ��������� ����� ��� TShowChangesInfoValuesMapImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TShowChangesInfoValuesMapImpl

 (*
 MDocumentService = interface
  {* �������� ������� TDocumentService }
  function OpenEntityAsDocument(const anEntity: IUnknown;
   const aContainer: IvcmContainer): IDocument;
  function SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
  function MakeBaloonForm(aCaller: TvcmContainerForm;
   aUserType: TvcmEffectiveUserType;
   const aWarning: IdsWarning): IvcmEntityForm;
  function OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
   const anAggregate: IvcmAggregate): IvcmEntityForm;
  function OpenExternalObject(const aContainer: IvcmContainer;
   const aData: InsLinkedObjectData): IvcmEntityForm;
  function OpenPicture(const aContainer: IvcmContainer;
   const aData: InsLinkedObjectData): IvcmEntityForm;
  function OpenPictureInfo(const aContainer: IvcmContainer;
   const aData: InsLinkedObjectDescription): IvcmEntityForm;
  function OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine): IvcmEntityForm;
  procedure OpenDocument(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
   {* ��������� �������� }
  procedure OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
 end;//MDocumentService
 *)

 IDocumentService = interface
  {* ��������� ������� TDocumentService }
  function OpenEntityAsDocument(const anEntity: IUnknown;
   const aContainer: IvcmContainer): IDocument;
  function SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
  function MakeBaloonForm(aCaller: TvcmContainerForm;
   aUserType: TvcmEffectiveUserType;
   const aWarning: IdsWarning): IvcmEntityForm;
  function OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
   const anAggregate: IvcmAggregate): IvcmEntityForm;
  function OpenExternalObject(const aContainer: IvcmContainer;
   const aData: InsLinkedObjectData): IvcmEntityForm;
  function OpenPicture(const aContainer: IvcmContainer;
   const aData: InsLinkedObjectData): IvcmEntityForm;
  function OpenPictureInfo(const aContainer: IvcmContainer;
   const aData: InsLinkedObjectDescription): IvcmEntityForm;
  function OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine): IvcmEntityForm;
  procedure OpenDocument(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
   {* ��������� �������� }
  procedure OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
 end;//IDocumentService

 TDocumentService = {final} class(Tl3ProtoObject)
  {* ������ � ���������� }
  private
   f_Alien: IDocumentService;
    {* ������� ���������� ������� IDocumentService }
  protected
   procedure pm_SetAlien(const aValue: IDocumentService);
   procedure ClearFields; override;
  public
   class function ShowChangesInfoSetting: Boolean;
    {* ����� ��� ��������� �������� ��������� "���������� ������� ��������� � ���������" }
   class procedure WriteShowChangesInfoSetting(aValue: Boolean);
    {* ����� ��� ������ �������� ��������� "���������� ������� ��������� � ���������" }
   function OpenEntityAsDocument(const anEntity: IUnknown;
    const aContainer: IvcmContainer): IDocument;
   function SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
   function MakeBaloonForm(aCaller: TvcmContainerForm;
    aUserType: TvcmEffectiveUserType;
    const aWarning: IdsWarning): IvcmEntityForm;
   function OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
    const anAggregate: IvcmAggregate): IvcmEntityForm;
   function OpenExternalObject(const aContainer: IvcmContainer;
    const aData: InsLinkedObjectData): IvcmEntityForm;
   function OpenPicture(const aContainer: IvcmContainer;
    const aData: InsLinkedObjectData): IvcmEntityForm;
   function OpenPictureInfo(const aContainer: IvcmContainer;
    const aData: InsLinkedObjectDescription): IvcmEntityForm;
   function OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine): IvcmEntityForm;
   procedure OpenDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* ��������� �������� }
   procedure OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   class function Instance: TDocumentService;
    {* ����� ��������� ���������� ���������� TDocumentService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IDocumentService
    write pm_SetAlien;
    {* ������� ���������� ������� IDocumentService }
 end;//TDocumentService

 (*
 MMonitoringsService = interface
  {* �������� ������� TMonitoringsService }
  function OpenNewsLine(aDenyNewTab: Boolean): IvcmEntityForm;
  procedure OpenAutoreferat(const aDoc: IDocument;
   const aContainer: IvcmContainer);
  procedure OpenAutoreferatAfterSearch(const aList: IMonitoringList;
   const aContainer: IvcmContainer);
 end;//MMonitoringsService
 *)

 IMonitoringsService = interface
  {* ��������� ������� TMonitoringsService }
  function OpenNewsLine(aDenyNewTab: Boolean): IvcmEntityForm;
  procedure OpenAutoreferat(const aDoc: IDocument;
   const aContainer: IvcmContainer);
  procedure OpenAutoreferatAfterSearch(const aList: IMonitoringList;
   const aContainer: IvcmContainer);
 end;//IMonitoringsService

 TMonitoringsService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IMonitoringsService;
    {* ������� ���������� ������� IMonitoringsService }
  protected
   procedure pm_SetAlien(const aValue: IMonitoringsService);
   procedure ClearFields; override;
  public
   function OpenNewsLine(aDenyNewTab: Boolean): IvcmEntityForm;
   procedure OpenAutoreferat(const aDoc: IDocument;
    const aContainer: IvcmContainer);
   procedure OpenAutoreferatAfterSearch(const aList: IMonitoringList;
    const aContainer: IvcmContainer);
   class function Instance: TMonitoringsService;
    {* ����� ��������� ���������� ���������� TMonitoringsService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IMonitoringsService
    write pm_SetAlien;
    {* ������� ���������� ������� IMonitoringsService }
 end;//TMonitoringsService

 TnsDocumentForReturnInfo = {$IfDef XE4}record{$Else}object{$EndIf}
  public
   rDoc: IDocument;
   rPara: IeeLeafPara;
 end;//TnsDocumentForReturnInfo

 (*
 MEditionsService = interface
  {* �������� ������� TEditionsService }
  procedure MakeCompareEditions(const aLeft: IDocument;
   const aRight: IDocument;
   const aParaForPositionning: IeeLeafPara;
   const aDocumentForReturn: IDocument;
   const aParaForReturn: IeeLeafPara;
   const aContainer: IvcmContainer = nil); overload;
  procedure MakeCompareEditions(const aDoc: IDocument;
   const aPara: IeeLeafPara;
   const aContainer: IvcmContainer = nil); overload;
  procedure MakeCompareEditions(const aLeft: IDocument;
   const aRight: IDocument;
   const aPara: IeeLeafPara;
   const aContainer: IvcmContainer = nil); overload;
  procedure MakeCompareEditions(const aDoc: IDocument;
   const aPara: IeeLeafPara;
   aEditionForCompare: Integer;
   const aContainer: IvcmContainer = nil); overload;
  procedure MakeCompareEditions(const aLeft: IDocument;
   const aRight: IDocument;
   const aPosition: TbsDocPos;
   const aDocumentForReturn: IDocument;
   const aParaForReturn: IeeLeafPara;
   const aContainer: IvcmContainer = nil); overload;
  procedure MakeCompareEditions(const aDoc: IDocument;
   const aPara: IeeLeafPara;
   aEditionForCompare: Integer;
   const aDocumentForReturn: TnsDocumentForReturnInfo;
   const aContainer: IvcmContainer = nil); overload;
   {* ������ ������������� ���������� "��������� ��������" }
 end;//MEditionsService
 *)

 IEditionsService = interface
  {* ��������� ������� TEditionsService }
  procedure MakeCompareEditions(const aLeft: IDocument;
   const aRight: IDocument;
   const aParaForPositionning: IeeLeafPara;
   const aDocumentForReturn: IDocument;
   const aParaForReturn: IeeLeafPara;
   const aContainer: IvcmContainer = nil); overload;
  procedure MakeCompareEditions(const aDoc: IDocument;
   const aPara: IeeLeafPara;
   const aContainer: IvcmContainer = nil); overload;
  procedure MakeCompareEditions(const aLeft: IDocument;
   const aRight: IDocument;
   const aPara: IeeLeafPara;
   const aContainer: IvcmContainer = nil); overload;
  procedure MakeCompareEditions(const aDoc: IDocument;
   const aPara: IeeLeafPara;
   aEditionForCompare: Integer;
   const aContainer: IvcmContainer = nil); overload;
  procedure MakeCompareEditions(const aLeft: IDocument;
   const aRight: IDocument;
   const aPosition: TbsDocPos;
   const aDocumentForReturn: IDocument;
   const aParaForReturn: IeeLeafPara;
   const aContainer: IvcmContainer = nil); overload;
  procedure MakeCompareEditions(const aDoc: IDocument;
   const aPara: IeeLeafPara;
   aEditionForCompare: Integer;
   const aDocumentForReturn: TnsDocumentForReturnInfo;
   const aContainer: IvcmContainer = nil); overload;
   {* ������ ������������� ���������� "��������� ��������" }
 end;//IEditionsService

 TEditionsService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IEditionsService;
    {* ������� ���������� ������� IEditionsService }
  protected
   procedure pm_SetAlien(const aValue: IEditionsService);
   procedure ClearFields; override;
  public
   procedure MakeCompareEditions(const aLeft: IDocument;
    const aRight: IDocument;
    const aParaForPositionning: IeeLeafPara;
    const aDocumentForReturn: IDocument;
    const aParaForReturn: IeeLeafPara;
    const aContainer: IvcmContainer = nil); overload;
   procedure MakeCompareEditions(const aDoc: IDocument;
    const aPara: IeeLeafPara;
    const aContainer: IvcmContainer = nil); overload;
   procedure MakeCompareEditions(const aLeft: IDocument;
    const aRight: IDocument;
    const aPara: IeeLeafPara;
    const aContainer: IvcmContainer = nil); overload;
   procedure MakeCompareEditions(const aDoc: IDocument;
    const aPara: IeeLeafPara;
    aEditionForCompare: Integer;
    const aContainer: IvcmContainer = nil); overload;
   procedure MakeCompareEditions(const aLeft: IDocument;
    const aRight: IDocument;
    const aPosition: TbsDocPos;
    const aDocumentForReturn: IDocument;
    const aParaForReturn: IeeLeafPara;
    const aContainer: IvcmContainer = nil); overload;
   procedure MakeCompareEditions(const aDoc: IDocument;
    const aPara: IeeLeafPara;
    aEditionForCompare: Integer;
    const aDocumentForReturn: TnsDocumentForReturnInfo;
    const aContainer: IvcmContainer = nil); overload;
    {* ������ ������������� ���������� "��������� ��������" }
   class function Instance: TEditionsService;
    {* ����� ��������� ���������� ���������� TEditionsService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IEditionsService
    write pm_SetAlien;
    {* ������� ���������� ������� IEditionsService }
 end;//TEditionsService

 (*
 MListService = interface
  {* �������� ������� TListService }
  procedure OpenList(const aList: IdeList;
   const aContainer: IvcmContainer);
   {* ��������� ������ � ��������� ���������� }
  procedure MakeListAnalizer(const aTree: Il3SimpleTree);
 end;//MListService
 *)

 IListService = interface
  {* ��������� ������� TListService }
  procedure OpenList(const aList: IdeList;
   const aContainer: IvcmContainer);
   {* ��������� ������ � ��������� ���������� }
  procedure MakeListAnalizer(const aTree: Il3SimpleTree);
 end;//IListService

 TListService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IListService;
    {* ������� ���������� ������� IListService }
  protected
   procedure pm_SetAlien(const aValue: IListService);
   procedure ClearFields; override;
  public
   procedure OpenList(const aList: IdeList;
    const aContainer: IvcmContainer);
    {* ��������� ������ � ��������� ���������� }
   procedure MakeListAnalizer(const aTree: Il3SimpleTree);
   class function Instance: TListService;
    {* ����� ��������� ���������� ���������� TListService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IListService
    write pm_SetAlien;
    {* ������� ���������� ������� IListService }
 end;//TListService

 (*
 MConsultationService = interface
  {* �������� ������� TConsultationService }
  procedure OpenSendConsultation(const aQuery: IQuery);
  procedure OpenEntityAsConsultation(const aCons: IUnknown;
   const aContainer: IvcmContainer);
  procedure OpenConsultation(const aCons: IbsConsultation;
   const aContainer: IvcmContainer);
  procedure GiveMarkOnConsultation(const aNode: Il3SimpleNode);
 end;//MConsultationService
 *)

 IConsultationService = interface
  {* ��������� ������� TConsultationService }
  procedure OpenSendConsultation(const aQuery: IQuery);
  procedure OpenEntityAsConsultation(const aCons: IUnknown;
   const aContainer: IvcmContainer);
  procedure OpenConsultation(const aCons: IbsConsultation;
   const aContainer: IvcmContainer);
  procedure GiveMarkOnConsultation(const aNode: Il3SimpleNode);
 end;//IConsultationService

 TConsultationService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IConsultationService;
    {* ������� ���������� ������� IConsultationService }
  protected
   procedure pm_SetAlien(const aValue: IConsultationService);
   procedure ClearFields; override;
  public
   procedure OpenSendConsultation(const aQuery: IQuery);
   procedure OpenEntityAsConsultation(const aCons: IUnknown;
    const aContainer: IvcmContainer);
   procedure OpenConsultation(const aCons: IbsConsultation;
    const aContainer: IvcmContainer);
   procedure GiveMarkOnConsultation(const aNode: Il3SimpleNode);
   class function Instance: TConsultationService;
    {* ����� ��������� ���������� ���������� TConsultationService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IConsultationService
    write pm_SetAlien;
    {* ������� ���������� ������� IConsultationService }
 end;//TConsultationService

 (*
 MUnderControlService = interface
  {* �������� ������� TUnderControlService }
  procedure AddControlledObject(const aData: IControllable);
  procedure BuildUnderControlList(const aContainer: IvcmContainer);
  procedure CloseUnderControl(const aContainer: IvcmContainer);
  procedure DeleteControlledObject(const aData: IControllable);
  procedure DropChangeStatusToOpened(const aForm: IvcmEntityForm);
  procedure MarkControlledAsOpen(const aData: IControllable);
  procedure OpenUnderControl(const aContainer: IvcmContainer);
 end;//MUnderControlService
 *)

 IUnderControlService = interface
  {* ��������� ������� TUnderControlService }
  procedure AddControlledObject(const aData: IControllable);
  procedure BuildUnderControlList(const aContainer: IvcmContainer);
  procedure CloseUnderControl(const aContainer: IvcmContainer);
  procedure DeleteControlledObject(const aData: IControllable);
  procedure DropChangeStatusToOpened(const aForm: IvcmEntityForm);
  procedure MarkControlledAsOpen(const aData: IControllable);
  procedure OpenUnderControl(const aContainer: IvcmContainer);
 end;//IUnderControlService

 TUnderControlService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IUnderControlService;
    {* ������� ���������� ������� IUnderControlService }
  protected
   procedure pm_SetAlien(const aValue: IUnderControlService);
   procedure ClearFields; override;
  public
   procedure AddControlledObject(const aData: IControllable);
   procedure BuildUnderControlList(const aContainer: IvcmContainer);
   procedure CloseUnderControl(const aContainer: IvcmContainer);
   procedure DeleteControlledObject(const aData: IControllable);
   procedure DropChangeStatusToOpened(const aForm: IvcmEntityForm);
   procedure MarkControlledAsOpen(const aData: IControllable);
   procedure OpenUnderControl(const aContainer: IvcmContainer);
   class function Instance: TUnderControlService;
    {* ����� ��������� ���������� ���������� TUnderControlService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IUnderControlService
    write pm_SetAlien;
    {* ������� ���������� ������� IUnderControlService }
 end;//TUnderControlService

 (*
 MChangesBetweenEditionsService = interface
  {* �������� ������� TChangesBetweenEditionsService }
  procedure ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
   {* �������� �������� ���������� � ��������� � ���������� ��������� }
  procedure ViewChangedFragments(const aLeft: IDocument;
   const aRight: IDocument);
 end;//MChangesBetweenEditionsService
 *)

 IChangesBetweenEditionsService = interface
  {* ��������� ������� TChangesBetweenEditionsService }
  procedure ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
   {* �������� �������� ���������� � ��������� � ���������� ��������� }
  procedure ViewChangedFragments(const aLeft: IDocument;
   const aRight: IDocument);
 end;//IChangesBetweenEditionsService

 TChangesBetweenEditionsService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IChangesBetweenEditionsService;
    {* ������� ���������� ������� IChangesBetweenEditionsService }
  protected
   procedure pm_SetAlien(const aValue: IChangesBetweenEditionsService);
   procedure ClearFields; override;
  public
   procedure ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
    {* �������� �������� ���������� � ��������� � ���������� ��������� }
   procedure ViewChangedFragments(const aLeft: IDocument;
    const aRight: IDocument);
   class function Instance: TChangesBetweenEditionsService;
    {* ����� ��������� ���������� ���������� TChangesBetweenEditionsService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IChangesBetweenEditionsService
    write pm_SetAlien;
    {* ������� ���������� ������� IChangesBetweenEditionsService }
 end;//TChangesBetweenEditionsService

 (*
 MAACService = interface
  {* �������� ������� TAACService }
  procedure MakeAAC(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
   {* ������ ������ ��� ��������� ��� }
  procedure MakeAACContents(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
   {* ������ ������ ��� ��������� ���������� ��� }
 end;//MAACService
 *)

 IAACService = interface
  {* ��������� ������� TAACService }
  procedure MakeAAC(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
   {* ������ ������ ��� ��������� ��� }
  procedure MakeAACContents(const aDocInfo: IdeDocInfo;
   const aContainer: IvcmContainer);
   {* ������ ������ ��� ��������� ���������� ��� }
 end;//IAACService

 TAACService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IAACService;
    {* ������� ���������� ������� IAACService }
  protected
   procedure pm_SetAlien(const aValue: IAACService);
   procedure ClearFields; override;
  public
   procedure MakeAAC(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* ������ ������ ��� ��������� ��� }
   procedure MakeAACContents(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
    {* ������ ������ ��� ��������� ���������� ��� }
   class function Instance: TAACService;
    {* ����� ��������� ���������� ���������� TAACService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
  public
   property Alien: IAACService
    write pm_SetAlien;
    {* ������� ���������� ������� IAACService }
 end;//TAACService

 TstTMainMenuServiceChangeableMainMenuTypeItem = class(TddComboBoxConfigItem)
  {* ������������ ��� ��������� "��� ���������� ����� ��������� ����" }
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstTMainMenuServiceChangeableMainMenuTypeItem

 TstTDocumentServiceShowChangesInfoItem = class(TddComboBoxConfigItem)
  {* ������������ ��� ��������� "���������� ������� ��������� � ���������" }
  public
   constructor Create(aMasterItem: TddBaseConfigItem = nil); reintroduce;
 end;//TstTDocumentServiceShowChangesInfoItem

const
 {* ����� �������������� �������������� ����� ChangeableMainMenuTypeValues }
 ChangeableMainMenuTypeValuesMap: array [ChangeableMainMenuTypeEnum] of Pl3StringIDEx = (
 @str_ChangeableMainMenuType_ST_FINANCE
 , @str_ChangeableMainMenuType_ST_HR
 , @str_ChangeableMainMenuType_ST_LEGAL
 , @str_ChangeableMainMenuType_ST_BUDGET_ORGS
 );

function TnsDocumentForReturnInfo_C(const aDoc: IDocument;
 const aPara: IeeLeafPara): TnsDocumentForReturnInfo;

var mod_opcode_ChatService_OpenContactList: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_DictionService_OpenDict: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_InternetAgentService_InternetAgent: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_DayTipsService_ShowDayTips: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_DocumentListFromFileService_OpenDocumentListFromFile: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_FoldersService_MyConsultations: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_FoldersService_MyInformation: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_FoldersService_OpenFrmAct: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_FoldersService_UnderControlOpenFrmAct: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SearchService_AllSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SearchService_AttributeSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SearchService_BaseSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SearchService_DocumentsWithoutClass: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SearchService_DocumentsWithoutIncluded: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SearchService_DocumentsWithoutKey: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SearchService_InpharmSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SearchService_OpenConsult: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SearchService_PublishSourceSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SearchService_StartENO: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SearchService_OpenKeyWordSearch: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SettingsService_AutoLogin: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SettingsService_LoadActiveSettings: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SettingsService_OpenConfList: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SettingsService_OpenStyleEditorAsModal: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SettingsService_SelectConfig: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_SettingsService_UserProperties: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_WorkJournalService_OpenJournal: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_DocumentService_OpenDocOnNumber: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_MonitoringsService_OpenLegislationReview: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_MonitoringsService_OpenNewsLine: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsStyleParser
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , DataAdapter
 , l3MessageID
 , afwFacade
 {$If NOT Defined(NoVCM)}
 , vcmItems
 {$IfEnd} // NOT Defined(NoVCM)
 , ddAppConfigConst
;

type
 TMainMenuOpenServiceImpl = {final} class(Tl3ProtoObject, IMainMenuOpenService)
  public
   procedure OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
   class function Instance: TMainMenuOpenServiceImpl;
    {* ����� ��������� ���������� ���������� TMainMenuOpenServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TMainMenuOpenServiceImpl

 TRubricatorOpenServiceImpl = {final} class(Tl3ProtoObject, IRubricatorOpenService)
  public
   procedure OpenRubricator(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem;
    aNeedsSheet: Boolean;
    const anAggregate: IvcmAggregate;
    const aContainer: IvcmContainer);
   class function Instance: TRubricatorOpenServiceImpl;
    {* ����� ��������� ���������� ���������� TRubricatorOpenServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TRubricatorOpenServiceImpl

 TQueryOpenServiceImpl = {final} class(Tl3ProtoObject, IQueryOpenService)
  public
   procedure OpenQuery(aQueryType: TlgQueryType;
    const aQuery: IQuery;
    const aContainer: IvcmContainer);
   class function Instance: TQueryOpenServiceImpl;
    {* ����� ��������� ���������� ���������� TQueryOpenServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TQueryOpenServiceImpl

 TDocumentOpenServiceImpl = {final} class(Tl3ProtoObject, IDocumentOpenService)
  public
   procedure OpenDocument(const aDocInfo: IdeDocInfo;
    const aContainer: IvcmContainer);
   class function Instance: TDocumentOpenServiceImpl;
    {* ����� ��������� ���������� ���������� TDocumentOpenServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TDocumentOpenServiceImpl

 TDocumentSettingsServiceImpl = {final} class(Tl3ProtoObject, IDocumentSettingsService)
  public
   function ShowChangesInfoSetting: Boolean;
   class function Instance: TDocumentSettingsServiceImpl;
    {* ����� ��������� ���������� ���������� TDocumentSettingsServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TDocumentSettingsServiceImpl

 TListOpenServiceImpl = {final} class(Tl3ProtoObject, IListOpenService)
  public
   procedure OpenList(const aList: IdeList;
    const aContainer: IvcmContainer);
   class function Instance: TListOpenServiceImpl;
    {* ����� ��������� ���������� ���������� TListOpenServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TListOpenServiceImpl

 TControlledObjectServiceImpl = {final} class(Tl3ProtoObject, IControlledObjectService)
  public
   procedure AddControlledObject(const aData: IControllable);
   procedure DeleteControlledObject(const aData: IControllable);
   class function Instance: TControlledObjectServiceImpl;
    {* ����� ��������� ���������� ���������� TControlledObjectServiceImpl }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TControlledObjectServiceImpl

var g_TChatService: TChatService = nil;
 {* ��������� ���������� TChatService }
var g_TDictionService: TDictionService = nil;
 {* ��������� ���������� TDictionService }
var g_TInpharmService: TInpharmService = nil;
 {* ��������� ���������� TInpharmService }
var g_TInternetAgentService: TInternetAgentService = nil;
 {* ��������� ���������� TInternetAgentService }
var g_TDayTipsService: TDayTipsService = nil;
 {* ��������� ���������� TDayTipsService }
var g_TDocumentListFromFileService: TDocumentListFromFileService = nil;
 {* ��������� ���������� TDocumentListFromFileService }
var g_TChangeableMainMenuTypeValuesMapImpl: Pointer = nil;
 {* ��������� ���������� TChangeableMainMenuTypeValuesMapImpl }
var g_TMainMenuOpenServiceImpl: TMainMenuOpenServiceImpl = nil;
 {* ��������� ���������� TMainMenuOpenServiceImpl }
var g_TMainMenuService: TMainMenuService = nil;
 {* ��������� ���������� TMainMenuService }
var g_TBaseSearchService: TBaseSearchService = nil;
 {* ��������� ���������� TBaseSearchService }
var g_TFiltersService: TFiltersService = nil;
 {* ��������� ���������� TFiltersService }
var g_TFoldersService: TFoldersService = nil;
 {* ��������� ���������� TFoldersService }
var g_TRubricatorOpenServiceImpl: TRubricatorOpenServiceImpl = nil;
 {* ��������� ���������� TRubricatorOpenServiceImpl }
var g_TRubricatorService: TRubricatorService = nil;
 {* ��������� ���������� TRubricatorService }
var g_TQueryOpenServiceImpl: TQueryOpenServiceImpl = nil;
 {* ��������� ���������� TQueryOpenServiceImpl }
var g_TSearchService: TSearchService = nil;
 {* ��������� ���������� TSearchService }
var g_TSettingsService: TSettingsService = nil;
 {* ��������� ���������� TSettingsService }
var g_TWorkJournalService: TWorkJournalService = nil;
 {* ��������� ���������� TWorkJournalService }
var g_TShowChangesInfoValuesMapImpl: Pointer = nil;
 {* ��������� ���������� TShowChangesInfoValuesMapImpl }
var g_TDocumentOpenServiceImpl: TDocumentOpenServiceImpl = nil;
 {* ��������� ���������� TDocumentOpenServiceImpl }
var g_TDocumentSettingsServiceImpl: TDocumentSettingsServiceImpl = nil;
 {* ��������� ���������� TDocumentSettingsServiceImpl }
var g_TDocumentService: TDocumentService = nil;
 {* ��������� ���������� TDocumentService }
var g_TMonitoringsService: TMonitoringsService = nil;
 {* ��������� ���������� TMonitoringsService }
var g_TEditionsService: TEditionsService = nil;
 {* ��������� ���������� TEditionsService }
var g_TListOpenServiceImpl: TListOpenServiceImpl = nil;
 {* ��������� ���������� TListOpenServiceImpl }
var g_TListService: TListService = nil;
 {* ��������� ���������� TListService }
var g_TConsultationService: TConsultationService = nil;
 {* ��������� ���������� TConsultationService }
var g_TControlledObjectServiceImpl: TControlledObjectServiceImpl = nil;
 {* ��������� ���������� TControlledObjectServiceImpl }
var g_TUnderControlService: TUnderControlService = nil;
 {* ��������� ���������� TUnderControlService }
var g_TChangesBetweenEditionsService: TChangesBetweenEditionsService = nil;
 {* ��������� ���������� TChangesBetweenEditionsService }
var g_TAACService: TAACService = nil;
 {* ��������� ���������� TAACService }

procedure TMainMenuOpenServiceImplFree;
 {* ����� ������������ ���������� ���������� TMainMenuOpenServiceImpl }
begin
 l3Free(g_TMainMenuOpenServiceImpl);
end;//TMainMenuOpenServiceImplFree

procedure TRubricatorOpenServiceImplFree;
 {* ����� ������������ ���������� ���������� TRubricatorOpenServiceImpl }
begin
 l3Free(g_TRubricatorOpenServiceImpl);
end;//TRubricatorOpenServiceImplFree

procedure TQueryOpenServiceImplFree;
 {* ����� ������������ ���������� ���������� TQueryOpenServiceImpl }
begin
 l3Free(g_TQueryOpenServiceImpl);
end;//TQueryOpenServiceImplFree

procedure TDocumentOpenServiceImplFree;
 {* ����� ������������ ���������� ���������� TDocumentOpenServiceImpl }
begin
 l3Free(g_TDocumentOpenServiceImpl);
end;//TDocumentOpenServiceImplFree

procedure TDocumentSettingsServiceImplFree;
 {* ����� ������������ ���������� ���������� TDocumentSettingsServiceImpl }
begin
 l3Free(g_TDocumentSettingsServiceImpl);
end;//TDocumentSettingsServiceImplFree

procedure TListOpenServiceImplFree;
 {* ����� ������������ ���������� ���������� TListOpenServiceImpl }
begin
 l3Free(g_TListOpenServiceImpl);
end;//TListOpenServiceImplFree

procedure TControlledObjectServiceImplFree;
 {* ����� ������������ ���������� ���������� TControlledObjectServiceImpl }
begin
 l3Free(g_TControlledObjectServiceImpl);
end;//TControlledObjectServiceImplFree

procedure TChatServiceFree;
 {* ����� ������������ ���������� ���������� TChatService }
begin
 l3Free(g_TChatService);
end;//TChatServiceFree

procedure TDictionServiceFree;
 {* ����� ������������ ���������� ���������� TDictionService }
begin
 l3Free(g_TDictionService);
end;//TDictionServiceFree

procedure TInpharmServiceFree;
 {* ����� ������������ ���������� ���������� TInpharmService }
begin
 l3Free(g_TInpharmService);
end;//TInpharmServiceFree

procedure TInternetAgentServiceFree;
 {* ����� ������������ ���������� ���������� TInternetAgentService }
begin
 l3Free(g_TInternetAgentService);
end;//TInternetAgentServiceFree

procedure TDayTipsServiceFree;
 {* ����� ������������ ���������� ���������� TDayTipsService }
begin
 l3Free(g_TDayTipsService);
end;//TDayTipsServiceFree

procedure TDocumentListFromFileServiceFree;
 {* ����� ������������ ���������� ���������� TDocumentListFromFileService }
begin
 l3Free(g_TDocumentListFromFileService);
end;//TDocumentListFromFileServiceFree

procedure TChangeableMainMenuTypeValuesMapImplFree;
 {* ����� ������������ ���������� ���������� TChangeableMainMenuTypeValuesMapImpl }
begin
 IUnknown(g_TChangeableMainMenuTypeValuesMapImpl) := nil;
end;//TChangeableMainMenuTypeValuesMapImplFree

procedure TMainMenuServiceFree;
 {* ����� ������������ ���������� ���������� TMainMenuService }
begin
 l3Free(g_TMainMenuService);
end;//TMainMenuServiceFree

procedure TBaseSearchServiceFree;
 {* ����� ������������ ���������� ���������� TBaseSearchService }
begin
 l3Free(g_TBaseSearchService);
end;//TBaseSearchServiceFree

procedure TFiltersServiceFree;
 {* ����� ������������ ���������� ���������� TFiltersService }
begin
 l3Free(g_TFiltersService);
end;//TFiltersServiceFree

procedure TFoldersServiceFree;
 {* ����� ������������ ���������� ���������� TFoldersService }
begin
 l3Free(g_TFoldersService);
end;//TFoldersServiceFree

procedure TRubricatorServiceFree;
 {* ����� ������������ ���������� ���������� TRubricatorService }
begin
 l3Free(g_TRubricatorService);
end;//TRubricatorServiceFree

procedure TSearchServiceFree;
 {* ����� ������������ ���������� ���������� TSearchService }
begin
 l3Free(g_TSearchService);
end;//TSearchServiceFree

procedure TSettingsServiceFree;
 {* ����� ������������ ���������� ���������� TSettingsService }
begin
 l3Free(g_TSettingsService);
end;//TSettingsServiceFree

procedure TWorkJournalServiceFree;
 {* ����� ������������ ���������� ���������� TWorkJournalService }
begin
 l3Free(g_TWorkJournalService);
end;//TWorkJournalServiceFree

procedure TShowChangesInfoValuesMapImplFree;
 {* ����� ������������ ���������� ���������� TShowChangesInfoValuesMapImpl }
begin
 IUnknown(g_TShowChangesInfoValuesMapImpl) := nil;
end;//TShowChangesInfoValuesMapImplFree

procedure TDocumentServiceFree;
 {* ����� ������������ ���������� ���������� TDocumentService }
begin
 l3Free(g_TDocumentService);
end;//TDocumentServiceFree

procedure TMonitoringsServiceFree;
 {* ����� ������������ ���������� ���������� TMonitoringsService }
begin
 l3Free(g_TMonitoringsService);
end;//TMonitoringsServiceFree

function TnsDocumentForReturnInfo_C(const aDoc: IDocument;
 const aPara: IeeLeafPara): TnsDocumentForReturnInfo;
//#UC START# *4B6074C60325_4B60748400F9_var*
//#UC END# *4B6074C60325_4B60748400F9_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B6074C60325_4B60748400F9_impl*
 Result.rDoc := aDoc;
 Result.rPara := aPara;
//#UC END# *4B6074C60325_4B60748400F9_impl*
end;//TnsDocumentForReturnInfo_C

procedure TEditionsServiceFree;
 {* ����� ������������ ���������� ���������� TEditionsService }
begin
 l3Free(g_TEditionsService);
end;//TEditionsServiceFree

procedure TListServiceFree;
 {* ����� ������������ ���������� ���������� TListService }
begin
 l3Free(g_TListService);
end;//TListServiceFree

procedure TConsultationServiceFree;
 {* ����� ������������ ���������� ���������� TConsultationService }
begin
 l3Free(g_TConsultationService);
end;//TConsultationServiceFree

procedure TUnderControlServiceFree;
 {* ����� ������������ ���������� ���������� TUnderControlService }
begin
 l3Free(g_TUnderControlService);
end;//TUnderControlServiceFree

procedure TChangesBetweenEditionsServiceFree;
 {* ����� ������������ ���������� ���������� TChangesBetweenEditionsService }
begin
 l3Free(g_TChangesBetweenEditionsService);
end;//TChangesBetweenEditionsServiceFree

procedure TAACServiceFree;
 {* ����� ������������ ���������� ���������� TAACService }
begin
 l3Free(g_TAACService);
end;//TAACServiceFree

procedure TChatService.pm_SetAlien(const aValue: IChatService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TChatService.pm_SetAlien

function TChatService.MakeChatDispatcher: IbsChatDispatcher;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeChatDispatcher
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TChatService.MakeChatDispatcher

function TChatService.OpenAddUserDialog: IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenAddUserDialog
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TChatService.OpenAddUserDialog

function TChatService.OpenChatWindow(anUID: TbsUserID;
 const aName: Il3CString): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenChatWindow(anUID, aName)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TChatService.OpenChatWindow

function TChatService.OpenHistoryWindow(anUID: TbsUserID;
 const aName: Il3CString): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenHistoryWindow(anUID, aName)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TChatService.OpenHistoryWindow

class function TChatService.Instance: TChatService;
 {* ����� ��������� ���������� ���������� TChatService }
begin
 if (g_TChatService = nil) then
 begin
  l3System.AddExitProc(TChatServiceFree);
  g_TChatService := Create;
 end;
 Result := g_TChatService;
end;//TChatService.Instance

class function TChatService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TChatService <> nil;
end;//TChatService.Exists

procedure TChatService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TChatService.ClearFields

procedure TDictionService.pm_SetAlien(const aValue: IDictionService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TDictionService.pm_SetAlien

procedure TDictionService.OpenDictionary(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* ��������� �������� ������� }
begin
 if (f_Alien <> nil) then
  f_Alien.OpenDictionary(aDocInfo, aContainer);
end;//TDictionService.OpenDictionary

procedure TDictionService.OpenTermByContext(const aContext: Il3CString;
 aLanguage: TbsLanguage);
 {* ��������� ������ �� ��������� }
var l_Child: INodeBase;
var l_Str: Il3CString;
var l_Entity: IEntityBase;
var l_Doc: IDocument;
var l_DictTree: Il3SimpleTree;
var l_FilterTree: Il3FilterableTree;
begin
 if (f_Alien <> nil) then
  f_Alien.OpenTermByContext(aContext, aLanguage);
end;//TDictionService.OpenTermByContext

class function TDictionService.Instance: TDictionService;
 {* ����� ��������� ���������� ���������� TDictionService }
begin
 if (g_TDictionService = nil) then
 begin
  l3System.AddExitProc(TDictionServiceFree);
  g_TDictionService := Create;
 end;
 Result := g_TDictionService;
end;//TDictionService.Instance

class function TDictionService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TDictionService <> nil;
end;//TDictionService.Exists

procedure TDictionService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TDictionService.ClearFields

procedure TInpharmService.pm_SetAlien(const aValue: IInpharmService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TInpharmService.pm_SetAlien

procedure TInpharmService.OpenDrugListIfNeeded(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenDrugListIfNeeded(aContainer);
end;//TInpharmService.OpenDrugListIfNeeded

procedure TInpharmService.OpenInpharmMainMenu(const aContainer: IvcmContainer);
var l_FormId: TvcmFormID;
begin
 if (f_Alien <> nil) then
  f_Alien.OpenInpharmMainMenu(aContainer);
end;//TInpharmService.OpenInpharmMainMenu

procedure TInpharmService.MedicFirms(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.MedicFirms(aContainer);
end;//TInpharmService.MedicFirms

procedure TInpharmService.OpenDrugDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenDrugDocument(aDocInfo, aContainer);
end;//TInpharmService.OpenDrugDocument

procedure TInpharmService.OpenDrugList(const aList: IdeList;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenDrugList(aList, aContainer);
end;//TInpharmService.OpenDrugList

procedure TInpharmService.OpenMedicDiction(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenMedicDiction(aDocInfo, aContainer);
end;//TInpharmService.OpenMedicDiction

procedure TInpharmService.OpenMedicFirmDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenMedicFirmDocument(aDocInfo, aContainer);
end;//TInpharmService.OpenMedicFirmDocument

class function TInpharmService.Instance: TInpharmService;
 {* ����� ��������� ���������� ���������� TInpharmService }
begin
 if (g_TInpharmService = nil) then
 begin
  l3System.AddExitProc(TInpharmServiceFree);
  g_TInpharmService := Create;
 end;
 Result := g_TInpharmService;
end;//TInpharmService.Instance

class function TInpharmService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TInpharmService <> nil;
end;//TInpharmService.Exists

procedure TInpharmService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TInpharmService.ClearFields

procedure TInternetAgentService.pm_SetAlien(const aValue: IInternetAgentService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TInternetAgentService.pm_SetAlien

procedure TInternetAgentService.MakeInternetAgent(const anURL: Il3CString;
 const aContainer: IvcmContainer);
 {* ������ ������� ������ ��������-������ }
begin
 if (f_Alien <> nil) then
  f_Alien.MakeInternetAgent(anURL, aContainer);
end;//TInternetAgentService.MakeInternetAgent

class function TInternetAgentService.Instance: TInternetAgentService;
 {* ����� ��������� ���������� ���������� TInternetAgentService }
begin
 if (g_TInternetAgentService = nil) then
 begin
  l3System.AddExitProc(TInternetAgentServiceFree);
  g_TInternetAgentService := Create;
 end;
 Result := g_TInternetAgentService;
end;//TInternetAgentService.Instance

class function TInternetAgentService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TInternetAgentService <> nil;
end;//TInternetAgentService.Exists

procedure TInternetAgentService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TInternetAgentService.ClearFields

procedure TDayTipsService.pm_SetAlien(const aValue: IDayTipsService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TDayTipsService.pm_SetAlien

function TDayTipsService.ShowDayTipsAtStartup: IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.ShowDayTipsAtStartup
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TDayTipsService.ShowDayTipsAtStartup

procedure TDayTipsService.OpenTip(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* ��������� ����� ��� }
begin
 if (f_Alien <> nil) then
  f_Alien.OpenTip(aDocInfo, aContainer);
end;//TDayTipsService.OpenTip

class function TDayTipsService.Instance: TDayTipsService;
 {* ����� ��������� ���������� ���������� TDayTipsService }
begin
 if (g_TDayTipsService = nil) then
 begin
  l3System.AddExitProc(TDayTipsServiceFree);
  g_TDayTipsService := Create;
 end;
 Result := g_TDayTipsService;
end;//TDayTipsService.Instance

class function TDayTipsService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TDayTipsService <> nil;
end;//TDayTipsService.Exists

procedure TDayTipsService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TDayTipsService.ClearFields

procedure TDocumentListFromFileService.pm_SetAlien(const aValue: IDocumentListFromFileService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TDocumentListFromFileService.pm_SetAlien

class function TDocumentListFromFileService.Instance: TDocumentListFromFileService;
 {* ����� ��������� ���������� ���������� TDocumentListFromFileService }
begin
 if (g_TDocumentListFromFileService = nil) then
 begin
  l3System.AddExitProc(TDocumentListFromFileServiceFree);
  g_TDocumentListFromFileService := Create;
 end;
 Result := g_TDocumentListFromFileService;
end;//TDocumentListFromFileService.Instance

class function TDocumentListFromFileService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TDocumentListFromFileService <> nil;
end;//TDocumentListFromFileService.Exists

procedure TDocumentListFromFileService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TDocumentListFromFileService.ClearFields

class procedure ChangeableMainMenuTypeValuesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
var
 l_Index: ChangeableMainMenuTypeEnum;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(ChangeableMainMenuTypeValuesMap[l_Index].AsCStr);
end;//ChangeableMainMenuTypeValuesMapHelper.FillStrings

class function ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): ChangeableMainMenuTypeEnum;
 {* �������������� ���������� �������� � ����������� }
var
 l_Index: ChangeableMainMenuTypeEnum;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, ChangeableMainMenuTypeValuesMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "ChangeableMainMenuTypeValuesMap"', [l3Str(aDisplayName)]);
end;//ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue

class function TChangeableMainMenuTypeValuesMapImplPrim.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TChangeableMainMenuTypeValuesMapImplPrim }
var
 l_Inst : TChangeableMainMenuTypeValuesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TChangeableMainMenuTypeValuesMapImplPrim.Make

function TChangeableMainMenuTypeValuesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TChangeableMainMenuTypeValuesMapImplPrim.pm_GetMapID

procedure TChangeableMainMenuTypeValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
begin
 ChangeableMainMenuTypeValuesMapHelper.FillStrings(aList);
end;//TChangeableMainMenuTypeValuesMapImplPrim.GetDisplayNames

function TChangeableMainMenuTypeValuesMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
begin
 Result := Ord(High(ChangeableMainMenuTypeEnum)) - Ord(Low(ChangeableMainMenuTypeEnum));
end;//TChangeableMainMenuTypeValuesMapImplPrim.MapSize

function TChangeableMainMenuTypeValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
begin
 Result := Ord(ChangeableMainMenuTypeValuesMapHelper.DisplayNameToValue(aDisplayName));
end;//TChangeableMainMenuTypeValuesMapImplPrim.DisplayNameToValue

function TChangeableMainMenuTypeValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 Assert(aValue >= Ord(Low(ChangeableMainMenuTypeEnum)));
 Assert(aValue <= Ord(High(ChangeableMainMenuTypeEnum)));
 Result := ChangeableMainMenuTypeValuesMap[ChangeableMainMenuTypeEnum(aValue)].AsCStr;
end;//TChangeableMainMenuTypeValuesMapImplPrim.ValueToDisplayName

class function TChangeableMainMenuTypeValuesMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TChangeableMainMenuTypeValuesMapImpl }
begin
 if (g_TChangeableMainMenuTypeValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TChangeableMainMenuTypeValuesMapImplFree);
  Il3IntegerValueMap(g_TChangeableMainMenuTypeValuesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TChangeableMainMenuTypeValuesMapImpl);
end;//TChangeableMainMenuTypeValuesMapImpl.Make

class function TChangeableMainMenuTypeValuesMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TChangeableMainMenuTypeValuesMapImpl <> nil;
end;//TChangeableMainMenuTypeValuesMapImpl.Exists

procedure TMainMenuOpenServiceImpl.OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
begin
 TMainMenuService.Instance.OpenMainMenuIfNeeded(aContainer);
end;//TMainMenuOpenServiceImpl.OpenMainMenuIfNeeded

class function TMainMenuOpenServiceImpl.Instance: TMainMenuOpenServiceImpl;
 {* ����� ��������� ���������� ���������� TMainMenuOpenServiceImpl }
begin
 if (g_TMainMenuOpenServiceImpl = nil) then
 begin
  l3System.AddExitProc(TMainMenuOpenServiceImplFree);
  g_TMainMenuOpenServiceImpl := Create;
 end;
 Result := g_TMainMenuOpenServiceImpl;
end;//TMainMenuOpenServiceImpl.Instance

class function TMainMenuOpenServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TMainMenuOpenServiceImpl <> nil;
end;//TMainMenuOpenServiceImpl.Exists

procedure TMainMenuService.pm_SetAlien(const aValue: IMainMenuService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TMainMenuService.pm_SetAlien

class function TMainMenuService.ChangeableMainMenuTypeSetting: Integer;
 {* ����� ��� ��������� �������� ��������� "��� ���������� ����� ��������� ����" }
begin
 if (afw.Settings = nil) then
  Result := dv_TMainMenuService_ChangeableMainMenuType
 else
  Result := afw.Settings.LoadInteger(pi_TMainMenuService_ChangeableMainMenuType, dv_TMainMenuService_ChangeableMainMenuType);
end;//TMainMenuService.ChangeableMainMenuTypeSetting

class procedure TMainMenuService.WriteChangeableMainMenuTypeSetting(aValue: Integer);
 {* ����� ��� ������ �������� ��������� "��� ���������� ����� ��������� ����" }
begin
 if (afw.Settings <> nil) then
 afw.Settings.SaveInteger(pi_TMainMenuService_ChangeableMainMenuType, aValue);
end;//TMainMenuService.WriteChangeableMainMenuTypeSetting

procedure TMainMenuService.OpenMainMenuIfNeeded(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenMainMenuIfNeeded(aContainer);
end;//TMainMenuService.OpenMainMenuIfNeeded

class function TMainMenuService.Instance: TMainMenuService;
 {* ����� ��������� ���������� ���������� TMainMenuService }
begin
 if (g_TMainMenuService = nil) then
 begin
  l3System.AddExitProc(TMainMenuServiceFree);
  g_TMainMenuService := Create;
 end;
 Result := g_TMainMenuService;
end;//TMainMenuService.Instance

class function TMainMenuService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TMainMenuService <> nil;
end;//TMainMenuService.Exists

procedure TMainMenuService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TMainMenuService.ClearFields

procedure TBaseSearchService.pm_SetAlien(const aValue: IBaseSearchService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TBaseSearchService.pm_SetAlien

procedure TBaseSearchService.BaseSearchCheckFindBack(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.BaseSearchCheckFindBack(aContainer);
end;//TBaseSearchService.BaseSearchCheckFindBack

procedure TBaseSearchService.BaseSearchCheckFragmentsCount(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.BaseSearchCheckFragmentsCount(aContainer);
end;//TBaseSearchService.BaseSearchCheckFragmentsCount

procedure TBaseSearchService.CheckBaseSearchDataReady(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.CheckBaseSearchDataReady(aContainer);
end;//TBaseSearchService.CheckBaseSearchDataReady

procedure TBaseSearchService.OpenBaseSearch(OpenKind: TnsBaseSearchOpenKind;
 const aQuery: IQuery);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenBaseSearch(OpenKind, aQuery);
end;//TBaseSearchService.OpenBaseSearch

procedure TBaseSearchService.TryAnotherBaseSearch(const aContainer: IvcmContainer;
 const aProcessor: InsBaseSearchResultProcessor;
 TryFullList: Boolean = False);
begin
 if (f_Alien <> nil) then
  f_Alien.TryAnotherBaseSearch(aContainer, aProcessor, TryFullList);
end;//TBaseSearchService.TryAnotherBaseSearch

function TBaseSearchService.MakeBaseSearchCard(const aContainer: IvcmContainer): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeBaseSearchCard(aContainer)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TBaseSearchService.MakeBaseSearchCard

function TBaseSearchService.MakeBaseSearchWindow(const aContainer: IvcmContainer;
 const aData: InsBaseSearcherWindowData;
 aZoneType: TvcmZoneType): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeBaseSearchWindow(aContainer, aData, aZoneType)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TBaseSearchService.MakeBaseSearchWindow

class function TBaseSearchService.Instance: TBaseSearchService;
 {* ����� ��������� ���������� ���������� TBaseSearchService }
begin
 if (g_TBaseSearchService = nil) then
 begin
  l3System.AddExitProc(TBaseSearchServiceFree);
  g_TBaseSearchService := Create;
 end;
 Result := g_TBaseSearchService;
end;//TBaseSearchService.Instance

class function TBaseSearchService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TBaseSearchService <> nil;
end;//TBaseSearchService.Exists

procedure TBaseSearchService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TBaseSearchService.ClearFields

procedure TFiltersService.pm_SetAlien(const aValue: IFiltersService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TFiltersService.pm_SetAlien

function TFiltersService.CreateFilter(const aQuery: IQuery): Integer;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.CreateFilter(aQuery)
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TFiltersService.CreateFilter

procedure TFiltersService.FiltersOpen(const aData: IucpFilters);
begin
 if (f_Alien <> nil) then
  f_Alien.FiltersOpen(aData);
end;//TFiltersService.FiltersOpen

procedure TFiltersService.OldSchoolFiltersOpen(const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer;
 anOwner: TComponent);
begin
 if (f_Alien <> nil) then
  f_Alien.OldSchoolFiltersOpen(anAggregate, aContainer, anOwner);
end;//TFiltersService.OldSchoolFiltersOpen

procedure TFiltersService.RenameFilter(const aFilter: IFilterFromQuery);
begin
 if (f_Alien <> nil) then
  f_Alien.RenameFilter(aFilter);
end;//TFiltersService.RenameFilter

class function TFiltersService.Instance: TFiltersService;
 {* ����� ��������� ���������� ���������� TFiltersService }
begin
 if (g_TFiltersService = nil) then
 begin
  l3System.AddExitProc(TFiltersServiceFree);
  g_TFiltersService := Create;
 end;
 Result := g_TFiltersService;
end;//TFiltersService.Instance

class function TFiltersService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TFiltersService <> nil;
end;//TFiltersService.Exists

procedure TFiltersService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TFiltersService.ClearFields

procedure TFoldersService.pm_SetAlien(const aValue: IFoldersService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TFoldersService.pm_SetAlien

procedure TFoldersService.CloseFolders(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.CloseFolders(aContainer);
end;//TFoldersService.CloseFolders

procedure TFoldersService.SelectOpenWithOperation(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 const aCaption: TvcmStringID;
 anOp: TListLogicOperation);
begin
 if (f_Alien <> nil) then
  f_Alien.SelectOpenWithOperation(aForm, aFilterInfo, aCaption, anOp);
end;//TFoldersService.SelectOpenWithOperation

function TFoldersService.EditInfoOpen(aIsNewFolder: Boolean;
 const aNode: IeeNode;
 const aCoords: InsFormCoordinates): Integer;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.EditInfoOpen(aIsNewFolder, aNode, aCoords)
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TFoldersService.EditInfoOpen

procedure TFoldersService.SelectOpenWithUserData(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 const aCaption: TvcmStringID;
 const aUserData: IUnknown);
begin
 if (f_Alien <> nil) then
  f_Alien.SelectOpenWithUserData(aForm, aFilterInfo, aCaption, aUserData);
end;//TFoldersService.SelectOpenWithUserData

procedure TFoldersService.LoadOpen(const aForm: IvcmEntityForm;
 const aData: InsFolderFilterInfo);
begin
 if (f_Alien <> nil) then
  f_Alien.LoadOpen(aForm, aData);
end;//TFoldersService.LoadOpen

procedure TFoldersService.TryOpenConsultationAnswer(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.TryOpenConsultationAnswer(aContainer);
end;//TFoldersService.TryOpenConsultationAnswer

procedure TFoldersService.RefreshStructure(const aNode: INode;
 aStatus: TNotifyStatus);
begin
 if (f_Alien <> nil) then
  f_Alien.RefreshStructure(aNode, aStatus);
end;//TFoldersService.RefreshStructure

function TFoldersService.OpenFolders(const aContainer: IvcmContainer;
 aCanCreate: Boolean): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenFolders(aContainer, aCanCreate)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TFoldersService.OpenFolders

function TFoldersService.SaveOpen(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 anElementType: TFoldersElementType;
 const anEntity: IEntityBase;
 aSaveAs: Boolean): Integer;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.SaveOpen(aForm, aFilterInfo, anElementType, anEntity, aSaveAs)
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TFoldersService.SaveOpen

procedure TFoldersService.SelectOpen(const aForm: IvcmEntityForm;
 const aFilterInfo: InsFolderFilterInfo;
 const aCaption: TvcmStringID);
begin
 if (f_Alien <> nil) then
  f_Alien.SelectOpen(aForm, aFilterInfo, aCaption);
end;//TFoldersService.SelectOpen

class function TFoldersService.Instance: TFoldersService;
 {* ����� ��������� ���������� ���������� TFoldersService }
begin
 if (g_TFoldersService = nil) then
 begin
  l3System.AddExitProc(TFoldersServiceFree);
  g_TFoldersService := Create;
 end;
 Result := g_TFoldersService;
end;//TFoldersService.Instance

class function TFoldersService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TFoldersService <> nil;
end;//TFoldersService.Exists

procedure TFoldersService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TFoldersService.ClearFields

procedure TRubricatorOpenServiceImpl.OpenRubricator(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem;
 aNeedsSheet: Boolean;
 const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer);
begin
 TRubricatorService.Instance.OpenRubricator(aNode, aRootToKeep, aMenuSectionItemToKeep, aNeedsSheet, anAggregate, aContainer);
end;//TRubricatorOpenServiceImpl.OpenRubricator

class function TRubricatorOpenServiceImpl.Instance: TRubricatorOpenServiceImpl;
 {* ����� ��������� ���������� ���������� TRubricatorOpenServiceImpl }
begin
 if (g_TRubricatorOpenServiceImpl = nil) then
 begin
  l3System.AddExitProc(TRubricatorOpenServiceImplFree);
  g_TRubricatorOpenServiceImpl := Create;
 end;
 Result := g_TRubricatorOpenServiceImpl;
end;//TRubricatorOpenServiceImpl.Instance

class function TRubricatorOpenServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TRubricatorOpenServiceImpl <> nil;
end;//TRubricatorOpenServiceImpl.Exists

procedure TRubricatorService.pm_SetAlien(const aValue: IRubricatorService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TRubricatorService.pm_SetAlien

function TRubricatorService.OpenRubricator(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem;
 aNeedsSheet: Boolean;
 const anAggregate: IvcmAggregate;
 const aContainer: IvcmContainer): IvcmEntityForm;
var l_Container: IvcmEntityForm;
var l_Navigator: IvcmEntityForm;
var l_Aggregate: IvcmAggregate;
var l_Params: IvcmMakeParams;
var l_RubrExists: Boolean;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenRubricator(aNode, aRootToKeep, aMenuSectionItemToKeep, aNeedsSheet, anAggregate, aContainer)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TRubricatorService.OpenRubricator

class function TRubricatorService.Instance: TRubricatorService;
 {* ����� ��������� ���������� ���������� TRubricatorService }
begin
 if (g_TRubricatorService = nil) then
 begin
  l3System.AddExitProc(TRubricatorServiceFree);
  g_TRubricatorService := Create;
 end;
 Result := g_TRubricatorService;
end;//TRubricatorService.Instance

class function TRubricatorService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TRubricatorService <> nil;
end;//TRubricatorService.Exists

procedure TRubricatorService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TRubricatorService.ClearFields

procedure TQueryOpenServiceImpl.OpenQuery(aQueryType: TlgQueryType;
 const aQuery: IQuery;
 const aContainer: IvcmContainer);
//#UC START# *9856D0A1DBB4_579F4A7103CF_57A339A6014A_Impl_var*
//#UC END# *9856D0A1DBB4_579F4A7103CF_57A339A6014A_Impl_var*
begin
//#UC START# *9856D0A1DBB4_579F4A7103CF_57A339A6014A_Impl_impl*
 case aQueryType of
  lg_qtKeyWord:
   TSearchService.Instance.OpenKeyWord(aQuery, aContainer);
  lg_qtAttribute:
   TSearchService.Instance.AttributeSearch(aQuery, nil, aContainer);
  lg_qtPublishedSource:
   TSearchService.Instance.PublishSourceSearch(aQuery, nil);
  lg_qtLegislationReview:
   TSearchService.Instance.OpenLegislationReview(aQuery);
  lg_qtSendConsultation:
   vcmDispatcher.ModuleOperation(mod_opcode_SearchService_OpenConsult);
  lg_qtBaseSearch:
   TBaseSearchService.Instance.OpenBaseSearch(ns_bsokGlobal, aQuery);
  lg_qtInpharmSearch:
   TSearchService.Instance.InpharmSearch(aQuery, nil, aContainer);
  else
   Assert(false);   
 end;//case aQueryType
//#UC END# *9856D0A1DBB4_579F4A7103CF_57A339A6014A_Impl_impl*
end;//TQueryOpenServiceImpl.OpenQuery

class function TQueryOpenServiceImpl.Instance: TQueryOpenServiceImpl;
 {* ����� ��������� ���������� ���������� TQueryOpenServiceImpl }
begin
 if (g_TQueryOpenServiceImpl = nil) then
 begin
  l3System.AddExitProc(TQueryOpenServiceImplFree);
  g_TQueryOpenServiceImpl := Create;
 end;
 Result := g_TQueryOpenServiceImpl;
end;//TQueryOpenServiceImpl.Instance

class function TQueryOpenServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TQueryOpenServiceImpl <> nil;
end;//TQueryOpenServiceImpl.Exists

procedure TSearchService.pm_SetAlien(const aValue: ISearchService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TSearchService.pm_SetAlien

procedure TSearchService.AttributeSearch(const aQuery: IQuery;
 const aList: IDynList;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.AttributeSearch(aQuery, aList, aContainer);
end;//TSearchService.AttributeSearch

procedure TSearchService.EditFilter(const aFilter: IdeFilter;
 anItemIndex: Integer);
 {* �������������� ������ }
begin
 if (f_Alien <> nil) then
  f_Alien.EditFilter(aFilter, anItemIndex);
end;//TSearchService.EditFilter

procedure TSearchService.InpharmSearch(const aQuery: IQuery;
 const aList: IDynList;
 const aContainer: IvcmContainer);
 {* ����� ������������� ������� }
begin
 if (f_Alien <> nil) then
  f_Alien.InpharmSearch(aQuery, aList, aContainer);
end;//TSearchService.InpharmSearch

procedure TSearchService.MakeNewFilter(aListType: TbsListType);
 {* �������� ����� �������� ������ ������� }
begin
 if (f_Alien <> nil) then
  f_Alien.MakeNewFilter(aListType);
end;//TSearchService.MakeNewFilter

procedure TSearchService.OpenKeyWord(const aQuery: IQuery;
 const aContainer: IvcmContainer);
 {* ������� ��� }
begin
 if (f_Alien <> nil) then
  f_Alien.OpenKeyWord(aQuery, aContainer);
end;//TSearchService.OpenKeyWord

procedure TSearchService.OpenOldSituationCard(const aQuery: IQuery;
 const aContainer: IvcmContainer);
 {* ������� ��� 5.� }
begin
 if (f_Alien <> nil) then
  f_Alien.OpenOldSituationCard(aQuery, aContainer);
end;//TSearchService.OpenOldSituationCard

procedure TSearchService.OpenPharmLegislationReview;
begin
 if (f_Alien <> nil) then
  f_Alien.OpenPharmLegislationReview;
end;//TSearchService.OpenPharmLegislationReview

procedure TSearchService.OpenPharmPublishSearch;
begin
 if (f_Alien <> nil) then
  f_Alien.OpenPharmPublishSearch;
end;//TSearchService.OpenPharmPublishSearch

procedure TSearchService.OpenSituationCard(const aQuery: IQuery);
 {* ������� ��� 6.� }
begin
 if (f_Alien <> nil) then
  f_Alien.OpenSituationCard(aQuery);
end;//TSearchService.OpenSituationCard

procedure TSearchService.OpenTaxesPublishSearch(const aPublishSearchTag: Il3CString);
 {* ��� �� ������� � �������� }
begin
 if (f_Alien <> nil) then
  f_Alien.OpenTaxesPublishSearch(aPublishSearchTag);
end;//TSearchService.OpenTaxesPublishSearch

procedure TSearchService.PublishSourceSearch(const aQuery: IQuery;
 const aList: IDynList);
begin
 if (f_Alien <> nil) then
  f_Alien.PublishSourceSearch(aQuery, aList);
end;//TSearchService.PublishSourceSearch

function TSearchService.DateQuery(const aCaller: IvcmEntityForm;
 const aData: IqaDateReqDataHolder): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.DateQuery(aCaller, aData)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TSearchService.DateQuery

function TSearchService.OpenFiltersForm(const aData: IdeFilter): IvcmEntityForm;
 {* ��������� ����� �������� }
var l_MainContainer: IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenFiltersForm(aData)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TSearchService.OpenFiltersForm

function TSearchService.OpenLegislationReview(const aQuery: IQuery): IvcmEntityForm;
 {* ������� ����� ��������� ���������������� }
var l_Container: IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenLegislationReview(aQuery)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TSearchService.OpenLegislationReview

class function TSearchService.Instance: TSearchService;
 {* ����� ��������� ���������� ���������� TSearchService }
begin
 if (g_TSearchService = nil) then
 begin
  l3System.AddExitProc(TSearchServiceFree);
  g_TSearchService := Create;
 end;
 Result := g_TSearchService;
end;//TSearchService.Instance

class function TSearchService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TSearchService <> nil;
end;//TSearchService.Exists

procedure TSearchService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TSearchService.ClearFields

procedure TSettingsService.pm_SetAlien(const aValue: ISettingsService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TSettingsService.pm_SetAlien

procedure TSettingsService.CloseConfList(const aContainer: IvcmContainer);
 {* ������� ������ ������������ }
begin
 if (f_Alien <> nil) then
  f_Alien.CloseConfList(aContainer);
end;//TSettingsService.CloseConfList

procedure TSettingsService.OpenConfList(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenConfList(aContainer);
end;//TSettingsService.OpenConfList

function TSettingsService.OpenStyleEditorAsModal(const aData: InsStyleTableSettingsInfo): Integer;
var l_SettingsData: InsStyleTableSettingsInfo;
var l_Container: IvcmEntityForm;
var l_Params: IvcmMakeParams;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenStyleEditorAsModal(aData)
 else
 begin
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TSettingsService.OpenStyleEditorAsModal

function TSettingsService.LoadSettings(const anAggregate: IvcmAggregate;
 const aData: InsConfigSettingsInfo): IvcmEntityForm;
 {* ������� ��������� }
begin
 if (f_Alien <> nil) then
  Result := f_Alien.LoadSettings(anAggregate, aData)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TSettingsService.LoadSettings

class function TSettingsService.Instance: TSettingsService;
 {* ����� ��������� ���������� ���������� TSettingsService }
begin
 if (g_TSettingsService = nil) then
 begin
  l3System.AddExitProc(TSettingsServiceFree);
  g_TSettingsService := Create;
 end;
 Result := g_TSettingsService;
end;//TSettingsService.Instance

class function TSettingsService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TSettingsService <> nil;
end;//TSettingsService.Exists

procedure TSettingsService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TSettingsService.ClearFields

procedure TWorkJournalService.pm_SetAlien(const aValue: IWorkJournalService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TWorkJournalService.pm_SetAlien

function TWorkJournalService.MakeWorkJournal: IbsWorkJournal;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeWorkJournal
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TWorkJournalService.MakeWorkJournal

class function TWorkJournalService.Instance: TWorkJournalService;
 {* ����� ��������� ���������� ���������� TWorkJournalService }
begin
 if (g_TWorkJournalService = nil) then
 begin
  l3System.AddExitProc(TWorkJournalServiceFree);
  g_TWorkJournalService := Create;
 end;
 Result := g_TWorkJournalService;
end;//TWorkJournalService.Instance

class function TWorkJournalService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TWorkJournalService <> nil;
end;//TWorkJournalService.Exists

procedure TWorkJournalService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TWorkJournalService.ClearFields

class procedure ShowChangesInfoValuesMapHelper.FillStrings(const aStrings: IafwStrings);
 {* ���������� ������ ����� ���������� }
var
 l_Index: Boolean;
begin
 aStrings.Clear;
 for l_Index := Low(l_Index) to High(l_Index) do
  aStrings.Add(ShowChangesInfoValuesMap[l_Index].AsCStr);
end;//ShowChangesInfoValuesMapHelper.FillStrings

class function ShowChangesInfoValuesMapHelper.DisplayNameToValue(const aDisplayName: Il3CString): Boolean;
 {* �������������� ���������� �������� � ����������� }
var
 l_Index: Boolean;
begin
 for l_Index := Low(l_Index) to High(l_Index) do
  if l3Same(aDisplayName, ShowChangesInfoValuesMap[l_Index].AsCStr) then
  begin
   Result := l_Index;
   Exit;
  end;//l3Same..
 raise Exception.CreateFmt('Display name "%s" not found in map "ShowChangesInfoValuesMap"', [l3Str(aDisplayName)]);
end;//ShowChangesInfoValuesMapHelper.DisplayNameToValue

class function TShowChangesInfoValuesMapImplPrim.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TShowChangesInfoValuesMapImplPrim }
var
 l_Inst : TShowChangesInfoValuesMapImplPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TShowChangesInfoValuesMapImplPrim.Make

function TShowChangesInfoValuesMapImplPrim.pm_GetMapID: Tl3ValueMapID;
begin
 l3FillChar(Result, SizeOf(Result));
 Assert(false);
end;//TShowChangesInfoValuesMapImplPrim.pm_GetMapID

procedure TShowChangesInfoValuesMapImplPrim.GetDisplayNames(const aList: Il3StringsEx);
 {* ��������� ������ ���������� "UI-������" }
begin
 ShowChangesInfoValuesMapHelper.FillStrings(aList);
end;//TShowChangesInfoValuesMapImplPrim.GetDisplayNames

function TShowChangesInfoValuesMapImplPrim.MapSize: Integer;
 {* ���������� ��������� � ����. }
begin
 Result := Ord(High(Boolean)) - Ord(Low(Boolean));
end;//TShowChangesInfoValuesMapImplPrim.MapSize

function TShowChangesInfoValuesMapImplPrim.DisplayNameToValue(const aDisplayName: Il3CString): Integer;
begin
 Result := Ord(ShowChangesInfoValuesMapHelper.DisplayNameToValue(aDisplayName));
end;//TShowChangesInfoValuesMapImplPrim.DisplayNameToValue

function TShowChangesInfoValuesMapImplPrim.ValueToDisplayName(aValue: Integer): Il3CString;
begin
 Assert(aValue >= Ord(Low(Boolean)));
 Assert(aValue <= Ord(High(Boolean)));
 Result := ShowChangesInfoValuesMap[Boolean(aValue)].AsCStr;
end;//TShowChangesInfoValuesMapImplPrim.ValueToDisplayName

class function TShowChangesInfoValuesMapImpl.Make: Il3IntegerValueMap;
 {* ��������� ����� ��� TShowChangesInfoValuesMapImpl }
begin
 if (g_TShowChangesInfoValuesMapImpl = nil) then
 begin
  l3System.AddExitProc(TShowChangesInfoValuesMapImplFree);
  Il3IntegerValueMap(g_TShowChangesInfoValuesMapImpl) := inherited Make;
 end;
 Result := Il3IntegerValueMap(g_TShowChangesInfoValuesMapImpl);
end;//TShowChangesInfoValuesMapImpl.Make

class function TShowChangesInfoValuesMapImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TShowChangesInfoValuesMapImpl <> nil;
end;//TShowChangesInfoValuesMapImpl.Exists

procedure TDocumentOpenServiceImpl.OpenDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
begin
 TDocumentService.Instance.OpenDocument(aDocInfo, aContainer);
end;//TDocumentOpenServiceImpl.OpenDocument

class function TDocumentOpenServiceImpl.Instance: TDocumentOpenServiceImpl;
 {* ����� ��������� ���������� ���������� TDocumentOpenServiceImpl }
begin
 if (g_TDocumentOpenServiceImpl = nil) then
 begin
  l3System.AddExitProc(TDocumentOpenServiceImplFree);
  g_TDocumentOpenServiceImpl := Create;
 end;
 Result := g_TDocumentOpenServiceImpl;
end;//TDocumentOpenServiceImpl.Instance

class function TDocumentOpenServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TDocumentOpenServiceImpl <> nil;
end;//TDocumentOpenServiceImpl.Exists

function TDocumentSettingsServiceImpl.ShowChangesInfoSetting: Boolean;
begin
 Result := TDocumentService.Instance.ShowChangesInfoSetting;
end;//TDocumentSettingsServiceImpl.ShowChangesInfoSetting

class function TDocumentSettingsServiceImpl.Instance: TDocumentSettingsServiceImpl;
 {* ����� ��������� ���������� ���������� TDocumentSettingsServiceImpl }
begin
 if (g_TDocumentSettingsServiceImpl = nil) then
 begin
  l3System.AddExitProc(TDocumentSettingsServiceImplFree);
  g_TDocumentSettingsServiceImpl := Create;
 end;
 Result := g_TDocumentSettingsServiceImpl;
end;//TDocumentSettingsServiceImpl.Instance

class function TDocumentSettingsServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TDocumentSettingsServiceImpl <> nil;
end;//TDocumentSettingsServiceImpl.Exists

procedure TDocumentService.pm_SetAlien(const aValue: IDocumentService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TDocumentService.pm_SetAlien

class function TDocumentService.ShowChangesInfoSetting: Boolean;
 {* ����� ��� ��������� �������� ��������� "���������� ������� ��������� � ���������" }
begin
 if (afw.Settings = nil) then
  Result := dv_TDocumentService_ShowChangesInfo
 else
  Result := afw.Settings.LoadBoolean(pi_TDocumentService_ShowChangesInfo, dv_TDocumentService_ShowChangesInfo);
end;//TDocumentService.ShowChangesInfoSetting

class procedure TDocumentService.WriteShowChangesInfoSetting(aValue: Boolean);
 {* ����� ��� ������ �������� ��������� "���������� ������� ��������� � ���������" }
begin
 if (afw.Settings <> nil) then
 afw.Settings.SaveBoolean(pi_TDocumentService_ShowChangesInfo, aValue);
end;//TDocumentService.WriteShowChangesInfoSetting

function TDocumentService.OpenEntityAsDocument(const anEntity: IUnknown;
 const aContainer: IvcmContainer): IDocument;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenEntityAsDocument(anEntity, aContainer)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TDocumentService.OpenEntityAsDocument

function TDocumentService.SafeOpenDocument(const aBaseEntity: IUnknown): IDocument;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.SafeOpenDocument(aBaseEntity)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TDocumentService.SafeOpenDocument

function TDocumentService.MakeBaloonForm(aCaller: TvcmContainerForm;
 aUserType: TvcmEffectiveUserType;
 const aWarning: IdsWarning): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeBaloonForm(aCaller, aUserType, aWarning)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TDocumentService.MakeBaloonForm

function TDocumentService.OpenEditionsListModal(const anEditionsHolder: IsdsEditionsHolder;
 const anAggregate: IvcmAggregate): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenEditionsListModal(anEditionsHolder, anAggregate)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TDocumentService.OpenEditionsListModal

function TDocumentService.OpenExternalObject(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectData): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenExternalObject(aContainer, aData)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TDocumentService.OpenExternalObject

function TDocumentService.OpenPicture(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectData): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenPicture(aContainer, aData)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TDocumentService.OpenPicture

function TDocumentService.OpenPictureInfo(const aContainer: IvcmContainer;
 const aData: InsLinkedObjectDescription): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenPictureInfo(aContainer, aData)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TDocumentService.OpenPictureInfo

function TDocumentService.OpenTurnOnTimeMachine(const anIntf: InsTurnOnTimeMachine): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenTurnOnTimeMachine(anIntf)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TDocumentService.OpenTurnOnTimeMachine

procedure TDocumentService.OpenDocument(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* ��������� �������� }
begin
 if (f_Alien <> nil) then
  f_Alien.OpenDocument(aDocInfo, aContainer);
end;//TDocumentService.OpenDocument

procedure TDocumentService.OpenDocumentWithCheck(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenDocumentWithCheck(aDocInfo, aContainer);
end;//TDocumentService.OpenDocumentWithCheck

class function TDocumentService.Instance: TDocumentService;
 {* ����� ��������� ���������� ���������� TDocumentService }
begin
 if (g_TDocumentService = nil) then
 begin
  l3System.AddExitProc(TDocumentServiceFree);
  g_TDocumentService := Create;
 end;
 Result := g_TDocumentService;
end;//TDocumentService.Instance

class function TDocumentService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TDocumentService <> nil;
end;//TDocumentService.Exists

procedure TDocumentService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TDocumentService.ClearFields

procedure TMonitoringsService.pm_SetAlien(const aValue: IMonitoringsService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TMonitoringsService.pm_SetAlien

function TMonitoringsService.OpenNewsLine(aDenyNewTab: Boolean): IvcmEntityForm;
begin
 if (f_Alien <> nil) then
  Result := f_Alien.OpenNewsLine(aDenyNewTab)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TMonitoringsService.OpenNewsLine

procedure TMonitoringsService.OpenAutoreferat(const aDoc: IDocument;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenAutoreferat(aDoc, aContainer);
end;//TMonitoringsService.OpenAutoreferat

procedure TMonitoringsService.OpenAutoreferatAfterSearch(const aList: IMonitoringList;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenAutoreferatAfterSearch(aList, aContainer);
end;//TMonitoringsService.OpenAutoreferatAfterSearch

class function TMonitoringsService.Instance: TMonitoringsService;
 {* ����� ��������� ���������� ���������� TMonitoringsService }
begin
 if (g_TMonitoringsService = nil) then
 begin
  l3System.AddExitProc(TMonitoringsServiceFree);
  g_TMonitoringsService := Create;
 end;
 Result := g_TMonitoringsService;
end;//TMonitoringsService.Instance

class function TMonitoringsService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TMonitoringsService <> nil;
end;//TMonitoringsService.Exists

procedure TMonitoringsService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TMonitoringsService.ClearFields

procedure TEditionsService.pm_SetAlien(const aValue: IEditionsService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TEditionsService.pm_SetAlien

procedure TEditionsService.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aParaForPositionning: IeeLeafPara;
 const aDocumentForReturn: IDocument;
 const aParaForReturn: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
begin
 if (f_Alien <> nil) then
  f_Alien.MakeCompareEditions(aLeft, aRight, aParaForPositionning, aDocumentForReturn, aParaForReturn, aContainer);
end;//TEditionsService.MakeCompareEditions

procedure TEditionsService.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
begin
 if (f_Alien <> nil) then
  f_Alien.MakeCompareEditions(aDoc, aPara, aContainer);
end;//TEditionsService.MakeCompareEditions

procedure TEditionsService.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aPara: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
begin
 if (f_Alien <> nil) then
  f_Alien.MakeCompareEditions(aLeft, aRight, aPara, aContainer);
end;//TEditionsService.MakeCompareEditions

procedure TEditionsService.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 aEditionForCompare: Integer;
 const aContainer: IvcmContainer = nil);
begin
 if (f_Alien <> nil) then
  f_Alien.MakeCompareEditions(aDoc, aPara, aEditionForCompare, aContainer);
end;//TEditionsService.MakeCompareEditions

procedure TEditionsService.MakeCompareEditions(const aLeft: IDocument;
 const aRight: IDocument;
 const aPosition: TbsDocPos;
 const aDocumentForReturn: IDocument;
 const aParaForReturn: IeeLeafPara;
 const aContainer: IvcmContainer = nil);
begin
 if (f_Alien <> nil) then
  f_Alien.MakeCompareEditions(aLeft, aRight, aPosition, aDocumentForReturn, aParaForReturn, aContainer);
end;//TEditionsService.MakeCompareEditions

procedure TEditionsService.MakeCompareEditions(const aDoc: IDocument;
 const aPara: IeeLeafPara;
 aEditionForCompare: Integer;
 const aDocumentForReturn: TnsDocumentForReturnInfo;
 const aContainer: IvcmContainer = nil);
 {* ������ ������������� ���������� "��������� ��������" }
begin
 if (f_Alien <> nil) then
  f_Alien.MakeCompareEditions(aDoc, aPara, aEditionForCompare, aDocumentForReturn, aContainer);
end;//TEditionsService.MakeCompareEditions

class function TEditionsService.Instance: TEditionsService;
 {* ����� ��������� ���������� ���������� TEditionsService }
begin
 if (g_TEditionsService = nil) then
 begin
  l3System.AddExitProc(TEditionsServiceFree);
  g_TEditionsService := Create;
 end;
 Result := g_TEditionsService;
end;//TEditionsService.Instance

class function TEditionsService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TEditionsService <> nil;
end;//TEditionsService.Exists

procedure TEditionsService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TEditionsService.ClearFields

procedure TListOpenServiceImpl.OpenList(const aList: IdeList;
 const aContainer: IvcmContainer);
begin
 TListService.Instance.OpenList(aList, aContainer);
end;//TListOpenServiceImpl.OpenList

class function TListOpenServiceImpl.Instance: TListOpenServiceImpl;
 {* ����� ��������� ���������� ���������� TListOpenServiceImpl }
begin
 if (g_TListOpenServiceImpl = nil) then
 begin
  l3System.AddExitProc(TListOpenServiceImplFree);
  g_TListOpenServiceImpl := Create;
 end;
 Result := g_TListOpenServiceImpl;
end;//TListOpenServiceImpl.Instance

class function TListOpenServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TListOpenServiceImpl <> nil;
end;//TListOpenServiceImpl.Exists

procedure TListService.pm_SetAlien(const aValue: IListService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TListService.pm_SetAlien

procedure TListService.OpenList(const aList: IdeList;
 const aContainer: IvcmContainer);
 {* ��������� ������ � ��������� ���������� }
begin
 if (f_Alien <> nil) then
  f_Alien.OpenList(aList, aContainer);
end;//TListService.OpenList

procedure TListService.MakeListAnalizer(const aTree: Il3SimpleTree);
begin
 if (f_Alien <> nil) then
  f_Alien.MakeListAnalizer(aTree);
end;//TListService.MakeListAnalizer

class function TListService.Instance: TListService;
 {* ����� ��������� ���������� ���������� TListService }
begin
 if (g_TListService = nil) then
 begin
  l3System.AddExitProc(TListServiceFree);
  g_TListService := Create;
 end;
 Result := g_TListService;
end;//TListService.Instance

class function TListService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TListService <> nil;
end;//TListService.Exists

procedure TListService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TListService.ClearFields

procedure TConsultationService.pm_SetAlien(const aValue: IConsultationService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TConsultationService.pm_SetAlien

procedure TConsultationService.OpenSendConsultation(const aQuery: IQuery);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenSendConsultation(aQuery);
end;//TConsultationService.OpenSendConsultation

procedure TConsultationService.OpenEntityAsConsultation(const aCons: IUnknown;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenEntityAsConsultation(aCons, aContainer);
end;//TConsultationService.OpenEntityAsConsultation

procedure TConsultationService.OpenConsultation(const aCons: IbsConsultation;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenConsultation(aCons, aContainer);
end;//TConsultationService.OpenConsultation

procedure TConsultationService.GiveMarkOnConsultation(const aNode: Il3SimpleNode);
begin
 if (f_Alien <> nil) then
  f_Alien.GiveMarkOnConsultation(aNode);
end;//TConsultationService.GiveMarkOnConsultation

class function TConsultationService.Instance: TConsultationService;
 {* ����� ��������� ���������� ���������� TConsultationService }
begin
 if (g_TConsultationService = nil) then
 begin
  l3System.AddExitProc(TConsultationServiceFree);
  g_TConsultationService := Create;
 end;
 Result := g_TConsultationService;
end;//TConsultationService.Instance

class function TConsultationService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TConsultationService <> nil;
end;//TConsultationService.Exists

procedure TConsultationService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TConsultationService.ClearFields

procedure TControlledObjectServiceImpl.AddControlledObject(const aData: IControllable);
begin
 TUnderControlService.Instance.AddControlledObject(aData);
end;//TControlledObjectServiceImpl.AddControlledObject

procedure TControlledObjectServiceImpl.DeleteControlledObject(const aData: IControllable);
begin
 TUnderControlService.Instance.DeleteControlledObject(aData);
end;//TControlledObjectServiceImpl.DeleteControlledObject

class function TControlledObjectServiceImpl.Instance: TControlledObjectServiceImpl;
 {* ����� ��������� ���������� ���������� TControlledObjectServiceImpl }
begin
 if (g_TControlledObjectServiceImpl = nil) then
 begin
  l3System.AddExitProc(TControlledObjectServiceImplFree);
  g_TControlledObjectServiceImpl := Create;
 end;
 Result := g_TControlledObjectServiceImpl;
end;//TControlledObjectServiceImpl.Instance

class function TControlledObjectServiceImpl.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TControlledObjectServiceImpl <> nil;
end;//TControlledObjectServiceImpl.Exists

procedure TUnderControlService.pm_SetAlien(const aValue: IUnderControlService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TUnderControlService.pm_SetAlien

procedure TUnderControlService.AddControlledObject(const aData: IControllable);
begin
 if (f_Alien <> nil) then
  f_Alien.AddControlledObject(aData);
end;//TUnderControlService.AddControlledObject

procedure TUnderControlService.BuildUnderControlList(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.BuildUnderControlList(aContainer);
end;//TUnderControlService.BuildUnderControlList

procedure TUnderControlService.CloseUnderControl(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.CloseUnderControl(aContainer);
end;//TUnderControlService.CloseUnderControl

procedure TUnderControlService.DeleteControlledObject(const aData: IControllable);
begin
 if (f_Alien <> nil) then
  f_Alien.DeleteControlledObject(aData);
end;//TUnderControlService.DeleteControlledObject

procedure TUnderControlService.DropChangeStatusToOpened(const aForm: IvcmEntityForm);
begin
 if (f_Alien <> nil) then
  f_Alien.DropChangeStatusToOpened(aForm);
end;//TUnderControlService.DropChangeStatusToOpened

procedure TUnderControlService.MarkControlledAsOpen(const aData: IControllable);
begin
 if (f_Alien <> nil) then
  f_Alien.MarkControlledAsOpen(aData);
end;//TUnderControlService.MarkControlledAsOpen

procedure TUnderControlService.OpenUnderControl(const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenUnderControl(aContainer);
end;//TUnderControlService.OpenUnderControl

class function TUnderControlService.Instance: TUnderControlService;
 {* ����� ��������� ���������� ���������� TUnderControlService }
begin
 if (g_TUnderControlService = nil) then
 begin
  l3System.AddExitProc(TUnderControlServiceFree);
  g_TUnderControlService := Create;
 end;
 Result := g_TUnderControlService;
end;//TUnderControlService.Instance

class function TUnderControlService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TUnderControlService <> nil;
end;//TUnderControlService.Exists

procedure TUnderControlService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TUnderControlService.ClearFields

procedure TChangesBetweenEditionsService.pm_SetAlien(const aValue: IChangesBetweenEditionsService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TChangesBetweenEditionsService.pm_SetAlien

procedure TChangesBetweenEditionsService.ViewChangedFragmentsForPrevEdition(const aDocument: IDocument);
 {* �������� �������� ���������� � ��������� � ���������� ��������� }
begin
 if (f_Alien <> nil) then
  f_Alien.ViewChangedFragmentsForPrevEdition(aDocument);
end;//TChangesBetweenEditionsService.ViewChangedFragmentsForPrevEdition

procedure TChangesBetweenEditionsService.ViewChangedFragments(const aLeft: IDocument;
 const aRight: IDocument);
begin
 if (f_Alien <> nil) then
  f_Alien.ViewChangedFragments(aLeft, aRight);
end;//TChangesBetweenEditionsService.ViewChangedFragments

class function TChangesBetweenEditionsService.Instance: TChangesBetweenEditionsService;
 {* ����� ��������� ���������� ���������� TChangesBetweenEditionsService }
begin
 if (g_TChangesBetweenEditionsService = nil) then
 begin
  l3System.AddExitProc(TChangesBetweenEditionsServiceFree);
  g_TChangesBetweenEditionsService := Create;
 end;
 Result := g_TChangesBetweenEditionsService;
end;//TChangesBetweenEditionsService.Instance

class function TChangesBetweenEditionsService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TChangesBetweenEditionsService <> nil;
end;//TChangesBetweenEditionsService.Exists

procedure TChangesBetweenEditionsService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TChangesBetweenEditionsService.ClearFields

procedure TAACService.pm_SetAlien(const aValue: IAACService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TAACService.pm_SetAlien

procedure TAACService.MakeAAC(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* ������ ������ ��� ��������� ��� }
begin
 if (f_Alien <> nil) then
  f_Alien.MakeAAC(aDocInfo, aContainer);
end;//TAACService.MakeAAC

procedure TAACService.MakeAACContents(const aDocInfo: IdeDocInfo;
 const aContainer: IvcmContainer);
 {* ������ ������ ��� ��������� ���������� ��� }
begin
 if (f_Alien <> nil) then
  f_Alien.MakeAACContents(aDocInfo, aContainer);
end;//TAACService.MakeAACContents

class function TAACService.Instance: TAACService;
 {* ����� ��������� ���������� ���������� TAACService }
begin
 if (g_TAACService = nil) then
 begin
  l3System.AddExitProc(TAACServiceFree);
  g_TAACService := Create;
 end;
 Result := g_TAACService;
end;//TAACService.Instance

class function TAACService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TAACService <> nil;
end;//TAACService.Exists

procedure TAACService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TAACService.ClearFields

constructor TstTMainMenuServiceChangeableMainMenuTypeItem.Create(aMasterItem: TddBaseConfigItem = nil);
var
 l_Value : TddConfigValue;
begin
 l3FillChar(l_Value, SizeOf(l_Value));
 l_Value.Kind := dd_vkInteger;
 l_Value.AsInteger := dv_TMainMenuService_ChangeableMainMenuType;
 inherited Create(pi_TMainMenuService_ChangeableMainMenuType,
  str_ChangeableMainMenuType.AsStr,
  l_Value, TChangeableMainMenuTypeValuesMapImpl.Make, aMasterItem);
end;//TstTMainMenuServiceChangeableMainMenuTypeItem.Create

constructor TstTDocumentServiceShowChangesInfoItem.Create(aMasterItem: TddBaseConfigItem = nil);
var
 l_Value : TddConfigValue;
begin
 l3FillChar(l_Value, SizeOf(l_Value));
 l_Value.Kind := dd_vkBoolean;
 l_Value.AsBoolean := dv_TDocumentService_ShowChangesInfo;
 inherited Create(pi_TDocumentService_ShowChangesInfo,
  str_ShowChangesInfo.AsStr,
  l_Value, TShowChangesInfoValuesMapImpl.Make, aMasterItem);
end;//TstTDocumentServiceShowChangesInfoItem.Create

initialization
 str_ChangeableMainMenuType.Init;
 {* ������������� str_ChangeableMainMenuType }
 str_ChangeableMainMenuType_ST_FINANCE.Init;
 {* ������������� str_ChangeableMainMenuType_ST_FINANCE }
 str_ChangeableMainMenuType_ST_HR.Init;
 {* ������������� str_ChangeableMainMenuType_ST_HR }
 str_ChangeableMainMenuType_ST_LEGAL.Init;
 {* ������������� str_ChangeableMainMenuType_ST_LEGAL }
 str_ChangeableMainMenuType_ST_BUDGET_ORGS.Init;
 {* ������������� str_ChangeableMainMenuType_ST_BUDGET_ORGS }
 TMainMenuOpenService.Instance.Alien := TMainMenuOpenServiceImpl.Instance;
 {* ����������� TMainMenuOpenServiceImpl }
 TRubricatorOpenService.Instance.Alien := TRubricatorOpenServiceImpl.Instance;
 {* ����������� TRubricatorOpenServiceImpl }
 TQueryOpenService.Instance.Alien := TQueryOpenServiceImpl.Instance;
 {* ����������� TQueryOpenServiceImpl }
 str_ShowChangesInfo.Init;
 {* ������������� str_ShowChangesInfo }
 str_ShowChangesInfo_Collapsed.Init;
 {* ������������� str_ShowChangesInfo_Collapsed }
 str_ShowChangesInfo_Expanded.Init;
 {* ������������� str_ShowChangesInfo_Expanded }
 TDocumentOpenService.Instance.Alien := TDocumentOpenServiceImpl.Instance;
 {* ����������� TDocumentOpenServiceImpl }
 TDocumentSettingsService.Instance.Alien := TDocumentSettingsServiceImpl.Instance;
 {* ����������� TDocumentSettingsServiceImpl }
 TListOpenService.Instance.Alien := TListOpenServiceImpl.Instance;
 {* ����������� TListOpenServiceImpl }
 TControlledObjectService.Instance.Alien := TControlledObjectServiceImpl.Instance;
 {* ����������� TControlledObjectServiceImpl }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
