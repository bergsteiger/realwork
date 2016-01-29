unit mmmMainFeatures;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/mmmMainFeatures.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::MedicMainMenu::TmmmMainFeatures
//
// Основные возможности
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
  mmmTree,
  l3StringIDEx,
  l3Tree_TLB
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TmmmMainFeatures = class(TmmmTree)
  {* Основные возможности }
 protected
 // overridden protected methods
   function MakeRoot: Il3RootNode; override;
     {* Создаёт корень дерева }
 end;//TmmmMainFeatures
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsTypes,
  DynamicTreeUnit,
  nsConst,
  nsMainMenuNode,
  l3MessageID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки Main Features }
  str_PharmPublishSearch : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PharmPublishSearch'; rValue : 'СМИ по медицине и здравоохранению');
   { 'СМИ по медицине и здравоохранению' }

// start class TmmmMainFeatures

function TmmmMainFeatures.MakeRoot: Il3RootNode;
//#UC START# *4909EF6E0361_490C422B0022_var*
//#UC END# *4909EF6E0361_490C422B0022_var*
begin
//#UC START# *4909EF6E0361_490C422B0022_impl*
 Result := inherited MakeRoot;

 nsAddMainMenuDocumentItem(Result,
                           Ord(ns_mntDocument),
                           [52390027, 52390002]); // Специально для руководителей и юристов, Стандарты и порядки медицинской помощи
 nsAddMainMenuItem(Result,
                   Ord(ns_mntPublishSource),
                   str_PharmPublishSearch.AsCStr);
 nsAddMainMenuDocumentItem(Result,
                           Ord(ns_mntDocument),
                           [52390028]); // Экспертная правовая поддержка
//#UC END# *4909EF6E0361_490C422B0022_impl*
end;//TmmmMainFeatures.MakeRoot

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_PharmPublishSearch
 str_PharmPublishSearch.Init;
{$IfEnd} //not Admin AND not Monitorings

end.