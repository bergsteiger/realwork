unit PrimToolbarMenu_Module;

interface

uses
 l3IntfUses
 , vcmToolbarsInterfaces
 , vcmBaseMenuManager
 , Classes
 , PrimCustomizeTools_Form
 , l3StringIDEx
 , vcmUserControls
 , tfwInteger
 , l3ProtoDataContainer
;

type
 // ut_CustomizeTools
 
 TCustomizeToolsForm = class(TPrimCustomizeToolsForm)
 end;//TCustomizeToolsForm
 
 TIvcmToolbarsCustomizeListenerPtrList = class(_l3InterfacePtrList_)
  {* Список указателей на IvcmToolbarsCustomizeListener }
 end;//TIvcmToolbarsCustomizeListenerPtrList
 
 TPrimToolbarMenuModule = class(IvcmToolbarsCustomizeNotify, IvcmToolbarsCustomize, MvcmModule)
  procedure Customize;
   {* Настройка... }
  procedure AvailableOperations;
   {* Доступные операции... }
  procedure IconsSize;
   {* Размер кнопок }
  procedure Fasten;
   {* Закрепить панели инструментов }
  procedure DoNotify;
  procedure pmToolbarPopup(Sender: TObject);
  procedure AddListener(const aListener: IvcmToolbarsCustomizeListener);
  procedure RemoveListener(const aListener: IvcmToolbarsCustomizeListener);
  function Notify: IvcmToolbarsCustomizeNotify;
 end;//TPrimToolbarMenuModule
 
implementation

uses
 l3ImplUses
 , afwFacade
 , vcmToolbarMenuRes
 , vcmExternalInterfaces
 , vcmMenuManager
 , vcmInterfaces
 , Controls
 , vcmCustomizeAvailableToolbarOps
 , vcmEntityForm
 , vcmMenus
 , vcmToolbar
 , eeShortCutEdit
 , TtfwClassRef_Proxy
 , l3MessageID
 , CustomizeToolsKeywordsPack
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type
 Tkw_FormUserType_ut_CustomizeTools = class(TtfwInteger)
  {* Слово словаря для типа формы ut_CustomizeTools }
 end;//Tkw_FormUserType_ut_CustomizeTools
 
end.
