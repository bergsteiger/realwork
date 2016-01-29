unit vcmFormSetHistory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
 , vcmExternalInterfaces
 , vcmFormSetFormHistoryItemList
 , vcmFormSetFormItemList
 , vcmUserControls
 , vcmEntityForm
 , vcmBaseTypes
 , vcmFormSetHistoryStepList
 , l3TabbedContainersDispatcher
 , l3ProtoDataContainer
 , vcmFormSetHistoryItemList
 , vcmFormSetHistoryStepItemList
;

type
 TvcmBaseFormSetHistoryItem = class(Tl3ProtoObject, IvcmFormSetHistoryItem)
  procedure FillItems(const aFormSet: IvcmFormSet;
   const aContainer: IvcmContainer;
   aItems: TvcmFormSetFormHistoryItemList);
  function MakeItem(const aFormSet: IvcmFormSet;
   const aContainer: IvcmContainer;
   const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem;
  procedure Create(const aFormSet: IvcmFormSet;
   const aContainer: IvcmContainer;
   aForClone: Boolean);
  function DoMakeFormSet(const aContainer: IvcmContainer;
   out aFormSet: IvcmFormSet): Boolean;
  procedure LoadFormsState;
  procedure DoLoadFormState(const aForm: IvcmEntityForm;
   const aFormItem: IvcmFormSetFormHistoryItem);
  function Caption: IvcmCString;
  function ItemCount: Integer;
  function GetItem(aIndex: Integer): IvcmFormSetFormHistoryItem;
  function MakeFormSet(const aContainer: IvcmContainer;
   out aFormSet: IvcmFormSet;
   aNeedAssignHistory: Boolean): Boolean;
 end;//TvcmBaseFormSetHistoryItem
 
 TvcmFormSetHistoryItem = class(TvcmBaseFormSetHistoryItem)
  procedure Create(const aFormSet: IvcmFormSet;
   const aContainer: IvcmContainer;
   aForClone: Boolean);
  function Make(const aFormSet: IvcmFormSet;
   const aContainer: IvcmContainer;
   aForClone: Boolean): IvcmFormSetHistoryItem;
  function MakeItem(const aFormSet: IvcmFormSet;
   const aContainer: IvcmContainer;
   const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem;
  function DoMakeFormSet(const aContainer: IvcmContainer;
   out aFormSet: IvcmFormSet): Boolean;
 end;//TvcmFormSetHistoryItem
 
 TvcmHistoryFormCacheItem = object
 end;//TvcmHistoryFormCacheItem
 
 TvcmFormSetFormHistoryItem = class(Tl3ProtoObject, IvcmFormSetFormHistoryItem)
  procedure Create(const aForm: IvcmEntityForm);
  function Make(const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem;
  function ZoneType: TvcmZoneType;
  function UserType: TvcmUserType;
  function SubUserType: TvcmUserType;
  function DataSource: IvcmFormDataSource;
  function FormData: IvcmBase;
  function MakeForm(const aContainer: IvcmContainer;
   const aFormSet: IvcmFormSet;
   const aAggregate: IvcmAggregate;
   out aForm: IvcmEntityForm): Boolean;
  function FormID: TvcmFormID;
  function GUID: TGUID;
  function ContainerGUID: TGUID;
 end;//TvcmFormSetFormHistoryItem
 
 TvcmFormSetHistory = class(Tl3ProtoObject, IvcmFormSetHistory)
  procedure Create;
  function Make: IvcmFormSetHistory;
  procedure SaveFormSet(const aFormSet: IvcmFormSet);
  function CloneContainer(const aContainer: IvcmContainer;
   const aContainerMaker: IvcmContainerMaker): IvcmContainer;
  procedure SaveForms(const aContainer: IvcmContainer);
  function GetFormset(const aContainer: IvcmContainer;
   out aFormSet: IvcmFormSet): Boolean;
  procedure StartOp(const aContainer: IvcmContainer);
  procedure EndOp(const aContainer: IvcmContainer);
  function MakeStepItems(const aContainer: IvcmContainer;
   aForClone: Boolean): IvcmFormSetHistoryStepItems;
  function HasAnyFormSet(const aContainer: IvcmContainer): Boolean;
  function HasNonFormsetForms(const aContainer: IvcmContainer): Boolean;
  function IsInFormset(const aForm: IvcmEntityForm): Boolean;
  function MakeStep(const aContainer: IvcmContainer;
   aForClone: Boolean): IvcmFormSetHistoryStep;
  procedure Back(const aContainer: IvcmContainer);
  function ItemCount: Integer;
  procedure CloneTab(const aTab: Il3FormTab);
  procedure SaveTab(const aTab: Il3FormTab);
  function CanBack: Boolean;
  function InBF: Boolean;
  function IsContainerInOp(const aContainer: IvcmContainer): Boolean;
 end;//TvcmFormSetHistory
 
 TvcmHistoryFormCache = class(Tl3ProtoDataContainer)
  function FindForm(const aGUID: TGUID): IvcmEntityForm;
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TvcmHistoryFormCache
 
 TvcmLegacyFormSetHistoryItem = class(TvcmBaseFormSetHistoryItem)
  procedure Create(const aContainer: IvcmContainer;
   aForClone: Boolean);
  function Make(const aContainer: IvcmContainer;
   aForClone: Boolean): IvcmFormSetHistoryItem;
  function GetFormContainer(const aItem: IvcmFormSetFormHistoryItem): IvcmContainer;
  function NeedMakeForm(const anItem: IvcmFormSetFormHistoryItem;
   const aContainer: IvcmContainer): Boolean;
  function MakeItem(const aFormSet: IvcmFormSet;
   const aContainer: IvcmContainer;
   const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem;
  function DoMakeFormSet(const aContainer: IvcmContainer;
   out aFormSet: IvcmFormSet): Boolean;
 end;//TvcmLegacyFormSetHistoryItem
 
 PvcmHistoryFormCacheItem = ^TvcmHistoryFormCacheItem;
 
 TvcmBaseFormSetHistoryStepItem = class(Tl3ProtoObject, IvcmFormSetHistoryStepItem)
  procedure Create(const aContainer: IvcmContainer;
   aForClone: Boolean);
  function Make(const aContainer: IvcmContainer;
   aForClone: Boolean): IvcmFormSetHistoryStepItem;
  procedure FillItems(const aContainer: IvcmContainer;
   aForClone: Boolean);
  procedure Restore(const aContainer: IvcmContainer;
   const aFormSetToClone: IvcmFormSet;
   aNeedAssignHistory: Boolean);
 end;//TvcmBaseFormSetHistoryStepItem
 
 TvcmFormSetHistoryItemStep = class(TvcmBaseFormSetHistoryStepItem)
 end;//TvcmFormSetHistoryItemStep
 
 TvcmLegacyFormSetHistoryItemStep = class(TvcmBaseFormSetHistoryStepItem)
 end;//TvcmLegacyFormSetHistoryItemStep
 
 TvcmFormSetHistoryStepItems = class(Tl3ProtoObject, IvcmFormSetHistoryStepItems)
  procedure Create;
  function Make: IvcmFormSetHistoryStepItems;
  function Next: Boolean;
  function Current: IvcmFormSetHistoryStepItem;
  procedure Add(const anItem: IvcmFormSetHistoryStepItem);
  procedure Reset;
 end;//TvcmFormSetHistoryStepItems
 
 TvcmFormSetHistoryStep = class(Tl3ProtoObject, IvcmFormSetHistoryStep)
  procedure Create(const aSteps: IvcmFormSetHistoryStepItems);
  function Make(const aSteps: IvcmFormSetHistoryStepItems): IvcmFormSetHistoryStep;
  function Next: Boolean;
  function Current: IvcmFormSetHistoryStepItem;
  procedure Add(const anItem: IvcmFormSetHistoryStepItem);
  procedure Restore(const aContainer: IvcmContainer;
   const aFormSetToClone: IvcmFormSet;
   aNeedAssignHistory: Boolean);
  procedure Reset;
 end;//TvcmFormSetHistoryStep
 
implementation

uses
 l3ImplUses
 , SysUtils
 , Classes
 , Controls
 , vcmIEntityFormList
 , l3InterfacesMisc
 , vcmFormSetContainerRegistry
 , vcmAggregate
 , vcmBase
 , vcmTabbedContainerFormDispatcher
 , Forms
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
