unit mmmReferencesAndDictionaries;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/mmmReferencesAndDictionaries.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::MedicMainMenu::TmmmReferencesAndDictionaries
//
// Справочники и словари
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
 TmmmReferencesAndDictionaries = class(TmmmTree)
  {* Справочники и словари }
 protected
 // overridden protected methods
   function MakeRoot: Il3RootNode; override;
     {* Создаёт корень дерева }
 end;//TmmmReferencesAndDictionaries
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsTypes,
  nsConst,
  DynamicTreeUnit,
  l3MessageID
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
   { Локализуемые строки RefAndDict local const }
  str_InpharmSearchCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'InpharmSearchCaption'; rValue : 'Поиск лекарственных средств');
   { 'Поиск лекарственных средств' }

// start class TmmmReferencesAndDictionaries

function TmmmReferencesAndDictionaries.MakeRoot: Il3RootNode;
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

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_InpharmSearchCaption
 str_InpharmSearchCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.