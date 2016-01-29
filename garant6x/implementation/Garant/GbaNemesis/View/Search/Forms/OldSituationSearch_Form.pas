unit OldSituationSearch_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/OldSituationSearch_Form.pas"
// Начат: 08.09.2009 15:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Основные прецеденты::Search::View::Search::Search::OldSituationSearch
//
// Поиск по ситуации
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
  PrimOldSituationSearchOptions_Form,
  vtPanel
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtProportionalPanel,
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
    { OldSituationSearchIDs }
   fm_cfOldSituationSearch : TvcmFormDescriptor = (rFormID : (rName : 'cfOldSituationSearch'; rID : 0); rFactory : nil);
    { Идентификатор формы TcfOldSituationSearch }

type
 OldSituationSearchFormDef = interface(IUnknown)
  {* Идентификатор формы OldSituationSearch }
   ['{C98510C7-15ED-408C-B356-69BB7B6D9CA4}']
 end;//OldSituationSearchFormDef

  TcfOldSituationSearch = {final form} class(TPrimOldSituationSearchOptionsForm, OldSituationSearchFormDef)
   {* Поиск по ситуации }
  Entities : TvcmEntities;
  end;//TcfOldSituationSearch

  TOldSituationSearchForm = TcfOldSituationSearch;
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
  OldSituationSearchKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}


{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация OldSituationSearch
 TtfwClassRef.Register(TcfOldSituationSearch);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы OldSituationSearch
 fm_cfOldSituationSearch.SetFactory(TcfOldSituationSearch.Make);
{$IfEnd} //not Admin AND not Monitorings

end.