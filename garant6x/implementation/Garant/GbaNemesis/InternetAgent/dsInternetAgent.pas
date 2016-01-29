unit dsInternetAgent;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "InternetAgent"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/InternetAgent/dsInternetAgent.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 ���������� ��������::InternetAgent::InternetAgent::InternetAgent::TdsInternetAgent
//
// ���������� ������� ������ ��������-������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Interfaces,
  InternetAgentInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmLocalInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObjectWithCOMQI,
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsInternetAgent;
 _InitDataType_ = Il3CString;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 TdsInternetAgent = {final vac} class(_vcmFormDataSource_, IdsInternetAgent)
  {* ���������� ������� ������ ��������-������ }
 protected
 // realized methods
   function Get_URL: WideString;
 end;//TdsInternetAgent
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3String,
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsInternetAgent;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

// start class TdsInternetAgent

function TdsInternetAgent.Get_URL: WideString;
//#UC START# *49EDE45A02EB_49ECA9AA0000get_var*
//#UC END# *49EDE45A02EB_49ECA9AA0000get_var*
begin
//#UC START# *49EDE45A02EB_49ECA9AA0000get_impl*
 Result := l3WideString(PartData);
//#UC END# *49EDE45A02EB_49ECA9AA0000get_impl*
end;//TdsInternetAgent.Get_URL

{$IfEnd} //not Admin AND not Monitorings

end.