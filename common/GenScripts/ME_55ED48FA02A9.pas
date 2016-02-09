unit tfwMainDictionaryWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwMainDictionary
 , tfwScriptingInterfaces
 , tfwClassLike
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopMainDictionaryCompiledCode = {final} class(TtfwClassLike)
  {* Слово скрипта pop:MainDictionary:CompiledCode
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aMainDictionary pop:MainDictionary:CompiledCode >>> l_TtfwWord
[code]  }
  private
   function CompiledCode(const aCtx: TtfwContext;
    aMainDictionary: TtfwMainDictionary): TtfwWord;
    {* Реализация слова скрипта pop:MainDictionary:CompiledCode }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMainDictionaryCompiledCode

function TkwPopMainDictionaryCompiledCode.CompiledCode(const aCtx: TtfwContext;
 aMainDictionary: TtfwMainDictionary): TtfwWord;
 {* Реализация слова скрипта pop:MainDictionary:CompiledCode }
//#UC START# *E184DB3F75A6_FA2C6FCB48FD_var*
//#UC END# *E184DB3F75A6_FA2C6FCB48FD_var*
begin
//#UC START# *E184DB3F75A6_FA2C6FCB48FD_impl*
 Result := aMainDictionary.CompiledCode;
//#UC END# *E184DB3F75A6_FA2C6FCB48FD_impl*
end;//TkwPopMainDictionaryCompiledCode.CompiledCode

procedure TkwPopMainDictionaryCompiledCode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FA2C6FCB48FD_var*
//#UC END# *4DAEEDE10285_FA2C6FCB48FD_var*
begin
//#UC START# *4DAEEDE10285_FA2C6FCB48FD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FA2C6FCB48FD_impl*
end;//TkwPopMainDictionaryCompiledCode.DoDoIt

class function TkwPopMainDictionaryCompiledCode.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:MainDictionary:CompiledCode';
end;//TkwPopMainDictionaryCompiledCode.GetWordNameForRegister

function TkwPopMainDictionaryCompiledCode.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopMainDictionaryCompiledCode.GetResultTypeInfo

function TkwPopMainDictionaryCompiledCode.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopMainDictionaryCompiledCode.GetAllParamsCount

function TkwPopMainDictionaryCompiledCode.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FA2C6FCB48FD_var*
//#UC END# *5617F4D00243_FA2C6FCB48FD_var*
begin
//#UC START# *5617F4D00243_FA2C6FCB48FD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FA2C6FCB48FD_impl*
end;//TkwPopMainDictionaryCompiledCode.ParamsTypes

initialization
 TkwPopMainDictionaryCompiledCode.RegisterInEngine;
 {* Регистрация pop_MainDictionary_CompiledCode }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwMainDictionary));
 {* Регистрация типа TtfwMainDictionary }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
