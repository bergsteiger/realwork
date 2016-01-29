unit smLawNewsTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "MainMenu"
// �����: ������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/MainMenu/smLawNewsTree.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ������������ ��������::MainMenu::MainMenu::MainMenuTrees::TsmLawNewsTree
//
// ������ "��������� � ����������������" ��� �������� ��������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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
  {* ������ "��������� � ����������������" ��� �������� ��������� ���� }
 protected
 // overridden protected methods
   function MakeRoot: Il3RootNode; override;
     {* ������ ������ ������ }
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