unit tfwStringToEnumValue;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// ������: "tfwStringToEnumValue.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::ConstantsRegistration::TtfwStringToEnumValue
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  TypInfo,
  tfwRegisterableWordPrim,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwStringToEnumValue = class(TtfwRegisterableWordPrim)
 private
 // private fields
   f_TypeInfo : PTypeInfo;
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 public
 // public methods
   class procedure Register(aTypeInfo: PTypeInfo);
 end;//TtfwStringToEnumValue
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TtfwStringToEnumValue

class procedure TtfwStringToEnumValue.Register(aTypeInfo: PTypeInfo);
//#UC START# *55313331027C_553132CA032A_var*
var
 l_Inst : TtfwStringToEnumValue;
//#UC END# *55313331027C_553132CA032A_var*
begin
//#UC START# *55313331027C_553132CA032A_impl*
 l_Inst := Create;
 try
  l_Inst.f_TypeInfo := aTypeInfo;
  l_Inst.RegisterInstance(aTypeInfo.Name + ':NameToValue');
 finally
  FreeAndNil(l_Inst);
 end;//try..finally
//#UC END# *55313331027C_553132CA032A_impl*
end;//TtfwStringToEnumValue.Register

procedure TtfwStringToEnumValue.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_553132CA032A_var*
//#UC END# *4DAEEDE10285_553132CA032A_var*
begin
//#UC START# *4DAEEDE10285_553132CA032A_impl*
 aCtx.rEngine.PushInt(GetEnumValue(f_TypeInfo, aCtx.rEngine.PopDelphiString));
//#UC END# *4DAEEDE10285_553132CA032A_impl*
end;//TtfwStringToEnumValue.DoDoIt

function TtfwStringToEnumValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_553132CA032A_var*
//#UC END# *551544E2001A_553132CA032A_var*
begin
//#UC START# *551544E2001A_553132CA032A_impl*
 Result := f_TypeInfo; 
//#UC END# *551544E2001A_553132CA032A_impl*
end;//TtfwStringToEnumValue.GetResultTypeInfo

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TtfwStringToEnumValue
 TtfwStringToEnumValue.RegisterClass;
{$IfEnd} //not NoScripts

end.