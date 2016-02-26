unit tfwAxiomaticsResNameGetters;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetters.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwAxiomaticsResNameGetterList
;

type
 TtfwAxiomaticsResNameGetters = class(TtfwAxiomaticsResNameGetterList)
  public
   class function Instance: TtfwAxiomaticsResNameGetters;
    {* ����� ��������� ���������� ���������� TtfwAxiomaticsResNameGetters }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TtfwAxiomaticsResNameGetters
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TtfwAxiomaticsResNameGetters: TtfwAxiomaticsResNameGetters = nil;
 {* ��������� ���������� TtfwAxiomaticsResNameGetters }

procedure TtfwAxiomaticsResNameGettersFree;
 {* ����� ������������ ���������� ���������� TtfwAxiomaticsResNameGetters }
begin
 l3Free(g_TtfwAxiomaticsResNameGetters);
end;//TtfwAxiomaticsResNameGettersFree

class function TtfwAxiomaticsResNameGetters.Instance: TtfwAxiomaticsResNameGetters;
 {* ����� ��������� ���������� ���������� TtfwAxiomaticsResNameGetters }
begin
 if (g_TtfwAxiomaticsResNameGetters = nil) then
 begin
  l3System.AddExitProc(TtfwAxiomaticsResNameGettersFree);
  g_TtfwAxiomaticsResNameGetters := Create;
 end;
 Result := g_TtfwAxiomaticsResNameGetters;
end;//TtfwAxiomaticsResNameGetters.Instance

class function TtfwAxiomaticsResNameGetters.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TtfwAxiomaticsResNameGetters <> nil;
end;//TtfwAxiomaticsResNameGetters.Exists
{$IfEnd} // NOT Defined(NoScripts)

end.
