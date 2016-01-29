unit GroupProperty_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/Forms/GroupProperty_Form.pas"
// Начат: 07.09.2009 18:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Администратор::Admin::View::Admin::Admin::GroupProperty
//
// Свойства группы
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
  ,
  PrimGroupPropertyOptions_Form
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
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
    { GroupPropertyIDs }
   fm_efGroupProperty : TvcmFormDescriptor = (rFormID : (rName : 'efGroupProperty'; rID : 0); rFactory : nil);
    { Идентификатор формы TefGroupProperty }

type
 GroupPropertyFormDef = interface(IUnknown)
  {* Идентификатор формы GroupProperty }
   ['{F213AE84-ECF9-427D-8B89-53C6221D1F27}']
 end;//GroupPropertyFormDef

  TefGroupProperty = {final form} class(TPrimGroupPropertyOptionsForm, GroupPropertyFormDef)
   {* Свойства группы }
  Entities : TvcmEntities;
  end;//TefGroupProperty

  TGroupPropertyForm = TefGroupProperty;
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
  GroupPropertyKeywordsPack
  {$IfEnd} //Admin AND not NoScripts
  
  ;
{$IfEnd} //Admin

{$If defined(Admin)}


{$IfEnd} //Admin

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация GroupProperty
 TtfwClassRef.Register(TefGroupProperty);
{$IfEnd} //Admin AND not NoScripts

end.