unit StyleEditorExample_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/StyleEditorExample_Form.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::StyleEditorExample
//
// Пример текста
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
  PrimStyleEditorExample_Form
  {$If defined(Nemesis)}
  ,
  nscTextSource
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  eeEditorWithoutOperations,
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
    { StyleEditorExampleIDs }
   fm_StyleEditorExampleForm : TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorExampleForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TStyleEditorExampleForm }

type
 StyleEditorExampleFormDef = interface(IUnknown)
  {* Идентификатор формы StyleEditorExample }
   ['{941E9E1B-2C84-4067-938E-6CFE6F2614A7}']
 end;//StyleEditorExampleFormDef

  TStyleEditorExampleForm = {final form} class(TPrimStyleEditorExampleForm, StyleEditorExampleFormDef)
   {* Пример текста }
  Entities : TvcmEntities;
  end;//TStyleEditorExampleForm
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
  StyleEditorExampleKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorExample
 TtfwClassRef.Register(TStyleEditorExampleForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы StyleEditorExample
 fm_StyleEditorExampleForm.SetFactory(TStyleEditorExampleForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.