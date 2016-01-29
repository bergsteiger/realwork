unit TreeAttributeSelect_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/TreeAttributeSelect_Form.pas"
// Начат: 15.09.2009 11:56
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Базовые определения предметной области::SearchLite::View::LiteSearch::LiteSearch::TreeAttributeSelect
//
// Выбор значений древовидного атрибута
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  PrimTreeAttributeSelectOptions_Form,
  SearchLite_FormDefinitions_Controls,
  vtPanel
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscTreeViewHotTruck
  {$IfEnd} //Nemesis
  ,
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
  TefTreeAttributeSelect = {final form} class(TPrimTreeAttributeSelectOptionsForm, TreeAttributeSelectFormDef)
   {* Выбор значений древовидного атрибута }
  Entities : TvcmEntities;
  end;//TefTreeAttributeSelect

  TTreeAttributeSelectForm = TefTreeAttributeSelect;

implementation

{$R *.DFM}

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(NoScripts)}
  ,
  TreeAttributeSelectKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;


initialization
{$If not defined(NoScripts)}
// Регистрация TreeAttributeSelect
 TtfwClassRef.Register(TefTreeAttributeSelect);
{$IfEnd} //not NoScripts
// Регистрация фабрики формы TreeAttributeSelect
 fm_efTreeAttributeSelect.SetFactory(TefTreeAttributeSelect.Make);

end.