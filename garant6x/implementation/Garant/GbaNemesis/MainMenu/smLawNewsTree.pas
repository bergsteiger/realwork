unit smLawNewsTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "MainMenu"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/MainMenu/smLawNewsTree.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Интерфейсные элементы::MainMenu::MainMenu::MainMenuTrees::TsmLawNewsTree
//
// Дерево "Изменения в законодательстве" для простого основного меню
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
  smTree,
  l3Tree_TLB
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TsmLawNewsTree = class(TsmTree)
  {* Дерево "Изменения в законодательстве" для простого основного меню }
 protected
 // overridden protected methods
   function MakeRoot: Il3RootNode; override;
     {* Создаёт корень дерева }
 end;//TsmLawNewsTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsConst,
  MainMenuUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TsmLawNewsTree

function TsmLawNewsTree.MakeRoot: Il3RootNode;
//#UC START# *4909EF6E0361_490C2AE8028E_var*
//#UC END# *4909EF6E0361_490C2AE8028E_var*
begin
//#UC START# *4909EF6E0361_490C2AE8028E_impl*
 Result := inherited MakeRoot;
 AddItems2011(Result, ST_CHANGES_IN_LEGISLATION);
(* nsAddMainMenuItem(Result, Ord(ns_siNewsLine),     ns_nipNewsLine);
 nsAddMainMenuItem(Result, Ord(ns_siLawChangings), ns_nipReview);
 nsAddMainMenuItem(Result, Ord(ns_siNewDocs),      ns_nipNewDocs);
 nsAddMainMenuItem(Result, Ord(ns_siMonitorings),  ns_nipMonitorings);*)
//#UC END# *4909EF6E0361_490C2AE8028E_impl*
end;//TsmLawNewsTree.MakeRoot

{$IfEnd} //not Admin AND not Monitorings

end.