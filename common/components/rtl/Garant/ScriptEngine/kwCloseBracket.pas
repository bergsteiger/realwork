unit kwCloseBracket;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// ������: "kwCloseBracket.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine$Core::CompiledWords::CloseBracket
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwCloseBracket = {abstract scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 public
 // overridden public methods
   function IsImmediate(const aCtx: TtfwContext): Boolean; override;
   function IsCloseBracket: Boolean; override;
 end;//TkwCloseBracket
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3String
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwCloseBracket

procedure TkwCloseBracket.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52D6AC0F0186_var*
//#UC END# *4DAEEDE10285_52D6AC0F0186_var*
begin
//#UC START# *4DAEEDE10285_52D6AC0F0186_impl*
 if (Self.ClassType = aCtx.rWordCompilingNow.GetEndBracket(aCtx, false)) then
  PtfwContext(@aCtx)^.rWasCloseBracket := true
 else
  CompilerAssert(false, '�������� ������������� ������', aCtx);
//#UC END# *4DAEEDE10285_52D6AC0F0186_impl*
end;//TkwCloseBracket.DoDoIt

function TkwCloseBracket.IsImmediate(const aCtx: TtfwContext): Boolean;
 {-}
begin
 Result := true;
end;//TkwCloseBracket.IsImmediate

function TkwCloseBracket.IsCloseBracket: Boolean;
//#UC START# *52D6ABCB0026_52D6AC0F0186_var*
//#UC END# *52D6ABCB0026_52D6AC0F0186_var*
begin
//#UC START# *52D6ABCB0026_52D6AC0F0186_impl*
 Result := true;
//#UC END# *52D6ABCB0026_52D6AC0F0186_impl*
end;//TkwCloseBracket.IsCloseBracket

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� CloseBracket
 TkwCloseBracket.RegisterClass;
{$IfEnd} //not NoScripts

end.