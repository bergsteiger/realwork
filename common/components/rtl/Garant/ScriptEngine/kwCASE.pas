unit kwCASE;
 {* Аналог Case из Delphi
[code]
 CASE
  1 ( 1 . )
  2 ( 2 . )
  DEFAULT ( 'else' . )
 ENDCASE
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCASE.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwBeginLikeWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
;

type
 TkwCASE = class(TtfwBeginLikeWord)
  {* Аналог Case из Delphi
[code]
 CASE
  1 ( 1 . )
  2 ( 2 . )
  DEFAULT ( 'else' . )
 ENDCASE
[code] }
  protected
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   class function GetWordNameForRegister: AnsiString; override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
 end;//TkwCASE
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwEND
 , kwCompiledCase
;

function TkwCASE.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4DBAEE8103DB_var*
//#UC END# *4DB6C99F026E_4DBAEE8103DB_var*
begin
//#UC START# *4DB6C99F026E_4DBAEE8103DB_impl*
 Result := TkwEND;
//#UC END# *4DB6C99F026E_4DBAEE8103DB_impl*
end;//TkwCASE.EndBracket

class function TkwCASE.GetWordNameForRegister: AnsiString;
begin
 Result := 'CASE';
end;//TkwCASE.GetWordNameForRegister

function TkwCASE.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_4DBAEE8103DB_var*
//#UC END# *4DBAEE0D028D_4DBAEE8103DB_var*
begin
//#UC START# *4DBAEE0D028D_4DBAEE8103DB_impl*
 Result := TkwCompiledCase;
//#UC END# *4DBAEE0D028D_4DBAEE8103DB_impl*
end;//TkwCASE.CompiledWordClass

initialization
 TkwCASE.RegisterInEngine;
 {* Регистрация CASE }
{$IfEnd} // NOT Defined(NoScripts)

end.
