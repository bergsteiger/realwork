unit mmmMainFeatures;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Medic"
// �����: ������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/mmmMainFeatures.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������� ��������::Inpharm::Medic::MedicMainMenu::TmmmMainFeatures
//
// �������� �����������
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
  mmmTree,
  l3StringIDEx,
  l3Tree_TLB
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TmmmMainFeatures = class(TmmmTree)
  {* �������� ����������� }
 protected
 // overridden protected methods
   function MakeRoot: Il3RootNode; override;
     {* ������ ������ ������ }
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
   { ������������ ������ Main Features }
  str_PharmPublishSearch : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'PharmPublishSearch'; rValue : '��� �� �������� � ���������������');
   { '��� �� �������� � ���������������' }

// start class TmmmMainFeatures

function TmmmMainFeatures.MakeRoot: Il3RootNode;
//#UC START# *4909EF6E0361_490C422B0022_var*
//#UC END# *4909EF6E0361_490C422B0022_var*
begin
//#UC START# *4909EF6E0361_490C422B0022_impl*
 Result := inherited MakeRoot;

 nsAddMainMenuDocumentItem(Result,
                           Ord(ns_mntDocument),
                           [52390027, 52390002]); // ���������� ��� ������������� � �������, ��������� � ������� ����������� ������
 nsAddMainMenuItem(Result,
                   Ord(ns_mntPublishSource),
                   str_PharmPublishSearch.AsCStr);
 nsAddMainMenuDocumentItem(Result,
                           Ord(ns_mntDocument),
                           [52390028]); // ���������� �������� ���������
//#UC END# *4909EF6E0361_490C422B0022_impl*
end;//TmmmMainFeatures.MakeRoot

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_PharmPublishSearch
 str_PharmPublishSearch.Init;
{$IfEnd} //not Admin AND not Monitorings

end.