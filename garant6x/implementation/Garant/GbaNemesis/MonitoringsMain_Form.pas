unit MonitoringsMain_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/MonitoringsMain_Form.pas"
// Начат: 10.09.2009 17:48
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> F1 Утилита Прайм::Monitoring::Monitorings::MonitoringsMain
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

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
   { Идентификатор формы TMonitoringsMainForm }

type
 MonitoringsMainFormDef = interface(IUnknown)
  {* Идентификатор формы MonitoringsMain }
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
// Регистрация MonitoringsMain
 TtfwClassRef.Register(TMonitoringsMainForm);
{$IfEnd} //Monitorings AND not Admin AND not NoScripts
{$If defined(Monitorings) AND not defined(Admin)}
// Регистрация фабрики формы MonitoringsMain
 fm_MonitoringsMainForm.SetFactory(TMonitoringsMainForm.Make);
{$IfEnd} //Monitorings AND not Admin

end.