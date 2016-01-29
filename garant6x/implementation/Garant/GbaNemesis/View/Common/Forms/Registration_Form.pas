unit Registration_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/Registration_Form.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Core::Common::View::Common::PrimF1Common::RegistrationForm
//
// Регистрация
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  PrimRegistration_Form,
  RegistrationForm_ut_RegistrationForm_UserType,
  vtPanel,
  vtLabel
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtCheckBox,
  vtGroupBox
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  ElPopBtn,
  vtFocusLabel,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
    { RegistrationFormIDs }
   fm_nsRegistrationForm : TvcmFormDescriptor = (rFormID : (rName : 'nsRegistrationForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TnsRegistrationForm }

type
 RegistrationFormFormDef = interface(IUnknown)
  {* Идентификатор формы RegistrationForm }
   ['{1C7CFA67-8415-4312-BA10-BF18AAF522CF}']
 end;//RegistrationFormFormDef

  TnsRegistrationForm = {final form} class(TPrimRegistrationForm, RegistrationFormFormDef)
   {* Регистрация }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TnsRegistrationForm

  TRegistrationForm = TnsRegistrationForm;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$R *.DFM}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  RegistrationFormKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
    { Локализуемые строки ut_RegistrationFormLocalConstants }
   str_ut_RegistrationFormCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_RegistrationFormCaption'; rValue : 'Регистрация');
    { Заголовок пользовательского типа "Регистрация" }

// start class TnsRegistrationForm

procedure TnsRegistrationForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_RegistrationFormName,
  str_ut_RegistrationFormCaption,
  str_ut_RegistrationFormCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_RegistrationFormName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация RegistrationForm
 TtfwClassRef.Register(TnsRegistrationForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ut_RegistrationFormCaption
 str_ut_RegistrationFormCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.