unit StyleEditorContainer_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/StyleEditorContainer_Form.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::StyleEditorContainer
//
// Редактор стилей
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
  PrimStyleEditorContainerOptions_Form,
  vtProportionalPanel,
  vtPanel,
  vtSizeablePanel,
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
    { StyleEditorContainerIDs }
   fm_StyleEditorContainerForm : TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorContainerForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TStyleEditorContainerForm }

type
 StyleEditorContainerFormDef = interface(IUnknown)
  {* Идентификатор формы StyleEditorContainer }
   ['{27578D68-B109-4681-A8A0-250B1511D051}']
 end;//StyleEditorContainerFormDef

  TStyleEditorContainerForm = {final form} class(TPrimStyleEditorContainerOptionsForm, StyleEditorContainerFormDef)
   {* Редактор стилей }
  Entities : TvcmEntities;
  end;//TStyleEditorContainerForm
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
  StyleEditorContainerKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorContainer
 TtfwClassRef.Register(TStyleEditorContainerForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.