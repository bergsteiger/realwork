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
 , SearchUnit
 , l3Interfaces
 , l3TreeInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , Types
 , l3Chars
 , bsTypes
 , eeInterfaces
 , SimpleListInterfaces
 , FoldersDomainInterfaces
 , ChatTypes
 , ChatInterfaces
 , BaseSearchInterfaces
 , PrimPrimListInterfaces
 , DocumentInterfaces
 , PrimBaseSearchInterfaces
 , l3ProtoObject
 , Classes
 , nsTypes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

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

var mod_opcode_ChatService_OpenContactList: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_DictionService_OpenDict: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_InpharmService_DrugList: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_InpharmService_MedicDiction: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_InpharmService_MedicFirms: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_InpharmService_MedicMainMenu: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_InternetAgentService_InternetAgent: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_DayTipsService_ShowDayTips: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_DocumentListFromFileService_OpenDocumentListFromFile: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_FoldersService_MyConsultations: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_FoldersService_MyInformation: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_FoldersService_OpenFrmAct: TvcmMOPID = (rMoID : -1; rOpID : -1);
var mod_opcode_FoldersService_UnderControlOpenFrmAct: TvcmMOPID = (rMoID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
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
;

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
var g_TMainMenuService: TMainMenuService = nil;
 {* ��������� ���������� TMainMenuService }
var g_TBaseSearchService: TBaseSearchService = nil;
 {* ��������� ���������� TBaseSearchService }
var g_TFiltersService: TFiltersService = nil;
 {* ��������� ���������� TFiltersService }
var g_TFoldersService: TFoldersService = nil;
 {* ��������� ���������� TFoldersService }

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

procedure TMainMenuService.pm_SetAlien(const aValue: IMainMenuService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TMainMenuService.pm_SetAlien

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

initialization
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
