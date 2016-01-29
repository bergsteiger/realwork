unit kwBracketBegin;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine"
// Автор: Люлин А.В.
// Модуль: "kwBracketBegin.pas"
// Начат: 03.05.2011 12:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeyword::Class Shared Delphi Low Level::ScriptEngine::CodeBranchingWords::BracketBegin
//
// Поддержка скобок.
// Пример:
// {code}
// 10 LOOP ( 'Hello' . )
// {code}
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwBeginLikeWord,
  tfwScriptingInterfaces,
  kwCompiledWordPrim
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwBracketBegin = {scriptword} class(TtfwBeginLikeWord)
  {* Поддержка скобок. 
Пример:
[code]
 10 LOOP ( 'Hello' . )
[code] }
 protected
 // realized methods
   function EndBracket(const aContext: TtfwContext;
     aSilent: Boolean): RtfwWord; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
   procedure CheckWordInfoOnCompile(const aCtx: TtfwContext); override;
 end;//TkwBracketBegin
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  kwBracketEnd,
  kwTypedBeginLikeCompiledCode
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwBracketBegin

function TkwBracketBegin.EndBracket(const aContext: TtfwContext;
  aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4DBFBBE603E5_var*
//#UC END# *4DB6C99F026E_4DBFBBE603E5_var*
begin
//#UC START# *4DB6C99F026E_4DBFBBE603E5_impl*
 Result := TkwBracketEnd;
//#UC END# *4DB6C99F026E_4DBFBBE603E5_impl*
end;//TkwBracketBegin.EndBracket

class function TkwBracketBegin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '(';
end;//TkwBracketBegin.GetWordNameForRegister

function TkwBracketBegin.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_4DBFBBE603E5_var*
//#UC END# *4DBAEE0D028D_4DBFBBE603E5_var*
begin
//#UC START# *4DBAEE0D028D_4DBFBBE603E5_impl*
 if aCtx.rTypeInfo.Empty then
  Result := inherited CompiledWordClass(aCtx)
 else
  Result := TkwTypedBeginLikeCompiledCode; 
//#UC END# *4DBAEE0D028D_4DBFBBE603E5_impl*
end;//TkwBracketBegin.CompiledWordClass

procedure TkwBracketBegin.CheckWordInfoOnCompile(const aCtx: TtfwContext);
//#UC START# *560941240035_4DBFBBE603E5_var*
//#UC END# *560941240035_4DBFBBE603E5_var*
begin
//#UC START# *560941240035_4DBFBBE603E5_impl*
 aCtx.rPrev.rTypeInfo := TtfwWordInfoE.Instance;
//#UC END# *560941240035_4DBFBBE603E5_impl*
end;//TkwBracketBegin.CheckWordInfoOnCompile

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация BracketBegin
 TkwBracketBegin.RegisterInEngine;
{$IfEnd} //not NoScripts

end.