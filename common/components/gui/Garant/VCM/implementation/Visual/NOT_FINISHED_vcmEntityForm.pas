unit NOT_FINISHED_vcmEntityForm;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/NOT_FINISHED_vcmEntityForm.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmEntityForm
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  afwInterfaces,
  vcmExternalInterfaces,
  l3InternalInterfaces,
  vcmInterfaces,
  vcmToolbarsInterfaces,
  vcmFormDispatcherInterfaces,
  l3ProtoDataContainer,
  vcmEntityFormModelPart,
  vcmEntityFormImplementationModelPart,
  vcmUserTypesCollectionItem,
  l3Core
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmEntityFormImplementation = class(TvcmEntityFormImplementationModelPart)
 end;//TvcmEntityFormImplementation

 TvcmGetLocalizationInfo = procedure (Sender: TObject;
  var theInfo: AnsiString) of object;

 TvcmSetLocalizationInfo = procedure (Sender: TObject;
  const theInfo: AnsiString) of object;

 RvcmEntityForm = ;

 IvcmFormState = interface(IvcmBase)
   ['{BB487EA1-7432-4B8B-B634-114A5634FE7D}']
   procedure LoadState(aForm: TvcmEntityForm;
     aStateType: TvcmStateType);
 end;//IvcmFormState

 IvcmStateItem = interface(IUnknown)
   ['{89686484-2090-46E7-B98A-E464E86DC4FD}']
   procedure LoadState(aForm: TvcmEntityForm;
     aStateType: TvcmStateType);
 end;//IvcmStateItem

 _afwApplicationDataUpdate_Parent_ = TvcmEntityFormModelPart;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 _afwSettingsReplace_Parent_ = _afwApplicationDataUpdate_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}
 TvcmEntityForm = class(_afwSettingsReplace_, Il3CommandTarget, IafwForm, IafwTabSheetControl, IvcmToolbarsCustomizeListener, IvcmFormDispatcherListener)
 protected
 // realized methods
   procedure UpdateCaption(const aCaption: IafwCString);
     {* установить заголовок формы. }
   function pm_GetBoundsRect: TRect;
   procedure PageInactive;
     {* активная закладка стала не активной. }
   procedure PageActive;
     {* закладка стала активной. }
   function pm_GetWeight: Integer;
   function ProcessCommand(Cmd: Tl3OperationCode;
    aForce: Boolean;
    aCount: Integer): Boolean;
   procedure StartNewMainForm;
     {* вызывается перед созданием главной формы }
   procedure BeforeCustomize;
     {* вызывается перед вызовом окна редактирования панелей инструментов }
 public
 // overridden public methods
   function NeedSaveInSettings: Boolean; override;
 protected
 // protected methods
   procedure UpdateStatusInfo;
     {* Сигнатура метода UpdateStatusInfo }
   procedure CheckFloatingVisibility; virtual;
   procedure CreateFormGUID(var theGUID: TGUID); virtual;
     {* Создаёт идентификатор формы. Для того, чтобы отличать однотипные формы друг от друга. В частности для истории. }
   function HasFormFloatingZoneTypeAndVisible: Boolean; virtual;
   procedure CleanDependencies; virtual;
     {* Сигнатура метода CleanDependencies }
   procedure SetupFormLayout; virtual;
     {* Тут можно настроить внешний вид формы }
   procedure ReleaseResources; virtual;
     {* Сигнатура метода ReleaseResources }
   procedure BeforeClosing; virtual;
     {* Сигнатура метода BeforeClosing }
   function DoGetTabCaption: IvcmCString; virtual;
   function HasFormModalState: Boolean;
   procedure DoOnShowModal; virtual;
   function DoGetNeedAddFormToTasksPanel: Boolean; virtual;
   function GetInner(anEntityID: TvcmControlID): IvcmEntity; virtual;
   function NeedTerminateApp: Boolean; virtual;
   function DoGetNeedSaveToTabHistory: Boolean; virtual;
   function NeedLoadFormStateForClone(const aState: IvcmBase;
     aStateType: TvcmStateType): Boolean; virtual;
   procedure DoBeforeHistoryNavigate; virtual;
     {* Сигнатура метода DoBeforeHistoryNavigate }
   procedure DoInit(aFromHistory: Boolean); virtual;
     {* Инициализация формы. Для перекрытия в потомках }
   function DoSaveState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; virtual;
     {* Сохраняет состояние формы. Для перекрытия в потомках }
   function DoLoadState(const aState: IvcmBase;
    aStateType: TvcmStateType): Boolean; virtual;
     {* Загружает состояние формы. Для перекрытия в потомках }
   procedure BecomeActive; virtual;
   procedure BecomeInactive; virtual;
   function SaveOwnFormState(out theState: IvcmBase;
    aStateType: TvcmStateType;
    aForClone: Boolean): Boolean; virtual;
   procedure PageActive; virtual;
   procedure PageInactive; virtual;
 public
 // public methods
   procedure NotifyUserTypeSet; virtual;
     {* Сигнатура метода NotifyUserTypeSet }
   procedure DefaultQueryClose(aSender: TObject); virtual;
   function AddUserType: TvcmUserTypesCollectionItem;
   procedure SetPositionByDS; virtual;
     {* Вызывается когда нужно изменить позицию используя источник данных. [$136258455] }
   function NeedDrawCaption: Boolean; virtual;
     {* Нужно ли рисовать заголовок зоны }
   function SettingsSuffix: AnsiString; virtual;
   procedure SetActiveControl; virtual;
     {* Устанавливает текущий контрол. Какой? Сама форма решает. Для перекрытия в потомках }
   function DoGetTabInfo(out theCaption: Il3CString;
    out theItemIndex: Integer): Boolean; virtual;
     {* Информация о закладке, в которую вставляется форма. Для перекрытия в потомках }
 end;//TvcmEntityForm
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils,
  l3VCLFormPtrList,
  vcmFormsUtils,
  vcmControlList
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  afwFacade,
  afwSettingsChangePublisher
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  VCMFormsProcessingPack
  {$IfEnd} //not NoScripts AND not NoVCM
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}

type
  _ItemType_ = IvcmStateItem;
  _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
  TvcmFormState = class(_l3InterfaceRefList_, IvcmBase, IvcmFormState)
  protected
  // realized methods
   procedure LoadState(aForm: TvcmEntityForm;
      aStateType: TvcmStateType);
  public
  // public methods
   procedure AddState(const aName: AnsiString;
      const aState: IUnknown);
  end;//TvcmFormState

type _Instance_R_ = TvcmFormState;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

// start class TvcmFormState

procedure TvcmFormState.AddState(const aName: AnsiString;
  const aState: IUnknown);
//#UC START# *55C1FE41015B_55C1F803015D_var*
//#UC END# *55C1FE41015B_55C1F803015D_var*
begin
//#UC START# *55C1FE41015B_55C1F803015D_impl*
 !!! Needs to be implemented !!!
//#UC END# *55C1FE41015B_55C1F803015D_impl*
end;//TvcmFormState.AddState

procedure TvcmFormState.LoadState(aForm: TvcmEntityForm;
  aStateType: TvcmStateType);
//#UC START# *55C1F7D50220_55C1F803015D_var*
//#UC END# *55C1F7D50220_55C1F803015D_var*
begin
//#UC START# *55C1F7D50220_55C1F803015D_impl*
 !!! Needs to be implemented !!!
//#UC END# *55C1F7D50220_55C1F803015D_impl*
end;//TvcmFormState.LoadState

procedure TvcmEntityForm.UpdateStatusInfo;
//#UC START# *4A378C0E0268_49525B34022A_var*
//#UC END# *4A378C0E0268_49525B34022A_var*
begin
//#UC START# *4A378C0E0268_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A378C0E0268_49525B34022A_impl*
end;//TvcmEntityForm.UpdateStatusInfo

procedure TvcmEntityForm.NotifyUserTypeSet;
//#UC START# *4D78E2BB0211_49525B34022A_var*
//#UC END# *4D78E2BB0211_49525B34022A_var*
begin
//#UC START# *4D78E2BB0211_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D78E2BB0211_49525B34022A_impl*
end;//TvcmEntityForm.NotifyUserTypeSet

procedure TvcmEntityForm.DefaultQueryClose(aSender: TObject);
//#UC START# *4E7A030702C6_49525B34022A_var*
//#UC END# *4E7A030702C6_49525B34022A_var*
begin
//#UC START# *4E7A030702C6_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E7A030702C6_49525B34022A_impl*
end;//TvcmEntityForm.DefaultQueryClose

procedure TvcmEntityForm.CheckFloatingVisibility;
//#UC START# *4E7A13AE01BC_49525B34022A_var*
//#UC END# *4E7A13AE01BC_49525B34022A_var*
begin
//#UC START# *4E7A13AE01BC_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E7A13AE01BC_49525B34022A_impl*
end;//TvcmEntityForm.CheckFloatingVisibility

procedure TvcmEntityForm.CreateFormGUID(var theGUID: TGUID);
//#UC START# *4EBBC63E032A_49525B34022A_var*
//#UC END# *4EBBC63E032A_49525B34022A_var*
begin
//#UC START# *4EBBC63E032A_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EBBC63E032A_49525B34022A_impl*
end;//TvcmEntityForm.CreateFormGUID

function TvcmEntityForm.AddUserType: TvcmUserTypesCollectionItem;
//#UC START# *5006A4F50056_49525B34022A_var*
//#UC END# *5006A4F50056_49525B34022A_var*
begin
//#UC START# *5006A4F50056_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5006A4F50056_49525B34022A_impl*
end;//TvcmEntityForm.AddUserType

function TvcmEntityForm.HasFormFloatingZoneTypeAndVisible: Boolean;
//#UC START# *523AC062006F_49525B34022A_var*
//#UC END# *523AC062006F_49525B34022A_var*
begin
//#UC START# *523AC062006F_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *523AC062006F_49525B34022A_impl*
end;//TvcmEntityForm.HasFormFloatingZoneTypeAndVisible

procedure TvcmEntityForm.CleanDependencies;
//#UC START# *52544597027B_49525B34022A_var*
//#UC END# *52544597027B_49525B34022A_var*
begin
//#UC START# *52544597027B_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52544597027B_49525B34022A_impl*
end;//TvcmEntityForm.CleanDependencies

procedure TvcmEntityForm.SetupFormLayout;
//#UC START# *529332B40230_49525B34022A_var*
//#UC END# *529332B40230_49525B34022A_var*
begin
//#UC START# *529332B40230_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *529332B40230_49525B34022A_impl*
end;//TvcmEntityForm.SetupFormLayout

procedure TvcmEntityForm.ReleaseResources;
//#UC START# *538C374A00B7_49525B34022A_var*
//#UC END# *538C374A00B7_49525B34022A_var*
begin
//#UC START# *538C374A00B7_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *538C374A00B7_49525B34022A_impl*
end;//TvcmEntityForm.ReleaseResources

procedure TvcmEntityForm.BeforeClosing;
//#UC START# *53A0288600CE_49525B34022A_var*
//#UC END# *53A0288600CE_49525B34022A_var*
begin
//#UC START# *53A0288600CE_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53A0288600CE_49525B34022A_impl*
end;//TvcmEntityForm.BeforeClosing

function TvcmEntityForm.DoGetTabCaption: IvcmCString;
//#UC START# *53F1C6EF02C9_49525B34022A_var*
//#UC END# *53F1C6EF02C9_49525B34022A_var*
begin
//#UC START# *53F1C6EF02C9_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53F1C6EF02C9_49525B34022A_impl*
end;//TvcmEntityForm.DoGetTabCaption

function TvcmEntityForm.HasFormModalState: Boolean;
//#UC START# *5445EA2201E6_49525B34022A_var*
//#UC END# *5445EA2201E6_49525B34022A_var*
begin
//#UC START# *5445EA2201E6_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5445EA2201E6_49525B34022A_impl*
end;//TvcmEntityForm.HasFormModalState

procedure TvcmEntityForm.DoOnShowModal;
//#UC START# *5445EA440078_49525B34022A_var*
//#UC END# *5445EA440078_49525B34022A_var*
begin
//#UC START# *5445EA440078_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5445EA440078_49525B34022A_impl*
end;//TvcmEntityForm.DoOnShowModal

function TvcmEntityForm.DoGetNeedAddFormToTasksPanel: Boolean;
//#UC START# *54F458DD01CE_49525B34022A_var*
//#UC END# *54F458DD01CE_49525B34022A_var*
begin
//#UC START# *54F458DD01CE_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *54F458DD01CE_49525B34022A_impl*
end;//TvcmEntityForm.DoGetNeedAddFormToTasksPanel

function TvcmEntityForm.GetInner(anEntityID: TvcmControlID): IvcmEntity;
//#UC START# *550BBA210234_49525B34022A_var*
//#UC END# *550BBA210234_49525B34022A_var*
begin
//#UC START# *550BBA210234_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *550BBA210234_49525B34022A_impl*
end;//TvcmEntityForm.GetInner

function TvcmEntityForm.NeedTerminateApp: Boolean;
//#UC START# *550BD7B6024E_49525B34022A_var*
//#UC END# *550BD7B6024E_49525B34022A_var*
begin
//#UC START# *550BD7B6024E_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *550BD7B6024E_49525B34022A_impl*
end;//TvcmEntityForm.NeedTerminateApp

function TvcmEntityForm.DoGetNeedSaveToTabHistory: Boolean;
//#UC START# *55B9F0BD0069_49525B34022A_var*
//#UC END# *55B9F0BD0069_49525B34022A_var*
begin
//#UC START# *55B9F0BD0069_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *55B9F0BD0069_49525B34022A_impl*
end;//TvcmEntityForm.DoGetNeedSaveToTabHistory

function TvcmEntityForm.NeedLoadFormStateForClone(const aState: IvcmBase;
  aStateType: TvcmStateType): Boolean;
//#UC START# *561CB1350027_49525B34022A_var*
//#UC END# *561CB1350027_49525B34022A_var*
begin
//#UC START# *561CB1350027_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *561CB1350027_49525B34022A_impl*
end;//TvcmEntityForm.NeedLoadFormStateForClone

procedure TvcmEntityForm.DoBeforeHistoryNavigate;
//#UC START# *562E15F20132_49525B34022A_var*
//#UC END# *562E15F20132_49525B34022A_var*
begin
//#UC START# *562E15F20132_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *562E15F20132_49525B34022A_impl*
end;//TvcmEntityForm.DoBeforeHistoryNavigate
// start class TvcmEntityForm

procedure TvcmEntityForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_49525B34022A_var*
//#UC END# *49803F5503AA_49525B34022A_var*
begin
//#UC START# *49803F5503AA_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *49803F5503AA_49525B34022A_impl*
end;//TvcmEntityForm.DoInit

function TvcmEntityForm.DoSaveState(out theState: IvcmBase;
  aStateType: TvcmStateType;
  aForClone: Boolean): Boolean;
//#UC START# *49806ED503D5_49525B34022A_var*
//#UC END# *49806ED503D5_49525B34022A_var*
begin
//#UC START# *49806ED503D5_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *49806ED503D5_49525B34022A_impl*
end;//TvcmEntityForm.DoSaveState

function TvcmEntityForm.DoLoadState(const aState: IvcmBase;
  aStateType: TvcmStateType): Boolean;
//#UC START# *49807428008C_49525B34022A_var*
//#UC END# *49807428008C_49525B34022A_var*
begin
//#UC START# *49807428008C_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *49807428008C_49525B34022A_impl*
end;//TvcmEntityForm.DoLoadState

procedure TvcmEntityForm.SetPositionByDS;
//#UC START# *498953170108_49525B34022A_var*
//#UC END# *498953170108_49525B34022A_var*
begin
//#UC START# *498953170108_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *498953170108_49525B34022A_impl*
end;//TvcmEntityForm.SetPositionByDS

function TvcmEntityForm.NeedDrawCaption: Boolean;
//#UC START# *4A84183701B9_49525B34022A_var*
//#UC END# *4A84183701B9_49525B34022A_var*
begin
//#UC START# *4A84183701B9_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A84183701B9_49525B34022A_impl*
end;//TvcmEntityForm.NeedDrawCaption

procedure TvcmEntityForm.BecomeActive;
//#UC START# *4A8AE0FA03B2_49525B34022A_var*
//#UC END# *4A8AE0FA03B2_49525B34022A_var*
begin
//#UC START# *4A8AE0FA03B2_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8AE0FA03B2_49525B34022A_impl*
end;//TvcmEntityForm.BecomeActive

function TvcmEntityForm.SettingsSuffix: AnsiString;
//#UC START# *4A8E425D0268_49525B34022A_var*
//#UC END# *4A8E425D0268_49525B34022A_var*
begin
//#UC START# *4A8E425D0268_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A8E425D0268_49525B34022A_impl*
end;//TvcmEntityForm.SettingsSuffix

procedure TvcmEntityForm.SetActiveControl;
//#UC START# *4AC3803A03CD_49525B34022A_var*
//#UC END# *4AC3803A03CD_49525B34022A_var*
begin
//#UC START# *4AC3803A03CD_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC3803A03CD_49525B34022A_impl*
end;//TvcmEntityForm.SetActiveControl

function TvcmEntityForm.DoGetTabInfo(out theCaption: Il3CString;
  out theItemIndex: Integer): Boolean;
//#UC START# *4AC497FD00A2_49525B34022A_var*
//#UC END# *4AC497FD00A2_49525B34022A_var*
begin
//#UC START# *4AC497FD00A2_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AC497FD00A2_49525B34022A_impl*
end;//TvcmEntityForm.DoGetTabInfo

procedure TvcmEntityForm.BecomeInactive;
//#UC START# *4AD5FA8E03DD_49525B34022A_var*
//#UC END# *4AD5FA8E03DD_49525B34022A_var*
begin
//#UC START# *4AD5FA8E03DD_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AD5FA8E03DD_49525B34022A_impl*
end;//TvcmEntityForm.BecomeInactive

function TvcmEntityForm.SaveOwnFormState(out theState: IvcmBase;
  aStateType: TvcmStateType;
  aForClone: Boolean): Boolean;
//#UC START# *4B4F49900003_49525B34022A_var*
//#UC END# *4B4F49900003_49525B34022A_var*
begin
//#UC START# *4B4F49900003_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B4F49900003_49525B34022A_impl*
end;//TvcmEntityForm.SaveOwnFormState

procedure TvcmEntityForm.PageActive;
//#UC START# *4C52E8030278_49525B34022A_var*
//#UC END# *4C52E8030278_49525B34022A_var*
begin
//#UC START# *4C52E8030278_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52E8030278_49525B34022A_impl*
end;//TvcmEntityForm.PageActive

procedure TvcmEntityForm.PageInactive;
//#UC START# *4C52E81603A9_49525B34022A_var*
//#UC END# *4C52E81603A9_49525B34022A_var*
begin
//#UC START# *4C52E81603A9_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C52E81603A9_49525B34022A_impl*
end;//TvcmEntityForm.PageInactive

procedure TvcmEntityForm.UpdateCaption(const aCaption: IafwCString);
//#UC START# *473D9692001D_49525B34022A_var*
//#UC END# *473D9692001D_49525B34022A_var*
begin
//#UC START# *473D9692001D_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *473D9692001D_49525B34022A_impl*
end;//TvcmEntityForm.UpdateCaption

function TvcmEntityForm.pm_GetBoundsRect: TRect;
//#UC START# *473D96AE014F_49525B34022Aget_var*
//#UC END# *473D96AE014F_49525B34022Aget_var*
begin
//#UC START# *473D96AE014F_49525B34022Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *473D96AE014F_49525B34022Aget_impl*
end;//TvcmEntityForm.pm_GetBoundsRect

procedure TvcmEntityForm.PageInactive;
//#UC START# *473DB05D033A_49525B34022A_var*
//#UC END# *473DB05D033A_49525B34022A_var*
begin
//#UC START# *473DB05D033A_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *473DB05D033A_49525B34022A_impl*
end;//TvcmEntityForm.PageInactive

procedure TvcmEntityForm.PageActive;
//#UC START# *473DB06A01A8_49525B34022A_var*
//#UC END# *473DB06A01A8_49525B34022A_var*
begin
//#UC START# *473DB06A01A8_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *473DB06A01A8_49525B34022A_impl*
end;//TvcmEntityForm.PageActive

function TvcmEntityForm.pm_GetWeight: Integer;
//#UC START# *473DB083030D_49525B34022Aget_var*
//#UC END# *473DB083030D_49525B34022Aget_var*
begin
//#UC START# *473DB083030D_49525B34022Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *473DB083030D_49525B34022Aget_impl*
end;//TvcmEntityForm.pm_GetWeight

function TvcmEntityForm.ProcessCommand(Cmd: Tl3OperationCode;
  aForce: Boolean;
  aCount: Integer): Boolean;
//#UC START# *476F76A90267_49525B34022A_var*
//#UC END# *476F76A90267_49525B34022A_var*
begin
//#UC START# *476F76A90267_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *476F76A90267_49525B34022A_impl*
end;//TvcmEntityForm.ProcessCommand

procedure TvcmEntityForm.StartNewMainForm;
//#UC START# *4992FBD101B2_49525B34022A_var*
//#UC END# *4992FBD101B2_49525B34022A_var*
begin
//#UC START# *4992FBD101B2_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4992FBD101B2_49525B34022A_impl*
end;//TvcmEntityForm.StartNewMainForm

procedure TvcmEntityForm.BeforeCustomize;
//#UC START# *4992FC5700E5_49525B34022A_var*
//#UC END# *4992FC5700E5_49525B34022A_var*
begin
//#UC START# *4992FC5700E5_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4992FC5700E5_49525B34022A_impl*
end;//TvcmEntityForm.BeforeCustomize

function TvcmEntityForm.NeedSaveInSettings: Boolean;
//#UC START# *4FC38C4C0119_49525B34022A_var*
//#UC END# *4FC38C4C0119_49525B34022A_var*
begin
//#UC START# *4FC38C4C0119_49525B34022A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FC38C4C0119_49525B34022A_impl*
end;//TvcmEntityForm.NeedSaveInSettings

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmEntityForm
 TtfwClassRef.Register(TvcmEntityForm);
{$IfEnd} //not NoScripts AND not NoVCM

end.