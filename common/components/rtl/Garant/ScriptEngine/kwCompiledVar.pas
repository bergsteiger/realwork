unit kwCompiledVar;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Core"
// �����: ����� �.�.
// ������: "kwCompiledVar.pas"
// �����: 29.04.2011 22:34
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Core::CompiledWords::TkwCompiledVar
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwCompiledWordPrim,
  tfwScriptingInterfaces,
  tfwTypeInfo,
  tfwKeyWordPrim
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 _kwCompiledVar_Parent_ = TkwCompiledWordPrim;
 {$Include ..\ScriptEngine\kwCompiledVar.imp.pas}
 TkwCompiledVar = class(_kwCompiledVar_)
 public
 // overridden public methods
   constructor Create(aWordProducer: TtfwWord;
     aPrevFinder: TtfwWord;
     aTypeInfo: TtfwWordInfo;
     const aCtx: TtfwContext;
     aKey: TtfwKeyWordPrim); override;
   function GetEndBracket(const aContext: TtfwContext;
     aSilent: Boolean): RtfwWord; override;
   function AcceptMedianBracket(aBracket: TtfwWord;
     var aCtx: TtfwContext): Boolean; override;
 end;//TkwCompiledVar
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwArray,
  l3Base,
  TypInfo,
  l3String
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include ..\ScriptEngine\kwCompiledVar.imp.pas}

// start class TkwCompiledVar

constructor TkwCompiledVar.Create(aWordProducer: TtfwWord;
  aPrevFinder: TtfwWord;
  aTypeInfo: TtfwWordInfo;
  const aCtx: TtfwContext;
  aKey: TtfwKeyWordPrim);
//#UC START# *4DC9723702F5_4DBB04B6014C_var*
//#UC END# *4DC9723702F5_4DBB04B6014C_var*
begin
//#UC START# *4DC9723702F5_4DBB04B6014C_impl*
 inherited;
//#UC END# *4DC9723702F5_4DBB04B6014C_impl*
end;//TkwCompiledVar.Create

function TkwCompiledVar.GetEndBracket(const aContext: TtfwContext;
  aSilent: Boolean): RtfwWord;
//#UC START# *52D6B62E001B_4DBB04B6014C_var*
//#UC END# *52D6B62E001B_4DBB04B6014C_var*
begin
//#UC START# *52D6B62E001B_4DBB04B6014C_impl*
 Result := nil;
//#UC END# *52D6B62E001B_4DBB04B6014C_impl*
end;//TkwCompiledVar.GetEndBracket

function TkwCompiledVar.AcceptMedianBracket(aBracket: TtfwWord;
  var aCtx: TtfwContext): Boolean;
//#UC START# *52D7DC84019E_4DBB04B6014C_var*
//#UC END# *52D7DC84019E_4DBB04B6014C_var*
begin
//#UC START# *52D7DC84019E_4DBB04B6014C_impl*
 Result := false;
//#UC END# *52D7DC84019E_4DBB04B6014C_impl*
end;//TkwCompiledVar.AcceptMedianBracket

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� TkwCompiledVar
 TkwCompiledVar.RegisterClass;
{$IfEnd} //not NoScripts

end.