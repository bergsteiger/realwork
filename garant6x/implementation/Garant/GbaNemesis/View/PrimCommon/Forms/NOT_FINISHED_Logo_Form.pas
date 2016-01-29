unit NOT_FINISHED_Logo_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/NOT_FINISHED_Logo_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Базовые определения предметной области::F1 Application Template::View::PrimCommon::Logo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
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
  Logo_ut_Logo_UserType,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;

type
 TLogoForm = {final form} class(TvcmEntityForm)
  Entities : TvcmEntities;
 protected
  procedure MakeControls; override;
 end;//TLogoForm

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
  LogoKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;

var
   { Локализуемые строки ut_LogoLocalConstants }
  str_ut_LogoCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LogoCaption'; rValue : 'Logo');
   { Заголовок пользовательского типа "Logo" }

// start class TLogoForm

procedure TLogoForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_LogoName,
  str_ut_LogoCaption,
  str_ut_LogoCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_LogoName
end;

initialization
{$If not defined(NoScripts)}
// Регистрация Logo
 TtfwClassRef.Register(TLogoForm);
{$IfEnd} //not NoScripts
// Инициализация str_ut_LogoCaption
 str_ut_LogoCaption.Init;

end.