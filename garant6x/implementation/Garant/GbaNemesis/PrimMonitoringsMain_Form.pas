unit PrimMonitoringsMain_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/PrimMonitoringsMain_Form.pas"
// Начат: 10.09.2009 19:19
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> F1 Утилита Прайм::Monitoring::Monitorings::PrimMonitoringsMain
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
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  ShellAndMonitoringsMain_Form,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimMonitoringsMain_utEmptyMainWindow_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Monitorings AND not Admin

{$If defined(Monitorings) AND not defined(Admin)}
type
 _AdminAndMonitoringsMainForm_Parent_ = TShellAndMonitoringsMainForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas}
 TPrimMonitoringsMainForm = {form} class(_AdminAndMonitoringsMainForm_)
 protected
  procedure MakeControls; override;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 end;//TPrimMonitoringsMainForm

 TvcmMainFormRef = TPrimMonitoringsMainForm;
{$IfEnd} //Monitorings AND not Admin

implementation

{$If defined(Monitorings) AND not defined(Admin)}
uses
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmSettings
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  ;
{$IfEnd} //Monitorings AND not Admin

{$If defined(Monitorings) AND not defined(Admin)}

type _Instance_R_ = TPrimMonitoringsMainForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas}

var
   { Локализуемые строки utEmptyMainWindowLocalConstants }
  str_utEmptyMainWindowCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowCaption'; rValue : 'Главное окно');
   { Заголовок пользовательского типа "Главное окно" }
  str_utEmptyMainWindowSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowSettingsCaption'; rValue : 'Главная панель инструментов');
   { Заголовок пользовательского типа "Главное окно" для настройки панелей инструментов }

// start class TPrimMonitoringsMainForm

{$If not defined(NoVCM)}
procedure TPrimMonitoringsMainForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4AA919040176_var*
//#UC END# *49803F5503AA_4AA919040176_var*
begin
//#UC START# *49803F5503AA_4AA919040176_impl*
 inherited;
 TdmStdRes.StartOpen(Self, False);
//#UC END# *49803F5503AA_4AA919040176_impl*
end;//TPrimMonitoringsMainForm.DoInit
{$IfEnd} //not NoVCM

procedure TPrimMonitoringsMainForm.MakeControls;
begin
 inherited;
 with AddUsertype(utEmptyMainWindowName,
  str_utEmptyMainWindowCaption,
  str_utEmptyMainWindowSettingsCaption,
  true,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(utEmptyMainWindowName
end;

{$IfEnd} //Monitorings AND not Admin

initialization
{$If defined(Monitorings) AND not defined(Admin)}
// Инициализация str_utEmptyMainWindowCaption
 str_utEmptyMainWindowCaption.Init;
{$IfEnd} //Monitorings AND not Admin
{$If defined(Monitorings) AND not defined(Admin)}
// Инициализация str_utEmptyMainWindowSettingsCaption
 str_utEmptyMainWindowSettingsCaption.Init;
{$IfEnd} //Monitorings AND not Admin
{$If defined(Monitorings) AND not defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimMonitoringsMain
 TtfwClassRef.Register(TPrimMonitoringsMainForm);
{$IfEnd} //Monitorings AND not Admin AND not NoScripts

end.