unit mmmReferencesAndDictionaries;
 {* Справочники и словари }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\mmmReferencesAndDictionaries.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , mmmTree
 , l3Tree_TLB
 , l3StringIDEx
;

type
 TmmmReferencesAndDictionaries = class(TmmmTree)
  {* Справочники и словари }
  protected
   function MakeRoot: Il3RootNode; override;
    {* Создаёт корень дерева }
 end;//TmmmReferencesAndDictionaries
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsTypes
 , nsConst
 , DynamicTreeUnit
 , l3MessageID
;

const
 {* Локализуемые строки RefAndDict local const }
 str_InpharmSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'InpharmSearchCaption'; rValue : 'Поиск лекарственных средств');
  {* 'Поиск лекарственных средств' }

function TmmmReferencesAndDictionaries.MakeRoot: Il3RootNode;
 {* Создаёт корень дерева }
//#UC START# *4909EF6E0361_490C3EE8039D_var*
var
 l_Inpharm: INodeBase;
//#UC END# *4909EF6E0361_490C3EE8039D_var*
begin
//#UC START# *4909EF6E0361_490C3EE8039D_impl*
 Result := inherited MakeRoot;
 l_Inpharm := nsFindNavigatorItem(ns_nipInpharm);
 if l_Inpharm <> nil then
 begin
  nsAddMainMenuItem(Result,
                    Ord(ns_mntAllDrugList),
                    ns_nipInpharmDrugList,
                    l_Inpharm);
  nsAddMainMenuItem(Result,
                    Ord(ns_mntSearchDrug),
                    {ns_nipInpharmSearch}
                    str_InpharmSearchCaption.AsCStr);
  nsAddMainMenuItem(Result,
                    Ord(ns_mntFirms),
                    ns_nipInpharmFirms,
                    l_Inpharm);
  nsAddMainMenuItem(Result,
                    Ord(ns_mntDiction),
                    ns_nipInpharmDiction,
                    l_Inpharm);
 end;//if l_Inpharm <> nil then
//#UC END# *4909EF6E0361_490C3EE8039D_impl*
end;//TmmmReferencesAndDictionaries.MakeRoot

initialization
 str_InpharmSearchCaption.Init;
 {* Инициализация str_InpharmSearchCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
