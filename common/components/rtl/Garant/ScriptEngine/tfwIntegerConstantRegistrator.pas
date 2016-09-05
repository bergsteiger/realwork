unit tfwIntegerConstantRegistrator;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwIntegerConstantRegistrator.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TtfwIntegerConstantRegistrator" MUID: (53C7C4BF03D9)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwInteger
;

type
 TtfwIntegerConstantRegistrator = class(TtfwInteger)
  private
   f_Value: Integer;
  protected
   class function ReallyNeedRegister: Boolean; override;
   function GetInteger: Integer; override;
  public
   class procedure Register(const aName: AnsiString;
    aValue: Integer);
   constructor Create(aValue: Integer); reintroduce;
 end;//TtfwIntegerConstantRegistrator
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 //#UC START# *53C7C4BF03D9impl_uses*
 //#UC END# *53C7C4BF03D9impl_uses*
;

class procedure TtfwIntegerConstantRegistrator.Register(const aName: AnsiString;
 aValue: Integer);
//#UC START# *53C7C5F402F1_53C7C4BF03D9_var*
var
 l_Inst : TtfwIntegerConstantRegistrator;
//#UC END# *53C7C5F402F1_53C7C4BF03D9_var*
begin
//#UC START# *53C7C5F402F1_53C7C4BF03D9_impl*
 l_Inst := Create(aValue);
 try
  l_Inst.RegisterInstance(aName);
 finally
  FreeAndNil(l_Inst);
 end;//try..finally
//#UC END# *53C7C5F402F1_53C7C4BF03D9_impl*
end;//TtfwIntegerConstantRegistrator.Register

constructor TtfwIntegerConstantRegistrator.Create(aValue: Integer);
//#UC START# *55C0D9FB0106_53C7C4BF03D9_var*
//#UC END# *55C0D9FB0106_53C7C4BF03D9_var*
begin
//#UC START# *55C0D9FB0106_53C7C4BF03D9_impl*
 inherited Create;
 f_Value := aValue;
//#UC END# *55C0D9FB0106_53C7C4BF03D9_impl*
end;//TtfwIntegerConstantRegistrator.Create

class function TtfwIntegerConstantRegistrator.ReallyNeedRegister: Boolean;
//#UC START# *4DC2E05B03DD_53C7C4BF03D9_var*
//#UC END# *4DC2E05B03DD_53C7C4BF03D9_var*
begin
//#UC START# *4DC2E05B03DD_53C7C4BF03D9_impl*
 Result := false;
//#UC END# *4DC2E05B03DD_53C7C4BF03D9_impl*
end;//TtfwIntegerConstantRegistrator.ReallyNeedRegister

function TtfwIntegerConstantRegistrator.GetInteger: Integer;
//#UC START# *4EE1DC8903BB_53C7C4BF03D9_var*
//#UC END# *4EE1DC8903BB_53C7C4BF03D9_var*
begin
//#UC START# *4EE1DC8903BB_53C7C4BF03D9_impl*
 Result := f_Value;
//#UC END# *4EE1DC8903BB_53C7C4BF03D9_impl*
end;//TtfwIntegerConstantRegistrator.GetInteger

initialization
 TtfwIntegerConstantRegistrator.RegisterInEngine;
 {* Регистрация TtfwIntegerConstantRegistrator }
{$IfEnd} // NOT Defined(NoScripts)

end.
