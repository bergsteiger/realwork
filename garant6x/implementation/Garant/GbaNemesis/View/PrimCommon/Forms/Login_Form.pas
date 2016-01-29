unit Login_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/Login_Form.pas"
// Начат: 21.08.2009 20:15
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::PrimCommon::Login
//
// Вход в систему ГАРАНТ
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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
  PrimLogin_Form,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  Login_ut_Login_UserType,
  vtGroupBox,
  vtLabel
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If defined(Nemesis)}
  ,
  nscComboBoxWithReadOnly
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtFocusLabel,
  vtCheckBox,
  ElPopBtn,
  vtPanel,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;

const
    { LoginIDs }
   fm_LoginForm : TvcmFormDescriptor = (rFormID : (rName : 'LoginForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TLoginForm }

type
 LoginFormDef = interface(IUnknown)
  {* Идентификатор формы Login }
   ['{96B4FBEB-A42A-4990-BCED-2F439F4E152A}']
 end;//LoginFormDef

  TLoginForm = {final form} class(TPrimLoginForm, LoginFormDef)
   {* Вход в систему ГАРАНТ }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TLoginForm

implementation

{$R *.DFM}

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  LoginKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;

var
    { Локализуемые строки ut_LoginLocalConstants }
   str_ut_LoginCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LoginCaption'; rValue : 'Вход в систему ГАРАНТ');
    { Заголовок пользовательского типа "Вход в систему ГАРАНТ" }

// start class TLoginForm

procedure TLoginForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_LoginName,
  str_ut_LoginCaption,
  str_ut_LoginCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_LoginName
end;

initialization
{$If not defined(NoScripts)}
// Регистрация Login
 TtfwClassRef.Register(TLoginForm);
{$IfEnd} //not NoScripts
// Регистрация фабрики формы Login
 fm_LoginForm.SetFactory(TLoginForm.Make);
// Инициализация str_ut_LoginCaption
 str_ut_LoginCaption.Init;

end.