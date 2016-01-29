unit PrimTasksPanelMenu_Module;

interface

uses
 l3IntfUses
 , vcmPopupMenuPrim
 , vcmTaskPanelInterfaces
 , Menus
 , Classes
 , PrimCustomizeTasksPanel_Form
 , l3StringIDEx
 , vcmUserControls
 , tfwInteger
;

type
 // ut_CustomizeTasksPanel
 
 TCustomizeTasksPanelForm = class(TPrimCustomizeTasksPanelForm)
  {* Редактор панели задач }
 end;//TCustomizeTasksPanelForm
 
 TPrimTasksPanelMenuModule = class(MvcmModule)
  procedure Customize;
   {* Настройка... }
  procedure CustomizePanel(const aPanel: IvcmCustOps);
   {* Настроить панель иструментов }
  function TasksPanelPopupMenu: TPopupMenu;
 end;//TPrimTasksPanelMenuModule
 
implementation

uses
 l3ImplUses
 , vcmInterfaces
 , vcmBase
 , SysUtils
 , vcmMenus
 , Forms
 , vcmCustOpsRepGroupList
 , TtfwClassRef_Proxy
 , l3MessageID
 , CustomizeTasksPanelKeywordsPack
;

type
 Tkw_FormUserType_ut_CustomizeTasksPanel = class(TtfwInteger)
  {* Слово словаря для типа формы ut_CustomizeTasksPanel }
 end;//Tkw_FormUserType_ut_CustomizeTasksPanel
 
end.
