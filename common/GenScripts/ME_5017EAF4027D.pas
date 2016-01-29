unit vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp;

interface

uses
 l3IntfUses
 , l3ProtoObjectWithCOMQI
 , vcmInterfaces
 , vcmLocalInterfaces
 , vcmExternalInterfaces
 , l3Interfaces
;

type
 // _UseCaseControllerType_
 
 // _FormDataSourceType_
 
 _vcmFormDataSourcePrimWithFlexUseCaseControllerType_ = class(Tl3ProtoObjectWithCOMQI, IvcmFormDataSource, IvcmFormSetDataSourceListener)
  function GetIsDataAvailable: Boolean;
   {* ���������� �� ������ }
  procedure Create(const aDataSource: _UseCaseControllerType_);
  function Make(const aDataSource: _UseCaseControllerType_): _FormDataSourceType_;
  procedure ClearRefs;
   {* ������� ������ �� ��������� ������������� ���������� }
  procedure FormSetDataChanged;
  function GetIsNeedChangePosition(const aDataSource: _FormDataSourceType_): Boolean;
  function GetIsSame(const aValue: _FormDataSourceType_): Boolean;
  procedure InitRefs(const aDS: IvcmFormSetDataSource);
   {* �������������� ������ �� ��������� ������������� ���������� }
  function MakeDisplayName: IvcmCString;
  procedure DataChanged;
   {* ������ ���������� }
  function IsSame(const aValue: IvcmFormDataSource): Boolean;
   {* �������� �� ��������� }
  function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
   {* �������� �� ����� ������� � ������ }
  function IsLikeViewAreaController(const aDataSource: IvcmFormDataSource): Boolean;
   {* ��������� ����� �� ������ ������� �� ������ }
  function UseCaseController: IvcmFormSetDataSource;
   {* ���������� ������ ����������. ��� ��������� ����� ������ �������, �� ��������� ������� �� ���������� ������ ������ (Refresh) }
  function CastUCC(const aGUID: TGUID;
   out theObj;
   NeedsException: Boolean): Boolean;
   {* �������� ���������� ���������� � ��������� ����������. ��� �����, ����� ��������� �� ������ ������ � ����������� ����������. [$122674504] }
  function DisplayName: IvcmCString;
   {* �������� ��������� ������ }
  function IsDataAvailable: Boolean;
   {* ���������� �� ������ � ������� ��������. ��������, �� ������� ����. }
 end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3InterfacesMisc
 , l3Base
;

end.
