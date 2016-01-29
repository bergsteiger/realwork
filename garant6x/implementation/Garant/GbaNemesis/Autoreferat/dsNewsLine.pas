unit dsNewsLine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Autoreferat"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Autoreferat/dsNewsLine.pas"
// �����: 28.11.2008 15:06
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 ���������������� �������::Autoreferat::Autoreferat::Autoreferat::TdsNewsLine
//
// ��������� �����
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
  AutoreferatInterfaces
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
 _FormDataSourceType_ = IdsNewsLine;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}
 TdsNewsLine = {vac} class(_vcmFormDataSourcePrim_, IdsNewsLine)
  {* ��������� ����� }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
    {$If not defined(NoVCM)}
   function GetIsDataAvailable: Boolean; override;
     {* ���������� �� ������ }
    {$IfEnd} //not NoVCM
 end;//TdsNewsLine
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter,
  l3InterfacesMisc,
  SysUtils,
  l3Base
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TdsNewsLine;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrim.imp.pas}

// start class TdsNewsLine

procedure TdsNewsLine.Cleanup;
//#UC START# *479731C50290_492FDE91018F_var*
//#UC END# *479731C50290_492FDE91018F_var*
begin
//#UC START# *479731C50290_492FDE91018F_impl*
 inherited;
//#UC END# *479731C50290_492FDE91018F_impl*
end;//TdsNewsLine.Cleanup

{$If not defined(NoVCM)}
function TdsNewsLine.GetIsDataAvailable: Boolean;
//#UC START# *55097FF5008E_492FDE91018F_var*
//#UC END# *55097FF5008E_492FDE91018F_var*
begin
//#UC START# *55097FF5008E_492FDE91018F_impl*
 Result := not defDataAdapter.AdministratorLogin and defDataAdapter.Monitoring.IsExist;
//#UC END# *55097FF5008E_492FDE91018F_impl*
end;//TdsNewsLine.GetIsDataAvailable
{$IfEnd} //not NoVCM

{$IfEnd} //not Admin AND not Monitorings

end.