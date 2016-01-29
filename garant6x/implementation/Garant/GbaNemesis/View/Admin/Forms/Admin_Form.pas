unit Admin_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Тучнин Д.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/Admin_Form.pas"
// Начат: 2005/08/16 09:41:37
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Администратор::Admin::View::Admin::Admin::AdminForm
//
// Администрирование пользователей
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
  PrimAdminOptions_Form,
  Admin_FormDefinitions_Controls,
  vtProportionalPanel,
  vtSizeablePanel,
  vtPanel,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
  TcfAdminForm = {final form} class(TPrimAdminOptionsForm, AdminFormFormDef)
   {* Администрирование пользователей }
  Entities : TvcmEntities;
  end;//TcfAdminForm

  TAdminForm = TcfAdminForm;
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
  
  {$If defined(Admin) AND not defined(NoScripts)}
  ,
  AdminFormKeywordsPack
  {$IfEnd} //Admin AND not NoScripts
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}


{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация AdminForm
 TtfwClassRef.Register(TcfAdminForm);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin)}
// Регистрация фабрики формы AdminForm
 fm_cfAdminForm.SetFactory(TcfAdminForm.Make);
{$IfEnd} //Admin

end.