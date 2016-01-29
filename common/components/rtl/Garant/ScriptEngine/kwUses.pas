unit kwUses;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// �����: ����� �.�.
// ������: "kwUses.pas"
// �����: 06.05.2011 11:26
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::IncludesAndUses::IncludesAndUsesPack::Uses
//
// ���������� ������� ������� � ������:
// ������:
// {code}
// USES
// DocumentNumbers.script
// ;
// {code}
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwUsesLike
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwUses = {scriptword} class(TkwUsesLike)
  {* ���������� ������� ������� � ������:
������:
[code]
USES
 DocumentNumbers.script
;
[code] }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwUses
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}

// start class TkwUses

class function TkwUses.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'USES';
end;//TkwUses.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Uses
 TkwUses.RegisterInEngine;
{$IfEnd} //not NoScripts

end.