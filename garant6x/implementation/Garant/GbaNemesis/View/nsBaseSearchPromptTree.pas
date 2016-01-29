unit nsBaseSearchPromptTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// �����: �������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsBaseSearchPromptTree.pas"
// �����: 2008/06/25 08:04:46
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::BaseSearch::TnsBaseSearchPromptTree
//
// ������ ���������. ���������
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
  nsBaseSearchPromptTreeBase
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsBaseSearchPromptTree = class(TnsBaseSearchPromptTreeBase)
  {* ������ ���������. ��������� }
 public
 // public methods
   class function Make: Il3SimpleTree; reintroduce;
     {* ������ ������ ��������� }
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnsBaseSearchPromptTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsBaseSearchPromptTree

var g_TnsBaseSearchPromptTree : Pointer = nil;

procedure TnsBaseSearchPromptTreeFree;
begin
 IUnknown(g_TnsBaseSearchPromptTree) := nil;
end;


class function TnsBaseSearchPromptTree.Make: Il3SimpleTree;
begin
 if (g_TnsBaseSearchPromptTree = nil) then
 begin
  l3System.AddExitProc(TnsBaseSearchPromptTreeFree);
  Il3SimpleTree(g_TnsBaseSearchPromptTree) := inherited Make;
 end;
 Result := Il3SimpleTree(g_TnsBaseSearchPromptTree);
end;

class function TnsBaseSearchPromptTree.Exists: Boolean;
 {-}
begin
 Result := g_TnsBaseSearchPromptTree <> nil;
end;//TnsBaseSearchPromptTree.Exists

{$IfEnd} //not Admin AND not Monitorings

end.