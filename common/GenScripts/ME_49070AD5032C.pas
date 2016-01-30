unit nsMedicDictionTree;
 {* ������� ����������� �������� (���������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicDictionTree.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsMedicDictionTreeBase
 , l3TreeInterfaces
;

type
 TnsMedicDictionTree = class(TnsMedicDictionTreeBase)
  {* ������� ����������� �������� (���������) }
  public
   class function Make: Il3SimpleTree; reintroduce;
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TnsMedicDictionTree;
    {* ����� ��������� ���������� ���������� TnsMedicDictionTree }
 end;//TnsMedicDictionTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsMedicDictionTree: TnsMedicDictionTree = nil;
 {* ��������� ���������� TnsMedicDictionTree }

procedure TnsMedicDictionTreeFree;
 {* ����� ������������ ���������� ���������� TnsMedicDictionTree }
begin
 l3Free(g_TnsMedicDictionTree);
end;//TnsMedicDictionTreeFree

class function TnsMedicDictionTree.Make: Il3SimpleTree;
var
 l_Inst : TnsMedicDictionTree;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsMedicDictionTree.Make

class function TnsMedicDictionTree.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsMedicDictionTree <> nil;
end;//TnsMedicDictionTree.Exists

class function TnsMedicDictionTree.Instance: TnsMedicDictionTree;
 {* ����� ��������� ���������� ���������� TnsMedicDictionTree }
begin
 if (g_TnsMedicDictionTree = nil) then
 begin
  l3System.AddExitProc(TnsMedicDictionTreeFree);
  g_TnsMedicDictionTree := Create;
 end;
 Result := g_TnsMedicDictionTree;
end;//TnsMedicDictionTree.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
