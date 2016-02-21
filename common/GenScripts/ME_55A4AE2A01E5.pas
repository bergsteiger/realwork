unit vcmFormSetHistory;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\ChromeLike\vcmFormSetHistory.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
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
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , vcmFormSetHistoryItemList
 , vcmFormSetHistoryStepItemList
;

type
 PvcmHistoryFormCacheItem = ^TvcmHistoryFormCacheItem;

 TvcmBaseFormSetHistoryItem = class(Tl3ProtoObject, IvcmFormSetHistoryItem)
  private
   f_Caption: IvcmCString;
   f_Items: TvcmFormSetFormHistoryItemList;
   f_ContainedFormHistoryState: IvcmHistoryState;
   f_ContainerData: IvcmBase;
  private
   procedure LoadFormsState;
  protected
   procedure FillItems(const aFormSet: IvcmFormSet;
    const aContainer: IvcmContainer;
    aItems: TvcmFormSetFormHistoryItemList); virtual;
   function MakeItem(const aFormSet: IvcmFormSet;
    const aContainer: IvcmContainer;
    const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem; virtual; abstract;
   function DoMakeFormSet(const aContainer: IvcmContainer;
    out aFormSet: IvcmFormSet): Boolean; virtual; abstract;
   procedure DoLoadFormState(const aForm: IvcmEntityForm;
    const aFormItem: IvcmFormSetFormHistoryItem); virtual;
   function pm_GetCaption: IvcmCString;
   function pm_GetItemCount: Integer;
   function GetItem(aIndex: Integer): IvcmFormSetFormHistoryItem;
   function MakeFormSet(const aContainer: IvcmContainer;
    out aFormSet: IvcmFormSet;
    aNeedAssignHistory: Boolean): Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aFormSet: IvcmFormSet;
    const aContainer: IvcmContainer;
    aForClone: Boolean); reintroduce;
 end;//TvcmBaseFormSetHistoryItem

 TvcmFormSetHistoryItem = class(TvcmBaseFormSetHistoryItem)
  private
   f_Factory: IvcmFormSetSimpleFactory;
   f_DataSource: IvcmFormSetDataSource;
   f_FormList: TvcmFormSetFormList;
   f_FormSetToClone: IvcmFormSet;
  protected
   function MakeItem(const aFormSet: IvcmFormSet;
    const aContainer: IvcmContainer;
    const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem; override;
   function DoMakeFormSet(const aContainer: IvcmContainer;
    out aFormSet: IvcmFormSet): Boolean; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FillItems(const aFormSet: IvcmFormSet;
    const aContainer: IvcmContainer;
    aItems: TvcmFormSetFormHistoryItemList); override;
  public
   constructor Create(const aFormSet: IvcmFormSet;
    const aContainer: IvcmContainer;
    aForClone: Boolean); reintroduce;
   class function Make(const aFormSet: IvcmFormSet;
    const aContainer: IvcmContainer;
    aForClone: Boolean): IvcmFormSetHistoryItem; reintroduce;
 end;//TvcmFormSetHistoryItem

 TvcmHistoryFormCacheItem = object
  public
   rForm: IvcmEntityForm;
   rGUID: TGUID;
  public
   function EQ(const aAnother: TvcmHistoryFormCacheItem): Boolean;
 end;//TvcmHistoryFormCacheItem

 TvcmFormSetFormHistoryItem = class(Tl3ProtoObject, IvcmFormSetFormHistoryItem)
  private
   f_ZoneType: TvcmZoneType;
   f_UserType: TvcmUserType;
   f_SubUserType: TvcmUserType;
   f_DataSource: IvcmFormDataSource;
   f_FormData: IvcmBase;
   f_FormClass: RvcmEntityForm;
   f_FormID: TvcmFormID;
   f_GUID: TGUID;
   f_ContainerGUID: TGUID;
  protected
   function pm_GetZoneType: TvcmZoneType;
   function pm_GetUserType: TvcmUserType;
   function pm_GetSubUserType: TvcmUserType;
   function pm_GetDataSource: IvcmFormDataSource;
   function pm_GetFormData: IvcmBase;
   function MakeForm(const aContainer: IvcmContainer;
    const aFormSet: IvcmFormSet;
    const aAggregate: IvcmAggregate;
    out aForm: IvcmEntityForm): Boolean;
   function pm_GetFormID: TvcmFormID;
   function pm_GetGUID: TGUID;
   function pm_GetContainerGUID: TGUID;
  public
   constructor Create(const aForm: IvcmEntityForm); reintroduce;
   class function Make(const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem; reintroduce;
 end;//TvcmFormSetFormHistoryItem

 TvcmFormSetHistory = class(Tl3ProtoObject, IvcmFormSetHistory)
  private
   f_Items: TvcmFormSetHistoryStepList;
   f_InBF: Boolean;
   f_ContainerInOp: Pointer;
  private
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
  protected
   procedure Back(const aContainer: IvcmContainer);
   function pm_GetItemCount: Integer;
   procedure CloneTab(const aTab: Il3FormTab);
   procedure SaveTab(const aTab: Il3FormTab);
   function CanBack: Boolean;
   function pm_GetInBF: Boolean;
   function IsContainerInOp(const aContainer: IvcmContainer): Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Make: IvcmFormSetHistory; reintroduce;
 end;//TvcmFormSetHistory

 _ItemType_ = TvcmHistoryFormCacheItem;
 _l3RecordWithEQList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}
 TvcmHistoryFormCache = class(_l3RecordWithEQList_)
  public
   function FindForm(const aGUID: TGUID): IvcmEntityForm;
 end;//TvcmHistoryFormCache

 TvcmLegacyFormSetHistoryItem = class(TvcmBaseFormSetHistoryItem)
  private
   f_FormCache: TvcmHistoryFormCache;
   f_ActiveFormStored: Boolean;
   f_ActiveFormID: TvcmFormID;
   f_ActiveFormUserType: TvcmUserType;
   f_ActiveFormSubUserType: TvcmUserType;
   f_ActiveFormZoneType: TvcmZoneType;
  private
   function GetFormContainer(const aItem: IvcmFormSetFormHistoryItem): IvcmContainer;
   function NeedMakeForm(const anItem: IvcmFormSetFormHistoryItem;
    const aContainer: IvcmContainer): Boolean;
  protected
   function MakeItem(const aFormSet: IvcmFormSet;
    const aContainer: IvcmContainer;
    const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem; override;
   function DoMakeFormSet(const aContainer: IvcmContainer;
    out aFormSet: IvcmFormSet): Boolean; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FillItems(const aFormSet: IvcmFormSet;
    const aContainer: IvcmContainer;
    aItems: TvcmFormSetFormHistoryItemList); override;
  public
   constructor Create(const aContainer: IvcmContainer;
    aForClone: Boolean); reintroduce;
   class function Make(const aContainer: IvcmContainer;
    aForClone: Boolean): IvcmFormSetHistoryItem; reintroduce;
 end;//TvcmLegacyFormSetHistoryItem

 TvcmBaseFormSetHistoryStepItem = class(Tl3ProtoObject, IvcmFormSetHistoryStepItem)
  private
   f_FormSetItems: TvcmFormSetHistoryItemList;
   f_TabParams: Il3TabParams;
  protected
   procedure FillItems(const aContainer: IvcmContainer;
    aForClone: Boolean); virtual;
   procedure Restore(const aContainer: IvcmContainer;
    const aFormSetToClone: IvcmFormSet;
    aNeedAssignHistory: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aContainer: IvcmContainer;
    aForClone: Boolean); reintroduce;
   class function Make(const aContainer: IvcmContainer;
    aForClone: Boolean): IvcmFormSetHistoryStepItem; reintroduce;
 end;//TvcmBaseFormSetHistoryStepItem

 TvcmFormSetHistoryItemStep = class(TvcmBaseFormSetHistoryStepItem)
  protected
   procedure FillItems(const aContainer: IvcmContainer;
    aForClone: Boolean); override;
 end;//TvcmFormSetHistoryItemStep

 TvcmLegacyFormSetHistoryItemStep = class(TvcmBaseFormSetHistoryStepItem)
  protected
   procedure FillItems(const aContainer: IvcmContainer;
    aForClone: Boolean); override;
 end;//TvcmLegacyFormSetHistoryItemStep

 TvcmFormSetHistoryStepItems = class(Tl3ProtoObject, IvcmFormSetHistoryStepItems)
  private
   f_Steps: TvcmFormSetHistoryStepItemList;
   f_CurrentIndex: Integer;
  protected
   function pm_GetNext: Boolean;
   function Get_Current: IvcmFormSetHistoryStepItem;
   procedure Add(const anItem: IvcmFormSetHistoryStepItem);
   procedure Reset;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Make: IvcmFormSetHistoryStepItems; reintroduce;
 end;//TvcmFormSetHistoryStepItems

 TvcmFormSetHistoryStep = class(Tl3ProtoObject, IvcmFormSetHistoryStep)
  private
   f_Steps: IvcmFormSetHistoryStepItems;
  protected
   function pm_GetNext: Boolean;
   function Get_Current: IvcmFormSetHistoryStepItem;
   procedure Add(const anItem: IvcmFormSetHistoryStepItem);
   procedure Restore(const aContainer: IvcmContainer;
    const aFormSetToClone: IvcmFormSet;
    aNeedAssignHistory: Boolean);
   procedure Reset;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aSteps: IvcmFormSetHistoryStepItems); reintroduce;
   class function Make(const aSteps: IvcmFormSetHistoryStepItems): IvcmFormSetHistoryStep; reintroduce;
 end;//TvcmFormSetHistoryStep

function TvcmHistoryFormCacheItem_C(const aForm: IvcmEntityForm;
 const aGUID: TGUID): TvcmHistoryFormCacheItem;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmIEntityFormList
 , l3InterfacesMisc
 , vcmFormSetContainerRegistry
 , vcmAggregate
 , vcmBase
 , vcmTabbedContainerFormDispatcher
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Base
 , l3MinMax
 , RTLConsts
;

function TvcmHistoryFormCacheItem_C(const aForm: IvcmEntityForm;
 const aGUID: TGUID): TvcmHistoryFormCacheItem;
//#UC START# *55C8648A0397_55C86432033A_var*
//#UC END# *55C8648A0397_55C86432033A_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *55C8648A0397_55C86432033A_impl*
 Result.rGUID := aGUID;
 Result.rForm := aForm;
//#UC END# *55C8648A0397_55C86432033A_impl*
end;//TvcmHistoryFormCacheItem_C

procedure TvcmBaseFormSetHistoryItem.FillItems(const aFormSet: IvcmFormSet;
 const aContainer: IvcmContainer;
 aItems: TvcmFormSetFormHistoryItemList);
//#UC START# *55A4BB09012B_55A4AE43002D_var*
//#UC END# *55A4BB09012B_55A4AE43002D_var*
begin
//#UC START# *55A4BB09012B_55A4AE43002D_impl*
 Assert(False);
//#UC END# *55A4BB09012B_55A4AE43002D_impl*
end;//TvcmBaseFormSetHistoryItem.FillItems

constructor TvcmBaseFormSetHistoryItem.Create(const aFormSet: IvcmFormSet;
 const aContainer: IvcmContainer;
 aForClone: Boolean);
//#UC START# *55A4BBCC00E5_55A4AE43002D_var*
var
 l_ContainedForm: IvcmContainedForm;
//#UC END# *55A4BBCC00E5_55A4AE43002D_var*
begin
//#UC START# *55A4BBCC00E5_55A4AE43002D_impl*
 inherited Create;
 f_Items := TvcmFormSetFormHistoryItemList.Create;
 FillItems(aFormSet, aContainer, f_Items);
 if Supports(aContainer, IvcmContainedForm, l_ContainedForm) then
 try
  f_ContainedFormHistoryState := l_ContainedForm.ContainedFormHistory.MakeState;
 finally
  l_ContainedForm := nil;
 end;
//#UC END# *55A4BBCC00E5_55A4AE43002D_impl*
end;//TvcmBaseFormSetHistoryItem.Create

procedure TvcmBaseFormSetHistoryItem.LoadFormsState;
//#UC START# *55C9B6EF01AE_55A4AE43002D_var*
//#UC END# *55C9B6EF01AE_55A4AE43002D_var*
begin
//#UC START# *55C9B6EF01AE_55A4AE43002D_impl*
 Assert(False);
//#UC END# *55C9B6EF01AE_55A4AE43002D_impl*
end;//TvcmBaseFormSetHistoryItem.LoadFormsState

procedure TvcmBaseFormSetHistoryItem.DoLoadFormState(const aForm: IvcmEntityForm;
 const aFormItem: IvcmFormSetFormHistoryItem);
//#UC START# *55C9B70700FF_55A4AE43002D_var*
//#UC END# *55C9B70700FF_55A4AE43002D_var*
begin
//#UC START# *55C9B70700FF_55A4AE43002D_impl*
 aForm.LoadCloneState(aFormItem.FormData, vcm_stContent);
//#UC END# *55C9B70700FF_55A4AE43002D_impl*
end;//TvcmBaseFormSetHistoryItem.DoLoadFormState

function TvcmBaseFormSetHistoryItem.pm_GetCaption: IvcmCString;
//#UC START# *55A4A49C012A_55A4AE43002Dget_var*
//#UC END# *55A4A49C012A_55A4AE43002Dget_var*
begin
//#UC START# *55A4A49C012A_55A4AE43002Dget_impl*
 Result := f_Caption;
//#UC END# *55A4A49C012A_55A4AE43002Dget_impl*
end;//TvcmBaseFormSetHistoryItem.pm_GetCaption

function TvcmBaseFormSetHistoryItem.pm_GetItemCount: Integer;
//#UC START# *55A4A4AD015C_55A4AE43002Dget_var*
//#UC END# *55A4A4AD015C_55A4AE43002Dget_var*
begin
//#UC START# *55A4A4AD015C_55A4AE43002Dget_impl*
 Result := f_Items.Count;
//#UC END# *55A4A4AD015C_55A4AE43002Dget_impl*
end;//TvcmBaseFormSetHistoryItem.pm_GetItemCount

function TvcmBaseFormSetHistoryItem.GetItem(aIndex: Integer): IvcmFormSetFormHistoryItem;
//#UC START# *55A4A4EE00A7_55A4AE43002D_var*
//#UC END# *55A4A4EE00A7_55A4AE43002D_var*
begin
//#UC START# *55A4A4EE00A7_55A4AE43002D_impl*
 Result := f_Items[aIndex];
//#UC END# *55A4A4EE00A7_55A4AE43002D_impl*
end;//TvcmBaseFormSetHistoryItem.GetItem

function TvcmBaseFormSetHistoryItem.MakeFormSet(const aContainer: IvcmContainer;
 out aFormSet: IvcmFormSet;
 aNeedAssignHistory: Boolean): Boolean;
//#UC START# *55A4A5A90145_55A4AE43002D_var*
var
 l_ContainedForm: IvcmContainedForm;
//#UC END# *55A4A5A90145_55A4AE43002D_var*
begin
//#UC START# *55A4A5A90145_55A4AE43002D_impl*
 Result := DoMakeFormset(aContainer, aFormSet);
 if aNeedAssignHistory and
   Supports(aContainer, IvcmContainedForm, l_ContainedForm) then
 try
  l_ContainedForm.ContainedFormHistory.AssignState(f_ContainedFormHistoryState);
 finally
  l_ContainedForm := nil;
 end;//try..finally
//#UC END# *55A4A5A90145_55A4AE43002D_impl*
end;//TvcmBaseFormSetHistoryItem.MakeFormSet

procedure TvcmBaseFormSetHistoryItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55A4AE43002D_var*
//#UC END# *479731C50290_55A4AE43002D_var*
begin
//#UC START# *479731C50290_55A4AE43002D_impl*
 f_Caption := nil;
 f_ContainedFormHistoryState := nil;
 FreeAndNil(f_Items);
 inherited;
//#UC END# *479731C50290_55A4AE43002D_impl*
end;//TvcmBaseFormSetHistoryItem.Cleanup

constructor TvcmFormSetHistoryItem.Create(const aFormSet: IvcmFormSet;
 const aContainer: IvcmContainer;
 aForClone: Boolean);
//#UC START# *55A4BC700145_55A4BC100361_var*
//#UC END# *55A4BC700145_55A4BC100361_var*
begin
//#UC START# *55A4BC700145_55A4BC100361_impl*
 inherited;
 f_FormList := TvcmFormSetFormList.Create;
 if aForClone then
  f_FormSetToClone := aFormSet;
 aFormSet.SaveFormList(f_FormList);
 if (f_FormSetToClone <> nil) then
 begin
  f_DataSource := aFormSet.DataSource.MakeClone;
  f_DataSource.FormSet := nil;
 end
 else
  f_DataSource := aFormSet.DataSource;
 f_Factory := aFormSet.Factory.GetSimpleFactory;
 f_DataSource.PopToHistory; 
//#UC END# *55A4BC700145_55A4BC100361_impl*
end;//TvcmFormSetHistoryItem.Create

class function TvcmFormSetHistoryItem.Make(const aFormSet: IvcmFormSet;
 const aContainer: IvcmContainer;
 aForClone: Boolean): IvcmFormSetHistoryItem;
var
 l_Inst : TvcmFormSetHistoryItem;
begin
 l_Inst := Create(aFormSet, aContainer, aForClone);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmFormSetHistoryItem.Make

function TvcmFormSetHistoryItem.MakeItem(const aFormSet: IvcmFormSet;
 const aContainer: IvcmContainer;
 const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem;
//#UC START# *55A4BB850020_55A4BC100361_var*
//#UC END# *55A4BB850020_55A4BC100361_var*
begin
//#UC START# *55A4BB850020_55A4BC100361_impl*
 Result := TvcmFormSetFormHistoryItem.Make(aForm);
//#UC END# *55A4BB850020_55A4BC100361_impl*
end;//TvcmFormSetHistoryItem.MakeItem

function TvcmFormSetHistoryItem.DoMakeFormSet(const aContainer: IvcmContainer;
 out aFormSet: IvcmFormSet): Boolean;
//#UC START# *55A4C21A006B_55A4BC100361_var*

 function lp_GetFormItem(const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem;
 var
  l_Index: Integer;
  l_Item: IvcmFormSetFormHistoryItem;
 begin
  Result := nil;
  for l_Index := 0 to Pred(f_Items.Count) do
  begin
    l_Item := f_Items[l_Index];
    if (aForm.SameName(l_Item.FormID)) and
       (l_Item.ZoneType = aForm.ZoneType) and
       (l_Item.UserType = aForm.UserType) and
       (l_Item.SubUserType = aForm.SubUserType) then
    begin
     Result := l_Item;
     Break;
    end;
  end;
 end;

var
 l_Index: Integer;
 l_Form: IvcmEntityForm;
 l_FormItem: IvcmFormSetFormHistoryItem;
//#UC END# *55A4C21A006B_55A4BC100361_var*
begin
//#UC START# *55A4C21A006B_55A4BC100361_impl*
 f_DataSource.PushFromHistory;
 aFormSet := f_Factory.MakeFormSet(f_DataSource, aContainer, False, False, f_FormSetToClone);

// aFormSet.AssignFormList(f_FormList);
// aFormSet.Refresh(nil);

 for l_Index := 0 to Pred(aFormSet.EntitiesCount) do
 begin
  l_Form := aFormSet.Entity[l_Index].AsForm;
  l_FormItem := lp_GetFormItem(l_Form);
  if (l_FormItem <> nil) and
     (l_Formitem.FormData <> nil) then
    DoLoadFormState(l_Form, l_FormItem);
 end;
//#UC END# *55A4C21A006B_55A4BC100361_impl*
end;//TvcmFormSetHistoryItem.DoMakeFormSet

procedure TvcmFormSetHistoryItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55A4BC100361_var*
//#UC END# *479731C50290_55A4BC100361_var*
begin
//#UC START# *479731C50290_55A4BC100361_impl*
 FreeAndNil(f_FormList);
 inherited;
//#UC END# *479731C50290_55A4BC100361_impl*
end;//TvcmFormSetHistoryItem.Cleanup

procedure TvcmFormSetHistoryItem.FillItems(const aFormSet: IvcmFormSet;
 const aContainer: IvcmContainer;
 aItems: TvcmFormSetFormHistoryItemList);
//#UC START# *55A4BB09012B_55A4BC100361_var*
var
 l_Index: Integer;
 l_Entity: IvcmEntity;
 l_Form: IvcmEntityForm;
//#UC END# *55A4BB09012B_55A4BC100361_var*
begin
//#UC START# *55A4BB09012B_55A4BC100361_impl*
 for l_Index := 0 to Pred(aFormSet.EntitiesCount) do
 begin
  if Supports(aFormSet.Entity[l_Index], IvcmEntityForm, l_Form) then
  try
   f_Items.Add(MakeItem(aFormSet, aContainer, l_Form));
  finally
   l_Form := nil;
  end;
 end;
//#UC END# *55A4BB09012B_55A4BC100361_impl*
end;//TvcmFormSetHistoryItem.FillItems

function TvcmHistoryFormCacheItem.EQ(const aAnother: TvcmHistoryFormCacheItem): Boolean;
//#UC START# *55C86479026B_55C86432033A_var*
//#UC END# *55C86479026B_55C86432033A_var*
begin
//#UC START# *55C86479026B_55C86432033A_impl*
 Result := l3IEQ(aAnother.rForm, rForm) and
           IsEqualGUID(aAnother.rGUID, rGUID);
//#UC END# *55C86479026B_55C86432033A_impl*
end;//TvcmHistoryFormCacheItem.EQ

constructor TvcmFormSetFormHistoryItem.Create(const aForm: IvcmEntityForm);
//#UC START# *55A4E8DA034B_55A4C8F4024D_var*
//#UC END# *55A4E8DA034B_55A4C8F4024D_var*
begin
//#UC START# *55A4E8DA034B_55A4C8F4024D_impl*
 inherited Create;
 f_ZoneType := aForm.ZoneType;
 f_UserType := aForm.UserType;
 f_SubUserType := aForm.SubUserType;
 f_DataSource := aForm.DataSource;
 f_FormClass := RvcmEntityForm((aForm.VCLWinControl as TvcmEntityForm).ClassType);
 f_FormID := TvcmEntityForm(aForm.VCLWinControl).FormID;
 f_FormData := nil;
 f_GUID := aForm.GUID;
 f_ContainerGUID := aForm.Container.AsForm.GUID;
 aForm.SaveStateForClone(f_FormData, vcm_stContent);
//#UC END# *55A4E8DA034B_55A4C8F4024D_impl*
end;//TvcmFormSetFormHistoryItem.Create

class function TvcmFormSetFormHistoryItem.Make(const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem;
var
 l_Inst : TvcmFormSetFormHistoryItem;
begin
 l_Inst := Create(aForm);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmFormSetFormHistoryItem.Make

function TvcmFormSetFormHistoryItem.pm_GetZoneType: TvcmZoneType;
//#UC START# *55A4A5290317_55A4C8F4024Dget_var*
//#UC END# *55A4A5290317_55A4C8F4024Dget_var*
begin
//#UC START# *55A4A5290317_55A4C8F4024Dget_impl*
 Result := f_ZoneType;
//#UC END# *55A4A5290317_55A4C8F4024Dget_impl*
end;//TvcmFormSetFormHistoryItem.pm_GetZoneType

function TvcmFormSetFormHistoryItem.pm_GetUserType: TvcmUserType;
//#UC START# *55A4A54302B1_55A4C8F4024Dget_var*
//#UC END# *55A4A54302B1_55A4C8F4024Dget_var*
begin
//#UC START# *55A4A54302B1_55A4C8F4024Dget_impl*
 Result := f_UserType;
//#UC END# *55A4A54302B1_55A4C8F4024Dget_impl*
end;//TvcmFormSetFormHistoryItem.pm_GetUserType

function TvcmFormSetFormHistoryItem.pm_GetSubUserType: TvcmUserType;
//#UC START# *55A4A5500345_55A4C8F4024Dget_var*
//#UC END# *55A4A5500345_55A4C8F4024Dget_var*
begin
//#UC START# *55A4A5500345_55A4C8F4024Dget_impl*
 Result := f_SubUserType;
//#UC END# *55A4A5500345_55A4C8F4024Dget_impl*
end;//TvcmFormSetFormHistoryItem.pm_GetSubUserType

function TvcmFormSetFormHistoryItem.pm_GetDataSource: IvcmFormDataSource;
//#UC START# *55A4A56A02DF_55A4C8F4024Dget_var*
//#UC END# *55A4A56A02DF_55A4C8F4024Dget_var*
begin
//#UC START# *55A4A56A02DF_55A4C8F4024Dget_impl*
 Result := f_DataSource;
//#UC END# *55A4A56A02DF_55A4C8F4024Dget_impl*
end;//TvcmFormSetFormHistoryItem.pm_GetDataSource

function TvcmFormSetFormHistoryItem.pm_GetFormData: IvcmBase;
//#UC START# *55A4A59101C1_55A4C8F4024Dget_var*
//#UC END# *55A4A59101C1_55A4C8F4024Dget_var*
begin
//#UC START# *55A4A59101C1_55A4C8F4024Dget_impl*
 Result := f_FormData;
//#UC END# *55A4A59101C1_55A4C8F4024Dget_impl*
end;//TvcmFormSetFormHistoryItem.pm_GetFormData

function TvcmFormSetFormHistoryItem.MakeForm(const aContainer: IvcmContainer;
 const aFormSet: IvcmFormSet;
 const aAggregate: IvcmAggregate;
 out aForm: IvcmEntityForm): Boolean;
//#UC START# *55A4A5F30313_55A4C8F4024D_var*
var
 l_GUID: TGUID;
 l_Params: IvcmMakeParams;
//#UC END# *55A4A5F30313_55A4C8F4024D_var*
begin
//#UC START# *55A4A5F30313_55A4C8F4024D_impl*
 l_Params := vcmMakeParams(aAggregate, aContainer, nil);
 aForm := f_FormClass.MakeSingleChild(aContainer, l_Params, f_ZoneType,
  f_UserType, nil, f_DataSource, f_SubUserType);
 Result := (aForm <> nil);
//#UC END# *55A4A5F30313_55A4C8F4024D_impl*
end;//TvcmFormSetFormHistoryItem.MakeForm

function TvcmFormSetFormHistoryItem.pm_GetFormID: TvcmFormID;
//#UC START# *55B8B56C0352_55A4C8F4024Dget_var*
//#UC END# *55B8B56C0352_55A4C8F4024Dget_var*
begin
//#UC START# *55B8B56C0352_55A4C8F4024Dget_impl*
 Result := f_FormID;
//#UC END# *55B8B56C0352_55A4C8F4024Dget_impl*
end;//TvcmFormSetFormHistoryItem.pm_GetFormID

function TvcmFormSetFormHistoryItem.pm_GetGUID: TGUID;
//#UC START# *55C486E400A6_55A4C8F4024Dget_var*
//#UC END# *55C486E400A6_55A4C8F4024Dget_var*
begin
//#UC START# *55C486E400A6_55A4C8F4024Dget_impl*
 Result := f_GUID;
//#UC END# *55C486E400A6_55A4C8F4024Dget_impl*
end;//TvcmFormSetFormHistoryItem.pm_GetGUID

function TvcmFormSetFormHistoryItem.pm_GetContainerGUID: TGUID;
//#UC START# *55C4920F0257_55A4C8F4024Dget_var*
//#UC END# *55C4920F0257_55A4C8F4024Dget_var*
begin
//#UC START# *55C4920F0257_55A4C8F4024Dget_impl*
 Result := f_ContainerGUID;
//#UC END# *55C4920F0257_55A4C8F4024Dget_impl*
end;//TvcmFormSetFormHistoryItem.pm_GetContainerGUID

constructor TvcmFormSetHistory.Create;
//#UC START# *55A63AE5034E_55A5EB6F0346_var*
//#UC END# *55A63AE5034E_55A5EB6F0346_var*
begin
//#UC START# *55A63AE5034E_55A5EB6F0346_impl*
 inherited;
 f_Items := TvcmFormSetHistoryStepList.Create;
//#UC END# *55A63AE5034E_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.Create

class function TvcmFormSetHistory.Make: IvcmFormSetHistory;
var
 l_Inst : TvcmFormSetHistory;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmFormSetHistory.Make

procedure TvcmFormSetHistory.SaveFormSet(const aFormSet: IvcmFormSet);
//#UC START# *55A7402F0390_55A5EB6F0346_var*
//#UC END# *55A7402F0390_55A5EB6F0346_var*
begin
//#UC START# *55A7402F0390_55A5EB6F0346_impl*
 f_Items.Add(MakeStep(aFormSet.Container, False));
//#UC END# *55A7402F0390_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.SaveFormSet

function TvcmFormSetHistory.CloneContainer(const aContainer: IvcmContainer;
 const aContainerMaker: IvcmContainerMaker): IvcmContainer;
//#UC START# *55A77BB20049_55A5EB6F0346_var*
var
 l_Step: IvcmFormSetHistoryStep;
 l_Params: Il3TabParams;
 l_NewContainer: IvcmContainer;
 l_PrevTab: Il3FormTab;
 l_NewTab: Il3FormTab;
 l_FormSetToClone: IvcmFormSet;
//#UC END# *55A77BB20049_55A5EB6F0346_var*
begin
//#UC START# *55A77BB20049_55A5EB6F0346_impl*
 Result := nil;

 l_Step := MakeStep(aContainer, True);

 with TvcmTabbedContainerFormDispatcher.Instance do
 begin
  l_NewContainer := MakeAndPlaceVCMContainer(aContainerMaker,
                                             aContainer,
                                             vcm_okInNewTab,
                                             True,
                                             False,
                                             aContainer.AsForm.VCLWinControl as TvcmEntityForm);
  if (l_NewContainer <> nil) then
   l_NewContainer.InitFromPrevContainer(aContainer, True);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=606828289
 end;
 if (l_NewContainer <> nil) then
 begin
  l_Step.Restore(l_NewContainer, nil, False);
  with TvcmTabbedContainerFormDispatcher.Instance do
  begin
   l_PrevTab := GetFormTab(aContainer.AsForm.VCLWinControl as TForm);
   l_NewTab := GetFormTab(l_NewContainer.AsForm.VCLWinControl as TForm);
  end;

  l_Params := l_PrevTab.CurrentParams;
  l_NewTab.AssignParams(l_Params);

  Result := l_NewContainer;
 end;
//#UC END# *55A77BB20049_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.CloneContainer

procedure TvcmFormSetHistory.SaveForms(const aContainer: IvcmContainer);
//#UC START# *55A77BCA0130_55A5EB6F0346_var*
//#UC END# *55A77BCA0130_55A5EB6F0346_var*
begin
//#UC START# *55A77BCA0130_55A5EB6F0346_impl*
 f_Items.Add(MakeStep(aContainer, False));
//#UC END# *55A77BCA0130_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.SaveForms

function TvcmFormSetHistory.GetFormset(const aContainer: IvcmContainer;
 out aFormSet: IvcmFormSet): Boolean;
//#UC START# *55AF6AB902E5_55A5EB6F0346_var*
//#UC END# *55AF6AB902E5_55A5EB6F0346_var*
begin
//#UC START# *55AF6AB902E5_55A5EB6F0346_impl*
 aFormSet := TvcmFormSetContainerRegistry.Instance.GetContainedFormSet(aContainer);
 Result := (aFormSet <> nil);
//#UC END# *55AF6AB902E5_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.GetFormset

procedure TvcmFormSetHistory.StartOp(const aContainer: IvcmContainer);
//#UC START# *55DAB0B9015F_55A5EB6F0346_var*
//#UC END# *55DAB0B9015F_55A5EB6F0346_var*
begin
//#UC START# *55DAB0B9015F_55A5EB6F0346_impl*
 Assert(f_ContainerInOp = nil);
 f_ContainerInOp := Pointer(aContainer);
//#UC END# *55DAB0B9015F_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.StartOp

procedure TvcmFormSetHistory.EndOp(const aContainer: IvcmContainer);
//#UC START# *55DAB0C6006A_55A5EB6F0346_var*
//#UC END# *55DAB0C6006A_55A5EB6F0346_var*
begin
//#UC START# *55DAB0C6006A_55A5EB6F0346_impl*
 Assert(f_ContainerInOp <> nil);
 f_ContainerInOp := nil;
//#UC END# *55DAB0C6006A_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.EndOp

function TvcmFormSetHistory.MakeStepItems(const aContainer: IvcmContainer;
 aForClone: Boolean): IvcmFormSetHistoryStepItems;
//#UC START# *55E54A7100E5_55A5EB6F0346_var*
//#UC END# *55E54A7100E5_55A5EB6F0346_var*
begin
//#UC START# *55E54A7100E5_55A5EB6F0346_impl*
 Assert(aContainer <> nil);
 Result := TvcmFormSetHistoryStepItems.Make;
 if HasNonFormSetForms(aContainer) then
  Result.Add(TvcmLegacyFormSetHistoryItemStep.Make(aContainer, aForClone));
 if HasAnyFormSet(aContainer) then
  Result.Add(TvcmFormSetHistoryItemStep.Make(aContainer, aForClone));
//#UC END# *55E54A7100E5_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.MakeStepItems

function TvcmFormSetHistory.HasAnyFormSet(const aContainer: IvcmContainer): Boolean;
//#UC START# *55E56013034C_55A5EB6F0346_var*
//#UC END# *55E56013034C_55A5EB6F0346_var*
begin
//#UC START# *55E56013034C_55A5EB6F0346_impl*
 Assert(aContainer <> nil);
 Result := (TvcmFormSetContainerRegistry.Instance.GetFormSetCount(aContainer) > 0);
//#UC END# *55E56013034C_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.HasAnyFormSet

function TvcmFormSetHistory.HasNonFormsetForms(const aContainer: IvcmContainer): Boolean;
//#UC START# *55E58D2100F2_55A5EB6F0346_var*

 function lp_CheckForm(const aForm: IvcmEntityForm): Boolean;
 var
  l_Index: Integer;
  l_Control: TControl;
  l_Component: TComponent;
  l_Form: IvcmEntityForm;
 begin
  Result := (not IsInFormset(aForm)) and (aForm.Aggregate <> nil);
  if (not Result) then
  begin
   for l_Index := 0 to Pred(aForm.VCLWinControl.ControlCount) do
   begin
    l_Control := aForm.VCLWinControl.Controls[l_Index];
    if l_Control is TvcmEntityForm then
    begin
     l_Form := TvcmEntityForm(l_Control).As_IvcmEntityForm;
     Result := lp_CheckForm(l_Form);
    end;
   end;
  end;
  if (not Result) then
  begin
   for l_Index := 0 to Pred(aForm.VCLWinControl.ComponentCount) do
   begin
    l_Component := aForm.VCLWinControl.Components[l_Index];
    if l_Component is TvcmEntityForm then
    begin
     l_Form := TvcmEntityForm(l_Component).As_IvcmEntityForm;
     Result := lp_CheckForm(l_Form);
    end;
   end;
  end;
 end;//lp_CheckForm


var
 l_FormIter: IvcmEntityFormIterator;
 l_Form: IvcmEntityForm;
//#UC END# *55E58D2100F2_55A5EB6F0346_var*
begin
//#UC START# *55E58D2100F2_55A5EB6F0346_impl*
 l_FormIter := aContainer.EntityFormIterator;
 l_Form := l_FormIter.Next;
 while (l_Form <> nil) do
 begin
  Result := lp_CheckForm(l_Form);
  if Result then
   Exit;
  l_Form := l_FormIter.Next;
 end;
//#UC END# *55E58D2100F2_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.HasNonFormsetForms

function TvcmFormSetHistory.IsInFormset(const aForm: IvcmEntityForm): Boolean;
//#UC START# *55E7E30B01FE_55A5EB6F0346_var*
var
 l_WinControl: TWinControl;
 l_Form: IvcmEntityForm;
 l_Index: Integer;
//#UC END# *55E7E30B01FE_55A5EB6F0346_var*
begin
//#UC START# *55E7E30B01FE_55A5EB6F0346_impl*
 Result := (aForm.FormSet <> nil) or
  Supports(aForm.Aggregate, IvcmFormSet);
//#UC END# *55E7E30B01FE_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.IsInFormset

function TvcmFormSetHistory.MakeStep(const aContainer: IvcmContainer;
 aForClone: Boolean): IvcmFormSetHistoryStep;
//#UC START# *56024FA0004B_55A5EB6F0346_var*
//#UC END# *56024FA0004B_55A5EB6F0346_var*
begin
//#UC START# *56024FA0004B_55A5EB6F0346_impl*
 Result := TvcmFormSetHistoryStep.Make(MakeStepItems(aContainer, aForClone));
//#UC END# *56024FA0004B_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.MakeStep

procedure TvcmFormSetHistory.Back(const aContainer: IvcmContainer);
//#UC START# *55A4A45E022B_55A5EB6F0346_var*
var
 l_Step: IvcmFormSetHistoryStep;
//#UC END# *55A4A45E022B_55A5EB6F0346_var*
begin
//#UC START# *55A4A45E022B_55A5EB6F0346_impl*
 f_InBf := True;
 try
  l_Step := f_Items.Last;
  f_Items.Remove(l_Step);
  l_Step.Restore(aContainer, nil, True);
 finally
  f_InBf := False;
 end;
//#UC END# *55A4A45E022B_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.Back

function TvcmFormSetHistory.pm_GetItemCount: Integer;
//#UC START# *55A4A47400CD_55A5EB6F0346get_var*
//#UC END# *55A4A47400CD_55A5EB6F0346get_var*
begin
//#UC START# *55A4A47400CD_55A5EB6F0346get_impl*
 Result := f_Items.Count;
//#UC END# *55A4A47400CD_55A5EB6F0346get_impl*
end;//TvcmFormSetHistory.pm_GetItemCount

procedure TvcmFormSetHistory.CloneTab(const aTab: Il3FormTab);
//#UC START# *55A77AAB00D9_55A5EB6F0346_var*
var
 l_Container: IvcmContainer;
 l_ContainerMaker: IvcmContainerMaker;
//#UC END# *55A77AAB00D9_55A5EB6F0346_var*
begin
//#UC START# *55A77AAB00D9_55A5EB6F0346_impl*
 f_InBf := True;
 try
  if Supports(aTab.TabbedForm, IvcmContainer, l_Container) and
     Supports(aTab.TabbedForm, IvcmContainerMaker, l_ContainerMaker) then
    CloneContainer(l_Container, l_ContainerMaker)
  else
   Assert(False);
 finally
  f_InBf := False;
 end;
//#UC END# *55A77AAB00D9_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.CloneTab

procedure TvcmFormSetHistory.SaveTab(const aTab: Il3FormTab);
//#UC START# *55A77AB90278_55A5EB6F0346_var*
var
 l_Container: IvcmContainer;
 l_FormSet: IvcmFormSet;
//#UC END# *55A77AB90278_55A5EB6F0346_var*
begin
//#UC START# *55A77AB90278_55A5EB6F0346_impl*
 if Supports(aTab.TabbedForm, IvcmContainer, l_Container) then
 begin
  f_InBf := True;
  try
   f_Items.Add(MakeStep(l_Container, False));
  finally
   f_InBf := False;
  end;
 end
 else
  Assert(False);
//#UC END# *55A77AB90278_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.SaveTab

function TvcmFormSetHistory.CanBack: Boolean;
//#UC START# *55A78D640044_55A5EB6F0346_var*
//#UC END# *55A78D640044_55A5EB6F0346_var*
begin
//#UC START# *55A78D640044_55A5EB6F0346_impl*
 Result := f_Items.Count > 0;
//#UC END# *55A78D640044_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.CanBack

function TvcmFormSetHistory.pm_GetInBF: Boolean;
//#UC START# *55B8871D0112_55A5EB6F0346get_var*
//#UC END# *55B8871D0112_55A5EB6F0346get_var*
begin
//#UC START# *55B8871D0112_55A5EB6F0346get_impl*
 Result := f_InBF;
//#UC END# *55B8871D0112_55A5EB6F0346get_impl*
end;//TvcmFormSetHistory.pm_GetInBF

function TvcmFormSetHistory.IsContainerInOp(const aContainer: IvcmContainer): Boolean;
//#UC START# *55DACFA000F1_55A5EB6F0346_var*
//#UC END# *55DACFA000F1_55A5EB6F0346_var*
begin
//#UC START# *55DACFA000F1_55A5EB6F0346_impl*
 Result := l3IEQ(IvcmContainer(f_ContainerInOp), aContainer);
//#UC END# *55DACFA000F1_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.IsContainerInOp

procedure TvcmFormSetHistory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55A5EB6F0346_var*
//#UC END# *479731C50290_55A5EB6F0346_var*
begin
//#UC START# *479731C50290_55A5EB6F0346_impl*
 FreeAndNil(f_Items);
 inherited;
//#UC END# *479731C50290_55A5EB6F0346_impl*
end;//TvcmFormSetHistory.Cleanup

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_55C864BA02BE_var*
//#UC END# *47B2C42A0163_55C864BA02BE_var*
begin
//#UC START# *47B2C42A0163_55C864BA02BE_impl*
 Assert(False);
//#UC END# *47B2C42A0163_55C864BA02BE_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_55C864BA02BE_var*
//#UC END# *47B99D4503A2_55C864BA02BE_var*
begin
//#UC START# *47B99D4503A2_55C864BA02BE_impl*
 Result := -1;
 Assert(False);
//#UC END# *47B99D4503A2_55C864BA02BE_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmHistoryFormCache;

{$Include w:\common\components\rtl\Garant\L3\l3RecordWithEQList.imp.pas}

function TvcmHistoryFormCache.FindForm(const aGUID: TGUID): IvcmEntityForm;
//#UC START# *55C893D00196_55C864BA02BE_var*
var
 l_Form: IvcmEntityForm;

 function lp_DoFindForm(anItem: PvcmHistoryFormCacheItem; anIndex: Integer): Boolean;
 begin
  Result := not IsEqualGUID(aGUID, anItem^.rGUID);
  if (not Result) then
   l_Form := anItem^.rForm;
 end;//lp_DoFindForms

//#UC END# *55C893D00196_55C864BA02BE_var*
begin
//#UC START# *55C893D00196_55C864BA02BE_impl*
 l_Form := nil;
 IterateAllF(l3L2IA(@lp_DoFindForm));
 Result := l_Form;
//#UC END# *55C893D00196_55C864BA02BE_impl*
end;//TvcmHistoryFormCache.FindForm

constructor TvcmLegacyFormSetHistoryItem.Create(const aContainer: IvcmContainer;
 aForClone: Boolean);
//#UC START# *55A4BCC1028B_55A4BC2300E5_var*
//#UC END# *55A4BCC1028B_55A4BC2300E5_var*
begin
//#UC START# *55A4BCC1028B_55A4BC2300E5_impl*
 f_FormCache := TvcmHistoryFormCache.Create;
 inherited Create(nil, aContainer, aForClone);
//#UC END# *55A4BCC1028B_55A4BC2300E5_impl*
end;//TvcmLegacyFormSetHistoryItem.Create

class function TvcmLegacyFormSetHistoryItem.Make(const aContainer: IvcmContainer;
 aForClone: Boolean): IvcmFormSetHistoryItem;
var
 l_Inst : TvcmLegacyFormSetHistoryItem;
begin
 l_Inst := Create(aContainer, aForClone);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmLegacyFormSetHistoryItem.Make

function TvcmLegacyFormSetHistoryItem.GetFormContainer(const aItem: IvcmFormSetFormHistoryItem): IvcmContainer;
//#UC START# *55C4923D0196_55A4BC2300E5_var*
var
 l_Index: Integer;
 l_FormGUID: TGUID;
 l_ContainerGUID: TGUID;
 l_ContainerForm: IvcmEntityForm;
//#UC END# *55C4923D0196_55A4BC2300E5_var*
begin
//#UC START# *55C4923D0196_55A4BC2300E5_impl*
 l_FormGUID := aItem.GUID;
 l_ContainerGUID := aItem.ContainerGUID;
 l_ContainerForm := f_FormCache.FindForm(l_ContainerGUID);
 if (l_ContainerForm <> nil) then
  Result := l_ContainerForm.AsContainer
 else
  Result := nil;
//#UC END# *55C4923D0196_55A4BC2300E5_impl*
end;//TvcmLegacyFormSetHistoryItem.GetFormContainer

function TvcmLegacyFormSetHistoryItem.NeedMakeForm(const anItem: IvcmFormSetFormHistoryItem;
 const aContainer: IvcmContainer): Boolean;
//#UC START# *55FFA8C202CD_55A4BC2300E5_var*
var
 l_Form: IvcmEntityForm;
//#UC END# *55FFA8C202CD_55A4BC2300E5_var*
begin
//#UC START# *55FFA8C202CD_55A4BC2300E5_impl*
 Result := (not aContainer.NativeMainForm.HasForm(anItem.FormID, anItem.ZoneType,
  True, @l_Form));
//#UC END# *55FFA8C202CD_55A4BC2300E5_impl*
end;//TvcmLegacyFormSetHistoryItem.NeedMakeForm

function TvcmLegacyFormSetHistoryItem.MakeItem(const aFormSet: IvcmFormSet;
 const aContainer: IvcmContainer;
 const aForm: IvcmEntityForm): IvcmFormSetFormHistoryItem;
//#UC START# *55A4BB850020_55A4BC2300E5_var*
//#UC END# *55A4BB850020_55A4BC2300E5_var*
begin
//#UC START# *55A4BB850020_55A4BC2300E5_impl*
 Result := TvcmFormSetFormHistoryItem.Make(aForm);
//#UC END# *55A4BB850020_55A4BC2300E5_impl*
end;//TvcmLegacyFormSetHistoryItem.MakeItem

function TvcmLegacyFormSetHistoryItem.DoMakeFormSet(const aContainer: IvcmContainer;
 out aFormSet: IvcmFormSet): Boolean;
//#UC START# *55A4C21A006B_55A4BC2300E5_var*
var
 l_ActiveInParentForm: IvcmEntityForm;
 l_Index: Integer;
 l_FormItem: IvcmFormSetFormHistoryItem;
 l_Form: IvcmEntityForm;
 l_Aggregate: IvcmAggregate;
 l_Container: IvcmContainer;
//#UC END# *55A4C21A006B_55A4BC2300E5_var*
begin
//#UC START# *55A4C21A006B_55A4BC2300E5_impl*
 l_ActiveInParentForm := nil;
 l_Aggregate := TvcmAggregate.Make;

 for l_Index := 0 to Pred(f_Items.Count) do
 begin
  l_FormItem := f_Items[l_Index];
  l_Container := GetFormContainer(l_FormItem);

  if (l_Container = nil) then
   l_Container := aContainer;

  if NeedMakeForm(l_FormItem, l_Container) then
  begin
   l_FormItem.MakeForm(l_Container, nil, l_Aggregate, l_Form);
   DoLoadFormState(l_Form, l_FormItem);
   f_FormCache.Add(TvcmHistoryFormCacheItem_C(l_Form, l_FormItem.GUID));
  end;
 end;

 if f_ActiveFormStored and
  l_Container.NativeMainForm.HasForm(f_ActiveFormID, f_ActiveFormZoneType,
  True, @l_ActiveInParentForm) then
 begin 
  l_ActiveInParentForm.SetActiveAndShowInParent;
  f_ActiveFormStored := False;
 end;
 
 f_FormCache.Clear;
//#UC END# *55A4C21A006B_55A4BC2300E5_impl*
end;//TvcmLegacyFormSetHistoryItem.DoMakeFormSet

procedure TvcmLegacyFormSetHistoryItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55A4BC2300E5_var*
//#UC END# *479731C50290_55A4BC2300E5_var*
begin
//#UC START# *479731C50290_55A4BC2300E5_impl*
 FreeAndNil(f_FormCache);
 inherited;
//#UC END# *479731C50290_55A4BC2300E5_impl*
end;//TvcmLegacyFormSetHistoryItem.Cleanup

procedure TvcmLegacyFormSetHistoryItem.FillItems(const aFormSet: IvcmFormSet;
 const aContainer: IvcmContainer;
 aItems: TvcmFormSetFormHistoryItemList);
//#UC START# *55A4BB09012B_55A4BC2300E5_var*
var
 l_List: TvcmIEntityFormList;
 l_MainForm: IvcmEntityForm;

 function lp_CheckForm(const aForm: IvcmEntityForm): Boolean;
 begin
  Result := (aForm.FormSet = nil) and
   (aForm.Aggregate <> nil) and 
   (not Supports(aForm.Aggregate, IvcmFormSet));
 end;//lp_CheckForm

 procedure lp_Save(aComponent: TComponent);
 var
  l_Form: IvcmEntityForm;
 begin
  if Supports(aComponent, IvcmEntityForm, l_Form) then
  try
   if (l_Form.NeedSaveToTabHistory) and
      (l_List.IndexOf(l_Form) = -1) and
      (not l3IEQ(l_Form, l_MainForm)) and
      lp_CheckForm(l_Form) then
    l_List.Add(l_Form);
  finally
   l_Form := nil;
  end;
 end;

 procedure lp_SaveDocked(aControl: TControl);
 var
  l_Index: Integer;
  l_Control: TWinControl;
 begin
  lp_Save(aControl);
  if (aControl is TWinControl) then
  begin
   l_Control := TWinControl(aControl);
   for l_Index := 0 to Pred(l_Control.ControlCount) do
    lp_SaveDocked(l_Control.Controls[l_Index]);
  end;
 end;//procedure lp_SaveDocked

 procedure lp_SaveOwned(aComponent: TComponent);
 var
  l_Index: Integer;
 begin
  lp_Save(aComponent);
  for l_Index := 0 to Pred(aComponent.ComponentCount) do
   lp_SaveOwned(TControl(aComponent.Components[l_Index]));
 end;//procedure lp_SaveOwned

var
 l_ContainerForm: TWinControl;
 l_Form: IvcmEntityForm;
 l_Index: Integer;
//#UC END# *55A4BB09012B_55A4BC2300E5_var*
begin
//#UC START# *55A4BB09012B_55A4BC2300E5_impl*
 l_List := TvcmIEntityFormList.Create;
 try
  l_ContainerForm := aContainer.AsForm.VCLWinControl;
  l_MainForm := aContainer.AsForm;
  lp_SaveOwned(l_ContainerForm);
  lp_SaveDocked(l_ContainerForm);
  for l_Index := 0 to Pred(l_List.Count) do
  begin
   l_Form := IvcmEntityForm(l_List.Items[l_Index]);
   f_Items.Add(MakeItem(aFormSet, aContainer, l_Form));
   if l_Form.IsActiveInParent then
   begin
    f_ActiveFormZoneType := l_Form.ZoneType;
    f_ActiveFormUserType := l_Form.UserType;
    f_ActiveFormSubUserType := l_Form.SubUserType;
    f_ActiveFormStored := True;
   end;
  end;
 finally
  FreeAndNil(l_List);
 end;
//#UC END# *55A4BB09012B_55A4BC2300E5_impl*
end;//TvcmLegacyFormSetHistoryItem.FillItems

constructor TvcmBaseFormSetHistoryStepItem.Create(const aContainer: IvcmContainer;
 aForClone: Boolean);
//#UC START# *55E409B1026B_55E4091E0038_var*
var
 l_Tab: Il3FormTab;
//#UC END# *55E409B1026B_55E4091E0038_var*
begin
//#UC START# *55E409B1026B_55E4091E0038_impl*
 Assert(aContainer <> nil);
 inherited Create;
 f_FormSetItems := TvcmFormSetHistoryItemList.Create;

 with TvcmTabbedContainerFormDispatcher.Instance do
  l_Tab := GetFormTab(aContainer.AsForm.VCLWinControl as TForm);

 f_TabParams := l_Tab.CurrentParams;

 FillItems(aContainer, aForClone);
//#UC END# *55E409B1026B_55E4091E0038_impl*
end;//TvcmBaseFormSetHistoryStepItem.Create

class function TvcmBaseFormSetHistoryStepItem.Make(const aContainer: IvcmContainer;
 aForClone: Boolean): IvcmFormSetHistoryStepItem;
var
 l_Inst : TvcmBaseFormSetHistoryStepItem;
begin
 l_Inst := Create(aContainer, aForClone);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmBaseFormSetHistoryStepItem.Make

procedure TvcmBaseFormSetHistoryStepItem.FillItems(const aContainer: IvcmContainer;
 aForClone: Boolean);
//#UC START# *55E40ECA011A_55E4091E0038_var*
//#UC END# *55E40ECA011A_55E4091E0038_var*
begin
//#UC START# *55E40ECA011A_55E4091E0038_impl*
//#UC END# *55E40ECA011A_55E4091E0038_impl*
end;//TvcmBaseFormSetHistoryStepItem.FillItems

procedure TvcmBaseFormSetHistoryStepItem.Restore(const aContainer: IvcmContainer;
 const aFormSetToClone: IvcmFormSet;
 aNeedAssignHistory: Boolean);
//#UC START# *55E4037A0376_55E4091E0038_var*
var
 l_Index: Integer;
 l_Item: IvcmFormSetHistoryItem;
 l_FormSet: IvcmFormSet;
 l_Tab: Il3FormTab;
//#UC END# *55E4037A0376_55E4091E0038_var*
begin
//#UC START# *55E4037A0376_55E4091E0038_impl*
 for l_Index := 0 to Pred(f_FormSetItems.Count) do
 begin
  l_Item := nil;
  l_Item := f_FormSetItems[l_Index];
  l_Item.MakeFormSet(aContainer, l_FormSet, aNeedAssignHistory);
 end;
 with TvcmTabbedContainerFormDispatcher.Instance do
  l_Tab := GetFormTab(aContainer.AsForm.VCLWinControl as TForm);
 Assert(l_Tab <> nil);
 l_Tab.AssignParams(f_TabParams);
 l_Tab.TabbedContainer.UpdateCaption;
//#UC END# *55E4037A0376_55E4091E0038_impl*
end;//TvcmBaseFormSetHistoryStepItem.Restore

procedure TvcmBaseFormSetHistoryStepItem.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55E4091E0038_var*
//#UC END# *479731C50290_55E4091E0038_var*
begin
//#UC START# *479731C50290_55E4091E0038_impl*
 FreeAndNil(f_FormSetItems);
 inherited;
//#UC END# *479731C50290_55E4091E0038_impl*
end;//TvcmBaseFormSetHistoryStepItem.Cleanup

procedure TvcmFormSetHistoryItemStep.FillItems(const aContainer: IvcmContainer;
 aForClone: Boolean);
//#UC START# *55E40ECA011A_55E55065035D_var*

 function lp_DoAddItem(const aFormSet: IvcmFormSet): Boolean;
 begin
  f_FormSetItems.Add(TvcmFormSetHistoryItem.Make(aFormSet, aContainer,
   aForClone));
  Result := True;
 end;//lp_DoAddItem

//#UC END# *55E40ECA011A_55E55065035D_var*
begin
//#UC START# *55E40ECA011A_55E55065035D_impl*
 with TvcmFormSetContainerRegistry.Instance.Map do
  ForEachF(L2TvcmFormSetContainerMapIteratorForEachFAction(@lp_DoAddItem), aContainer);
//#UC END# *55E40ECA011A_55E55065035D_impl*
end;//TvcmFormSetHistoryItemStep.FillItems

procedure TvcmLegacyFormSetHistoryItemStep.FillItems(const aContainer: IvcmContainer;
 aForClone: Boolean);
//#UC START# *55E40ECA011A_55E5507203BD_var*
//#UC END# *55E40ECA011A_55E5507203BD_var*
begin
//#UC START# *55E40ECA011A_55E5507203BD_impl*
 f_FormSetItems.Add(TvcmLegacyFormSetHistoryItem.Make(aContainer, aForClone));
//#UC END# *55E40ECA011A_55E5507203BD_impl*
end;//TvcmLegacyFormSetHistoryItemStep.FillItems

constructor TvcmFormSetHistoryStepItems.Create;
//#UC START# *55F7CDE00187_55F7CD4B039A_var*
//#UC END# *55F7CDE00187_55F7CD4B039A_var*
begin
//#UC START# *55F7CDE00187_55F7CD4B039A_impl*
 inherited;
 Reset;
 f_Steps := TvcmFormSetHistoryStepItemList.Create;
//#UC END# *55F7CDE00187_55F7CD4B039A_impl*
end;//TvcmFormSetHistoryStepItems.Create

class function TvcmFormSetHistoryStepItems.Make: IvcmFormSetHistoryStepItems;
var
 l_Inst : TvcmFormSetHistoryStepItems;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmFormSetHistoryStepItems.Make

function TvcmFormSetHistoryStepItems.pm_GetNext: Boolean;
//#UC START# *55F7CCDD01AE_55F7CD4B039Aget_var*
//#UC END# *55F7CCDD01AE_55F7CD4B039Aget_var*
begin
//#UC START# *55F7CCDD01AE_55F7CD4B039Aget_impl*
 Result := (f_CurrentIndex < Pred(f_Steps.Count));
 if Result then
  Inc(f_CurrentIndex);
//#UC END# *55F7CCDD01AE_55F7CD4B039Aget_impl*
end;//TvcmFormSetHistoryStepItems.pm_GetNext

function TvcmFormSetHistoryStepItems.Get_Current: IvcmFormSetHistoryStepItem;
//#UC START# *55F7CD080116_55F7CD4B039Aget_var*
//#UC END# *55F7CD080116_55F7CD4B039Aget_var*
begin
//#UC START# *55F7CD080116_55F7CD4B039Aget_impl*
 Result := f_Steps[f_CurrentIndex];
//#UC END# *55F7CD080116_55F7CD4B039Aget_impl*
end;//TvcmFormSetHistoryStepItems.Get_Current

procedure TvcmFormSetHistoryStepItems.Add(const anItem: IvcmFormSetHistoryStepItem);
//#UC START# *55F7CD340397_55F7CD4B039A_var*
//#UC END# *55F7CD340397_55F7CD4B039A_var*
begin
//#UC START# *55F7CD340397_55F7CD4B039A_impl*
 f_Steps.Add(anItem);
//#UC END# *55F7CD340397_55F7CD4B039A_impl*
end;//TvcmFormSetHistoryStepItems.Add

procedure TvcmFormSetHistoryStepItems.Reset;
//#UC START# *56025D8D015B_55F7CD4B039A_var*
//#UC END# *56025D8D015B_55F7CD4B039A_var*
begin
//#UC START# *56025D8D015B_55F7CD4B039A_impl*
 f_CurrentIndex := -1;
//#UC END# *56025D8D015B_55F7CD4B039A_impl*
end;//TvcmFormSetHistoryStepItems.Reset

procedure TvcmFormSetHistoryStepItems.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55F7CD4B039A_var*
//#UC END# *479731C50290_55F7CD4B039A_var*
begin
//#UC START# *479731C50290_55F7CD4B039A_impl*
 FreeAndNil(f_Steps);
 inherited;
//#UC END# *479731C50290_55F7CD4B039A_impl*
end;//TvcmFormSetHistoryStepItems.Cleanup

constructor TvcmFormSetHistoryStep.Create(const aSteps: IvcmFormSetHistoryStepItems);
//#UC START# *56024E5400EC_56024DEC0148_var*
//#UC END# *56024E5400EC_56024DEC0148_var*
begin
//#UC START# *56024E5400EC_56024DEC0148_impl*
 inherited Create;
 f_Steps := aSteps;
//#UC END# *56024E5400EC_56024DEC0148_impl*
end;//TvcmFormSetHistoryStep.Create

class function TvcmFormSetHistoryStep.Make(const aSteps: IvcmFormSetHistoryStepItems): IvcmFormSetHistoryStep;
var
 l_Inst : TvcmFormSetHistoryStep;
begin
 l_Inst := Create(aSteps);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TvcmFormSetHistoryStep.Make

function TvcmFormSetHistoryStep.pm_GetNext: Boolean;
//#UC START# *55F7CCDD01AE_56024DEC0148get_var*
//#UC END# *55F7CCDD01AE_56024DEC0148get_var*
begin
//#UC START# *55F7CCDD01AE_56024DEC0148get_impl*
 Result := f_Steps.Next;
//#UC END# *55F7CCDD01AE_56024DEC0148get_impl*
end;//TvcmFormSetHistoryStep.pm_GetNext

function TvcmFormSetHistoryStep.Get_Current: IvcmFormSetHistoryStepItem;
//#UC START# *55F7CD080116_56024DEC0148get_var*
//#UC END# *55F7CD080116_56024DEC0148get_var*
begin
//#UC START# *55F7CD080116_56024DEC0148get_impl*
 Result := f_Steps.Current;
//#UC END# *55F7CD080116_56024DEC0148get_impl*
end;//TvcmFormSetHistoryStep.Get_Current

procedure TvcmFormSetHistoryStep.Add(const anItem: IvcmFormSetHistoryStepItem);
//#UC START# *55F7CD340397_56024DEC0148_var*
//#UC END# *55F7CD340397_56024DEC0148_var*
begin
//#UC START# *55F7CD340397_56024DEC0148_impl*
 f_Steps.Add(anItem);
//#UC END# *55F7CD340397_56024DEC0148_impl*
end;//TvcmFormSetHistoryStep.Add

procedure TvcmFormSetHistoryStep.Restore(const aContainer: IvcmContainer;
 const aFormSetToClone: IvcmFormSet;
 aNeedAssignHistory: Boolean);
//#UC START# *560246E502E8_56024DEC0148_var*
//#UC END# *560246E502E8_56024DEC0148_var*
begin
//#UC START# *560246E502E8_56024DEC0148_impl*
 f_Steps.Reset;
 while f_Steps.Next do
  f_Steps.Current.Restore(aContainer, aFormSetToClone, aNeedAssignHistory);
//#UC END# *560246E502E8_56024DEC0148_impl*
end;//TvcmFormSetHistoryStep.Restore

procedure TvcmFormSetHistoryStep.Reset;
//#UC START# *56025D8D015B_56024DEC0148_var*
//#UC END# *56025D8D015B_56024DEC0148_var*
begin
//#UC START# *56025D8D015B_56024DEC0148_impl*
 f_Steps.Reset;
//#UC END# *56025D8D015B_56024DEC0148_impl*
end;//TvcmFormSetHistoryStep.Reset

procedure TvcmFormSetHistoryStep.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56024DEC0148_var*
//#UC END# *479731C50290_56024DEC0148_var*
begin
//#UC START# *479731C50290_56024DEC0148_impl*
 f_Steps := nil;
 inherited;
//#UC END# *479731C50290_56024DEC0148_impl*
end;//TvcmFormSetHistoryStep.Cleanup
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoVGScene) AND NOT Defined(NoTabs)

end.
