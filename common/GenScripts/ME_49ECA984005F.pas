unit sdsInternetAgent;
 {* ���������� ���������� ��������-������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\InternetAgent\sdsInternetAgent.pas"
// ���������: "UseCaseControllerImp"
// ������� ������: "TsdsInternetAgent" MUID: (49ECA984005F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , InternetAgentInterfaces
 , l3Interfaces
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
 , l3NotifyPtrList
;

type
 _InitDataType_ = Il3CString;
 _SetType_ = IsdsInternetAgent;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}
 TsdsInternetAgent = class(_vcmFormSetDataSourceWithoutData_, IsdsInternetAgent)
  {* ���������� ���������� ��������-������ }
  private
   f_MainViewArea: IvcmViewAreaControllerRef;
    {* ���� ��� ������� ������ MainViewArea }
  protected
   function pm_GetMainViewArea: IdsInternetAgent;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* ������� ������ �� ������� ����� }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
 end;//TsdsInternetAgent
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsInternetAgent
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , SysUtils
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TsdsInternetAgent;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSourceWithoutData.imp.pas}

function TsdsInternetAgent.pm_GetMainViewArea: IdsInternetAgent;
//#UC START# *4A37A70E01DE_49ECA984005Fget_var*
//#UC END# *4A37A70E01DE_49ECA984005Fget_var*
begin
//#UC START# *4A37A70E01DE_49ECA984005Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A37A70E01DE_49ECA984005Fget_impl*
end;//TsdsInternetAgent.pm_GetMainViewArea

procedure TsdsInternetAgent.ClearAreas;
 {* ������� ������ �� ������� ����� }
//#UC START# *4938F7E702B7_49ECA984005F_var*
//#UC END# *4938F7E702B7_49ECA984005F_var*
begin
//#UC START# *4938F7E702B7_49ECA984005F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_49ECA984005F_impl*
end;//TsdsInternetAgent.ClearAreas

procedure TsdsInternetAgent.ClearFields;
begin
 f_MainViewArea := nil;
 inherited;
end;//TsdsInternetAgent.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
