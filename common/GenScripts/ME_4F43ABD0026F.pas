unit WordsDefinitionPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\WordsDefinitionPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "WordsDefinitionPack" MUID: (4F43ABD0026F)

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
 , kwCompiledFunction
 , SysUtils
 , l3Base
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 TkwFUNCTION = {final} class(TtfwProcedure)
  protected
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
   class function GetWordNameForRegister: AnsiString; override;
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
   function AddedParameters: Tl3CStringArray; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOPERATOR

 TkwWordWorker = {final} class(TtfwProcedure)
  {* Определяет слово, которое может работать со словом записанным за ним непосредственно в коде. Например как @ }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function AddedParameters: Tl3CStringArray; override;
 end;//TkwWordWorker

function TkwFUNCTION.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_4F3BEDEB009F_var*
//#UC END# *4DBAEE0D028D_4F3BEDEB009F_var*
begin
//#UC START# *4DBAEE0D028D_4F3BEDEB009F_impl*
 Result := TkwCompiledFunction;
//#UC END# *4DBAEE0D028D_4F3BEDEB009F_impl*
end;//TkwFUNCTION.CompiledWordClass

class function TkwFUNCTION.GetWordNameForRegister: AnsiString;
begin
 Result := 'FUNCTION';
end;//TkwFUNCTION.GetWordNameForRegister

class function TkwNewWord.GetWordNameForRegister: AnsiString;
begin
 Result := ':';
end;//TkwNewWord.GetWordNameForRegister

function TkwOPERATOR.AddedParameters: Tl3CStringArray;
//#UC START# *4F3FF55403AB_53E466AC0341_var*
//#UC END# *4F3FF55403AB_53E466AC0341_var*
begin
//#UC START# *4F3FF55403AB_53E466AC0341_impl*
 Result := nil;
//#UC END# *4F3FF55403AB_53E466AC0341_impl*
end;//TkwOPERATOR.AddedParameters

class function TkwOPERATOR.GetWordNameForRegister: AnsiString;
begin
 Result := 'OPERATOR';
end;//TkwOPERATOR.GetWordNameForRegister

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
