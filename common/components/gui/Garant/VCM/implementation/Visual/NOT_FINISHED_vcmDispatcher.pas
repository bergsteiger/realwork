unit NOT_FINISHED_vcmDispatcher;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\NOT_FINISHED_vcmDispatcher.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmDispatcher" MUID: (57D2C1600360)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBase
 , vcmFormDispatcherInterfaces
 , vcmInterfaces
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmExternalInterfaces
 , l3Core
;

type
 TvcmDispatcher = class(TvcmCacheableBase, IvcmFormDispatcherNotify, IvcmDispatcher, IvcmFormDispatcher)
  protected
   procedure AddListener(const aListener: IvcmFormDispatcherListener);
   procedure RemoveListener(const aListener: IvcmFormDispatcherListener);
   procedure AddForm(const aForm: IvcmEntityForm);
    {* добавить новую форму в приложение }
   procedure RemoveForm(const aForm: IvcmEntityForm);
    {* удалить форму из приложения }
   procedure ShowMainForm(const aForm: IvcmEntityForm);
    {* показать главную форму }
   procedure Lock;
   procedure UnLock;
   procedure BackupLockStatus;
   procedure RestoreLockStatus;
   function FindForm(const aGUID: TGUID;
    out theForm: IvcmEntityForm): Boolean;
   procedure AddFormForInvalidate(const aForm: IvcmEntityForm);
   procedure AddControlForInvalidate(aControl: TObject);
   procedure AddFormForUpdateActions(const aForm: IvcmEntityForm);
   procedure AddDockManager(const aDockManager: IDockManager);
   procedure AddLockListener(const aListener: IvcmLockListener);
   procedure RemoveLockListener(const aListener: IvcmLockListener);
   procedure UpdateMainCaption(const aForm: IvcmEntityForm = nil);
   procedure AddToCloseQueue(const aForm: IvcmEntityForm);
   procedure PlaceNewMainForm(aSource: TCustomForm;
    aNew: TCustomForm);
    {* разместить новую главную форму.
             aSourceMainForm:
               - форма на которой вызвали создание новой }
   procedure StartNewMainForm;
    {* вызывается перед началом создания главной формы }
   function Get_Locked: Boolean;
   function Get_MainFormsCount: Integer;
   function Get_MainForm(anIndex: Integer): IvcmEntityForm;
   function Get_CurrentMainForm: IvcmEntityForm;
   function Get_Notify: IvcmFormDispatcherNotify;
   procedure BeginRestoreAllSettings;
   procedure EndRestoreAllSettings;
   procedure RestoreFormSize;
    {* перечитывает размер компонентов на форме (восстанавливает сначала
             размеры Design-Time, потом читает из настроек) }
   procedure ReloadAllToolbars;
    {* перезагружает информацию toolbar-ов у всех открытых в данный момент
             форм }
   function EntityOperation(const anOp: TvcmOPID;
    const aParams: IvcmExecuteParams): Boolean; overload;
   procedure EntityOperation(const anOp: TvcmOPID;
    const aParams: IvcmTestParams); overload;
   {$If NOT Defined(DesignTimeLibrary)}
   procedure EntityOperationBroadcast(const anOp: TvcmOPID;
    const aParams: IvcmExecuteParams);
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure CallModuleOperation(const anOp: TvcmMOPID;
    const aParams: IvcmExecuteParams);
    {* Выполняет операцию модуля. (!) Только для вызова изнутри VCM. Не для использования на формах }
   procedure ModuleOperation(const anOp: TvcmMOPID;
    const aParams: IvcmTestParams); overload;
    {* выполняет операцию модуля }
   function ModuleOperation(const anOp: TvcmMOPID): Boolean; overload;
    {* выполняет операцию модуля }
   function GetModuleByID(aModuleID: TvcmControlID): IvcmModule;
    {* возвращает модуль по идентификатору }
   function Get_Module(anIndex: Integer): IvcmModule;
   procedure UpdateStatus;
   procedure AddAggregate(const anAggregate: IvcmAggregate);
   procedure RemoveAggregate(const anAggregate: IvcmAggregate);
   function FindAggregate(const aGUID: TGUID;
    out theAggregate: IvcmAggregate): Boolean;
   procedure StoreFocus;
   procedure RestoreFocus;
   procedure BeginOp(anInternal: Boolean = False);
   procedure EndOp;
   procedure StoreFocused(aHandle: THandle);
   function InOp(anInternal: Boolean = False): Boolean;
   procedure BeginCancelModal;
   procedure EndCancelModal;
   function InCancelModal: Boolean;
   procedure LockCursor;
   procedure UnlockCursor;
   procedure LockActionUpdate;
   procedure UnlockActionUpdate;
    {* блокировать OnTest-ы операций. Необходимо когда система находится в
             переходном состоянии и не все данные актуальны }
   procedure AddObjectForFree(O: TObject);
   procedure ReinsertForms;
    {* перечитывает значения форм }
   procedure TileWindowsHorizontal(const aForms: IvcmEntityFormsIterable = nil);
    {* упорядочить открытые окна приложения горизонтально }
   procedure TileWindowsVertical(const aForms: IvcmEntityFormsIterable = nil);
    {* упорядочить открытые окна приложения ветикально }
   procedure CascadeWindows(const aForms: IvcmEntityFormsIterable = nil);
    {* расположить открытые окна каскадом }
   procedure CloseAllWindows(const aForms: IvcmEntityFormsIterable = nil;
    const aCurrent: IvcmEntityForm = nil);
    {* закрыть все открытые окна кроме текущего, если он не указан, то закрывается приложение }
   function Get_FormDispatcher: IvcmFormDispatcher;
   function Get_History: IvcmHistory;
   function Get_ActiveEntity: IvcmEntity;
   function Get_ModulesCount: Integer;
   function Get_EntitiesCount: Integer;
   function Get_Entity(anIndex: Integer): IvcmEntity;
   function Get_IsRestoringAllSettings: Boolean;
   function Get_InClosingAllWindows: Boolean;
   function pm_GetIsLockActionUpdate: Boolean;
   function pm_GetMainFormProvider: IvcmMainFormProvider;
   procedure pm_SetMainFormProvider(const aValue: IvcmMainFormProvider);
   procedure LockInOp;
    {* Игнорируем скобки BeginOp/EndOp }
   procedure UnlockInOp;
    {* Игнорируем скобки BeginOp/EndOp }
  public
   class function Instance: TvcmDispatcher;
    {* Метод получения экземпляра синглетона TvcmDispatcher }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TvcmDispatcher
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57D2C1600360impl_uses*
 //#UC END# *57D2C1600360impl_uses*
;

var g_TvcmDispatcher: TvcmDispatcher = nil;
 {* Экземпляр синглетона TvcmDispatcher }

procedure TvcmDispatcherFree;
 {* Метод освобождения экземпляра синглетона TvcmDispatcher }
begin
 l3Free(g_TvcmDispatcher);
end;//TvcmDispatcherFree

procedure TvcmDispatcher.AddListener(const aListener: IvcmFormDispatcherListener);
//#UC START# *4992FC34014C_57D2C1600360_var*
//#UC END# *4992FC34014C_57D2C1600360_var*
begin
//#UC START# *4992FC34014C_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *4992FC34014C_57D2C1600360_impl*
end;//TvcmDispatcher.AddListener

procedure TvcmDispatcher.RemoveListener(const aListener: IvcmFormDispatcherListener);
//#UC START# *4992FC420063_57D2C1600360_var*
//#UC END# *4992FC420063_57D2C1600360_var*
begin
//#UC START# *4992FC420063_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *4992FC420063_57D2C1600360_impl*
end;//TvcmDispatcher.RemoveListener

procedure TvcmDispatcher.AddForm(const aForm: IvcmEntityForm);
 {* добавить новую форму в приложение }
//#UC START# *499556690347_57D2C1600360_var*
//#UC END# *499556690347_57D2C1600360_var*
begin
//#UC START# *499556690347_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *499556690347_57D2C1600360_impl*
end;//TvcmDispatcher.AddForm

procedure TvcmDispatcher.RemoveForm(const aForm: IvcmEntityForm);
 {* удалить форму из приложения }
//#UC START# *499556780259_57D2C1600360_var*
//#UC END# *499556780259_57D2C1600360_var*
begin
//#UC START# *499556780259_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *499556780259_57D2C1600360_impl*
end;//TvcmDispatcher.RemoveForm

procedure TvcmDispatcher.ShowMainForm(const aForm: IvcmEntityForm);
 {* показать главную форму }
//#UC START# *49955685037A_57D2C1600360_var*
//#UC END# *49955685037A_57D2C1600360_var*
begin
//#UC START# *49955685037A_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955685037A_57D2C1600360_impl*
end;//TvcmDispatcher.ShowMainForm

procedure TvcmDispatcher.Lock;
//#UC START# *49955692026A_57D2C1600360_var*
//#UC END# *49955692026A_57D2C1600360_var*
begin
//#UC START# *49955692026A_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955692026A_57D2C1600360_impl*
end;//TvcmDispatcher.Lock

procedure TvcmDispatcher.UnLock;
//#UC START# *4995569D0097_57D2C1600360_var*
//#UC END# *4995569D0097_57D2C1600360_var*
begin
//#UC START# *4995569D0097_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995569D0097_57D2C1600360_impl*
end;//TvcmDispatcher.UnLock

procedure TvcmDispatcher.BackupLockStatus;
//#UC START# *499556A40146_57D2C1600360_var*
//#UC END# *499556A40146_57D2C1600360_var*
begin
//#UC START# *499556A40146_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *499556A40146_57D2C1600360_impl*
end;//TvcmDispatcher.BackupLockStatus

procedure TvcmDispatcher.RestoreLockStatus;
//#UC START# *499556AB022F_57D2C1600360_var*
//#UC END# *499556AB022F_57D2C1600360_var*
begin
//#UC START# *499556AB022F_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *499556AB022F_57D2C1600360_impl*
end;//TvcmDispatcher.RestoreLockStatus

function TvcmDispatcher.FindForm(const aGUID: TGUID;
 out theForm: IvcmEntityForm): Boolean;
//#UC START# *499556DB01E8_57D2C1600360_var*
//#UC END# *499556DB01E8_57D2C1600360_var*
begin
//#UC START# *499556DB01E8_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *499556DB01E8_57D2C1600360_impl*
end;//TvcmDispatcher.FindForm

procedure TvcmDispatcher.AddFormForInvalidate(const aForm: IvcmEntityForm);
//#UC START# *499556EB0036_57D2C1600360_var*
//#UC END# *499556EB0036_57D2C1600360_var*
begin
//#UC START# *499556EB0036_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *499556EB0036_57D2C1600360_impl*
end;//TvcmDispatcher.AddFormForInvalidate

procedure TvcmDispatcher.AddControlForInvalidate(aControl: TObject);
//#UC START# *499556F601B0_57D2C1600360_var*
//#UC END# *499556F601B0_57D2C1600360_var*
begin
//#UC START# *499556F601B0_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *499556F601B0_57D2C1600360_impl*
end;//TvcmDispatcher.AddControlForInvalidate

procedure TvcmDispatcher.AddFormForUpdateActions(const aForm: IvcmEntityForm);
//#UC START# *499556FF01CD_57D2C1600360_var*
//#UC END# *499556FF01CD_57D2C1600360_var*
begin
//#UC START# *499556FF01CD_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *499556FF01CD_57D2C1600360_impl*
end;//TvcmDispatcher.AddFormForUpdateActions

procedure TvcmDispatcher.AddDockManager(const aDockManager: IDockManager);
//#UC START# *4995570A03CD_57D2C1600360_var*
//#UC END# *4995570A03CD_57D2C1600360_var*
begin
//#UC START# *4995570A03CD_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995570A03CD_57D2C1600360_impl*
end;//TvcmDispatcher.AddDockManager

procedure TvcmDispatcher.AddLockListener(const aListener: IvcmLockListener);
//#UC START# *4995574300E4_57D2C1600360_var*
//#UC END# *4995574300E4_57D2C1600360_var*
begin
//#UC START# *4995574300E4_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995574300E4_57D2C1600360_impl*
end;//TvcmDispatcher.AddLockListener

procedure TvcmDispatcher.RemoveLockListener(const aListener: IvcmLockListener);
//#UC START# *4995574D03DB_57D2C1600360_var*
//#UC END# *4995574D03DB_57D2C1600360_var*
begin
//#UC START# *4995574D03DB_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995574D03DB_57D2C1600360_impl*
end;//TvcmDispatcher.RemoveLockListener

procedure TvcmDispatcher.UpdateMainCaption(const aForm: IvcmEntityForm = nil);
//#UC START# *4995575803B1_57D2C1600360_var*
//#UC END# *4995575803B1_57D2C1600360_var*
begin
//#UC START# *4995575803B1_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995575803B1_57D2C1600360_impl*
end;//TvcmDispatcher.UpdateMainCaption

procedure TvcmDispatcher.AddToCloseQueue(const aForm: IvcmEntityForm);
//#UC START# *4995576100AD_57D2C1600360_var*
//#UC END# *4995576100AD_57D2C1600360_var*
begin
//#UC START# *4995576100AD_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995576100AD_57D2C1600360_impl*
end;//TvcmDispatcher.AddToCloseQueue

procedure TvcmDispatcher.PlaceNewMainForm(aSource: TCustomForm;
 aNew: TCustomForm);
 {* разместить новую главную форму.
             aSourceMainForm:
               - форма на которой вызвали создание новой }
//#UC START# *4995576B03B9_57D2C1600360_var*
//#UC END# *4995576B03B9_57D2C1600360_var*
begin
//#UC START# *4995576B03B9_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995576B03B9_57D2C1600360_impl*
end;//TvcmDispatcher.PlaceNewMainForm

procedure TvcmDispatcher.StartNewMainForm;
 {* вызывается перед началом создания главной формы }
//#UC START# *4995577F0221_57D2C1600360_var*
//#UC END# *4995577F0221_57D2C1600360_var*
begin
//#UC START# *4995577F0221_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995577F0221_57D2C1600360_impl*
end;//TvcmDispatcher.StartNewMainForm

function TvcmDispatcher.Get_Locked: Boolean;
//#UC START# *499557920080_57D2C1600360get_var*
//#UC END# *499557920080_57D2C1600360get_var*
begin
//#UC START# *499557920080_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *499557920080_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_Locked

function TvcmDispatcher.Get_MainFormsCount: Integer;
//#UC START# *4995579C0176_57D2C1600360get_var*
//#UC END# *4995579C0176_57D2C1600360get_var*
begin
//#UC START# *4995579C0176_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995579C0176_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_MainFormsCount

function TvcmDispatcher.Get_MainForm(anIndex: Integer): IvcmEntityForm;
//#UC START# *499557FD02B8_57D2C1600360get_var*
//#UC END# *499557FD02B8_57D2C1600360get_var*
begin
//#UC START# *499557FD02B8_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *499557FD02B8_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_MainForm

function TvcmDispatcher.Get_CurrentMainForm: IvcmEntityForm;
//#UC START# *4995586301F3_57D2C1600360get_var*
//#UC END# *4995586301F3_57D2C1600360get_var*
begin
//#UC START# *4995586301F3_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4995586301F3_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_CurrentMainForm

function TvcmDispatcher.Get_Notify: IvcmFormDispatcherNotify;
//#UC START# *499558A30052_57D2C1600360get_var*
//#UC END# *499558A30052_57D2C1600360get_var*
begin
//#UC START# *499558A30052_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *499558A30052_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_Notify

procedure TvcmDispatcher.BeginRestoreAllSettings;
//#UC START# *49955B59006C_57D2C1600360_var*
//#UC END# *49955B59006C_57D2C1600360_var*
begin
//#UC START# *49955B59006C_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955B59006C_57D2C1600360_impl*
end;//TvcmDispatcher.BeginRestoreAllSettings

procedure TvcmDispatcher.EndRestoreAllSettings;
//#UC START# *49955B620344_57D2C1600360_var*
//#UC END# *49955B620344_57D2C1600360_var*
begin
//#UC START# *49955B620344_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955B620344_57D2C1600360_impl*
end;//TvcmDispatcher.EndRestoreAllSettings

procedure TvcmDispatcher.RestoreFormSize;
 {* перечитывает размер компонентов на форме (восстанавливает сначала
             размеры Design-Time, потом читает из настроек) }
//#UC START# *49955B6C0227_57D2C1600360_var*
//#UC END# *49955B6C0227_57D2C1600360_var*
begin
//#UC START# *49955B6C0227_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955B6C0227_57D2C1600360_impl*
end;//TvcmDispatcher.RestoreFormSize

procedure TvcmDispatcher.ReloadAllToolbars;
 {* перезагружает информацию toolbar-ов у всех открытых в данный момент
             форм }
//#UC START# *49955B7A0097_57D2C1600360_var*
//#UC END# *49955B7A0097_57D2C1600360_var*
begin
//#UC START# *49955B7A0097_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955B7A0097_57D2C1600360_impl*
end;//TvcmDispatcher.ReloadAllToolbars

function TvcmDispatcher.EntityOperation(const anOp: TvcmOPID;
 const aParams: IvcmExecuteParams): Boolean;
//#UC START# *49955B9502D1_57D2C1600360_var*
//#UC END# *49955B9502D1_57D2C1600360_var*
begin
//#UC START# *49955B9502D1_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955B9502D1_57D2C1600360_impl*
end;//TvcmDispatcher.EntityOperation

procedure TvcmDispatcher.EntityOperation(const anOp: TvcmOPID;
 const aParams: IvcmTestParams);
//#UC START# *49955BA801FD_57D2C1600360_var*
//#UC END# *49955BA801FD_57D2C1600360_var*
begin
//#UC START# *49955BA801FD_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955BA801FD_57D2C1600360_impl*
end;//TvcmDispatcher.EntityOperation

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmDispatcher.EntityOperationBroadcast(const anOp: TvcmOPID;
 const aParams: IvcmExecuteParams);
//#UC START# *49955BCE010F_57D2C1600360_var*
//#UC END# *49955BCE010F_57D2C1600360_var*
begin
//#UC START# *49955BCE010F_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955BCE010F_57D2C1600360_impl*
end;//TvcmDispatcher.EntityOperationBroadcast
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure TvcmDispatcher.CallModuleOperation(const anOp: TvcmMOPID;
 const aParams: IvcmExecuteParams);
 {* Выполняет операцию модуля. (!) Только для вызова изнутри VCM. Не для использования на формах }
//#UC START# *49955BF8022D_57D2C1600360_var*
//#UC END# *49955BF8022D_57D2C1600360_var*
begin
//#UC START# *49955BF8022D_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955BF8022D_57D2C1600360_impl*
end;//TvcmDispatcher.CallModuleOperation

procedure TvcmDispatcher.ModuleOperation(const anOp: TvcmMOPID;
 const aParams: IvcmTestParams);
 {* выполняет операцию модуля }
//#UC START# *49955C0B02AB_57D2C1600360_var*
//#UC END# *49955C0B02AB_57D2C1600360_var*
begin
//#UC START# *49955C0B02AB_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955C0B02AB_57D2C1600360_impl*
end;//TvcmDispatcher.ModuleOperation

function TvcmDispatcher.ModuleOperation(const anOp: TvcmMOPID): Boolean;
 {* выполняет операцию модуля }
//#UC START# *49955C220255_57D2C1600360_var*
//#UC END# *49955C220255_57D2C1600360_var*
begin
//#UC START# *49955C220255_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955C220255_57D2C1600360_impl*
end;//TvcmDispatcher.ModuleOperation

function TvcmDispatcher.GetModuleByID(aModuleID: TvcmControlID): IvcmModule;
 {* возвращает модуль по идентификатору }
//#UC START# *49955C5101F1_57D2C1600360_var*
//#UC END# *49955C5101F1_57D2C1600360_var*
begin
//#UC START# *49955C5101F1_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955C5101F1_57D2C1600360_impl*
end;//TvcmDispatcher.GetModuleByID

function TvcmDispatcher.Get_Module(anIndex: Integer): IvcmModule;
//#UC START# *49955C970119_57D2C1600360get_var*
//#UC END# *49955C970119_57D2C1600360get_var*
begin
//#UC START# *49955C970119_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955C970119_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_Module

procedure TvcmDispatcher.UpdateStatus;
//#UC START# *49955D45017B_57D2C1600360_var*
//#UC END# *49955D45017B_57D2C1600360_var*
begin
//#UC START# *49955D45017B_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955D45017B_57D2C1600360_impl*
end;//TvcmDispatcher.UpdateStatus

procedure TvcmDispatcher.AddAggregate(const anAggregate: IvcmAggregate);
//#UC START# *49955D4F01FD_57D2C1600360_var*
//#UC END# *49955D4F01FD_57D2C1600360_var*
begin
//#UC START# *49955D4F01FD_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955D4F01FD_57D2C1600360_impl*
end;//TvcmDispatcher.AddAggregate

procedure TvcmDispatcher.RemoveAggregate(const anAggregate: IvcmAggregate);
//#UC START# *49955D5802B2_57D2C1600360_var*
//#UC END# *49955D5802B2_57D2C1600360_var*
begin
//#UC START# *49955D5802B2_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955D5802B2_57D2C1600360_impl*
end;//TvcmDispatcher.RemoveAggregate

function TvcmDispatcher.FindAggregate(const aGUID: TGUID;
 out theAggregate: IvcmAggregate): Boolean;
//#UC START# *49955D660174_57D2C1600360_var*
//#UC END# *49955D660174_57D2C1600360_var*
begin
//#UC START# *49955D660174_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955D660174_57D2C1600360_impl*
end;//TvcmDispatcher.FindAggregate

procedure TvcmDispatcher.StoreFocus;
//#UC START# *49955D9E0380_57D2C1600360_var*
//#UC END# *49955D9E0380_57D2C1600360_var*
begin
//#UC START# *49955D9E0380_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955D9E0380_57D2C1600360_impl*
end;//TvcmDispatcher.StoreFocus

procedure TvcmDispatcher.RestoreFocus;
//#UC START# *49955DA6004C_57D2C1600360_var*
//#UC END# *49955DA6004C_57D2C1600360_var*
begin
//#UC START# *49955DA6004C_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955DA6004C_57D2C1600360_impl*
end;//TvcmDispatcher.RestoreFocus

procedure TvcmDispatcher.BeginOp(anInternal: Boolean = False);
//#UC START# *49955DB3020D_57D2C1600360_var*
//#UC END# *49955DB3020D_57D2C1600360_var*
begin
//#UC START# *49955DB3020D_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955DB3020D_57D2C1600360_impl*
end;//TvcmDispatcher.BeginOp

procedure TvcmDispatcher.EndOp;
//#UC START# *49955DBB03AC_57D2C1600360_var*
//#UC END# *49955DBB03AC_57D2C1600360_var*
begin
//#UC START# *49955DBB03AC_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955DBB03AC_57D2C1600360_impl*
end;//TvcmDispatcher.EndOp

procedure TvcmDispatcher.StoreFocused(aHandle: THandle);
//#UC START# *49955E2101A7_57D2C1600360_var*
//#UC END# *49955E2101A7_57D2C1600360_var*
begin
//#UC START# *49955E2101A7_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E2101A7_57D2C1600360_impl*
end;//TvcmDispatcher.StoreFocused

function TvcmDispatcher.InOp(anInternal: Boolean = False): Boolean;
//#UC START# *49955E2902C1_57D2C1600360_var*
//#UC END# *49955E2902C1_57D2C1600360_var*
begin
//#UC START# *49955E2902C1_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E2902C1_57D2C1600360_impl*
end;//TvcmDispatcher.InOp

procedure TvcmDispatcher.BeginCancelModal;
//#UC START# *49955E3100CE_57D2C1600360_var*
//#UC END# *49955E3100CE_57D2C1600360_var*
begin
//#UC START# *49955E3100CE_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E3100CE_57D2C1600360_impl*
end;//TvcmDispatcher.BeginCancelModal

procedure TvcmDispatcher.EndCancelModal;
//#UC START# *49955E380234_57D2C1600360_var*
//#UC END# *49955E380234_57D2C1600360_var*
begin
//#UC START# *49955E380234_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E380234_57D2C1600360_impl*
end;//TvcmDispatcher.EndCancelModal

function TvcmDispatcher.InCancelModal: Boolean;
//#UC START# *49955E4101C4_57D2C1600360_var*
//#UC END# *49955E4101C4_57D2C1600360_var*
begin
//#UC START# *49955E4101C4_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E4101C4_57D2C1600360_impl*
end;//TvcmDispatcher.InCancelModal

procedure TvcmDispatcher.LockCursor;
//#UC START# *49955E4B0045_57D2C1600360_var*
//#UC END# *49955E4B0045_57D2C1600360_var*
begin
//#UC START# *49955E4B0045_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E4B0045_57D2C1600360_impl*
end;//TvcmDispatcher.LockCursor

procedure TvcmDispatcher.UnlockCursor;
//#UC START# *49955E510310_57D2C1600360_var*
//#UC END# *49955E510310_57D2C1600360_var*
begin
//#UC START# *49955E510310_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E510310_57D2C1600360_impl*
end;//TvcmDispatcher.UnlockCursor

procedure TvcmDispatcher.LockActionUpdate;
//#UC START# *49955E5A013E_57D2C1600360_var*
//#UC END# *49955E5A013E_57D2C1600360_var*
begin
//#UC START# *49955E5A013E_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E5A013E_57D2C1600360_impl*
end;//TvcmDispatcher.LockActionUpdate

procedure TvcmDispatcher.UnlockActionUpdate;
 {* блокировать OnTest-ы операций. Необходимо когда система находится в
             переходном состоянии и не все данные актуальны }
//#UC START# *49955E600354_57D2C1600360_var*
//#UC END# *49955E600354_57D2C1600360_var*
begin
//#UC START# *49955E600354_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E600354_57D2C1600360_impl*
end;//TvcmDispatcher.UnlockActionUpdate

procedure TvcmDispatcher.AddObjectForFree(O: TObject);
//#UC START# *49955E870182_57D2C1600360_var*
//#UC END# *49955E870182_57D2C1600360_var*
begin
//#UC START# *49955E870182_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E870182_57D2C1600360_impl*
end;//TvcmDispatcher.AddObjectForFree

procedure TvcmDispatcher.ReinsertForms;
 {* перечитывает значения форм }
//#UC START# *49955E9001A4_57D2C1600360_var*
//#UC END# *49955E9001A4_57D2C1600360_var*
begin
//#UC START# *49955E9001A4_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E9001A4_57D2C1600360_impl*
end;//TvcmDispatcher.ReinsertForms

procedure TvcmDispatcher.TileWindowsHorizontal(const aForms: IvcmEntityFormsIterable = nil);
 {* упорядочить открытые окна приложения горизонтально }
//#UC START# *49955E9F00CF_57D2C1600360_var*
//#UC END# *49955E9F00CF_57D2C1600360_var*
begin
//#UC START# *49955E9F00CF_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955E9F00CF_57D2C1600360_impl*
end;//TvcmDispatcher.TileWindowsHorizontal

procedure TvcmDispatcher.TileWindowsVertical(const aForms: IvcmEntityFormsIterable = nil);
 {* упорядочить открытые окна приложения ветикально }
//#UC START# *49955EAD0266_57D2C1600360_var*
//#UC END# *49955EAD0266_57D2C1600360_var*
begin
//#UC START# *49955EAD0266_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955EAD0266_57D2C1600360_impl*
end;//TvcmDispatcher.TileWindowsVertical

procedure TvcmDispatcher.CascadeWindows(const aForms: IvcmEntityFormsIterable = nil);
 {* расположить открытые окна каскадом }
//#UC START# *49955EBA00EB_57D2C1600360_var*
//#UC END# *49955EBA00EB_57D2C1600360_var*
begin
//#UC START# *49955EBA00EB_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955EBA00EB_57D2C1600360_impl*
end;//TvcmDispatcher.CascadeWindows

procedure TvcmDispatcher.CloseAllWindows(const aForms: IvcmEntityFormsIterable = nil;
 const aCurrent: IvcmEntityForm = nil);
 {* закрыть все открытые окна кроме текущего, если он не указан, то закрывается приложение }
//#UC START# *49955EC80182_57D2C1600360_var*
//#UC END# *49955EC80182_57D2C1600360_var*
begin
//#UC START# *49955EC80182_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955EC80182_57D2C1600360_impl*
end;//TvcmDispatcher.CloseAllWindows

function TvcmDispatcher.Get_FormDispatcher: IvcmFormDispatcher;
//#UC START# *49955EE6038B_57D2C1600360get_var*
//#UC END# *49955EE6038B_57D2C1600360get_var*
begin
//#UC START# *49955EE6038B_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955EE6038B_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_FormDispatcher

function TvcmDispatcher.Get_History: IvcmHistory;
//#UC START# *49955F0C0129_57D2C1600360get_var*
//#UC END# *49955F0C0129_57D2C1600360get_var*
begin
//#UC START# *49955F0C0129_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955F0C0129_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_History

function TvcmDispatcher.Get_ActiveEntity: IvcmEntity;
//#UC START# *49955F3902F7_57D2C1600360get_var*
//#UC END# *49955F3902F7_57D2C1600360get_var*
begin
//#UC START# *49955F3902F7_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955F3902F7_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_ActiveEntity

function TvcmDispatcher.Get_ModulesCount: Integer;
//#UC START# *49955F6202E0_57D2C1600360get_var*
//#UC END# *49955F6202E0_57D2C1600360get_var*
begin
//#UC START# *49955F6202E0_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955F6202E0_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_ModulesCount

function TvcmDispatcher.Get_EntitiesCount: Integer;
//#UC START# *49955F8302CE_57D2C1600360get_var*
//#UC END# *49955F8302CE_57D2C1600360get_var*
begin
//#UC START# *49955F8302CE_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955F8302CE_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_EntitiesCount

function TvcmDispatcher.Get_Entity(anIndex: Integer): IvcmEntity;
//#UC START# *49955F930093_57D2C1600360get_var*
//#UC END# *49955F930093_57D2C1600360get_var*
begin
//#UC START# *49955F930093_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955F930093_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_Entity

function TvcmDispatcher.Get_IsRestoringAllSettings: Boolean;
//#UC START# *49955FB00036_57D2C1600360get_var*
//#UC END# *49955FB00036_57D2C1600360get_var*
begin
//#UC START# *49955FB00036_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955FB00036_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_IsRestoringAllSettings

function TvcmDispatcher.Get_InClosingAllWindows: Boolean;
//#UC START# *49955FBF02AD_57D2C1600360get_var*
//#UC END# *49955FBF02AD_57D2C1600360get_var*
begin
//#UC START# *49955FBF02AD_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955FBF02AD_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_InClosingAllWindows

function TvcmDispatcher.pm_GetIsLockActionUpdate: Boolean;
//#UC START# *49955FCE02AF_57D2C1600360get_var*
//#UC END# *49955FCE02AF_57D2C1600360get_var*
begin
//#UC START# *49955FCE02AF_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *49955FCE02AF_57D2C1600360get_impl*
end;//TvcmDispatcher.pm_GetIsLockActionUpdate

function TvcmDispatcher.pm_GetMainFormProvider: IvcmMainFormProvider;
//#UC START# *5461E0570220_57D2C1600360get_var*
//#UC END# *5461E0570220_57D2C1600360get_var*
begin
//#UC START# *5461E0570220_57D2C1600360get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5461E0570220_57D2C1600360get_impl*
end;//TvcmDispatcher.pm_GetMainFormProvider

procedure TvcmDispatcher.pm_SetMainFormProvider(const aValue: IvcmMainFormProvider);
//#UC START# *5461E0570220_57D2C1600360set_var*
//#UC END# *5461E0570220_57D2C1600360set_var*
begin
//#UC START# *5461E0570220_57D2C1600360set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5461E0570220_57D2C1600360set_impl*
end;//TvcmDispatcher.pm_SetMainFormProvider

procedure TvcmDispatcher.LockInOp;
 {* Игнорируем скобки BeginOp/EndOp }
//#UC START# *558A86490317_57D2C1600360_var*
//#UC END# *558A86490317_57D2C1600360_var*
begin
//#UC START# *558A86490317_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *558A86490317_57D2C1600360_impl*
end;//TvcmDispatcher.LockInOp

procedure TvcmDispatcher.UnlockInOp;
 {* Игнорируем скобки BeginOp/EndOp }
//#UC START# *558A86710146_57D2C1600360_var*
//#UC END# *558A86710146_57D2C1600360_var*
begin
//#UC START# *558A86710146_57D2C1600360_impl*
 !!! Needs to be implemented !!!
//#UC END# *558A86710146_57D2C1600360_impl*
end;//TvcmDispatcher.UnlockInOp

class function TvcmDispatcher.Instance: TvcmDispatcher;
 {* Метод получения экземпляра синглетона TvcmDispatcher }
begin
 if (g_TvcmDispatcher = nil) then
 begin
  l3System.AddExitProc(TvcmDispatcherFree);
  g_TvcmDispatcher := Create;
 end;
 Result := g_TvcmDispatcher;
end;//TvcmDispatcher.Instance

class function TvcmDispatcher.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmDispatcher <> nil;
end;//TvcmDispatcher.Exists
{$IfEnd} // NOT Defined(NoVCM)

end.
