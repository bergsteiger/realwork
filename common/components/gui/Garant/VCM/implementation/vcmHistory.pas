unit vcmHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmHistory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM$Visual::Implementation::vcmHistory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces,
  vcmInterfaces,
  SysUtils,
  l3PureMixIns,
  vcmBase,
  vcmEntityForm,
  vcmUserControls,
  l3ProtoObject,
  l3ProtoDataContainer,
  vcmIEntityFormPtrList,
  vcmBaseTypes,
  vcmHistoryItemList,
  vcmHistoryFormNode,
  l3Interfaces,
  l3Types,
  l3Memory,
  l3Core,
  l3Except,
  Classes
  ;

type
 IvcmFormHistoryItem = interface(IvcmHistoryItem)
   ['{B8A57CB1-BC72-41FC-9407-770BE962585D}']
   procedure ResetContainer;
     {* Сигнатура метода ResetContainer }
   function pm_GetFormClass: TvcmFormID;
   function pm_GetUserType: TvcmUserType;
   function pm_GetItemType: TvcmHistoryItemType;
   property FormClass: TvcmFormID
     read pm_GetFormClass;
   property UserType: TvcmUserType
     read pm_GetUserType;
   property ItemType: TvcmHistoryItemType
     read pm_GetItemType;
 end;//IvcmFormHistoryItem

 IvcmInternalHistory = interface(IvcmHistory)
   ['{D98D21B3-34A8-4A13-94D6-C3FE61D93247}']
   function InternalSaveState(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType;
     InDestroy: Boolean;
     aForceSave: Boolean = False): Boolean;
 end;//IvcmInternalHistory

 TvcmHistory = class(TvcmCacheableBase, IvcmHistory, IvcmInternalHistory)
 private
 // private fields
   f_History : TvcmHistoryItemList;
   f_SavingClone : Boolean;
   f_Forms : TvcmIEntityFormPtrList;
   f_ContainerItem : IvcmContainerHistoryItem;
   f_Current : Integer;
   f_Starts : Integer;
   f_Delta : Integer;
   f_MainForm : Pointer;
   f_Last : Boolean;
    {* признак того, что вызов последний}
   f_Multi : Boolean;
    {* скобки для множественного вызова Back из одноименной процедуры}
   f_InBF : Boolean;
   f_InBack : Boolean;
   f_ForceSave : Boolean;
 protected
 // property methods
   function pm_GetMainForm: IvcmEntityForm;
 protected
 // realized methods
   procedure BeforeFormDestroy(const aForm: IvcmEntityForm);
   function ForceSaveState(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType = vcm_stContent): Boolean;
     {* сохранение без проверки необходимости сохранения формы }
   function SaveState(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType = vcm_stContent): Boolean;
   procedure SaveClose(const aForm: IvcmEntityForm;
     const aFormID: TvcmFormID;
     aUserType: TvcmUserType;
     aZoneType: TvcmZoneType;
     aSubUserType: TvcmUserType);
     {* форма которая должна быть закрыта при переходе по истории }
   function HasInPreviousStep(const aFormClass: TvcmFormID;
     aUserType: TvcmUserType = vcm_utAny): Boolean;
   function Back(aTruncate: Boolean = False): Boolean; overload; 
   function Forward: Boolean; overload; 
   procedure Back(const aParams: IvcmExecuteParamsPrim;
     aTruncate: Boolean = False); overload; 
   procedure Forward(const aParams: IvcmExecuteParamsPrim); overload; 
   function CanBack: Boolean;
   function CanForward: Boolean;
   procedure GetBackStrings(const aParams: IvcmTestParamsPrim);
   procedure GetForwardStrings(const aParams: IvcmTestParamsPrim);
   procedure Start(const aSender: IvcmEntityForm;
     const aCaption: IvcmCString = nil;
     aFormSet: Boolean = False);
   procedure Finish(const aSender: IvcmEntityForm);
   procedure AddForm(const aForm: IvcmEntityForm);
   procedure RemoveForm(const aForm: IvcmEntityForm);
   function Add(const anItem: IvcmHistoryItem): Boolean;
     {* добавляет запись в историю }
   function IsLast: Boolean;
   function pm_GetInBF: Boolean;
   function pm_GetInProcess: Boolean;
   function InBack: Boolean;
     {* Находимся в процессе Back, если нет, то Forward }
   procedure Clear(aHeedCheckCurrent: Boolean = true);
     {* Очищает историю }
   procedure DeleteBackItem;
     {* Удаляет один элемент из списка Back }
   function GetBackCount: Integer;
   function GetForwardCount: Integer;
   function GetBackItem(anIndex: Integer): Il3CString;
   function GetForwardItem(anIndex: Integer): Il3CString;
   procedure DeleteForwardItem;
     {* Удаляет один элемент из списка Forward }
   function InternalSaveState(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType;
     InDestroy: Boolean;
     aForceSave: Boolean = False): Boolean;
   procedure ResetContainer;
     {* Сигнатура метода ResetContainer }
   function MakeState: IvcmHistoryState;
   procedure AssignState(const aState: IvcmHistoryState);
   procedure SaveClone(const aForm: IvcmEntityForm);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   function NeedSaveForm(const aForm: IvcmEntityForm;
     InDestroy: Boolean): Boolean;
     {* нужно ли сохранять заданную форму }
   function CheckAnother(const aForm: IvcmEntityForm;
     out theHistory: IvcmHistory): Boolean; virtual;
     {* проверяет от этой ли формы история, и если не от этой, то возвращает правильную историю. }
   function GetCaption(anIndex: Integer): IvcmCString;
     {* возвращает название одного шага истории }
 public
 // public methods
   constructor Create(const aMainForm: IvcmEntityForm); reintroduce;
   class function Make(const aMainForm: IvcmEntityForm): IvcmHistory; reintroduce;
     {* Сигнатура фабрики TvcmHistory.Make }
 public
 // public properties
   property MainForm: IvcmEntityForm
     read pm_GetMainForm;
 end;//TvcmHistory

 TvcmObjectWithDataHistoryItem = class(TvcmBase, IvcmHistoryItem)
 private
 // private fields
   f_Object : IvcmObjectWithData;
   f_Data : IvcmData;
 private
 // private methods
   procedure DoActivate;
     {* Сигнатура метода DoActivate }
 protected
 // realized methods
   function pm_GetCaption: IvcmCString;
   function Activate(const aMainForm: IvcmEntityForm): Boolean; overload; 
   function Activate(const aMainForm: IvcmEntityForm;
       const anOwner: IvcmEntityForm): Boolean; overload; 
   function Drop: Boolean;
   function IsAcceptable: Boolean;
     {* можно ли активизировать элемент истории в текущих условиях }
 public
 // public methods
   constructor Create(const aObject: IvcmObjectWithData;
     const aData: IvcmData); reintroduce;
   class function Make(const aObject: IvcmObjectWithData;
     const aData: IvcmData): IvcmHistoryItem; reintroduce;
     {* Сигнатура фабрики TvcmObjectWithDataHistoryItem.Make }
 end;//TvcmObjectWithDataHistoryItem

 IvcmFormHistoryItemList = interface(IUnknown)
   ['{59876B02-DA96-4D06-80B6-6ACA9E7CE378}']
  // Ml3List
   function pm_GetEmpty: Boolean;
   function pm_GetFirst: IvcmFormHistoryItem;
   function pm_GetLast: IvcmFormHistoryItem;
   function pm_GetItems(anIndex: Integer): IvcmFormHistoryItem;
   property Empty: Boolean
     read pm_GetEmpty;
   property First: IvcmFormHistoryItem
     read pm_GetFirst;
     {* Первый элемент. }
   property Last: IvcmFormHistoryItem
     read pm_GetLast;
     {* Последний элемент. }
   property Items[anIndex: Integer]: IvcmFormHistoryItem
     read pm_GetItems;
     default;
  // Ml3CountHolder
   function pm_GetCount: Integer;
   property Count: Integer
     read pm_GetCount;
     {* Число элементов. }
 end;//IvcmFormHistoryItemList

 _ItemType_ = IvcmFormHistoryItem;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TvcmFormHistoryItemList = class(_l3InterfaceRefList_, IvcmFormHistoryItemList)
 protected
 // realized methods
   function pm_GetCount: Integer;
 end;//TvcmFormHistoryItemList

 TvcmHistoryState = class(Tl3ProtoObject, IvcmHistoryState)
 private
 // private fields
   f_Items : IvcmHistoryItems;
   f_Current : Integer;
   f_ContainerItem : IvcmContainerHistoryItem;
 protected
 // realized methods
   function pm_GetItems: IvcmHistoryItems;
   function pm_GetCurrent: Integer;
   function pm_GetContainerItem: IvcmContainerHistoryItem;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aItems: IvcmHistoryItems;
     aCurrent: Integer;
     const aContainerItem: IvcmContainerHistoryItem); reintroduce;
   class function Make(const aItems: IvcmHistoryItems;
     aCurrent: Integer;
     const aContainerItem: IvcmContainerHistoryItem): IvcmHistoryState; reintroduce;
     {* Сигнатура фабрики TvcmHistoryState.Make }
 end;//TvcmHistoryState

var g_vcmHistoryLimit : Integer = High(Integer);
 {* Лимит количества записей в истории приложения}

var g_LockHistory : Integer = 0;

var g_LockBeforeFormDestroy : Integer = 0;
 {* паблик, потому что приватным генерировалось ниже, чем нужно}
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  l3IID,
  l3String,
  Windows
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  vcmUtils,
  vcmAggregate,
  vcmBaseMenuManager,
  vcmTaskPanelInterfaces,
  vcmHistoryRes,
  afwFacade
  ;

type
 EvcmFormWasClosedInSave = class(Exception)
 end;//EvcmFormWasClosedInSave

 TvcmHistoryItemBase = class(TvcmCacheableBase, IvcmFormHistoryItem)
 private
 // private fields
   f_PathNode : TvcmHistoryFormNode;
   f_FormClass : RvcmEntityForm;
   f_FormId : TvcmFormID;
   f_Caption : IvcmCString;
   f_Focused : AnsiString;
   f_FormData : IvcmBase;
   f_FormGUID : TGUID;
   f_ZoneType : TvcmZoneType;
   f_Aggregate : PGUID;
   f_ContainerGUID : PGUID;
   f_Owner : PGUID;
   f_UserType : TvcmUserType;
   f_SubUserType : TvcmUserType;
   f_DataSource : IvcmFormDataSource;
   f_ItemType : TvcmHistoryItemType;
   f_SavingClone : Boolean;
    {* Поле для свойства SavingClone}
 protected
 // property methods
   function pm_GetSavingClone: Boolean; virtual;
 protected
 // realized methods
   function pm_GetCaption: IvcmCString;
   function pm_GetFormClass: TvcmFormID;
   function pm_GetUserType: TvcmUserType;
   function pm_GetItemType: TvcmHistoryItemType;
   function Activate(const aMainForm: IvcmEntityForm): Boolean; overload; 
   function Activate(const aMainForm: IvcmEntityForm;
       const anOwner: IvcmEntityForm): Boolean; overload; 
   function Drop: Boolean;
   function IsAcceptable: Boolean;
     {* можно ли активизировать элемент истории в текущих условиях }
   procedure ResetContainer;
     {* Сигнатура метода ResetContainer }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
 protected
 // protected methods
   function DoActivate(const aMainForm: IvcmEntityForm;
     const anOwner: IvcmEntityForm): Boolean; virtual; abstract;
   procedure UpdateContainer(const aForm: IvcmEntityForm);
   procedure UpdateOwner(const aForm: IvcmEntityForm);
   procedure UpdateAggregate(const aForm: IvcmEntityForm);
   procedure UpdateFormInfo(const aForm: IvcmEntityForm);
   procedure FreeContainer;
     {* Сигнатура метода FreeContainer }
   procedure FreeOwner;
     {* Сигнатура метода FreeOwner }
   procedure FreeAggregate;
     {* Сигнатура метода FreeAggregate }
   function Container(const aMainForm: IvcmEntityForm): IvcmContainer;
   function MakeForm(const aMainForm: IvcmEntityForm;
     const anOwner: IvcmEntityForm;
     const aDataSource: IvcmFormDataSource): IvcmEntityForm;
   procedure StoreFocused(const aForm: IvcmEntityForm);
   procedure RestoreFocused(const aForm: IvcmEntityForm);
 public
 // public methods
   constructor Create(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType;
     const aFormId: TvcmFormID;
     aUserType: TvcmUserType;
     aZoneType: TvcmZoneType;
     aItemType: TvcmHistoryItemType;
     aSubUserType: TvcmUserType;
     aForClone: Boolean); reintroduce; virtual;
   class function Make(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType;
     const aFormId: TvcmFormID;
     aUserType: TvcmUserType;
     aZoneType: TvcmZoneType;
     aItemType: TvcmHistoryItemType;
     aSubUserType: TvcmUserType;
     aForClone: Boolean): IvcmFormHistoryItem; reintroduce; overload; 
     {* Сигнатура фабрики TvcmHistoryItemBase.Make$1 }
   class function Make(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType): IvcmFormHistoryItem; overload; 
 protected
 // protected properties
   property SavingClone: Boolean
     read pm_GetSavingClone;
 end;//TvcmHistoryItemBase

// start class TvcmHistoryItemBase

procedure TvcmHistoryItemBase.UpdateContainer(const aForm: IvcmEntityForm);
//#UC START# *5508100C018B_5506DC4F0011_var*
//#UC END# *5508100C018B_5506DC4F0011_var*
begin
//#UC START# *5508100C018B_5506DC4F0011_impl*
 if not aForm.Container.IsNull then
 begin
  if not Assigned(f_ContainerGUID) then
   New(f_ContainerGUID);
  f_ContainerGUID^ := aForm.Container.AsForm.GUID;
 end//not l_Container.IsNull
 else
  FreeContainer;
//#UC END# *5508100C018B_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.UpdateContainer

procedure TvcmHistoryItemBase.UpdateOwner(const aForm: IvcmEntityForm);
//#UC START# *5508102A0098_5506DC4F0011_var*
var
 l_Owner: TComponent;
//#UC END# *5508102A0098_5506DC4F0011_var*
begin
//#UC START# *5508102A0098_5506DC4F0011_impl*
 l_Owner := aForm.VCLWinControl.Owner;
 if (l_Owner Is TvcmEntityForm) then
 begin
  if not Assigned(f_Owner) then
   New(f_Owner);
  f_Owner^ := TvcmEntityForm(l_Owner).As_IvcmEntityForm.GUID;
 end//l_Owner Is TvcmEntityForm
 else
  FreeOwner;
//#UC END# *5508102A0098_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.UpdateOwner

procedure TvcmHistoryItemBase.UpdateAggregate(const aForm: IvcmEntityForm);
//#UC START# *5508103701AF_5506DC4F0011_var*
//#UC END# *5508103701AF_5506DC4F0011_var*
begin
//#UC START# *5508103701AF_5506DC4F0011_impl*
 if Assigned(aForm.Aggregate) then
 begin
  if not Assigned(f_Aggregate) then
   New(f_Aggregate);
  f_Aggregate^ := aForm.Aggregate.GUID;
 end//aForm.Aggregate <> nil
 else
  FreeAggregate;
//#UC END# *5508103701AF_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.UpdateAggregate

procedure TvcmHistoryItemBase.UpdateFormInfo(const aForm: IvcmEntityForm);
//#UC START# *5508104402FE_5506DC4F0011_var*
//#UC END# *5508104402FE_5506DC4F0011_var*
begin
//#UC START# *5508104402FE_5506DC4F0011_impl*
 if Assigned(aForm) then
 begin
  f_FormClass := RvcmEntityForm(aForm.VCLWinControl.ClassType);
  f_Caption := aForm.{VCLForm.}MainCaption;
  f_FormGUID := aForm.GUID;
  f_DataSource := aForm.DataSource;
  UpdateAggregate(aForm);
  UpdateContainer(aForm);
  UpdateOwner(aForm);
 end;//Assigned(aForm)
//#UC END# *5508104402FE_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.UpdateFormInfo

procedure TvcmHistoryItemBase.FreeContainer;
//#UC START# *5508105E024B_5506DC4F0011_var*
//#UC END# *5508105E024B_5506DC4F0011_var*
begin
//#UC START# *5508105E024B_5506DC4F0011_impl*
 if Assigned(f_ContainerGUID) then
 begin
  Dispose(f_ContainerGUID);
  f_ContainerGUID := nil;
 end;
//#UC END# *5508105E024B_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.FreeContainer

procedure TvcmHistoryItemBase.FreeOwner;
//#UC START# *5508106B01A3_5506DC4F0011_var*
//#UC END# *5508106B01A3_5506DC4F0011_var*
begin
//#UC START# *5508106B01A3_5506DC4F0011_impl*
 if Assigned(f_Owner) then
 begin
  Dispose(f_Owner);
  f_Owner := nil;
 end;
//#UC END# *5508106B01A3_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.FreeOwner

procedure TvcmHistoryItemBase.FreeAggregate;
//#UC START# *550810770379_5506DC4F0011_var*
//#UC END# *550810770379_5506DC4F0011_var*
begin
//#UC START# *550810770379_5506DC4F0011_impl*
 if Assigned(f_Aggregate) then
 begin
  Dispose(f_Aggregate);
  f_Aggregate := nil;
 end;//Assigned(f_Aggregate)
//#UC END# *550810770379_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.FreeAggregate

function TvcmHistoryItemBase.Container(const aMainForm: IvcmEntityForm): IvcmContainer;
//#UC START# *5508108B0208_5506DC4F0011_var*
var
 l_Form: IvcmEntityForm;
//#UC END# *5508108B0208_5506DC4F0011_var*
begin
//#UC START# *5508108B0208_5506DC4F0011_impl*
 if (f_ContainerGUID = nil) then
  Result := aMainForm.AsContainer
 else
 if g_Dispatcher.FormDispatcher.FindForm(f_ContainerGUID^, l_Form) then
 begin
  Assert(not l_Form.VCMClosing);
  // - если форма УЖЕ закрывается, то её наверное повторно использовать НЕЛЬЗЯ
  Result := l_Form.AsContainer
 end//g_Dispatcher.FormDispatcher.FindForm(f_ContainerGUID^, l_Form)
 else
 begin
  if (f_PathNode <> nil) then
   Result := f_PathNode.FindContainer(aMainForm.AsContainer);
  if (Result <> nil) then
   Exit;
  Result := aMainForm.AsContainer;
  Assert(False, Format('А возможна ли такая ситуация, что у формы "%s" не нашёлся контейнер, который запомнили. И правильная ли она? http://mdp.garant.ru/pages/viewpage.action?pageId=326773370&focusedCommentId=330698389#comment-330698389',
                       [f_FormClass.ClassName]));
 end;//g_Dispatcher.FormDispatcher.FindForm(f_ContainerGUID^, l_Form)
//#UC END# *5508108B0208_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.Container

function TvcmHistoryItemBase.MakeForm(const aMainForm: IvcmEntityForm;
  const anOwner: IvcmEntityForm;
  const aDataSource: IvcmFormDataSource): IvcmEntityForm;
//#UC START# *550810B10266_5506DC4F0011_var*
var
 l_Container: IvcmContainer;
 l_Aggregate: IvcmAggregate;
 l_Owner: IvcmEntityForm;
//#UC END# *550810B10266_5506DC4F0011_var*
begin
//#UC START# *550810B10266_5506DC4F0011_impl*
 Result := nil;

 if (f_FormClass = aMainForm.VCLWinControl.ClassType) then
  Exit;

 // Если элемента не было до этого, то при переходе назад он должен быть удален
 f_ItemType := vcm_hitClose;

 (*if (f_FormData = nil) then
  Result := nil
 else*)
 // !!! - закомментрировал, т.к. иначе неправильно сохранялись формы-контейнеры
 begin
  l_Container := Container(aMainForm);
  if (f_Aggregate = nil) then
   l_Aggregate := nil
  else
   l_Aggregate := TvcmAggregate.Make(f_Aggregate);
  if (anOwner = nil) then
  begin
   if (f_Owner = nil) then
    l_Owner := nil
   else
   begin
    if g_Dispatcher.FormDispatcher.FindForm(f_Owner^, l_Owner) then
     Assert(not l_Owner.VCMClosing);
     // - если форма УЖЕ закрывается, то её наверное повторно использовать НЕЛЬЗЯ
   end;//f_Owner = nil
  end//anOwner = nil
  else
   l_Owner := anOwner;
  if (l_Container <> nil) and not l_Container.IsNull then
   Result := f_FormClass.MakeSingleChild(l_Container,
                                         vcmMakeParams(l_Aggregate, l_Container, l_Owner.VCLWinControl),
                                         f_ZoneType,
                                         f_UserType,
                                         @f_FormGUID,
                                         aDataSource,
                                         f_SubUserType)
  else
   Result := f_FormClass.Make(vcmMakeParams(l_Aggregate, l_Container, l_Owner.VCLWinControl),
                              f_ZoneType,
                              f_UserType,
                              @f_FormGUID,
                              aDataSource,
                              f_SubUserType);
 end;//f_FormData = nil
//#UC END# *550810B10266_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.MakeForm

procedure TvcmHistoryItemBase.StoreFocused(const aForm: IvcmEntityForm);
//#UC START# *550811080395_5506DC4F0011_var*
var
 l_Form,
 l_Parent,
 l_Control: TWinControl;
//#UC END# *550811080395_5506DC4F0011_var*
begin
//#UC START# *550811080395_5506DC4F0011_impl*
 f_Focused := '';
 if Assigned(aForm) and Assigned(aForm.VCLWinControl) then
 begin
  l_Form := aForm.VCLWinControl;
  l_Control := FindControl(Windows.GetFocus);
  if Assigned(l_Control) then
  begin
   l_Parent := l_Control.Parent;
   while Assigned(l_Parent) do
    if l_Parent = l_Form then
    begin
     f_Focused := l_Control.Name;
     Break;
    end
    else if l_Parent is TCustomForm then
     Break
    else
     l_Parent := l_Parent.Parent;
  end;
 end;
//#UC END# *550811080395_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.StoreFocused

procedure TvcmHistoryItemBase.RestoreFocused(const aForm: IvcmEntityForm);
//#UC START# *55081119039F_5506DC4F0011_var*
var
 l_Control: TWinControl;
//#UC END# *55081119039F_5506DC4F0011_var*
begin
//#UC START# *55081119039F_5506DC4F0011_impl*
 if (f_Focused <> '') and Assigned(aForm) and Assigned(aForm.VCLWinControl) then
 begin
  l_Control := aForm.VCLWinControl.FindComponent(f_Focused) as TWinControl;
  if Assigned(l_Control) then
   g_Dispatcher.StoreFocused(l_Control.Handle);
 end;//f_Focused <> ''..
//#UC END# *55081119039F_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.RestoreFocused

constructor TvcmHistoryItemBase.Create(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType;
  const aFormId: TvcmFormID;
  aUserType: TvcmUserType;
  aZoneType: TvcmZoneType;
  aItemType: TvcmHistoryItemType;
  aSubUserType: TvcmUserType;
  aForClone: Boolean);
//#UC START# *550811520043_5506DC4F0011_var*
var
 l_PrevVCMClosing: Boolean;
 l_NowVCMClosing: Boolean;
//#UC END# *550811520043_5506DC4F0011_var*
begin
//#UC START# *550811520043_5506DC4F0011_impl*
 inherited Create;
 f_SavingClone := aForClone;
 f_ZoneType := aZoneType;
 f_UserType := aUserType;
 f_FormId := aFormId;
 f_ItemType := aItemType;
 f_SubUserType := aSubUserType;
 StoreFocused(aForm);
 if Assigned(aForm) then
 begin
  f_PathNode := TvcmHistoryFormNode.Create(aForm, nil);
  UpdateFormInfo(aForm);
  l_PrevVCMClosing := aForm.VCMClosing;
  if not aForm.SaveState(f_FormData, aStateType) then
  begin
   l_NowVCMClosing := aForm.VCMClosing;
   if l_NowVCMClosing then
   begin
    Assert(not l_PrevVCMClosing, aForm.VCLWinControl.ClassName);
    f_FormClass := nil;
   end;//aForm.VCMClosing
   f_FormData := nil;
   if l_NowVCMClosing then
    raise EvcmFormWasClosedInSave.Create('Форма была закрыта во время сохранения');
  end;//not aForm.SaveState(f_FormData, aStateType)
 end;//if Assigned(aForm) then
//#UC END# *550811520043_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.Create

class function TvcmHistoryItemBase.Make(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType;
  const aFormId: TvcmFormID;
  aUserType: TvcmUserType;
  aZoneType: TvcmZoneType;
  aItemType: TvcmHistoryItemType;
  aSubUserType: TvcmUserType;
  aForClone: Boolean): IvcmFormHistoryItem;
var
 l_Inst : TvcmHistoryItemBase;
begin
 l_Inst := Create(aForm, aStateType, aFormId, aUserType, aZoneType, aItemType, aSubUserType, aForClone);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

class function TvcmHistoryItemBase.Make(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType): IvcmFormHistoryItem;
//#UC START# *5508119800FB_5506DC4F0011_var*
var
 l_Form: TvcmEntityForm;
//#UC END# *5508119800FB_5506DC4F0011_var*
begin
//#UC START# *5508119800FB_5506DC4F0011_impl*
 l_Form := (aForm.VCLWinControl as TvcmEntityForm);
 Result := Make(aForm, aStateType, l_Form.FormID, l_Form.UserType, l_Form.ZoneType, vcm_hitNone, l_Form.SubUserType, False);
//#UC END# *5508119800FB_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.Make

function TvcmHistoryItemBase.pm_GetSavingClone: Boolean;
//#UC START# *559F88140365_5506DC4F0011get_var*
//#UC END# *559F88140365_5506DC4F0011get_var*
begin
//#UC START# *559F88140365_5506DC4F0011get_impl*
 Result := f_SavingClone;
//#UC END# *559F88140365_5506DC4F0011get_impl*
end;//TvcmHistoryItemBase.pm_GetSavingClone

function TvcmHistoryItemBase.pm_GetCaption: IvcmCString;
//#UC START# *499559980178_5506DC4F0011get_var*
//#UC END# *499559980178_5506DC4F0011get_var*
begin
//#UC START# *499559980178_5506DC4F0011get_impl*
 Result := f_Caption;
//#UC END# *499559980178_5506DC4F0011get_impl*
end;//TvcmHistoryItemBase.pm_GetCaption

function TvcmHistoryItemBase.pm_GetFormClass: TvcmFormID;
//#UC START# *5506D47103A1_5506DC4F0011get_var*
//#UC END# *5506D47103A1_5506DC4F0011get_var*
begin
//#UC START# *5506D47103A1_5506DC4F0011get_impl*
 Result := f_FormId;
//#UC END# *5506D47103A1_5506DC4F0011get_impl*
end;//TvcmHistoryItemBase.pm_GetFormClass

function TvcmHistoryItemBase.pm_GetUserType: TvcmUserType;
//#UC START# *5506D4830243_5506DC4F0011get_var*
//#UC END# *5506D4830243_5506DC4F0011get_var*
begin
//#UC START# *5506D4830243_5506DC4F0011get_impl*
 Result := f_UserType;
//#UC END# *5506D4830243_5506DC4F0011get_impl*
end;//TvcmHistoryItemBase.pm_GetUserType

function TvcmHistoryItemBase.pm_GetItemType: TvcmHistoryItemType;
//#UC START# *5506D49100B7_5506DC4F0011get_var*
//#UC END# *5506D49100B7_5506DC4F0011get_var*
begin
//#UC START# *5506D49100B7_5506DC4F0011get_impl*
 Result := f_ItemType;
//#UC END# *5506D49100B7_5506DC4F0011get_impl*
end;//TvcmHistoryItemBase.pm_GetItemType

function TvcmHistoryItemBase.Activate(const aMainForm: IvcmEntityForm): Boolean;
//#UC START# *550938E80131_5506DC4F0011_var*
//#UC END# *550938E80131_5506DC4F0011_var*
begin
//#UC START# *550938E80131_5506DC4F0011_impl*
 Result := Activate(aMainForm, nil);
//#UC END# *550938E80131_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.Activate

function TvcmHistoryItemBase.Activate(const aMainForm: IvcmEntityForm;
  const anOwner: IvcmEntityForm): Boolean;
//#UC START# *5509390702F7_5506DC4F0011_var*
var
 l_SaveSelf: IUnknown;
//#UC END# *5509390702F7_5506DC4F0011_var*
begin
//#UC START# *5509390702F7_5506DC4F0011_impl*
 l_SaveSelf := Self;
 try
  Result := DoActivate(aMainForm, anOwner);
 finally
  l_SaveSelf := nil;
 end;//try..finally
//#UC END# *5509390702F7_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.Activate

function TvcmHistoryItemBase.Drop: Boolean;
//#UC START# *5509391E0197_5506DC4F0011_var*
//#UC END# *5509391E0197_5506DC4F0011_var*
begin
//#UC START# *5509391E0197_5506DC4F0011_impl*
 Result := False;
//#UC END# *5509391E0197_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.Drop

function TvcmHistoryItemBase.IsAcceptable: Boolean;
//#UC START# *550953A00312_5506DC4F0011_var*
//#UC END# *550953A00312_5506DC4F0011_var*
begin
//#UC START# *550953A00312_5506DC4F0011_impl*
 if Assigned(f_DataSource) then
  Result := f_DataSource.IsDataAvailable
 else
  Result := True;
//#UC END# *550953A00312_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.IsAcceptable

procedure TvcmHistoryItemBase.ResetContainer;
//#UC START# *5583B0BD0124_5506DC4F0011_var*
//#UC END# *5583B0BD0124_5506DC4F0011_var*
begin
//#UC START# *5583B0BD0124_5506DC4F0011_impl*
 f_ContainerGUID := nil;
//#UC END# *5583B0BD0124_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.ResetContainer

procedure TvcmHistoryItemBase.Cleanup;
//#UC START# *479731C50290_5506DC4F0011_var*
//#UC END# *479731C50290_5506DC4F0011_var*
begin
//#UC START# *479731C50290_5506DC4F0011_impl*
 f_DataSource := nil;
 f_FormData := nil;
 f_Caption := nil;
 FreeContainer;
 FreeOwner;
 FreeAggregate;
 FreeAndNil(f_PathNode);  
 inherited;
//#UC END# *479731C50290_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.Cleanup

function TvcmHistoryItemBase.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_5506DC4F0011_var*
var
 l_FormSet: IvcmFormSet;
//#UC END# *4A60B23E00C3_5506DC4F0011_var*
begin
//#UC START# *4A60B23E00C3_5506DC4F0011_impl*
 Result := inherited COMQueryInterface(IID, Obj);
 if Result.Fail then
 begin
  if IID.EQ(IvcmFormSet) and vcmInFormSet(f_DataSource, @l_FormSet) then
  begin
   IvcmFormSet(Obj) := l_FormSet;
   Result.SetOK;
  end//if IID.EQ(IvcmFormSet)
  else
   Result.SetNOINTERFACE;
 end;//if l3IFail(Result) then
//#UC END# *4A60B23E00C3_5506DC4F0011_impl*
end;//TvcmHistoryItemBase.COMQueryInterface

type
 TvcmHistoryItemRec = class(TvcmHistoryItemBase)
 private
 // private fields
   f_Docked : TvcmFormHistoryItemList;
   f_Children : TvcmFormHistoryItemList;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // overridden public methods
   constructor Create(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType;
     const aFormId: TvcmFormID;
     aUserType: TvcmUserType;
     aZoneType: TvcmZoneType;
     aItemType: TvcmHistoryItemType;
     aSubUserType: TvcmUserType;
     aForClone: Boolean); override;
 protected
 // protected methods
   function MakeChild(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType): IvcmFormHistoryItem; virtual; abstract;
   procedure SaveOwned(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType;
     out aList: TvcmFormHistoryItemList);
   procedure SaveDocked(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType;
     out aList: TvcmFormHistoryItemList);
   procedure ActivateList(const aMainForm: IvcmEntityForm;
     const aForm: IvcmEntityForm;
     aList: TvcmFormHistoryItemList;
     aInFormSet: Boolean);
 end;//TvcmHistoryItemRec

// start class TvcmHistoryItemRec

procedure TvcmHistoryItemRec.SaveOwned(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType;
  out aList: TvcmFormHistoryItemList);
//#UC START# *550825D501AF_5506DC9F019D_var*
 procedure l_SaveOwned(aControl: TComponent);
 var
  l_Index: Integer;
  l_Child: TComponent;
  l_Form: IvcmEntityForm;
 begin//SaveOwned
  with aControl do
   for l_Index := 0 to Pred(ComponentCount) do
   begin
    l_Child := Components[l_Index];
    if (l_Child Is TCustomForm) and
       Supports(l_Child, IvcmEntityForm, l_Form) then
     try
      if (aList = nil) then
       aList := TvcmFormHistoryItemList.Make;
      aList.Add(MakeChild(l_Form, aStateType));
     finally
      l_Form := nil;
     end;//try..finally
   end;//for l_Index
 end;//l_SaveOwned
//#UC END# *550825D501AF_5506DC9F019D_var*
begin
//#UC START# *550825D501AF_5506DC9F019D_impl*
 aList := nil;
 if not Assigned(aForm.FormSet) and (aStateType = vcm_stContent) then
  l_SaveOwned(aForm.VCLWinControl);
//#UC END# *550825D501AF_5506DC9F019D_impl*
end;//TvcmHistoryItemRec.SaveOwned

procedure TvcmHistoryItemRec.SaveDocked(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType;
  out aList: TvcmFormHistoryItemList);
//#UC START# *550825EE00D2_5506DC9F019D_var*
 procedure l_SaveDocked(aControl: TWinControl);
 var
  l_Index: Integer;
  l_Child: TControl;
  l_Form: IvcmEntityForm;
 begin//l_SaveDocked
  with aControl do
   for l_Index := 0 to Pred(ControlCount) do
   begin
    l_Child := Controls[l_Index];
    if (l_Child Is TCustomForm) and (l_Child.Owner <> aControl) and
       Supports(l_Child, IvcmEntityForm, l_Form) then
     try
      if (aList = nil) then
       aList := TvcmFormHistoryItemList.Make;
      aList.Add(MakeChild(l_Form, aStateType));
     finally
      l_Child := nil;
     end;//try..finally
    if (l_Child Is TWinControl) then
     l_SaveDocked(TWinControl(l_Child));
   end;//for l_Index
 end;//l_SaveDocked
//#UC END# *550825EE00D2_5506DC9F019D_var*
begin
//#UC START# *550825EE00D2_5506DC9F019D_impl*
 aList := nil;
 if not Assigned(aForm.FormSet) and (aStateType = vcm_stContent) then
  l_SaveDocked(aForm.VCLWinControl);
//#UC END# *550825EE00D2_5506DC9F019D_impl*
end;//TvcmHistoryItemRec.SaveDocked

procedure TvcmHistoryItemRec.ActivateList(const aMainForm: IvcmEntityForm;
  const aForm: IvcmEntityForm;
  aList: TvcmFormHistoryItemList;
  aInFormSet: Boolean);
//#UC START# *5508260503CB_5506DC9F019D_var*
var
 l_Index: Integer;
//#UC END# *5508260503CB_5506DC9F019D_var*
begin
//#UC START# *5508260503CB_5506DC9F019D_impl*
 if not aInFormSet and (aList <> nil) then
  with aList do
   for l_Index := Lo to Hi do
    Items[l_Index].Activate(aMainForm, aForm);
//#UC END# *5508260503CB_5506DC9F019D_impl*
end;//TvcmHistoryItemRec.ActivateList

procedure TvcmHistoryItemRec.Cleanup;
//#UC START# *479731C50290_5506DC9F019D_var*
//#UC END# *479731C50290_5506DC9F019D_var*
begin
//#UC START# *479731C50290_5506DC9F019D_impl*
 FreeAndNil(f_Children);
 FreeAndNil(f_Docked);
 inherited;
//#UC END# *479731C50290_5506DC9F019D_impl*
end;//TvcmHistoryItemRec.Cleanup

constructor TvcmHistoryItemRec.Create(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType;
  const aFormId: TvcmFormID;
  aUserType: TvcmUserType;
  aZoneType: TvcmZoneType;
  aItemType: TvcmHistoryItemType;
  aSubUserType: TvcmUserType;
  aForClone: Boolean);
//#UC START# *550811520043_5506DC9F019D_var*
//#UC END# *550811520043_5506DC9F019D_var*
begin
//#UC START# *550811520043_5506DC9F019D_impl*
 try
  inherited Create(aForm, aStateType, aFormId, aUserType, aZoneType, aItemType, aSubUserType, aForClone);
 except
  on EvcmFormWasClosedInSave do
  // - форму закрыли в процессе сохранения
  //   Например БП из-за:
  //    http://mdp.garant.ru/pages/viewpage.action?pageId=321989072&focusedCommentId=330698655#comment-330698655
  begin
   f_Caption := aForm.MainCaption;
   FreeAndNil(f_Children);
   FreeAndNil(f_Docked);
   f_ItemType := vcm_hitClose;
  end;//on EvcmFormWasClosedInSave
 end;//try..except
 if Assigned(aForm) then
 begin
  f_Caption := aForm.MainCaption;
  FreeAndNil(f_Children);
  FreeAndNil(f_Docked);
  SaveOwned(aForm, aStateType, f_Children);
  SaveDocked(aForm, aStateType, f_Docked);
 end;//Assigned(aForm)
//#UC END# *550811520043_5506DC9F019D_impl*
end;//TvcmHistoryItemRec.Create

type
 TvcmContainerHistoryItem = class(TvcmHistoryItemList, IvcmContainerHistoryItem)
 private
 // private fields
   f_Caption : IvcmCString;
 protected
 // realized methods
   function pm_GetCaption: IvcmCString;
   function Add(const anItem: IvcmHistoryItem;
       aDelta: Integer): Boolean;
   function IsEmpty: Boolean;
   function ItemsCount: Integer;
   function GetItem(anIndex: Integer): IvcmHistoryItem;
   function Activate(const aMainForm: IvcmEntityForm): Boolean; overload; 
   function Activate(const aMainForm: IvcmEntityForm;
       const anOwner: IvcmEntityForm): Boolean; overload; 
   function Drop: Boolean;
   function IsAcceptable: Boolean;
     {* можно ли активизировать элемент истории в текущих условиях }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   function DoActivate(const aMainForm: IvcmEntityForm;
     const anOwner: IvcmEntityForm): Boolean; virtual;
 public
 // public methods
   constructor Create(const aCaption: IvcmCString); reintroduce;
   class function Make(const aCaption: IvcmCString): IvcmContainerHistoryItem; reintroduce;
     {* Сигнатура фабрики TvcmContainerHistoryItem.Make }
 end;//TvcmContainerHistoryItem

// start class TvcmContainerHistoryItem

constructor TvcmContainerHistoryItem.Create(const aCaption: IvcmCString);
//#UC START# *550828670328_5506DD0C00BA_var*
//#UC END# *550828670328_5506DD0C00BA_var*
begin
//#UC START# *550828670328_5506DD0C00BA_impl*
 inherited Create;
 f_Caption := aCaption;
//#UC END# *550828670328_5506DD0C00BA_impl*
end;//TvcmContainerHistoryItem.Create

function TvcmContainerHistoryItem.DoActivate(const aMainForm: IvcmEntityForm;
  const anOwner: IvcmEntityForm): Boolean;
//#UC START# *550828F60179_5506DD0C00BA_var*
var
 l_SaveSelf: IUnknown;
 l_Index: Integer;
//#UC END# *550828F60179_5506DD0C00BA_var*
begin
//#UC START# *550828F60179_5506DD0C00BA_impl*
 Result := True;
 l_SaveSelf := Self;
 try
  if not IsEmpty then
  begin
   aMainForm.BeforeHistoryNavigate;
   for l_Index := Lo to Hi do
    if not Items[l_Index].Activate(aMainForm) then
     Result := False;
  end;
 finally
  l_SaveSelf := nil;
 end;//try..finally
//#UC END# *550828F60179_5506DD0C00BA_impl*
end;//TvcmContainerHistoryItem.DoActivate

class function TvcmContainerHistoryItem.Make(const aCaption: IvcmCString): IvcmContainerHistoryItem;
var
 l_Inst : TvcmContainerHistoryItem;
begin
 l_Inst := Create(aCaption);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmContainerHistoryItem.pm_GetCaption: IvcmCString;
//#UC START# *499559980178_5506DD0C00BAget_var*
var
 l_Index: Integer;
//#UC END# *499559980178_5506DD0C00BAget_var*
begin
//#UC START# *499559980178_5506DD0C00BAget_impl*
 Result := f_Caption;
 l_Index := 0;
 while vcmIsNil(Result) and (l_Index < ItemsCount) do
 begin
  Result := GetItem(l_Index).Caption;
  Inc(l_Index);
 end;//while (Result = '')
//#UC END# *499559980178_5506DD0C00BAget_impl*
end;//TvcmContainerHistoryItem.pm_GetCaption

function TvcmContainerHistoryItem.Add(const anItem: IvcmHistoryItem;
  aDelta: Integer): Boolean;
//#UC START# *5506D4C70264_5506DD0C00BA_var*
//#UC END# *5506D4C70264_5506DD0C00BA_var*
begin
//#UC START# *5506D4C70264_5506DD0C00BA_impl*
 if (anItem = nil) then
  Result := False
 else
 begin
  Insert(Count - aDelta, anItem);
  Result := True;
 end;//anItem = nil
//#UC END# *5506D4C70264_5506DD0C00BA_impl*
end;//TvcmContainerHistoryItem.Add

function TvcmContainerHistoryItem.IsEmpty: Boolean;
//#UC START# *5506D4DD031A_5506DD0C00BA_var*
//#UC END# *5506D4DD031A_5506DD0C00BA_var*
begin
//#UC START# *5506D4DD031A_5506DD0C00BA_impl*
 Result := Empty;
//#UC END# *5506D4DD031A_5506DD0C00BA_impl*
end;//TvcmContainerHistoryItem.IsEmpty

function TvcmContainerHistoryItem.ItemsCount: Integer;
//#UC START# *5506D4EF0074_5506DD0C00BA_var*
//#UC END# *5506D4EF0074_5506DD0C00BA_var*
begin
//#UC START# *5506D4EF0074_5506DD0C00BA_impl*
 Result := Count;
//#UC END# *5506D4EF0074_5506DD0C00BA_impl*
end;//TvcmContainerHistoryItem.ItemsCount

function TvcmContainerHistoryItem.GetItem(anIndex: Integer): IvcmHistoryItem;
//#UC START# *5506D504018E_5506DD0C00BA_var*
//#UC END# *5506D504018E_5506DD0C00BA_var*
begin
//#UC START# *5506D504018E_5506DD0C00BA_impl*
 Result := Items[anIndex];
//#UC END# *5506D504018E_5506DD0C00BA_impl*
end;//TvcmContainerHistoryItem.GetItem

function TvcmContainerHistoryItem.Activate(const aMainForm: IvcmEntityForm): Boolean;
//#UC START# *550938E80131_5506DD0C00BA_var*
//#UC END# *550938E80131_5506DD0C00BA_var*
begin
//#UC START# *550938E80131_5506DD0C00BA_impl*
 Result := Activate(aMainForm, nil);
//#UC END# *550938E80131_5506DD0C00BA_impl*
end;//TvcmContainerHistoryItem.Activate

function TvcmContainerHistoryItem.Activate(const aMainForm: IvcmEntityForm;
  const anOwner: IvcmEntityForm): Boolean;
//#UC START# *5509390702F7_5506DD0C00BA_var*
//#UC END# *5509390702F7_5506DD0C00BA_var*
begin
//#UC START# *5509390702F7_5506DD0C00BA_impl*
 Result := DoActivate(aMainForm, anOwner);
//#UC END# *5509390702F7_5506DD0C00BA_impl*
end;//TvcmContainerHistoryItem.Activate

function TvcmContainerHistoryItem.Drop: Boolean;
//#UC START# *5509391E0197_5506DD0C00BA_var*
//#UC END# *5509391E0197_5506DD0C00BA_var*
begin
//#UC START# *5509391E0197_5506DD0C00BA_impl*
 Result := False;
//#UC END# *5509391E0197_5506DD0C00BA_impl*
end;//TvcmContainerHistoryItem.Drop

function TvcmContainerHistoryItem.IsAcceptable: Boolean;
//#UC START# *550953A00312_5506DD0C00BA_var*
var
 l_Index: Integer;
//#UC END# *550953A00312_5506DD0C00BA_var*
begin
//#UC START# *550953A00312_5506DD0C00BA_impl*
 if not IsEmpty then
  for l_Index := Lo to Hi do
   if not Items[l_Index].IsAcceptable then
   begin
    Result := False;
    Exit;
   end;
 Result := True;
//#UC END# *550953A00312_5506DD0C00BA_impl*
end;//TvcmContainerHistoryItem.IsAcceptable

procedure TvcmContainerHistoryItem.Cleanup;
//#UC START# *479731C50290_5506DD0C00BA_var*
//#UC END# *479731C50290_5506DD0C00BA_var*
begin
//#UC START# *479731C50290_5506DD0C00BA_impl*
 f_Caption := nil;
 inherited;
//#UC END# *479731C50290_5506DD0C00BA_impl*
end;//TvcmContainerHistoryItem.Cleanup

type
 TvcmHistoryItemPrim = class(TvcmHistoryItemRec)
 private
 // private fields
   f_StateType : TvcmStateType;
 private
 // private methods
   function NeedCheckHasForm: Boolean;
 protected
 // realized methods
   function DoActivate(const aMainForm: IvcmEntityForm;
     const anOwner: IvcmEntityForm): Boolean; override;
   function MakeChild(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType): IvcmFormHistoryItem; override;
 public
 // overridden public methods
   constructor Create(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType;
     const aFormId: TvcmFormID;
     aUserType: TvcmUserType;
     aZoneType: TvcmZoneType;
     aItemType: TvcmHistoryItemType;
     aSubUserType: TvcmUserType;
     aForClone: Boolean); override;
 end;//TvcmHistoryItemPrim

// start class TvcmHistoryItemPrim

function TvcmHistoryItemPrim.NeedCheckHasForm: Boolean;
//#UC START# *559F7CBC036D_5506DCC90183_var*
//#UC END# *559F7CBC036D_5506DCC90183_var*
begin
//#UC START# *559F7CBC036D_5506DCC90183_impl*
 Result := not SavingClone;
//#UC END# *559F7CBC036D_5506DCC90183_impl*
end;//TvcmHistoryItemPrim.NeedCheckHasForm

function TvcmHistoryItemPrim.DoActivate(const aMainForm: IvcmEntityForm;
  const anOwner: IvcmEntityForm): Boolean;
//#UC START# *55080FE40284_5506DCC90183_var*
 function lpFindForm(out aForm: IvcmEntityForm): Boolean;
 begin//lpFindForm
  Result := False;
  if vcmInFormSet(f_DataSource) and
     NeedCheckHasForm then
  begin
   Result := Container(aMainForm).HasForm(f_FormId,
                                          f_ZoneType,
                                          True,
                                          @aForm,
                                          f_UserType,
                                          nil,
                                          f_SubUserType);
   if Result then                                       
    Assert(not aForm.VCMClosing);
    // - если форма УЖЕ закрывается, то её наверное повторно использовать НЕЛЬЗЯ
  end//vcmInFormSet(f_DataSource)
  else
  begin
   if NeedCheckHasForm then
    Result := g_Dispatcher.FormDispatcher.FindForm(f_FormGUID, aForm);
   if Result then
   begin
    //Assert(not aForm.VCMClosing);
    if aForm.VCMClosing then
    // - если форма УЖЕ закрывается, то её наверное повторно использовать НЕЛЬЗЯ
    begin
     g_Dispatcher.FormDispatcher.RemoveForm(aForm);
     // - удалить её надо из диспетчера, чтобы больше не находилась
     aForm := nil;
     Result := False;
    end;//aForm.VCMClosing 
   end;//Result
  end;//vcmInFormSet(f_DataSource)
 end;//lpFindForm

 function lp_SameUseCase(const aForm: IvcmEntityForm): Boolean;
 begin//lp_SameUseCase
  Result := True;
  if Assigned(f_DataSource) and Assigned(f_DataSource.UseCaseController) and
     Assigned(aForm.DataSource) and Assigned(aForm.DataSource.UseCaseController) then
      Result := vcmIEQ(f_DataSource.UseCaseController, aForm.DataSource.UseCaseController);
 end;//lp_SameUseCase

var
 l_FormData: IvcmBase;
 l_Form: IvcmEntityForm;
 l_Caption: IvcmCString;
 l_Children: TvcmFormHistoryItemList;
 l_Docked: TvcmFormHistoryItemList;
 l_DataSource: IvcmFormDataSource;
 l_UtilizeForm: Boolean;
//#UC END# *55080FE40284_5506DCC90183_var*
begin
//#UC START# *55080FE40284_5506DCC90183_impl*
 Result := True; 
 // Форма должна быть закрыта
 if f_ItemType = vcm_hitClose then
 begin
  l_Form := nil;
  if NeedCheckHasForm then
   aMainForm.AsContainer.HasForm(f_FormId, f_ZoneType, True, @l_Form, f_UserType, nil, f_SubUserType);
  if Assigned(l_Form) then
  try
   f_ItemType := vcm_hitContent;
   UpdateFormInfo(l_Form);
   if not l_Form.SaveState(l_FormData, f_StateType) then
    l_FormData := nil;
   f_FormData := l_FormData;
   l_Form.SafeClose;
  finally
   l_Form := nil;
  end;//try..finally
 end//if f_StateType = vcm_stMissing then
 // Создадим форму из истории
 else
 begin
  l_Children := nil;
  l_Docked := nil;
  try
   l_FormData := f_FormData;
   // Форма ничего не знает про тип
   if lpFindForm(l_Form) then
   begin
    // Форма была открыта в процессе работы
    l_UtilizeForm := True;
    if (f_ItemType = vcm_hitContent) then
     f_ItemType := vcm_hitNone;
    SaveOwned(l_Form, f_StateType, l_Children);
    SaveDocked(l_Form, f_StateType, l_Docked);
    if not l_Form.SaveState(l_FormData, f_StateType) then
     // - сохраняем данные, для симметричности вызовов SaveState/LoadState.
     l_FormData := nil;
   end//lpFindForm(l_Form)
   else
   begin
    l_Form := MakeForm(aMainForm, anOwner, f_DataSource);
    if (l_Form = nil) then
     Exit;
    l_Children := nil;
    l_Docked := nil;
    // Форма должна быть закрыта
    f_ItemType := vcm_hitClose;
    l_UtilizeForm := False;
   end;//lpFindForm(l_Form)
   l_Caption := l_Form.{VCLForm.}MainCaption;
   //l_Form.DataSource := f_DataSource;
   // ^Если ты бля такой умный и хочешь переставить эту строчку сюда,
   //  то читай внимательно - http://mdp.garant.ru/pages/viewpage.action?pageId=267324195&focusedCommentId=269072024#comment-269072024
   l_Form.LoadState(f_FormData, f_StateType);
   l_Form.Caption := f_Caption;
   RestoreFocused(l_Form);
   f_Caption := l_Caption;
   // Только для форм без сборки, сборка сама контролирует запись в историю
   ActivateList(aMainForm, l_Form, f_Children, Assigned(l_Form.FormSet));
   ActivateList(aMainForm, nil, f_Docked, Assigned(l_Form.FormSet));
   l_DataSource := l_Form.DataSource;
   // Если утилизируем форму снесем ей сначала DataSource
   // чтоб эмулировать удаление/создание K-136262540
   if l_UtilizeForm then
   begin
    if l_Form.IsMainInFormSet and not lp_SameUseCase(l_Form) then
     l_Form.FormSet.PopToHistory;
    l_Form.DataSource := nil;
   end;//l_UtilizeForm
   l_Form.DataSource := f_DataSource;
   f_DataSource := l_DataSource;
   f_FormData := l_FormData;
   // - устанавливаем новые данные формы
   vcmSet(f_Children, l_Children);
   // - устанавливаем информацию о новых детях
   vcmSet(f_Docked, l_Docked);
   // - устанавливаем информацию о новых подчиненных
   if (f_ItemType = vcm_hitContent) then
    f_ItemType := vcm_hitClose;
  finally
   FreeAndNil(l_Children);
   FreeAndNil(l_Docked);
  end;//try..finally
 end;//if f_StateType = vcm_stMissing then
//#UC END# *55080FE40284_5506DCC90183_impl*
end;//TvcmHistoryItemPrim.DoActivate

function TvcmHistoryItemPrim.MakeChild(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType): IvcmFormHistoryItem;
//#UC START# *550825AC0253_5506DCC90183_var*
//#UC END# *550825AC0253_5506DCC90183_var*
begin
//#UC START# *550825AC0253_5506DCC90183_impl*
 Result := Make(aForm, aStateType);
//#UC END# *550825AC0253_5506DCC90183_impl*
end;//TvcmHistoryItemPrim.MakeChild

constructor TvcmHistoryItemPrim.Create(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType;
  const aFormId: TvcmFormID;
  aUserType: TvcmUserType;
  aZoneType: TvcmZoneType;
  aItemType: TvcmHistoryItemType;
  aSubUserType: TvcmUserType;
  aForClone: Boolean);
//#UC START# *550811520043_5506DCC90183_var*
//#UC END# *550811520043_5506DCC90183_var*
begin
//#UC START# *550811520043_5506DCC90183_impl*
 inherited Create(aForm, aStateType, aFormId, aUserType, aZoneType, aItemType, aSubUserType, aForClone);
 f_StateType := aStateType;
//#UC END# *550811520043_5506DCC90183_impl*
end;//TvcmHistoryItemPrim.Create

type
 TvcmContainerFormSetHistoryItem = class(TvcmContainerHistoryItem)
 protected
 // overridden protected methods
   function DoActivate(const aMainForm: IvcmEntityForm;
     const anOwner: IvcmEntityForm): Boolean; override;
 end;//TvcmContainerFormSetHistoryItem

// start class TvcmContainerFormSetHistoryItem

function TvcmContainerFormSetHistoryItem.DoActivate(const aMainForm: IvcmEntityForm;
  const anOwner: IvcmEntityForm): Boolean;
//#UC START# *550828F60179_5506DD5502B6_var*
var
 l_SaveSelf: IUnknown;
 l_Index: Integer;
 l_List: TvcmHistoryItemList;
 l_FormItem: IvcmFormHistoryItem;
 l_FormSet: IvcmFormSet;
 l_MainObjectForm: IvcmEntityForm;
 l_NeedLock: Boolean;
//#UC END# *550828F60179_5506DD5502B6_var*
begin
//#UC START# *550828F60179_5506DD5502B6_impl*
 Result := True;
 l_SaveSelf := Self;
 try
  if not IsEmpty then
  begin
   l_NeedLock := False;
   if aMainForm.AsContainer.HasForm(vcm_ztMainObjectForm, True, @l_MainObjectForm) then
   begin
    if not l_MainObjectForm.IsMainInFormSet then
     l_MainObjectForm := l_MainObjectForm.Container.AsForm;
    if (l_MainObjectForm <> nil) then
     if (l_MainObjectForm.IsMainInFormSet) then
     begin
      l_NeedLock := True;
      g_Dispatcher.History.BeforeFormDestroy(l_MainObjectForm);
     end;//l_MainObjectForm.IsMainInFormSet
   end;//aMainForm.AsContainer.HasForm(vcm_ztMainObjectForm
   if l_NeedLock then
    Inc(g_LockBeforeFormDestroy);
   try
    l_List := TvcmHistoryItemList.Create;
    try
     // Нам нужно получить FormSet до того как мы начнем активировать элементы,
     // т.к. в процессе активации данные элементов будут замененны:
     l_FormSet := nil;
     if (Hi >= 0) then
      Supports(Items[0], IvcmFormSet, l_FormSet);

     l_FormSet.Container := aMainForm.AsContainer;


     // Формы которые должны быть закрыты. Сохраняем сначала, поэтому что была
     // ситуация, когда в текущем и предыдущем шаге разные формы находились в
     // одном контейнере, при создании Формы1 существующая Форма2 удалялась и
     // когда доходили до элемента истории связанного с Формой2 он не заполнялся,
     // поскольку Формы2 уже не было (cq 00018103). Поэтому сначала сохраняются
     // формы, которые должны быть закрыты, потом создаются новые, или
     // перегружаются существующие.
     //
     for l_Index := Hi downto Lo do
      // for l_Index := Hi downto Lo do
      //   - потому, что формы из сборки записываются рекурсивным обходом дерева
      //     сборки и нам нужно сначала закрыть детей потом родителей, в которые
      //     они вложены.
      if Supports(Items[l_Index], IvcmFormHistoryItem, l_FormItem) then
      begin
       with l_FormItem do
        if ItemType = vcm_hitClose then
         Activate(aMainForm)
        else
         // l_List.Insert(0, Items[l_Index]) -
         //   - с точностью до наоборот, создаем родителей, потом детей.
         l_List.Insert(0, Items[l_Index]);
      end//Supports(Items[l_Index], IvcmFormHistoryItem, l_FormItem)
 (*     else
      if Supports(Items[l_Index], IvcmObjectWithDataHistoryItem) then
       IvcmHistoryItem(Items[l_Index]).Activate(aMainForm)*)
   // Это всё попытки залечить http://mdp.garant.ru/pages/viewpage.action?pageId=267324195
   // но дело оказалось не в этом
      ;
     // Формы которые должны быть созданы
     for l_Index := l_List.Lo to l_List.Hi do
      with l_List[l_Index] do
       Activate(aMainForm);
     // Сообщим, что можно обновлять представление сборки:
     if l_FormSet <> nil then
      l_FormSet.PushFromHistory;
    finally
     FreeAndNil(l_List);
    end;//try..finally
   finally
    if l_NeedLock then
     Dec(g_LockBeforeFormDestroy);
   end;//try..finally
  end;//if not IsEmpty then
 finally
  l_SaveSelf := nil;
 end;//try..finally
//#UC END# *550828F60179_5506DD5502B6_impl*
end;//TvcmContainerFormSetHistoryItem.DoActivate

type
 TvcmHistoryItem = class(TvcmHistoryItemRec)
 protected
 // realized methods
   function DoActivate(const aMainForm: IvcmEntityForm;
     const anOwner: IvcmEntityForm): Boolean; override;
   function MakeChild(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType): IvcmFormHistoryItem; override;
 public
 // public methods
   class function Make(const aForm: IvcmEntityForm;
     aStateType: TvcmStateType;
     InDestroy: Boolean;
     aForClone: Boolean): IvcmFormHistoryItem;
 end;//TvcmHistoryItem

// start class TvcmHistoryItem

class function TvcmHistoryItem.Make(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType;
  InDestroy: Boolean;
  aForClone: Boolean): IvcmFormHistoryItem;
//#UC START# *55082738022C_5506DCE50052_var*
var
 l_Item: TvcmHistoryItem;
//#UC END# *55082738022C_5506DCE50052_var*
begin
//#UC START# *55082738022C_5506DCE50052_impl*
 if InDestroy then
 begin
  g_Dispatcher.UpdateStatus;
  with (aForm.VCLWinControl as TvcmEntityForm) do
   l_Item := Self.Create(aForm, aStateType, FormId, UserType, ZoneType,
    vcm_hitNone, SubUserType, aForClone);
  try
   Result := l_Item;
  finally
   FreeAndNil(l_Item);
  end;//try..finally
 end//InDestroy
 else
  Result := TvcmHistoryItemPrim.Make(aForm, aStateType);
//#UC END# *55082738022C_5506DCE50052_impl*
end;//TvcmHistoryItem.Make

function TvcmHistoryItem.DoActivate(const aMainForm: IvcmEntityForm;
  const anOwner: IvcmEntityForm): Boolean;
//#UC START# *55080FE40284_5506DCE50052_var*
var
 l_Form: IvcmEntityForm;
 l_Caption: IvcmCString;
 l_DataSource: IvcmFormDataSource;
//#UC END# *55080FE40284_5506DCE50052_var*
begin
//#UC START# *55080FE40284_5506DCE50052_impl*
 Result := True;
 if g_Dispatcher.FormDispatcher.FindForm(f_FormGUID, l_Form) then
 begin
  //Assert(not l_Form.VCMClosing);
  // - если форма УЖЕ закрывается, то её наверное повторно использовать НЕЛЬЗЯ
  if not l_Form.VCMClosing then
  // -  например это ОДНО ОМ уже ЗАКРЫВАЕТСЯ, а хочется создать НОВОЕ
  // http://mdp.garant.ru/pages/viewpage.action?pageId=332566005
   Exit
  // - форма уже восстановлена
  else
   g_Dispatcher.FormDispatcher.RemoveForm(l_Form);
   // - удалить её надо из диспетчера, чтобы больше не находилась
 end;//g_Dispatcher.FormDispatcher.FindForm(f_FormGUID, l_Form)
 l_Form := MakeForm(aMainForm, anOwner, nil);
 if (l_Form <> nil) then
  Result := l_Form.IsAcceptable(False);
 if (f_FormClass <> nil) then
  Assert(l_Form <> nil,
         Format('А может ли тут быть такое, что форма не создана? FormClass = %s Caption = %s',
                [f_FormClass.ClassName, l3Str(f_Caption)]));
 if not Result then
  l_Form := nil;
 if (l_Form = nil) then
  Exit;
 l_Caption := l_Form.{VCLForm.}MainCaption;
 l_Form.LoadState(f_FormData, vcm_stContent);
 l_Form.Caption := f_Caption;
 l_DataSource := l_Form.DataSource;
 l_Form.DataSource := f_DataSource;
 f_DataSource := l_DataSource;
 RestoreFocused(l_Form);
 f_Caption := l_Caption;
 ActivateList(aMainForm, l_Form, f_Children, Assigned(l_Form.FormSet));
 ActivateList(aMainForm, nil, f_Docked, Assigned(l_Form.FormSet));
//#UC END# *55080FE40284_5506DCE50052_impl*
end;//TvcmHistoryItem.DoActivate

function TvcmHistoryItem.MakeChild(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType): IvcmFormHistoryItem;
//#UC START# *550825AC0253_5506DCE50052_var*
//#UC END# *550825AC0253_5506DCE50052_var*
begin
//#UC START# *550825AC0253_5506DCE50052_impl*
 Result := Make(aForm, aStateType, True, SavingClone);
//#UC END# *550825AC0253_5506DCE50052_impl*
end;//TvcmHistoryItem.MakeChild
var cMaxCount : Integer = 10;

// start class TvcmHistory

function TvcmHistory.NeedSaveForm(const aForm: IvcmEntityForm;
  InDestroy: Boolean): Boolean;
//#UC START# *5506D91401EE_5506D56E02FB_var*
var
 l_Main: IvcmEntityForm;
 l_VMain: TWinControl;
 l_Container: IvcmContainer;
 l_Form: IvcmEntityForm;
//#UC END# *5506D91401EE_5506D56E02FB_var*
begin
//#UC START# *5506D91401EE_5506D56E02FB_impl*
 Result := False;
 if (aForm = nil) then
  Exit;
 if f_ForceSave and not InDestroy then
 begin
  Result := True;
  Exit;
 end;//f_ForceSave..
 l_Main := MainForm;
 if (l_Main = nil) then
  Exit;
 try
  l_VMain := l_Main.VCLWinControl;
  l_Form := aForm;
  l_Container := aForm.Container;
  while True do
  begin
   if (l_Container = nil) or l_Container.IsNULL then
    Exit;
   if (l_Container.AsForm.VCLWinControl = l_VMain) then
    if (l_Form.ZoneType in g_MenuManager.HistoryZones) then
     Break
    else
     Exit;
   l_Form := l_Container.AsForm;
   l_Container := l_Container.AsForm.Container;
  end;//while True
  Result := True;
 finally
  // - если форма находится в списке добавленных и руками дернули ее сохранение
  if not Result and (f_Forms <> nil) then
   Result := (f_Forms.IndexOf(aForm) >= 0);
 end;//try..finally
//#UC END# *5506D91401EE_5506D56E02FB_impl*
end;//TvcmHistory.NeedSaveForm

function TvcmHistory.CheckAnother(const aForm: IvcmEntityForm;
  out theHistory: IvcmHistory): Boolean;
//#UC START# *5506D937025E_5506D56E02FB_var*
var
 l_Form: TCustomForm;
 l_MainForm: IvcmMainForm;
 l_History: IvcmHistory;
//#UC END# *5506D937025E_5506D56E02FB_var*
begin
//#UC START# *5506D937025E_5506D56E02FB_impl*
 Result := False;
 if (aForm <> nil) then
 begin
  l_Form := (aForm.VCLWinControl as TCustomForm);
  while (l_Form <> nil) do
  begin
   if Supports(l_Form, IvcmMainForm, l_MainForm) then
   try
    l_History := l_MainForm.History;
    if not vcmIEQ(Self, l_History) then
    begin
     Result := True;
     theHistory := l_History;
    end;//not vcmIEQ(Self, l_History)
    Break;
   finally
    l_MainForm := nil;
   end;//try..finally
   l_Form := afw.GetAnotherParentForm(l_Form);
  end;//while True
 end;//aForm = nil
//#UC END# *5506D937025E_5506D56E02FB_impl*
end;//TvcmHistory.CheckAnother

function TvcmHistory.GetCaption(anIndex: Integer): IvcmCString;
//#UC START# *5506D97302DF_5506D56E02FB_var*
const
 cCont = '...';
 cLen = 73;
var
 l_Res: AnsiString; 
//#UC END# *5506D97302DF_5506D56E02FB_var*
begin
//#UC START# *5506D97302DF_5506D56E02FB_impl*
 if (f_History = nil) or (anIndex < 0) or (anIndex >= f_History.Count) then
  Result := str_vcmWrongHistoryElement.AsCStr
 else
 begin
  Result := f_History[anIndex].Caption;
  if vcmIsNil(Result) then
   Result := vcmCStr(IntToStr(Succ(anIndex)));
 end;//f_History = nil..
 if (vcmLen(Result) > cLen) then
 begin
  l_Res := vcmStr(Result);
  SetLength(l_Res, cLen - Length(cCont));
  Result := vcmCStr(l_Res + cCont);
 end;//Length(Result)
//#UC END# *5506D97302DF_5506D56E02FB_impl*
end;//TvcmHistory.GetCaption

constructor TvcmHistory.Create(const aMainForm: IvcmEntityForm);
//#UC START# *5506D99500B7_5506D56E02FB_var*
//#UC END# *5506D99500B7_5506D56E02FB_var*
begin
//#UC START# *5506D99500B7_5506D56E02FB_impl*
 inherited Create;
 f_MainForm := Pointer(aMainForm);
 f_Last := True;
//#UC END# *5506D99500B7_5506D56E02FB_impl*
end;//TvcmHistory.Create

class function TvcmHistory.Make(const aMainForm: IvcmEntityForm): IvcmHistory;
var
 l_Inst : TvcmHistory;
begin
 l_Inst := Create(aMainForm);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmHistory.pm_GetMainForm: IvcmEntityForm;
//#UC START# *5506D8CD0392_5506D56E02FBget_var*
//#UC END# *5506D8CD0392_5506D56E02FBget_var*
begin
//#UC START# *5506D8CD0392_5506D56E02FBget_impl*
 Result := IvcmEntityForm(f_MainForm);
//#UC END# *5506D8CD0392_5506D56E02FBget_impl*
end;//TvcmHistory.pm_GetMainForm

procedure TvcmHistory.BeforeFormDestroy(const aForm: IvcmEntityForm);
//#UC START# *499559BF038A_5506D56E02FB_var*
//#UC END# *499559BF038A_5506D56E02FB_var*
begin
//#UC START# *499559BF038A_5506D56E02FB_impl*
 // Только для форм без сборки (сборка сама занимается сохранением)
 if not Assigned(aForm.FormSet) then
  InternalSaveState(aForm, vcm_stContent, True)
 else
 if aForm.IsMainInFormSet then
  if (g_LockBeforeFormDestroy = 0) then
   with aForm.FormSet do
   begin
    PopToHistory;
    SaveHistory;
   end;//if aForm.IsMainInFormSet then
//#UC END# *499559BF038A_5506D56E02FB_impl*
end;//TvcmHistory.BeforeFormDestroy

function TvcmHistory.ForceSaveState(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType = vcm_stContent): Boolean;
//#UC START# *499559C900EE_5506D56E02FB_var*
//#UC END# *499559C900EE_5506D56E02FB_var*
begin
//#UC START# *499559C900EE_5506D56E02FB_impl*
 Result := InternalSaveState(aForm, aStateType, False, True);
//#UC END# *499559C900EE_5506D56E02FB_impl*
end;//TvcmHistory.ForceSaveState

function TvcmHistory.SaveState(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType = vcm_stContent): Boolean;
//#UC START# *499559DD00D6_5506D56E02FB_var*
//#UC END# *499559DD00D6_5506D56E02FB_var*
begin
//#UC START# *499559DD00D6_5506D56E02FB_impl*
 Result := InternalSaveState(aForm, aStateType, False);
//#UC END# *499559DD00D6_5506D56E02FB_impl*
end;//TvcmHistory.SaveState

procedure TvcmHistory.SaveClose(const aForm: IvcmEntityForm;
  const aFormID: TvcmFormID;
  aUserType: TvcmUserType;
  aZoneType: TvcmZoneType;
  aSubUserType: TvcmUserType);
//#UC START# *499559EC0143_5506D56E02FB_var*
var
 l_History: IvcmHistory;
//#UC END# *499559EC0143_5506D56E02FB_var*
begin
//#UC START# *499559EC0143_5506D56E02FB_impl*
 if CheckAnother(aForm, l_History) then
  (l_History as IvcmInternalHistory).SaveClose(aForm, aFormId, aUserType, aZoneType, aSubUserType)
 else
  Add(TvcmHistoryItemPrim.Make(aForm, vcm_stContent, aFormId, aUserType, aZoneType, vcm_hitClose, aSubUserType, False));
//#UC END# *499559EC0143_5506D56E02FB_impl*
end;//TvcmHistory.SaveClose

function TvcmHistory.HasInPreviousStep(const aFormClass: TvcmFormID;
  aUserType: TvcmUserType = vcm_utAny): Boolean;
//#UC START# *49955A0E01FD_5506D56E02FB_var*
 function Check(const aItem: IvcmHistoryItem): Boolean;
 var
  l_FormItem: IvcmFormHistoryItem;
 begin//Check
  Result := Supports(aItem, IvcmFormHistoryItem,
   l_FormItem) and not l_FormItem.FormClass.EQ(aFormClass) and
   ((aUserType = vcm_utAny) or (l_FormItem.UserType = aUserType));
 end;//Check

var
 l_ContItem: IvcmContainerHistoryItem;
 l_Check: Boolean;
 l_Index: Integer;
//#UC END# *49955A0E01FD_5506D56E02FB_var*
begin
//#UC START# *49955A0E01FD_5506D56E02FB_impl*
 l_Check := True;
 while (f_Current > 0) do
 begin
  if Supports(f_History[f_Current - 1], IvcmContainerHistoryItem, l_ContItem) then
  begin
   l_Check := False;
   for l_Index := 0 to l_ContItem.ItemsCount - 1 do
    if Check(l_ContItem.GetItem(l_Index)) then
    begin
     l_Check := True;
     Break;
    end;//Check(l_ContItem.GetItem(l_Index))
  end//Supports(f_History[f_Current - 1], IvcmContainerHistoryItem, l_ContItem)
  else
   l_Check := Check(f_History[f_Current - 1]);
  Back;
  if not l_Check then
   Break;
 end;//while (f_Current > 0)
 Result := not l_Check;
//#UC END# *49955A0E01FD_5506D56E02FB_impl*
end;//TvcmHistory.HasInPreviousStep

function TvcmHistory.Back(aTruncate: Boolean = False): Boolean;
//#UC START# *49955A280277_5506D56E02FB_var*
var
 l_Current: Integer;
 l_Item: IvcmHistoryItem;
 l_Accept: Boolean;
//#UC END# *49955A280277_5506D56E02FB_var*
begin
//#UC START# *49955A280277_5506D56E02FB_impl*
 l_Accept := True;
 Result := CanBack;
 if not f_Multi then
  f_Last := True;
 if Result then
 begin
  if not f_History[f_Current - 1].IsAcceptable then
  begin
   DeleteBackItem;
   Result := Back(aTruncate);
   Exit;
  end;
  g_Dispatcher.FormDispatcher.Lock;
  try
   g_Dispatcher.StoreFocus;
   try
    g_Dispatcher.BeginOp;
    try
     Dec(f_Current);
     l_Current := f_Current;
     f_InBF := True;
     try
      f_InBack := True;
      l_Item := f_History[l_Current];
      l_Accept := l_Item.Activate(MainForm);
      //
      if aTruncate and (l_Current >= 0) then
       f_History.Count := l_Current;
     finally
      f_InBF := False;
     end;//try..finally
     f_Current := l_Current;
    finally
     g_Dispatcher.EndOp;
    end;//try..finally
   finally
    g_Dispatcher.RestoreFocus;
   end;//try..finally
  finally
   g_Dispatcher.FormDispatcher.Unlock;
  end;//try..finally
  if not l_Accept then
  begin
   Result := Back(True);
  end;
 end;//f_Current > 0
//#UC END# *49955A280277_5506D56E02FB_impl*
end;//TvcmHistory.Back

function TvcmHistory.Forward: Boolean;
//#UC START# *49955A3202E4_5506D56E02FB_var*
var
 l_Current: Integer;
 l_Item: IvcmHistoryItem;
 l_Accept: Boolean;
//#UC END# *49955A3202E4_5506D56E02FB_var*
begin
//#UC START# *49955A3202E4_5506D56E02FB_impl*
 l_Accept := True;
 Result := CanForward;
 if not f_Multi then
  f_Last := True;
 if Result then
 begin
  if not f_History[f_Current].IsAcceptable then
  begin
   DeleteForwardItem;
   Result := Forward;
   Exit;
  end;
  g_Dispatcher.FormDispatcher.Lock;
  try
   g_Dispatcher.StoreFocus;
   try
    g_Dispatcher.BeginOp;
    try
     l_Current := f_Current;
     f_InBF := True;
     try
      f_InBack := False;
      l_Item := f_History[l_Current];
      l_Accept := l_Item.Activate(MainForm);
     finally
      f_InBF := False;
     end;//try..finally
     f_Current := Succ(l_Current);
    finally
     g_Dispatcher.EndOp;
    end;//try..finally
   finally
    g_Dispatcher.RestoreFocus;
   end;//try..finally
  finally
   g_Dispatcher.FormDispatcher.Unlock;
  end;//try..finally
  if not l_Accept then
  begin
   Result := Forward;
  end;
 end;//f_Current >= 0
//#UC END# *49955A3202E4_5506D56E02FB_impl*
end;//TvcmHistory.Forward

procedure TvcmHistory.Back(const aParams: IvcmExecuteParamsPrim;
  aTruncate: Boolean = False);
//#UC START# *49955A4401E0_5506D56E02FB_var*
var
 l_To: Integer;
//#UC END# *49955A4401E0_5506D56E02FB_var*
begin
//#UC START# *49955A4401E0_5506D56E02FB_impl*
 l_To := aParams.ItemIndex;
 if (l_To <= 0) then
  l_To := 1;
 f_Multi := True;
 try
  f_Last := l_To = 1;
  while (l_To > 0) and Back(aTruncate) do
  begin
   Dec(l_To);
   f_Last := l_To = 1;
  end;
 finally
  f_Multi := False;
  f_Last := True;
 end;
//#UC END# *49955A4401E0_5506D56E02FB_impl*
end;//TvcmHistory.Back

procedure TvcmHistory.Forward(const aParams: IvcmExecuteParamsPrim);
//#UC START# *49955A4F00AB_5506D56E02FB_var*
var
 l_To: Integer;
//#UC END# *49955A4F00AB_5506D56E02FB_var*
begin
//#UC START# *49955A4F00AB_5506D56E02FB_impl*
 l_To := aParams.ItemIndex;
 if (l_To <= 0) then
  l_To := 1;
 f_Multi := True;
 f_Last := l_To = 1;
 try
  while (l_To > 0) and Forward do
  begin
   Dec(l_To);
   f_Last := l_To = 1;
  end;
 finally
  f_Multi := False;
  f_Last := True; 
 end; 
//#UC END# *49955A4F00AB_5506D56E02FB_impl*
end;//TvcmHistory.Forward

function TvcmHistory.CanBack: Boolean;
//#UC START# *49955A5B00B1_5506D56E02FB_var*
//#UC END# *49955A5B00B1_5506D56E02FB_var*
begin
//#UC START# *49955A5B00B1_5506D56E02FB_impl*
 Result := (f_History <> nil) and (f_Current > 0) and (f_Current <= f_History.Count);
//#UC END# *49955A5B00B1_5506D56E02FB_impl*
end;//TvcmHistory.CanBack

function TvcmHistory.CanForward: Boolean;
//#UC START# *49955A6701A1_5506D56E02FB_var*
//#UC END# *49955A6701A1_5506D56E02FB_var*
begin
//#UC START# *49955A6701A1_5506D56E02FB_impl*
 Result := (f_History <> nil) and (f_Current >= 0) and (f_Current < f_History.Count);
//#UC END# *49955A6701A1_5506D56E02FB_impl*
end;//TvcmHistory.CanForward

procedure TvcmHistory.GetBackStrings(const aParams: IvcmTestParamsPrim);
//#UC START# *49955A71029F_5506D56E02FB_var*
var
 l_Index: Integer;
//#UC END# *49955A71029F_5506D56E02FB_var*
begin
//#UC START# *49955A71029F_5506D56E02FB_impl*
 with aParams.Op.SubItems do
 begin
  Clear;
  if (f_History <> nil) then
   for l_Index := Pred(f_Current) downto Max(f_Current - cMaxCount, 0) do
    Add(GetCaption(l_Index));
 end;//with aParams.Op.SubItems
//#UC END# *49955A71029F_5506D56E02FB_impl*
end;//TvcmHistory.GetBackStrings

procedure TvcmHistory.GetForwardStrings(const aParams: IvcmTestParamsPrim);
//#UC START# *49955A7B015F_5506D56E02FB_var*
var
 l_Index: Integer;
//#UC END# *49955A7B015F_5506D56E02FB_var*
begin
//#UC START# *49955A7B015F_5506D56E02FB_impl*
 with aParams.Op.SubItems do
 begin
  Clear;
  if (f_History <> nil) then
   for l_Index := f_Current to Pred(Min(f_Current + cMaxCount, f_History.Count)) do
    Add(GetCaption(l_Index));
 end;//with aParams.Op.SubItems
//#UC END# *49955A7B015F_5506D56E02FB_impl*
end;//TvcmHistory.GetForwardStrings

procedure TvcmHistory.Start(const aSender: IvcmEntityForm;
  const aCaption: IvcmCString = nil;
  aFormSet: Boolean = False);
//#UC START# *49955A870211_5506D56E02FB_var*
var
 l_Index: Integer;
 l_Delta: Integer;
 l_History: IvcmHistory;
 l_Form: IvcmEntityForm;
//#UC END# *49955A870211_5506D56E02FB_var*
begin
//#UC START# *49955A870211_5506D56E02FB_impl*
 if CheckAnother(aSender, l_History) then
  l_History.Start(aSender)
 else
 begin
  if (f_Starts = 0) then
  begin
   // Пока закомментировал в связи с
   // http://mdp.garant.ru/pages/viewpage.action?pageId=424393579
   // Assert(aCaption = nil);
   // - проверяем необходимомсть параметра
   if not aFormSet then
    f_ContainerItem := TvcmContainerHistoryItem.Make(aCaption)
   else
    f_ContainerItem := TvcmContainerFormSetHistoryItem.Make(aCaption);
  end;//f_Starts = 0
  Inc(f_Starts);
  if (f_Starts = 1) then
  begin
   f_Delta := 0;
   if (f_Forms <> nil) then
   begin
    f_ForceSave := True;
    try
     l_Delta := 0;
     with f_Forms do
     begin
      l_Index := 0;
      while (l_Index < Count) do
      begin
       l_Form := Items[l_Index];
       if l_Form.InClose then
       begin
        if SaveState(l_Form, vcm_stContent) then
         Inc(l_Delta);
       end//l_Form.InClose
       else
       begin
        if SaveState(l_Form, vcm_stPosition) then
         Inc(l_Delta);
       end;//l_Form.InClose
       Inc(l_Index);
      end;//while (l_Index < Count)
     end;//with f_Forms
     f_Delta := l_Delta;
    finally
     f_ForceSave := False;
    end;//try..finally
   end;//f_Forms <> nil
  end;//f_Starts = 1
 end;//CheckAnother(aForm, l_History)
//#UC END# *49955A870211_5506D56E02FB_impl*
end;//TvcmHistory.Start

procedure TvcmHistory.Finish(const aSender: IvcmEntityForm);
//#UC START# *49955AA6028E_5506D56E02FB_var*
var
 l_Container: IvcmContainerHistoryItem;
 l_History: IvcmHistory;
//#UC END# *49955AA6028E_5506D56E02FB_var*
begin
//#UC START# *49955AA6028E_5506D56E02FB_impl*
 if CheckAnother(aSender, l_History) then
  l_History.Finish(aSender)
 else
 begin
  Dec(f_Starts);
  if (f_Starts = 0) then
  begin
   l_Container := f_ContainerItem;
   f_ContainerItem := nil;
   if (l_Container <> nil) and
      not l_Container.IsEmpty and
      (l_Container.ItemsCount > f_Delta) then
   begin
    if (l_Container.ItemsCount > 1) then
     Add(l_Container)
    else
     Add(l_Container.GetItem(0));
   end;//not l_Container.IsEmpty
  end;//f_Starts = 0
 end;//CheckAnother(aSender, l_History)
//#UC END# *49955AA6028E_5506D56E02FB_impl*
end;//TvcmHistory.Finish

procedure TvcmHistory.AddForm(const aForm: IvcmEntityForm);
//#UC START# *49955AB102DB_5506D56E02FB_var*
var
 l_History: IvcmHistory;
//#UC END# *49955AB102DB_5506D56E02FB_var*
begin
//#UC START# *49955AB102DB_5506D56E02FB_impl*
 if CheckAnother(aForm, l_History) then
  l_History.AddForm(aForm)
 else
 begin
  if (f_Forms = nil) then
   f_Forms := TvcmIEntityFormPtrList.MakeSorted;
  f_Forms.Add(aForm);
 end;//CheckAnother(aForm, l_History)
//#UC END# *49955AB102DB_5506D56E02FB_impl*
end;//TvcmHistory.AddForm

procedure TvcmHistory.RemoveForm(const aForm: IvcmEntityForm);
//#UC START# *49955ABC00AD_5506D56E02FB_var*
var
 l_History: IvcmHistory;
//#UC END# *49955ABC00AD_5506D56E02FB_var*
begin
//#UC START# *49955ABC00AD_5506D56E02FB_impl*
 if CheckAnother(aForm, l_History) then
 begin
  if (l_History <> nil) then // здесь эта проверка нужна !!!
   l_History.RemoveForm(aForm)
 end
 else
 begin
  if (f_Forms <> nil) then
   f_Forms.Remove(aForm);
 end;//CheckAnother(aForm, l_History)
//#UC END# *49955ABC00AD_5506D56E02FB_impl*
end;//TvcmHistory.RemoveForm

function TvcmHistory.Add(const anItem: IvcmHistoryItem): Boolean;
//#UC START# *49955AC80055_5506D56E02FB_var*
var
 l_Index: Integer;  
//#UC END# *49955AC80055_5506D56E02FB_var*
begin
//#UC START# *49955AC80055_5506D56E02FB_impl*
 if (f_ContainerItem <> nil) then
 begin
  Result := f_ContainerItem.Add(anItem, f_Delta);
 end//f_ContainerItem <> nil
 else
 begin
  if (f_History = nil) then
   f_History := TvcmHistoryItemList.Create;
  if (f_Current >= f_History.Count) then
   Result := (f_History.Add(anItem) >= 0)
  else
  begin
   Result := True;
   f_History[f_Current] := anItem;
   if not f_InBF then
    f_History.Count := Succ(f_Current);
  end;
  if not f_InBF then
  begin
   l_Index := 0;
   while (f_History.Count - l_Index > g_vcmHistoryLimit) do
   begin
    if f_History[l_Index].Drop then
     // - удалось выместить на диск
     Inc(l_Index)
    else
    begin
     f_History.Delete(l_Index);
     Dec(f_Current);
    end;//f_History[l_Index].Drop
   end;//f_History.Count > g_vcmHistoryLimit
  end;//not f_InBF
  Inc(f_Current);
 end;//f_ContainerItem <> nil
//#UC END# *49955AC80055_5506D56E02FB_impl*
end;//TvcmHistory.Add

function TvcmHistory.IsLast: Boolean;
//#UC START# *49955AD6022E_5506D56E02FB_var*
//#UC END# *49955AD6022E_5506D56E02FB_var*
begin
//#UC START# *49955AD6022E_5506D56E02FB_impl*
 Result := f_Last;
//#UC END# *49955AD6022E_5506D56E02FB_impl*
end;//TvcmHistory.IsLast

function TvcmHistory.pm_GetInBF: Boolean;
//#UC START# *49955AE20023_5506D56E02FBget_var*
//#UC END# *49955AE20023_5506D56E02FBget_var*
begin
//#UC START# *49955AE20023_5506D56E02FBget_impl*
 Result := f_InBF;
//#UC END# *49955AE20023_5506D56E02FBget_impl*
end;//TvcmHistory.pm_GetInBF

function TvcmHistory.pm_GetInProcess: Boolean;
//#UC START# *49955AF40024_5506D56E02FBget_var*
//#UC END# *49955AF40024_5506D56E02FBget_var*
begin
//#UC START# *49955AF40024_5506D56E02FBget_impl*
 Result := (f_Starts <> 0);
//#UC END# *49955AF40024_5506D56E02FBget_impl*
end;//TvcmHistory.pm_GetInProcess

function TvcmHistory.InBack: Boolean;
//#UC START# *49EDA518032B_5506D56E02FB_var*
//#UC END# *49EDA518032B_5506D56E02FB_var*
begin
//#UC START# *49EDA518032B_5506D56E02FB_impl*
 Result := f_InBack;
//#UC END# *49EDA518032B_5506D56E02FB_impl*
end;//TvcmHistory.InBack

procedure TvcmHistory.Clear(aHeedCheckCurrent: Boolean = true);
//#UC START# *4DB0239600EC_5506D56E02FB_var*
//#UC END# *4DB0239600EC_5506D56E02FB_var*
begin
//#UC START# *4DB0239600EC_5506D56E02FB_impl*
 Assert(not f_InBF);
 Assert({$IfDef nsTest}not aHeedCheckCurrent or {$EndIf}(f_Starts <= 0));
 f_Starts := 0;
 f_Current := 0;
 if (f_History <> nil) then
  f_History.Clear;
//#UC END# *4DB0239600EC_5506D56E02FB_impl*
end;//TvcmHistory.Clear

procedure TvcmHistory.DeleteBackItem;
//#UC START# *4E82C9D3005D_5506D56E02FB_var*
//#UC END# *4E82C9D3005D_5506D56E02FB_var*
begin
//#UC START# *4E82C9D3005D_5506D56E02FB_impl*
 Assert(not f_InBF);
 Assert(f_Starts <= 0);
 Assert(f_Current > 0);
 Assert(f_Current <= f_History.Count);
 Dec(f_Current);
 f_History.Delete(f_Current);
//#UC END# *4E82C9D3005D_5506D56E02FB_impl*
end;//TvcmHistory.DeleteBackItem

function TvcmHistory.GetBackCount: Integer;
//#UC START# *4FC4CF3F01DC_5506D56E02FB_var*
//#UC END# *4FC4CF3F01DC_5506D56E02FB_var*
begin
//#UC START# *4FC4CF3F01DC_5506D56E02FB_impl*
 Result := Max(f_Current, 0);
//#UC END# *4FC4CF3F01DC_5506D56E02FB_impl*
end;//TvcmHistory.GetBackCount

function TvcmHistory.GetForwardCount: Integer;
//#UC START# *4FC4CF570044_5506D56E02FB_var*
//#UC END# *4FC4CF570044_5506D56E02FB_var*
begin
//#UC START# *4FC4CF570044_5506D56E02FB_impl*
 Result := Max(f_History.Count - f_Current, 0);
//#UC END# *4FC4CF570044_5506D56E02FB_impl*
end;//TvcmHistory.GetForwardCount

function TvcmHistory.GetBackItem(anIndex: Integer): Il3CString;
//#UC START# *4FC4CF6B0145_5506D56E02FB_var*
//#UC END# *4FC4CF6B0145_5506D56E02FB_var*
begin
//#UC START# *4FC4CF6B0145_5506D56E02FB_impl*
 Result := GetCaption(GetBackCount - anIndex - 1);
//#UC END# *4FC4CF6B0145_5506D56E02FB_impl*
end;//TvcmHistory.GetBackItem

function TvcmHistory.GetForwardItem(anIndex: Integer): Il3CString;
//#UC START# *4FC4CF840110_5506D56E02FB_var*
//#UC END# *4FC4CF840110_5506D56E02FB_var*
begin
//#UC START# *4FC4CF840110_5506D56E02FB_impl*
 Result := GetCaption(GetBackCount + anIndex);
//#UC END# *4FC4CF840110_5506D56E02FB_impl*
end;//TvcmHistory.GetForwardItem

procedure TvcmHistory.DeleteForwardItem;
//#UC START# *53DE68ED020E_5506D56E02FB_var*
//#UC END# *53DE68ED020E_5506D56E02FB_var*
begin
//#UC START# *53DE68ED020E_5506D56E02FB_impl*
 Assert(not f_InBF);
 Assert(f_Starts <= 0);
 Assert(f_Current >= 0);
 Assert(f_Current < f_History.Count);
 f_History.Delete(f_Current);
//#UC END# *53DE68ED020E_5506D56E02FB_impl*
end;//TvcmHistory.DeleteForwardItem

function TvcmHistory.InternalSaveState(const aForm: IvcmEntityForm;
  aStateType: TvcmStateType;
  InDestroy: Boolean;
  aForceSave: Boolean = False): Boolean;
//#UC START# *5506D54601F8_5506D56E02FB_var*
var
 l_History: IvcmHistory;
//#UC END# *5506D54601F8_5506D56E02FB_var*
begin
//#UC START# *5506D54601F8_5506D56E02FB_impl*
 if (g_LockHistory > 0) then
  Result := False
 else
 if CheckAnother(aForm, l_History) then
  Result := (l_History as IvcmInternalHistory).InternalSaveState(aForm, aStateType, InDestroy)
 else
 begin
  if aForceSave or NeedSaveForm(aForm, InDestroy) then
  begin
   if InDestroy then
    Start(aForm);
   try
    Result := Add(TvcmHistoryItem.Make(aForm, aStateType, InDestroy, False));
   finally
    if InDestroy then
     Finish(aForm);
   end;//try..finally
  end//NeedSaveForm
  else
   Result := False;
 end;//CheckAnother(aForm, l_History)
//#UC END# *5506D54601F8_5506D56E02FB_impl*
end;//TvcmHistory.InternalSaveState

procedure TvcmHistory.ResetContainer;
//#UC START# *5583A8D20275_5506D56E02FB_var*
var
 l_Index: Integer;
 l_FormItem: IvcmFormHistoryItem;
//#UC END# *5583A8D20275_5506D56E02FB_var*
begin
//#UC START# *5583A8D20275_5506D56E02FB_impl*
 for l_Index := 0 to Pred(f_History.Count) do
 begin
  if Supports(f_History[l_Index], IvcmFormHistoryItem, l_FormItem) then
  try
   l_FormItem.ResetContainer;
  finally
   l_FormItem := nil;
  end;
 end;
//#UC END# *5583A8D20275_5506D56E02FB_impl*
end;//TvcmHistory.ResetContainer

function TvcmHistory.MakeState: IvcmHistoryState;
//#UC START# *558A5FAC01CC_5506D56E02FB_var*
//#UC END# *558A5FAC01CC_5506D56E02FB_var*
begin
//#UC START# *558A5FAC01CC_5506D56E02FB_impl*
 Result := TvcmHistoryState.Make(f_History, f_Current, f_ContainerItem);
//#UC END# *558A5FAC01CC_5506D56E02FB_impl*
end;//TvcmHistory.MakeState

procedure TvcmHistory.AssignState(const aState: IvcmHistoryState);
//#UC START# *558A5FD70198_5506D56E02FB_var*
//#UC END# *558A5FD70198_5506D56E02FB_var*
begin
//#UC START# *558A5FD70198_5506D56E02FB_impl*
 if (aState.Items <> nil) then
 begin
  if (f_History = nil) then
   f_History := TvcmHistoryItemList.Create;
  f_History.Assign(aState.Items);
 end;
 f_Current := aState.Current;
 f_ContainerItem := aState.ContainerItem;
//#UC END# *558A5FD70198_5506D56E02FB_impl*
end;//TvcmHistory.AssignState

procedure TvcmHistory.SaveClone(const aForm: IvcmEntityForm);
//#UC START# *559F70D00030_5506D56E02FB_var*
//#UC END# *559F70D00030_5506D56E02FB_var*
begin
//#UC START# *559F70D00030_5506D56E02FB_impl*
 f_SavingClone := True;
 try
  if not Assigned(aForm.FormSet) then
   InternalSaveState(aForm, vcm_stContent, True)
  else
  if aForm.IsMainInFormSet then
   if (g_LockBeforeFormDestroy = 0) then
    with aForm.FormSet do
    begin
     PopToHistory;
     SaveHistory;
    end;//if aForm.IsMainInFormSet then
 finally
  f_SavingClone := False;
 end;
//#UC END# *559F70D00030_5506D56E02FB_impl*
end;//TvcmHistory.SaveClone

procedure TvcmHistory.Cleanup;
//#UC START# *479731C50290_5506D56E02FB_var*
//#UC END# *479731C50290_5506D56E02FB_var*
begin
//#UC START# *479731C50290_5506D56E02FB_impl*
 f_ContainerItem := nil;
 f_MainForm := nil;
 f_Current := 0;
 FreeAndNil(f_History);
 FreeAndNil(f_Forms);
 inherited;
//#UC END# *479731C50290_5506D56E02FB_impl*
end;//TvcmHistory.Cleanup
// start class TvcmObjectWithDataHistoryItem

procedure TvcmObjectWithDataHistoryItem.DoActivate;
//#UC START# *5506DB9403A6_5506DB25003E_var*
var
 l_Temp: IvcmData;
//#UC END# *5506DB9403A6_5506DB25003E_var*
begin
//#UC START# *5506DB9403A6_5506DB25003E_impl*
 l_Temp := f_Object.DataForSave;
 f_Object.DataForSave := f_Data;
 f_Data := l_Temp;
//#UC END# *5506DB9403A6_5506DB25003E_impl*
end;//TvcmObjectWithDataHistoryItem.DoActivate

constructor TvcmObjectWithDataHistoryItem.Create(const aObject: IvcmObjectWithData;
  const aData: IvcmData);
//#UC START# *5506DBA30102_5506DB25003E_var*
//#UC END# *5506DBA30102_5506DB25003E_var*
begin
//#UC START# *5506DBA30102_5506DB25003E_impl*
 inherited Create;
 f_Object := aObject;
 f_Data := aData;
//#UC END# *5506DBA30102_5506DB25003E_impl*
end;//TvcmObjectWithDataHistoryItem.Create

class function TvcmObjectWithDataHistoryItem.Make(const aObject: IvcmObjectWithData;
  const aData: IvcmData): IvcmHistoryItem;
var
 l_Inst : TvcmObjectWithDataHistoryItem;
begin
 l_Inst := Create(aObject, aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmObjectWithDataHistoryItem.pm_GetCaption: IvcmCString;
//#UC START# *499559980178_5506DB25003Eget_var*
//#UC END# *499559980178_5506DB25003Eget_var*
begin
//#UC START# *499559980178_5506DB25003Eget_impl*
 Result := nil;
//#UC END# *499559980178_5506DB25003Eget_impl*
end;//TvcmObjectWithDataHistoryItem.pm_GetCaption

function TvcmObjectWithDataHistoryItem.Activate(const aMainForm: IvcmEntityForm): Boolean;
//#UC START# *550938E80131_5506DB25003E_var*
//#UC END# *550938E80131_5506DB25003E_var*
begin
//#UC START# *550938E80131_5506DB25003E_impl*
 Result := Activate(aMainForm, nil);
//#UC END# *550938E80131_5506DB25003E_impl*
end;//TvcmObjectWithDataHistoryItem.Activate

function TvcmObjectWithDataHistoryItem.Activate(const aMainForm: IvcmEntityForm;
  const anOwner: IvcmEntityForm): Boolean;
//#UC START# *5509390702F7_5506DB25003E_var*
//#UC END# *5509390702F7_5506DB25003E_var*
begin
//#UC START# *5509390702F7_5506DB25003E_impl*
 DoActivate;
 Result := True;
//#UC END# *5509390702F7_5506DB25003E_impl*
end;//TvcmObjectWithDataHistoryItem.Activate

function TvcmObjectWithDataHistoryItem.Drop: Boolean;
//#UC START# *5509391E0197_5506DB25003E_var*
//#UC END# *5509391E0197_5506DB25003E_var*
begin
//#UC START# *5509391E0197_5506DB25003E_impl*
 Result := False;
//#UC END# *5509391E0197_5506DB25003E_impl*
end;//TvcmObjectWithDataHistoryItem.Drop

function TvcmObjectWithDataHistoryItem.IsAcceptable: Boolean;
//#UC START# *550953A00312_5506DB25003E_var*
//#UC END# *550953A00312_5506DB25003E_var*
begin
//#UC START# *550953A00312_5506DB25003E_impl*
 Result := True;
//#UC END# *550953A00312_5506DB25003E_impl*
end;//TvcmObjectWithDataHistoryItem.IsAcceptable
type _Instance_R_ = TvcmFormHistoryItemList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

// start class TvcmFormHistoryItemList

function TvcmFormHistoryItemList.pm_GetCount: Integer;
//#UC START# *4BB08B8902F2_55C0A6F4039Eget_var*
//#UC END# *4BB08B8902F2_55C0A6F4039Eget_var*
begin
//#UC START# *4BB08B8902F2_55C0A6F4039Eget_impl*
 Result := inherited Count;
//#UC END# *4BB08B8902F2_55C0A6F4039Eget_impl*
end;//TvcmFormHistoryItemList.pm_GetCount
// start class TvcmHistoryState

constructor TvcmHistoryState.Create(const aItems: IvcmHistoryItems;
  aCurrent: Integer;
  const aContainerItem: IvcmContainerHistoryItem);
//#UC START# *558A5AC303BA_558A59F101DA_var*
//#UC END# *558A5AC303BA_558A59F101DA_var*
begin
//#UC START# *558A5AC303BA_558A59F101DA_impl*
 inherited Create;
 if (aItems <> nil) then
  f_Items := aItems.MakeClone;
 f_Current := aCurrent;
//#UC END# *558A5AC303BA_558A59F101DA_impl*
end;//TvcmHistoryState.Create

class function TvcmHistoryState.Make(const aItems: IvcmHistoryItems;
  aCurrent: Integer;
  const aContainerItem: IvcmContainerHistoryItem): IvcmHistoryState;
var
 l_Inst : TvcmHistoryState;
begin
 l_Inst := Create(aItems, aCurrent, aContainerItem);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TvcmHistoryState.pm_GetItems: IvcmHistoryItems;
//#UC START# *558A5A260359_558A59F101DAget_var*
//#UC END# *558A5A260359_558A59F101DAget_var*
begin
//#UC START# *558A5A260359_558A59F101DAget_impl*
 Result := f_Items;
//#UC END# *558A5A260359_558A59F101DAget_impl*
end;//TvcmHistoryState.pm_GetItems

function TvcmHistoryState.pm_GetCurrent: Integer;
//#UC START# *558D24FD013A_558A59F101DAget_var*
//#UC END# *558D24FD013A_558A59F101DAget_var*
begin
//#UC START# *558D24FD013A_558A59F101DAget_impl*
 Result := f_Current;
//#UC END# *558D24FD013A_558A59F101DAget_impl*
end;//TvcmHistoryState.pm_GetCurrent

function TvcmHistoryState.pm_GetContainerItem: IvcmContainerHistoryItem;
//#UC START# *55910DA003E1_558A59F101DAget_var*
//#UC END# *55910DA003E1_558A59F101DAget_var*
begin
//#UC START# *55910DA003E1_558A59F101DAget_impl*
 Result := f_ContainerItem;
//#UC END# *55910DA003E1_558A59F101DAget_impl*
end;//TvcmHistoryState.pm_GetContainerItem

procedure TvcmHistoryState.Cleanup;
//#UC START# *479731C50290_558A59F101DA_var*
//#UC END# *479731C50290_558A59F101DA_var*
begin
//#UC START# *479731C50290_558A59F101DA_impl*
 f_Items := nil;
 inherited;
//#UC END# *479731C50290_558A59F101DA_impl*
end;//TvcmHistoryState.Cleanup
{$IfEnd} //not NoVCM

end.