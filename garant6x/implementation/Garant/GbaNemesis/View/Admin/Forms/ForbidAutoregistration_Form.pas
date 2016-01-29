unit ForbidAutoregistration_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/ForbidAutoregistration_Form.pas"
// Начат: 07.09.2009 18:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Администратор::Admin::View::Admin::Admin::ForbidAutoregistration
//
// Запретить авторегистрацию
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
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  PrimForbidAutoregistrationOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  ForbidAutoregistration_ut_ForbidAutoregistration_UserType,
  vtLabel,
  vtGroupBox
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
const
    { ForbidAutoregistrationIDs }
   fm_efForbidAutoregistration : TvcmFormDescriptor = (rFormID : (rName : 'efForbidAutoregistration'; rID : 0); rFactory : nil);
    { Идентификатор формы TefForbidAutoregistration }

type
 ForbidAutoregistrationFormDef = interface(IUnknown)
  {* Идентификатор формы ForbidAutoregistration }
   ['{5D4153F1-D087-4AF8-A4ED-39411EB7A1A3}']
 end;//ForbidAutoregistrationFormDef

  TefForbidAutoregistration = {final form} class(TPrimForbidAutoregistrationOptionsForm, ForbidAutoregistrationFormDef)
   {* Запретить авторегистрацию }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TefForbidAutoregistration

  TForbidAutoregistrationForm = TefForbidAutoregistration;
{$IfEnd} //Admin

implementation

{$R *.DFM}

{$If defined(Admin)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If defined(Admin) AND not defined(NoScripts)}
  ,
  ForbidAutoregistrationKeywordsPack
  {$IfEnd} //Admin AND not NoScripts
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

var
    { Локализуемые строки ut_ForbidAutoregistrationLocalConstants }
   str_ut_ForbidAutoregistrationCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_ForbidAutoregistrationCaption'; rValue : 'Запретить авторегистрацию');
    { Заголовок пользовательского типа "Запретить авторегистрацию" }

// start class TefForbidAutoregistration

procedure TefForbidAutoregistration.MakeControls;
begin
 inherited;
 with AddUsertype(ut_ForbidAutoregistrationName,
  str_ut_ForbidAutoregistrationCaption,
  str_ut_ForbidAutoregistrationCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_ForbidAutoregistrationName
end;

{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация ForbidAutoregistration
 TtfwClassRef.Register(TefForbidAutoregistration);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin)}
// Инициализация str_ut_ForbidAutoregistrationCaption
 str_ut_ForbidAutoregistrationCaption.Init;
{$IfEnd} //Admin

end.