unit QueryCard_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/QueryCard_Form.pas"
// Начат: 10.09.2009 21:03
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::CommonSearch::QueryCard
//
// Карточка запросов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Search_FormDefinitions_Controls,
  PrimQueryCardOptions_Form,
  evQueryCardEditor,
  evTextSource,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
type
  TenQueryCard = {final form} class(TPrimQueryCardOptionsForm, QueryCardFormDef)
   {* Карточка запросов }
  Entities : TvcmEntities;
  end;//TenQueryCard

  TQueryCardForm = TenQueryCard;
{$IfEnd} //not Admin

implementation

{$R *.DFM}

{$If not defined(Admin)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  {$If not defined(Admin) AND not defined(NoScripts)}
  ,
  QueryCardKeywordsPack
  {$IfEnd} //not Admin AND not NoScripts
  
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}


{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// Регистрация QueryCard
 TtfwClassRef.Register(TenQueryCard);
{$IfEnd} //not Admin AND not NoScripts
{$If not defined(Admin)}
// Регистрация фабрики формы QueryCard
 fm_enQueryCard.SetFactory(TenQueryCard.Make);
{$IfEnd} //not Admin

end.