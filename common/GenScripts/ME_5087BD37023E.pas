unit vcmFormSet;

interface

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
  function Make(const aContainer: IvcmContainer;
   const aFactory: IvcmFormSetFactory): IvcmFormSet;
  procedure Create(const aContainer: IvcmContainer;
   const aFactory: IvcmFormSetFactory);
  procedure FormListAssigned;
  function DoGetFormSetCaption: IvcmCString;
  function DoGetFormSetTabCaption: IvcmCString;
  function DoGetFormSetTabHint: IvcmCString;
  function DoGetCanBeCloned: Boolean;
  function DoGetCanBeSavedToHistory: Boolean;
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
  function Container: IvcmContainer;
  function Factory: IvcmFormSetFactory;
  function CanRefresh: Boolean;
   {* после помещения удаляемой сборки в историю обновлять ее нельзя }
  function DataSource: IvcmFormSetDataSource;
   {* бизнес объект прецедента }
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
  function FormSetImageIndex: Integer;
  function FormSetCaption: IvcmCString;
  function FormSetTabCaption: IvcmCString;
  function FormSetTabHint: IvcmCString;
  function MakeClone(const aContainer: IvcmContainer): IvcmFormSet;
  function CanBeCloned: Boolean;
  function CanBeSavedToHistory: Boolean;
 end;//TvcmFormSet
 
implementation

uses
 l3ImplUses
 , SysUtils
 , vcmFormSetRefreshParams
 , vcmFormSetContainerRegistry
;

end.
