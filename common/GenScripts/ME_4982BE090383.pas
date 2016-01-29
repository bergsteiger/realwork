unit vcmControllers;

interface

uses
 l3IntfUses
 , vcmBaseTypes
 , vcmInterfaces
;

type
 TvcmNeedMakeDS = vcmBaseTypes.TvcmNeedMakeDS;
  {* ������������ ��� ������������ ������������� �������� ��� }
 
 IvcmFormDataSourceRef = interface
  {* ������������� ������ �� ������ ������ �����. }
  procedure Clear;
   {* ���������� ������ �� _DataSource � NeedMake ������������� ��� vcm_nmNo }
  procedure SetIfNeedMakeNo(aValue: TvcmNeedMakeDS);
   {* ������������� ���� ���� ��� �������� vcm_nmNo }
  procedure Assign(const aSource: IvcmFormDataSourceRef);
   {* ����������� ������ aSource }
 end;//IvcmFormDataSourceRef
 
 IvcmViewAreaControllerRef = IvcmFormDataSourceRef;
 
 IvcmViewAreaController = IvcmFormDataSource;
  {* ������ �� IvcmFormDataSource. ��� ������������� � �������������� ����. � ������ ���� ��������� ������, ���� ��������� IvcmFormDataSource }
 
 IvcmUseCaseController = IvcmFormSetDataSource;
  {* ������ �� IvcmFormSetDataSource. ��� ������������� � �������������� ����. � ������ ���� ��������� ������, ���� ��������� IvcmFormSetDataSource }
 
implementation

uses
 l3ImplUses
;

end.
