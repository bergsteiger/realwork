unit Attributes_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/Attributes_Form.pas"
// Начат: 05.02.2009 19:28
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Работа с документом и списком документов::Document::View::Document::Document::Attributes
//
// Информация о документе
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
  Common_FormDefinitions_Controls,
  PrimAttributesOptions_Form,
  l3TreeInterfaces,
  nscTreeViewWithAdapterDragDrop,
  PrimAttributes_Form,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
  TAttributesForm = {final form} class(TPrimAttributesOptionsForm, AttributesFormDef)
   {* Информация о документе }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TAttributesForm
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
  AttributesKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TAttributesForm

procedure TAttributesForm.MakeControls;
begin
 inherited;
 tvAttributes.Parent := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Attributes
 TtfwClassRef.Register(TAttributesForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы Attributes
 fm_AttributesForm.SetFactory(TAttributesForm.Make);
{$IfEnd} //not Admin AND not Monitorings

end.