unit vcmFormSet;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormSet.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmFormSet" MUID: (5087BD37023E)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmAggregate
 , vcmInterfaces
 , vcmFormSetRefreshDataParamsList
 , vcmFormSetFormItemList
 , vcmExternalInterfaces
 , vcmBaseTypes
;

type
 RvcmFormSet = class of TvcmFormSet;

 TvcmFormSet = class(TvcmAggregate, IvcmFormSet)
  private
   f_Factory: IvcmFormSetFactory;
   f_Container: Pointer;
   f_CanRefresh: Boolean;
   f_DataSource: Integer;
   f_RefreshStack: TvcmFormSetRefreshDataParamsList;
   f_Forms: TvcmFormSetFormList;
  protected
   function pm_GetRefreshStack: TvcmFormSetRefreshDataParamsList;
   function pm_GetForms: TvcmFormSetFormList;
   procedure FormListAssigned; virtual;
   function DoGetFormSetCaption: IvcmCString; virtual;
   function DoGetFormSetTabCaption: IvcmCString; virtual;
   function DoGetFormSetTabHint: IvcmCString; virtual;
   function DoGetCanBeCloned: Boolean; virtual;
   function DoGetCanBeSavedToHistory: Boolean; virtual;
   function DoGetCanBeMain: Boolean; virtual;
   procedure Refresh(const aParams: IvcmFormSetRefreshDataParams);
    {* обновляет представление сборки }
   procedure SaveHistory;
    {* сохраняет сборку в историю }
   function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
    {* является ли форма главной в сборке }
   function FindStatusInfoForm: IvcmEntityForm;
    {* найти форму отвечающую за вывод статуса }
   procedure PopToHistory;
    {* сборка помещена в историю }
   procedure PushFromHistory;
    {* сборка выгружена из истории }
   function pm_GetContainer: IvcmContainer;
   procedure pm_SetContainer(const aValue: IvcmContainer);
   function pm_GetFactory: IvcmFormSetFactory;
   procedure pm_SetFactory(const aValue: IvcmFormSetFactory);
   function pm_GetCanRefresh: Boolean;
   function pm_GetDataSource: IvcmFormSetDataSource;
   procedure pm_SetDataSource(const aValue: IvcmFormSetDataSource);
   procedure AssignFormList(aFormList: TvcmFormSetFormList);
    {* Заполнить мапу форм / флажков в сборке }
   function GetFormNeedMakeDS(const aFormDescr: TvcmFormSetFormItemDescr): TvcmNeedMakeDS;
   procedure SetFormNeedMakeDS(const aFormDescr: TvcmFormSetFormItemDescr;
    aNeedMakeDS: TvcmNeedMakeDS);
   function CastFS(const aGUID: TGUID;
    out theObj): Boolean;
   procedure SetFormClosed(const aForm: IvcmEntityForm);
    {* Установить признак того, что форма была закрыта }
   procedure SetIfNeedMakeNo(const aFormDescr: TvcmFormSetFormItemDescr;
    aNeedMake: TvcmNeedMakeDS);
   procedure SaveFormList(aFormList: TvcmFormSetFormList);
   function pm_GetFormSetImageIndex: Integer;
   function pm_GetFormSetCaption: IvcmCString;
   function pm_GetFormSetTabCaption: IvcmCString;
   function pm_GetFormSetTabHint: IvcmCString;
   function MakeClone(const aContainer: IvcmContainer): IvcmFormSet;
   function pm_GetCanBeCloned: Boolean;
   function pm_GetCanBeSavedToHistory: Boolean;
   function pm_GetCanBeMain: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make(const aContainer: IvcmContainer;
    const aFactory: IvcmFormSetFactory): IvcmFormSet;
   constructor Create(const aContainer: IvcmContainer;
    const aFactory: IvcmFormSetFactory); reintroduce; virtual;
  protected
   property RefreshStack: TvcmFormSetRefreshDataParamsList
    read pm_GetRefreshStack;
   property Forms: TvcmFormSetFormList
    read pm_GetForms;
 end;//TvcmFormSet
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , vcmFormSetRefreshParams
 , vcmFormSetContainerRegistry
 //#UC START# *5087BD37023Eimpl_uses*
 //#UC END# *5087BD37023Eimpl_uses*
;

function TvcmFormSet.pm_GetRefreshStack: TvcmFormSetRefreshDataParamsList;
//#UC START# *5286081A00D0_5087BD37023Eget_var*
//#UC END# *5286081A00D0_5087BD37023Eget_var*
begin
//#UC START# *5286081A00D0_5087BD37023Eget_impl*
 if f_RefreshStack = nil then
  f_RefreshStack := TvcmFormSetRefreshDataParamsList.Make;
 Result := f_RefreshStack;
//#UC END# *5286081A00D0_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetRefreshStack

function TvcmFormSet.pm_GetForms: TvcmFormSetFormList;
//#UC START# *528B259002B0_5087BD37023Eget_var*
//#UC END# *528B259002B0_5087BD37023Eget_var*
begin
//#UC START# *528B259002B0_5087BD37023Eget_impl*
 if (f_Forms = nil) then
  f_Forms := TvcmFormSetFormList.Create;
 Result := f_Forms;
//#UC END# *528B259002B0_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetForms

class function TvcmFormSet.Make(const aContainer: IvcmContainer;
 const aFactory: IvcmFormSetFactory): IvcmFormSet;
//#UC START# *5286089601AD_5087BD37023E_var*
var
 l_Class : TvcmFormSet;
//#UC END# *5286089601AD_5087BD37023E_var*
begin
//#UC START# *5286089601AD_5087BD37023E_impl*
 l_Class := Create(aContainer, aFactory);
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;//try..finally
//#UC END# *5286089601AD_5087BD37023E_impl*
end;//TvcmFormSet.Make

constructor TvcmFormSet.Create(const aContainer: IvcmContainer;
 const aFactory: IvcmFormSetFactory);
//#UC START# *528609A20025_5087BD37023E_var*
//#UC END# *528609A20025_5087BD37023E_var*
begin
//#UC START# *528609A20025_5087BD37023E_impl*
 inherited Create;
 f_Container := Pointer(aContainer);
 f_Factory   := aFactory;
 f_CanRefresh := True;
 TvcmFormSetContainerRegistry.Instance.RegisterFormSet(Self, aContainer);
//#UC END# *528609A20025_5087BD37023E_impl*
end;//TvcmFormSet.Create

procedure TvcmFormSet.FormListAssigned;
//#UC START# *53034BFF0015_5087BD37023E_var*
//#UC END# *53034BFF0015_5087BD37023E_var*
begin
//#UC START# *53034BFF0015_5087BD37023E_impl*
 //
//#UC END# *53034BFF0015_5087BD37023E_impl*
end;//TvcmFormSet.FormListAssigned

function TvcmFormSet.DoGetFormSetCaption: IvcmCString;
//#UC START# *54B352340122_5087BD37023E_var*
//#UC END# *54B352340122_5087BD37023E_var*
begin
//#UC START# *54B352340122_5087BD37023E_impl*
 Result := pm_GetFactory.MakeFormSetCaption(pm_GetDataSource);
//#UC END# *54B352340122_5087BD37023E_impl*
end;//TvcmFormSet.DoGetFormSetCaption

function TvcmFormSet.DoGetFormSetTabCaption: IvcmCString;
//#UC START# *54B3525201F6_5087BD37023E_var*
//#UC END# *54B3525201F6_5087BD37023E_var*
begin
//#UC START# *54B3525201F6_5087BD37023E_impl*
 Result := pm_GetFactory.MakeFormSetTabCaption(pm_GetDataSource);
 if (Result = nil) and
    (f_DataSource <> 0) then
  Result := IvcmFormSetDataSource(f_DataSource).TabCaption;
//#UC END# *54B3525201F6_5087BD37023E_impl*
end;//TvcmFormSet.DoGetFormSetTabCaption

function TvcmFormSet.DoGetFormSetTabHint: IvcmCString;
//#UC START# *54B3526E020F_5087BD37023E_var*
//#UC END# *54B3526E020F_5087BD37023E_var*
begin
//#UC START# *54B3526E020F_5087BD37023E_impl*
 Result := pm_GetFactory.MakeFormSetTabHint(pm_GetDataSource);
 if (Result = nil) and
    (f_DataSource <> 0) then
  Result := IvcmFormSetDataSource(f_DataSource).TabHint;
//#UC END# *54B3526E020F_5087BD37023E_impl*
end;//TvcmFormSet.DoGetFormSetTabHint

function TvcmFormSet.DoGetCanBeCloned: Boolean;
//#UC START# *555D6A1000F5_5087BD37023E_var*
//#UC END# *555D6A1000F5_5087BD37023E_var*
begin
//#UC START# *555D6A1000F5_5087BD37023E_impl*
 Result := f_Factory.CanCloneFormSet(Self);
//#UC END# *555D6A1000F5_5087BD37023E_impl*
end;//TvcmFormSet.DoGetCanBeCloned

function TvcmFormSet.DoGetCanBeSavedToHistory: Boolean;
//#UC START# *55E019130227_5087BD37023E_var*
//#UC END# *55E019130227_5087BD37023E_var*
begin
//#UC START# *55E019130227_5087BD37023E_impl*
 Result := f_Factory.CanSaveFormSetToHistory(Self);
//#UC END# *55E019130227_5087BD37023E_impl*
end;//TvcmFormSet.DoGetCanBeSavedToHistory

function TvcmFormSet.DoGetCanBeMain: Boolean;
//#UC START# *57EB9D32008D_5087BD37023E_var*
//#UC END# *57EB9D32008D_5087BD37023E_var*
begin
//#UC START# *57EB9D32008D_5087BD37023E_impl*
 Result := pm_GetFactory.CanFormsetBeMain;
//#UC END# *57EB9D32008D_5087BD37023E_impl*
end;//TvcmFormSet.DoGetCanBeMain

procedure TvcmFormSet.Refresh(const aParams: IvcmFormSetRefreshDataParams);
 {* обновляет представление сборки }
//#UC START# *4995750900DB_5087BD37023E_var*
//#UC END# *4995750900DB_5087BD37023E_var*
begin
//#UC START# *4995750900DB_5087BD37023E_impl*
 Assert(pm_GetDataSource <> nil, 'FormSetDataSource undefined!');
 if Assigned(f_Factory) then
  if pm_GetCanRefresh then
   f_Factory.Refresh(vcmMakeRefreshParams(aParams, pm_GetDataSource, Self))
  else
   RefreshStack.Add(aParams);
//#UC END# *4995750900DB_5087BD37023E_impl*
end;//TvcmFormSet.Refresh

procedure TvcmFormSet.SaveHistory;
 {* сохраняет сборку в историю }
//#UC START# *4995752D00BE_5087BD37023E_var*
//#UC END# *4995752D00BE_5087BD37023E_var*
begin
//#UC START# *4995752D00BE_5087BD37023E_impl*
 if Assigned(f_Factory) then
  f_Factory.SaveHistory(pm_GetContainer, false);
//#UC END# *4995752D00BE_5087BD37023E_impl*
end;//TvcmFormSet.SaveHistory

function TvcmFormSet.IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
 {* является ли форма главной в сборке }
//#UC START# *499575D60157_5087BD37023E_var*
//#UC END# *499575D60157_5087BD37023E_var*
begin
//#UC START# *499575D60157_5087BD37023E_impl*
 Result := pm_GetFactory.IsMainInFormSet(aForm);
//#UC END# *499575D60157_5087BD37023E_impl*
end;//TvcmFormSet.IsMainInFormSet

function TvcmFormSet.FindStatusInfoForm: IvcmEntityForm;
 {* найти форму отвечающую за вывод статуса }
//#UC START# *499575E601E5_5087BD37023E_var*
var
 l_Index : Integer;
 l_Form  : IvcmEntityForm;
//#UC END# *499575E601E5_5087BD37023E_var*
begin
//#UC START# *499575E601E5_5087BD37023E_impl*
 Result := nil;
 for l_Index := 0 to Pred(Get_EntitiesCount) do
  if Supports(Get_Entity(l_Index), IvcmEntityForm, l_Form) AND
     pm_GetFactory.IsDefaultStatusForm(l_Form) then
  begin
   Result := l_Form;
   break;
  end;//Supports..
//#UC END# *499575E601E5_5087BD37023E_impl*
end;//TvcmFormSet.FindStatusInfoForm

procedure TvcmFormSet.PopToHistory;
 {* сборка помещена в историю }
//#UC START# *499575F40009_5087BD37023E_var*
//#UC END# *499575F40009_5087BD37023E_var*
begin
//#UC START# *499575F40009_5087BD37023E_impl*
 f_CanRefresh := False;
 TvcmFormSetContainerRegistry.Instance.UnregisterFormSet(Self);
//#UC END# *499575F40009_5087BD37023E_impl*
end;//TvcmFormSet.PopToHistory

procedure TvcmFormSet.PushFromHistory;
 {* сборка выгружена из истории }
//#UC START# *499575FF0015_5087BD37023E_var*
//#UC END# *499575FF0015_5087BD37023E_var*
begin
//#UC START# *499575FF0015_5087BD37023E_impl*
 TvcmFormSetContainerRegistry.Instance.RegisterFormSet(Self, pm_GetContainer);
 f_CanRefresh := True;
 pm_GetDataSource.PushFromHistory;
//#UC END# *499575FF0015_5087BD37023E_impl*
end;//TvcmFormSet.PushFromHistory

function TvcmFormSet.pm_GetContainer: IvcmContainer;
//#UC START# *4995761C018F_5087BD37023Eget_var*
//#UC END# *4995761C018F_5087BD37023Eget_var*
begin
//#UC START# *4995761C018F_5087BD37023Eget_impl*
 Result := IvcmContainer(f_Container);
//#UC END# *4995761C018F_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetContainer

procedure TvcmFormSet.pm_SetContainer(const aValue: IvcmContainer);
//#UC START# *4995761C018F_5087BD37023Eset_var*
//#UC END# *4995761C018F_5087BD37023Eset_var*
begin
//#UC START# *4995761C018F_5087BD37023Eset_impl*
 f_Container := Pointer(aValue);
 TvcmFormSetContainerRegistry.Instance.RegisterFormSet(Self, aValue);
//#UC END# *4995761C018F_5087BD37023Eset_impl*
end;//TvcmFormSet.pm_SetContainer

function TvcmFormSet.pm_GetFactory: IvcmFormSetFactory;
//#UC START# *4995762F039E_5087BD37023Eget_var*
//#UC END# *4995762F039E_5087BD37023Eget_var*
begin
//#UC START# *4995762F039E_5087BD37023Eget_impl*
 Result := f_Factory;
//#UC END# *4995762F039E_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetFactory

procedure TvcmFormSet.pm_SetFactory(const aValue: IvcmFormSetFactory);
//#UC START# *4995762F039E_5087BD37023Eset_var*
//#UC END# *4995762F039E_5087BD37023Eset_var*
begin
//#UC START# *4995762F039E_5087BD37023Eset_impl*
 f_Factory := aValue;
//#UC END# *4995762F039E_5087BD37023Eset_impl*
end;//TvcmFormSet.pm_SetFactory

function TvcmFormSet.pm_GetCanRefresh: Boolean;
//#UC START# *4995764602B6_5087BD37023Eget_var*
//#UC END# *4995764602B6_5087BD37023Eget_var*
begin
//#UC START# *4995764602B6_5087BD37023Eget_impl*
 Result := f_CanRefresh;
//#UC END# *4995764602B6_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetCanRefresh

function TvcmFormSet.pm_GetDataSource: IvcmFormSetDataSource;
//#UC START# *49957658008F_5087BD37023Eget_var*
//#UC END# *49957658008F_5087BD37023Eget_var*
begin
//#UC START# *49957658008F_5087BD37023Eget_impl*
 Result := IvcmFormSetDataSource(f_DataSource);
//#UC END# *49957658008F_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetDataSource

procedure TvcmFormSet.pm_SetDataSource(const aValue: IvcmFormSetDataSource);
//#UC START# *49957658008F_5087BD37023Eset_var*
//#UC END# *49957658008F_5087BD37023Eset_var*
begin
//#UC START# *49957658008F_5087BD37023Eset_impl*
 Assert(f_DataSource = 0, 'FormSetDataSource already exists!');
 f_DataSource := Integer(aValue);
//#UC END# *49957658008F_5087BD37023Eset_impl*
end;//TvcmFormSet.pm_SetDataSource

procedure TvcmFormSet.AssignFormList(aFormList: TvcmFormSetFormList);
 {* Заполнить мапу форм / флажков в сборке }
//#UC START# *528DA6D00396_5087BD37023E_var*
//#UC END# *528DA6D00396_5087BD37023E_var*
begin
//#UC START# *528DA6D00396_5087BD37023E_impl*
 Assert(aFormList <> nil);
 Forms.Assign(aFormList);
 FormListAssigned;
//#UC END# *528DA6D00396_5087BD37023E_impl*
end;//TvcmFormSet.AssignFormList

function TvcmFormSet.GetFormNeedMakeDS(const aFormDescr: TvcmFormSetFormItemDescr): TvcmNeedMakeDS;
//#UC START# *528DAD93029F_5087BD37023E_var*
//#UC END# *528DAD93029F_5087BD37023E_var*
begin
//#UC START# *528DAD93029F_5087BD37023E_impl*
 Result := Forms.NeedMakeDS[aFormDescr];
//#UC END# *528DAD93029F_5087BD37023E_impl*
end;//TvcmFormSet.GetFormNeedMakeDS

procedure TvcmFormSet.SetFormNeedMakeDS(const aFormDescr: TvcmFormSetFormItemDescr;
 aNeedMakeDS: TvcmNeedMakeDS);
//#UC START# *528DB1F80281_5087BD37023E_var*
//#UC END# *528DB1F80281_5087BD37023E_var*
begin
//#UC START# *528DB1F80281_5087BD37023E_impl*
 Forms.NeedMakeDS[aFormDescr] := aNeedMakeDS;
//#UC END# *528DB1F80281_5087BD37023E_impl*
end;//TvcmFormSet.SetFormNeedMakeDS

function TvcmFormSet.CastFS(const aGUID: TGUID;
 out theObj): Boolean;
//#UC START# *529D991A02D3_5087BD37023E_var*
//#UC END# *529D991A02D3_5087BD37023E_var*
begin
//#UC START# *529D991A02D3_5087BD37023E_impl*
 Result := Supports(Self, aGUID, theObj);
//#UC END# *529D991A02D3_5087BD37023E_impl*
end;//TvcmFormSet.CastFS

procedure TvcmFormSet.SetFormClosed(const aForm: IvcmEntityForm);
 {* Установить признак того, что форма была закрыта }
//#UC START# *52A56B30012F_5087BD37023E_var*
//#UC END# *52A56B30012F_5087BD37023E_var*
begin
//#UC START# *52A56B30012F_5087BD37023E_impl*
 SetFormNeedMakeDS(aForm.KeyInFormSet, vcm_nmNo);
//#UC END# *52A56B30012F_5087BD37023E_impl*
end;//TvcmFormSet.SetFormClosed

procedure TvcmFormSet.SetIfNeedMakeNo(const aFormDescr: TvcmFormSetFormItemDescr;
 aNeedMake: TvcmNeedMakeDS);
//#UC START# *52E8E6420272_5087BD37023E_var*
//#UC END# *52E8E6420272_5087BD37023E_var*
begin
//#UC START# *52E8E6420272_5087BD37023E_impl*
 Forms.SetIfNeedMakeNo(aFormDescr, aNeedmake);
//#UC END# *52E8E6420272_5087BD37023E_impl*
end;//TvcmFormSet.SetIfNeedMakeNo

procedure TvcmFormSet.SaveFormList(aFormList: TvcmFormSetFormList);
//#UC START# *52EF7041000D_5087BD37023E_var*
//#UC END# *52EF7041000D_5087BD37023E_var*
begin
//#UC START# *52EF7041000D_5087BD37023E_impl*
 Assert(aFormList <> nil);
 aFormList.Assign(Forms);
//#UC END# *52EF7041000D_5087BD37023E_impl*
end;//TvcmFormSet.SaveFormList

function TvcmFormSet.pm_GetFormSetImageIndex: Integer;
//#UC START# *53B3B3C60264_5087BD37023Eget_var*
//#UC END# *53B3B3C60264_5087BD37023Eget_var*
begin
//#UC START# *53B3B3C60264_5087BD37023Eget_impl*
 if (f_DataSource <> 0) then
  Result := pm_GetDataSource.FormSetImageIndex
 else
  Result := -1;
//#UC END# *53B3B3C60264_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetFormSetImageIndex

function TvcmFormSet.pm_GetFormSetCaption: IvcmCString;
//#UC START# *54B350C10230_5087BD37023Eget_var*
//#UC END# *54B350C10230_5087BD37023Eget_var*
begin
//#UC START# *54B350C10230_5087BD37023Eget_impl*
 Result := DoGetFormSetCaption;
//#UC END# *54B350C10230_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetFormSetCaption

function TvcmFormSet.pm_GetFormSetTabCaption: IvcmCString;
//#UC START# *54B350DD005E_5087BD37023Eget_var*
//#UC END# *54B350DD005E_5087BD37023Eget_var*
begin
//#UC START# *54B350DD005E_5087BD37023Eget_impl*
 Result := DoGetFormSetTabCaption;
//#UC END# *54B350DD005E_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetFormSetTabCaption

function TvcmFormSet.pm_GetFormSetTabHint: IvcmCString;
//#UC START# *54B350EC00E5_5087BD37023Eget_var*
//#UC END# *54B350EC00E5_5087BD37023Eget_var*
begin
//#UC START# *54B350EC00E5_5087BD37023Eget_impl*
 Result := DoGetFormSetTabHint;
//#UC END# *54B350EC00E5_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetFormSetTabHint

function TvcmFormSet.MakeClone(const aContainer: IvcmContainer): IvcmFormSet;
//#UC START# *555B21DA0384_5087BD37023E_var*
//#UC END# *555B21DA0384_5087BD37023E_var*
begin
//#UC START# *555B21DA0384_5087BD37023E_impl*
 Result := pm_GetFactory.CloneFormSet(Self, aContainer);
//#UC END# *555B21DA0384_5087BD37023E_impl*
end;//TvcmFormSet.MakeClone

function TvcmFormSet.pm_GetCanBeCloned: Boolean;
//#UC START# *555D5CF4019C_5087BD37023Eget_var*
//#UC END# *555D5CF4019C_5087BD37023Eget_var*
begin
//#UC START# *555D5CF4019C_5087BD37023Eget_impl*
 Result := DoGetCanBeCloned;
//#UC END# *555D5CF4019C_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetCanBeCloned

function TvcmFormSet.pm_GetCanBeSavedToHistory: Boolean;
//#UC START# *55E012ED0134_5087BD37023Eget_var*
//#UC END# *55E012ED0134_5087BD37023Eget_var*
begin
//#UC START# *55E012ED0134_5087BD37023Eget_impl*
 Result := DoGetCanBeSavedToHistory;
//#UC END# *55E012ED0134_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetCanBeSavedToHistory

function TvcmFormSet.pm_GetCanBeMain: Boolean;
//#UC START# *57EB9AFB026D_5087BD37023Eget_var*
//#UC END# *57EB9AFB026D_5087BD37023Eget_var*
begin
//#UC START# *57EB9AFB026D_5087BD37023Eget_impl*
 Result := DoGetCanBeMain;
//#UC END# *57EB9AFB026D_5087BD37023Eget_impl*
end;//TvcmFormSet.pm_GetCanBeMain

procedure TvcmFormSet.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5087BD37023E_var*
//#UC END# *479731C50290_5087BD37023E_var*
begin
//#UC START# *479731C50290_5087BD37023E_impl*
 f_DataSource := 0;
 FreeAndNil(f_RefreshStack);
 f_Factory := nil;
 f_Container := nil;
 FreeAndNil(f_Forms);
 TvcmFormSetContainerRegistry.Instance.UnregisterFormSet(Self);
 inherited;
//#UC END# *479731C50290_5087BD37023E_impl*
end;//TvcmFormSet.Cleanup
{$IfEnd} // NOT Defined(NoVCM)

end.
