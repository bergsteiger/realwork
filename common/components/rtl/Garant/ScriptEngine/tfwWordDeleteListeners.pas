unit tfwWordDeleteListeners;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwWordDeleteListeners.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwWordDeleteListeners" MUID: (57BB002402E9)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ItfwWordListenerList
;

type
 TtfwWordDeleteListeners = class(TItfwWordListenerList)
  public
   class function Instance: TtfwWordDeleteListeners;
    {* ����� ��������� ���������� ���������� TtfwWordDeleteListeners }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TtfwWordDeleteListeners
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *57BB002402E9impl_uses*
 //#UC END# *57BB002402E9impl_uses*
;

var g_TtfwWordDeleteListeners: TtfwWordDeleteListeners = nil;
 {* ��������� ���������� TtfwWordDeleteListeners }

procedure TtfwWordDeleteListenersFree;
 {* ����� ������������ ���������� ���������� TtfwWordDeleteListeners }
begin
 l3Free(g_TtfwWordDeleteListeners);
end;//TtfwWordDeleteListenersFree

class function TtfwWordDeleteListeners.Instance: TtfwWordDeleteListeners;
 {* ����� ��������� ���������� ���������� TtfwWordDeleteListeners }
begin
 if (g_TtfwWordDeleteListeners = nil) then
 begin
  l3System.AddExitProc(TtfwWordDeleteListenersFree);
  g_TtfwWordDeleteListeners := Create;
 end;
 Result := g_TtfwWordDeleteListeners;
end;//TtfwWordDeleteListeners.Instance

class function TtfwWordDeleteListeners.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TtfwWordDeleteListeners <> nil;
end;//TtfwWordDeleteListeners.Exists
{$IfEnd} // NOT Defined(NoScripts)

end.
