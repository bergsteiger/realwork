unit tfwClassesForRegister;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwClassesForRegister.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwClassesForRegister" MUID: (5732F2B10311)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ClassList
;

type
 TtfwClassesForRegister = class(Tl3ClassList)
  public
   class procedure RegisterClass(aClass: TClass);
   class function Instance: TtfwClassesForRegister;
    {* Метод получения экземпляра синглетона TtfwClassesForRegister }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TtfwClassesForRegister
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *5732F2B10311impl_uses*
 //#UC END# *5732F2B10311impl_uses*
;

var g_TtfwClassesForRegister: TtfwClassesForRegister = nil;
 {* Экземпляр синглетона TtfwClassesForRegister }

procedure TtfwClassesForRegisterFree;
 {* Метод освобождения экземпляра синглетона TtfwClassesForRegister }
begin
 l3Free(g_TtfwClassesForRegister);
end;//TtfwClassesForRegisterFree

class procedure TtfwClassesForRegister.RegisterClass(aClass: TClass);
//#UC START# *5732F2E2031F_5732F2B10311_var*
//#UC END# *5732F2E2031F_5732F2B10311_var*
begin
//#UC START# *5732F2E2031F_5732F2B10311_impl*
 if (Instance.IndexOf(aClass) < 0) then
  Instance.Add(aClass);
//#UC END# *5732F2E2031F_5732F2B10311_impl*
end;//TtfwClassesForRegister.RegisterClass

class function TtfwClassesForRegister.Instance: TtfwClassesForRegister;
 {* Метод получения экземпляра синглетона TtfwClassesForRegister }
begin
 if (g_TtfwClassesForRegister = nil) then
 begin
  l3System.AddExitProc(TtfwClassesForRegisterFree);
  g_TtfwClassesForRegister := Create;
 end;
 Result := g_TtfwClassesForRegister;
end;//TtfwClassesForRegister.Instance

class function TtfwClassesForRegister.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwClassesForRegister <> nil;
end;//TtfwClassesForRegister.Exists
{$IfEnd} // NOT Defined(NoScripts)

end.
