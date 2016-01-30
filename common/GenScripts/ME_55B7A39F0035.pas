unit tfwAxiomaticsResNameGetters;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwAxiomaticsResNameGetters.pas"
// ���������: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwAxiomaticsResNameGetterList
;

type
 TtfwAxiomaticsResNameGetters = class(TtfwAxiomaticsResNameGetterList)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TtfwAxiomaticsResNameGetters;
    {* ����� ��������� ���������� ���������� TtfwAxiomaticsResNameGetters }
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

class function TtfwAxiomaticsResNameGetters.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TtfwAxiomaticsResNameGetters <> nil;
end;//TtfwAxiomaticsResNameGetters.Exists

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
{$IfEnd} // NOT Defined(NoScripts)

end.
