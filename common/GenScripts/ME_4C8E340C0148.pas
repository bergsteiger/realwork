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
  {* ������ ���������� �� IvcmToolbarsCustomizeListener }
 end;//TIvcmToolbarsCustomizeListenerPtrList
 
 TPrimToolbarMenuModule = class(IvcmToolbarsCustomizeNotify, IvcmToolbarsCustomize, MvcmModule)
  procedure Customize;
   {* ���������... }
  procedure AvailableOperations;
   {* ��������� ��������... }
  procedure IconsSize;
   {* ������ ������ }
  procedure Fasten;
   {* ��������� ������ ������������ }
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
  {* ����� ������� ��� ���� ����� ut_CustomizeTools }
 end;//Tkw_FormUserType_ut_CustomizeTools
 
end.
