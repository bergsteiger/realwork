unit tfwTypesForRegister;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwTypesForRegister.pas"
// ���������: "SimpleClass"
// ������� ������: "TtfwTypesForRegister" MUID: (5731ECF2038D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRTTITypeInfoList
 , TypInfo
;

type
 TtfwTypesForRegister = class(TtfwRTTITypeInfoList)
  public
   class procedure RegisterType(aType: PTypeInfo);
   class function Instance: TtfwTypesForRegister;
    {* ����� ��������� ���������� ���������� TtfwTypesForRegister }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TtfwTypesForRegister
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TtfwTypesForRegister: TtfwTypesForRegister = nil;
 {* ��������� ���������� TtfwTypesForRegister }

procedure TtfwTypesForRegisterFree;
 {* ����� ������������ ���������� ���������� TtfwTypesForRegister }
begin
 l3Free(g_TtfwTypesForRegister);
end;//TtfwTypesForRegisterFree

class procedure TtfwTypesForRegister.RegisterType(aType: PTypeInfo);
//#UC START# *5731ED2B01E9_5731ECF2038D_var*
//#UC END# *5731ED2B01E9_5731ECF2038D_var*
begin
//#UC START# *5731ED2B01E9_5731ECF2038D_impl*
 if (Instance.IndexOf(aType) < 0) then
  Instance.Add(aType);
//#UC END# *5731ED2B01E9_5731ECF2038D_impl*
end;//TtfwTypesForRegister.RegisterType

class function TtfwTypesForRegister.Instance: TtfwTypesForRegister;
 {* ����� ��������� ���������� ���������� TtfwTypesForRegister }
begin
 if (g_TtfwTypesForRegister = nil) then
 begin
  l3System.AddExitProc(TtfwTypesForRegisterFree);
  g_TtfwTypesForRegister := Create;
 end;
 Result := g_TtfwTypesForRegister;
end;//TtfwTypesForRegister.Instance

class function TtfwTypesForRegister.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TtfwTypesForRegister <> nil;
end;//TtfwTypesForRegister.Exists
{$IfEnd} // NOT Defined(NoScripts)

end.
