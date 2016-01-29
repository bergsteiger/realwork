unit ChangesBetweenEditons_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ChangesBetweenEditons/Forms/ChangesBetweenEditons_Form.pas"
// Начат: 25.05.2011 14:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Пользовательские сервисы::ChangesBetweenEditions::View::ChangesBetweenEditons::ChangesBetweenEditions::ChangesBetweenEditons
//
// Изменения в документе
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
  ,
  PrimChangesBetweenEditons_Form
  {$If defined(Nemesis)}
  ,
  nscEditor
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
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
    { ChangesBetweenEditonsIDs }
   fm_ChangesBetweenEditonsForm : TvcmFormDescriptor = (rFormID : (rName : 'ChangesBetweenEditonsForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TChangesBetweenEditonsForm }

type
 ChangesBetweenEditonsFormDef = interface(IUnknown)
  {* Идентификатор формы ChangesBetweenEditons }
   ['{E8402096-B641-4FAE-B341-69369D1BB399}']
 end;//ChangesBetweenEditonsFormDef

  TChangesBetweenEditonsForm = {final form} class(TPrimChangesBetweenEditonsForm, ChangesBetweenEditonsFormDef)
   {* Изменения в документе }
  Entities : TvcmEntities;
  end;//TChangesBetweenEditonsForm
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
  
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  ChangesBetweenEditonsKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация ChangesBetweenEditons
 TtfwClassRef.Register(TChangesBetweenEditonsForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы ChangesBetweenEditons
 fm_ChangesBetweenEditonsForm.SetFactory(TChangesBetweenEditonsForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.