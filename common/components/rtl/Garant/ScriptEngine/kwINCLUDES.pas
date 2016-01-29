unit kwINCLUDES;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "kwINCLUDES.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::IncludesAndUses::IncludesAndUsesPack::INCLUDES
//
// ��� USES, �� ��������� �������� ����� �� ���������� ������� - ������ ����� ���� �������
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwUsesLike,
  kwIncluded
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwINCLUDES = {final scriptword} class(TkwUsesLike)
  {* ��� USES, �� ��������� �������� ����� �� ���������� ������� - ������ ����� ���� ������� }
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetIncludedClass: RkwIncluded; override;
 end;//TkwINCLUDES
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  kwInnerIncluded
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwINCLUDES

class function TkwINCLUDES.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'INCLUDES';
end;//TkwINCLUDES.GetWordNameForRegister

function TkwINCLUDES.GetIncludedClass: RkwIncluded;
//#UC START# *4F3AA4E10327_4F3AA502005F_var*
//#UC END# *4F3AA4E10327_4F3AA502005F_var*
begin
//#UC START# *4F3AA4E10327_4F3AA502005F_impl*
 Result := TkwInnerIncluded;
//#UC END# *4F3AA4E10327_4F3AA502005F_impl*
end;//TkwINCLUDES.GetIncludedClass

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� INCLUDES
 TkwINCLUDES.RegisterInEngine;
{$IfEnd} //not NoScripts

end.