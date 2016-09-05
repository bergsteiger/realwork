unit tfwStringConstantRegistrator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwStringConstantRegistrator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwStringConstantRegistrator" MUID: (55311B3903DC)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwString
 , l3Interfaces
 , tfwScriptingInterfaces
;

type
 TtfwStringConstantRegistrator = class(TtfwString)
  private
   f_Value: Il3CString;
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function ReallyNeedRegister: Boolean; override;
   function GetString: AnsiString; override;
   procedure ClearFields; override;
  public
   class function Register(const aName: AnsiString;
    const aValue: Il3CString): Boolean;
 end;//TtfwStringConstantRegistrator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , SysUtils
 //#UC START# *55311B3903DCimpl_uses*
 //#UC END# *55311B3903DCimpl_uses*
;

class function TtfwStringConstantRegistrator.Register(const aName: AnsiString;
 const aValue: Il3CString): Boolean;
//#UC START# *55311BAA0306_55311B3903DC_var*
var
 l_Inst : TtfwStringConstantRegistrator;
//#UC END# *55311BAA0306_55311B3903DC_var*
begin
//#UC START# *55311BAA0306_55311B3903DC_impl*
 l_Inst := Create;
 try
  l_Inst.f_Value := aValue;
  Result := l_Inst.RegisterInstance(aName);
 finally
  FreeAndNil(l_Inst);
 end;//try..finally
//#UC END# *55311BAA0306_55311B3903DC_impl*
end;//TtfwStringConstantRegistrator.Register

procedure TtfwStringConstantRegistrator.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55311B3903DC_var*
//#UC END# *4DAEEDE10285_55311B3903DC_var*
begin
//#UC START# *4DAEEDE10285_55311B3903DC_impl*
 aCtx.rEngine.PushString(f_Value);
//#UC END# *4DAEEDE10285_55311B3903DC_impl*
end;//TtfwStringConstantRegistrator.DoDoIt

class function TtfwStringConstantRegistrator.ReallyNeedRegister: Boolean;
//#UC START# *4DC2E05B03DD_55311B3903DC_var*
//#UC END# *4DC2E05B03DD_55311B3903DC_var*
begin
//#UC START# *4DC2E05B03DD_55311B3903DC_impl*
 Result := false;
//#UC END# *4DC2E05B03DD_55311B3903DC_impl*
end;//TtfwStringConstantRegistrator.ReallyNeedRegister

function TtfwStringConstantRegistrator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_55311B3903DC_var*
//#UC END# *4DDFD2EA0116_55311B3903DC_var*
begin
//#UC START# *4DDFD2EA0116_55311B3903DC_impl*
 Result := l3Str(f_Value);
//#UC END# *4DDFD2EA0116_55311B3903DC_impl*
end;//TtfwStringConstantRegistrator.GetString

procedure TtfwStringConstantRegistrator.ClearFields;
begin
 f_Value := nil;
 inherited;
end;//TtfwStringConstantRegistrator.ClearFields

initialization
 TtfwStringConstantRegistrator.RegisterInEngine;
 {* Регистрация TtfwStringConstantRegistrator }
{$IfEnd} // NOT Defined(NoScripts)

end.
