unit MonitoringsMain_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/MonitoringsMain_Form.pas"
// �����: 10.09.2009 17:48
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> F1 ������� �����::Monitoring::Monitorings::MonitoringsMain
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Monitorings) AND not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  PrimMonitoringsMain_Form,
  MainPrim_Form
  {$If defined(Nemesis)}
  ,
  nscStatusBar
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  vtProportionalPanel,
  vtSizeablePanel
  {$If defined(Nemesis)}
  ,
  nscNavigator
  {$IfEnd} //Nemesis
  ,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Monitorings AND not Admin

{$If defined(Monitorings) AND not defined(Admin)}
const
   { MonitoringsMainIDs }
  fm_MonitoringsMainForm : TvcmFormDescriptor = (rFormID : (rName : 'MonitoringsMainForm'; rID : 0); rFactory : nil);
   { ������������� ����� TMonitoringsMainForm }

type
 MonitoringsMainFormDef = interface(IUnknown)
  {* ������������� ����� MonitoringsMain }
   ['{302D255D-E242-47AD-ACB5-B3822A5E3F7F}']
 end;//MonitoringsMainFormDef

 TMonitoringsMainForm = {final form} class(TPrimMonitoringsMainForm, MonitoringsMainFormDef)
  Entities : TvcmEntities;
 end;//TMonitoringsMainForm
{$IfEnd} //Monitorings AND not Admin

implementation

{$R *.DFM}

{$If defined(Monitorings) AND not defined(Admin)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
  ,
  MonitoringsMainKeywordsPack
  {$IfEnd} //Monitorings AND not Admin AND not NoScripts
  
  ;
{$IfEnd} //Monitorings AND not Admin

{$If defined(Monitorings) AND not defined(Admin)}


{$IfEnd} //Monitorings AND not Admin

initialization
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// ����������� MonitoringsMain
 TtfwClassRef.Register(TMonitoringsMainForm);
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin)}
// ����������� ������� ����� MonitoringsMain
 fm_MonitoringsMainForm.SetFactory(TMonitoringsMainForm.Make);
{$IfEnd} //Monitorings AND not Admin

end.