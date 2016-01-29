unit nsMedicFirmsTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Medic"
// �����: �������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/nsMedicFirmsTree.pas"
// �����: 2008/03/21 11:36:49
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 ���������� ��������::Inpharm::Medic::Medic$Unit::TnsMedicFirmsTree
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
  nsMedicFirmsTreeBase
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsMedicFirmsTree = class(TnsMedicFirmsTreeBase)
 public
 // public methods
   class function Make: Il3SimpleTree; reintroduce;
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnsMedicFirmsTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsMedicFirmsTree

var g_TnsMedicFirmsTree : Pointer = nil;

procedure TnsMedicFirmsTreeFree;
begin
 IUnknown(g_TnsMedicFirmsTree) := nil;
end;


class function TnsMedicFirmsTree.Make: Il3SimpleTree;
begin
 if (g_TnsMedicFirmsTree = nil) then
 begin
  l3System.AddExitProc(TnsMedicFirmsTreeFree);
  Il3SimpleTree(g_TnsMedicFirmsTree) := inherited Make;
 end;
 Result := Il3SimpleTree(g_TnsMedicFirmsTree);
end;

class function TnsMedicFirmsTree.Exists: Boolean;
 {-}
begin
 Result := g_TnsMedicFirmsTree <> nil;
end;//TnsMedicFirmsTree.Exists

{$IfEnd} //not Admin AND not Monitorings

end.