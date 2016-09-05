unit tfwRegisteredEnums;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwRegisteredEnums.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwRegisteredEnums" MUID: (53C7ED5A01A0)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRTTITypeInfoList
;

type
 TtfwRegisteredEnums = class(TtfwRTTITypeInfoList)
  public
   class function Instance: TtfwRegisteredEnums;
    {* ����� ��������� ���������� ���������� TtfwRegisteredEnums }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TtfwRegisteredEnums
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *53C7ED5A01A0impl_uses*
 //#UC END# *53C7ED5A01A0impl_uses*
;

var g_TtfwRegisteredEnums: TtfwRegisteredEnums = nil;
 {* ��������� ���������� TtfwRegisteredEnums }

procedure TtfwRegisteredEnumsFree;
 {* ����� ������������ ���������� ���������� TtfwRegisteredEnums }
begin
 l3Free(g_TtfwRegisteredEnums);
end;//TtfwRegisteredEnumsFree

class function TtfwRegisteredEnums.Instance: TtfwRegisteredEnums;
 {* ����� ��������� ���������� ���������� TtfwRegisteredEnums }
begin
 if (g_TtfwRegisteredEnums = nil) then
 begin
  l3System.AddExitProc(TtfwRegisteredEnumsFree);
  g_TtfwRegisteredEnums := Create;
 end;
 Result := g_TtfwRegisteredEnums;
end;//TtfwRegisteredEnums.Instance

class function TtfwRegisteredEnums.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TtfwRegisteredEnums <> nil;
end;//TtfwRegisteredEnums.Exists
{$IfEnd} // NOT Defined(NoScripts)

end.
