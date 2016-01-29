unit CodeBranchingPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "CodeBranchingPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine::CodeBranchingWords::CodeBranchingPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwBeginLikeWord,
  kwRULES
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  kwCompiledRules,
  kwStandardProcedureCloseBracket,
  kwIfElse,
  kwElse,
  kwCASE,
  kwDEFAULT,
  kwRAISE,
  kwBracketBegin,
  kwBEGIN,
  tfwScriptingTypes
  ;

{$IfEnd} //not NoScripts
end.