unit sdsQuery;
 {* ������ ������ ���������� "��������� ������" }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Consultation\sdsQuery.pas"
// ���������: "UseCaseControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ConsultationInterfaces
 , QueryCardInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObjectWithCOMQI
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Interfaces
 , l3NotifyPtrList
 , dsQuery
;

type
 TdsQueryClass = class of TdsQuery;

 _InitDataType_ = IdeQuery;
 _SetType_ = IsdsQuery;
 {$Include vcmFormSetDataSourceWithoutData.imp.pas}
 TsdsQuery = {final} class(_vcmFormSetDataSourceWithoutData_, IsdsQuery)
  {* ������ ������ ���������� "��������� ������" }
  private
   f_dsQuery: IvcmViewAreaControllerRef;
    {* ���� ��� ������� ������ dsQuery }
   f_dsSaveLoad: IvcmViewAreaControllerRef;
    {* ���� ��� ������� ������ dsSaveLoad }
  protected
   function GetQueryClass: TdsQueryClass; virtual;
   function pm_GetdsQuery: IdsQuery;
   function pm_GetdsSaveLoad: IdsSaveLoad;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* ������� ������ �� ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsQuery
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsSaveLoad
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , SysUtils
;

type _Instance_R_ = TsdsQuery;

{$Include vcmFormSetDataSourceWithoutData.imp.pas}

function TsdsQuery.GetQueryClass: TdsQueryClass;
//#UC START# *492FEE0000FD_492FECE300EA_var*
//#UC END# *492FEE0000FD_492FECE300EA_var*
begin
//#UC START# *492FEE0000FD_492FECE300EA_impl*
 Result := TdsQuery;
//#UC END# *492FEE0000FD_492FECE300EA_impl*
end;//TsdsQuery.GetQueryClass

function TsdsQuery.pm_GetdsQuery: IdsQuery;
//#UC START# *492F006F00BE_492FECE300EAget_var*
//#UC END# *492F006F00BE_492FECE300EAget_var*
begin
//#UC START# *492F006F00BE_492FECE300EAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *492F006F00BE_492FECE300EAget_impl*
end;//TsdsQuery.pm_GetdsQuery

function TsdsQuery.pm_GetdsSaveLoad: IdsSaveLoad;
//#UC START# *492F00890059_492FECE300EAget_var*
//#UC END# *492F00890059_492FECE300EAget_var*
begin
//#UC START# *492F00890059_492FECE300EAget_impl*
 !!! Needs to be implemented !!!
//#UC END# *492F00890059_492FECE300EAget_impl*
end;//TsdsQuery.pm_GetdsSaveLoad

{$If NOT Defined(NoVCM)}
procedure TsdsQuery.ClearAreas;
 {* ������� ������ �� ������� ����� }
//#UC START# *4938F7E702B7_492FECE300EA_var*
//#UC END# *4938F7E702B7_492FECE300EA_var*
begin
//#UC START# *4938F7E702B7_492FECE300EA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_492FECE300EA_impl*
end;//TsdsQuery.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
