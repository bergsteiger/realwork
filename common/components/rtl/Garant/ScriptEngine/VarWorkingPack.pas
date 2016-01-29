unit VarWorkingPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "VarWorkingPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::Basics::VarWorkingPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwConst,
  tfwTypeInfo
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes
  ;

type
 TkwCONST = {final scriptword} class(TtfwConst)
  {* ���������� ���������.
������:
[code]
 CONST cFake1 5
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCONST

// start class TkwCONST

class function TkwCONST.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'CONST';
end;//TkwCONST.GetWordNameForRegister
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� CONST
 TkwCONST.RegisterInEngine;
{$IfEnd} //not NoScripts

end.