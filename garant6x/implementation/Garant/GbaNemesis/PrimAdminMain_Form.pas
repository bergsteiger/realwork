unit PrimAdminMain_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/PrimAdminMain_Form.pas"
// Начат: 07.09.2009 18:30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> F1 Администратор::Admin$Shell::AdminApp::PrimAdminMain
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  PrimMainOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimAdminMain_utEmptyMainWindow_UserType,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 _AdminAndMonitoringsMainForm_Parent_ = TPrimMainOptionsForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas}
 TPrimAdminMainForm = {form} class(_AdminAndMonitoringsMainForm_)
 protected
  procedure MakeControls; override;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
     {* Инициализация формы. Для перекрытия в потомках }
   {$IfEnd} //not NoVCM
 end;//TPrimAdminMainForm

 TvcmMainFormRef = TPrimAdminMainForm;
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
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
{$IfEnd} //Admin

{$If defined(Admin)}

type _Instance_R_ = TPrimAdminMainForm;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\AdminAndMonitoringsMainForm.imp.pas}

var
   { Локализуемые строки utEmptyMainWindowLocalConstants }
  str_utEmptyMainWindowCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowCaption'; rValue : 'Главное окно');
   { Заголовок пользовательского типа "Главное окно" }
  str_utEmptyMainWindowSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utEmptyMainWindowSettingsCaption'; rValue : 'Главная панель инструментов');
   { Заголовок пользовательского типа "Главное окно" для настройки панелей инструментов }

// start class TPrimAdminMainForm

{$If not defined(NoVCM)}
procedure TPrimAdminMainForm.DoInit(aFromHistory: Boolean);
//#UC START# *49803F5503AA_4AA518EB039C_var*
//#UC END# *49803F5503AA_4AA518EB039C_var*
begin
//#UC START# *49803F5503AA_4AA518EB039C_impl*
 inherited;
 TdmStdRes.OpenUserList(Self);
//#UC END# *49803F5503AA_4AA518EB039C_impl*
end;//TPrimAdminMainForm.DoInit
{$IfEnd} //not NoVCM

procedure TPrimAdminMainForm.MakeControls;
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

{$IfEnd} //Admin

initialization
{$If defined(Admin)}
// Инициализация str_utEmptyMainWindowCaption
 str_utEmptyMainWindowCaption.Init;
{$IfEnd} //Admin
{$If defined(Admin)}
// Инициализация str_utEmptyMainWindowSettingsCaption
 str_utEmptyMainWindowSettingsCaption.Init;
{$IfEnd} //Admin
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация PrimAdminMain
 TtfwClassRef.Register(TPrimAdminMainForm);
{$IfEnd} //Admin AND not NoScripts

end.