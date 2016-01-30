unit nsMedicFirmsTree;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmsTree.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

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
   class function Instance: TnsMedicFirmsTree;
    {* ����� ��������� ���������� ���������� TnsMedicFirmsTree }
 end;//TnsMedicFirmsTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsMedicFirmsTree: TnsMedicFirmsTree = nil;
 {* ��������� ���������� TnsMedicFirmsTree }

procedure TnsMedicFirmsTreeFree;
 {* ����� ������������ ���������� ���������� TnsMedicFirmsTree }
begin
 l3Free(g_TnsMedicFirmsTree);
end;//TnsMedicFirmsTreeFree

class function TnsMedicFirmsTree.Make: Il3SimpleTree;
var
 l_Inst : TnsMedicFirmsTree;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsMedicFirmsTree.Make

class function TnsMedicFirmsTree.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsMedicFirmsTree <> nil;
end;//TnsMedicFirmsTree.Exists

class function TnsMedicFirmsTree.Instance: TnsMedicFirmsTree;
 {* ����� ��������� ���������� ���������� TnsMedicFirmsTree }
begin
 if (g_TnsMedicFirmsTree = nil) then
 begin
  l3System.AddExitProc(TnsMedicFirmsTreeFree);
  g_TnsMedicFirmsTree := Create;
 end;
 Result := g_TnsMedicFirmsTree;
end;//TnsMedicFirmsTree.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
