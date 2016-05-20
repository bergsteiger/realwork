unit NOT_COMPLETED_MainPrim_Form;

// Модуль: "w:\common\components\gui\Garant\VCM\View\NOT_COMPLETED_MainPrim_Form.pas"
// Стереотип: "VCMMainForm"
// Элемент модели: "MainPrim" MUID: (4F6B382E00D9)
// Имя типа: "TMainPrimForm"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , OfficeLikeMain_Form
 {$IfEnd} // NOT Defined(NoVCM)
 , PresentationInterfaces
 , F1Like_InternalOperations_Controls
 {$If NOT Defined(NoVCM)}
 , OfficeLike_System_Controls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 {$If Defined(Nemesis)}
 , nscStatusBar
 {$IfEnd} // Defined(Nemesis)
 , vtPanel
 , vtProportionalPanel
 , vtSizeablePanel
 {$If Defined(Nemesis)}
 , nscNavigator
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmContainerForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 , Classes
;

type
 // LeftNavigatorZone

 // RightNavigatorZone

 // ChildZone

 // ParentZone

 // BaseSeachZone

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Define HasRightNavigator}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

 TMainPrimForm = class({$If NOT Defined(NoVCM)}
 TOfficeLikeMainForm
 {$IfEnd} // NOT Defined(NoVCM)
 , InsMainFormChildZoneManager)
  private
   f_NeedSwitchKeyboard: Boolean;
   f_OldCaption: Il3CString;
   f_StatusBar: TnscStatusBar;
    {* Поле для свойства StatusBar }
   f_ClientZone: TvtPanel;
    {* Поле для свойства ClientZone }
   f_MainZone: TvtProportionalPanel;
    {* Поле для свойства MainZone }
   f_ParentZonePanel: TvtPanel;
    {* Поле для свойства ParentZonePanel }
   f_ChildZonePanel: TvtSizeablePanel;
    {* Поле для свойства ChildZonePanel }
   f_BaseSearchPanel: TvtPanel;
    {* Поле для свойства BaseSearchPanel }
   f_LeftNavigator: TnscNavigator;
    {* Поле для свойства LeftNavigator }
   {$If Defined(HasRightNavigator)}
   f_RightNavigator: TnscNavigator;
    {* Поле для свойства RightNavigator }
   {$IfEnd} // Defined(HasRightNavigator)
  private
   procedure vcmMainFormCloseQuery(Sender: TObject;
    var CanClose: Boolean);
   procedure vcmMainFormInsertForm(const aForm: IvcmEntityForm;
    var aMode: TvcmInsertMode);
   procedure fChildZoneQueryResize(ALeft: Integer;
    ATop: Integer;
    AWidth: Integer;
    AHeight: Integer;
    var aCanResize: Boolean);
   procedure fLeftNavigatorSaveSize(Sender: TObject;
    aSize: Integer);
   procedure fLeftNavigatorStateChange(Sender: TObject);
   procedure fLeftNavigatorLoadSize(Sender: TObject;
    var aSize: Integer);
   {$If Defined(HasRightNavigator)}
   procedure fRightNavigatorSaveSize(Sender: TObject;
    aSize: Integer);
   {$IfEnd} // Defined(HasRightNavigator)
   {$If Defined(HasRightNavigator)}
   procedure fRightNavigatorStateChange(Sender: TObject);
   {$IfEnd} // Defined(HasRightNavigator)
   {$If Defined(HasRightNavigator)}
   procedure fRightNavigatorLoadSize(Sender: TObject;
    var aSize: Integer);
   {$IfEnd} // Defined(HasRightNavigator)
   {$If Defined(HasRightNavigator)}
   procedure SaveRightNavigatorSize;
   {$IfEnd} // Defined(HasRightNavigator)
   {$If Defined(HasRightNavigator)}
   procedure LoadRightNavigatorSize;
   {$IfEnd} // Defined(HasRightNavigator)
   procedure SaveLeftNavigatorSize;
   procedure LoadLeftNavigatorSize;
  protected
   procedure ActivateDefKeyboardLayout; virtual;
   procedure InitClone(aForm: TvcmMainForm); virtual;
   procedure vcmMainFormAfterInsertForm(const aForm: IvcmEntityForm); virtual;
   procedure DropChangeStatusToOpened; virtual;
   procedure LoadSettings; virtual;
   function NeedAskMayExit: Boolean; virtual;
   function OpenNewMainWindow: TvcmMainForm; virtual;
   procedure DoCascadeWindows; virtual;
   procedure DoTileWindowsHorizontal; virtual;
   procedure DoTileWindowsVertical; virtual;
   function GetCanCloseAllWindows: Boolean; virtual;
   procedure DoCloseAllWindows; virtual;
   function DoGetNextMainForm: IvcmEntityForm; virtual;
   function GetCurrentActiveWindow: IvcmEntityForm; virtual;
   function GetCurrentOpenedWindowsCount: Integer; virtual;
   procedure CorrectHeight(var aHeight: Integer);
    {* корректирует при необходимости высоту дочерней зоны }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCL)}
   procedure DoShow; override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCM)}
   procedure DoSaveInSettings; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DispatcherCreated; override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   procedure Common_ShowSplitter_Execute(aVisible: Boolean);
   procedure Common_ShowSplitter(const aParams: IvcmExecuteParamsPrim);
   procedure Common_CheckChildZone_Execute(aToggle: Boolean);
   procedure Common_CheckChildZone(const aParams: IvcmExecuteParamsPrim);
   {$If NOT Defined(NoVCM)}
   procedure Common_OpenNewWindowByUser_Test(const aParams: IvcmTestParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Common_OpenNewWindowByUser_Execute(const aParams: IvcmExecuteParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Common_GetWindowList_Test(const aParams: IvcmTestParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Common_GetWindowList_Execute(const aParams: IvcmExecuteParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Common_CascadeWindows_Test(const aParams: IvcmTestParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Common_CascadeWindows_Execute(const aParams: IvcmExecuteParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Common_TileWindowsHorizontal_Test(const aParams: IvcmTestParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Common_TileWindowsHorizontal_Execute(const aParams: IvcmExecuteParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Common_TileWindowsVertical_Test(const aParams: IvcmTestParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Common_TileWindowsVertical_Execute(const aParams: IvcmExecuteParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Common_CloseAllWindows_Test(const aParams: IvcmTestParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Common_CloseAllWindows_Execute(const aParams: IvcmExecuteParamsPrim);
   {$IfEnd} // NOT Defined(NoVCM)
   constructor Create(AOwner: TComponent); override;
  public
   property StatusBar: TnscStatusBar
    read f_StatusBar;
   property ClientZone: TvtPanel
    read f_ClientZone;
 end;//TMainPrimForm

implementation

uses
 l3ImplUses
 , Graphics
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , nsWindowsList
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , afwFacade
 , Windows
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , OfficeLikeAppInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 , nsFormUtils
 , nsSettingsConst
 {$If NOT Defined(NoVCM)}
 , vcmHistory
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vtNavigator
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , F1Like_FormDefinitions_Controls
;

{$If NOT Defined(NoVCM)}
var g_InMakeClone: Boolean = False;

procedure TMainPrimForm.vcmMainFormCloseQuery(Sender: TObject;
 var CanClose: Boolean);
//#UC START# *4F6B4C7101EB_4F6B382E00D9_var*
//#UC END# *4F6B4C7101EB_4F6B382E00D9_var*
begin
//#UC START# *4F6B4C7101EB_4F6B382E00D9_impl*
 if CanClose and NeedAskMayExit then
 begin
  with Dispatcher do
  begin
   if (not InClosingAllWindows) then
   begin
    CanClose := AskMayExit;
    if CanClose then
     CanClose := (l3System.CheckClipboard(afw.Application.AskClearClipboardProc) <> IDCancel);
   end//not InClosingAllWindows
   else
    CanClose := InClosingAllWindows;
   if CanClose then
    DropChangeStatusToOpened;
  end;//with Dispatcher
 end;//CanClose..
//#UC END# *4F6B4C7101EB_4F6B382E00D9_impl*
end;//TMainPrimForm.vcmMainFormCloseQuery

procedure TMainPrimForm.vcmMainFormInsertForm(const aForm: IvcmEntityForm;
 var aMode: TvcmInsertMode);
//#UC START# *4F6B688F02BB_4F6B382E00D9_var*
var
 l_IForm: IvcmEntityForm;
//#UC END# *4F6B688F02BB_4F6B382E00D9_var*
begin
//#UC START# *4F6B688F02BB_4F6B382E00D9_impl*
 case aForm.ZoneType of
  vcm_ztParent:
  begin
   // Проверка вставки самого контейнера:
   if not aForm.SameName(fm_ParentForm.rFormID) then
   begin
    aMode := vcm_imDisable;
    if HasForm(fm_ParentForm.rFormID, vcm_ztParent, false, @l_IForm) then
     // Если контейнер уже существует, то вставляем в него:
     l_IForm.AsContainer.InsertForm(aForm)
    else
    begin
     // Создаем контейнер для основных объектов и вставляем форму уже в него:
     l_IForm := TdmStdRes.MakeParent(Self);
     l_IForm.AsContainer.InsertForm(aForm);
    end;//HasForm(fm_ParentForm, vcm_ztParent, false, @l_IForm)
   end//not aForm.SameName(fm_ParentForm)
   else
    aMode := vcm_imAllow;
  end;//vcm_ztParent
  vcm_ztChild:
  begin
   if not aForm.SameName(fm_ChildForm.rFormID) then {проверка вставки самого контейнера}
   begin
    aMode := vcm_imDisable;
    if HasForm(fm_ChildForm.rFormID, vcm_ztChild, false, @l_IForm) then
     // Если контейнер уже существует, то вставляем в него:
     l_IForm.AsContainer.InsertForm(aForm)
    else
    if HasForm(fm_ParentForm.rFormID, vcm_ztParent, false, @l_IForm) then
     // Создаем контейнер для зависимых объектов и вставляем форму уже в него:
     TdmStdRes.MakeChild(Self, l_IForm.VCLWinControl As TvcmEntityForm).AsContainer.InsertForm(aForm)
    else
     raise Exception.Create('Дочерняя зона создаётся раньше родительской');
   end//not aForm.SameName(fm_ChildForm)
   else
    aMode := vcm_imAllow;
  end;//vcm_ztChild
  vcm_ztNavigator:
   aMode := vcm_imAllow;
  else
   aMode := vcm_imAllow;
 end;//case aForm.ZoneType
//#UC END# *4F6B688F02BB_4F6B382E00D9_impl*
end;//TMainPrimForm.vcmMainFormInsertForm

procedure TMainPrimForm.ActivateDefKeyboardLayout;
//#UC START# *4F71FA8102BF_4F6B382E00D9_var*
//#UC END# *4F71FA8102BF_4F6B382E00D9_var*
begin
//#UC START# *4F71FA8102BF_4F6B382E00D9_impl*
 // - ничего не делаем
//#UC END# *4F71FA8102BF_4F6B382E00D9_impl*
end;//TMainPrimForm.ActivateDefKeyboardLayout

procedure TMainPrimForm.fChildZoneQueryResize(ALeft: Integer;
 ATop: Integer;
 AWidth: Integer;
 AHeight: Integer;
 var aCanResize: Boolean);
//#UC START# *4F7AE3370161_4F6B382E00D9_var*
const
 cMinChildHeight = 75;
   {* - минимальная высота ChildZone при которой не происходит перехода на
        первую закладку. }
var
 lForm : IvcmEntityForm;
//#UC END# *4F7AE3370161_4F6B382E00D9_var*
begin
//#UC START# *4F7AE3370161_4F6B382E00D9_impl*
 aCanResize := (AHeight > cMinChildHeight);
 (* Поиск Child_Form *)
 if not aCanResize and HasForm(fm_ChildForm.rFormID, vcm_ztChild, True, @lForm) then
 try
  (* Переход на первую закладку *)
  op_Switcher_SetFirstPageActive.Call(lForm);
 finally
  lForm := nil;
 end;//try..finally
//#UC END# *4F7AE3370161_4F6B382E00D9_impl*
end;//TMainPrimForm.fChildZoneQueryResize

procedure TMainPrimForm.InitClone(aForm: TvcmMainForm);
//#UC START# *4F7AE85E01EF_4F6B382E00D9_var*
//#UC END# *4F7AE85E01EF_4F6B382E00D9_var*
begin
//#UC START# *4F7AE85E01EF_4F6B382E00D9_impl*
 // - ничего не делаем, пусть потомки делают
//#UC END# *4F7AE85E01EF_4F6B382E00D9_impl*
end;//TMainPrimForm.InitClone

procedure TMainPrimForm.vcmMainFormAfterInsertForm(const aForm: IvcmEntityForm);
//#UC START# *4F7AEC7F03CB_4F6B382E00D9_var*
//#UC END# *4F7AEC7F03CB_4F6B382E00D9_var*
begin
//#UC START# *4F7AEC7F03CB_4F6B382E00D9_impl*
 nsSetPageIcon(aForm);
//#UC END# *4F7AEC7F03CB_4F6B382E00D9_impl*
end;//TMainPrimForm.vcmMainFormAfterInsertForm

procedure TMainPrimForm.DropChangeStatusToOpened;
//#UC START# *4F7AED150304_4F6B382E00D9_var*
//#UC END# *4F7AED150304_4F6B382E00D9_var*
begin
//#UC START# *4F7AED150304_4F6B382E00D9_impl*
 // - ничего не делаем, пусть потомки разбираются
//#UC END# *4F7AED150304_4F6B382E00D9_impl*
end;//TMainPrimForm.DropChangeStatusToOpened

procedure TMainPrimForm.fLeftNavigatorSaveSize(Sender: TObject;
 aSize: Integer);
//#UC START# *4F7B02880214_4F6B382E00D9_var*
//#UC END# *4F7B02880214_4F6B382E00D9_var*
begin
//#UC START# *4F7B02880214_4F6B382E00D9_impl*
 afw.Settings.SaveInteger(pi_Navigator_LeftSize, aSize);
//#UC END# *4F7B02880214_4F6B382E00D9_impl*
end;//TMainPrimForm.fLeftNavigatorSaveSize

procedure TMainPrimForm.fLeftNavigatorStateChange(Sender: TObject);
//#UC START# *4F7B02A4014A_4F6B382E00D9_var*
//#UC END# *4F7B02A4014A_4F6B382E00D9_var*
begin
//#UC START# *4F7B02A4014A_4F6B382E00D9_impl*
 afw.Settings.SaveInteger(pi_LeftNavigator, Ord(LeftNavigator.State));
//#UC END# *4F7B02A4014A_4F6B382E00D9_impl*
end;//TMainPrimForm.fLeftNavigatorStateChange

procedure TMainPrimForm.fLeftNavigatorLoadSize(Sender: TObject;
 var aSize: Integer);
//#UC START# *4F7B02C1038C_4F6B382E00D9_var*
//#UC END# *4F7B02C1038C_4F6B382E00D9_var*
begin
//#UC START# *4F7B02C1038C_4F6B382E00D9_impl*
 aSize := afw.Settings.LoadInteger(pi_Navigator_LeftSize, dv_Navigator_LeftSize);
//#UC END# *4F7B02C1038C_4F6B382E00D9_impl*
end;//TMainPrimForm.fLeftNavigatorLoadSize

{$If Defined(HasRightNavigator)}
procedure TMainPrimForm.fRightNavigatorSaveSize(Sender: TObject;
 aSize: Integer);
//#UC START# *4F7B030202AF_4F6B382E00D9_var*
//#UC END# *4F7B030202AF_4F6B382E00D9_var*
begin
//#UC START# *4F7B030202AF_4F6B382E00D9_impl*
 afw.Settings.SaveInteger(pi_Navigator_RightSize, aSize);
//#UC END# *4F7B030202AF_4F6B382E00D9_impl*
end;//TMainPrimForm.fRightNavigatorSaveSize
{$IfEnd} // Defined(HasRightNavigator)

{$If Defined(HasRightNavigator)}
procedure TMainPrimForm.fRightNavigatorStateChange(Sender: TObject);
//#UC START# *4F7B0324026C_4F6B382E00D9_var*
//#UC END# *4F7B0324026C_4F6B382E00D9_var*
begin
//#UC START# *4F7B0324026C_4F6B382E00D9_impl*
 afw.Settings.SaveInteger(pi_RightNavigator, Ord(RightNavigator.State));
//#UC END# *4F7B0324026C_4F6B382E00D9_impl*
end;//TMainPrimForm.fRightNavigatorStateChange
{$IfEnd} // Defined(HasRightNavigator)

{$If Defined(HasRightNavigator)}
procedure TMainPrimForm.fRightNavigatorLoadSize(Sender: TObject;
 var aSize: Integer);
//#UC START# *4F7B03520229_4F6B382E00D9_var*
//#UC END# *4F7B03520229_4F6B382E00D9_var*
begin
//#UC START# *4F7B03520229_4F6B382E00D9_impl*
 aSize := afw.Settings.LoadInteger(pi_Navigator_RightSize, dv_Navigator_RightSize);
//#UC END# *4F7B03520229_4F6B382E00D9_impl*
end;//TMainPrimForm.fRightNavigatorLoadSize
{$IfEnd} // Defined(HasRightNavigator)

{$If Defined(HasRightNavigator)}
procedure TMainPrimForm.SaveRightNavigatorSize;
//#UC START# *4F7B07610146_4F6B382E00D9_var*
//#UC END# *4F7B07610146_4F6B382E00D9_var*
begin
//#UC START# *4F7B07610146_4F6B382E00D9_impl*
 afw.Settings.SaveInteger(pi_Navigator_RightSize, RightNavigator.SizeNormal);
//#UC END# *4F7B07610146_4F6B382E00D9_impl*
end;//TMainPrimForm.SaveRightNavigatorSize
{$IfEnd} // Defined(HasRightNavigator)

{$If Defined(HasRightNavigator)}
procedure TMainPrimForm.LoadRightNavigatorSize;
//#UC START# *4F7B077502AC_4F6B382E00D9_var*
//#UC END# *4F7B077502AC_4F6B382E00D9_var*
begin
//#UC START# *4F7B077502AC_4F6B382E00D9_impl*
 RightNavigator.SizeNormal := afw.Settings.LoadInteger(pi_Navigator_RightSize,
  dv_Navigator_RightSize);
//#UC END# *4F7B077502AC_4F6B382E00D9_impl*
end;//TMainPrimForm.LoadRightNavigatorSize
{$IfEnd} // Defined(HasRightNavigator)

procedure TMainPrimForm.SaveLeftNavigatorSize;
//#UC START# *4F7B0786002B_4F6B382E00D9_var*
//#UC END# *4F7B0786002B_4F6B382E00D9_var*
begin
//#UC START# *4F7B0786002B_4F6B382E00D9_impl*
 afw.Settings.SaveInteger(pi_Navigator_LeftSize, LeftNavigator.SizeNormal);
//#UC END# *4F7B0786002B_4F6B382E00D9_impl*
end;//TMainPrimForm.SaveLeftNavigatorSize

procedure TMainPrimForm.LoadLeftNavigatorSize;
//#UC START# *4F7B079B001C_4F6B382E00D9_var*
//#UC END# *4F7B079B001C_4F6B382E00D9_var*
begin
//#UC START# *4F7B079B001C_4F6B382E00D9_impl*
 LeftNavigator.SizeNormal := afw.Settings.LoadInteger(pi_Navigator_LeftSize,
  dv_Navigator_LeftSize);
//#UC END# *4F7B079B001C_4F6B382E00D9_impl*
end;//TMainPrimForm.LoadLeftNavigatorSize

procedure TMainPrimForm.LoadSettings;
//#UC START# *4F7B0815025A_4F6B382E00D9_var*

 procedure LoadNavigator(aNavigator : TnscNavigator;
                         aPropId    : PAnsiChar;
                         aDefVal    : Integer);
 begin
  aNavigator.State := TNavigatorState(afw.Settings.LoadInteger(aPropId, aDefVal));
 end;

//#UC END# *4F7B0815025A_4F6B382E00D9_var*
begin
//#UC START# *4F7B0815025A_4F6B382E00D9_impl*
 LoadNavigator(LeftNavigator, pi_LeftNavigator, Ord(dv_LeftNavigator));
 {$IfDef HasRightNavigator}
 LoadNavigator(RightNavigator, pi_RightNavigator, Ord(dv_RightNavigator));
 {$EndIf HasRightNavigator}
 LoadLeftNavigatorSize;
 {$IfDef HasRightNavigator}
 LoadRightNavigatorSize;
 {$EndIf HasRightNavigator}
 LeftNavigator.AutoHideFloat := afw.Settings.LoadBoolean(pi_lnAutoHideFloat,
  dv_lnAutoHideFloat);
 {$IfDef HasRightNavigator}
 RightNavigator.AutoHideFloat := afw.Settings.LoadBoolean(pi_rnAutoHideFloat,
  dv_rnAutoHideFloat);
 {$EndIf HasRightNavigator} 
//#UC END# *4F7B0815025A_4F6B382E00D9_impl*
end;//TMainPrimForm.LoadSettings

function TMainPrimForm.NeedAskMayExit: Boolean;
//#UC START# *53A013DF03E1_4F6B382E00D9_var*
//#UC END# *53A013DF03E1_4F6B382E00D9_var*
begin
//#UC START# *53A013DF03E1_4F6B382E00D9_impl*
 Result :=  (not SDI) OR
            (Dispatcher.FormDispatcher.MainFormsCount <= 1);
//#UC END# *53A013DF03E1_4F6B382E00D9_impl*
end;//TMainPrimForm.NeedAskMayExit

function TMainPrimForm.OpenNewMainWindow: TvcmMainForm;
//#UC START# *53AD17180374_4F6B382E00D9_var*
//#UC END# *53AD17180374_4F6B382E00D9_var*
begin
//#UC START# *53AD17180374_4F6B382E00D9_impl*
 Result := MakeClone;
 if (Result <> nil) then
 begin
  InitClone(Result);
  if (GetForegroundWindow <> Result.Handle) then
   SetForegroundWindow(Result.Handle);
 end;
//#UC END# *53AD17180374_4F6B382E00D9_impl*
end;//TMainPrimForm.OpenNewMainWindow

procedure TMainPrimForm.DoCascadeWindows;
//#UC START# *53D0E77003DD_4F6B382E00D9_var*
//#UC END# *53D0E77003DD_4F6B382E00D9_var*
begin
//#UC START# *53D0E77003DD_4F6B382E00D9_impl*
 Dispatcher.CascadeWindows;
//#UC END# *53D0E77003DD_4F6B382E00D9_impl*
end;//TMainPrimForm.DoCascadeWindows

procedure TMainPrimForm.DoTileWindowsHorizontal;
//#UC START# *53D0ECFB035D_4F6B382E00D9_var*
//#UC END# *53D0ECFB035D_4F6B382E00D9_var*
begin
//#UC START# *53D0ECFB035D_4F6B382E00D9_impl*
 Dispatcher.TileWindowsHorizontal;
//#UC END# *53D0ECFB035D_4F6B382E00D9_impl*
end;//TMainPrimForm.DoTileWindowsHorizontal

procedure TMainPrimForm.DoTileWindowsVertical;
//#UC START# *53D0ED410163_4F6B382E00D9_var*
//#UC END# *53D0ED410163_4F6B382E00D9_var*
begin
//#UC START# *53D0ED410163_4F6B382E00D9_impl*
 Dispatcher.TileWindowsVertical;
//#UC END# *53D0ED410163_4F6B382E00D9_impl*
end;//TMainPrimForm.DoTileWindowsVertical

function TMainPrimForm.GetCanCloseAllWindows: Boolean;
//#UC START# *53D20CE2034C_4F6B382E00D9_var*
//#UC END# *53D20CE2034C_4F6B382E00D9_var*
begin
//#UC START# *53D20CE2034C_4F6B382E00D9_impl*
 Result := (Dispatcher.FormDispatcher.MainFormsCount > 1);
//#UC END# *53D20CE2034C_4F6B382E00D9_impl*
end;//TMainPrimForm.GetCanCloseAllWindows

procedure TMainPrimForm.DoCloseAllWindows;
//#UC START# *53D20D0402AC_4F6B382E00D9_var*
//#UC END# *53D20D0402AC_4F6B382E00D9_var*
begin
//#UC START# *53D20D0402AC_4F6B382E00D9_impl*
 Dispatcher.CloseAllWindows(nil, Self.as_IvcmEntityForm);
//#UC END# *53D20D0402AC_4F6B382E00D9_impl*
end;//TMainPrimForm.DoCloseAllWindows

function TMainPrimForm.DoGetNextMainForm: IvcmEntityForm;
//#UC START# *53D21DEA02A4_4F6B382E00D9_var*
var
 l_MyIndex: Integer;
 l_Index: Integer;
//#UC END# *53D21DEA02A4_4F6B382E00D9_var*
begin
//#UC START# *53D21DEA02A4_4F6B382E00D9_impl*
 Result := nil;
 with Dispatcher.FormDispatcher do
 begin
  l_MyIndex := -1;
  // Индекс текущей формы
  for l_Index := 0 to Pred(MainFormsCount) do
   if (MainForm[l_Index].VCLWinControl = Self) then
   begin
    l_MyIndex := l_Index;
    Break;
   end;//VCLWinControl = Self
  // Надейм следущую форму и сделаем ее активной
  if (l_MyIndex <> -1) then
  begin
   Inc(l_MyIndex);
   if (l_MyIndex = MainFormsCount) then
    l_MyIndex := 0;
   Result := MainForm[l_MyIndex];
  end;//l_MyIndex <> -1
 end;
//#UC END# *53D21DEA02A4_4F6B382E00D9_impl*
end;//TMainPrimForm.DoGetNextMainForm

function TMainPrimForm.GetCurrentActiveWindow: IvcmEntityForm;
//#UC START# *54607EC40295_4F6B382E00D9_var*
//#UC END# *54607EC40295_4F6B382E00D9_var*
begin
//#UC START# *54607EC40295_4F6B382E00D9_impl*
 Result := Self.As_IvcmEntityForm;
//#UC END# *54607EC40295_4F6B382E00D9_impl*
end;//TMainPrimForm.GetCurrentActiveWindow

function TMainPrimForm.GetCurrentOpenedWindowsCount: Integer;
//#UC START# *54607EEF00BB_4F6B382E00D9_var*
//#UC END# *54607EEF00BB_4F6B382E00D9_var*
begin
//#UC START# *54607EEF00BB_4F6B382E00D9_impl*
 Result := Dispatcher.FormDispatcher.MainFormsCount;
//#UC END# *54607EEF00BB_4F6B382E00D9_impl*
end;//TMainPrimForm.GetCurrentOpenedWindowsCount

procedure TMainPrimForm.CorrectHeight(var aHeight: Integer);
 {* корректирует при необходимости высоту дочерней зоны }
//#UC START# *499037820017_4F6B382E00D9_var*
var
 l_AvailableHeight: Integer;
//#UC END# *499037820017_4F6B382E00D9_var*
begin
//#UC START# *499037820017_4F6B382E00D9_impl*
 l_AvailableHeight := MainZone.Height - ParentZonePanel.Constraints.MinHeight;
 if aHeight > l_AvailableHeight then
  aHeight := l_AvailableHeight;
//#UC END# *499037820017_4F6B382E00D9_impl*
end;//TMainPrimForm.CorrectHeight

procedure TMainPrimForm.Common_ShowSplitter_Execute(aVisible: Boolean);
//#UC START# *4AE8744002F3_4F6B382E00D9exec_var*
//#UC END# *4AE8744002F3_4F6B382E00D9exec_var*
begin
//#UC START# *4AE8744002F3_4F6B382E00D9exec_impl*
 if aVisible then
  ChildZonePanel.SizeableSides := [szTop]
 else
  ChildZonePanel.SizeableSides := [];
//#UC END# *4AE8744002F3_4F6B382E00D9exec_impl*
end;//TMainPrimForm.Common_ShowSplitter_Execute

procedure TMainPrimForm.Common_ShowSplitter(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ICommon_ShowSplitter_Params) do
  Self.Common_ShowSplitter_Execute(Visible);
end;//TMainPrimForm.Common_ShowSplitter

procedure TMainPrimForm.Common_CheckChildZone_Execute(aToggle: Boolean);
//#UC START# *4AE8777F01A3_4F6B382E00D9exec_var*
var
 l_IForm: IvcmEntityForm;
//#UC END# *4AE8777F01A3_4F6B382E00D9exec_var*
begin
//#UC START# *4AE8777F01A3_4F6B382E00D9exec_impl*
 if aToggle then
 begin
  // Управляем видимостью нижнего контейнера
  if not HasForm(fm_ChildForm.rFormID, vcm_ztChild, false, @l_IForm) then
   ChildZonePanel.Hide
  else
  if l_IForm.AsContainer.HasForm(vcm_ztChild, false) then
   ChildZonePanel.Show
  else
   ChildZonePanel.Hide;
 end//aToggle
 else
  ChildZonePanel.Show;
//#UC END# *4AE8777F01A3_4F6B382E00D9exec_impl*
end;//TMainPrimForm.Common_CheckChildZone_Execute

procedure TMainPrimForm.Common_CheckChildZone(const aParams: IvcmExecuteParamsPrim);
begin
 with (aParams.Data As ICommon_CheckChildZone_Params) do
  Self.Common_CheckChildZone_Execute(Toggle);
end;//TMainPrimForm.Common_CheckChildZone

procedure TMainPrimForm.Common_OpenNewWindowByUser_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A30B60087_4F6B382E00D9test_var*
//#UC END# *4C8A30B60087_4F6B382E00D9test_var*
begin
//#UC START# *4C8A30B60087_4F6B382E00D9test_impl*
{$if defined(Admin) or defined(Monitorings)}
 aParams.Op.Flag[vcm_ofEnabled] := False;
 aParams.Op.Flag[vcm_ofVisible] := False;
{$else}
 if g_InMakeClone then
  aParams.Op.Flag[vcm_ofEnabled] := False;
{$ifend}
//#UC END# *4C8A30B60087_4F6B382E00D9test_impl*
end;//TMainPrimForm.Common_OpenNewWindowByUser_Test

procedure TMainPrimForm.Common_OpenNewWindowByUser_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A30B60087_4F6B382E00D9exec_var*
//#UC END# *4C8A30B60087_4F6B382E00D9exec_var*
begin
//#UC START# *4C8A30B60087_4F6B382E00D9exec_impl*
 g_InMakeClone := true;
 try
  OpenNewMainWindow;
 finally
  g_InMakeClone := false;
 end;//try..finally
//#UC END# *4C8A30B60087_4F6B382E00D9exec_impl*
end;//TMainPrimForm.Common_OpenNewWindowByUser_Execute

procedure TMainPrimForm.Common_GetWindowList_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A30DB001D_4F6B382E00D9test_var*
var
 l_List : IvcmNodes;
 l_ParentForm: TCustomForm;
 l_Form: IvcmEntityForm;
//#UC END# *4C8A30DB001D_4F6B382E00D9test_var*
begin
//#UC START# *4C8A30DB001D_4F6B382E00D9test_impl*
{$if defined(Admin) or defined(Monitorings)}
 aParams.Op.Flag[vcm_ofEnabled] := False;
 aParams.Op.Flag[vcm_ofVisible] := False;
{$else}
 l_List := aParams.Op.SubNodes;
 // Для одной формы список не показываем
 if GetCurrentOpenedWindowsCount = 1 then
 begin
  l_List.Clear;
  aParams.Op.Flag[vcm_ofEnabled] := False;
 end//Dispatcher.FormDispatcher.MainFormsCount
 else
 begin
  // Перезагрузим список, если изменился _Caption формы
  if not l3Same(f_OldCaption, CCaption) then
  begin
   TnsWindowsList.Instance.Reload;
   f_OldCaption := CCaption;
  end;//not l3Same(f_OldCaption, CCaption)
  // Установим список
  if (l_List <> nil) then
  begin
   with l_List do
   begin
    Clear;
    Add(TnsWindowsList.Instance.Root);
    // Текущая формы выделена check-ом
    Current := TnsWindowsList.Instance.FindNode(GetCurrentActiveWindow);
   end;//with l_List
  end;//l_List <> nil
 end;//Dispatcher.FormDispatcher.MainFormsCount
{$ifend}
//#UC END# *4C8A30DB001D_4F6B382E00D9test_impl*
end;//TMainPrimForm.Common_GetWindowList_Test

procedure TMainPrimForm.Common_GetWindowList_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A30DB001D_4F6B382E00D9exec_var*
var
 lWindow  : InsWindow;
 lIndex   : Integer;
 lMyIndex : Integer;
//#UC END# *4C8A30DB001D_4F6B382E00D9exec_var*
begin
//#UC START# *4C8A30DB001D_4F6B382E00D9exec_impl*
 with Dispatcher.FormDispatcher do
 begin
  // Пользователь выбрал значение в списке
  if Supports(aParams.CurrentNode, InsWindow, lWindow) then
   try
    ShowMainForm(lWindow.Form);
   finally
    lWindow := nil;
   end//try..finally
  // Пользователь нажал на кнопку в toolbar-е, выберем следующее окно после
  // текущего
  else
   ShowMainForm(DoGetNextMainForm);
 end;//with Dispatcher.FormDispatcher
//#UC END# *4C8A30DB001D_4F6B382E00D9exec_impl*
end;//TMainPrimForm.Common_GetWindowList_Execute

procedure TMainPrimForm.Common_CascadeWindows_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A30F30115_4F6B382E00D9test_var*
//#UC END# *4C8A30F30115_4F6B382E00D9test_var*
begin
//#UC START# *4C8A30F30115_4F6B382E00D9test_impl*
{$if defined(Admin) or defined(Monitorings)}
 aParams.Op.Flag[vcm_ofEnabled] := False;
 aParams.Op.Flag[vcm_ofVisible] := False;
{$ifend}
//#UC END# *4C8A30F30115_4F6B382E00D9test_impl*
end;//TMainPrimForm.Common_CascadeWindows_Test

procedure TMainPrimForm.Common_CascadeWindows_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A30F30115_4F6B382E00D9exec_var*
//#UC END# *4C8A30F30115_4F6B382E00D9exec_var*
begin
//#UC START# *4C8A30F30115_4F6B382E00D9exec_impl*
 DoCascadeWindows;
//#UC END# *4C8A30F30115_4F6B382E00D9exec_impl*
end;//TMainPrimForm.Common_CascadeWindows_Execute

procedure TMainPrimForm.Common_TileWindowsHorizontal_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A3114001E_4F6B382E00D9test_var*
//#UC END# *4C8A3114001E_4F6B382E00D9test_var*
begin
//#UC START# *4C8A3114001E_4F6B382E00D9test_impl*
{$if defined(Admin) or defined(Monitorings)}
 aParams.Op.Flag[vcm_ofEnabled] := False;
 aParams.Op.Flag[vcm_ofVisible] := False;
{$ifend}
//#UC END# *4C8A3114001E_4F6B382E00D9test_impl*
end;//TMainPrimForm.Common_TileWindowsHorizontal_Test

procedure TMainPrimForm.Common_TileWindowsHorizontal_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A3114001E_4F6B382E00D9exec_var*
//#UC END# *4C8A3114001E_4F6B382E00D9exec_var*
begin
//#UC START# *4C8A3114001E_4F6B382E00D9exec_impl*
 DoTileWindowsHorizontal;
//#UC END# *4C8A3114001E_4F6B382E00D9exec_impl*
end;//TMainPrimForm.Common_TileWindowsHorizontal_Execute

procedure TMainPrimForm.Common_TileWindowsVertical_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A312F018D_4F6B382E00D9test_var*
//#UC END# *4C8A312F018D_4F6B382E00D9test_var*
begin
//#UC START# *4C8A312F018D_4F6B382E00D9test_impl*
{$if defined(Admin) or defined(Monitorings)}
 aParams.Op.Flag[vcm_ofEnabled] := False;
 aParams.Op.Flag[vcm_ofVisible] := False;
{$ifend}
//#UC END# *4C8A312F018D_4F6B382E00D9test_impl*
end;//TMainPrimForm.Common_TileWindowsVertical_Test

procedure TMainPrimForm.Common_TileWindowsVertical_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A312F018D_4F6B382E00D9exec_var*
//#UC END# *4C8A312F018D_4F6B382E00D9exec_var*
begin
//#UC START# *4C8A312F018D_4F6B382E00D9exec_impl*
 DoTileWindowsVertical;
//#UC END# *4C8A312F018D_4F6B382E00D9exec_impl*
end;//TMainPrimForm.Common_TileWindowsVertical_Execute

procedure TMainPrimForm.Common_CloseAllWindows_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4C8A31770143_4F6B382E00D9test_var*
//#UC END# *4C8A31770143_4F6B382E00D9test_var*
begin
//#UC START# *4C8A31770143_4F6B382E00D9test_impl*
{$if defined(Admin) or defined(Monitorings)}
 aParams.Op.Flag[vcm_ofEnabled] := False;
 aParams.Op.Flag[vcm_ofVisible] := False;
{$else}
 aParams.Op.Flag[vcm_ofEnabled] := GetCanCloseAllWindows;
{$ifend}
//#UC END# *4C8A31770143_4F6B382E00D9test_impl*
end;//TMainPrimForm.Common_CloseAllWindows_Test

procedure TMainPrimForm.Common_CloseAllWindows_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8A31770143_4F6B382E00D9exec_var*
//#UC END# *4C8A31770143_4F6B382E00D9exec_var*
begin
//#UC START# *4C8A31770143_4F6B382E00D9exec_impl*
 DoCloseAllWindows;
//#UC END# *4C8A31770143_4F6B382E00D9exec_impl*
end;//TMainPrimForm.Common_CloseAllWindows_Execute

procedure TMainPrimForm.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F6B382E00D9_var*
//#UC END# *479731C50290_4F6B382E00D9_var*
begin
//#UC START# *479731C50290_4F6B382E00D9_impl*
 TnsWindowsList.Instance.Remove(Self.As_IvcmEntityForm);
 inherited;
//#UC END# *479731C50290_4F6B382E00D9_impl*
end;//TMainPrimForm.Cleanup

procedure TMainPrimForm.InitFields;
//#UC START# *47A042E100E2_4F6B382E00D9_var*
//#UC END# *47A042E100E2_4F6B382E00D9_var*
begin
//#UC START# *47A042E100E2_4F6B382E00D9_impl*
 inherited;
 SDI := true;
//#UC END# *47A042E100E2_4F6B382E00D9_impl*
end;//TMainPrimForm.InitFields

constructor TMainPrimForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4F6B382E00D9_var*
//#UC END# *47D1602000C6_4F6B382E00D9_var*
begin
//#UC START# *47D1602000C6_4F6B382E00D9_impl*
 SDI := True;
 inherited;
//#UC END# *47D1602000C6_4F6B382E00D9_impl*
end;//TMainPrimForm.Create

procedure TMainPrimForm.DoInit(aFromHistory: Boolean);
 {* Инициализация формы. Для перекрытия в потомках }
//#UC START# *49803F5503AA_4F6B382E00D9_var*
//#UC END# *49803F5503AA_4F6B382E00D9_var*
begin
//#UC START# *49803F5503AA_4F6B382E00D9_impl*
 inherited;
 // Появилась новая форма, перегрузим список открытых окон
 History.AddForm(Self.As_IvcmEntityForm);
 TnsWindowsList.Instance.Reload;
 OnInsertForm := vcmMainFormInsertForm;
 OnAfterInsertForm := vcmMainFormAfterInsertForm;
 OnCloseQuery := vcmMainFormCloseQuery;
 //WindowState := wsMaximized;
 f_NeedSwitchKeyboard := (Dispatcher.FormDispatcher.MainFormsCount = 1);
//#UC END# *49803F5503AA_4F6B382E00D9_impl*
end;//TMainPrimForm.DoInit

procedure TMainPrimForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4F6B382E00D9_var*
//#UC END# *4A8E8F2E0195_4F6B382E00D9_var*
begin
//#UC START# *4A8E8F2E0195_4F6B382E00D9_impl*
 inherited;
 ActiveControl := ParentZonePanel;
 with ClientZone do
 begin
   Left := 0;
   Top := 0;
   Width := 801;
   Height := 542;
   Align := alClient;
   BevelOuter := bvNone;
   Color := clWhite;
   TabOrder := 0;
 end;//with ClientZone
 with BaseSearchPanel do
 begin
   Left := 0;
   Top := 0;
   Width := 801;
   Height := 41;
   Align := alTop;
   AutoSize := True;
   BevelOuter := bvNone;
   Color := clWhite;
   TabOrder := 0;
 end;//with BaseSearchPanel
 with MainZone do
 begin
   Left := 20;
   Top := 41;
   Width := 761;
   Height := 501;
   BevelOuter := bvNone;
   Color := clWhite;
   TabOrder := 1;
 end;//with MainZone;
 with LeftNavigator do
 begin
   Left := 0;
   Top := 41;
   Width := 20;
   Height := 501;
   OnSaveSize := fLeftNavigatorSaveSize;
   OnLoadSize := fLeftNavigatorLoadSize;
   Images := dmStdRes.SmallImageList;
   DelayIntervalOnHide := 700;
   DelayOnAutoHide := True;
   SingleFloatNavigator := False;
   Align := alLeft;
   SizeEmpty := 2;
   SizeNormal := 200;
   OnStateChange := fLeftNavigatorStateChange;
   UnDockFromFloat := True;
   ButtonsImageList := dmStdRes.NavigatorImageList;
   BevelOuter := bvNone;
   Color := clWhite;
   TabOrder := 3;
 end;//with LeftNavigator
 {$IfDef HasRightNavigator}
 with RightNavigator do
 begin
   Left := 781;
   Top := 41;
   Width := 20;
   Height := 501;
   OnSaveSize := fRightNavigatorSaveSize;
   OnLoadSize := fRightNavigatorLoadSize;
   Images := dmStdRes.SmallImageList;
   DelayIntervalOnHide := 700;
   DelayOnAutoHide := True;
   SingleFloatNavigator := False;
   Align := alRight;
   SizeEmpty := 2;
   SizeNormal := 200;
   OnStateChange := fRightNavigatorStateChange;
   UnDockFromFloat := True;
   ButtonsImageList := dmStdRes.NavigatorImageList;
   BevelOuter := bvNone;
   Color := clWhite;
   TabOrder := 2;
 end;//RightNavigator
 {$EndIf HasRightNavigator}
 with ChildZonePanel do
 begin
   Left := 0;
   Top := 261;
   Width := 761;
   Height := 240;
   ResizeAreaWidth := 5;
   SizeableSides := [szTop];
   SplitterBevel := bvRaised;
   OnQueryResize := fChildZoneQueryResize;
   Align := alBottom;
   BevelOuter := bvNone;
   Color := clWhite;
   Constraints.MinHeight := 27;
   TabOrder := 1;
 end;//ChildZonePanel
  with ParentZonePanel do
  begin
    Left := 0;
    Top := 0;
    Width := 761;
    Height := 261;
    Align := alClient;
    BevelOuter := bvNone;
    Color := clWhite;
    Constraints.MinHeight := 40;
    TabOrder := 0;
  end;//with ParentZonePanel
  with StatusBar do
  begin
    Left := 0;
    Top := 542;
    Width := 801;
    Height := 28;
    Font.Charset := RUSSIAN_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'Arial';
    Font.Style := [];
    ParentFont := False;
    ParentShowHint := False;
    ShowHint := True;
  end;//with StatusBar
 RequestAlign; 
//#UC END# *4A8E8F2E0195_4F6B382E00D9_impl*
end;//TMainPrimForm.InitControls

{$If NOT Defined(NoVCL)}
procedure TMainPrimForm.DoShow;
//#UC START# *4B321D1301DD_4F6B382E00D9_var*
//#UC END# *4B321D1301DD_4F6B382E00D9_var*
begin
//#UC START# *4B321D1301DD_4F6B382E00D9_impl*
 inherited;
 if f_NeedSwitchKeyboard then
 begin
  Self.ActivateDefKeyboardLayout;
  f_NeedSwitchKeyboard := False;
 end;//f_NeedSwitchKeyboard
//#UC END# *4B321D1301DD_4F6B382E00D9_impl*
end;//TMainPrimForm.DoShow
{$IfEnd} // NOT Defined(NoVCL)

procedure TMainPrimForm.DoSaveInSettings;
//#UC START# *4F7B072201AA_4F6B382E00D9_var*
//#UC END# *4F7B072201AA_4F6B382E00D9_var*
begin
//#UC START# *4F7B072201AA_4F6B382E00D9_impl*
 inherited;
 with afw.Settings do
 begin
  SaveInteger(pi_LeftNavigator, Ord(LeftNavigator.State));
  {$IfDef HasRightNavigator}
  SaveInteger(pi_RightNavigator, Ord(RightNavigator.State));
  {$EndIf HasRightNavigator}
  SaveLeftNavigatorSize;
  {$IfDef HasRightNavigator}
  SaveRightNavigatorSize;
  {$EndIf HasRightNavigator}
  SaveBoolean(pi_lnAutoHideFloat, LeftNavigator.AutoHideFloat);
  {$IfDef HasRightNavigator}
  SaveBoolean(pi_rnAutoHideFloat, RightNavigator.AutoHideFloat);
  {$EndIf HasRightNavigator}
 end;//with afw.Settings
//#UC END# *4F7B072201AA_4F6B382E00D9_impl*
end;//TMainPrimForm.DoSaveInSettings

procedure TMainPrimForm.DispatcherCreated;
//#UC START# *4F7B0CF50022_4F6B382E00D9_var*
//#UC END# *4F7B0CF50022_4F6B382E00D9_var*
begin
//#UC START# *4F7B0CF50022_4F6B382E00D9_impl*
 inherited;
 g_vcmHistoryLimit := afw.Settings.LoadInteger(piHistoryItems, dvHistoryItems);
 MenuManager.LoadShortcuts;
//#UC END# *4F7B0CF50022_4F6B382E00D9_impl*
end;//TMainPrimForm.DispatcherCreated

procedure TMainPrimForm.ClearFields;
begin
 f_OldCaption := nil;
 inherited;
end;//TMainPrimForm.ClearFields

procedure TMainPrimForm.MakeControls;
begin
 inherited;
 f_StatusBar := TnscStatusBar.Create(Self);
 f_StatusBar.Name := 'StatusBar';
 f_StatusBar.Parent := Self;
 f_ClientZone := TvtPanel.Create(Self);
 f_ClientZone.Name := 'ClientZone';
 f_ClientZone.Parent := Self;
 f_MainZone := TvtProportionalPanel.Create(Self);
 f_MainZone.Name := 'MainZone';
 f_MainZone.Parent := ClientZone;
 f_ParentZonePanel := TvtPanel.Create(Self);
 f_ParentZonePanel.Name := 'ParentZonePanel';
 f_ParentZonePanel.Parent := MainZone;
 with DefineZone(vcm_ztParent, f_ParentZonePanel) do
 begin
  //#UC START# *4F6B3F20007B*
  !!!
  //#UC END# *4F6B3F20007B*
 end;//with DefineZone(vcm_ztParent
 f_ChildZonePanel := TvtSizeablePanel.Create(Self);
 f_ChildZonePanel.Name := 'ChildZonePanel';
 f_ChildZonePanel.Parent := MainZone;
 with DefineZone(vcm_ztChild, f_ChildZonePanel) do
 begin
 end;//with DefineZone(vcm_ztChild
 f_BaseSearchPanel := TvtPanel.Create(Self);
 f_BaseSearchPanel.Name := 'BaseSearchPanel';
 f_BaseSearchPanel.Parent := ClientZone;
 with DefineZone(vcm_ztMain, f_BaseSearchPanel) do
 begin
 end;//with DefineZone(vcm_ztMain
 f_LeftNavigator := TnscNavigator.Create(Self);
 f_LeftNavigator.Name := 'LeftNavigator';
 f_LeftNavigator.Parent := ClientZone;
 with DefineZone(vcm_ztNavigator, f_LeftNavigator) do
 begin
  CanClose := vcm_ccEnable;
  //#UC START# *4F6B38FB0206*
  !!!
  //#UC END# *4F6B38FB0206*
 end;//with DefineZone(vcm_ztNavigator
{$If Defined(HasRightNavigator)}
 f_RightNavigator := TnscNavigator.Create(Self);
 f_RightNavigator.Name := 'RightNavigator';
 f_RightNavigator.Parent := ClientZone;
 with DefineZone(vcm_ztNavigator, f_RightNavigator) do
 begin
  CanClose := vcm_ccEnable;
  //#UC START# *4F6B391B022C*
  !!!
  //#UC END# *4F6B391B022C*
 end;//with DefineZone(vcm_ztNavigator
{$IfEnd} // Defined(HasRightNavigator)

end;//TMainPrimForm.MakeControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMainPrimForm);
 {* Регистрация MainPrim }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
