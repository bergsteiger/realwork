unit kwBracketBegin;
 {* Поддержка скобок. 
Пример:
[code]
 10 LOOP ( 'Hello' . )
[code] }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwBracketBegin.pas"
// Стереотип: "ScriptKeyword"

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
 TkwBracketBegin = class(TtfwBeginLikeWord)
  {* Поддержка скобок. 
Пример:
[code]
 10 LOOP ( 'Hello' . )
[code] }
  protected
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   class function GetWordNameForRegister: AnsiString; override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
   procedure CheckWordInfoOnCompile(const aCtx: TtfwContext); override;
 end;//TkwBracketBegin
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwBracketEnd
 , kwTypedBeginLikeCompiledCode
;

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

initialization
 TkwBracketBegin.RegisterInEngine;
 {* Регистрация BracketBegin }
{$IfEnd} // NOT Defined(NoScripts)

end.
