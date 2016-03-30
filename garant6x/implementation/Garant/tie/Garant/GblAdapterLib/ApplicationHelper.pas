unit ApplicationHelper;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ApplicationHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ApplicationHelper" MUID: (460A6EF8024B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , ServerFacade
 //#UC START# *460A6EF8024Bintf_uses*
 //#UC END# *460A6EF8024Bintf_uses*
;

type
 BaseId = record
  stamp: Cardinal;
 //#UC START# *460A80090380publ*
 //#UC END# *460A80090380publ*
 end;//BaseId

 //#UC START# *460A6EF8024Bci*
 //#UC END# *460A6EF8024Bci*
 //#UC START# *460A6EF8024Bcit*
 //#UC END# *460A6EF8024Bcit*
 ApplicationHelper = class
  private
   base_id: BaseId;
   function_manager: ;
   contract_form: ;
   search_manager: ;
   user_manager: ;
   folders: ;
   under_control_manager: ;
   settings: ;
   settings_manager: ;
   life_cycle_manager: ;
   consultation_manager: ;
   logging_manager: ;
   integration: ;
   xml_save: ;
   prime: ;
   prime_xml_save: ;
   server_facade: ServerFacade;
   user_journal: ;
    {* Журнал работы }
   tree_factory: ;
   property_manager: ;
   banner_manager: ;
   group_manager: ;
   remote_support: ;
   filters_manager: ;
   context_filter: ;
   main_menu: ;
   decisions_archive_support: ;
   document_type_resolver: ;
   link_manager: ;
   f_uid: ;
    {* Поле для свойства uid }
  private
   function ServerFacade: ServerFacade; virtual; stdcall;
  protected
   procedure GetUid; stdcall;
   procedure ThrMgr; virtual; stdcall;
  public
   procedure ClearCacheAndRegenerateBaseId; virtual; stdcall;
   function CompareAndUpdateBaseId(var base_id: BaseId): ByteBool; virtual; stdcall;
   procedure GetCachedFunctionManager; virtual; stdcall;
   procedure GetCachedContextFilter; virtual; stdcall;
   procedure GetCachedContractForm; virtual; stdcall;
   procedure GetCachedUserManager; virtual; stdcall;
   procedure GetCachedFolders; virtual; stdcall;
   procedure GetCachedUnderControlManager; virtual; stdcall;
   procedure GetCachedSettings; virtual; stdcall;
   procedure GetCachedSettingsManager; virtual; stdcall;
   procedure GetCachedLifeCycleManager; virtual; stdcall;
   procedure GetCachedXmlSave; virtual; stdcall;
   function IsConfigurationsExist: ByteBool; virtual; stdcall;
   procedure GetCachedSearchManager; virtual; stdcall;
   procedure GetCachedConsultationManager; virtual; stdcall;
   procedure GetCachedLoggingManager; virtual; stdcall;
   procedure GetCachedIntegration; virtual; stdcall;
   procedure GetCachedPrime; virtual; stdcall;
   procedure GetCachedPrimeXmlSave; virtual; stdcall;
   procedure StartListenForMe; virtual; stdcall;
    {* Заставляем NotifyManager слушать нотификации только для меня }
   procedure StopListenForMe; virtual; stdcall;
    {* Прекратить слушать нотификации для меня }
   procedure ClearCache; virtual; stdcall;
    {* Очистка кешированных серверных объектов }
   procedure Init(server_facade: ServerFacade); virtual; stdcall;
   constructor Make; reintroduce; virtual; stdcall;
   procedure GetCachedUserJournal; virtual; stdcall;
   procedure GetCachedTreeFactory; virtual; stdcall;
   procedure GetCachedPropertyManager; virtual; stdcall;
   procedure GetCachedBannerManager; virtual; stdcall;
    {* Получить баннер с сервера }
   procedure GetCachedCurrentUserId; virtual; stdcall;
    {* возвращает идентификатор текущего пользователя }
   procedure GetCachedGroupManager; virtual; stdcall;
   procedure GetCachedRemoteDocumentSupport; virtual; stdcall;
   procedure GetCachedFiltersManager; virtual; stdcall;
   procedure GetCachedMainMenu; virtual; stdcall;
   procedure GetCachedDecisionsArchiveSupport; virtual; stdcall;
   procedure GetCachedDocumentTypeResolver; virtual; stdcall;
   procedure GetCachedLinkManager; virtual; stdcall;
   class function Exists: ByteBool; stdcall;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: ApplicationHelper;
    {* Метод получения экземпляра синглетона ApplicationHelper }
  private
   property Uid: 
    read GetUid;
    {* uid текущего пользователя }
 //#UC START# *460A6EF8024Bpubl*
 //#UC END# *460A6EF8024Bpubl*
 end;//ApplicationHelper

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *460A6EF8024Bimpl_uses*
 //#UC END# *460A6EF8024Bimpl_uses*
;

var g_ApplicationHelper: ApplicationHelper = nil;
 {* Экземпляр синглетона ApplicationHelper }

procedure ApplicationHelperFree;
 {* Метод освобождения экземпляра синглетона ApplicationHelper }
begin
 l3Free(g_ApplicationHelper);
end;//ApplicationHelperFree

procedure ApplicationHelper.GetUid;
//#UC START# *4AEE9F4A02BF_460A6EF8024Bget_var*
//#UC END# *4AEE9F4A02BF_460A6EF8024Bget_var*
begin
//#UC START# *4AEE9F4A02BF_460A6EF8024Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEE9F4A02BF_460A6EF8024Bget_impl*
end;//ApplicationHelper.GetUid

procedure ApplicationHelper.ClearCacheAndRegenerateBaseId;
//#UC START# *460A806C0214_460A6EF8024B_var*
//#UC END# *460A806C0214_460A6EF8024B_var*
begin
//#UC START# *460A806C0214_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460A806C0214_460A6EF8024B_impl*
end;//ApplicationHelper.ClearCacheAndRegenerateBaseId

function ApplicationHelper.CompareAndUpdateBaseId(var base_id: BaseId): ByteBool;
//#UC START# *460A80AB0254_460A6EF8024B_var*
//#UC END# *460A80AB0254_460A6EF8024B_var*
begin
//#UC START# *460A80AB0254_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460A80AB0254_460A6EF8024B_impl*
end;//ApplicationHelper.CompareAndUpdateBaseId

procedure ApplicationHelper.GetCachedFunctionManager;
//#UC START# *460A80C603C1_460A6EF8024B_var*
//#UC END# *460A80C603C1_460A6EF8024B_var*
begin
//#UC START# *460A80C603C1_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460A80C603C1_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedFunctionManager

procedure ApplicationHelper.GetCachedContextFilter;
//#UC START# *4D3EE8C701C0_460A6EF8024B_var*
//#UC END# *4D3EE8C701C0_460A6EF8024B_var*
begin
//#UC START# *4D3EE8C701C0_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D3EE8C701C0_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedContextFilter

procedure ApplicationHelper.GetCachedContractForm;
//#UC START# *460A819B01DA_460A6EF8024B_var*
//#UC END# *460A819B01DA_460A6EF8024B_var*
begin
//#UC START# *460A819B01DA_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460A819B01DA_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedContractForm

procedure ApplicationHelper.GetCachedUserManager;
//#UC START# *460B91AE00DA_460A6EF8024B_var*
//#UC END# *460B91AE00DA_460A6EF8024B_var*
begin
//#UC START# *460B91AE00DA_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B91AE00DA_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedUserManager

procedure ApplicationHelper.GetCachedFolders;
//#UC START# *460B91FC0157_460A6EF8024B_var*
//#UC END# *460B91FC0157_460A6EF8024B_var*
begin
//#UC START# *460B91FC0157_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B91FC0157_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedFolders

procedure ApplicationHelper.GetCachedUnderControlManager;
//#UC START# *460B92A701F4_460A6EF8024B_var*
//#UC END# *460B92A701F4_460A6EF8024B_var*
begin
//#UC START# *460B92A701F4_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B92A701F4_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedUnderControlManager

procedure ApplicationHelper.GetCachedSettings;
//#UC START# *460B94F80232_460A6EF8024B_var*
//#UC END# *460B94F80232_460A6EF8024B_var*
begin
//#UC START# *460B94F80232_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B94F80232_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedSettings

procedure ApplicationHelper.GetCachedSettingsManager;
//#UC START# *460B95AC03D8_460A6EF8024B_var*
//#UC END# *460B95AC03D8_460A6EF8024B_var*
begin
//#UC START# *460B95AC03D8_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B95AC03D8_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedSettingsManager

procedure ApplicationHelper.GetCachedLifeCycleManager;
//#UC START# *460B95D9004E_460A6EF8024B_var*
//#UC END# *460B95D9004E_460A6EF8024B_var*
begin
//#UC START# *460B95D9004E_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B95D9004E_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedLifeCycleManager

procedure ApplicationHelper.GetCachedXmlSave;
//#UC START# *4682713102DE_460A6EF8024B_var*
//#UC END# *4682713102DE_460A6EF8024B_var*
begin
//#UC START# *4682713102DE_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4682713102DE_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedXmlSave

procedure ApplicationHelper.ThrMgr;
//#UC START# *460BA6F801D4_460A6EF8024B_var*
//#UC END# *460BA6F801D4_460A6EF8024B_var*
begin
//#UC START# *460BA6F801D4_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BA6F801D4_460A6EF8024B_impl*
end;//ApplicationHelper.ThrMgr

function ApplicationHelper.IsConfigurationsExist: ByteBool;
//#UC START# *460BA70A0157_460A6EF8024B_var*
//#UC END# *460BA70A0157_460A6EF8024B_var*
begin
//#UC START# *460BA70A0157_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BA70A0157_460A6EF8024B_impl*
end;//ApplicationHelper.IsConfigurationsExist

procedure ApplicationHelper.GetCachedSearchManager;
//#UC START# *460BA7220280_460A6EF8024B_var*
//#UC END# *460BA7220280_460A6EF8024B_var*
begin
//#UC START# *460BA7220280_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BA7220280_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedSearchManager

procedure ApplicationHelper.GetCachedConsultationManager;
//#UC START# *460BA73401D4_460A6EF8024B_var*
//#UC END# *460BA73401D4_460A6EF8024B_var*
begin
//#UC START# *460BA73401D4_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BA73401D4_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedConsultationManager

procedure ApplicationHelper.GetCachedLoggingManager;
//#UC START# *460BA77D007D_460A6EF8024B_var*
//#UC END# *460BA77D007D_460A6EF8024B_var*
begin
//#UC START# *460BA77D007D_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BA77D007D_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedLoggingManager

procedure ApplicationHelper.GetCachedIntegration;
//#UC START# *463F5B37009C_460A6EF8024B_var*
//#UC END# *463F5B37009C_460A6EF8024B_var*
begin
//#UC START# *463F5B37009C_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *463F5B37009C_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedIntegration

procedure ApplicationHelper.GetCachedPrime;
//#UC START# *47C2A4670007_460A6EF8024B_var*
//#UC END# *47C2A4670007_460A6EF8024B_var*
begin
//#UC START# *47C2A4670007_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C2A4670007_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedPrime

procedure ApplicationHelper.GetCachedPrimeXmlSave;
//#UC START# *47C695540167_460A6EF8024B_var*
//#UC END# *47C695540167_460A6EF8024B_var*
begin
//#UC START# *47C695540167_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C695540167_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedPrimeXmlSave

procedure ApplicationHelper.StartListenForMe;
 {* Заставляем NotifyManager слушать нотификации только для меня }
//#UC START# *460CD7A6038A_460A6EF8024B_var*
//#UC END# *460CD7A6038A_460A6EF8024B_var*
begin
//#UC START# *460CD7A6038A_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CD7A6038A_460A6EF8024B_impl*
end;//ApplicationHelper.StartListenForMe

procedure ApplicationHelper.StopListenForMe;
 {* Прекратить слушать нотификации для меня }
//#UC START# *460CD7D402FD_460A6EF8024B_var*
//#UC END# *460CD7D402FD_460A6EF8024B_var*
begin
//#UC START# *460CD7D402FD_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CD7D402FD_460A6EF8024B_impl*
end;//ApplicationHelper.StopListenForMe

procedure ApplicationHelper.ClearCache;
 {* Очистка кешированных серверных объектов }
//#UC START# *460CDD6C0399_460A6EF8024B_var*
//#UC END# *460CDD6C0399_460A6EF8024B_var*
begin
//#UC START# *460CDD6C0399_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CDD6C0399_460A6EF8024B_impl*
end;//ApplicationHelper.ClearCache

procedure ApplicationHelper.Init(server_facade: ServerFacade);
//#UC START# *4746FE3B0046_460A6EF8024B_var*
//#UC END# *4746FE3B0046_460A6EF8024B_var*
begin
//#UC START# *4746FE3B0046_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4746FE3B0046_460A6EF8024B_impl*
end;//ApplicationHelper.Init

constructor ApplicationHelper.Make;
//#UC START# *474704110312_460A6EF8024B_var*
//#UC END# *474704110312_460A6EF8024B_var*
begin
//#UC START# *474704110312_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *474704110312_460A6EF8024B_impl*
end;//ApplicationHelper.Make

function ApplicationHelper.ServerFacade: ServerFacade;
//#UC START# *474705300058_460A6EF8024B_var*
//#UC END# *474705300058_460A6EF8024B_var*
begin
//#UC START# *474705300058_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *474705300058_460A6EF8024B_impl*
end;//ApplicationHelper.ServerFacade

procedure ApplicationHelper.GetCachedUserJournal;
//#UC START# *4A80371200CE_460A6EF8024B_var*
//#UC END# *4A80371200CE_460A6EF8024B_var*
begin
//#UC START# *4A80371200CE_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A80371200CE_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedUserJournal

procedure ApplicationHelper.GetCachedTreeFactory;
//#UC START# *4ABB429C0210_460A6EF8024B_var*
//#UC END# *4ABB429C0210_460A6EF8024B_var*
begin
//#UC START# *4ABB429C0210_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB429C0210_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedTreeFactory

procedure ApplicationHelper.GetCachedPropertyManager;
//#UC START# *4AC4AB0C01BC_460A6EF8024B_var*
//#UC END# *4AC4AB0C01BC_460A6EF8024B_var*
begin
//#UC START# *4AC4AB0C01BC_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC4AB0C01BC_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedPropertyManager

procedure ApplicationHelper.GetCachedBannerManager;
 {* Получить баннер с сервера }
//#UC START# *4ACF446803B9_460A6EF8024B_var*
//#UC END# *4ACF446803B9_460A6EF8024B_var*
begin
//#UC START# *4ACF446803B9_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ACF446803B9_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedBannerManager

procedure ApplicationHelper.GetCachedCurrentUserId;
 {* возвращает идентификатор текущего пользователя }
//#UC START# *4AEE9E0E01D3_460A6EF8024B_var*
//#UC END# *4AEE9E0E01D3_460A6EF8024B_var*
begin
//#UC START# *4AEE9E0E01D3_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEE9E0E01D3_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedCurrentUserId

procedure ApplicationHelper.GetCachedGroupManager;
//#UC START# *4AF00C4B02A1_460A6EF8024B_var*
//#UC END# *4AF00C4B02A1_460A6EF8024B_var*
begin
//#UC START# *4AF00C4B02A1_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF00C4B02A1_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedGroupManager

procedure ApplicationHelper.GetCachedRemoteDocumentSupport;
//#UC START# *4BD5566102F9_460A6EF8024B_var*
//#UC END# *4BD5566102F9_460A6EF8024B_var*
begin
//#UC START# *4BD5566102F9_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BD5566102F9_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedRemoteDocumentSupport

procedure ApplicationHelper.GetCachedFiltersManager;
//#UC START# *4CA5C3E1000C_460A6EF8024B_var*
//#UC END# *4CA5C3E1000C_460A6EF8024B_var*
begin
//#UC START# *4CA5C3E1000C_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CA5C3E1000C_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedFiltersManager

procedure ApplicationHelper.GetCachedMainMenu;
//#UC START# *4DD4FCEF01B0_460A6EF8024B_var*
//#UC END# *4DD4FCEF01B0_460A6EF8024B_var*
begin
//#UC START# *4DD4FCEF01B0_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DD4FCEF01B0_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedMainMenu

procedure ApplicationHelper.GetCachedDecisionsArchiveSupport;
//#UC START# *4F71D2D20136_460A6EF8024B_var*
//#UC END# *4F71D2D20136_460A6EF8024B_var*
begin
//#UC START# *4F71D2D20136_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F71D2D20136_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedDecisionsArchiveSupport

procedure ApplicationHelper.GetCachedDocumentTypeResolver;
//#UC START# *4FE86FAD00A3_460A6EF8024B_var*
//#UC END# *4FE86FAD00A3_460A6EF8024B_var*
begin
//#UC START# *4FE86FAD00A3_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE86FAD00A3_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedDocumentTypeResolver

procedure ApplicationHelper.GetCachedLinkManager;
//#UC START# *55952CE501E5_460A6EF8024B_var*
//#UC END# *55952CE501E5_460A6EF8024B_var*
begin
//#UC START# *55952CE501E5_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *55952CE501E5_460A6EF8024B_impl*
end;//ApplicationHelper.GetCachedLinkManager

class function ApplicationHelper.Exists: ByteBool;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_ApplicationHelper <> nil;
end;//ApplicationHelper.Exists

class function ApplicationHelper.Instance: ApplicationHelper;
 {* Метод получения экземпляра синглетона ApplicationHelper }
begin
 if (g_ApplicationHelper = nil) then
 begin
  l3System.AddExitProc(ApplicationHelperFree);
  g_ApplicationHelper := Create;
 end;
 Result := g_ApplicationHelper;
end;//ApplicationHelper.Instance

//#UC START# *460A6EF8024Bimpl*
//#UC END# *460A6EF8024Bimpl*

end.
