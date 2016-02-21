unit WordsDefinitionPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\WordsDefinitionPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwProcedure
 , kwCompiledWordPrim
 , tfwScriptingInterfaces
 , l3Interfaces
 , tfwScriptingTypes
 , kwCompiledFunction
 , SysUtils
 , l3Base
;

type
 TkwFUNCTION = {final} class(TtfwProcedure)
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
 end;//TkwFUNCTION

 TkwNewWord = {final} class(TtfwProcedure)
  {* Определение новых слов. Пример: 
[code]
: Hello
 3 FOR
  'Hello' .
 NEXT
;
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwNewWord

 TkwOPERATOR = {final} class(TtfwProcedure)
  {* Определяет операторы, которые могут принимать слова как слева, так и справа }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function AddedParameters: Tl3CStringArray; override;
 end;//TkwOPERATOR

 TkwWordWorker = {final} class(TtfwProcedure)
  {* Определяет слово, которое может работать со словом записанным за ним непосредственно в коде. Например как @ }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function AddedParameters: Tl3CStringArray; override;
 end;//TkwWordWorker

class function TkwFUNCTION.GetWordNameForRegister: AnsiString;
begin
 Result := 'FUNCTION';
end;//TkwFUNCTION.GetWordNameForRegister

function TkwFUNCTION.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_4F3BEDEB009F_var*
//#UC END# *4DBAEE0D028D_4F3BEDEB009F_var*
begin
//#UC START# *4DBAEE0D028D_4F3BEDEB009F_impl*
 Result := TkwCompiledFunction;
//#UC END# *4DBAEE0D028D_4F3BEDEB009F_impl*
end;//TkwFUNCTION.CompiledWordClass

class function TkwNewWord.GetWordNameForRegister: AnsiString;
begin
 Result := ':';
end;//TkwNewWord.GetWordNameForRegister

class function TkwOPERATOR.GetWordNameForRegister: AnsiString;
begin
 Result := 'OPERATOR';
end;//TkwOPERATOR.GetWordNameForRegister

function TkwOPERATOR.AddedParameters: Tl3CStringArray;
//#UC START# *4F3FF55403AB_53E466AC0341_var*
//#UC END# *4F3FF55403AB_53E466AC0341_var*
begin
//#UC START# *4F3FF55403AB_53E466AC0341_impl*
 Result := nil;
//#UC END# *4F3FF55403AB_53E466AC0341_impl*
end;//TkwOPERATOR.AddedParameters

class function TkwWordWorker.GetWordNameForRegister: AnsiString;
begin
 Result := 'WORDWORKER';
end;//TkwWordWorker.GetWordNameForRegister

function TkwWordWorker.AddedParameters: Tl3CStringArray;
//#UC START# *4F3FF55403AB_4F2196CA01FE_var*
//#UC END# *4F3FF55403AB_4F2196CA01FE_var*
begin
//#UC START# *4F3FF55403AB_4F2196CA01FE_impl*
 Result := l3CStringArrayFromS(['WordToWork']);
//#UC END# *4F3FF55403AB_4F2196CA01FE_impl*
end;//TkwWordWorker.AddedParameters

initialization
 TkwFUNCTION.RegisterInEngine;
 {* Регистрация FUNCTION }
 TkwNewWord.RegisterInEngine;
 {* Регистрация NewWord }
 TkwOPERATOR.RegisterInEngine;
 {* Регистрация OPERATOR }
 TkwWordWorker.RegisterInEngine;
 {* Регистрация WordWorker }
{$IfEnd} // NOT Defined(NoScripts)

end.
