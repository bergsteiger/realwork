unit vcmFormSetDataSource.imp;

interface

uses
 l3IntfUses
 , l3ProtoObjectWithCOMQI
 , vcmInterfaces
 , vcmExternalInterfaces
 , l3Interfaces
;

type
 // _SetDataType_
 
 // _SetType_
 
 // _InitDataType_
 
 _vcmFormSetDataSource_ = class(Tl3ProtoObjectWithCOMQI, IvcmFormSetDataSource)
  {* ������ ������ ������ }
  function DoGetFormSetImageIndex: Integer;
  function DoGetTabCaption: IvcmCString;
  function DoGetTabHint: IvcmCString;
  function DoMakeClone: IvcmFormSetDataSource;
  function MakeWithSetData(const aSetData: _SetDataType_): IvcmFormSetDataSource;
  function GetDataForClone: _InitDataType_;
  function MakeData: _SetDataType_;
   {* ������ ������. }
  procedure DataExchange;
   {* - ���������� ����� ��������� ������ �������������. }
  procedure Create(const aData: _InitDataType_);
  function Make(const aData: _InitDataType_): _SetType_;
  function GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean;
  procedure DoPushFromHistory;
   {* ������ ���� ��������� �� ������� }
  procedure ClearRefs;
   {* ������� ������ �� ��������� ������ }
  procedure ClearAreas;
   {* ������� ������ �� ������� ����� }
  procedure BeginRefresh;
   {* ���������� ����� ������� ���������� }
  procedure EndRefresh;
   {* ���������� � ����� ���������� }
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* �������� �� ����� ������� � ������ }
  function IsLikeUseCaseController(const aDataSource: IvcmFormSetDataSource): Boolean;
   {* ��������� ����� �� ������������� ������ ��� ��� ������� � ������� �� ������ }
  function IsRefreshing: Boolean;
   {* ������ ��������� � ��������� ���������� }
  procedure PushFromHistory;
   {* ������ ���� ��������� �� ������� }
  procedure Refresh(const aParams: IvcmFormSetRefreshDataParams);
   {* �������� ������������� ������ }
  function FormSet: IvcmFormSet;
  function MainCaption: IvcmCString;
  function MainImageIndex: Integer;
  function InInit: Boolean;
   {* ���� ������� ��� ������ ���������� ������ }
  function DataForSave: IvcmData;
   {* ������ ����������� ������ ��������� ��������, ������ ��� �������� ������ ����� � ������������ ������� ������� ����������� }
  function FormSetImageIndex: Integer;
  function TabCaption: IvcmCString;
  function TabHint: IvcmCString;
  function MakeClone: IvcmFormSetDataSource;
  procedure PopToHistory;
 end;//_vcmFormSetDataSource_
 
implementation

uses
 l3ImplUses
 , vcmLocalInterfaces
 , l3Base
 , SysUtils
;

end.
