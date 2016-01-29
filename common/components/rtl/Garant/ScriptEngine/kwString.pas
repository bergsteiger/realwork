unit kwString;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// �����: ����� �.�.
// ������: "kwString.pas"
// �����: 26.04.2011 17:49
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::PrimitiveWords::TkwString
//
// �������� �������� � ���� ��� ���������.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwRegisterableWordPrim,
  TypInfo,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwString = class(TtfwRegisterableWordPrim)
  {* �������� �������� � ���� ��� ���������. }
 private
 // private fields
   f_Value : Il3CString;
    {* ���� ��� �������� Value}
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function WordName: Il3CString; override;
 public
 // public methods
   constructor Create(const aValue: Il3CString); reintroduce;
 public
 // public properties
   property Value: Il3CString
     read f_Value;
 end;//TkwString
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwString

constructor TkwString.Create(const aValue: Il3CString);
//#UC START# *4DB6CD7402A0_4DB6CD4203D4_var*
//#UC END# *4DB6CD7402A0_4DB6CD4203D4_var*
begin
//#UC START# *4DB6CD7402A0_4DB6CD4203D4_impl*
 inherited Create;
 f_Value := aValue;
//#UC END# *4DB6CD7402A0_4DB6CD4203D4_impl*
end;//TkwString.Create

procedure TkwString.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DB6CD4203D4_var*
//#UC END# *4DAEEDE10285_4DB6CD4203D4_var*
begin
//#UC START# *4DAEEDE10285_4DB6CD4203D4_impl*
 aCtx.rEngine.PushString(f_Value);
//#UC END# *4DAEEDE10285_4DB6CD4203D4_impl*
end;//TkwString.DoDoIt

procedure TkwString.Cleanup;
//#UC START# *479731C50290_4DB6CD4203D4_var*
//#UC END# *479731C50290_4DB6CD4203D4_var*
begin
//#UC START# *479731C50290_4DB6CD4203D4_impl*
 f_Value := nil;
 inherited;
//#UC END# *479731C50290_4DB6CD4203D4_impl*
end;//TkwString.Cleanup

procedure TkwString.ClearFields;
 {-}
begin
 {$If not defined(NoScripts)}
 f_Value := nil;
 {$IfEnd} //not NoScripts
 inherited;
end;//TkwString.ClearFields

function TkwString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4DB6CD4203D4_var*
//#UC END# *551544E2001A_4DB6CD4203D4_var*
begin
//#UC START# *551544E2001A_4DB6CD4203D4_impl*
 Result := @tfw_tiString;
//#UC END# *551544E2001A_4DB6CD4203D4_impl*
end;//TkwString.GetResultTypeInfo

function TkwString.WordName: Il3CString;
//#UC START# *55AFD7DA0258_4DB6CD4203D4_var*
//#UC END# *55AFD7DA0258_4DB6CD4203D4_var*
begin
//#UC START# *55AFD7DA0258_4DB6CD4203D4_impl*
 Result := f_Value;
//#UC END# *55AFD7DA0258_4DB6CD4203D4_impl*
end;//TkwString.WordName

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwString
 TkwString.RegisterClass;
{$IfEnd} //not NoScripts

end.