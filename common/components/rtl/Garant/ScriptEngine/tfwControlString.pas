unit tfwControlString;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$RTLandVCL"
// ������: "tfwControlString.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::VCL bindings::TtfwControlString
//
// ����� ��� ����������� �������� � ��� ������
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwString
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwControlString = {abstract} class(TtfwString)
  {* ����� ��� ����������� �������� � ��� ������ }
 public
 // public methods
   class procedure Register(const aName: AnsiString;
     aClass: TClass);
 end;//TtfwControlString
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3Base,
  l3Except,
  tfwClassRef,
  SysUtils,
  StrUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TtfwControlString

class procedure TtfwControlString.Register(const aName: AnsiString;
  aClass: TClass);
//#UC START# *508528490090_508527F30183_var*
//#UC END# *508528490090_508527F30183_var*
begin
//#UC START# *508528490090_508527F30183_impl*
 inherited Register(aName);
 TtfwClassRef.Register(aClass);
//#UC END# *508528490090_508527F30183_impl*
end;//TtfwControlString.Register

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TtfwControlString
 TtfwControlString.RegisterClass;
{$IfEnd} //not NoScripts

end.