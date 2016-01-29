unit AttributeSelect_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/AttributeSelect_Form.pas"
// Начат: 15.09.2009 12:26
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::LiteSearch::AttributeSelect
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  PrimAttributeSelectOptions_Form,
  SearchLite_FormDefinitions_Controls,
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

type
  TcfAttributeSelect = {final form} class(TPrimAttributeSelectOptionsForm, AttributeSelectFormDef)
  Entities : TvcmEntities;
  end;//TcfAttributeSelect

  TAttributeSelectForm = TcfAttributeSelect;

implementation

{$R *.DFM}

uses
  l3String
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  AttributeSelectKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// Регистрация AttributeSelect
 TtfwClassRef.Register(TcfAttributeSelect);
{$IfEnd} //not NoScripts
// Регистрация фабрики формы AttributeSelect
 fm_cfAttributeSelect.SetFactory(TcfAttributeSelect.Make);

end.