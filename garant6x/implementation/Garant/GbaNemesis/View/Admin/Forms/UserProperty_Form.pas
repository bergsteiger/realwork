unit UserProperty_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/UserProperty_Form.pas"
// Начат: 07.09.2009 18:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Администратор::Admin::View::Admin::Admin::UserProperty
//
// Свойства пользователя
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
  PrimUserPropertyOptions_Form,
  Admin_FormDefinitions_Controls,
  vtPanel,
  vtLabel
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtComboBoxQS,
  vtCheckBox,
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
  TefUserProperty = {final form} class(TPrimUserPropertyOptionsForm, UserPropertyFormDef)
   {* Свойства пользователя }
  Entities : TvcmEntities;
  end;//TefUserProperty

  TUserPropertyForm = TefUserProperty;
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
  UserPropertyKeywordsPack
  {$IfEnd} //Admin AND not NoScripts
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}


{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация UserProperty
 TtfwClassRef.Register(TefUserProperty);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin)}
// Регистрация фабрики формы UserProperty
 fm_efUserProperty.SetFactory(TefUserProperty.Make);
{$IfEnd} //Admin

end.