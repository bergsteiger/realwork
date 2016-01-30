unit kwTryFinally;
 {* Полный аналог try finally Delphi }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwTryFinally.pas"
// Стереотип: "ScriptKeyword"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDualWord
 , tfwScriptingInterfaces
 , kwDualCompiledWordContainer
 , kwCompiledWordPrim
;

type
 TkwTryFinally = class(TtfwDualWord)
  {* Полный аналог try finally Delphi }
  protected
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   function MedianBracket: RtfwWord; override;
   function MakeDualCompiled(const aContext: TtfwContext;
    aCompiled: TkwCompiledWordPrim;
    aCompiled2: TkwCompiledWordPrim): TkwDualCompiledWordContainer; override;
   function MedianBracket2: RtfwWord; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwTryFinally
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCompiledTryFinally
 , kwCompiledTryExcept
 , kwEND
 , kwFINALLY
 , kwEXCEPT
;

function TkwTryFinally.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4DBAC542005F_var*
//#UC END# *4DB6C99F026E_4DBAC542005F_var*
begin
//#UC START# *4DB6C99F026E_4DBAC542005F_impl*
 Result := TkwEND;
//#UC END# *4DB6C99F026E_4DBAC542005F_impl*
end;//TkwTryFinally.EndBracket

function TkwTryFinally.MedianBracket: RtfwWord;
//#UC START# *4DBAC41301F2_4DBAC542005F_var*
//#UC END# *4DBAC41301F2_4DBAC542005F_var*
begin
//#UC START# *4DBAC41301F2_4DBAC542005F_impl*
 Result := TkwFINALLY;
//#UC END# *4DBAC41301F2_4DBAC542005F_impl*
end;//TkwTryFinally.MedianBracket

function TkwTryFinally.MakeDualCompiled(const aContext: TtfwContext;
 aCompiled: TkwCompiledWordPrim;
 aCompiled2: TkwCompiledWordPrim): TkwDualCompiledWordContainer;
//#UC START# *4DBAC44D02CC_4DBAC542005F_var*
//#UC END# *4DBAC44D02CC_4DBAC542005F_var*
begin
//#UC START# *4DBAC44D02CC_4DBAC542005F_impl*
 CompilerAssert(aCompiled2 <> nil, 'Нет второй половины', aContext);
 CompilerAssert(aCompiled2.Key <> nil, 'Нет стереотипа второй половины', aContext);
 if (TtfwKeyWord(aCompiled2.Key).Word.ClassType = TkwFINALLY) then
  Result := TkwCompiledTryFinally.Create(aCompiled, aCompiled2, aContext)
 else
 if (TtfwKeyWord(aCompiled2.Key).Word.ClassType = TkwEXCEPT) then
  Result := TkwCompiledTryExcept.Create(aCompiled, aCompiled2, aContext)
 else
 begin
  Result := nil;
  CompilerAssert(false, 'Неизвестная средняя скобка', aContext);
 end;//else
(* Case aMedianNum of
  1:
   if aCompiled2.Key.Word.ClassType =
   Result := TkwCompiledTryFinally.Create(aCompiled, aCompiled2);
  2:
   Result := TkwCompiledTryExcept.Create(aCompiled, aCompiled2);
  else
  begin
   Result := nil;
   CompilerAssert(false, 'Неизвестная средняя скобка', aContext);
  end;//else
 end;//Case aMedianNum*)
//#UC END# *4DBAC44D02CC_4DBAC542005F_impl*
end;//TkwTryFinally.MakeDualCompiled

function TkwTryFinally.MedianBracket2: RtfwWord;
//#UC START# *4DBADF3E02CC_4DBAC542005F_var*
//#UC END# *4DBADF3E02CC_4DBAC542005F_var*
begin
//#UC START# *4DBADF3E02CC_4DBAC542005F_impl*
 Result := TkwEXCEPT;
//#UC END# *4DBADF3E02CC_4DBAC542005F_impl*
end;//TkwTryFinally.MedianBracket2

class function TkwTryFinally.GetWordNameForRegister: AnsiString;
begin
 Result := 'TRY';
end;//TkwTryFinally.GetWordNameForRegister

initialization
 TkwTryFinally.RegisterInEngine;
 {* Регистрация TryFinally }
{$IfEnd} // NOT Defined(NoScripts)

end.
