unit ItfwScriptEngineWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ItfwScriptEngineWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwDictionaryEx
 , l3Interfaces
 , tfwTypeInfo
 , l3Variant
 , Types
 , tfwDictionaryPrim
 , TypInfo
 , tfwClassLike
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwDictionaryExWordsPack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopScriptEngineAsKeywordFinder = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ScriptEngine:AsKeywordFinder
*Тип результата:* TtfwKeywordFinder
*Пример:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aScriptEngine pop:ScriptEngine:AsKeywordFinder >>> l_TtfwKeywordFinder
[code]  }
  private
   function AsKeywordFinder(const aCtx: TtfwContext;
    const aScriptEngine: ItfwScriptEngine): TtfwKeywordFinder;
    {* Реализация слова скрипта pop:ScriptEngine:AsKeywordFinder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopScriptEngineAsKeywordFinder

 TkwPopScriptEngineAddInitialization = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ScriptEngine:AddInitialization
*Пример:*
[code]
 aWord aScriptEngine pop:ScriptEngine:AddInitialization
[code]  }
  private
   procedure AddInitialization(const aCtx: TtfwContext;
    const aScriptEngine: ItfwScriptEngine;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:ScriptEngine:AddInitialization }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopScriptEngineAddInitialization

 TkwPopScriptEngineCurrentCompilingDictionary = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ScriptEngine:CurrentCompilingDictionary
*Тип результата:* TtfwDictionaryEx
*Пример:*
[code]
OBJECT VAR l_TtfwDictionaryEx
 aScriptEngine pop:ScriptEngine:CurrentCompilingDictionary >>> l_TtfwDictionaryEx
[code]  }
  private
   function CurrentCompilingDictionary(const aCtx: TtfwContext;
    const aScriptEngine: ItfwScriptEngine): TtfwDictionaryEx;
    {* Реализация слова скрипта pop:ScriptEngine:CurrentCompilingDictionary }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopScriptEngineCurrentCompilingDictionary

 TkwPopScriptEngineDisableForHelp = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ScriptEngine:DisableForHelp
*Пример:*
[code]
 aWord aScriptEngine pop:ScriptEngine:DisableForHelp
[code]  }
  private
   procedure DisableForHelp(const aCtx: TtfwContext;
    const aScriptEngine: ItfwScriptEngine;
    aWord: TtfwWord);
    {* Реализация слова скрипта pop:ScriptEngine:DisableForHelp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopScriptEngineDisableForHelp

function TkwPopScriptEngineAsKeywordFinder.AsKeywordFinder(const aCtx: TtfwContext;
 const aScriptEngine: ItfwScriptEngine): TtfwKeywordFinder;
 {* Реализация слова скрипта pop:ScriptEngine:AsKeywordFinder }
//#UC START# *40ABA0669AE5_63D6AB9D9B8E_var*
//#UC END# *40ABA0669AE5_63D6AB9D9B8E_var*
begin
//#UC START# *40ABA0669AE5_63D6AB9D9B8E_impl*
 Result := aScriptEngine.KeywordFinder(aCtx);
//#UC END# *40ABA0669AE5_63D6AB9D9B8E_impl*
end;//TkwPopScriptEngineAsKeywordFinder.AsKeywordFinder

procedure TkwPopScriptEngineAsKeywordFinder.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_63D6AB9D9B8E_var*
//#UC END# *4DAEEDE10285_63D6AB9D9B8E_var*
begin
//#UC START# *4DAEEDE10285_63D6AB9D9B8E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_63D6AB9D9B8E_impl*
end;//TkwPopScriptEngineAsKeywordFinder.DoDoIt

class function TkwPopScriptEngineAsKeywordFinder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScriptEngine:AsKeywordFinder';
end;//TkwPopScriptEngineAsKeywordFinder.GetWordNameForRegister

function TkwPopScriptEngineAsKeywordFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeywordFinder);
end;//TkwPopScriptEngineAsKeywordFinder.GetResultTypeInfo

function TkwPopScriptEngineAsKeywordFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopScriptEngineAsKeywordFinder.GetAllParamsCount

function TkwPopScriptEngineAsKeywordFinder.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_63D6AB9D9B8E_var*
//#UC END# *5617F4D00243_63D6AB9D9B8E_var*
begin
//#UC START# *5617F4D00243_63D6AB9D9B8E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_63D6AB9D9B8E_impl*
end;//TkwPopScriptEngineAsKeywordFinder.ParamsTypes

procedure TkwPopScriptEngineAddInitialization.AddInitialization(const aCtx: TtfwContext;
 const aScriptEngine: ItfwScriptEngine;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:ScriptEngine:AddInitialization }
//#UC START# *0A9E82A4F7FB_F4290567147F_var*
//#UC END# *0A9E82A4F7FB_F4290567147F_var*
begin
//#UC START# *0A9E82A4F7FB_F4290567147F_impl*
 aCtx.rEngine.AddInitialization(aCtx, aWord);
//#UC END# *0A9E82A4F7FB_F4290567147F_impl*
end;//TkwPopScriptEngineAddInitialization.AddInitialization

procedure TkwPopScriptEngineAddInitialization.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F4290567147F_var*
//#UC END# *4DAEEDE10285_F4290567147F_var*
begin
//#UC START# *4DAEEDE10285_F4290567147F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F4290567147F_impl*
end;//TkwPopScriptEngineAddInitialization.DoDoIt

class function TkwPopScriptEngineAddInitialization.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScriptEngine:AddInitialization';
end;//TkwPopScriptEngineAddInitialization.GetWordNameForRegister

function TkwPopScriptEngineAddInitialization.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopScriptEngineAddInitialization.GetResultTypeInfo

function TkwPopScriptEngineAddInitialization.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopScriptEngineAddInitialization.GetAllParamsCount

function TkwPopScriptEngineAddInitialization.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F4290567147F_var*
//#UC END# *5617F4D00243_F4290567147F_var*
begin
//#UC START# *5617F4D00243_F4290567147F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F4290567147F_impl*
end;//TkwPopScriptEngineAddInitialization.ParamsTypes

function TkwPopScriptEngineCurrentCompilingDictionary.CurrentCompilingDictionary(const aCtx: TtfwContext;
 const aScriptEngine: ItfwScriptEngine): TtfwDictionaryEx;
 {* Реализация слова скрипта pop:ScriptEngine:CurrentCompilingDictionary }
//#UC START# *20FE4AD2F344_1C1FE481A9C3_var*
//#UC END# *20FE4AD2F344_1C1FE481A9C3_var*
begin
//#UC START# *20FE4AD2F344_1C1FE481A9C3_impl*
 Result := aScriptEngine.CurrentCompilingDictionary As TtfwDictionaryEx;
//#UC END# *20FE4AD2F344_1C1FE481A9C3_impl*
end;//TkwPopScriptEngineCurrentCompilingDictionary.CurrentCompilingDictionary

procedure TkwPopScriptEngineCurrentCompilingDictionary.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1C1FE481A9C3_var*
//#UC END# *4DAEEDE10285_1C1FE481A9C3_var*
begin
//#UC START# *4DAEEDE10285_1C1FE481A9C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1C1FE481A9C3_impl*
end;//TkwPopScriptEngineCurrentCompilingDictionary.DoDoIt

class function TkwPopScriptEngineCurrentCompilingDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScriptEngine:CurrentCompilingDictionary';
end;//TkwPopScriptEngineCurrentCompilingDictionary.GetWordNameForRegister

function TkwPopScriptEngineCurrentCompilingDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwDictionaryEx);
end;//TkwPopScriptEngineCurrentCompilingDictionary.GetResultTypeInfo

function TkwPopScriptEngineCurrentCompilingDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopScriptEngineCurrentCompilingDictionary.GetAllParamsCount

function TkwPopScriptEngineCurrentCompilingDictionary.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1C1FE481A9C3_var*
//#UC END# *5617F4D00243_1C1FE481A9C3_var*
begin
//#UC START# *5617F4D00243_1C1FE481A9C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1C1FE481A9C3_impl*
end;//TkwPopScriptEngineCurrentCompilingDictionary.ParamsTypes

procedure TkwPopScriptEngineDisableForHelp.DisableForHelp(const aCtx: TtfwContext;
 const aScriptEngine: ItfwScriptEngine;
 aWord: TtfwWord);
 {* Реализация слова скрипта pop:ScriptEngine:DisableForHelp }
//#UC START# *D20BEDECAE0B_B7DCC24F906E_var*
//#UC END# *D20BEDECAE0B_B7DCC24F906E_var*
begin
//#UC START# *D20BEDECAE0B_B7DCC24F906E_impl*
 aScriptEngine.DisableForHelp(aWord);
//#UC END# *D20BEDECAE0B_B7DCC24F906E_impl*
end;//TkwPopScriptEngineDisableForHelp.DisableForHelp

procedure TkwPopScriptEngineDisableForHelp.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B7DCC24F906E_var*
//#UC END# *4DAEEDE10285_B7DCC24F906E_var*
begin
//#UC START# *4DAEEDE10285_B7DCC24F906E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B7DCC24F906E_impl*
end;//TkwPopScriptEngineDisableForHelp.DoDoIt

class function TkwPopScriptEngineDisableForHelp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScriptEngine:DisableForHelp';
end;//TkwPopScriptEngineDisableForHelp.GetWordNameForRegister

function TkwPopScriptEngineDisableForHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopScriptEngineDisableForHelp.GetResultTypeInfo

function TkwPopScriptEngineDisableForHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopScriptEngineDisableForHelp.GetAllParamsCount

function TkwPopScriptEngineDisableForHelp.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B7DCC24F906E_var*
//#UC END# *5617F4D00243_B7DCC24F906E_var*
begin
//#UC START# *5617F4D00243_B7DCC24F906E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B7DCC24F906E_impl*
end;//TkwPopScriptEngineDisableForHelp.ParamsTypes

initialization
 TkwPopScriptEngineAsKeywordFinder.RegisterInEngine;
 {* Регистрация pop_ScriptEngine_AsKeywordFinder }
 TkwPopScriptEngineAddInitialization.RegisterInEngine;
 {* Регистрация pop_ScriptEngine_AddInitialization }
 TkwPopScriptEngineCurrentCompilingDictionary.RegisterInEngine;
 {* Регистрация pop_ScriptEngine_CurrentCompilingDictionary }
 TkwPopScriptEngineDisableForHelp.RegisterInEngine;
 {* Регистрация pop_ScriptEngine_DisableForHelp }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwScriptEngine));
 {* Регистрация типа ItfwScriptEngine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
 {* Регистрация типа TtfwKeywordFinder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwDictionaryEx));
 {* Регистрация типа TtfwDictionaryEx }
{$IfEnd} // NOT Defined(NoScripts)

end.
