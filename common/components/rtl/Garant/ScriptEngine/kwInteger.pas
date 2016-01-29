unit kwInteger;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// �����: ����� �.�.
// ������: "kwInteger.pas"
// �����: 26.04.2011 17:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::PrimitiveWords::TkwInteger
//
// ����������������� ����� Interger
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  TypInfo,
  l3Interfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwInteger = class(TtfwWord)
  {* ����������������� ����� Interger }
 private
 // private fields
   f_Value : Integer;
    {* ���� ��� �������� Value}
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function WordName: Il3CString; override;
 public
 // public methods
   constructor Create(aValue: Integer); reintroduce;
 public
 // public properties
   property Value: Integer
     read f_Value;
 end;//TkwInteger
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwInteger

constructor TkwInteger.Create(aValue: Integer);
//#UC START# *4DB6CD0F02C5_4DB6CCE100E0_var*
//#UC END# *4DB6CD0F02C5_4DB6CCE100E0_var*
begin
//#UC START# *4DB6CD0F02C5_4DB6CCE100E0_impl*
 inherited Create;
 f_Value := aValue;
//#UC END# *4DB6CD0F02C5_4DB6CCE100E0_impl*
end;//TkwInteger.Create

procedure TkwInteger.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB6CCE100E0_var*
//#UC END# *4DAEEDE10285_4DB6CCE100E0_var*
begin
//#UC START# *4DAEEDE10285_4DB6CCE100E0_impl*
 aCtx.rEngine.PushInt(f_Value);
//#UC END# *4DAEEDE10285_4DB6CCE100E0_impl*
end;//TkwInteger.DoDoIt

function TkwInteger.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4DB6CCE100E0_var*
//#UC END# *551544E2001A_4DB6CCE100E0_var*
begin
//#UC START# *551544E2001A_4DB6CCE100E0_impl*
 Result := TypeInfo(Integer);
//#UC END# *551544E2001A_4DB6CCE100E0_impl*
end;//TkwInteger.GetResultTypeInfo

function TkwInteger.WordName: Il3CString;
//#UC START# *55AFD7DA0258_4DB6CCE100E0_var*
//#UC END# *55AFD7DA0258_4DB6CCE100E0_var*
begin
//#UC START# *55AFD7DA0258_4DB6CCE100E0_impl*
 Result := TtfwCStringFactory.C(IntToStr(f_Value));
//#UC END# *55AFD7DA0258_4DB6CCE100E0_impl*
end;//TkwInteger.WordName

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwInteger
 TkwInteger.RegisterClass;
{$IfEnd} //not NoScripts

end.