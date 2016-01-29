unit vcmFormSetFactory;

interface

uses
 l3IntfUses
 , vcmFormSetFactoryPrim
 , vcmInterfaces
 , l3Interfaces
 , vcmFormSetRefreshParamsList
 , vcmFormSetFormsCollection
 , vcmFormSetFormItemList
 , vcmFormSetFormsCollectionItem
 , vcmFormSetFormsCollectionItemPrim
 , vcmFormSetFormsCollectionItemModelPart
 , vcmUserControls
 , vcmBaseTypes
 , vcmFormSet
 , vcmExternalInterfaces
;

type
 TsfsOnGetMainCaption = procedure(aSender: TObject;
  const aDataSource: IvcmFormSetDataSource;
  var aCaption: Il3CString) of object;
 
 TsfsOnGetMainImageIndex = procedure(aSender: TObject;
  const aDataSource: IvcmFormSetDataSource;
  var aImageIndex: Integer) of object;
 
 RvcmFormSetFactory = class of TvcmFormSetFactory;
 
 TvcmFormSetFactory = class(TvcmFormSetFactoryPrim, IvcmFormSetFactory)
  function MakeFormSet(const aDataSource: IvcmFormSetDataSource;
   const aContainer: IvcmContainer;
   aSaveToHistory: Boolean;
   aLockSetFocusToMainObjectForm: Boolean;
   const aFormSetToClone: IvcmFormSet): IvcmFormSet;
   {* ������� ������ }
  function FormSetItem(aItem: TvcmFormSetFormsCollectionItemPrim): TvcmFormSetFormsCollectionItem;
  function IsOwnerItem(aItem: TvcmFormSetFormsCollectionItem): Boolean;
   {* ���������� ��������� �� ������� �����-����������� ������ }
  procedure SaveToHistoryClosedForm(const aHistory: IvcmHistory;
   aItem: TvcmFormSetFormsCollectionItem;
   aSubUserType: Integer);
   {* ��������� �������� ����� � ������� }
  function IsLikeFormSet(const aDataSource: IvcmFormSetDataSource;
   const aContainer: IvcmContainer): Boolean;
   {* ���������� �������� �� ������ � ������ ������ � ���� �� }
  function IsFormSetExists(const aContainer: IvcmContainer;
   out aFormSet: IvcmFormSet): Boolean;
  procedure Create;
  function Id: TvcmFormSetID;
  procedure Make(const aDataSource: IvcmFormSetDataSource;
   const aContainer: IvcmContainer;
   aSaveToHistory: Boolean;
   aLockSetFocusToMainObjectForm: Boolean); overload;
  function AddZone(const aName: AnsiString;
   aZoneType: TvcmZoneType;
   const aFormDescriptor: TvcmFormDescriptor): TvcmFormSetFormsCollectionItemModelPart; overload;
  function AddZone(const aName: AnsiString;
   aZoneType: TvcmZoneType;
   const aFormDescriptor: TvcmFormDescriptor;
   aUserType: TvcmUserType;
   aNeedMakeDS: TvcmNeedMakeDS): TvcmFormSetFormsCollectionItemModelPart; overload;
  function GetFormSetImplementation: RvcmFormSet;
   {* ���������� ����� ���������� ������ }
  procedure InitForms(const aParams: IvcmFormSetRefreshParams);
   {* ���������� ��� �������� ������ ����� Refresh ��� ������������� ������ ������� �� ������. }
  function DoMakeFormSetCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
  function DoMakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
  function DoMakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString;
  procedure Make(const aDataSource: IvcmFormSetDataSource;
   const aContainer: IvcmContainer;
   out aFormSet: IvcmFormSet;
   aSaveToHistory: Boolean;
   aLockSetFocusToMainObjectForm: Boolean;
   const aFormSetToClone: IvcmFormSet); overload;
  function DoGetCanCloneFormSet(const aFormSet: IvcmFormSet): Boolean;
  function DoGetCanSaveFormSetToHistory(const aFormSet: IvcmFormSet): Boolean;
  function FormSetId: PvcmFormSetID;
   {* ������������� ������, ��� ������ ��������� ��� �������� ������ }
  procedure Refresh(const aParams: IvcmFormSetRefreshParams);
   {* ��������� ������ ������.
            aDataForHistory - ������ aDataSource, ������� ���������� ���������
                              � ������� }
  procedure SaveHistory(const aContainer: IvcmContainer;
   aNeedSaveUseCaseData: Boolean);
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* �������� �� ����� ������� � ������ }
  function IsDefaultStatusForm(const aForm: IvcmEntityForm): Boolean;
   {* �������� �� ����� ���������� �� ����� ������� }
  function MakeMainCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
  function MakeMainImageIndex(const aDataSource: IvcmFormSetDataSource): Integer;
  function MakeFormSetCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
  function MakeFormSetTabCaption(const aDataSource: IvcmFormSetDataSource): IvcmCString;
  function MakeFormSetTabHint(const aDataSource: IvcmFormSetDataSource): IvcmCString;
  function CloneFormSet(const aFormSet: IvcmFormSet;
   const aContainer: IvcmContainer): IvcmFormSet;
  function GetSimpleFactory: IvcmFormSetSimpleFactory;
  function CanCloneFormSet(const aFormSet: IvcmFormSet): Boolean;
  function CanSaveFormSetToHistory(const aFormSet: IvcmFormSet): Boolean;
 end;//TvcmFormSetFactory
 
implementation

uses
 l3ImplUses
 , vcmFormSetDataSource
 , vcmFormSetRefreshParams
 , l3Base
 , SysUtils
 , vcmHistory
 , Classes
 , vcmEntityForm
 , vcmBase
 , vcmHistoryService
 , vcmFormSetFactoryFacade
 , vcmFormDataSourceList
 , vcmZoneTypeList
;

end.
