unit tfwCompiledAxiomaticsRes;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwCompiledAxiomaticsRes.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3StringList
;

type
 TtfwCompiledAxiomaticsRes = class(Tl3StringList)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TtfwCompiledAxiomaticsRes;
    {* ����� ��������� ���������� ���������� TtfwCompiledAxiomaticsRes }
 end;//TtfwCompiledAxiomaticsRes
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TtfwCompiledAxiomaticsRes: TtfwCompiledAxiomaticsRes = nil;
 {* ��������� ���������� TtfwCompiledAxiomaticsRes }

procedure TtfwCompiledAxiomaticsResFree;
 {* ����� ������������ ���������� ���������� TtfwCompiledAxiomaticsRes }
begin
 l3Free(g_TtfwCompiledAxiomaticsRes);
end;//TtfwCompiledAxiomaticsResFree

class function TtfwCompiledAxiomaticsRes.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TtfwCompiledAxiomaticsRes <> nil;
end;//TtfwCompiledAxiomaticsRes.Exists

class function TtfwCompiledAxiomaticsRes.Instance: TtfwCompiledAxiomaticsRes;
 {* ����� ��������� ���������� ���������� TtfwCompiledAxiomaticsRes }
begin
 if (g_TtfwCompiledAxiomaticsRes = nil) then
 begin
  l3System.AddExitProc(TtfwCompiledAxiomaticsResFree);
  g_TtfwCompiledAxiomaticsRes := Create;
 end;
 Result := g_TtfwCompiledAxiomaticsRes;
end;//TtfwCompiledAxiomaticsRes.Instance
{$IfEnd} // NOT Defined(NoScripts)

end.
