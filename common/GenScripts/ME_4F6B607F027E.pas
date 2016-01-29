unit F1LikeRes;

interface

uses
 l3IntfUses
 , OfficeLikeRes
 , PresentationInterfaces
 , F1Like_InternalOperations_Controls
 , OfficeLike_System_Controls
 , l3Interfaces
 , nscStatusBar
 , vtPanel
 , vtProportionalPanel
 , vtSizeablePanel
 , nscNavigator
 , vcmInterfaces
 , vcmContainerForm
 , vcmMainForm
 , Classes
;

type
 // LeftNavigatorZone
 
 // RightNavigatorZone
 
 // ChildZone
 
 // ParentZone
 
 // BaseSeachZone
 
 {$Define HasRightNavigator}
 
 TMainPrimForm = class(TOfficeLikeMainForm, InsMainFormChildZoneManager, Common, Common)
  procedure vcmMainFormCloseQuery(Sender: TObject;
   var CanClose: Boolean);
  procedure vcmMainFormInsertForm(const aForm: IvcmEntityForm;
   var aMode: TvcmInsertMode);
  procedure ActivateDefKeyboardLayout;
  procedure fChildZoneQueryResize(ALeft: Integer;
   ATop: Integer;
   AWidth: Integer;
   AHeight: Integer;
   var aCanResize: Boolean);
  procedure InitClone(aForm: TvcmMainForm);
  procedure vcmMainFormAfterInsertForm(const aForm: IvcmEntityForm);
  procedure DropChangeStatusToOpened;
  procedure fLeftNavigatorSaveSize(Sender: TObject;
   aSize: Integer);
  procedure fLeftNavigatorStateChange(Sender: TObject);
  procedure fLeftNavigatorLoadSize(Sender: TObject;
   var aSize: Integer);
  procedure fRightNavigatorSaveSize(Sender: TObject;
   aSize: Integer);
  procedure fRightNavigatorStateChange(Sender: TObject);
  procedure fRightNavigatorLoadSize(Sender: TObject;
   var aSize: Integer);
  procedure SaveRightNavigatorSize;
  procedure LoadRightNavigatorSize;
  procedure SaveLeftNavigatorSize;
  procedure LoadLeftNavigatorSize;
  procedure LoadSettings;
  function NeedAskMayExit: Boolean;
  function OpenNewMainWindow: TvcmMainForm;
  procedure DoCascadeWindows;
  procedure DoTileWindowsHorizontal;
  procedure DoTileWindowsVertical;
  function GetCanCloseAllWindows: Boolean;
  procedure DoCloseAllWindows;
  function DoGetNextMainForm: IvcmEntityForm;
  function GetCurrentActiveWindow: IvcmEntityForm;
  function GetCurrentOpenedWindowsCount: Integer;
  procedure CorrectHeight(var aHeight: Integer);
   {* корректирует при необходимости высоту дочерней зоны }
  procedure ShowSplitter;
  procedure CheckChildZone;
  procedure OpenNewWindowByUser;
  procedure GetWindowList;
  procedure CascadeWindows;
  procedure TileWindowsHorizontal;
  procedure TileWindowsVertical;
  procedure CloseAllWindows;
 end;//TMainPrimForm
 
 TF1LikeRes = class(TOfficeLikeRes)
 end;//TF1LikeRes
 
implementation

uses
 l3ImplUses
 , moTasksPanelMenu
 , moParentAndChild
 , vtStdRes
 , Graphics
 , Controls
 , Forms
 , nsWindowsList
 , l3Base
 , afwFacade
 , Windows
 , SysUtils
 , OfficeLikeAppInterfaces
 , l3String
 , nsFormUtils
 , nsSettingsConst
 , vcmHistory
 , vtNavigator
 , TtfwClassRef_Proxy
 , F1Like_FormDefinitions_Controls
;

end.
