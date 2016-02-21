unit smLawNewsTree;
 {* Дерево "Изменения в законодательстве" для простого основного меню }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\MainMenu\smLawNewsTree.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , smTree
 , l3Tree_TLB
;

type
 TsmLawNewsTree = class(TsmTree)
  {* Дерево "Изменения в законодательстве" для простого основного меню }
  protected
   function MakeRoot: Il3RootNode; override;
    {* Создаёт корень дерева }
 end;//TsmLawNewsTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsConst
 , MainMenuUnit
;

function TsmLawNewsTree.MakeRoot: Il3RootNode;
 {* Создаёт корень дерева }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
