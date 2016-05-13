unit tfwTypesForRegister;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwTypesForRegister.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwTypesForRegister" MUID: (5731ECF2038D)

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
    {* Метод получения экземпляра синглетона TtfwTypesForRegister }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
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
 {* Экземпляр синглетона TtfwTypesForRegister }

procedure TtfwTypesForRegisterFree;
 {* Метод освобождения экземпляра синглетона TtfwTypesForRegister }
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
 {* Метод получения экземпляра синглетона TtfwTypesForRegister }
begin
 if (g_TtfwTypesForRegister = nil) then
 begin
  l3System.AddExitProc(TtfwTypesForRegisterFree);
  g_TtfwTypesForRegister := Create;
 end;
 Result := g_TtfwTypesForRegister;
end;//TtfwTypesForRegister.Instance

class function TtfwTypesForRegister.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwTypesForRegister <> nil;
end;//TtfwTypesForRegister.Exists
{$IfEnd} // NOT Defined(NoScripts)

end.
