unit vcmDispatcher;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmDispatcher.pas"
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
 , vcmMainForm
 , vcmIEntityList
 , vcmIEntityFormPtrList
 , vcmDockManagerList
 , vcmLockListenerList
 , vcmFormDispatcherListenerList
 , vcmAggregateRefList
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , Windows
 , Types
 , vcmExternalInterfaces
 , vcmUserControls
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Core
;

type
 PvcmTileWindowType = ^TvcmTileWindowType;

 TvcmTileWindowType = (
  {* тип размещения окон (горизонтально, вертикально). }
  vcm_twHorizontal
  , vcm_twVertical
 );//TvcmTileWindowType

 TvcmLockNotify = (
  {* типы уведомления о блокировке\разблокировке действий. }
  vcm_lnLock
   {* работа с визуалкой заблокирована; }
  , vcm_lnBeforeUnlock
   {* здесь мы можем обновлять данные, переходные процессы закончились, но визуалка ещё не рисуется; }
  , vcm_lnUnlock
   {* здесь уже можно рисоваться; }
 );//TvcmLockNotify

 TvcmDispatcher = class(TvcmCacheableBase, IvcmFormDispatcherNotify, IvcmDispatcher, IvcmFormDispatcher)
  private
   f_NeedUpdateMainCaption: Boolean;
   f_Entities: TvcmIEntityList;
   f_MainForms: TvcmIEntityFormPtrList;
   f_FormsForClose: TvcmIEntityFormPtrList;
   f_InvalidateForms: TvcmIEntityFormPtrList;
   f_UpdateForms: TvcmIEntityFormPtrList;
   f_ObjectsForFree: TvcmObjectList;
   f_InvalidateCtrls: TvcmLongintList;
    {* list of hwnds }
   f_SaveLockCounter: TvcmLongintList;
   f_DockManagers: TvcmDockManagerList;
   f_LockListeners: TvcmLockListenerList;
   f_FDListeners: TvcmFormDispatcherListenerList;
   f_Aggregates: TvcmAggregateRefList;
   f_Lock: Integer;
   f_CursorLock: Integer;
   f_StoredFocusLock: Integer;
   f_OldCursor: TCursor;
   f_Op: Integer;
   f_CancelModalLock: Integer;
   f_PrevFocused: THandle;
   f_RestoreAllSettings: Integer;
   f_ClosingAllWindows: Boolean;
   f_ActionUpdateCount: Integer;
   f_InternalOp: Boolean;
   f_NewMainFormBounds: TRect;
   f_NeedUpdateStatus: Boolean;
   f_UnlockProtection: Boolean;
   f_MainFormProvider: Pointer;
   f_LockInOpCount: Integer;
  private
   class function _GetMain(aForm: TCustomForm): TvcmMainForm;
  protected
   function pm_GetForm: TvcmMainForm;
   function Get_As_IvcmDispatcher: IvcmDispatcher;
   procedure LockNotify(aLock: TvcmLockNotify);
    {* рассылает нотификацию о блокировке\разблокировке действий на период выполнения операции модуля. }
   procedure PrepareWindows(const aForms: IvcmEntityFormsIterable = nil);
    {* подготавливает окна к упорядочиванию. }
   function GetCurrentMonitorRect: TRect;
   procedure TileWindows(aType: TvcmTileWindowType;
    const aForms: IvcmEntityFormsIterable = nil);
   procedure ArrangeAll(const aForms: IvcmEntityFormsIterable);
   procedure SetWindowPosition(aHandle: THandle;
    aLeft: Integer;
    aTop: Integer;
    aWidth: Integer;
    aHeight: Integer);
   procedure EntityOperation(const anOp: TvcmOPID;
    const aParams: IvcmParams;
    aMode: TvcmOperationMode); overload;
   procedure ModuleOperation(const anOp: TvcmMOPID;
    const aParams: IvcmParams;
    aMode: TvcmOperationMode); overload;
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
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Instance: TvcmDispatcher;
    {* Метод получения экземпляра синглетона TvcmDispatcher }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Form: TvcmMainForm
    read pm_GetForm;
   property Locked: Boolean
    read Get_Locked;
   property MainFormsCount: Integer
    read Get_MainFormsCount;
   property MainForm[anIndex: Integer]: IvcmEntityForm
    read Get_MainForm;
   property ActiveEntity: IvcmEntity
    read Get_ActiveEntity;
   property FormDispatcher: IvcmFormDispatcher
    read Get_FormDispatcher;
   property EntitiesCount: Integer
    read Get_EntitiesCount;
   property Entity[anIndex: Integer]: IvcmEntity
    read Get_Entity;
   property As_IvcmDispatcher: IvcmDispatcher
    read Get_As_IvcmDispatcher;
   property History: IvcmHistory
    read Get_History;
   property ModulesCount: Integer
    read Get_ModulesCount;
   property Module[anIndex: Integer]: IvcmModule
    read Get_Module;
 end;//TvcmDispatcher
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57D2C1600360impl_uses*
 , l3Types
 , vcmUtils
 , vcmBaseMenuManager
 , vcmMessages
 , vcmEntityForm
 , vcmForm
 , vcmContainerForm
 , vcmModule

 , vtPanel

 , afwFacade
 , afwInterfaces
 , Classes
 //#UC END# *57D2C1600360impl_uses*
;

var g_TvcmDispatcher: TvcmDispatcher = nil;
 {* Экземпляр синглетона TvcmDispatcher }

procedure TvcmDispatcherFree;
 {* Метод освобождения экземпляра синглетона TvcmDispatcher }
begin
 l3Free(g_TvcmDispatcher);
end;//TvcmDispatcherFree

function TvcmDispatcher.pm_GetForm: TvcmMainForm;
//#UC START# *57D67EBB000A_57D2C1600360get_var*
//#UC END# *57D67EBB000A_57D2C1600360get_var*
begin
//#UC START# *57D67EBB000A_57D2C1600360get_impl*
 Result := _GetMain(Screen.ActiveForm);
 if (Result = nil) then
  Result := _GetMain(Screen.ActiveCustomForm);
 if (Result = nil) then
  Result := _GetMain(Application.MainForm);
//#UC END# *57D67EBB000A_57D2C1600360get_impl*
end;//TvcmDispatcher.pm_GetForm

function TvcmDispatcher.Get_As_IvcmDispatcher: IvcmDispatcher;
//#UC START# *57D7E48D0247_57D2C1600360get_var*
//#UC END# *57D7E48D0247_57D2C1600360get_var*
begin
//#UC START# *57D7E48D0247_57D2C1600360get_impl*
 Result := Self;
//#UC END# *57D7E48D0247_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_As_IvcmDispatcher

procedure TvcmDispatcher.LockNotify(aLock: TvcmLockNotify);
 {* рассылает нотификацию о блокировке\разблокировке действий на период выполнения операции модуля. }
//#UC START# *57D68D5F02BF_57D2C1600360_var*
var
 l_Index: Integer;
//#UC END# *57D68D5F02BF_57D2C1600360_var*
begin
//#UC START# *57D68D5F02BF_57D2C1600360_impl*
 if (f_LockListeners <> nil) then
  with f_LockListeners do
  begin
   l_Index := Lo;
   while (l_Index <= Hi) do
   begin
    {$IfOpt D+}
    try
    {$EndIf}
     with Items[l_Index] do
      case aLock of
       vcm_lnLock: Lock;
       vcm_lnBeforeUnlock: BeforeUnlock;
       vcm_lnUnlock: UnLock;
      end;//case aLock of
    {$IfOpt D+}
    except
     // - падение - не повод замораживать всё приложение
     on E: Exception do
      l3System.Exception2Log(E);
    end;//try..except
    {$EndIf}
    Inc(l_Index);
   end;//while (l_Index <= Hi) do
  end;//with f_LockListeners do
//#UC END# *57D68D5F02BF_57D2C1600360_impl*
end;//TvcmDispatcher.LockNotify

procedure TvcmDispatcher.PrepareWindows(const aForms: IvcmEntityFormsIterable = nil);
 {* подготавливает окна к упорядочиванию. }
//#UC START# *57D68DA50138_57D2C1600360_var*
 function lp_DoPrepareWindow(anItem: PIvcmEntityForm; anIndex: Integer): Boolean;
 begin
  vcmDropConstraints(anItem^.VCLWinControl As TCustomForm);
  Result := True;
 end;//lp_DoPrepareWindow
//#UC END# *57D68DA50138_57D2C1600360_var*
begin
//#UC START# *57D68DA50138_57D2C1600360_impl*
 if (aForms <> nil) then
  aForms.IterateFormsF(l3L2IA(@lp_DoPrepareWindow))
 else
  f_MainForms.IterateAllF(l3L2IA(@lp_DoPrepareWindow));
//#UC END# *57D68DA50138_57D2C1600360_impl*
end;//TvcmDispatcher.PrepareWindows

function TvcmDispatcher.GetCurrentMonitorRect: TRect;
//#UC START# *57D68DE4037B_57D2C1600360_var*
//#UC END# *57D68DE4037B_57D2C1600360_var*
begin
//#UC START# *57D68DE4037B_57D2C1600360_impl*
 Result := Screen.MonitorFromPoint(Mouse.CursorPos).WorkareaRect;
//#UC END# *57D68DE4037B_57D2C1600360_impl*
end;//TvcmDispatcher.GetCurrentMonitorRect

procedure TvcmDispatcher.TileWindows(aType: TvcmTileWindowType;
 const aForms: IvcmEntityFormsIterable = nil);
//#UC START# *57D68E2100FB_57D2C1600360_var*
var
 l_Step: Integer;
 l_Monitor: TRect;
 l_Cursor: Integer;
 l_Width: Integer;
 l_Height: Integer;
 l_MainFormsCount: Integer;
 l_RestDiv : Integer;

 function lp_DoTileWindows(anItem: PIvcmEntityForm; anIndex: Integer): Boolean;
 var
  l_Form: IvcmEntityForm;
  l_FormHandle: HWND;
 begin
  l_Form := anItem^;
  try
   l_FormHandle := l_Form.VCLWinControl.Handle;
   // добавим остаток от деления
   if anIndex = Pred(l_MainFormsCount) then
    l_Step := l_Step + l_RestDiv;
   // установим позицию формы
   case aType of
    vcm_twHorizontal: SetWindowPosition(l_FormHandle, l_Monitor.Left, l_Cursor, l_Width, l_Step);
    vcm_twVertical: SetWindowPosition(l_FormHandle, l_Cursor, l_Monitor.Top, l_Step, l_Height);
   end;//case aType
   // положение следующего окна
   Inc(l_Cursor, l_Step);
   Result := True;
  finally
   l_Form := nil;
  end;//try..finally
 end;//lp_DoTileWindows

const
 TILE_COUNT = 3;
//#UC END# *57D68E2100FB_57D2C1600360_var*
begin
//#UC START# *57D68E2100FB_57D2C1600360_impl*
 PrepareWindows(aForms);
 if (aForms <> nil) then
  l_MainFormsCount := aForms.FormsCount
 else
  l_MainFormsCount := f_MainForms.Count;
 if (l_MainFormsCount > TILE_COUNT) then
  ArrangeAll(aForms)
 else
 begin
  l_Monitor := GetCurrentMonitorRect;
  l_Height  := l_Monitor.Bottom - l_Monitor.Top;
  l_Width   := l_Monitor.Right  - l_Monitor.Left;
  // высота/ширина формы
  if aType = vcm_twHorizontal then
  begin
   l_RestDiv := l_Height mod l_MainFormsCount;
   l_Step    := l_Height div l_MainFormsCount;
   l_Cursor  := l_Monitor.Top;
  end//aType = vcm_twHorizontal
  else
  begin
   l_RestDiv := l_Width mod l_MainFormsCount;
   l_Step    := l_Width div l_MainFormsCount;
   l_Cursor  := l_Monitor.Left;
  end;//aType = vcm_twHorizontal
  // установим размеры
  if (aForms <> nil) then
   aForms.IterateFormsF(l3L2IA(@lp_DoTileWindows))
  else
   f_MainForms.IterateAllF(l3L2IA(@lp_DoTileWindows));
 end;//f_MainForms.Count > TILE_COUNT
//#UC END# *57D68E2100FB_57D2C1600360_impl*
end;//TvcmDispatcher.TileWindows

procedure TvcmDispatcher.ArrangeAll(const aForms: IvcmEntityFormsIterable);
//#UC START# *57D68E6803A0_57D2C1600360_var*
const
 ROWS = 3;
var
 lAddHeight    : Integer;           
 lIndex        : Integer;
 lHeightRest   : Integer;
 lWindowsRest  : Integer;
 lWindowsInRow : Integer;
 lMonitor      : TRect;
 lScreenWidth  : Integer; // ширина экрана
 lScreenHeight : Integer; // высота экрана
 lWindowHeight : Integer; // высота всех форм на экране
 lCursor       : Integer; // текущая обрабатываемая форма, увеличивается после
                          // работы с формой

 function lp_GetForm(aIndex: Integer): IvcmEntityForm;
 var
  l_Form: IvcmEntityForm;

  function lp_DoGetForm(anItem: PIvcmEntityForm; anIndex: Integer): Boolean;
  begin
   if (anIndex = aIndex) then
   begin
    Result := False;
    l_Form := anItem^;
   end
   else
    Result := True;
  end;//lp_DoGetForm

 begin
  if (aForms <> nil) then
  begin
   l_Form := nil;
   aForms.IterateFormsF(l3L2IA(@lp_DoGetForm));
   Result := l_Form;
  end
  else
   Result := Get_MainForm(aIndex);
 end;//lp_GetForm

 procedure BuildRow(const aTop    : Integer;
                    const aHeight : Integer);
 var
  lRest        : Integer;
  lIndex       : Integer;
  lCount       : Integer;
  lAddHeight   : Integer;
  lWindowWidth : Integer;
 begin
  lAddHeight := 0;
  lCount := lWindowsInRow;
  if lWindowsRest > 0 then
  begin
   // мы забрали одну "лишнуюю" форму для отображения в нашей строке
   Dec(lWindowsRest);
   // в нашем столбце на одну форму будет больше
   Inc(lCount);
  end;
  // ширина формы в нашем столбце
  lWindowWidth := lScreenWidth div lCount;
  // остаток который отдадим последней форме
  lRest := lScreenWidth mod lCount;

  for lIndex := 0 to Pred(lCount) do
  begin
   // остаток
   if lIndex = Pred(lCount) then
    lAddHeight := lRest;
   // позиционируем
   SetWindowPosition(lp_GetForm(lCursor).VCLWinControl.Handle,
                     lMonitor.Left + lWindowWidth * lIndex, aTop,
                     lWindowWidth, aHeight + lAddHeight);
   Inc(lCursor);
  end;//for lIndex
 end;

var
 l_MainFormsCount: Integer;
//#UC END# *57D68E6803A0_57D2C1600360_var*
begin
//#UC START# *57D68E6803A0_57D2C1600360_impl*
 if (aForms <> nil) then
  l_MainFormsCount := aForms.FormsCount
 else
  l_MainFormsCount := f_MainForms.Count;
 PrepareWindows;
 // текущая форма
 lCursor := 0;
 lAddHeight := 0;
 // текущий монитор
 lMonitor := GetCurrentMonitorRect;
 lScreenWidth := (lMonitor.Right - lMonitor.Left);
 lScreenHeight := (lMonitor.Bottom - lMonitor.Top);
 // высота строк
 lWindowHeight := lScreenHeight div ROWS;
 // остаток окон
 lWindowsRest := l_MainFormsCount mod ROWS;
 // остаток высоты
 lHeightRest := lScreenHeight mod ROWS;
 // количество форм в строке
 lWindowsInRow := l_MainFormsCount div ROWS;
 // строим
 for lIndex := 0 to Pred(ROWS) do
 begin
  if lIndex = Pred(ROWS) then
   lAddHeight := lHeightRest;
  BuildRow(lWindowHeight * lIndex + lMonitor.Top, lWindowHeight + lAddHeight);
 end;
//#UC END# *57D68E6803A0_57D2C1600360_impl*
end;//TvcmDispatcher.ArrangeAll

procedure TvcmDispatcher.SetWindowPosition(aHandle: THandle;
 aLeft: Integer;
 aTop: Integer;
 aWidth: Integer;
 aHeight: Integer);
//#UC START# *57D68EAD027E_57D2C1600360_var*
var
 l_Placement: TWindowPlacement;
//#UC END# *57D68EAD027E_57D2C1600360_var*
begin
//#UC START# *57D68EAD027E_57D2C1600360_impl*
 l_Placement.Length := SizeOf(l_Placement);
 GetWindowPlacement(aHandle, @l_Placement);
 l_Placement.rcNormalPosition := Rect(aLeft, aTop, aLeft + aWidth, aTop + aHeight);
 l_Placement.showCmd := SW_SHOWNORMAL;
 SetWindowPlacement(aHandle, @l_Placement);
//#UC END# *57D68EAD027E_57D2C1600360_impl*
end;//TvcmDispatcher.SetWindowPosition

procedure TvcmDispatcher.EntityOperation(const anOp: TvcmOPID;
 const aParams: IvcmParams;
 aMode: TvcmOperationMode);
//#UC START# *57D6901B0325_57D2C1600360_var*
 function TranslateToContainerZone(const aCont : IvcmContainer;
                                   aZone       : TvcmZoneType) : Boolean;
 var
  l_Cont : IvcmContainer;
  l_Form : IvcmEntityForm;
  l_Entity : IvcmEntity;
 begin//TranslateToContainerZone
  Result := false;
  l_Cont := aCont;
  while (l_Cont <> nil) do
  begin
   l_Cont.HasForm(aZone, false, @l_Form);
   if (l_Form = nil) then
    break;

   l_Entity := l_Form.Entity;
   l_Entity.Operation(anOp, aParams, aMode);
   Case aMode of
   vcm_omTest :
    if aParams.Done then
    //if aParams.TestPart.Op.Flag[vcm_ofEnabled] then
    begin
     Result := true;
     break;
    end;//aParams.Done
   vcm_omExecute :
    begin
     if aParams.Done then
     begin
      Result := true;
      break;
     end;//aParams.Done 
    end;//vcm_omExecute
   end;//Case aMode

   if vcmIEQ(l_Form, l_Cont) then
    break;
   if (l_Form.VCLWinControl = l_Cont.AsForm.VCLWinControl) then
    break;
   l_Cont := l_Form.AsContainer;
   //Supports(l_Form, IvcmContainer, l_Cont);
  end;//while l_Cont <> nil
 end;//TranslateToContainerZone

var
 l_Entity      : IvcmEntity;
 l_Form        : IvcmEntityForm;
 l_WasDisabled : Boolean;
 l_MainFormCont : IvcmContainer;
 l_HasModal: Boolean;
//#UC END# *57D6901B0325_57D2C1600360_var*
begin
//#UC START# *57D6901B0325_57D2C1600360_impl*
 aParams.SetContainerPrim(Form, false);
 l_Entity := ActiveEntity;
 aParams.DoneStatus := vcm_dsNotDone;
 Case aMode of
  vcm_omTest :
   aParams.TestPart.Op.Flag[vcm_ofEnabled] := false;
 end;//Case aMode
 l_WasDisabled := false;
 l_HasModal := false;
 while (l_Entity <> nil) do
 begin
  l_Entity.Operation(anOp, aParams, aMode);
  Case aMode of
  vcm_omTest :
   if aParams.Done then
   //if aParams.TestPart.Op.Flag[vcm_ofEnabled] then
    break;
  vcm_omExecute :
   begin
    if aParams.Done then
     break;
   end;//vcm_omExecute
  end;//Case aMode
  if (aParams.DoneStatus = vcm_dsDisabled) then
   l_WasDisabled := true;
   // - операция типа есть, но запрещена
  l_Form := l_Entity.AsForm;
  if (l_Form <> nil) then
   try
    l_Entity := nil;
    l_HasModal := l_HasModal or l_Form.IsModal;
    if l_HasModal AND (aMode <> vcm_omTest) then
    begin
     Assert(l_Form.VCLWinControl.Visible, Format('Попытка выполнить операцию на невидимой модальной форме (%s), которая наверное закрывается. См. http://mdp.garant.ru/pages/viewpage.action?pageId=427756504&focusedCommentId=427759367#comment-427759367', [l_Form.VCLWinControl.Name]));
    end;//l_HasModal
    if (not l_Form.IsModal or (aMode = vcm_omTest)) AND
       not l_WasDisabled AND
       // - если САМА форма не модальная или тестируем операцию (cq24729), то надо передать операцию родителю
       Supports(afw.GetAnotherParentForm(l_Form.VCLWinControl), IvcmEntityForm, l_Form) then
     try
      l_Entity := l_Form.Entity;
     finally
      l_Form := nil;
     end;//try..finally
   finally
    l_Form := nil;
   end//try..finally
  else
   l_Entity := nil;
 end;//while (l_Entity <> nil)
 if (not l_HasModal) and (aParams.DoneStatus in [vcm_dsExcludedInUserType, vcm_dsNoEntity]) then
 begin
  if l_WasDisabled then
  begin
   // - операция запрещена, а вверх никого не нашли
   aParams.DoneStatus := vcm_dsDisabled;
   // - надо сообщить что ShortCut обрабатывать не надо
  end//l_WasDisabled
  else
  begin
  // - здесь пытаемся транслировать оперцию форме в Parent-зоне.
   if Supports(Get_CurrentMainForm, IvcmContainer, l_MainFormCont) then
   begin
    TranslateToContainerZone(l_MainFormCont, vcm_ztMainObjectForm);
    if not aParams.Done and (aParams.DoneStatus in [vcm_dsNoEntity]) then
    begin
    // - типа перенаправляем из баллона в основную форму
     if not l_MainFormCont.AsForm.Entity.Operation(anOp, aParams, aMode) then
     begin
      if not aParams.Done and (aParams.DoneStatus in [vcm_dsNoEntity]) then
      begin
       // - типа перенаправляем из баллона в его владельца
       l_Entity := ActiveEntity;
       l_Form := l_Entity.AsForm;
       if (l_Form <> nil) then
        if l_Form.IsBaloon then
         if Supports(l_Form.VCLWinControl.Owner, IvcmEntity, l_Entity) then
          l_Entity.Operation(anOp, aParams, aMode);
      end;//not aParams.Done and (aParams.DoneStatus in [vcm_dsNoEntity])
     end;//not l_MainFormCont.AsForm.Entity.Operation(anOp, aParams, aMode)
    end;//not aParams.Done and (aParams.DoneStatus in [vcm_dsNoEntity])
   end;//Supports(Get_CurrentMainForm, IvcmContainer, l_Cont)
  end;//l_WasDisabled
 end;//aParams.DoneStatus in [vcm_dsExcludedInUserType, vcm_dsNoEntity]
//#UC END# *57D6901B0325_57D2C1600360_impl*
end;//TvcmDispatcher.EntityOperation

procedure TvcmDispatcher.ModuleOperation(const anOp: TvcmMOPID;
 const aParams: IvcmParams;
 aMode: TvcmOperationMode);
//#UC START# *57D6908A0139_57D2C1600360_var*
var
 l_Module: IvcmModule;
//#UC END# *57D6908A0139_57D2C1600360_var*
begin
//#UC START# *57D6908A0139_57D2C1600360_impl*
 aParams.SetContainerPrim(Form, False);
 l_Module := GetModuleByID(anOp.rMoID);
 if (l_Module = nil) then
 begin
  case aMode of
   vcm_omTest: aParams.TestPart.Op.Flag[vcm_ofEnabled] := false;
   vcm_omExecute: aParams.DoneStatus := vcm_dsNotDone;
  end;//Case aMode
 end//l_Module = nil
 else
  l_Module.Operation(anOp.rOpID, aParams, aMode);
//#UC END# *57D6908A0139_57D2C1600360_impl*
end;//TvcmDispatcher.ModuleOperation

constructor TvcmDispatcher.Create;
//#UC START# *57D691730194_57D2C1600360_var*
//#UC END# *57D691730194_57D2C1600360_var*
begin
//#UC START# *57D691730194_57D2C1600360_impl*
 inherited Create;
 f_Entities := TvcmIEntityList.Make;
 f_MainForms := TvcmIEntityFormPtrList.Make;
 f_FormsForClose := TvcmIEntityFormPtrList.Make;
 f_ObjectsForFree := TvcmObjectList.Make;
 f_InvalidateForms := TvcmIEntityFormPtrList.Make;
 f_UpdateForms := TvcmIEntityFormPtrList.Make;
 f_InvalidateCtrls := TvcmLongintList.Make;
 f_DockManagers := TvcmDockManagerList.Make;
 f_LockListeners := TvcmLockListenerList.Make;
 f_RestoreAllSettings := 0;
 f_CursorLock := 0;
 f_Lock := 0;
 f_PrevFocused := 0;
 f_SaveLockCounter := TvcmLongintList.Make;
 f_StoredFocusLock := 0;
 f_ActionUpdateCount := 0;
 f_MainFormProvider := nil;
 f_LockInOpCount := 0;
//#UC END# *57D691730194_57D2C1600360_impl*
end;//TvcmDispatcher.Create

class function TvcmDispatcher._GetMain(aForm: TCustomForm): TvcmMainForm;
//#UC START# *57D6966401BF_57D2C1600360_var*
var
 l_Form: TCustomForm;
 l_Container: IafwMainFormContainer;
 l_CurrentMainForm: TCustomForm;
//#UC END# *57D6966401BF_57D2C1600360_var*
begin
//#UC START# *57D6966401BF_57D2C1600360_impl*
 Result := nil;
 l_Form := aForm;
 if Assigned(l_Form) and not (csDestroying in l_Form.ComponentState) then
  if Supports(l_Form, IafwMainFormContainer, l_Container) then
  try
   l_CurrentMainForm := l_Container.CurrentMainForm;
   if (l_CurrentMainForm <> nil) then
    Result := l_CurrentMainForm as TvcmMainForm
  finally
   l_Container := nil;
  end;//try..finally

 if (Result = nil) then
 begin
  while (l_Form <> nil) AND (Result = nil) do
   if (l_Form Is TvcmMainForm) then
    Result := TvcmMainForm(l_Form)
   else
    l_Form := afw.GetAnotherParentForm(l_Form);
  if (Result = nil) then
  begin
   l_Form := aForm;
   while (l_Form <> nil) AND (Result = nil) do
    if (l_Form Is TvcmMainForm) then
     Result := TvcmMainForm(l_Form)
    else
     l_Form := afw.GetParentForm(l_Form.Owner);
  end;//Result = nil
 end;
//#UC END# *57D6966401BF_57D2C1600360_impl*
end;//TvcmDispatcher._GetMain

procedure TvcmDispatcher.AddListener(const aListener: IvcmFormDispatcherListener);
//#UC START# *4992FC34014C_57D2C1600360_var*
var
 l_Index: Integer;
//#UC END# *4992FC34014C_57D2C1600360_var*
begin
//#UC START# *4992FC34014C_57D2C1600360_impl*
 if f_FDListeners = nil then
  f_FDListeners := TvcmFormDispatcherListenerList.Make;
 l_Index := f_FDListeners.IndexOf(aListener);
 if l_Index = -1 then
  f_FDListeners.Add(aListener);
//#UC END# *4992FC34014C_57D2C1600360_impl*
end;//TvcmDispatcher.AddListener

procedure TvcmDispatcher.RemoveListener(const aListener: IvcmFormDispatcherListener);
//#UC START# *4992FC420063_57D2C1600360_var*
//#UC END# *4992FC420063_57D2C1600360_var*
begin
//#UC START# *4992FC420063_57D2C1600360_impl*
 if f_FDListeners <> nil then
  f_FDListeners.Remove(aListener);
//#UC END# *4992FC420063_57D2C1600360_impl*
end;//TvcmDispatcher.RemoveListener

procedure TvcmDispatcher.AddForm(const aForm: IvcmEntityForm);
 {* добавить новую форму в приложение }
//#UC START# *499556690347_57D2C1600360_var*
var
 l_Main: TvcmMainForm;
 l_Index : Integer;
 l_Form : IvcmEntityForm;
//#UC END# *499556690347_57D2C1600360_var*
begin
//#UC START# *499556690347_57D2C1600360_impl*
 if (aForm.VCLWinControl Is TvcmMainForm) then
  f_MainForms.Add(aForm)
 else
 begin
  // begin http://mdp.garant.ru/pages/viewpage.action?pageId=330139744&focusedCommentId=330142461#comment-330142461
  // - тут проверяем, что нельзя добавлять ДВЕ формы с ОДИНАКОВЫМ GUID
  with f_Entities do
   for l_Index := Lo to Hi do
   begin
    l_Form := Items[l_Index].AsForm;
    //if Supports(Items[l_Index], IvcmEntityForm, l_Form) then
    if (l_Form <> nil) then
    begin
     if IsEqualGUID(l_Form.GUID, aForm.GUID) then
      if not vcmIEQ(l_Form, aForm) then
       if (l_Form.NativeMainForm.AsForm.VCLWinControl <>
           aForm.NativeMainForm.AsForm.VCLWinControl) then
        // - http://mdp.garant.ru/pages/viewpage.action?pageId=327826220&focusedCommentId=330142701#comment-330142701   
        Assert(false);
    end;//Supports(Items[l_Index]
   end;//for l_Index
  // end http://mdp.garant.ru/pages/viewpage.action?pageId=330139744&focusedCommentId=330142461#comment-330142461
  f_Entities.Add(aForm.Entity);
  { Зарегистрируем операции управления формой }
  if Assigned(g_MenuManager) then
   g_MenuManager.AddForm(aForm);
  l_Main := Form;
  if (l_Main = nil) then
   l_Main := _GetMain(aForm.VCLWinControl As TCustomForm);
  if (l_Main <> nil) then
   l_Main.ShowForm(aForm);
 end;//aForm.VCLForm Is TvcmMainForm
//#UC END# *499556690347_57D2C1600360_impl*
end;//TvcmDispatcher.AddForm

procedure TvcmDispatcher.RemoveForm(const aForm: IvcmEntityForm);
 {* удалить форму из приложения }
//#UC START# *499556780259_57D2C1600360_var*
var
 l_Index   : Integer;
 l_Entity  : IvcmEntity;
 l_History : IvcmHistory;
//#UC END# *499556780259_57D2C1600360_var*
begin
//#UC START# *499556780259_57D2C1600360_impl*
 if (aForm <> nil) then
 begin
  if (g_MenuManager <> nil) then
   g_MenuManager.RemoveForm(aForm);
  l_History := Get_History;
  if (l_History <> nil) then
   l_History.RemoveForm(aForm);
  if (f_InvalidateForms <> nil) then
   f_InvalidateForms.Remove(aForm);
  if (f_UpdateForms <> nil) then
   f_UpdateForms.Remove(aForm);
  if (aForm.VCLWinControl Is TvcmMainForm) then 
  begin
   // Новую форму будем открывать на месте предыдущей закрытой:
   if f_MainForms.Count > 1 then
   begin
    // Если закрываемая форма максимизирована, то просто сбрасываем размеры,
    // чтобы они не применялись в TvcmDispatcher.PlaceNewMainForm, т.к. если
    // текущая форма не развернута, то новой форме присвоят размер развернутой
    // при этом работать с ней будет не удобно:
    // 1. Запустили приложение, состояние окна Normal;
    // 2. Открыли новое окно и устновили состояние Maximized;
    // 3. Открываем новое окно;
    // 4. Перед открытие в настройки будет записано Normal (SaveActiveForms);
    // 5. Читаем настройки для нового окна, состояние Normal;
    // 6. Размещаем окно в TvcmDispatcher.PlaceNewMainForm устанавливая ему
    //    размер максимизированного (f_NewMainFormBounds);
    // 7. Получается некрасиво;
    if (aForm.VCLWinControl As TCustomForm).WindowState = wsMaximized then
     SetRectEmpty(f_NewMainFormBounds)
    else
     f_NewMainFormBounds := aForm.VCLWinControl.BoundsRect;
   end;//if f_MainForms.Count > 1 then
   f_MainForms.Remove(aForm);
  end//if (aForm <> nil) then
  else
  begin
   l_Entity := aForm.Entity;
   with f_Entities do
    for l_Index := Lo to Hi do
     if vcmIEQ(f_Entities[l_Index], l_Entity) then
     begin
      Delete(l_Index);
      break;
     end;//vcmIEQ(f_Entities[l_Index], l_Entity)
  end;//aForm.VCLForm Is TvcmMainForm
  //if not InOp then
    with f_FormsForClose do
    begin
     l_Index := IndexOf(aForm);
     if l_Index <> -1 then
      Delete(l_Index);
    end;//with f_FormsForClose
 end;//aForm <> nil
//#UC END# *499556780259_57D2C1600360_impl*
end;//TvcmDispatcher.RemoveForm

procedure TvcmDispatcher.ShowMainForm(const aForm: IvcmEntityForm);
 {* показать главную форму }
//#UC START# *49955685037A_57D2C1600360_var*
//#UC END# *49955685037A_57D2C1600360_var*
begin
//#UC START# *49955685037A_57D2C1600360_impl*
 if ((aForm.VCLWinControl As TForm).WindowState = wsMinimized) then
  (aForm.VCLWinControl As TForm).WindowState := wsNormal;
 SetWindowPos(aForm.VCLWinControl.Handle, 0, -1, -1, -1, -1, SWP_NOSIZE or
  SWP_SHOWWINDOW or SWP_NOMOVE);
//#UC END# *49955685037A_57D2C1600360_impl*
end;//TvcmDispatcher.ShowMainForm

procedure TvcmDispatcher.Lock;
//#UC START# *49955692026A_57D2C1600360_var*
//#UC END# *49955692026A_57D2C1600360_var*
begin
//#UC START# *49955692026A_57D2C1600360_impl*
 if not f_UnlockProtection then
 begin
  if not Locked then
   LockNotify(vcm_lnLock);
  Inc(f_Lock);
 end;//if not f_UnlockProtection then
//#UC END# *49955692026A_57D2C1600360_impl*
end;//TvcmDispatcher.Lock

procedure TvcmDispatcher.UnLock;
//#UC START# *4995569D0097_57D2C1600360_var*
var
 l_Index : Integer;
 l_Form  : IvcmEntityForm;
 l_DM    : IDockManager; 
//#UC END# *4995569D0097_57D2C1600360_var*
begin
//#UC START# *4995569D0097_57D2C1600360_impl*
 if f_UnlockProtection then
  exit;
 if (f_Lock = 1) then
 begin
  if (f_InvalidateForms <> nil) then
   with f_InvalidateForms do
   begin
    l_Index := Lo;
    while (l_Index <= Hi) do
    begin
     l_Form := Items[l_Index];
     try
      if (l_Form.VCLWinControl <> nil) then
       l_Form.VCLWinControl.EnableAlign;
(*       with l_Form.VCLWinControl do
       begin
        EnableAlign;
        {Invalidate;
        Perform(WM_NCPaint, 0, 0);}
       end;//with l_Form.VCLForm*)
     finally
      l_Form := nil;
     end;//try..finally
     Inc(l_Index);
    end;//while (l_Index <= Hi)
   end;//with f_InvalidateForms
 end;//f_Lock = 1

 if (f_Lock = 1) then
 begin
  LockNotify(vcm_lnBeforeUnlock);
  Assert(f_Lock = 1);
 end;//f_Lock = 1

 f_UnlockProtection := true;
 try
  Dec(f_Lock);
  if (f_Lock = 0) then
  begin

   if (f_DockManagers <> nil) then
    with f_DockManagers do
    begin
     l_Index := Lo;
     while (l_Index <= Hi) do
     begin
      l_DM := Items[l_Index];
      try
       l_DM.EndUpdate;
      finally
       l_DM := nil;
      end;//try..finally
      Inc(l_Index);
     end;//while (l_Index <= Hi)
     Clear;
    end;//with f_DockManagers
    LockNotify(vcm_lnUnlock);

    if (f_UpdateForms <> nil) then
     with f_UpdateForms do
     begin
      l_Index := Lo;
      while (l_Index <= Hi) do
      begin
       l_Form := Items[l_Index];
       try
        if l_Form.VCLWinControl is TvcmForm then
         TvcmForm(l_Form.VCLWinControl).UpdateActions;
       finally
        l_Form := nil;
       end;//try..finally
       Inc(l_Index);
      end;//while (l_Index <= Hi)
      Clear;
     end;// with f_UpdateForms

    if (f_InvalidateForms <> nil) then
     with f_InvalidateForms do
     begin
      l_Index := Lo;
      while (l_Index <= Hi) do
      begin
       l_Form := Items[l_Index];
       try
        if (l_Form.VCLWinControl <> nil) then
         RedrawWindow(l_Form.VCLWinControl.Handle, nil, 0, RDW_ERASE or
          RDW_INTERNALPAINT or RDW_FRAME or RDW_INVALIDATE);
       finally
        l_Form := nil;
       end;//try..finally
       Inc(l_Index);
      end;//while (l_Index <= Hi)
      Clear;
     end;//with f_InvalidateForms

    if (f_InvalidateCtrls <> nil) then
     with f_InvalidateCtrls do
     begin
      l_Index := Lo;
      while (l_Index <= Hi) do
      begin
       RedrawWindow(hWND(Items[l_Index]), nil, 0, RDW_ERASE or RDW_INTERNALPAINT or
        RDW_FRAME or RDW_INVALIDATE);
       Inc(l_Index);
      end;//while (l_Index <= Hi)
      Clear;
     end;//with f_InvalidateCtrls
    if f_NeedUpdateMainCaption then
    begin
     f_NeedUpdateMainCaption := false;
     for l_Index := 0 to Pred(MainFormsCount) do
      (MainForm[l_Index].VCLWinControl as TvcmMainForm).UpdateMainCaption;
    end;//f_NeedUpdateMainCaption
  end;//f_Lock = 0
 finally
  f_UnlockProtection := false;
 end;
//#UC END# *4995569D0097_57D2C1600360_impl*
end;//TvcmDispatcher.UnLock

procedure TvcmDispatcher.BackupLockStatus;
//#UC START# *499556A40146_57D2C1600360_var*
//#UC END# *499556A40146_57D2C1600360_var*
begin
//#UC START# *499556A40146_57D2C1600360_impl*
 f_SaveLockCounter.Add(f_Lock);
 f_Lock := 1;
 Unlock;
//#UC END# *499556A40146_57D2C1600360_impl*
end;//TvcmDispatcher.BackupLockStatus

procedure TvcmDispatcher.RestoreLockStatus;
//#UC START# *499556AB022F_57D2C1600360_var*
//#UC END# *499556AB022F_57D2C1600360_var*
begin
//#UC START# *499556AB022F_57D2C1600360_impl*
 assert(f_SaveLockCounter.Count > 0);
 f_Lock := f_SaveLockCounter[f_SaveLockCounter.Count - 1];
 f_SaveLockCounter.Delete(f_SaveLockCounter.Count - 1);
//#UC END# *499556AB022F_57D2C1600360_impl*
end;//TvcmDispatcher.RestoreLockStatus

function TvcmDispatcher.FindForm(const aGUID: TGUID;
 out theForm: IvcmEntityForm): Boolean;
//#UC START# *499556DB01E8_57D2C1600360_var*
var
 l_Index : Integer;
//#UC END# *499556DB01E8_57D2C1600360_var*
begin
//#UC START# *499556DB01E8_57D2C1600360_impl*
 Result := false;
 if (f_Entities <> nil) then
  with f_Entities do
   for l_Index := Lo to Hi do
   begin
    theForm := Items[l_Index].AsForm;
    //if Supports(Items[l_Index], IvcmEntityForm, theForm) then
    if (theForm <> nil) then
    begin
     if IsEqualGUID(theForm.GUID, aGUID) then
     begin
      Result := true;
      Exit;
     end;//IsEqualGUID(theForm.GUID, aGUID)
    end;//Supports(Items[l_Index]
   end;//for l_Index
 if (f_MainForms <> nil) then
  with f_MainForms do
   for l_Index := Lo to Hi do
   begin
    theForm := Items[l_Index];
    //if Supports(Items[l_Index], IvcmEntityForm, theForm) then
    if (theForm <> nil) then
    begin
     if IsEqualGUID(theForm.GUID, aGUID) then
     begin
      Result := true;
      Exit;
     end;//IsEqualGUID(theForm.GUID, aGUID)
    end;//Supports(Items[l_Index]
   end;//for l_Index
//#UC END# *499556DB01E8_57D2C1600360_impl*
end;//TvcmDispatcher.FindForm

procedure TvcmDispatcher.AddFormForInvalidate(const aForm: IvcmEntityForm);
//#UC START# *499556EB0036_57D2C1600360_var*
var
 l_Index : Integer;
//#UC END# *499556EB0036_57D2C1600360_var*
begin
//#UC START# *499556EB0036_57D2C1600360_impl*
 l_Index := f_InvalidateForms.IndexOf(aForm);
 if (l_Index < 0) then
 begin
  f_InvalidateForms.Add(aForm);
  aForm.VCLWinControl.DisableAlign;
 end;//l_Index < 0
//#UC END# *499556EB0036_57D2C1600360_impl*
end;//TvcmDispatcher.AddFormForInvalidate

procedure TvcmDispatcher.AddControlForInvalidate(aControl: TObject);
//#UC START# *499556F601B0_57D2C1600360_var*
var
 l_Index   : Integer;
 l_Control : TWinControl;
//#UC END# *499556F601B0_57D2C1600360_var*
begin
//#UC START# *499556F601B0_57D2C1600360_impl*
 if (aControl is TWinControl) then
 begin
  l_Control := TWinControl(aControl);
  l_Index := f_InvalidateCtrls.IndexOf(Integer(l_Control.Handle));
  if (l_Index < 0) then
   f_InvalidateCtrls.Add(Integer(l_Control.Handle));
 end;
//#UC END# *499556F601B0_57D2C1600360_impl*
end;//TvcmDispatcher.AddControlForInvalidate

procedure TvcmDispatcher.AddFormForUpdateActions(const aForm: IvcmEntityForm);
//#UC START# *499556FF01CD_57D2C1600360_var*
var
 l_Index : Integer;
//#UC END# *499556FF01CD_57D2C1600360_var*
begin
//#UC START# *499556FF01CD_57D2C1600360_impl*
 l_Index := f_UpdateForms.IndexOf(aForm);
 if (l_Index < 0) then
  f_UpdateForms.Add(aForm);
//#UC END# *499556FF01CD_57D2C1600360_impl*
end;//TvcmDispatcher.AddFormForUpdateActions

procedure TvcmDispatcher.AddDockManager(const aDockManager: IDockManager);
//#UC START# *4995570A03CD_57D2C1600360_var*
var
 l_Index: Integer;
//#UC END# *4995570A03CD_57D2C1600360_var*
begin
//#UC START# *4995570A03CD_57D2C1600360_impl*
 if (aDockManager <> nil) then
 begin
  l_Index := f_DockManagers.IndexOf(aDockManager);
  if (l_Index < 0) and not f_UnlockProtection then
  begin
   f_DockManagers.Add(aDockManager);
   aDockManager.BeginUpdate;
  end;//l_Index < 0
 end;//aDockManager <> nil
//#UC END# *4995570A03CD_57D2C1600360_impl*
end;//TvcmDispatcher.AddDockManager

procedure TvcmDispatcher.AddLockListener(const aListener: IvcmLockListener);
//#UC START# *4995574300E4_57D2C1600360_var*
var
 l_Index : Integer;
//#UC END# *4995574300E4_57D2C1600360_var*
begin
//#UC START# *4995574300E4_57D2C1600360_impl*
 l_Index := f_LockListeners.IndexOf(aListener);
 if (l_Index < 0) then
  f_LockListeners.Add(aListener);
//#UC END# *4995574300E4_57D2C1600360_impl*
end;//TvcmDispatcher.AddLockListener

procedure TvcmDispatcher.RemoveLockListener(const aListener: IvcmLockListener);
//#UC START# *4995574D03DB_57D2C1600360_var*
//#UC END# *4995574D03DB_57D2C1600360_var*
begin
//#UC START# *4995574D03DB_57D2C1600360_impl*
 if (f_LockListeners <> nil) then
  f_LockListeners.Remove(aListener);
//#UC END# *4995574D03DB_57D2C1600360_impl*
end;//TvcmDispatcher.RemoveLockListener

procedure TvcmDispatcher.UpdateMainCaption(const aForm: IvcmEntityForm = nil);
//#UC START# *4995575803B1_57D2C1600360_var*
 procedure lp_DoUpdateMainCaption(const aMainForm: TvcmMainForm);
 begin
  if Locked then
   // - не обновляем заголовок окна при залочке
   f_NeedUpdateMainCaption := true
  else
   aMainForm.UpdateMainCaption;
 end;//lp_DoUpdateMainCaption

var
 l_CMF : IvcmEntityForm;
 l_Container: IafwMainFormContainer;
//#UC END# *4995575803B1_57D2C1600360_var*
begin
//#UC START# *4995575803B1_57D2C1600360_impl*
 // Если форма еще не видна и мы знаем о ней (aForm <> nil), то пытаемся использовать ее.
 if (aForm <> nil) and aForm.IsMainObjectForm then
 begin
  if not Supports(afw.GetTopParentForm(aForm.VCLWinControl), IvcmEntityForm, l_CMF) then
   l_CMF := Get_CurrentMainForm;
 end//(aForm <> nil) and aForm.IsMainObjectForm
 else
  l_CMF := Get_CurrentMainForm;
 if (l_CMF <> nil) then
 begin
  if (l_CMF.VCLWinControl Is TvcmMainForm) then
   lp_DoUpdateMainCaption(TvcmMainForm(l_CMF.VCLWinControl))
  else
  if Supports(l_CMF, IafwMainFormContainer, l_Container) then
  try
   // Главной формой оказался контейнер, содержащий TvcmMainForm - нужно
   // обновить заголовок текущей активной главной формы в контейнере
   lp_DoUpdateMainCaption(TvcmMainForm(l_Container.CurrentMainForm));
   l_Container.UpdateFormCaption(aForm.VCLWinControl as TafwCustomForm);
  finally
   l_Container := nil;
  end;//try..finally
 end;//l_CMF <> nil..
//#UC END# *4995575803B1_57D2C1600360_impl*
end;//TvcmDispatcher.UpdateMainCaption

procedure TvcmDispatcher.AddToCloseQueue(const aForm: IvcmEntityForm);
//#UC START# *4995576100AD_57D2C1600360_var*
//#UC END# *4995576100AD_57D2C1600360_var*
begin
//#UC START# *4995576100AD_57D2C1600360_impl*
 Assert(InOp);
 if (f_FormsForClose.IndexOf(aForm) < 0) then
  f_FormsForClose.Add(aForm);
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
 if (aSource.WindowState = wsMaximized) then
   aNew.WindowState := wsMaximized
 else
  // Разместим форму на месте предыдущей закрытой:
  if not IsRectEmpty(f_NewMainFormBounds) then
  begin
   // Уберем ограничения т.к. f_NewMainFormBounds в них не вписываются:
   with aNew.Constraints, f_NewMainFormBounds do
    if ((MinHeight <> 0) and (MinHeight < Bottom - Top)) or
      ((MinWidth <> 0) and (MinWidth < Right - Left)) then
     vcmDropConstraints(aNew);
   aNew.BoundsRect := f_NewMainFormBounds;
  end
  // Смещаем относительно главной на который вызвали создание нового главного
  // окна:
  else
  begin
   aNew.WindowState := wsNormal;
   aNew.Top := aSource.Top + 50;
   aNew.Left := aSource.Left + 50;
   aNew.Width := aSource.Width;
   aNew.Height := aSource.Height;
  end;
//#UC END# *4995576B03B9_57D2C1600360_impl*
end;//TvcmDispatcher.PlaceNewMainForm

procedure TvcmDispatcher.StartNewMainForm;
 {* вызывается перед началом создания главной формы }
//#UC START# *4995577F0221_57D2C1600360_var*
var
 l_Index: Integer;
//#UC END# *4995577F0221_57D2C1600360_var*
begin
//#UC START# *4995577F0221_57D2C1600360_impl*
 if f_FDListeners <> nil then
  for l_Index := 0 to Pred(f_FDListeners.Count) do
   f_FDListeners[l_Index].StartNewMainForm;
//#UC END# *4995577F0221_57D2C1600360_impl*
end;//TvcmDispatcher.StartNewMainForm

function TvcmDispatcher.Get_Locked: Boolean;
//#UC START# *499557920080_57D2C1600360get_var*
//#UC END# *499557920080_57D2C1600360get_var*
begin
//#UC START# *499557920080_57D2C1600360get_impl*
 Result := (f_Lock > 0);
//#UC END# *499557920080_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_Locked

function TvcmDispatcher.Get_MainFormsCount: Integer;
//#UC START# *4995579C0176_57D2C1600360get_var*
//#UC END# *4995579C0176_57D2C1600360get_var*
begin
//#UC START# *4995579C0176_57D2C1600360get_impl*
 Result := f_MainForms.Count;
//#UC END# *4995579C0176_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_MainFormsCount

function TvcmDispatcher.Get_MainForm(anIndex: Integer): IvcmEntityForm;
//#UC START# *499557FD02B8_57D2C1600360get_var*
//#UC END# *499557FD02B8_57D2C1600360get_var*
begin
//#UC START# *499557FD02B8_57D2C1600360get_impl*
 Result := f_MainForms.Items[anIndex];
//#UC END# *499557FD02B8_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_MainForm

function TvcmDispatcher.Get_CurrentMainForm: IvcmEntityForm;
//#UC START# *4995586301F3_57D2C1600360get_var*
 function lp_DoGetCurrentMainForm: IvcmEntityForm;
 var
  l_MF: IafwMainForm;
 begin
  Result := nil;
  if (f_MainFormProvider <> nil) then
   Result := IvcmMainFormProvider(f_MainFormProvider).CurrentMainForm
  else
  begin
   l_MF := afw.Application.CurrentMainForm;
   if (l_MF <> nil) then
   try
    Supports(l_MF, IvcmEntityForm, Result);
   finally
    l_MF := nil;
   end;//try..finally
  end;
 end;//lp_DoGetCurrentMainForm

var
 l_MF    : IafwMainForm;
 l_Index : Integer;
//#UC END# *4995586301F3_57D2C1600360get_var*
begin
//#UC START# *4995586301F3_57D2C1600360get_impl*
 if (afw.Application = nil) then
  Result := nil
 else
 begin
  Result := lp_DoGetCurrentMainForm;
  if (Result = nil) then
  begin
   for l_Index := 0 to Screen.FormCount - 1 do
    if (Screen.Forms[l_Index] Is TvcmMainForm) then
     if Supports(Screen.Forms[l_Index], IvcmEntityForm, Result) then
      break;
  end;//l_MF <> nil
 end;//afw.Application = nil
//#UC END# *4995586301F3_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_CurrentMainForm

function TvcmDispatcher.Get_Notify: IvcmFormDispatcherNotify;
//#UC START# *499558A30052_57D2C1600360get_var*
//#UC END# *499558A30052_57D2C1600360get_var*
begin
//#UC START# *499558A30052_57D2C1600360get_impl*
 Result := Self;
//#UC END# *499558A30052_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_Notify

procedure TvcmDispatcher.BeginRestoreAllSettings;
//#UC START# *49955B59006C_57D2C1600360_var*
//#UC END# *49955B59006C_57D2C1600360_var*
begin
//#UC START# *49955B59006C_57D2C1600360_impl*
 Inc(f_RestoreAllSettings);
//#UC END# *49955B59006C_57D2C1600360_impl*
end;//TvcmDispatcher.BeginRestoreAllSettings

procedure TvcmDispatcher.EndRestoreAllSettings;
//#UC START# *49955B620344_57D2C1600360_var*
//#UC END# *49955B620344_57D2C1600360_var*
begin
//#UC START# *49955B620344_57D2C1600360_impl*
 Dec(f_RestoreAllSettings);
//#UC END# *49955B620344_57D2C1600360_impl*
end;//TvcmDispatcher.EndRestoreAllSettings

procedure TvcmDispatcher.RestoreFormSize;
 {* перечитывает размер компонентов на форме (восстанавливает сначала
             размеры Design-Time, потом читает из настроек) }
//#UC START# *49955B6C0227_57D2C1600360_var*
var
 l_Index : Integer;
 l_Form  : IvcmEntityForm;
//#UC END# *49955B6C0227_57D2C1600360_var*
begin
//#UC START# *49955B6C0227_57D2C1600360_impl*
 (* Главные формы не регистрируются в списке сущностей *)
 for l_Index := 0 to Pred(Get_MainFormsCount) do
  (Get_MainForm(l_Index).VCLWinControl As TvcmMainForm).RestoreFormSize; 
 (* Пройдемся по зарегистрированным формам *)
 for l_Index := 0 to Pred(Get_EntitiesCount) do
  if Supports(Get_Entity(l_Index), IvcmEntityForm, l_Form) then
  try
   if (l_Form.VCLWinControl is TvcmContainerForm) then
    TvcmContainerForm(l_Form.VCLWinControl).RestoreControlSize;
  finally
   l_Form := nil;
  end;//try..finally
//#UC END# *49955B6C0227_57D2C1600360_impl*
end;//TvcmDispatcher.RestoreFormSize

procedure TvcmDispatcher.ReloadAllToolbars;
 {* перезагружает информацию toolbar-ов у всех открытых в данный момент
             форм }
//#UC START# *49955B7A0097_57D2C1600360_var*
var
 l_Index : Integer;
 l_Form  : IvcmEntityForm;
//#UC END# *49955B7A0097_57D2C1600360_var*
begin
//#UC START# *49955B7A0097_57D2C1600360_impl*
 for l_Index := 0 to Pred(Get_MainFormsCount) do
 begin
  (Get_MainForm(l_Index).VCLWinControl as TvcmEntityForm).ReloadToolbars;
  afw.ProcessMessages;
 end;//for l_Index

 for l_Index := 0 to Pred(Get_EntitiesCount) do
  if Supports(Get_Entity(l_Index), IvcmEntityForm, l_Form) then
  try
   with (l_Form.VCLWinControl As TvcmEntityForm) do
   begin
    ReloadToolbars;
    // ManualUpdateActions надо, иначе имеем на экране не реальное состояние
    // формы
    ManualUpdateActions;
   end;//with (l_Form.VCLWinControl As TvcmEntityForm)
   afw.ProcessMessages;
  finally
   l_Form := nil;
  end;//try..finally
//#UC END# *49955B7A0097_57D2C1600360_impl*
end;//TvcmDispatcher.ReloadAllToolbars

function TvcmDispatcher.EntityOperation(const anOp: TvcmOPID;
 const aParams: IvcmExecuteParams): Boolean;
//#UC START# *49955B9502D1_57D2C1600360_var*
//#UC END# *49955B9502D1_57D2C1600360_var*
begin
//#UC START# *49955B9502D1_57D2C1600360_impl*
 Assert(anOp.rEnID > 0);
 Assert(anOp.rOpID > 0);
 EntityOperation(anOp, aParams.BasePart, vcm_omExecute);
 Result := aParams.DoneStatus in [vcm_dsDone, vcm_dsDisabled];
//#UC END# *49955B9502D1_57D2C1600360_impl*
end;//TvcmDispatcher.EntityOperation

procedure TvcmDispatcher.EntityOperation(const anOp: TvcmOPID;
 const aParams: IvcmTestParams);
//#UC START# *49955BA801FD_57D2C1600360_var*
//#UC END# *49955BA801FD_57D2C1600360_var*
begin
//#UC START# *49955BA801FD_57D2C1600360_impl*
 Assert(anOp.rEnID > 0);
 Assert(anOp.rOpID > 0);
 EntityOperation(anOp, aParams.BasePart, vcm_omTest);
//#UC END# *49955BA801FD_57D2C1600360_impl*
end;//TvcmDispatcher.EntityOperation

{$If NOT Defined(DesignTimeLibrary)}
procedure TvcmDispatcher.EntityOperationBroadcast(const anOp: TvcmOPID;
 const aParams: IvcmExecuteParams);
//#UC START# *49955BCE010F_57D2C1600360_var*
{$IfNDef DesignTimeLibrary}
type
 PIvcmEntity = ^IvcmEntity;

  function DoIt(anItem: PIvcmEntity; anIndex: Integer): Boolean;
  begin//DoIt
   Result := true;
   aParams.DoneStatus := vcm_dsNotDone;
   anItem^.Operation(anOp, aParams);
  end;//DoIt

  function DoIt1(anItem: PIvcmEntityForm; anIndex: Integer): Boolean;
  begin//DoIt1
   Result := true;
   aParams.DoneStatus := vcm_dsNotDone;
   anItem^.Entity.Operation(anOp, aParams);
  end;//DoIt1

var
 l_CloneList: TvcmIEntityList;
{$EndIf DesignTimeLibrary}
//#UC END# *49955BCE010F_57D2C1600360_var*
begin
//#UC START# *49955BCE010F_57D2C1600360_impl*
{$IfNDef DesignTimeLibrary}
 Assert(anOp.rEnID > 0);
 Assert(anOp.rOpID > 0);
 BeginOp;
 // - фиксируем набор форм
 try
  aParams.DoneStatus := vcm_dsNotDone;
  // в процессе пробегания по листу, список f_Entities может изменяться
  {$IfNDef DesignTimeLibrary}
  l_CloneList := f_Entities.Clone;
  {$Else DesignTimeLibrary}
  l_CloneList := nil;
  {$EndIf DesignTimeLibrary}
  try
   l_CloneList.IterateAllF(l3L2IA(@DoIt));
  finally
   vcmFree(l_CloneList);
  end;//try..finally
  f_MainForms.IterateAllF(l3L2IA(@DoIt1));
 finally
  EndOp;
 end;//try..finally
{$EndIf DesignTimeLibrary}
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
 Assert(anOp.rMoID > 0);
 Assert(anOp.rOpID > 0);
 ModuleOperation(anOp, aParams.BasePart, vcm_omExecute);
//#UC END# *49955BF8022D_57D2C1600360_impl*
end;//TvcmDispatcher.CallModuleOperation

procedure TvcmDispatcher.ModuleOperation(const anOp: TvcmMOPID;
 const aParams: IvcmTestParams);
 {* выполняет операцию модуля }
//#UC START# *49955C0B02AB_57D2C1600360_var*
//#UC END# *49955C0B02AB_57D2C1600360_var*
begin
//#UC START# *49955C0B02AB_57D2C1600360_impl*
 Assert(anOp.rMoID > 0);
 Assert(anOp.rOpID > 0);
 ModuleOperation(anOp, aParams.BasePart, vcm_omTest);
//#UC END# *49955C0B02AB_57D2C1600360_impl*
end;//TvcmDispatcher.ModuleOperation

function TvcmDispatcher.ModuleOperation(const anOp: TvcmMOPID): Boolean;
 {* выполняет операцию модуля }
//#UC START# *49955C220255_57D2C1600360_var*
var
 l_P : IvcmExecuteParams;
//#UC END# *49955C220255_57D2C1600360_var*
begin
//#UC START# *49955C220255_57D2C1600360_impl*
 l_P := vcmParams;
 ModuleOperation(anOp, l_P.BasePart, vcm_omExecute);
 Result := l_P.DoneStatus in [vcm_dsDone, vcm_dsDisabled];
//#UC END# *49955C220255_57D2C1600360_impl*
end;//TvcmDispatcher.ModuleOperation

function TvcmDispatcher.GetModuleByID(aModuleID: TvcmControlID): IvcmModule;
 {* возвращает модуль по идентификатору }
//#UC START# *49955C5101F1_57D2C1600360_var*
//#UC END# *49955C5101F1_57D2C1600360_var*
begin
//#UC START# *49955C5101F1_57D2C1600360_impl*
 Result := TvcmModule.GetModuleByID(aModuleID);
//#UC END# *49955C5101F1_57D2C1600360_impl*
end;//TvcmDispatcher.GetModuleByID

function TvcmDispatcher.Get_Module(anIndex: Integer): IvcmModule;
//#UC START# *49955C970119_57D2C1600360get_var*
//#UC END# *49955C970119_57D2C1600360get_var*
begin
//#UC START# *49955C970119_57D2C1600360get_impl*
 Result := TvcmModule.GetModule(anIndex);
//#UC END# *49955C970119_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_Module

procedure TvcmDispatcher.UpdateStatus;
//#UC START# *49955D45017B_57D2C1600360_var*
//#UC END# *49955D45017B_57D2C1600360_var*
begin
//#UC START# *49955D45017B_57D2C1600360_impl*
 if (afw.Application <> nil) AND
    (afw.Application.CurrentMainForm <> nil) AND
    (afw.Application.CurrentMainForm.Status <> nil) then
  if pm_GetIsLockActionUpdate then
   f_NeedUpdateStatus := True
  else
   afw.Application.CurrentMainForm.Status.Update;
//#UC END# *49955D45017B_57D2C1600360_impl*
end;//TvcmDispatcher.UpdateStatus

procedure TvcmDispatcher.AddAggregate(const anAggregate: IvcmAggregate);
//#UC START# *49955D4F01FD_57D2C1600360_var*
//#UC END# *49955D4F01FD_57D2C1600360_var*
begin
//#UC START# *49955D4F01FD_57D2C1600360_impl*
 if (f_Aggregates = nil) then
  f_Aggregates := TvcmAggregateRefList.MakeSorted;
 f_Aggregates.Add(anAggregate); 
//#UC END# *49955D4F01FD_57D2C1600360_impl*
end;//TvcmDispatcher.AddAggregate

procedure TvcmDispatcher.RemoveAggregate(const anAggregate: IvcmAggregate);
//#UC START# *49955D5802B2_57D2C1600360_var*
//#UC END# *49955D5802B2_57D2C1600360_var*
begin
//#UC START# *49955D5802B2_57D2C1600360_impl*
 f_Aggregates.Remove(anAggregate);
//#UC END# *49955D5802B2_57D2C1600360_impl*
end;//TvcmDispatcher.RemoveAggregate

function TvcmDispatcher.FindAggregate(const aGUID: TGUID;
 out theAggregate: IvcmAggregate): Boolean;
//#UC START# *49955D660174_57D2C1600360_var*
var
 l_Index : Integer;
//#UC END# *49955D660174_57D2C1600360_var*
begin
//#UC START# *49955D660174_57D2C1600360_impl*
 Result := false;
 if (f_Aggregates <> nil) then
  with f_Aggregates do
   for l_Index := Lo to Hi do
   begin
    theAggregate := Items[l_Index];
    if IsEqualGUID(theAggregate.GUID, aGUID) then
    begin
     Result := true;
     break;
    end;//IsEqualGUID(anAggregate.GUID, aGUID)
   end;//for l_Index
//#UC END# *49955D660174_57D2C1600360_impl*
end;//TvcmDispatcher.FindAggregate

procedure TvcmDispatcher.StoreFocus;
//#UC START# *49955D9E0380_57D2C1600360_var*
//#UC END# *49955D9E0380_57D2C1600360_var*
begin
//#UC START# *49955D9E0380_57D2C1600360_impl*
 if f_StoredFocusLock = 0  then
  StoreFocused(Windows.GetFocus);
 inc(f_StoredFocusLock);
//#UC END# *49955D9E0380_57D2C1600360_impl*
end;//TvcmDispatcher.StoreFocus

procedure TvcmDispatcher.RestoreFocus;
//#UC START# *49955DA6004C_57D2C1600360_var*
var
 l_Parent,
 l_Control : TWinControl;

 function lp_TrySetFocus(aControl: TControl): boolean;
 Var
  l_LocControl: TControl;
  l_FCS: IafwFocusableControlParent;  
 begin
  Result := False;
  l_LocControl := aControl;
  while l_LocControl <> nil do
  begin
   if not l_LocControl.Enabled or not l_LocControl.Visible then
   begin
    if Supports(l_LocControl, IafwFocusableControlParent, l_FCS) then
    begin
     l_FCS.SetFocusToControl(l_Control);
     Result := True;
    end;
    exit;
   end;
   l_LocControl := l_LocControl.Parent;
  end;
  Result := True;
  if l_Control.CanFocus then
   l_Control.SetFocus;
 end;
//#UC END# *49955DA6004C_57D2C1600360_var*
begin
//#UC START# *49955DA6004C_57D2C1600360_impl*
 dec(f_StoredFocusLock);
 if (f_StoredFocusLock = 0) and
    (f_PrevFocused <> 0) then
 begin
  if Windows.GetFocus <> f_PrevFocused then
  begin
   l_Control := FindControl(f_PrevFocused);
   l_Parent := l_Control;
   while Assigned(l_Parent) do
    if l_Parent is TvcmEntityForm then
    begin
     lp_TrySetFocus(l_Control);
     l_Parent := nil;
    end
    else
     l_Parent := l_Parent.Parent;
  end;
  f_PrevFocused := 0;
 end;
//#UC END# *49955DA6004C_57D2C1600360_impl*
end;//TvcmDispatcher.RestoreFocus

procedure TvcmDispatcher.BeginOp(anInternal: Boolean = False);
//#UC START# *49955DB3020D_57D2C1600360_var*
//#UC END# *49955DB3020D_57D2C1600360_var*
begin
//#UC START# *49955DB3020D_57D2C1600360_impl*
 if (f_Op = 0) then
  f_InternalOp := anInternal; 
 Inc(f_Op);
//#UC END# *49955DB3020D_57D2C1600360_impl*
end;//TvcmDispatcher.BeginOp

procedure TvcmDispatcher.EndOp;
//#UC START# *49955DBB03AC_57D2C1600360_var*
 function l_FreeObject(anObj: PObject; anIndex: Integer): Boolean;
 var
  l_Object : TObject;
 begin//l_FreeObject
  Result := true;
  l_Object := anObj^;
  f_ObjectsForFree.Delete(anIndex);
  vcmFree(l_Object);
 end;//l_FreeObject

 function l_CloseForm(aForm: PIvcmEntityForm; anIndex: Integer): Boolean;
 var
  l_Form : TCustomForm;
 begin//l_CloseForm
  Result := true;
  l_Form := aForm^.VCLWinControl As TCustomForm;
  f_FormsForClose.Delete(anIndex);
  if (l_Form Is TvcmForm) then
   TvcmForm(l_Form).SafeClose
  else
   l_Form.Free;
 end;//l_CloseForm
//#UC END# *49955DBB03AC_57D2C1600360_var*
begin
//#UC START# *49955DBB03AC_57D2C1600360_impl*
 if (f_Op <= 1) then
 begin
  if (f_ObjectsForFree <> nil) then
   f_ObjectsForFree.IterateAllF(l3L2IA(@l_FreeObject));
  if (f_FormsForClose <> nil) then
   f_FormsForClose.IterateAllF(l3L2IA(@l_CloseForm));
 end;//f_Op <= 0
 // Уменьшаем здесь осознано, чтобы защитить повторный вызов кода выше
 Dec(f_Op);
 Assert(f_Op >= 0);
//#UC END# *49955DBB03AC_57D2C1600360_impl*
end;//TvcmDispatcher.EndOp

procedure TvcmDispatcher.StoreFocused(aHandle: THandle);
//#UC START# *49955E2101A7_57D2C1600360_var*
//#UC END# *49955E2101A7_57D2C1600360_var*
begin
//#UC START# *49955E2101A7_57D2C1600360_impl*
 f_PrevFocused := aHandle;
//#UC END# *49955E2101A7_57D2C1600360_impl*
end;//TvcmDispatcher.StoreFocused

function TvcmDispatcher.InOp(anInternal: Boolean = False): Boolean;
//#UC START# *49955E2902C1_57D2C1600360_var*
//#UC END# *49955E2902C1_57D2C1600360_var*
begin
//#UC START# *49955E2902C1_57D2C1600360_impl*
 if f_LockInOpCount > 0 then
  Result := False
 else
 if anInternal then
 begin
  if f_InternalOp then
   Result := false
  else
   Result := (f_Op > 0);
 end//anInternal
 else
  Result := (f_Op > 0);
//#UC END# *49955E2902C1_57D2C1600360_impl*
end;//TvcmDispatcher.InOp

procedure TvcmDispatcher.BeginCancelModal;
//#UC START# *49955E3100CE_57D2C1600360_var*
//#UC END# *49955E3100CE_57D2C1600360_var*
begin
//#UC START# *49955E3100CE_57D2C1600360_impl*
 inc(f_CancelModalLock);
//#UC END# *49955E3100CE_57D2C1600360_impl*
end;//TvcmDispatcher.BeginCancelModal

procedure TvcmDispatcher.EndCancelModal;
//#UC START# *49955E380234_57D2C1600360_var*
//#UC END# *49955E380234_57D2C1600360_var*
begin
//#UC START# *49955E380234_57D2C1600360_impl*
 dec(f_CancelModalLock);
//#UC END# *49955E380234_57D2C1600360_impl*
end;//TvcmDispatcher.EndCancelModal

function TvcmDispatcher.InCancelModal: Boolean;
//#UC START# *49955E4101C4_57D2C1600360_var*
//#UC END# *49955E4101C4_57D2C1600360_var*
begin
//#UC START# *49955E4101C4_57D2C1600360_impl*
 Result := f_CancelModalLock > 0;
//#UC END# *49955E4101C4_57D2C1600360_impl*
end;//TvcmDispatcher.InCancelModal

procedure TvcmDispatcher.LockCursor;
//#UC START# *49955E4B0045_57D2C1600360_var*
//#UC END# *49955E4B0045_57D2C1600360_var*
begin
//#UC START# *49955E4B0045_57D2C1600360_impl*
 if f_CursorLock = 0 then
 begin
  f_OldCursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
 end;
 inc(f_CursorLock);
//#UC END# *49955E4B0045_57D2C1600360_impl*
end;//TvcmDispatcher.LockCursor

procedure TvcmDispatcher.UnlockCursor;
//#UC START# *49955E510310_57D2C1600360_var*
//#UC END# *49955E510310_57D2C1600360_var*
begin
//#UC START# *49955E510310_57D2C1600360_impl*
 dec(f_CursorLock);
 if f_CursorLock = 0 then
  Screen.Cursor := f_OldCursor;
//#UC END# *49955E510310_57D2C1600360_impl*
end;//TvcmDispatcher.UnlockCursor

procedure TvcmDispatcher.LockActionUpdate;
//#UC START# *49955E5A013E_57D2C1600360_var*
//#UC END# *49955E5A013E_57D2C1600360_var*
begin
//#UC START# *49955E5A013E_57D2C1600360_impl*
 afw.LockActionUpdate;
 Inc(f_ActionUpdateCount);
//#UC END# *49955E5A013E_57D2C1600360_impl*
end;//TvcmDispatcher.LockActionUpdate

procedure TvcmDispatcher.UnlockActionUpdate;
 {* блокировать OnTest-ы операций. Необходимо когда система находится в
             переходном состоянии и не все данные актуальны }
//#UC START# *49955E600354_57D2C1600360_var*
//#UC END# *49955E600354_57D2C1600360_var*
begin
//#UC START# *49955E600354_57D2C1600360_impl*
 Dec(f_ActionUpdateCount);
 if (f_ActionUpdateCount = 0) and f_NeedUpdateStatus then
 begin
  PostMessage(pm_GetForm.Handle, vcm_msgUpdateStatus, 0, 0);
  f_NeedUpdateStatus := false;
 end;
 afw.UnlockActionUpdate;
//#UC END# *49955E600354_57D2C1600360_impl*
end;//TvcmDispatcher.UnlockActionUpdate

procedure TvcmDispatcher.AddObjectForFree(O: TObject);
//#UC START# *49955E870182_57D2C1600360_var*
//#UC END# *49955E870182_57D2C1600360_var*
begin
//#UC START# *49955E870182_57D2C1600360_impl*
 if (f_ObjectsForFree.IndexOf(O) < 0) then
  f_ObjectsForFree.Add(O);
//#UC END# *49955E870182_57D2C1600360_impl*
end;//TvcmDispatcher.AddObjectForFree

procedure TvcmDispatcher.ReinsertForms;
 {* перечитывает значения форм }
//#UC START# *49955E9001A4_57D2C1600360_var*
var
 l_Form      : IvcmEntityForm;
 l_CloneList : TvcmIEntityList;
 l_Count     : Integer;
 l_Flag      : Boolean;
//#UC END# *49955E9001A4_57D2C1600360_var*
begin
//#UC START# *49955E9001A4_57D2C1600360_impl*
 // для того, чтобы умерли старые формы и мы случайно не вставили их повторно
 afw.ProcessMessages;
 l_CloneList := TvcmIEntityList.Create;
 try
  for l_Count := 0 to Pred(Get_EntitiesCount) do
   l_CloneList.Add(Get_Entity(l_Count));
  for l_Count := 0 to Pred(l_CloneList.Count) do
  begin
   l_Form := l_CloneList[l_Count].AsForm;
   if (l_Form <> nil) then
   begin
    l_Form.LockFocus;
    try
     l_Flag := false;
     (l_Form.VCLWinControl as TvcmEntityForm).Container.InsertForm(l_Form);
     if l_Flag then
      l_Form.VCLWinControl.Show;
    finally
     l_Form.UnlockFocus;
    end;//try..finally
   end;//Supports(l_CloneList[l_Count], IvcmEntityForm, l_Form)
  end;//for l_Count
  // установим фокус
  l_Form := Get_CurrentMainForm;
  if Assigned(l_Form) and Assigned(l_Form.VCLWinControl) then
   (l_Form.VCLWinControl as TvcmMainForm).DoGiveFocusToZone;
 finally
  FreeAndNil(l_CloneList);
 end;//try..finally
//#UC END# *49955E9001A4_57D2C1600360_impl*
end;//TvcmDispatcher.ReinsertForms

procedure TvcmDispatcher.TileWindowsHorizontal(const aForms: IvcmEntityFormsIterable = nil);
 {* упорядочить открытые окна приложения горизонтально }
//#UC START# *49955E9F00CF_57D2C1600360_var*
//#UC END# *49955E9F00CF_57D2C1600360_var*
begin
//#UC START# *49955E9F00CF_57D2C1600360_impl*
 TileWindows(vcm_twHorizontal, aForms);
//#UC END# *49955E9F00CF_57D2C1600360_impl*
end;//TvcmDispatcher.TileWindowsHorizontal

procedure TvcmDispatcher.TileWindowsVertical(const aForms: IvcmEntityFormsIterable = nil);
 {* упорядочить открытые окна приложения ветикально }
//#UC START# *49955EAD0266_57D2C1600360_var*
//#UC END# *49955EAD0266_57D2C1600360_var*
begin
//#UC START# *49955EAD0266_57D2C1600360_impl*
 TileWindows(vcm_twVertical, aForms);
//#UC END# *49955EAD0266_57D2C1600360_impl*
end;//TvcmDispatcher.TileWindowsVertical

procedure TvcmDispatcher.CascadeWindows(const aForms: IvcmEntityFormsIterable = nil);
 {* расположить открытые окна каскадом }
//#UC START# *49955EBA00EB_57D2C1600360_var*
var
 lCurrentPoint: TPoint;
 lWidth: Integer;
 lHeight: Integer;
 lOffsetPoint  : TPoint;

 function lp_DoCascadeWindows(anItem: PIvcmEntityForm; anIndex: Integer): Boolean;
 var
  l_Form: IvcmEntityForm;
 begin
  l_Form := anItem^;
  try
   SetWindowPos(l_Form.VCLWinControl.Handle, HWND_TOP,
                lCurrentPoint.X, lCurrentPoint.Y,
                lWidth, lHeight,
                SWP_SHOWWINDOW);
   with lCurrentPoint do
   begin
    X := X + lOffsetPoint.X;
    Y := Y + lOffsetPoint.Y;
   end;//with lCurrentPoint
  finally
   l_Form := nil;
  end;//try..finally
 end;//lp_DoCascadeWindos
//#UC END# *49955EBA00EB_57D2C1600360_var*
begin
//#UC START# *49955EBA00EB_57D2C1600360_impl*
 PrepareWindows(aForms);
 lCurrentPoint := Point(GetCurrentMonitorRect.Left, GetCurrentMonitorRect.Top);
 with lOffsetPoint do
 begin
  // сдвиг вправо
  X := GetSystemMetrics(SM_CYCAPTION) + GetSystemMetrics(SM_CYSIZEFRAME);
  // сдвиг вниз
  Y := X;
 end;
 with GetCurrentMonitorRect do
 begin
  lHeight := ((Bottom - Top) div 4) * 3;
  lWidth := ((Right - Left) div 5) * 4;
 end;//with GetCurrentMonitorRect
 if (aForms <> nil) then
  aForms.IterateFormsF(l3L2IA(@lp_DoCascadeWindows))
 else
  f_MainForms.IterateAllF(l3L2IA(@lp_DoCascadeWindows));
//#UC END# *49955EBA00EB_57D2C1600360_impl*
end;//TvcmDispatcher.CascadeWindows

procedure TvcmDispatcher.CloseAllWindows(const aForms: IvcmEntityFormsIterable = nil;
 const aCurrent: IvcmEntityForm = nil);
 {* закрыть все открытые окна кроме текущего, если он не указан, то закрывается приложение }
//#UC START# *49955EC80182_57D2C1600360_var*
 function lp_DoCloseWindow(anItem: PIvcmEntityForm; anIndex: Integer): Boolean;
 begin
  if f_ClosingAllWindows or
    (anItem^ <> aCurrent) then
   anItem^.SafeClose;
  Result := True;
 end;//lp_DoCloseWindow

var
 l_Index: Integer;
//#UC END# *49955EC80182_57D2C1600360_var*
begin
//#UC START# *49955EC80182_57D2C1600360_impl*
 f_ClosingAllWindows := not Assigned(aCurrent);
 // clipboard содержит большой кусок информации, пользователь не хочет закрывать
 // приложение
 if f_ClosingAllWindows and
    (l3System.CheckClipboard(afw.Application.AskClearClipboardProc) = IDCancel) then
 begin
  f_ClosingAllWindows := False;
  Exit;
 end;
 // закрываем все кроме текущего или выходим
 if (aForms <> nil) then
  aForms.IterateFormsF(l3L2IA(@lp_DoCloseWindow))
 else
  f_MainForms.IterateAllF(l3L2IA(@lp_DoCloseWindow));
//#UC END# *49955EC80182_57D2C1600360_impl*
end;//TvcmDispatcher.CloseAllWindows

function TvcmDispatcher.Get_FormDispatcher: IvcmFormDispatcher;
//#UC START# *49955EE6038B_57D2C1600360get_var*
//#UC END# *49955EE6038B_57D2C1600360get_var*
begin
//#UC START# *49955EE6038B_57D2C1600360get_impl*
 Result := Self;
//#UC END# *49955EE6038B_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_FormDispatcher

function TvcmDispatcher.Get_History: IvcmHistory;
//#UC START# *49955F0C0129_57D2C1600360get_var*
var
 l_MainForm : TvcmMainForm;
//#UC END# *49955F0C0129_57D2C1600360get_var*
begin
//#UC START# *49955F0C0129_57D2C1600360get_impl*
 l_MainForm := Form;
 if (l_MainForm = nil) then
  Result := nil
 else
  Result := l_MainForm.History;
//#UC END# *49955F0C0129_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_History

function TvcmDispatcher.Get_ActiveEntity: IvcmEntity;
//#UC START# *49955F3902F7_57D2C1600360get_var*
var
 l_Form    : TCustomForm;
 l_EForm   : IvcmEntityForm;
 l_Control : TWinControl;
 l_Parent  : TWinControl;
 l_Container: IafwMainFormContainer;
 l_Menu: IvcmMainMenuForChromeLike;
//#UC END# *49955F3902F7_57D2C1600360get_var*
begin
//#UC START# *49955F3902F7_57D2C1600360get_impl*
 Result := nil;//f_ActiveEntity;//каждый раз заново определяем _ActiveEntity (временно)
 if (Result = nil) then
 begin
  l_Control := FindControl(Windows.GetFocus);
  if Supports(l_Control, IvcmMainMenuForChromeLike, l_Menu) then
  try
   // новое "вкладочное" главное меню забирает на себя фокус. Нам это не нужно. http://mdp.garant.ru/pages/viewpage.action?pageId=562611367
   // l_Control := f_FocusedControl
   // - фокус не прошел. Построили список, закрыли в нем панель поиска,
   // нажали в меню "файл" - "сохранить в мои документы". В f_FocusedControl - мусор.
   // http://mdp.garant.ru/pages/viewpage.action?pageId=565861782
   l_Control := l_Menu.FocusedControl;
   // - меню знает, что было в фокусе до него - видимо нам это и нужно
  finally
   l_Menu := nil;
  end;
  // else
  // f_FocusedControl := l_Control;
  if (l_Control = nil) and (Form <> nil) then
   l_Control := Form.ActiveControl;
  if Assigned(l_Control) then
  begin
   //Assert(not (l_Control Is TvtCustomPanel),
   //       'http://mdp.garant.ru/pages/viewpage.action?pageId=352452629&focusedCommentId=354683670#comment-354683670');
   // - не прокатил Assert :-(
   l_Parent := l_Control.Parent;
   if (l_Parent <> nil) AND not (l_Parent Is TCustomForm) then
    // - эта ветка нужна для контролов, которые лежат в Toolbar'е - чтобы транслировать
    //   операции той форме, к которой относится контрол.
    if Supports(l_Parent.Owner, IvcmEntityForm, l_EForm) AND
       not l_EForm.InClose then
     Result := l_EForm.Entity;
     //Supports(l_EForm, IvcmEntity, Result);
   if (Result = nil) then
   begin
    if (l_Control Is TvtCustomPanel) then
    begin
     // http://mdp.garant.ru/pages/viewpage.action?pageId=352452629&focusedCommentId=354683670#comment-354683670
     if (l_Control.ControlCount = 1) then
     begin
      if Supports(l_Control.Controls[0], IvcmEntityForm, l_EForm) then
       if l_EForm.IsBaloon then
        Result := l_EForm.Entity;
     end;//l_Control.ControlCount = 1
    end;//l_Control Is TvtCustomPanel
    if (Result = nil) then
    begin
     l_Form := afw.GetParentForm(l_Control);
     if not Supports(l_Form, IvcmEntityForm, l_EForm) OR
        not l_EForm.InClose then
      //Result := l_Form.Entity;
      Supports(l_Form, IvcmEntity, Result)
    end;//Result = nil
   end;//Result = nil
  end;//Assigned(l_Control)
  if not Assigned(Result) and (Form <> nil) then
   Result := Form.Entity;
 end;//Result = nil

 { СТАРЫЙ КОД:

   Result := f_ActiveEntity;
   if (Result = nil) then
    Result := Form As XIvcmEntity;

   Комментарий:
    Изменения сделаны для следующий ситуации:
     1. Открываем модальную форму (f_ActiveEntity = модальная форма);
     2. Закрываем модальную форму (f_ActiveEntity = nil);
     3. Активной форме приложения не пришло уведомление, что она активна
      f_ActiveEntity = nil, а на самом деле f_ActiveEntity = активной форме; }
 if Supports(Result, IafwMainFormContainer, l_Container) then
 try
  l_Form := l_Container.CurrentMainForm;
  if (l_Form <> nil) AND (l_Form is TvcmEntityForm) then
  begin
   Result := TvcmEntityForm(l_Form).As_IvcmEntityForm.Entity;
  end;
 finally
  l_Container := nil;
 end;
//#UC END# *49955F3902F7_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_ActiveEntity

function TvcmDispatcher.Get_ModulesCount: Integer;
//#UC START# *49955F6202E0_57D2C1600360get_var*
//#UC END# *49955F6202E0_57D2C1600360get_var*
begin
//#UC START# *49955F6202E0_57D2C1600360get_impl*
 Result := TvcmModule.GetModuleCount;
//#UC END# *49955F6202E0_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_ModulesCount

function TvcmDispatcher.Get_EntitiesCount: Integer;
//#UC START# *49955F8302CE_57D2C1600360get_var*
//#UC END# *49955F8302CE_57D2C1600360get_var*
begin
//#UC START# *49955F8302CE_57D2C1600360get_impl*
 Result := f_Entities.Count;
//#UC END# *49955F8302CE_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_EntitiesCount

function TvcmDispatcher.Get_Entity(anIndex: Integer): IvcmEntity;
//#UC START# *49955F930093_57D2C1600360get_var*
//#UC END# *49955F930093_57D2C1600360get_var*
begin
//#UC START# *49955F930093_57D2C1600360get_impl*
 Result := f_Entities[anIndex];
//#UC END# *49955F930093_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_Entity

function TvcmDispatcher.Get_IsRestoringAllSettings: Boolean;
//#UC START# *49955FB00036_57D2C1600360get_var*
//#UC END# *49955FB00036_57D2C1600360get_var*
begin
//#UC START# *49955FB00036_57D2C1600360get_impl*
 Result := f_RestoreAllSettings > 0;
//#UC END# *49955FB00036_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_IsRestoringAllSettings

function TvcmDispatcher.Get_InClosingAllWindows: Boolean;
//#UC START# *49955FBF02AD_57D2C1600360get_var*
//#UC END# *49955FBF02AD_57D2C1600360get_var*
begin
//#UC START# *49955FBF02AD_57D2C1600360get_impl*
 Result := f_ClosingAllWindows;
//#UC END# *49955FBF02AD_57D2C1600360get_impl*
end;//TvcmDispatcher.Get_InClosingAllWindows

function TvcmDispatcher.pm_GetIsLockActionUpdate: Boolean;
//#UC START# *49955FCE02AF_57D2C1600360get_var*
//#UC END# *49955FCE02AF_57D2C1600360get_var*
begin
//#UC START# *49955FCE02AF_57D2C1600360get_impl*
 Result := f_ActionUpdateCount > 0;
//#UC END# *49955FCE02AF_57D2C1600360get_impl*
end;//TvcmDispatcher.pm_GetIsLockActionUpdate

function TvcmDispatcher.pm_GetMainFormProvider: IvcmMainFormProvider;
//#UC START# *5461E0570220_57D2C1600360get_var*
//#UC END# *5461E0570220_57D2C1600360get_var*
begin
//#UC START# *5461E0570220_57D2C1600360get_impl*
 Result := IvcmMainFormProvider(f_MainFormProvider);
//#UC END# *5461E0570220_57D2C1600360get_impl*
end;//TvcmDispatcher.pm_GetMainFormProvider

procedure TvcmDispatcher.pm_SetMainFormProvider(const aValue: IvcmMainFormProvider);
//#UC START# *5461E0570220_57D2C1600360set_var*
//#UC END# *5461E0570220_57D2C1600360set_var*
begin
//#UC START# *5461E0570220_57D2C1600360set_impl*
 if (f_MainFormProvider <> Pointer(aValue)) then
  f_MainFormProvider := Pointer(aValue);
//#UC END# *5461E0570220_57D2C1600360set_impl*
end;//TvcmDispatcher.pm_SetMainFormProvider

procedure TvcmDispatcher.LockInOp;
 {* Игнорируем скобки BeginOp/EndOp }
//#UC START# *558A86490317_57D2C1600360_var*
//#UC END# *558A86490317_57D2C1600360_var*
begin
//#UC START# *558A86490317_57D2C1600360_impl*
 Inc(f_LockInOpCount);
//#UC END# *558A86490317_57D2C1600360_impl*
end;//TvcmDispatcher.LockInOp

procedure TvcmDispatcher.UnlockInOp;
 {* Игнорируем скобки BeginOp/EndOp }
//#UC START# *558A86710146_57D2C1600360_var*
//#UC END# *558A86710146_57D2C1600360_var*
begin
//#UC START# *558A86710146_57D2C1600360_impl*
 Assert(f_LockInOpCount > 0);
 Dec(f_LockInOpCount);
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

procedure TvcmDispatcher.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57D2C1600360_var*
//#UC END# *479731C50290_57D2C1600360_var*
begin
//#UC START# *479731C50290_57D2C1600360_impl*
 vcmFree(f_Aggregates);
 vcmFree(f_Entities);
 vcmFree(f_MainForms);
 vcmFree(f_ObjectsForFree);
 vcmFree(f_FormsForClose);
 vcmFree(f_DockManagers);
 vcmFree(f_InvalidateForms);
 vcmFree(f_UpdateForms);
 vcmFree(f_InvalidateCtrls);
 vcmFree(f_SaveLockCounter);
 vcmFree(f_LockListeners);
 vcmFree(f_FDListeners);
 f_ClosingAllWindows := False;
 f_MainFormProvider := nil;
 inherited;
//#UC END# *479731C50290_57D2C1600360_impl*
end;//TvcmDispatcher.Cleanup
{$IfEnd} // NOT Defined(NoVCM)

end.
