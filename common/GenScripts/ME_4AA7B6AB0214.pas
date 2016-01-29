unit vcmHistory;

interface

uses
 l3IntfUses
 , vcmInterfaces
 , vcmBaseTypes
 , vcmUserControls
 , vcmExternalInterfaces
 , l3Interfaces
 , vcmBase
 , vcmHistoryItemList
 , vcmIEntityFormPtrList
 , vcmHistoryFormNode
 , vcmEntityForm
 , l3IID
 , SysUtils
 , l3PureMixIns
 , l3ProtoDataContainer
 , l3ProtoObject
;

type
 IvcmFormHistoryItem = interface(IvcmHistoryItem)
  procedure ResetContainer;
 end;//IvcmFormHistoryItem
 
 IvcmInternalHistory = interface(IvcmHistory)
  function InternalSaveState(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType;
   InDestroy: Boolean;
   aForceSave: Boolean): Boolean;
 end;//IvcmInternalHistory
 
 TvcmHistory = class(TvcmCacheableBase, IvcmHistory, IvcmInternalHistory)
  function NeedSaveForm(const aForm: IvcmEntityForm;
   InDestroy: Boolean): Boolean;
   {* нужно ли сохран€ть заданную форму }
  function CheckAnother(const aForm: IvcmEntityForm;
   out theHistory: IvcmHistory): Boolean;
   {* провер€ет от этой ли формы истори€, и если не от этой, то возвращает правильную историю. }
  function GetCaption(anIndex: Integer): IvcmCString;
   {* возвращает название одного шага истории }
  procedure Create(const aMainForm: IvcmEntityForm);
  function Make(const aMainForm: IvcmEntityForm): IvcmHistory;
  procedure BeforeFormDestroy(const aForm: IvcmEntityForm);
  function ForceSaveState(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType): Boolean;
   {* сохранение без проверки необходимости сохранени€ формы }
  function SaveState(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType): Boolean; overload;
  procedure SaveClose(const aForm: IvcmEntityForm;
   const aFormID: TvcmFormID;
   aUserType: TvcmUserType;
   aZoneType: TvcmZoneType;
   aSubUserType: TvcmUserType);
   {* форма котора€ должна быть закрыта при переходе по истории }
  function HasInPreviousStep(const aFormClass: TvcmFormID;
   aUserType: TvcmUserType): Boolean;
  function Back(aTruncate: Boolean): Boolean; overload;
  function Forward: Boolean; overload;
  procedure Back(const aParams: IvcmExecuteParamsPrim;
   aTruncate: Boolean); overload;
  procedure Forward(const aParams: IvcmExecuteParamsPrim); overload;
  function CanBack: Boolean;
  function CanForward: Boolean;
  procedure GetBackStrings(const aParams: IvcmTestParamsPrim);
  procedure GetForwardStrings(const aParams: IvcmTestParamsPrim);
  procedure Start(const aSender: IvcmEntityForm;
   const aCaption: IvcmCString;
   aFormSet: Boolean);
  procedure Finish(const aSender: IvcmEntityForm);
  procedure AddForm(const aForm: IvcmEntityForm);
  procedure RemoveForm(const aForm: IvcmEntityForm);
  function Add(const anItem: IvcmHistoryItem): Boolean;
   {* добавл€ет запись в историю }
  function IsLast: Boolean;
  function InBF: Boolean;
   {* истори€ находитс€ в состо€нии перехода (Back/Forward) }
  function InProcess: Boolean;
   {* истори€ находитс€ в процессе сохранени€ (между сколбками Start-Finish) }
  function InBack: Boolean;
   {* Ќаходимс€ в процессе Back, если нет, то Forward }
  procedure Clear(aHeedCheckCurrent: Boolean);
   {* ќчищает историю }
  procedure DeleteBackItem;
   {* ”дал€ет один элемент из списка Back }
  function GetBackCount: Integer;
  function GetForwardCount: Integer;
  function GetBackItem(anIndex: Integer): Il3CString;
  function GetForwardItem(anIndex: Integer): Il3CString;
  procedure DeleteForwardItem;
   {* ”дал€ет один элемент из списка Forward }
  function InternalSaveState(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType;
   InDestroy: Boolean;
   aForceSave: Boolean): Boolean; overload;
  procedure ResetContainer;
  function MakeState: IvcmHistoryState;
  procedure AssignState(const aState: IvcmHistoryState);
  procedure SaveClone(const aForm: IvcmEntityForm);
 end;//TvcmHistory
 
 TvcmObjectWithDataHistoryItem = class(TvcmBase, IvcmHistoryItem)
  procedure DoActivate;
  procedure Create(const aObject: IvcmObjectWithData;
   const aData: IvcmData);
  procedure Make(const aObject: IvcmObjectWithData;
   const aData: IvcmData);
  function Caption: IvcmCString;
   {* название }
  function Activate(const aMainForm: IvcmEntityForm): Boolean; overload;
  function Activate(const aMainForm: IvcmEntityForm;
   const anOwner: IvcmEntityForm): Boolean; overload;
  function Drop: Boolean;
  function IsAcceptable: Boolean;
   {* можно ли активизировать элемент истории в текущих услови€х }
 end;//TvcmObjectWithDataHistoryItem
 
 EvcmFormWasClosedInSave = class(Exception)
 end;//EvcmFormWasClosedInSave
 
 IvcmFormHistoryItemList = interface
 end;//IvcmFormHistoryItemList
 
 TvcmFormHistoryItemList = class(Tl3ProtoDataContainer, IvcmFormHistoryItemList)
  function Count: Integer;
   {* „исло элементов. }
 end;//TvcmFormHistoryItemList
 
 TvcmHistoryState = class(Tl3ProtoObject, IvcmHistoryState)
  procedure Create(const aItems: IvcmHistoryItems;
   aCurrent: Integer;
   const aContainerItem: IvcmContainerHistoryItem);
  procedure Make(const aItems: IvcmHistoryItems;
   aCurrent: Integer;
   const aContainerItem: IvcmContainerHistoryItem);
  function Items: IvcmHistoryItems;
  function Current: Integer;
  function ContainerItem: IvcmContainerHistoryItem;
 end;//TvcmHistoryState
 
implementation

uses
 l3ImplUses
 , l3String
 , l3MinMax
 , Classes
 , Windows
 , Controls
 , Forms
 , vcmUtils
 , vcmAggregate
 , vcmBaseMenuManager
 , vcmTaskPanelInterfaces
 , vcmHistoryRes
 , afwFacade
 , l3Base
 , RTLConsts
;

type
 TvcmHistoryItemBase = class(TvcmCacheableBase, IvcmFormHistoryItem)
  function DoActivate(const aMainForm: IvcmEntityForm;
   const anOwner: IvcmEntityForm): Boolean;
  procedure UpdateContainer(const aForm: IvcmEntityForm);
  procedure UpdateOwner(const aForm: IvcmEntityForm);
  procedure UpdateAggregate(const aForm: IvcmEntityForm);
  procedure UpdateFormInfo(const aForm: IvcmEntityForm);
  procedure FreeContainer;
  procedure FreeOwner;
  procedure FreeAggregate;
  function Container(const aMainForm: IvcmEntityForm): IvcmContainer;
  function MakeForm(const aMainForm: IvcmEntityForm;
   const anOwner: IvcmEntityForm;
   const aDataSource: IvcmFormDataSource): IvcmEntityForm;
  procedure StoreFocused(const aForm: IvcmEntityForm);
  procedure RestoreFocused(const aForm: IvcmEntityForm);
  procedure Create(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType;
   const aFormId: TvcmFormID;
   aUserType: TvcmUserType;
   aZoneType: TvcmZoneType;
   aItemType: TvcmHistoryItemType;
   aSubUserType: TvcmUserType;
   aForClone: Boolean);
  procedure Make(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType;
   const aFormId: TvcmFormID;
   aUserType: TvcmUserType;
   aZoneType: TvcmZoneType;
   aItemType: TvcmHistoryItemType;
   aSubUserType: TvcmUserType;
   aForClone: Boolean); overload;
  function Make(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType): IvcmFormHistoryItem; overload;
  function Caption: IvcmCString;
   {* название }
  function FormClass: TvcmFormID;
  function UserType: TvcmUserType;
  function ItemType: TvcmHistoryItemType;
  function Activate(const aMainForm: IvcmEntityForm): Boolean; overload;
  function Activate(const aMainForm: IvcmEntityForm;
   const anOwner: IvcmEntityForm): Boolean; overload;
  function Drop: Boolean;
  function IsAcceptable: Boolean;
   {* можно ли активизировать элемент истории в текущих услови€х }
  procedure ResetContainer;
 end;//TvcmHistoryItemBase
 
 TvcmHistoryItemRec = class(TvcmHistoryItemBase)
  function MakeChild(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType): IvcmFormHistoryItem;
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
 
 TvcmContainerHistoryItem = class(TvcmHistoryItemList, IvcmContainerHistoryItem)
  procedure Create(const aCaption: IvcmCString);
  function DoActivate(const aMainForm: IvcmEntityForm;
   const anOwner: IvcmEntityForm): Boolean;
  function Make(const aCaption: IvcmCString): IvcmContainerHistoryItem;
  function Caption: IvcmCString;
   {* название }
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
   {* можно ли активизировать элемент истории в текущих услови€х }
 end;//TvcmContainerHistoryItem
 
 TvcmHistoryItemPrim = class(TvcmHistoryItemRec)
  function NeedCheckHasForm: Boolean;
  function DoActivate(const aMainForm: IvcmEntityForm;
   const anOwner: IvcmEntityForm): Boolean;
  function MakeChild(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType): IvcmFormHistoryItem;
 end;//TvcmHistoryItemPrim
 
 TvcmContainerFormSetHistoryItem = class(TvcmContainerHistoryItem)
 end;//TvcmContainerFormSetHistoryItem
 
 TvcmHistoryItem = class(TvcmHistoryItemRec)
  function Make(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType;
   InDestroy: Boolean;
   aForClone: Boolean): IvcmFormHistoryItem;
  function DoActivate(const aMainForm: IvcmEntityForm;
   const anOwner: IvcmEntityForm): Boolean;
  function MakeChild(const aForm: IvcmEntityForm;
   aStateType: TvcmStateType): IvcmFormHistoryItem;
 end;//TvcmHistoryItem
 
end.
