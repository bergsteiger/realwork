unit nsMedicFirmsCountryFilterTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Medic"
// �����: �������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/nsMedicFirmsCountryFilterTree.pas"
// �����: 2008/03/21 11:36:49
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������� ��������::Inpharm::Medic::Medic$Unit::TnsMedicFirmsCountryFilterTree
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
  l3TreeInterfaces,
  nsMedicFirmsCountryFilterTreeBase
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsMedicFirmsCountryFilterTree = class(TnsMedicFirmsCountryFilterTreeBase)
 public
 // public methods
   class function Make: Il3SimpleTree; reintroduce;
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnsMedicFirmsCountryFilterTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsMedicFirmsCountryFilterTree

var g_TnsMedicFirmsCountryFilterTree : Pointer = nil;

procedure TnsMedicFirmsCountryFilterTreeFree;
begin
 IUnknown(g_TnsMedicFirmsCountryFilterTree) := nil;
end;


class function TnsMedicFirmsCountryFilterTree.Make: Il3SimpleTree;
begin
 if (g_TnsMedicFirmsCountryFilterTree = nil) then
 begin
  l3System.AddExitProc(TnsMedicFirmsCountryFilterTreeFree);
  Il3SimpleTree(g_TnsMedicFirmsCountryFilterTree) := inherited Make;
 end;
 Result := Il3SimpleTree(g_TnsMedicFirmsCountryFilterTree);
end;

class function TnsMedicFirmsCountryFilterTree.Exists: Boolean;
 {-}
begin
 Result := g_TnsMedicFirmsCountryFilterTree <> nil;
end;//TnsMedicFirmsCountryFilterTree.Exists

{$IfEnd} //not Admin AND not Monitorings

end.