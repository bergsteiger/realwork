unit ApplicationHelper;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ApplicationHelper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "ApplicationHelper" MUID: (460A6EF8024B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , ServerFacade
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
   function server_facade: ServerFacade; virtual;
  protected
   procedure pm_Getuid;
   procedure thr_mgr; virtual;
  public
   procedure clear_cache_and_regenerate_base_id; virtual;
   function compare_and_update_base_id(var base_id: BaseId): Boolean; virtual;
   procedure get_cached_function_manager; virtual;
   procedure get_cached_context_filter; virtual;
   procedure get_cached_contract_form; virtual;
   procedure get_cached_user_manager; virtual;
   procedure get_cached_folders; virtual;
   procedure get_cached_under_control_manager; virtual;
   procedure get_cached_settings; virtual;
   procedure get_cached_settings_manager; virtual;
   procedure get_cached_life_cycle_manager; virtual;
   procedure get_cached_xml_save; virtual;
   function is_configurations_exist: Boolean; virtual;
   procedure get_cached_search_manager; virtual;
   procedure get_cached_consultation_manager; virtual;
   procedure get_cached_logging_manager; virtual;
   procedure get_cached_integration; virtual;
   procedure get_cached_prime; virtual;
   procedure get_cached_prime_xml_save; virtual;
   procedure start_listen_for_me; virtual;
    {* Заставляем NotifyManager слушать нотификации только для меня }
   procedure stop_listen_for_me; virtual;
    {* Прекратить слушать нотификации для меня }
   procedure clear_cache; virtual;
    {* Очистка кешированных серверных объектов }
   procedure init(server_facade: ServerFacade); virtual;
   constructor make; reintroduce; virtual;
   procedure get_cached_user_journal; virtual;
   procedure get_cached_tree_factory; virtual;
   procedure get_cached_property_manager; virtual;
   procedure get_cached_banner_manager; virtual;
    {* Получить баннер с сервера }
   procedure get_cached_current_user_id; virtual;
    {* возвращает идентификатор текущего пользователя }
   procedure get_cached_group_manager; virtual;
   procedure get_cached_remote_document_support; virtual;
   procedure get_cached_filters_manager; virtual;
   procedure get_cached_main_menu; virtual;
   procedure get_cached_decisions_archive_support; virtual;
   procedure get_cached_document_type_resolver; virtual;
   procedure get_cached_link_manager; virtual;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: ApplicationHelper;
    {* Метод получения экземпляра синглетона ApplicationHelper }
  private
   property uid: 
    read pm_Getuid;
    {* uid текущего пользователя }
 //#UC START# *460A6EF8024Bpubl*
 //#UC END# *460A6EF8024Bpubl*
 end;//ApplicationHelper

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_ApplicationHelper: ApplicationHelper = nil;
 {* Экземпляр синглетона ApplicationHelper }

procedure ApplicationHelperFree;
 {* Метод освобождения экземпляра синглетона ApplicationHelper }
begin
 l3Free(g_ApplicationHelper);
end;//ApplicationHelperFree

procedure ApplicationHelper.pm_Getuid;
//#UC START# *4AEE9F4A02BF_460A6EF8024Bget_var*
//#UC END# *4AEE9F4A02BF_460A6EF8024Bget_var*
begin
//#UC START# *4AEE9F4A02BF_460A6EF8024Bget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEE9F4A02BF_460A6EF8024Bget_impl*
end;//ApplicationHelper.pm_Getuid

procedure ApplicationHelper.clear_cache_and_regenerate_base_id;
//#UC START# *460A806C0214_460A6EF8024B_var*
//#UC END# *460A806C0214_460A6EF8024B_var*
begin
//#UC START# *460A806C0214_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460A806C0214_460A6EF8024B_impl*
end;//ApplicationHelper.clear_cache_and_regenerate_base_id

function ApplicationHelper.compare_and_update_base_id(var base_id: BaseId): Boolean;
//#UC START# *460A80AB0254_460A6EF8024B_var*
//#UC END# *460A80AB0254_460A6EF8024B_var*
begin
//#UC START# *460A80AB0254_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460A80AB0254_460A6EF8024B_impl*
end;//ApplicationHelper.compare_and_update_base_id

procedure ApplicationHelper.get_cached_function_manager;
//#UC START# *460A80C603C1_460A6EF8024B_var*
//#UC END# *460A80C603C1_460A6EF8024B_var*
begin
//#UC START# *460A80C603C1_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460A80C603C1_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_function_manager

procedure ApplicationHelper.get_cached_context_filter;
//#UC START# *4D3EE8C701C0_460A6EF8024B_var*
//#UC END# *4D3EE8C701C0_460A6EF8024B_var*
begin
//#UC START# *4D3EE8C701C0_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D3EE8C701C0_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_context_filter

procedure ApplicationHelper.get_cached_contract_form;
//#UC START# *460A819B01DA_460A6EF8024B_var*
//#UC END# *460A819B01DA_460A6EF8024B_var*
begin
//#UC START# *460A819B01DA_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460A819B01DA_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_contract_form

procedure ApplicationHelper.get_cached_user_manager;
//#UC START# *460B91AE00DA_460A6EF8024B_var*
//#UC END# *460B91AE00DA_460A6EF8024B_var*
begin
//#UC START# *460B91AE00DA_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B91AE00DA_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_user_manager

procedure ApplicationHelper.get_cached_folders;
//#UC START# *460B91FC0157_460A6EF8024B_var*
//#UC END# *460B91FC0157_460A6EF8024B_var*
begin
//#UC START# *460B91FC0157_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B91FC0157_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_folders

procedure ApplicationHelper.get_cached_under_control_manager;
//#UC START# *460B92A701F4_460A6EF8024B_var*
//#UC END# *460B92A701F4_460A6EF8024B_var*
begin
//#UC START# *460B92A701F4_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B92A701F4_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_under_control_manager

procedure ApplicationHelper.get_cached_settings;
//#UC START# *460B94F80232_460A6EF8024B_var*
//#UC END# *460B94F80232_460A6EF8024B_var*
begin
//#UC START# *460B94F80232_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B94F80232_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_settings

procedure ApplicationHelper.get_cached_settings_manager;
//#UC START# *460B95AC03D8_460A6EF8024B_var*
//#UC END# *460B95AC03D8_460A6EF8024B_var*
begin
//#UC START# *460B95AC03D8_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B95AC03D8_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_settings_manager

procedure ApplicationHelper.get_cached_life_cycle_manager;
//#UC START# *460B95D9004E_460A6EF8024B_var*
//#UC END# *460B95D9004E_460A6EF8024B_var*
begin
//#UC START# *460B95D9004E_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460B95D9004E_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_life_cycle_manager

procedure ApplicationHelper.get_cached_xml_save;
//#UC START# *4682713102DE_460A6EF8024B_var*
//#UC END# *4682713102DE_460A6EF8024B_var*
begin
//#UC START# *4682713102DE_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4682713102DE_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_xml_save

procedure ApplicationHelper.thr_mgr;
//#UC START# *460BA6F801D4_460A6EF8024B_var*
//#UC END# *460BA6F801D4_460A6EF8024B_var*
begin
//#UC START# *460BA6F801D4_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BA6F801D4_460A6EF8024B_impl*
end;//ApplicationHelper.thr_mgr

function ApplicationHelper.is_configurations_exist: Boolean;
//#UC START# *460BA70A0157_460A6EF8024B_var*
//#UC END# *460BA70A0157_460A6EF8024B_var*
begin
//#UC START# *460BA70A0157_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BA70A0157_460A6EF8024B_impl*
end;//ApplicationHelper.is_configurations_exist

procedure ApplicationHelper.get_cached_search_manager;
//#UC START# *460BA7220280_460A6EF8024B_var*
//#UC END# *460BA7220280_460A6EF8024B_var*
begin
//#UC START# *460BA7220280_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BA7220280_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_search_manager

procedure ApplicationHelper.get_cached_consultation_manager;
//#UC START# *460BA73401D4_460A6EF8024B_var*
//#UC END# *460BA73401D4_460A6EF8024B_var*
begin
//#UC START# *460BA73401D4_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BA73401D4_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_consultation_manager

procedure ApplicationHelper.get_cached_logging_manager;
//#UC START# *460BA77D007D_460A6EF8024B_var*
//#UC END# *460BA77D007D_460A6EF8024B_var*
begin
//#UC START# *460BA77D007D_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460BA77D007D_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_logging_manager

procedure ApplicationHelper.get_cached_integration;
//#UC START# *463F5B37009C_460A6EF8024B_var*
//#UC END# *463F5B37009C_460A6EF8024B_var*
begin
//#UC START# *463F5B37009C_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *463F5B37009C_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_integration

procedure ApplicationHelper.get_cached_prime;
//#UC START# *47C2A4670007_460A6EF8024B_var*
//#UC END# *47C2A4670007_460A6EF8024B_var*
begin
//#UC START# *47C2A4670007_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C2A4670007_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_prime

procedure ApplicationHelper.get_cached_prime_xml_save;
//#UC START# *47C695540167_460A6EF8024B_var*
//#UC END# *47C695540167_460A6EF8024B_var*
begin
//#UC START# *47C695540167_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C695540167_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_prime_xml_save

procedure ApplicationHelper.start_listen_for_me;
 {* Заставляем NotifyManager слушать нотификации только для меня }
//#UC START# *460CD7A6038A_460A6EF8024B_var*
//#UC END# *460CD7A6038A_460A6EF8024B_var*
begin
//#UC START# *460CD7A6038A_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CD7A6038A_460A6EF8024B_impl*
end;//ApplicationHelper.start_listen_for_me

procedure ApplicationHelper.stop_listen_for_me;
 {* Прекратить слушать нотификации для меня }
//#UC START# *460CD7D402FD_460A6EF8024B_var*
//#UC END# *460CD7D402FD_460A6EF8024B_var*
begin
//#UC START# *460CD7D402FD_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CD7D402FD_460A6EF8024B_impl*
end;//ApplicationHelper.stop_listen_for_me

procedure ApplicationHelper.clear_cache;
 {* Очистка кешированных серверных объектов }
//#UC START# *460CDD6C0399_460A6EF8024B_var*
//#UC END# *460CDD6C0399_460A6EF8024B_var*
begin
//#UC START# *460CDD6C0399_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *460CDD6C0399_460A6EF8024B_impl*
end;//ApplicationHelper.clear_cache

procedure ApplicationHelper.init(server_facade: ServerFacade);
//#UC START# *4746FE3B0046_460A6EF8024B_var*
//#UC END# *4746FE3B0046_460A6EF8024B_var*
begin
//#UC START# *4746FE3B0046_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4746FE3B0046_460A6EF8024B_impl*
end;//ApplicationHelper.init

constructor ApplicationHelper.make;
//#UC START# *474704110312_460A6EF8024B_var*
//#UC END# *474704110312_460A6EF8024B_var*
begin
//#UC START# *474704110312_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *474704110312_460A6EF8024B_impl*
end;//ApplicationHelper.make

function ApplicationHelper.server_facade: ServerFacade;
//#UC START# *474705300058_460A6EF8024B_var*
//#UC END# *474705300058_460A6EF8024B_var*
begin
//#UC START# *474705300058_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *474705300058_460A6EF8024B_impl*
end;//ApplicationHelper.server_facade

procedure ApplicationHelper.get_cached_user_journal;
//#UC START# *4A80371200CE_460A6EF8024B_var*
//#UC END# *4A80371200CE_460A6EF8024B_var*
begin
//#UC START# *4A80371200CE_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A80371200CE_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_user_journal

procedure ApplicationHelper.get_cached_tree_factory;
//#UC START# *4ABB429C0210_460A6EF8024B_var*
//#UC END# *4ABB429C0210_460A6EF8024B_var*
begin
//#UC START# *4ABB429C0210_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB429C0210_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_tree_factory

procedure ApplicationHelper.get_cached_property_manager;
//#UC START# *4AC4AB0C01BC_460A6EF8024B_var*
//#UC END# *4AC4AB0C01BC_460A6EF8024B_var*
begin
//#UC START# *4AC4AB0C01BC_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC4AB0C01BC_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_property_manager

procedure ApplicationHelper.get_cached_banner_manager;
 {* Получить баннер с сервера }
//#UC START# *4ACF446803B9_460A6EF8024B_var*
//#UC END# *4ACF446803B9_460A6EF8024B_var*
begin
//#UC START# *4ACF446803B9_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ACF446803B9_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_banner_manager

procedure ApplicationHelper.get_cached_current_user_id;
 {* возвращает идентификатор текущего пользователя }
//#UC START# *4AEE9E0E01D3_460A6EF8024B_var*
//#UC END# *4AEE9E0E01D3_460A6EF8024B_var*
begin
//#UC START# *4AEE9E0E01D3_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AEE9E0E01D3_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_current_user_id

procedure ApplicationHelper.get_cached_group_manager;
//#UC START# *4AF00C4B02A1_460A6EF8024B_var*
//#UC END# *4AF00C4B02A1_460A6EF8024B_var*
begin
//#UC START# *4AF00C4B02A1_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AF00C4B02A1_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_group_manager

procedure ApplicationHelper.get_cached_remote_document_support;
//#UC START# *4BD5566102F9_460A6EF8024B_var*
//#UC END# *4BD5566102F9_460A6EF8024B_var*
begin
//#UC START# *4BD5566102F9_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BD5566102F9_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_remote_document_support

procedure ApplicationHelper.get_cached_filters_manager;
//#UC START# *4CA5C3E1000C_460A6EF8024B_var*
//#UC END# *4CA5C3E1000C_460A6EF8024B_var*
begin
//#UC START# *4CA5C3E1000C_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4CA5C3E1000C_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_filters_manager

procedure ApplicationHelper.get_cached_main_menu;
//#UC START# *4DD4FCEF01B0_460A6EF8024B_var*
//#UC END# *4DD4FCEF01B0_460A6EF8024B_var*
begin
//#UC START# *4DD4FCEF01B0_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DD4FCEF01B0_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_main_menu

procedure ApplicationHelper.get_cached_decisions_archive_support;
//#UC START# *4F71D2D20136_460A6EF8024B_var*
//#UC END# *4F71D2D20136_460A6EF8024B_var*
begin
//#UC START# *4F71D2D20136_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F71D2D20136_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_decisions_archive_support

procedure ApplicationHelper.get_cached_document_type_resolver;
//#UC START# *4FE86FAD00A3_460A6EF8024B_var*
//#UC END# *4FE86FAD00A3_460A6EF8024B_var*
begin
//#UC START# *4FE86FAD00A3_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FE86FAD00A3_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_document_type_resolver

procedure ApplicationHelper.get_cached_link_manager;
//#UC START# *55952CE501E5_460A6EF8024B_var*
//#UC END# *55952CE501E5_460A6EF8024B_var*
begin
//#UC START# *55952CE501E5_460A6EF8024B_impl*
 !!! Needs to be implemented !!!
//#UC END# *55952CE501E5_460A6EF8024B_impl*
end;//ApplicationHelper.get_cached_link_manager

class function ApplicationHelper.Exists: Boolean;
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
