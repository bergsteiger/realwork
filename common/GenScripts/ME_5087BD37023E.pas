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
   {* ��������� ������������� ������ }
  procedure SaveHistory;
   {* ��������� ������ � ������� }
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* �������� �� ����� ������� � ������ }
  function FindStatusInfoForm: IvcmEntityForm;
   {* ����� ����� ���������� �� ����� ������� }
  procedure PopToHistory;
   {* ������ �������� � ������� }
  procedure PushFromHistory;
   {* ������ ��������� �� ������� }
  function Container: IvcmContainer;
  function Factory: IvcmFormSetFactory;
  function CanRefresh: Boolean;
   {* ����� ��������� ��������� ������ � ������� ��������� �� ������ }
  function DataSource: IvcmFormSetDataSource;
   {* ������ ������ ���������� }
  procedure AssignFormList(aFormList: TvcmFormSetFormList);
   {* ��������� ���� ���� / ������� � ������ }
  function GetFormNeedMakeDS(const aFormDescr: TvcmFormSetFormItemDescr): TvcmNeedMakeDS;
  procedure SetFormNeedMakeDS(const aFormDescr: TvcmFormSetFormItemDescr;
   aNeedMakeDS: TvcmNeedMakeDS);
  function CastFS(const aGUID: TGUID;
   out theObj): Boolean;
  procedure SetFormClosed(const aForm: IvcmEntityForm);
   {* ���������� ������� ����, ��� ����� ���� ������� }
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
