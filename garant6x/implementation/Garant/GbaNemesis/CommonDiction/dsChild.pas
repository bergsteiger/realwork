unit dsChild;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "CommonDiction"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/CommonDiction/dsChild.pas"
// �����: 11.03.2011 22:41
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 Core::Common::CommonDiction::CommonDiction::TdsChild
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
  CommonDictionInterfaces
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
  l3Interfaces,
  l3NotifyPtrList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _FormDataSourceType_ = IdsChild;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsChild = {final vac} class(_vcmFormDataSourcePrim_, IdsChild)
 end;//TdsChild
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsChild;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}


{$IfEnd} //not Admin AND not Monitorings
end.