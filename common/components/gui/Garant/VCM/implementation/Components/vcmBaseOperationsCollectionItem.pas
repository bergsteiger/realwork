unit vcmBaseOperationsCollectionItem;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Components/vcmBaseOperationsCollectionItem.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM::Components::TvcmBaseOperationsCollectionItem
//
//
// Нарисовано не до конца
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces,
  vcmInterfaces,
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  vcmAction
  {$If not defined(NoVCL)}
  ,
  ActnList
  {$IfEnd} //not NoVCL
  ,
  vcmBase,
  vcmUserControls,
  vcmBaseOperationState,
  vcmOperationParams,
  vcmBaseOperationStates,
  vcmActiveControlsCollection
  {$If defined(XE)}
  ,
  Actions
  {$IfEnd} //XE
  ,
  vcmBaseCollectionItem
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
const
  { vcm_DefaultOperationOptions }
 vcm_DefaultOperationOptions = [vcm_ooShowInMainToolbar, vcm_ooShowInChildToolbar, vcm_ooShowInContextMenu, vcm_ooShowInMainMenu, vcm_ooShowInChildMenu];
  { Набор параметров по умолчанию для свойсва TvcmOperationsCollectionItem.Options }

type
 TvcmGetStateEvent = procedure (var State: TvcmOperationStateIndex) of object;

 TvcmContextTestEvent = vcmInterfaces.TvcmTestEvent;
  {* Вызывается в момент проверки доступности операции из контекстного меню }

 TvcmContextExecuteEvent = vcmBase.TvcmExecuteEvent;
  {* Вызывается при выполнении операции из контекстного меню }

 TvcmHandleType = (
   vcm_htContext
 , vcm_htGlobal
 , vcm_htControl
 );//TvcmHandleType

 TvcmHandleTypes = set of TvcmHandleType;

 TvcmBaseOperationsCollectionItemPrim = class(TvcmOperationParams)
 private
 // private fields
   f_GroupID : Integer;
   f_Enabled : Boolean;
   f_VisibleToUser : Integer;
   f_OpDef : IvcmOperationDef;
   f_FormGetState : TvcmControlGetStateEvent;
   f_FormTest : TvcmControlTestEvent;
   f_FormExecute : TvcmControlExecuteEvent;
   f_OperationID : Integer;
    {* Поле для свойства OperationID}
   f_ContextMenuWeight : Integer;
    {* Поле для свойства ContextMenuWeight}
   f_OperationType : TvcmOperationType;
    {* Поле для свойства OperationType}
   f_AutoLock : Boolean;
    {* Поле для свойства AutoLock}
   f_AutoFocus : Boolean;
    {* Поле для свойства AutoFocus}
   f_LongProcess : Boolean;
    {* Поле для свойства LongProcess}
   f_States : TvcmBaseOperationStates;
    {* Поле для свойства States}
   f_State : TvcmOperationStateIndex;
    {* Поле для свойства State}
   f_Controls : TvcmActiveControlsCollection;
    {* Поле для свойства Controls}
   f_OnGetState : TvcmGetStateEvent;
    {* Поле для свойства OnGetState}
   f_OnTest : TvcmTestEvent;
    {* Поле для свойства OnTest}
   f_OnExecute : TvcmExecuteEvent;
    {* Поле для свойства OnExecute}
   f_OnContextTest : TvcmContextTestEvent;
    {* Поле для свойства OnContextTest}
   f_OnContextExecute : TvcmContextExecuteEvent;
    {* Поле для свойства OnContextExecute}
   f_IsCaptionUnique : Boolean;
    {* Поле для свойства IsCaptionUnique}
   f_SaveShortcut : TShortCut;
    {* Поле для свойства SaveShortcut}
   f_SaveSecondaryShortcuts : AnsiString;
    {* Поле для свойства SaveSecondaryShortcuts}
   f_IsDefault : Boolean;
    {* Поле для свойства IsDefault}
 protected
 // property methods
   function pm_GetContextMenuWeight: Integer;
   procedure pm_SetContextMenuWeight(aValue: Integer);
   function pm_GetOptions: TvcmOperationOptions; virtual;
   procedure pm_SetOptions(aValue: TvcmOperationOptions); virtual;
   function pm_GetOperationType: TvcmOperationType; virtual;
   procedure pm_SetOperationType(aValue: TvcmOperationType); virtual;
   function pm_GetStates: TvcmBaseOperationStates; virtual;
   procedure pm_SetStates(aValue: TvcmBaseOperationStates); virtual;
   procedure pm_SetState(const aValue: TvcmOperationStateIndex);
   function pm_GetIsDefault: Boolean; virtual;
   procedure pm_SetIsDefault(aValue: Boolean); virtual;
   function pm_GetVisibleToUser: Boolean;
   function pm_GetOperationDef: IvcmOperationDef;
   {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   function pm_GetCategory: AnsiString; virtual;
   {$IfEnd} //not DesignTimeLibrary AND not NoVCM
   function pm_GetGroupID: Integer; virtual;
   procedure pm_SetGroupID(aValue: Integer); virtual;
   function pm_GetExcludeUserTypes: TvcmEffectiveUserTypes; virtual;
   procedure pm_SetExcludeUserTypes(aValue: TvcmEffectiveUserTypes); virtual;
   function pm_GetCurrentState: TvcmBaseOperationState;
   function pm_GetLinked: Boolean; virtual;
   procedure pm_SetLinked(aValue: Boolean); virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure BeforeAddToCache; override;
     {* функция, вызываемая перед добавлением объекта в кэш повторного использования. }
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
   procedure ChangeName(const anOld: AnsiString;
     const aNew: AnsiString); override;
   procedure ChangeCaption(const anOld: AnsiString;
     const aNew: AnsiString); override;
 public
 // overridden public methods
   procedure Assign(Source: TPersistent); override;
   constructor Create(aCollection: TCollection); override;
   function MakeID(const aName: AnsiString): Integer; override;
   function GetID: Integer; override;
   function QueryInterface(const IID: TGUID;
    out Obj): HResult; override;
 protected
 // protected fields
   f_Options : TvcmOperationOptions;
 protected
 // protected methods
   function GetDefaultOptions: TvcmOperationOptions; virtual;
   function GetGroupIDStored: Boolean; virtual;
   function GetOperationTypeStored: Boolean; virtual;
   function GetIsDefaultStored: Boolean; virtual;
   procedure OnSecondaryShortCutsChange(Sender: TObject);
     {* TNotifyEvent is used for events that do not require parameters. }
   function IsHandledToControl: Boolean;
     {* операция опубликована компонентом }
   function GetLinkedAction: TvcmAction;
     {* Action к которому привязана операция }
   function ControllerCommand: Word;
     {* идентификатор комманды-shortcut }
   function ParentID: Integer;
   function IsLinkedToModule: Boolean;
   class procedure ResetShortCutHandler(var aValue: TShortCut;
     aCommandID: Word = 0);
   procedure DoFormGetState(var State: TvcmOperationStateIndex);
   procedure DoFormTest(const aParams: IvcmTestParamsPrim);
   procedure DoFormExecute(const aParams: IvcmExecuteParams);
   procedure FakeControlTest(const aParams: IvcmTestParamsPrim);
   procedure ClearOp;
     {* Сигнатура метода ClearOp }
   procedure SetShortCuts(aShortCut: TShortCut;
     aSecondaryShortCuts: TShortCutList); virtual;
   class function StatesClass: RvcmBaseOperationStates; virtual;
   function OwnerUserType: TvcmEffectiveUserType;
     {* Возвращает пользовательский тип "формы" на которой определена операция }
   function OperationTypeStored: Boolean;
     {* "Функция определяющая, что свойство OperationType сохраняется" }
   function IsDefaultStored: Boolean;
     {* "Функция определяющая, что свойство IsDefault сохраняется" }
   function GroupIDStored: Boolean;
     {* "Функция определяющая, что свойство GroupID сохраняется" }
 public
 // public methods
   function OwnerForm: TCustomForm;
     {* Возвращает "форму" на которой определена операция }
    {$If defined(XE) AND not defined(NoVCM)}
   procedure ReplaceShortCuts(aShortCut: TShortCut;
     aSecondaryShortCuts: TCustomShortCutList); overload; 
    {$IfEnd} //XE AND not NoVCM
    {$If not defined(NoVCM) AND not defined(XE)}
   procedure ReplaceShortCuts(aShortCut: TShortCut;
     aSecondaryShortCuts: TShortCutList); overload; 
    {$IfEnd} //not NoVCM AND not XE
   procedure StoreDesignTimeShortcuts;
     {* Сигнатура метода StoreDesignTimeShortcuts }
   function SomePropStored: Boolean;
   procedure RemoveShortCut(aShortCut: TShortCut); virtual;
   procedure UnlinkControl(aControl: TComponent);
   function Handled(aTypes: TvcmHandleTypes): Boolean; virtual;
   procedure Operation(aControl: TComponent;
     const aTarget: IUnknown;
     aMode: TvcmOperationMode;
     const aParams: IvcmParams;
     aForce: Boolean);
     {* Выполнение операции }
   procedure PublishOp(aControl: TComponent;
     anExecute: TvcmControlExecuteEvent;
     aTest: TvcmControlTestEvent;
     aGetState: TvcmControlGetStateEvent); overload; 
     {* опубликовать операцию }
   procedure PublishOp(aControl: TComponent;
     anExecute: TvcmExecuteEvent;
     aTest: TvcmControlTestEvent;
     aGetState: TvcmControlGetStateEvent); overload; 
     {* опубликовать операцию }
 public
 // public properties
   property OperationID: Integer
     read f_OperationID;
   property ContextMenuWeight: Integer
     read pm_GetContextMenuWeight
     write pm_SetContextMenuWeight;
   property Options: TvcmOperationOptions
     read pm_GetOptions
     write pm_SetOptions;
   property OperationType: TvcmOperationType
     read pm_GetOperationType
     write pm_SetOperationType
     stored OperationTypeStored;
   property AutoLock: Boolean
     read f_AutoLock
     write f_AutoLock;
   property AutoFocus: Boolean
     read f_AutoFocus
     write f_AutoFocus;
     {* Установка фокуса до выполнения операции.

Если AutoFocus = True, перед выполнением операции, фокус передаётся форме или контролу, с которым связана эта операция }
   property LongProcess: Boolean
     read f_LongProcess
     write f_LongProcess;
     {* Обрамление выполнения операции курсором crHourGlass. Нужно только для длительных внутренних (vcm_otInternal) операций, т.к. все вызовы через Action и так обрамлены подобным образом.

Если LongProcess = True, перед выполнением операции курсор заменяется на crHourGlass, а после выполнения возвращается к первоначальному виду }
   property States: TvcmBaseOperationStates
     read pm_GetStates
     write pm_SetStates;
   property State: TvcmOperationStateIndex
     read f_State
     write pm_SetState;
   property Controls: TvcmActiveControlsCollection
     read f_Controls;
   property OnGetState: TvcmGetStateEvent
     read f_OnGetState
     write f_OnGetState;
   property OnTest: TvcmTestEvent
     read f_OnTest
     write f_OnTest;
     {* Вызывается для перерисовки состояния операции.

Данный обработчик вызывается для определения доступности операции. В массиве aParams можно вернуть изменившее состояние.

Индекс параметра   Тип        Значение
-----------------  ---------  --------------------------------
vcm_opEnabled      Boolean    Доступность выполнения операции
vcm_opVisible      Boolean    Видимость операции в меню и на панели инструментов
vcm_opChecked      Boolean    Операция помечена
vcm_opLongHint     AnsiString     Текст подсказки, отображаемой в статусной строке
vcm_opCaption      AnsiString     Заголовок пункта меню

Для типа операции vcm_otCombo в aParams.Op.SubItems нужно вернуть список строк, представляющий список элементов выпадающего списка. }
   property OnExecute: TvcmExecuteEvent
     read f_OnExecute
     write f_OnExecute;
     {* Обработчик операции. Вызывается из меню главной формы или панели инструментов. }
   property OnContextTest: TvcmContextTestEvent
     read f_OnContextTest
     write f_OnContextTest;
     {* Вызывается из контекстного меню.
          
Данный обработчик вызывается для определения доступности операции. В массиве aParams можно вернуть изменившее состояние.

Индекс параметра   Тип        Значение
-----------------  ---------  --------------------------------
vcm_opEnabled      Boolean    Доступность выполнения операции
vcm_opVisible      Boolean    Видимость операции в меню и на панели инструментов
vcm_opChecked      Boolean    Операция помечена
vcm_opLongHint     AnsiString     Текст подсказки, отображаемой в статусной строке
vcm_opCaption      AnsiString     Заголовок пункта меню

Для типа операции vcm_otCombo в aParams.Op.SubItems нужно вернуть список строк, представляющий список элементов выпадающего списка. }
   property OnContextExecute: TvcmContextExecuteEvent
     read f_OnContextExecute
     write f_OnContextExecute;
     {* Обработчик операции. Вызывается из контекстного меню. }
   property IsCaptionUnique: Boolean
     read f_IsCaptionUnique
     write f_IsCaptionUnique;
   property SaveShortcut: TShortCut
     read f_SaveShortcut;
   property SaveSecondaryShortcuts: AnsiString
     read f_SaveSecondaryShortcuts;
   property IsDefault: Boolean
     read pm_GetIsDefault
     write pm_SetIsDefault
     stored IsDefaultStored;
   property VisibleToUser: Boolean
     read pm_GetVisibleToUser;
   property OperationDef: IvcmOperationDef
     read pm_GetOperationDef;
     {* Описатель операции }
   {$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
   property Category: AnsiString
     read pm_GetCategory;
     {* Категория операции.
Задается на стадии проектирования формы. Используется для группировки операций. }
   {$IfEnd} //not DesignTimeLibrary AND not NoVCM
   property GroupID: Integer
     read pm_GetGroupID
     write pm_SetGroupID
     stored GroupIDStored;
   property ExcludeUserTypes: TvcmEffectiveUserTypes
     read pm_GetExcludeUserTypes
     write pm_SetExcludeUserTypes;
   property CurrentState: TvcmBaseOperationState
     read pm_GetCurrentState;
   property Linked: Boolean
     read pm_GetLinked
     write pm_SetLinked;
 end;//TvcmBaseOperationsCollectionItemPrim

//#UC START# *4D7A109601C2ci*
//#UC END# *4D7A109601C2ci*
//#UC START# *4D7A109601C2cit*
//#UC END# *4D7A109601C2cit*
 TvcmBaseOperationsCollectionItem = class(TvcmBaseOperationsCollectionItemPrim)
//#UC START# *4D7A109601C2publ*
   published
    property AutoLock;
    property AutoFocus;
    property LongProcess;
   published
    property OnTest;
    property OnExecute;
    property OnContextTest;
    property OnContextExecute;
//#UC END# *4D7A109601C2publ*
 end;//TvcmBaseOperationsCollectionItem
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  vcmInternalConst,
  vcmEntitiesCollectionItem,
  OvcCmd,
  OvcController
  {$If not defined(NoVCL)}
  ,
  Menus
  {$IfEnd} //not NoVCL
  ,
  vcmModulesCollectionItem,
  vcmBaseEntitiesCollectionItem,
  vcmModuleDef,
  vcmOVCCommands,
  vcmModuleAction,
  vcmEntityAction,
  afwFacade,
  l3Types,
  vcmActiveControlsCollectionItem
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  TypInfo,
  vcmBaseOperationDef,
  vcmUtils,
  vcmRepositoryEx,
  vcmModule,

  vcmEntityForm,
  vcmBaseMenuManager,
  vcmContainerForm
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmBaseOperationsCollectionItemPrim

function TvcmBaseOperationsCollectionItemPrim.GetDefaultOptions: TvcmOperationOptions;
//#UC START# *5620E1270164_5620CFFC0045_var*
var
 l_Owner : TObject;
//#UC END# *5620E1270164_5620CFFC0045_var*
begin
//#UC START# *5620E1270164_5620CFFC0045_impl*
 if (OperationType in vcm_HiddenOperations) then
  Result := []
 else
 if IsLinkedToModule then
  Result := []
 else
 if Handled([vcm_htGlobal, vcm_htControl]) then
 begin
  Result := vcm_DefaultOperationOptions;
  if (Collection <> nil) then
  begin
   l_Owner := Collection.Owner;
   if (l_Owner Is TvcmEntitiesCollectionItem) then
   begin
    // - это операция сущности
    if (TvcmEntitiesCollectionItem(l_Owner).Controls <> nil) AND
       not TvcmEntitiesCollectionItem(l_Owner).Controls.LinkedToForm then
    begin
     // - сущность привязана к контролу, а не к форме целиком
     Exclude(Result, vcm_ooShowInMainToolbar);
     Exclude(Result, vcm_ooShowInMainMenu);
    end;//not TvcmEntitiesCollectionItem(l_Owner).Controls.LinkedToForm
   end;//l_Owner Is TvcmEntitiesCollectionItem
  end;//Collection <> nil
  if IsHandledToControl then
  begin
   Exclude(Result, vcm_ooShowInChildToolbar);
   Exclude(Result, vcm_ooShowInChildMenu);
  end;//HandledOnlyByControl
 end//Assigned(f_OnExecute)
 else
 if Handled([vcm_htContext]) then
  Result := [vcm_ooShowInContextMenu]
 else
  Result := [];
//#UC END# *5620E1270164_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetDefaultOptions

function TvcmBaseOperationsCollectionItemPrim.GetGroupIDStored: Boolean;
//#UC START# *5620E2C30048_5620CFFC0045_var*
//#UC END# *5620E2C30048_5620CFFC0045_var*
begin
//#UC START# *5620E2C30048_5620CFFC0045_impl*
 Result := (f_GroupID > 0);
//#UC END# *5620E2C30048_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetGroupIDStored

function TvcmBaseOperationsCollectionItemPrim.GetOperationTypeStored: Boolean;
//#UC START# *5620E36701EE_5620CFFC0045_var*
//#UC END# *5620E36701EE_5620CFFC0045_var*
begin
//#UC START# *5620E36701EE_5620CFFC0045_impl*
 Result := (f_OperationType <> vcm_otButton);
//#UC END# *5620E36701EE_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetOperationTypeStored

function TvcmBaseOperationsCollectionItemPrim.GetIsDefaultStored: Boolean;
//#UC START# *5620E5C101B2_5620CFFC0045_var*
//#UC END# *5620E5C101B2_5620CFFC0045_var*
begin
//#UC START# *5620E5C101B2_5620CFFC0045_impl*
 Result := (f_IsDefault <> False);
//#UC END# *5620E5C101B2_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetIsDefaultStored

procedure TvcmBaseOperationsCollectionItemPrim.OnSecondaryShortCutsChange(Sender: TObject);
//#UC START# *5620E5FF00DA_5620CFFC0045_var*
//#UC END# *5620E5FF00DA_5620CFFC0045_var*
begin
//#UC START# *5620E5FF00DA_5620CFFC0045_impl*
 SetShortCuts(ShortCut, SecondaryShortCuts);
//#UC END# *5620E5FF00DA_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.OnSecondaryShortCutsChange

function TvcmBaseOperationsCollectionItemPrim.IsHandledToControl: Boolean;
//#UC START# *5620E72703A2_5620CFFC0045_var*
//#UC END# *5620E72703A2_5620CFFC0045_var*
begin
//#UC START# *5620E72703A2_5620CFFC0045_impl*
 Result := Handled([vcm_htControl]) and not Handled([vcm_htGlobal, vcm_htContext]);
//#UC END# *5620E72703A2_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.IsHandledToControl

function TvcmBaseOperationsCollectionItemPrim.GetLinkedAction: TvcmAction;
//#UC START# *5620E6910372_5620CFFC0045_var*
//#UC END# *5620E6910372_5620CFFC0045_var*
begin
//#UC START# *5620E6910372_5620CFFC0045_impl*
 Result := nil;
 if Assigned(Collection) then
  if (Collection.Owner is TvcmModulesCollectionItem) then
   with TvcmModulesCollectionItem(Collection.Owner) do
    Result := TvcmModuleAction.Make(Dispatcher.GetModuleByID(ModuleID).ModuleDef, OperationDef)
  else
  if (Collection.Owner is TvcmBaseEntitiesCollectionItem) then
   with TvcmBaseEntitiesCollectionItem(Collection.Owner) do
    Result := TvcmEntityAction.Make(EntityDef, OperationDef)
  else
  if (Collection.Owner is TvcmCustomModuleDef) then
   with TvcmCustomModuleDef(Collection.Owner) do
    if Assigned(Owner) and (Owner is TvcmModule) then
     with TvcmModule(Owner) do
      Result := TvcmModuleAction.Make(GetModuleDef, OperationDef);
//#UC END# *5620E6910372_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetLinkedAction

function TvcmBaseOperationsCollectionItemPrim.ControllerCommand: Word;
//#UC START# *5620E66E0367_5620CFFC0045_var*
var
 l_ParentID: Integer;
//#UC END# *5620E66E0367_5620CFFC0045_var*
begin
//#UC START# *5620E66E0367_5620CFFC0045_impl*
 Result := 0;
 l_ParentID := ParentID;
 if (l_ParentID > 0) then
  Result := vcmCommandID(l_ParentID, false, OperationID)
 else
 if (l_ParentID < 0) then
  Result := vcmCommandID(-l_ParentID, true, OperationID)
 else
  Assert(false, 'Операция не привязана ни к сущности, ни к модулю');
//#UC END# *5620E66E0367_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ControllerCommand

function TvcmBaseOperationsCollectionItemPrim.ParentID: Integer;
//#UC START# *5620E65A00D3_5620CFFC0045_var*
//#UC END# *5620E65A00D3_5620CFFC0045_var*
begin
//#UC START# *5620E65A00D3_5620CFFC0045_impl*
 Result := 0;
 if Assigned(Collection) then
  if (Collection.Owner is TvcmModulesCollectionItem) then
   with TvcmModulesCollectionItem(Collection.Owner) do
    Result := -ModuleID
  else
  if (Collection.Owner is TvcmBaseEntitiesCollectionItem) then
   with TvcmBaseEntitiesCollectionItem(Collection.Owner) do
    Result := EntityID
  else
  if (Collection.Owner is TvcmCustomModuleDef) then
   with TvcmCustomModuleDef(Collection.Owner) do
    if Assigned(Owner) and (Owner is TvcmModule) then
     with TvcmModule(Owner) do
      Result := -ID;
//#UC END# *5620E65A00D3_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ParentID

function TvcmBaseOperationsCollectionItemPrim.IsLinkedToModule: Boolean;
//#UC START# *5620E643039B_5620CFFC0045_var*
//#UC END# *5620E643039B_5620CFFC0045_var*
begin
//#UC START# *5620E643039B_5620CFFC0045_impl*
 Result := false;
 if Assigned(Collection) then
  if (Collection.Owner is TvcmModulesCollectionItem) then
   Result := true
  else
  if (Collection.Owner is TvcmBaseEntitiesCollectionItem) then
   Result := false
  else
  if (Collection.Owner is TvcmCustomModuleDef) then
   with TvcmCustomModuleDef(Collection.Owner) do
    if Assigned(Owner) and (Owner is TvcmModule) then
      Result := true;
//#UC END# *5620E643039B_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.IsLinkedToModule

class procedure TvcmBaseOperationsCollectionItemPrim.ResetShortCutHandler(var aValue: TShortCut;
  aCommandID: Word = 0);
//#UC START# *5620E6250019_5620CFFC0045_var*
var
 l_Controller: TOvcController;
 l_Key: Word;
 l_Shift: TShiftState;
//#UC END# *5620E6250019_5620CFFC0045_var*
begin
//#UC START# *5620E6250019_5620CFFC0045_impl*
 if (aValue <> 0) then
 begin
  l_Controller := GetDefController;
  if Assigned(l_Controller) then
   with l_Controller.EntryCommands do
   begin
    if GetCommandTableIndex(c_vcmTableName) < 0 then
     CreateCommandTable(c_vcmTableName, true);
    if (aCommandID = 0) then
    begin
     ShortCutToKey(aValue, l_Key, l_Shift);
     DeleteCommand(c_vcmTableName, l_Key, vcmByteShift(l_Shift), 0, 0);
    end
    else
    begin
     ShortCutToKey(aValue, l_Key, l_Shift);
     try
      AddCommand(c_vcmTableName, l_Key, vcmByteShift(l_Shift), 0, 0, aCommandID);
     except
      aValue := 0;
     end;//try..except
    end;//aCommandID = 0
   end;//l_Controller.EntryCommands
 end;//aValue <> 0
//#UC END# *5620E6250019_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ResetShortCutHandler

procedure TvcmBaseOperationsCollectionItemPrim.DoFormGetState(var State: TvcmOperationStateIndex);
//#UC START# *5620E7B10292_5620CFFC0045_var*
//#UC END# *5620E7B10292_5620CFFC0045_var*
begin
//#UC START# *5620E7B10292_5620CFFC0045_impl*
 f_FormGetState(State);
//#UC END# *5620E7B10292_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.DoFormGetState

procedure TvcmBaseOperationsCollectionItemPrim.DoFormTest(const aParams: IvcmTestParamsPrim);
//#UC START# *5620E7CC00CF_5620CFFC0045_var*
//#UC END# *5620E7CC00CF_5620CFFC0045_var*
begin
//#UC START# *5620E7CC00CF_5620CFFC0045_impl*
 f_FormTest(aParams);
//#UC END# *5620E7CC00CF_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.DoFormTest

procedure TvcmBaseOperationsCollectionItemPrim.DoFormExecute(const aParams: IvcmExecuteParams);
//#UC START# *5620E7E70331_5620CFFC0045_var*
//#UC END# *5620E7E70331_5620CFFC0045_var*
begin
//#UC START# *5620E7E70331_5620CFFC0045_impl*
 Assert(Assigned(f_FormExecute));
 f_FormExecute(aParams);
//#UC END# *5620E7E70331_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.DoFormExecute

procedure TvcmBaseOperationsCollectionItemPrim.FakeControlTest(const aParams: IvcmTestParamsPrim);
//#UC START# *5620E802035A_5620CFFC0045_var*
//#UC END# *5620E802035A_5620CFFC0045_var*
begin
//#UC START# *5620E802035A_5620CFFC0045_impl*
//#UC END# *5620E802035A_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.FakeControlTest

procedure TvcmBaseOperationsCollectionItemPrim.ClearOp;
//#UC START# *5620E8DC016C_5620CFFC0045_var*
var
 l_Op: IvcmOpHolder;
//#UC END# *5620E8DC016C_5620CFFC0045_var*
begin
//#UC START# *5620E8DC016C_5620CFFC0045_impl*
 if Supports(f_OpDef, IvcmOpHolder, l_Op) then
 try
  l_Op.ClearOp;
 finally
  l_Op := nil;
 end;//try..finally
 f_OpDef := nil;
//#UC END# *5620E8DC016C_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ClearOp

procedure TvcmBaseOperationsCollectionItemPrim.SetShortCuts(aShortCut: TShortCut;
  aSecondaryShortCuts: TShortCutList);
//#UC START# *5620E8B900F5_5620CFFC0045_var*
//#UC END# *5620E8B900F5_5620CFFC0045_var*
begin
//#UC START# *5620E8B900F5_5620CFFC0045_impl*
//#UC END# *5620E8B900F5_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.SetShortCuts

class function TvcmBaseOperationsCollectionItemPrim.StatesClass: RvcmBaseOperationStates;
//#UC START# *5620E87503A8_5620CFFC0045_var*
//#UC END# *5620E87503A8_5620CFFC0045_var*
begin
//#UC START# *5620E87503A8_5620CFFC0045_impl*
 Result := TvcmBaseOperationStates;
//#UC END# *5620E87503A8_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.StatesClass

function TvcmBaseOperationsCollectionItemPrim.OwnerUserType: TvcmEffectiveUserType;
//#UC START# *5620E8300061_5620CFFC0045_var*
var
 l_Form: TvcmEntityForm;
//#UC END# *5620E8300061_5620CFFC0045_var*
begin
//#UC START# *5620E8300061_5620CFFC0045_impl*
 Result := 0;
 l_Form := TvcmEntityForm(OwnerForm);
 if l_Form <> nil then
  Result := l_Form.UserType;
//#UC END# *5620E8300061_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.OwnerUserType

function TvcmBaseOperationsCollectionItemPrim.OwnerForm: TCustomForm;
//#UC START# *5620EED40232_5620CFFC0045_var*
var
 l_Col: TCollection;
 l_Ow: TPersistent;
 l_Form: TCustomForm;
//#UC END# *5620EED40232_5620CFFC0045_var*
begin
//#UC START# *5620EED40232_5620CFFC0045_impl*
 Result := nil;
 l_Col := Collection;
 if (l_Col <> nil) then
 begin
  l_Ow := l_Col.Owner;
  if (l_Ow Is TvcmEntitiesCollectionItem) then
  begin
   l_Col := TvcmEntitiesCollectionItem(l_Ow).Collection;
   if (l_Col <> nil) then
   begin
    l_Ow := l_Col.Owner;
    if (l_Ow <> nil) then
     Result := afw.GetParentForm(l_Ow);
   end;//l_Col <> nil
  end;//l_Ow Is vcmEntitiesCollectionItem
 end;//l_Col <> nil
//#UC END# *5620EED40232_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.OwnerForm

{$If defined(XE) AND not defined(NoVCM)}
procedure TvcmBaseOperationsCollectionItemPrim.ReplaceShortCuts(aShortCut: TShortCut;
  aSecondaryShortCuts: TCustomShortCutList);
//#UC START# *5620EF040199_5620CFFC0045_var*
//#UC END# *5620EF040199_5620CFFC0045_var*
begin
//#UC START# *5620EF040199_5620CFFC0045_impl*
 SetShortCuts(aShortCut, TShortCutList(aSecondaryShortCuts));
//#UC END# *5620EF040199_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ReplaceShortCuts
{$IfEnd} //XE AND not NoVCM

{$If not defined(NoVCM) AND not defined(XE)}
procedure TvcmBaseOperationsCollectionItemPrim.ReplaceShortCuts(aShortCut: TShortCut;
  aSecondaryShortCuts: TShortCutList);
//#UC START# *5620EF9D02F1_5620CFFC0045_var*
//#UC END# *5620EF9D02F1_5620CFFC0045_var*
begin
//#UC START# *5620EF9D02F1_5620CFFC0045_impl*
 SetShortCuts(aShortCut, TShortCutList(aSecondaryShortCuts));
//#UC END# *5620EF9D02F1_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ReplaceShortCuts
{$IfEnd} //not NoVCM AND not XE

procedure TvcmBaseOperationsCollectionItemPrim.StoreDesignTimeShortcuts;
//#UC START# *5620F0050158_5620CFFC0045_var*
//#UC END# *5620F0050158_5620CFFC0045_var*
begin
//#UC START# *5620F0050158_5620CFFC0045_impl*
 f_SaveShortcut := Shortcut;
 f_SaveSecondaryShortcuts := SecondaryShortCuts.Text;
//#UC END# *5620F0050158_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.StoreDesignTimeShortcuts

function TvcmBaseOperationsCollectionItemPrim.SomePropStored: Boolean;
//#UC START# *5620F09B013E_5620CFFC0045_var*
//#UC END# *5620F09B013E_5620CFFC0045_var*
begin
//#UC START# *5620F09B013E_5620CFFC0045_impl*
 Result := OperationTypeStored OR GroupIDStored OR
           IsDefaultStored or vcmHasSetEvent(Self);
//#UC END# *5620F09B013E_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.SomePropStored

procedure TvcmBaseOperationsCollectionItemPrim.RemoveShortCut(aShortCut: TShortCut);
//#UC START# *5620F16701DD_5620CFFC0045_var*
//#UC END# *5620F16701DD_5620CFFC0045_var*
begin
//#UC START# *5620F16701DD_5620CFFC0045_impl*
 Assert(false);
//#UC END# *5620F16701DD_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.RemoveShortCut

procedure TvcmBaseOperationsCollectionItemPrim.UnlinkControl(aControl: TComponent);
//#UC START# *5620F28501E2_5620CFFC0045_var*
//#UC END# *5620F28501E2_5620CFFC0045_var*
begin
//#UC START# *5620F28501E2_5620CFFC0045_impl*
 if (f_Controls <> nil) then
  f_Controls.UnlinkControl(aControl);
//#UC END# *5620F28501E2_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.UnlinkControl

function TvcmBaseOperationsCollectionItemPrim.Handled(aTypes: TvcmHandleTypes): Boolean;
//#UC START# *5620F2B50162_5620CFFC0045_var*
var
 l_Index: Integer;
//#UC END# *5620F2B50162_5620CFFC0045_var*
begin
//#UC START# *5620F2B50162_5620CFFC0045_impl*
 {$IfNDef DesignTimeLibrary}
 Result := ((vcm_htGlobal in aTypes) and Assigned(f_OnExecute)) or
           ((vcm_htContext in aTypes) and Assigned(f_OnContextExecute));
 {$Else  DesignTimeLibrary}
 Result := ((vcm_htGlobal in aTypes) and (GetMethodProp(Self, 'OnExecute').Code <> nil)) or
           ((vcm_htContext in aTypes) and (GetMethodProp(Self, 'OnContextExecute').Code <> nil));
 {$EndIf DesignTimeLibrary}

 if not Result and (vcm_htControl in aTypes) and
    ((Controls <> nil) AND (Controls.Count > 0)) then
  for l_Index := 0 to Pred(Controls.Count) do
   if Assigned(TvcmActiveControlsCollectionItem(Controls.Items[l_Index]).OnExecute) then
   begin
    Result := True;
    break;
   end;
//#UC END# *5620F2B50162_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.Handled

procedure TvcmBaseOperationsCollectionItemPrim.Operation(aControl: TComponent;
  const aTarget: IUnknown;
  aMode: TvcmOperationMode;
  const aParams: IvcmParams;
  aForce: Boolean);
//#UC START# *5620F10C0381_5620CFFC0045_var*
var
 l_FD: IvcmFormDispatcher;
 l_AL: Boolean;
 l_State: TvcmOperationStateIndex;
 l_CurState: TvcmBaseOperationState;
 l_Form: TvcmEntityForm;
 l_ParentForm: TCustomForm;
 {$IfDef vcmNeedL3}
 l_Test: TvcmTestEvent;
 l_TestM: Tl3Method absolute l_Test;
 {$EndIf vcmNeedL3}
 l_Action: TvcmAction;
 l_ActionParams : IvcmTestParams;
 l_Control: TvcmActiveControlsCollectionItem;
 l_Cursor: TCursor;
 l_IsOpExcluded : Boolean;
 l_Part: IvcmExecuteParams;
 l_TPart: IvcmTestParams;
 l_Enabled: Boolean;
//#UC END# *5620F10C0381_5620CFFC0045_var*
begin
//#UC START# *5620F10C0381_5620CFFC0045_impl*
 Assert(Ord(AMode) <= Ord(High(TvcmOperationMode))); 
 l_FD := vcmDispatcher.FormDispatcher;
 l_AL := AutoLock AND (l_FD <> nil) AND (aMode in vcm_omExecutes);
 if l_AL then
  l_FD.Lock;
 try
  aParams.Target := aTarget;
  aParams.Control := aControl;
  if (Controls = nil) then
   l_Control := nil
  else
   l_Control := Controls.FindItemByControl(aControl) As TvcmActiveControlsCollectionItem;
  Case aMode of
   vcm_omTest :
   begin
    l_TPart := aParams.TestPart;
    if (l_Control = nil) then
     l_TPart.SetControlEvent(nil)
    else
    if Assigned(l_Control.OnTest) then
     l_TPart.SetControlEvent(l_Control.OnTest)
    else
     l_TPart.SetControlEvent(FakeControlTest);
    aParams.DoneStatus := vcm_dsDone;
    if not aForce AND l_FD.Locked then
     Exit;
    if Assigned(f_OnGetState) then
    begin
     l_State := State;
     f_OnGetState(l_State);
     State := l_State;
    end;//Assigned(f_OnGetState)
    l_CurState := CurrentState;
    l_IsOpExcluded := (ExcludeUserTypes <> []) AND
     (OwnerUserType in ExcludeUserTypes);
    if l_IsOpExcluded then
    begin
     l_TPart.Op.Flag[vcm_ofEnabled] := false;
     aParams.DoneStatus := vcm_dsExcludedInUserType;
    end//l_IsOpExcluded
    else
    begin
     if (l_CurState = nil) then
      l_TPart.Op.Flag[vcm_ofEnabled] := true
     else
      l_TPart.Op.Flag[vcm_ofEnabled] := l_CurState.Enabled;
    end;//ExcludeUserTypes <> []
    if (OperationType in vcm_HiddenOperations) then
     l_TPart.Op.Flag[vcm_ofVisible] := false
    else
    if (l_CurState <> nil) then
     l_TPart.Op.Flag[vcm_ofVisible] := l_CurState.Visible;
    if (l_CurState = nil) then
    begin
     l_TPart.Op.Hint := vcmCStr(Hint);
     l_TPart.Op.LongHint := vcmCStr(LongHint);
     l_TPart.Op.ShortCut := Integer(ShortCut);
     l_TPart.Op.ImageIndex := Integer(ImageIndex);
    end//l_CurState = nil
    else
    begin
     l_TPart.Op.Caption := vcmCStr(l_CurState.Caption);
     l_TPart.Op.Flag[vcm_ofChecked] := l_CurState.Checked;
     l_TPart.Op.Hint := vcmCStr(l_CurState.Hint);
     l_TPart.Op.LongHint := vcmCStr(l_CurState.LongHint);
     if (l_CurState.ShortCut = 0) then
      l_TPart.Op.ShortCut := Integer(ShortCut)
     else
      l_TPart.Op.ShortCut := Integer(l_CurState.ShortCut);
     l_TPart.Op.ImageIndex := Integer(l_CurState.ImageIndex);
    end;//l_CurState = nil
    if (aTarget <> nil) and Assigned(f_OnContextTest) then
     f_OnContextTest(l_TPart)
    else//(aTarget <> nil) and Assigned(f_OnContextTest)
    if Assigned(f_OnTest) and not l_IsOpExcluded then
    begin
     {$IfDef vcmNeedL3}
     l_Test := f_OnTest;
     if not (TObject(l_TestM.Data) Is TComponent) OR
        not (csDestroying in TComponent(l_TestM.Data).ComponentState) then
     {$EndIf vcmNeedL3}
     begin
      f_OnTest(l_TPart);
     end;//not (TObject(l_TestM.Data) Is TComponent)..
    end//Assigned(f_OnTest)
    else
    begin
     // Если на форме нет обработчиков пытаемся отдать контролу
     l_Enabled := l_TPart.Op.Flag[vcm_ofEnabled];
     if not l_TPart.CallControl then
     begin
      // Если контрол не проверился и нет обработчиков - запрещаем операцию вообще.
      if not ((Assigned(l_Control) and Assigned(l_Control.OnExecute)) OR
         Assigned(f_OnExecute) OR Assigned(f_OnContextExecute)) then
       l_TPart.Op.Flag[vcm_ofEnabled] := false
      else
       l_TPart.Op.Flag[vcm_ofEnabled] := l_Enabled;
     end;//not l_TPart.CallControl
    end;//Assigned(f_OnTest) and not l_IsOpExcluded
    f_Enabled := l_TPart.Op.Flag[vcm_ofEnabled];
    //aParams.DoneStatus := vcm_dsDone;
   end;//vcm_omTest
   vcm_omExecute,
   vcm_omAggregateExecute:
   begin
    l_Part := aParams.ExecutePart;
    if (l_Control = nil) then
     l_Part.SetControlEvent(nil)
    else
     l_Part.SetControlEvent(l_Control.OnExecute);
    if ((not f_Enabled or not (OperationType in vcm_HiddenOperations)) OR
       ((aMode = vcm_omAggregateExecute) AND (OperationType = vcm_otInternal)))
       // - чтобы из обработчика операций агрегации можно было запрещать операцию
       // Может что-то отвалиться:
       // http://mdp.garant.ru/pages/viewpage.action?pageId=178324372&focusedCommentId=178324544#comment-178324544
       AND
       (((l_Control <> nil) AND Assigned(l_Control.OnTest)) OR
       (Assigned(f_OnTest) OR Assigned(f_OnContextTest))) then
    begin
     // - надо вызвать OnTest
     l_Action := GetLinkedAction;
     if (l_Action <> nil) then
     begin
      l_ActionParams := l_Action.MakeTestParams;
      // в параметрах определим контейнер
      if not Assigned(l_ActionParams.Container) then
      begin
       l_Form := TvcmEntityForm(OwnerForm);
       // для операций модуля OwnerForm = nil, поэтому берем текущую главную
       if not Assigned(l_Form) and Assigned(Dispatcher.FormDispatcher.CurrentMainForm) then
        l_Form := (Dispatcher.FormDispatcher.CurrentMainForm.VCLWinControl As TvcmEntityForm);
       if Assigned(l_Form) then
        begin
        if (l_Form is TvcmContainerForm) then
         l_ActionParams.BasePart.SetContainerPrim(TvcmContainerForm(l_Form), true)
        else
         l_ActionParams.BasePart.SetContainerPrim(l_Form.Container, true);
       end;//not Assigned(l_Form)
      end;//not Assigned(l_ActionParams.Container)
      // вызываем OnTest
      Operation(aControl, aTarget, vcm_omTest, l_ActionParams.BasePart, True);
     end;//l_Action <> nil
    end;//not f_Enabled AND (OperationType in vcm_HiddenOperations)
    if not f_Enabled AND
       ((aMode = vcm_omExecute) OR
       (OperationType = vcm_otInternal))
       // - чтобы таки не звать запрещённую внутренюю операцию агрегации
       // Может что-то отвалиться:
       // http://mdp.garant.ru/pages/viewpage.action?pageId=178324372&focusedCommentId=178324544#comment-178324544
       then
    begin
     if ((ExcludeUserTypes <> []) AND (OwnerUserType in ExcludeUserTypes)) then
      aParams.DoneStatus := vcm_dsExcludedInUserType
     else
      aParams.DoneStatus := vcm_dsDisabled;
    end//not f_Enabled
    else
    if ((ExcludeUserTypes <> []) AND (OwnerUserType in ExcludeUserTypes)) then
     aParams.DoneStatus := vcm_dsExcludedInUserType
    else
    begin
     aParams.DoneStatus := vcm_dsDone;
     l_Cursor := Screen.Cursor;
     if f_LongProcess then
      Screen.Cursor := crHourGlass;
     try
      if (aTarget <> nil) and Assigned(f_OnContextExecute) then
       f_OnContextExecute(l_Part)
      else //(aTarget <> nil) and Assigned(f_OnContextExecute)
       if ((l_Control <> nil) AND Assigned(l_Control.OnExecute)) OR
          Assigned(f_OnExecute) then
       begin
        if (aMode = vcm_omExecute) and f_AutoFocus then
        begin
         if (aControl <> nil) then
         begin
          l_ParentForm := afw.GetTopParentForm(aControl);
          if Assigned(l_ParentForm) and l_ParentForm.Active and
            (aControl is TWinControl) then
           (aControl as TWinControl).SetFocus
         end
         else
         begin
          l_Form := TvcmEntityForm(OwnerForm);
          if l_Form <> nil then
           l_Form.SetFocus;
         end;
        end;//aMode = vcm_omExecute) and f_AutoFocus
        if Assigned(f_OnExecute) then
         f_OnExecute(l_Part)
        else
         l_Part.CallControl;
       end;//Assigned(f_OnExecute)
     finally
      if f_LongProcess then
       Screen.Cursor := l_Cursor;
     end;//try..finally
    end;//ExcludeUserTypes <> []..
   end;//vcm_omExecute
  end;//Case aMode
 finally
  if l_AL then
   l_FD.Unlock;
 end;//try..finally
//#UC END# *5620F10C0381_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.Operation

procedure TvcmBaseOperationsCollectionItemPrim.PublishOp(aControl: TComponent;
  anExecute: TvcmControlExecuteEvent;
  aTest: TvcmControlTestEvent;
  aGetState: TvcmControlGetStateEvent);
//#UC START# *5620F19403B6_5620CFFC0045_var*
//#UC END# *5620F19403B6_5620CFFC0045_var*
begin
//#UC START# *5620F19403B6_5620CFFC0045_impl*
 if (aControl Is TvcmEntityForm) OR (aControl Is TvcmModule) then
 begin
  if not Assigned(f_OnTest) AND not Assigned(f_OnExecute) then
  begin
   //Assert(not Assigned(f_OnContextTest));
   //Assert(not Assigned(f_OnContextExecute));
   f_FormTest := aTest;
   f_FormExecute := anExecute;
   f_FormGetState := aGetState;
   if Assigned(f_FormTest) then
   begin
    f_OnTest := DoFormTest;
    //f_OnContextTest := DoFormTest;
   end;//Assigned(f_FormTest)
   if Assigned(f_FormExecute) then
   begin
    f_OnExecute := DoFormExecute;
    //f_OnContextExecute := DoFormExecute;
   end;//Assigned(f_FormExecute)
   if Assigned(f_FormGetState) then
    f_OnGetState := DoFormGetState;
    // - это заготовка для модели
  end;//not Assigned(f_OnTest)
 end//aControl Is TvcmEntityForm
 else
 begin
  if (aControl <> nil) then
  begin
   if (f_Controls = nil) then
    f_Controls := TvcmActiveControlsCollection.Create(Self);
   f_Controls.PublishOp(aControl, anExecute, aTest);
  end;//aControl <> nil
 end;//aControl Is TvcmEntityForm
//#UC END# *5620F19403B6_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.PublishOp

procedure TvcmBaseOperationsCollectionItemPrim.PublishOp(aControl: TComponent;
  anExecute: TvcmExecuteEvent;
  aTest: TvcmControlTestEvent;
  aGetState: TvcmControlGetStateEvent);
//#UC START# *5620F1DF01BF_5620CFFC0045_var*
//#UC END# *5620F1DF01BF_5620CFFC0045_var*
begin
//#UC START# *5620F1DF01BF_5620CFFC0045_impl*
 if (aControl Is TvcmEntityForm) then
 begin
  if not Assigned(f_OnTest) AND not Assigned(f_OnExecute) then
  begin
   Assert(not Assigned(f_OnContextTest));
   Assert(not Assigned(f_OnContextExecute));
   f_FormTest := aTest;
   //f_FormExecute := anExecute;
   f_FormGetState := aGetState;
   if Assigned(f_FormTest) then
   begin
    f_OnTest := DoFormTest;
    //f_OnContextTest := DoFormTest;
   end;//Assigned(f_FormTest)
(*   if Assigned(f_FormExecute) then
   begin*)
    f_OnExecute := anExecute;
    //f_OnContextExecute := DoFormExecute;
(*   end;//Assigned(f_FormExecute)*)
   if Assigned(f_FormGetState) then
    f_OnGetState := DoFormGetState;
    // - это заготовка для модели
  end;//not Assigned(f_OnTest)
 end//aControl Is TvcmEntityForm
 else
 begin
  Assert(false);
(*  if (f_Controls = nil) then
   f_Controls := TvcmActiveControlsCollection.Create(Self);
  f_Controls.PublishOp(aControl, anExecute, aTest);*)
 end;//aControl Is TvcmEntityForm
//#UC END# *5620F1DF01BF_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.PublishOp

function TvcmBaseOperationsCollectionItemPrim.pm_GetContextMenuWeight: Integer;
//#UC START# *5620CF82017C_5620CFFC0045get_var*
//#UC END# *5620CF82017C_5620CFFC0045get_var*
begin
//#UC START# *5620CF82017C_5620CFFC0045get_impl*
 Result := f_ContextMenuWeight;
//#UC END# *5620CF82017C_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetContextMenuWeight

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetContextMenuWeight(aValue: Integer);
//#UC START# *5620CF82017C_5620CFFC0045set_var*
//#UC END# *5620CF82017C_5620CFFC0045set_var*
begin
//#UC START# *5620CF82017C_5620CFFC0045set_impl*
 f_ContextMenuWeight := aValue;
//#UC END# *5620CF82017C_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetContextMenuWeight

function TvcmBaseOperationsCollectionItemPrim.pm_GetOptions: TvcmOperationOptions;
//#UC START# *5620CF2802E3_5620CFFC0045get_var*
//#UC END# *5620CF2802E3_5620CFFC0045get_var*
begin
//#UC START# *5620CF2802E3_5620CFFC0045get_impl*
 if (f_Options = []) then
 begin
  Result := GetDefaultOptions;
  {$IfNDef DesignTimeLibrary}
  f_Options := Result;
  {$EndIf  DesignTimeLibrary}
 end//f_Options = []
 else
  Result := f_Options;
//#UC END# *5620CF2802E3_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetOptions

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetOptions(aValue: TvcmOperationOptions);
//#UC START# *5620CF2802E3_5620CFFC0045set_var*
//#UC END# *5620CF2802E3_5620CFFC0045set_var*
begin
//#UC START# *5620CF2802E3_5620CFFC0045set_impl*
 if (Options <> aValue) then
 begin
  if (OperationType in vcm_HiddenOperations) then
   if (aValue <> []) then
    Exit;
  f_Options := aValue;
 end;//Options <> aValue
//#UC END# *5620CF2802E3_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetOptions

function TvcmBaseOperationsCollectionItemPrim.pm_GetOperationType: TvcmOperationType;
//#UC START# *5620CEB201FB_5620CFFC0045get_var*
//#UC END# *5620CEB201FB_5620CFFC0045get_var*
begin
//#UC START# *5620CEB201FB_5620CFFC0045get_impl*
 Result := f_OperationType;
//#UC END# *5620CEB201FB_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetOperationType

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetOperationType(aValue: TvcmOperationType);
//#UC START# *5620CEB201FB_5620CFFC0045set_var*
//#UC END# *5620CEB201FB_5620CFFC0045set_var*
begin
//#UC START# *5620CEB201FB_5620CFFC0045set_impl*
 f_OperationType := aValue;
//#UC END# *5620CEB201FB_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetOperationType

function TvcmBaseOperationsCollectionItemPrim.pm_GetStates: TvcmBaseOperationStates;
//#UC START# *5620D26602B5_5620CFFC0045get_var*
//#UC END# *5620D26602B5_5620CFFC0045get_var*
begin
//#UC START# *5620D26602B5_5620CFFC0045get_impl*
 Result := f_States;
//#UC END# *5620D26602B5_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetStates

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetStates(aValue: TvcmBaseOperationStates);
//#UC START# *5620D26602B5_5620CFFC0045set_var*
//#UC END# *5620D26602B5_5620CFFC0045set_var*
begin
//#UC START# *5620D26602B5_5620CFFC0045set_impl*
 States.Assign(aValue);
//#UC END# *5620D26602B5_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetStates

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetState(const aValue: TvcmOperationStateIndex);
//#UC START# *5620D2A101D3_5620CFFC0045set_var*
//#UC END# *5620D2A101D3_5620CFFC0045set_var*
begin
//#UC START# *5620D2A101D3_5620CFFC0045set_impl*
 if (f_State.rID <> aValue.rID) then
 begin
  if (aValue.rID >= vcm_DefaultOperationState.rID) AND (aValue.rID < States.Count) then
  begin
   f_State := aValue;
  end;//aValue >= vcm_DefaultOperationState..
 end;//f_State <> aValue
//#UC END# *5620D2A101D3_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetState

function TvcmBaseOperationsCollectionItemPrim.pm_GetIsDefault: Boolean;
//#UC START# *5620D7470392_5620CFFC0045get_var*
//#UC END# *5620D7470392_5620CFFC0045get_var*
begin
//#UC START# *5620D7470392_5620CFFC0045get_impl*
 Result := f_IsDefault;
//#UC END# *5620D7470392_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetIsDefault

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetIsDefault(aValue: Boolean);
//#UC START# *5620D7470392_5620CFFC0045set_var*
//#UC END# *5620D7470392_5620CFFC0045set_var*
begin
//#UC START# *5620D7470392_5620CFFC0045set_impl*
 f_IsDefault := aValue;
//#UC END# *5620D7470392_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetIsDefault

function TvcmBaseOperationsCollectionItemPrim.pm_GetVisibleToUser: Boolean;
//#UC START# *5620E01800F3_5620CFFC0045get_var*
//#UC END# *5620E01800F3_5620CFFC0045get_var*
begin
//#UC START# *5620E01800F3_5620CFFC0045get_impl*
 if f_VisibleToUser = -1 then
  if (Caption <> '') AND
     (OperationType in vcmToolbarOpTypes) then
   f_VisibleToUser := 1
  else
   f_VisibleToUser := 0;
 Result := f_VisibleToUser > 0;
//#UC END# *5620E01800F3_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetVisibleToUser

function TvcmBaseOperationsCollectionItemPrim.pm_GetOperationDef: IvcmOperationDef;
//#UC START# *5620E17102F2_5620CFFC0045get_var*
//#UC END# *5620E17102F2_5620CFFC0045get_var*
begin
//#UC START# *5620E17102F2_5620CFFC0045get_impl*
 if (Name = '') then
  // - имени нету - значит об операции ничего вразумительного пока сказать нечего
  Result := nil
 else
 begin
  if (f_OpDef = nil) then
   f_OpDef := TvcmBaseOperationDef.Make(Self);
  Result := f_OpDef;
 end;//Name = ''
//#UC END# *5620E17102F2_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetOperationDef

{$If not defined(DesignTimeLibrary) AND not defined(NoVCM)}
function TvcmBaseOperationsCollectionItemPrim.pm_GetCategory: AnsiString;
//#UC START# *5620E23201F0_5620CFFC0045get_var*
var
 l_Collection: TCollection;
 l_Owner: TPersistent;
//#UC END# *5620E23201F0_5620CFFC0045get_var*
begin
//#UC START# *5620E23201F0_5620CFFC0045get_impl*
 Result := '';
 l_Collection := Collection;
 if (l_Collection <> nil) then
 begin
  l_Owner := l_Collection.Owner;
  if (l_Owner <> nil) then
  begin
   if (GetPropInfo(l_Owner, 'Caption') <> nil) then
    Result := GetStrProp(l_Owner, 'Caption')
   else
   if (l_Owner Is TvcmCustomModuleDef) then
    Result := vcmStr(TvcmCustomModuleDef(l_Owner).ModuleDef.Caption);
  end;//l_Owner <> nil
 end;//l_Collection <> nil
//#UC END# *5620E23201F0_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetCategory
{$IfEnd} //not DesignTimeLibrary AND not NoVCM

function TvcmBaseOperationsCollectionItemPrim.pm_GetGroupID: Integer;
//#UC START# *5620E28E0284_5620CFFC0045get_var*
//#UC END# *5620E28E0284_5620CFFC0045get_var*
begin
//#UC START# *5620E28E0284_5620CFFC0045get_impl*
 Result := f_GroupID;
//#UC END# *5620E28E0284_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetGroupID

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetGroupID(aValue: Integer);
//#UC START# *5620E28E0284_5620CFFC0045set_var*
//#UC END# *5620E28E0284_5620CFFC0045set_var*
begin
//#UC START# *5620E28E0284_5620CFFC0045set_impl*
 f_GroupID := aValue;
//#UC END# *5620E28E0284_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetGroupID

function TvcmBaseOperationsCollectionItemPrim.pm_GetExcludeUserTypes: TvcmEffectiveUserTypes;
//#UC START# *5620E402012B_5620CFFC0045get_var*
//#UC END# *5620E402012B_5620CFFC0045get_var*
begin
//#UC START# *5620E402012B_5620CFFC0045get_impl*
 Result := [];
//#UC END# *5620E402012B_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetExcludeUserTypes

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetExcludeUserTypes(aValue: TvcmEffectiveUserTypes);
//#UC START# *5620E402012B_5620CFFC0045set_var*
//#UC END# *5620E402012B_5620CFFC0045set_var*
begin
//#UC START# *5620E402012B_5620CFFC0045set_impl*
//#UC END# *5620E402012B_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetExcludeUserTypes

function TvcmBaseOperationsCollectionItemPrim.pm_GetCurrentState: TvcmBaseOperationState;
//#UC START# *5620E5640206_5620CFFC0045get_var*
//#UC END# *5620E5640206_5620CFFC0045get_var*
begin
//#UC START# *5620E5640206_5620CFFC0045get_impl*
 if (f_State.rID = vcm_DefaultOperationState.rID) then
  Result := nil
 else
  Result := TvcmBaseOperationState(States.Items[f_State.rID]);
//#UC END# *5620E5640206_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetCurrentState

function TvcmBaseOperationsCollectionItemPrim.pm_GetLinked: Boolean;
//#UC START# *5620E6F00105_5620CFFC0045get_var*
//#UC END# *5620E6F00105_5620CFFC0045get_var*
begin
//#UC START# *5620E6F00105_5620CFFC0045get_impl*
 Result := false;
//#UC END# *5620E6F00105_5620CFFC0045get_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_GetLinked

procedure TvcmBaseOperationsCollectionItemPrim.pm_SetLinked(aValue: Boolean);
//#UC START# *5620E6F00105_5620CFFC0045set_var*
//#UC END# *5620E6F00105_5620CFFC0045set_var*
begin
//#UC START# *5620E6F00105_5620CFFC0045set_impl*
//#UC END# *5620E6F00105_5620CFFC0045set_impl*
end;//TvcmBaseOperationsCollectionItemPrim.pm_SetLinked

function TvcmBaseOperationsCollectionItemPrim.OperationTypeStored: Boolean;
//#UC START# *7C0E36AF141A_5620CFFC0045_var*
//#UC END# *7C0E36AF141A_5620CFFC0045_var*
begin
//#UC START# *7C0E36AF141A_5620CFFC0045_impl*
 Result := GetOperationTypeStored;
//#UC END# *7C0E36AF141A_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.OperationTypeStored

function TvcmBaseOperationsCollectionItemPrim.IsDefaultStored: Boolean;
//#UC START# *EBDB5C8A01C4_5620CFFC0045_var*
//#UC END# *EBDB5C8A01C4_5620CFFC0045_var*
begin
//#UC START# *EBDB5C8A01C4_5620CFFC0045_impl*
 Result := GetIsDefaultStored;
//#UC END# *EBDB5C8A01C4_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.IsDefaultStored

function TvcmBaseOperationsCollectionItemPrim.GroupIDStored: Boolean;
//#UC START# *C79988A52B31_5620CFFC0045_var*
//#UC END# *C79988A52B31_5620CFFC0045_var*
begin
//#UC START# *C79988A52B31_5620CFFC0045_impl*
 Result := GetGroupIDStored;
//#UC END# *C79988A52B31_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GroupIDStored

procedure TvcmBaseOperationsCollectionItemPrim.Assign(Source: TPersistent);
//#UC START# *478CF34E02CE_5620CFFC0045_var*
//#UC END# *478CF34E02CE_5620CFFC0045_var*
begin
//#UC START# *478CF34E02CE_5620CFFC0045_impl*
 inherited;
 if (Source is TvcmBaseOperationsCollectionItem) then
 begin
  GroupID := TvcmBaseOperationsCollectionItem(Source).GroupID;
  OperationType := TvcmBaseOperationsCollectionItem(Source).OperationType;
  AutoLock := TvcmBaseOperationsCollectionItem(Source).AutoLock;
  ExcludeUserTypes := TvcmBaseOperationsCollectionItem(Source).ExcludeUserTypes;
  OnTest := TvcmBaseOperationsCollectionItem(Source).OnTest;
  OnExecute := TvcmBaseOperationsCollectionItem(Source).OnExecute;
  OnContextTest := TvcmBaseOperationsCollectionItem(Source).OnContextTest;
  OnContextExecute := TvcmBaseOperationsCollectionItem(Source).OnContextExecute;
  Options := TvcmBaseOperationsCollectionItem(Source).Options;
  IsDefault := TvcmBaseOperationsCollectionItem(Source).IsDefault;
 end;//TvcmBaseOperationsCollectionItem
//#UC END# *478CF34E02CE_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.Assign

procedure TvcmBaseOperationsCollectionItemPrim.Cleanup;
//#UC START# *479731C50290_5620CFFC0045_var*
//#UC END# *479731C50290_5620CFFC0045_var*
begin
//#UC START# *479731C50290_5620CFFC0045_impl*
 f_FormGetState := nil;
 f_FormTest := nil;
 f_FormExecute := nil;
 FreeAndNil(f_Controls);
 ClearOp;
 SetShortCuts(TShortcut(0), nil);
 f_SaveShortcut := TShortcut(0);
 f_SaveSecondaryShortcuts := '';
 FreeAndNil(f_States);
 inherited;
//#UC END# *479731C50290_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.Cleanup

procedure TvcmBaseOperationsCollectionItemPrim.BeforeAddToCache;
//#UC START# *479F2B3302C1_5620CFFC0045_var*
//#UC END# *479F2B3302C1_5620CFFC0045_var*
begin
//#UC START# *479F2B3302C1_5620CFFC0045_impl*
 inherited;
 f_Options := [];
 f_OperationType := Low(TvcmOperationType);
 f_AutoLock := false;
 f_AutoFocus := false;
 f_LongProcess := false;

 f_OnGetState := nil;
 f_OnTest := nil;
 f_OnExecute := nil;

 f_OnContextTest := nil;
 f_OnContextExecute := nil;
 f_IsDefault := False;
//#UC END# *479F2B3302C1_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.BeforeAddToCache

constructor TvcmBaseOperationsCollectionItemPrim.Create(aCollection: TCollection);
//#UC START# *4D555CF50027_5620CFFC0045_var*
//#UC END# *4D555CF50027_5620CFFC0045_var*
begin
//#UC START# *4D555CF50027_5620CFFC0045_impl*
 inherited;
 //f_Controls := TvcmActiveControlsCollection.Create(Self);
 f_State := vcm_DefaultOperationState;
 f_States := StatesClass.Create(Self);
 f_Enabled := true;
 f_VisibleToUser := -1;
 f_IsCaptionUnique := True;
 SecondaryShortCuts.OnChange := OnSecondaryShortCutsChange;
 f_SaveShortcut := TShortcut(0);
 f_SaveSecondaryShortcuts := '';
 f_ContextMenuWeight := 0;
//#UC END# *4D555CF50027_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.Create

procedure TvcmBaseOperationsCollectionItemPrim.ClearFields;
 {-}
begin
 Finalize(f_State);
 inherited;
end;//TvcmBaseOperationsCollectionItemPrim.ClearFields

procedure TvcmBaseOperationsCollectionItemPrim.ChangeName(const anOld: AnsiString;
  const aNew: AnsiString);
//#UC START# *55CCBA3C0190_5620CFFC0045_var*
//#UC END# *55CCBA3C0190_5620CFFC0045_var*
begin
//#UC START# *55CCBA3C0190_5620CFFC0045_impl*
 inherited;
 f_OperationID := MakeID(aNew);
//#UC END# *55CCBA3C0190_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ChangeName

procedure TvcmBaseOperationsCollectionItemPrim.ChangeCaption(const anOld: AnsiString;
  const aNew: AnsiString);
//#UC START# *55CCBA8003C7_5620CFFC0045_var*
//#UC END# *55CCBA8003C7_5620CFFC0045_var*
begin
//#UC START# *55CCBA8003C7_5620CFFC0045_impl*
 inherited;
 {$IfDef DesignTimeLibrary}
 vcmGetID(vcm_repOperationCaption, aNew);
 {$EndIf DesignTimeLibrary}
//#UC END# *55CCBA8003C7_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.ChangeCaption

function TvcmBaseOperationsCollectionItemPrim.MakeID(const aName: AnsiString): Integer;
//#UC START# *55CCBAAB00F4_5620CFFC0045_var*
//#UC END# *55CCBAAB00F4_5620CFFC0045_var*
begin
//#UC START# *55CCBAAB00F4_5620CFFC0045_impl*
 Result := vcmGetID(vcm_repOperation, aName, ParentID);
//#UC END# *55CCBAAB00F4_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.MakeID

function TvcmBaseOperationsCollectionItemPrim.GetID: Integer;
//#UC START# *55CCBAC800F0_5620CFFC0045_var*
//#UC END# *55CCBAC800F0_5620CFFC0045_var*
begin
//#UC START# *55CCBAC800F0_5620CFFC0045_impl*
 Result := OperationID;
//#UC END# *55CCBAC800F0_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.GetID

function TvcmBaseOperationsCollectionItemPrim.QueryInterface(const IID: TGUID;
  out Obj): HResult;
//#UC START# *561145D802BB_5620CFFC0045_var*
//#UC END# *561145D802BB_5620CFFC0045_var*
begin
//#UC START# *561145D802BB_5620CFFC0045_impl*
 if IsEqualGUID(IID, IvcmUserFriendlyControl) then
 begin
  Result := S_Ok;
  IvcmUserFriendlyControl(Obj) := OperationDef;
  if (IUnknown(Obj) = nil) then
   Result := E_NoInterface;
 end
 else
 if IsEqualGUID(IID, IvcmOperationDef) then
 begin
  Result := S_Ok;
  IvcmOperationDef(Obj) := OperationDef;
  if (IUnknown(Obj) = nil) then
   Result := E_NoInterface;
 end
 else
 if IsEqualGUID(IID, IvcmIdentifiedUserFriendlyControl) then
 begin
  Result := S_Ok;
  IvcmIdentifiedUserFriendlyControl(Obj) := OperationDef;
  if (IUnknown(Obj) = nil) then
   Result := E_NoInterface;
 end
 else
  Result := inherited QueryInterface(IID, Obj);
//#UC END# *561145D802BB_5620CFFC0045_impl*
end;//TvcmBaseOperationsCollectionItemPrim.QueryInterface

//#UC START# *4D7A109601C2impl*
//#UC END# *4D7A109601C2impl*

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmBaseOperationsCollectionItemPrim
 TtfwClassRef.Register(TvcmBaseOperationsCollectionItemPrim);
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TvcmBaseOperationsCollectionItem
 TtfwClassRef.Register(TvcmBaseOperationsCollectionItem);
{$IfEnd} //not NoScripts AND not NoVCM

end.