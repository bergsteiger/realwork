unit vcmControllers;
 {* ���������� ������������ }

// ������: "w:\common\components\gui\Garant\VCM\vcmControllers.pas"
// ���������: "Interfaces"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBaseTypes
 , vcmInterfaces
;

const
 {* ������ ��� �������� vcmBaseTypes.TvcmNeedMakeDS }
 vcm_nmForce = vcmBaseTypes.vcm_nmForce;
  {* ��������� �� ������ �� �� ��� }
 vcm_nmNo = vcmBaseTypes.vcm_nmNo;
  {* ������ ���������, �������� ������, ��� ����� ���� ������� ������������� � ��� ���������� ������ �� ��������� �� ����� }
 vcm_nmYes = vcmBaseTypes.vcm_nmYes;
  {* ��������� ��������� }

type
 TvcmNeedMakeDS = vcmBaseTypes.TvcmNeedMakeDS;
  {* ������������ ��� ������������ ������������� �������� ��� }

 IvcmFormDataSourceRef = interface
  {* ������������� ������ �� ������ ������ �����. }
  ['{F5C8B83F-1541-4055-A90B-32A85E5C3969}']
  function pm_GetIsEmpty: Boolean;
  function pm_GetCanBeClosed: Boolean;
  function pm_GetReferred: IvcmFormDataSource;
  procedure pm_SetReferred(const aValue: IvcmFormDataSource);
  function pm_GetNeedMake: TvcmNeedMakeDS;
  procedure pm_SetNeedMake(aValue: TvcmNeedMakeDS);
  procedure Clear;
   {* ���������� ������ �� _DataSource � NeedMake ������������� ��� vcm_nmNo }
  procedure SetIfNeedMakeNo(aValue: TvcmNeedMakeDS);
   {* ������������� ���� ���� ��� �������� vcm_nmNo }
  procedure Assign(const aSource: IvcmFormDataSourceRef);
   {* ����������� ������ aSource }
  property IsEmpty: Boolean
   read pm_GetIsEmpty;
   {* ���������� ������� ��������� ������. }
  property CanBeClosed: Boolean
   read pm_GetCanBeClosed;
   {* ����� �� ������� }
  property Referred: IvcmFormDataSource
   read pm_GetReferred
   write pm_SetReferred;
   {* ������ �� ���������� ������� ������ }
  property NeedMake: TvcmNeedMakeDS
   read pm_GetNeedMake
   write pm_SetNeedMake;
   {* ���������� ������������� �������� ��� }
 end;//IvcmFormDataSourceRef

 IvcmViewAreaControllerRef = IvcmFormDataSourceRef;

 IvcmViewAreaController = IvcmFormDataSource;
  {* ������ �� IvcmFormDataSource. ��� ������������� � �������������� ����. � ������ ���� ��������� ������, ���� ��������� IvcmFormDataSource }

 IvcmUseCaseController = IvcmFormSetDataSource;
  {* ������ �� IvcmFormSetDataSource. ��� ������������� � �������������� ����. � ������ ���� ��������� ������, ���� ��������� IvcmFormSetDataSource }
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(NoVCM)

end.
