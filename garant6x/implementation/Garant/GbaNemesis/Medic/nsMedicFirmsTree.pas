unit nsMedicFirmsTree;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmsTree.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsMedicFirmsTree" MUID: (49071797031F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsMedicFirmsTreeBase
 , l3TreeInterfaces
;

type
 TnsMedicFirmsTree = class(TnsMedicFirmsTreeBase)
  public
   class function Make: Il3SimpleTree; reintroduce;
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TnsMedicFirmsTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *49071797031Fimpl_uses*
 //#UC END# *49071797031Fimpl_uses*
;

var g_TnsMedicFirmsTree: Pointer = nil;
 {* ��������� ���������� TnsMedicFirmsTree }

procedure TnsMedicFirmsTreeFree;
 {* ����� ������������ ���������� ���������� TnsMedicFirmsTree }
begin
 IUnknown(g_TnsMedicFirmsTree) := nil;
end;//TnsMedicFirmsTreeFree

class function TnsMedicFirmsTree.Make: Il3SimpleTree;
begin
 if (g_TnsMedicFirmsTree = nil) then
 begin
  l3System.AddExitProc(TnsMedicFirmsTreeFree);
  Il3SimpleTree(g_TnsMedicFirmsTree) := inherited Make;
 end;
 Result := Il3SimpleTree(g_TnsMedicFirmsTree);
end;//TnsMedicFirmsTree.Make

class function TnsMedicFirmsTree.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsMedicFirmsTree <> nil;
end;//TnsMedicFirmsTree.Exists
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
