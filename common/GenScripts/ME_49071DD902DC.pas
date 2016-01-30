unit nsMedicFirmsCountryFilterTree;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\nsMedicFirmsCountryFilterTree.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsMedicFirmsCountryFilterTreeBase
 , l3TreeInterfaces
;

type
 TnsMedicFirmsCountryFilterTree = class(TnsMedicFirmsCountryFilterTreeBase)
  public
   class function Make: Il3SimpleTree; reintroduce;
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TnsMedicFirmsCountryFilterTree;
    {* ����� ��������� ���������� ���������� TnsMedicFirmsCountryFilterTree }
 end;//TnsMedicFirmsCountryFilterTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsMedicFirmsCountryFilterTree: TnsMedicFirmsCountryFilterTree = nil;
 {* ��������� ���������� TnsMedicFirmsCountryFilterTree }

procedure TnsMedicFirmsCountryFilterTreeFree;
 {* ����� ������������ ���������� ���������� TnsMedicFirmsCountryFilterTree }
begin
 l3Free(g_TnsMedicFirmsCountryFilterTree);
end;//TnsMedicFirmsCountryFilterTreeFree

class function TnsMedicFirmsCountryFilterTree.Make: Il3SimpleTree;
var
 l_Inst : TnsMedicFirmsCountryFilterTree;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsMedicFirmsCountryFilterTree.Make

class function TnsMedicFirmsCountryFilterTree.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TnsMedicFirmsCountryFilterTree <> nil;
end;//TnsMedicFirmsCountryFilterTree.Exists

class function TnsMedicFirmsCountryFilterTree.Instance: TnsMedicFirmsCountryFilterTree;
 {* ����� ��������� ���������� ���������� TnsMedicFirmsCountryFilterTree }
begin
 if (g_TnsMedicFirmsCountryFilterTree = nil) then
 begin
  l3System.AddExitProc(TnsMedicFirmsCountryFilterTreeFree);
  g_TnsMedicFirmsCountryFilterTree := Create;
 end;
 Result := g_TnsMedicFirmsCountryFilterTree;
end;//TnsMedicFirmsCountryFilterTree.Instance
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
