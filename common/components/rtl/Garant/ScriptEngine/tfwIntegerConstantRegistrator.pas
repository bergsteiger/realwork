unit tfwIntegerConstantRegistrator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// ������: "tfwIntegerConstantRegistrator.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::PrimitiveWords::TtfwIntegerConstantRegistrator
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwInteger
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwIntegerConstantRegistrator = class(TtfwInteger)
 private
 // private fields
   f_Value : Integer;
 protected
 // overridden protected methods
   class function ReallyNeedRegister: Boolean; override;
   function GetInteger: Integer; override;
 public
 // public methods
   class procedure Register(const aName: AnsiString;
     aValue: Integer);
   constructor Create(aValue: Integer); reintroduce;
 end;//TtfwIntegerConstantRegistrator
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TtfwIntegerConstantRegistrator

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

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TtfwIntegerConstantRegistrator
 TtfwIntegerConstantRegistrator.RegisterInEngine;
{$IfEnd} //not NoScripts

end.