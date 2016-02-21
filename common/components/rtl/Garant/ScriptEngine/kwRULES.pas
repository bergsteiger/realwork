unit kwRULES;
 {* ������ CASE � ��������������� � MDP. ���� ������� �����������, �� ����������� ��������� �� ��� �������� � �������������� ����� }

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwRULES.pas"
// ���������: "ScriptKeyword"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwBeginLikeWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwRULES = {final} class(TtfwBeginLikeWord)
  {* ������ CASE � ��������������� � MDP. ���� ������� �����������, �� ����������� ��������� �� ��� �������� � �������������� ����� }
  protected
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   class function GetWordNameForRegister: AnsiString; override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
 end;//TkwRULES
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCompiledRules
 , kwStandardProcedureCloseBracket
;

function TkwRULES.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4F51EC180118_var*
//#UC END# *4DB6C99F026E_4F51EC180118_var*
begin
//#UC START# *4DB6C99F026E_4F51EC180118_impl*
 Result := TkwStandardProcedureCloseBracket;
//#UC END# *4DB6C99F026E_4F51EC180118_impl*
end;//TkwRULES.EndBracket

class function TkwRULES.GetWordNameForRegister: AnsiString;
begin
 Result := 'RULES';
end;//TkwRULES.GetWordNameForRegister

function TkwRULES.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_4F51EC180118_var*
//#UC END# *4DBAEE0D028D_4F51EC180118_var*
begin
//#UC START# *4DBAEE0D028D_4F51EC180118_impl*
 Result := TkwCompiledRules;
//#UC END# *4DBAEE0D028D_4F51EC180118_impl*
end;//TkwRULES.CompiledWordClass

initialization
 TkwRULES.RegisterInEngine;
 {* ����������� RULES }
{$IfEnd} // NOT Defined(NoScripts)

end.
