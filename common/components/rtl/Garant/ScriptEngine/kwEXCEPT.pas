unit kwEXCEPT;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "kwEXCEPT.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::Scripting Axiomatics::EXCEPT
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwMedianBacket
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwEXCEPT = {final scriptword} class(TkwMedianBacket)
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwEXCEPT
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwEXCEPT

class function TkwEXCEPT.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'EXCEPT';
end;//TkwEXCEPT.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� EXCEPT
 TkwEXCEPT.RegisterInEngine;
{$IfEnd} //not NoScripts

end.