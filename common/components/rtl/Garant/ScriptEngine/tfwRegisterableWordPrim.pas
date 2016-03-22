unit tfwRegisterableWordPrim;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwRegisterableWordPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwRegisterableWordPrim" MUID: (54D229E702B6)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
;

type
 TtfwRegisterableWordPrim = {abstract} class(TtfwWord)
  protected
   class function Register(const aName: AnsiString): Boolean;
   class function ReallyNeedRegister: Boolean; virtual;
   class procedure RegisterInEngine; virtual;
   class function GetWordNameForRegister: AnsiString; virtual;
  public
   function RegisterInstance(const aName: AnsiString): Boolean;
 end;//TtfwRegisterableWordPrim
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwAutoregisteredDiction
;

function TtfwRegisterableWordPrim.RegisterInstance(const aName: AnsiString): Boolean;
//#UC START# *53F1E3A4014D_54D229E702B6_var*
//#UC END# *53F1E3A4014D_54D229E702B6_var*
begin
//#UC START# *53F1E3A4014D_54D229E702B6_impl*
 Assert(aName <> '');
 Result := TtfwAutoregisteredDiction.Instance.AddWord(aName, Self);
 if Result then
  Self.RegisterClass;
//#UC END# *53F1E3A4014D_54D229E702B6_impl*
end;//TtfwRegisterableWordPrim.RegisterInstance

class function TtfwRegisterableWordPrim.Register(const aName: AnsiString): Boolean;
//#UC START# *4DDFD69F00FE_54D229E702B6_var*
//#UC END# *4DDFD69F00FE_54D229E702B6_var*
begin
//#UC START# *4DDFD69F00FE_54D229E702B6_impl*
 Assert(aName <> '');
 Result := TtfwAutoregisteredDiction.Instance.AddWord(aName, Self);
 //if Result then
  Self.RegisterClass;
//#UC END# *4DDFD69F00FE_54D229E702B6_impl*
end;//TtfwRegisterableWordPrim.Register

class function TtfwRegisterableWordPrim.ReallyNeedRegister: Boolean;
//#UC START# *4DC2E05B03DD_54D229E702B6_var*
//#UC END# *4DC2E05B03DD_54D229E702B6_var*
begin
//#UC START# *4DC2E05B03DD_54D229E702B6_impl*
 Result := true;
//#UC END# *4DC2E05B03DD_54D229E702B6_impl*
end;//TtfwRegisterableWordPrim.ReallyNeedRegister

class procedure TtfwRegisterableWordPrim.RegisterInEngine;
//#UC START# *52A086150180_54D229E702B6_var*
//#UC END# *52A086150180_54D229E702B6_var*
begin
//#UC START# *52A086150180_54D229E702B6_impl*
 if ReallyNeedRegister then
  Register(NameForRegister)
 else
  Self.RegisterClass; 
//#UC END# *52A086150180_54D229E702B6_impl*
end;//TtfwRegisterableWordPrim.RegisterInEngine

class function TtfwRegisterableWordPrim.GetWordNameForRegister: AnsiString;
//#UC START# *4DB0614603C8_54D229E702B6_var*
//#UC END# *4DB0614603C8_54D229E702B6_var*
begin
//#UC START# *4DB0614603C8_54D229E702B6_impl*
 Result := '';
 Assert(false);
//#UC END# *4DB0614603C8_54D229E702B6_impl*
end;//TtfwRegisterableWordPrim.GetWordNameForRegister

initialization
 TtfwRegisterableWordPrim.RegisterClass;
 {* Регистрация TtfwRegisterableWordPrim }
{$IfEnd} // NOT Defined(NoScripts)

end.
