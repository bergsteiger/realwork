unit ShellAndMonitoringsMain_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ShellAndMonitoringsMain_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::ShellAndMonitorings::ShellAndMonitoringsMain
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  PrimMainOptions_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
 TShellAndMonitoringsMainForm = {form} class(TPrimMainOptionsForm)
 end;//TShellAndMonitoringsMainForm

 TvcmMainFormRef = TShellAndMonitoringsMainForm;
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}


{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация ShellAndMonitoringsMain
 TtfwClassRef.Register(TShellAndMonitoringsMainForm);
{$IfEnd} //not Admin AND not NoScripts

end.