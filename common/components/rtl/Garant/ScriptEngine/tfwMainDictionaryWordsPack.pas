unit tfwMainDictionaryWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwMainDictionaryWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "tfwMainDictionaryWordsPack" MUID: (55ED48FA02A9)

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
 , tfwMainDictionary
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopMainDictionaryCompiledCode = {final} class(TtfwClassLike)
  {* Слово скрипта pop:MainDictionary:CompiledCode }
  private
   function CompiledCode(const aCtx: TtfwContext;
    aMainDictionary: TtfwMainDictionary): TtfwWord;
    {* Реализация слова скрипта pop:MainDictionary:CompiledCode }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopMainDictionaryCompiledCode

function TkwPopMainDictionaryCompiledCode.CompiledCode(const aCtx: TtfwContext;
 aMainDictionary: TtfwMainDictionary): TtfwWord;
 {* Реализация слова скрипта pop:MainDictionary:CompiledCode }
//#UC START# *55ED491201A9_55ED491201A9_55A0005D02CC_Word_var*
//#UC END# *55ED491201A9_55ED491201A9_55A0005D02CC_Word_var*
begin
//#UC START# *55ED491201A9_55ED491201A9_55A0005D02CC_Word_impl*
 Result := aMainDictionary.CompiledCode;
//#UC END# *55ED491201A9_55ED491201A9_55A0005D02CC_Word_impl*
end;//TkwPopMainDictionaryCompiledCode.CompiledCode

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
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwMainDictionary)]);
end;//TkwPopMainDictionaryCompiledCode.ParamsTypes

procedure TkwPopMainDictionaryCompiledCode.DoDoIt(const aCtx: TtfwContext);
var l_aMainDictionary: TtfwMainDictionary;
begin
 try
  l_aMainDictionary := TtfwMainDictionary(aCtx.rEngine.PopObjAs(TtfwMainDictionary));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMainDictionary: TtfwMainDictionary : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CompiledCode(aCtx, l_aMainDictionary));
end;//TkwPopMainDictionaryCompiledCode.DoDoIt

initialization
 TkwPopMainDictionaryCompiledCode.RegisterInEngine;
 {* Регистрация pop_MainDictionary_CompiledCode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwMainDictionary));
 {* Регистрация типа TtfwMainDictionary }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
