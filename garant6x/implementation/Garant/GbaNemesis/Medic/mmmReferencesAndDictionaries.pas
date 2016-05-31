unit mmmReferencesAndDictionaries;
 {* ����������� � ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\mmmReferencesAndDictionaries.pas"
// ���������: "SimpleClass"
// ������� ������: "TmmmReferencesAndDictionaries" MUID: (490C3EE8039D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , mmmTree
 , l3Tree_TLB
;

type
 TmmmReferencesAndDictionaries = class(TmmmTree)
  {* ����������� � ������� }
  protected
   function MakeRoot: Il3RootNode; override;
    {* ������ ������ ������ }
 end;//TmmmReferencesAndDictionaries
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , nsTypes
 , nsConst
 , DynamicTreeUnit
;

const
 {* ������������ ������ RefAndDict local const }
 str_InpharmSearchCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'InpharmSearchCaption'; rValue : '����� ������������� �������');
  {* '����� ������������� �������' }

function TmmmReferencesAndDictionaries.MakeRoot: Il3RootNode;
 {* ������ ������ ������ }
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
 {* ������������� str_InpharmSearchCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
