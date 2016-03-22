unit tfwDictionaryWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "tfwDictionaryWordsPack" MUID: (55E727F40334)

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
 , tfwDictionary
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , l3Interfaces
 , tfwMembersIterator
 , tfwScriptEngineExInterfaces
 , tfwKeywordsIterator
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopDictionaryWordsIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:WordsIterator
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionary pop:Dictionary:WordsIterator >>> l_ItfwValueList
[code]  }
  private
   function WordsIterator(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary): ItfwValueList;
    {* Реализация слова скрипта pop:Dictionary:WordsIterator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryWordsIterator

 TkwPopDictionaryKeywordByName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:KeywordByName
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aDictionary pop:Dictionary:KeywordByName >>> l_TtfwKeyWord
[code]  }
  private
   function KeywordByName(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary;
    const aName: Il3CString): TtfwKeyWord;
    {* Реализация слова скрипта pop:Dictionary:KeywordByName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryKeywordByName

 TkwPopDictionaryKeyWordsIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:KeyWordsIterator
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aDictionary pop:Dictionary:KeyWordsIterator >>> l_ItfwValueList
[code]  }
  private
   function KeyWordsIterator(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary): ItfwValueList;
    {* Реализация слова скрипта pop:Dictionary:KeyWordsIterator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryKeyWordsIterator

 TkwPopDictionaryOwnKeywordByName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:OwnKeywordByName
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aDictionary pop:Dictionary:OwnKeywordByName >>> l_TtfwKeyWord
[code]  }
  private
   function OwnKeywordByName(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary;
    const aName: Il3CString): TtfwKeyWord;
    {* Реализация слова скрипта pop:Dictionary:OwnKeywordByName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryOwnKeywordByName

function TkwPopDictionaryWordsIterator.WordsIterator(const aCtx: TtfwContext;
 aDictionary: TtfwDictionary): ItfwValueList;
 {* Реализация слова скрипта pop:Dictionary:WordsIterator }
//#UC START# *FD92525AFBF3_D1DB0CBA0A4E_var*
//#UC END# *FD92525AFBF3_D1DB0CBA0A4E_var*
begin
//#UC START# *FD92525AFBF3_D1DB0CBA0A4E_impl*
 Result := TtfwMembersIterator.Make(aDictionary); 
//#UC END# *FD92525AFBF3_D1DB0CBA0A4E_impl*
end;//TkwPopDictionaryWordsIterator.WordsIterator

procedure TkwPopDictionaryWordsIterator.DoDoIt(const aCtx: TtfwContext);
var l_aDictionary: TtfwDictionary;
begin
 try
  l_aDictionary := TtfwDictionary(aCtx.rEngine.PopObjAs(TtfwDictionary));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionary: TtfwDictionary : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList(WordsIterator(aCtx, l_aDictionary));
end;//TkwPopDictionaryWordsIterator.DoDoIt

function TkwPopDictionaryWordsIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwPopDictionaryWordsIterator.GetResultTypeInfo

function TkwPopDictionaryWordsIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopDictionaryWordsIterator.GetAllParamsCount

function TkwPopDictionaryWordsIterator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionary)]);
end;//TkwPopDictionaryWordsIterator.ParamsTypes

class function TkwPopDictionaryWordsIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:WordsIterator';
end;//TkwPopDictionaryWordsIterator.GetWordNameForRegister

function TkwPopDictionaryKeywordByName.KeywordByName(const aCtx: TtfwContext;
 aDictionary: TtfwDictionary;
 const aName: Il3CString): TtfwKeyWord;
 {* Реализация слова скрипта pop:Dictionary:KeywordByName }
//#UC START# *76C176260330_9E811BEE054C_var*
//#UC END# *76C176260330_9E811BEE054C_var*
begin
//#UC START# *76C176260330_9E811BEE054C_impl*
 Result := aDictionary.DRbyCName[aName];
//#UC END# *76C176260330_9E811BEE054C_impl*
end;//TkwPopDictionaryKeywordByName.KeywordByName

procedure TkwPopDictionaryKeywordByName.DoDoIt(const aCtx: TtfwContext);
var l_aDictionary: TtfwDictionary;
var l_aName: Il3CString;
begin
 try
  l_aDictionary := TtfwDictionary(aCtx.rEngine.PopObjAs(TtfwDictionary));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionary: TtfwDictionary : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(KeywordByName(aCtx, l_aDictionary, l_aName));
end;//TkwPopDictionaryKeywordByName.DoDoIt

function TkwPopDictionaryKeywordByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopDictionaryKeywordByName.GetResultTypeInfo

function TkwPopDictionaryKeywordByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopDictionaryKeywordByName.GetAllParamsCount

function TkwPopDictionaryKeywordByName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionary), @tfw_tiString]);
end;//TkwPopDictionaryKeywordByName.ParamsTypes

class function TkwPopDictionaryKeywordByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:KeywordByName';
end;//TkwPopDictionaryKeywordByName.GetWordNameForRegister

function TkwPopDictionaryKeyWordsIterator.KeyWordsIterator(const aCtx: TtfwContext;
 aDictionary: TtfwDictionary): ItfwValueList;
 {* Реализация слова скрипта pop:Dictionary:KeyWordsIterator }
//#UC START# *96DE91D549EC_7A25B6D5DC06_var*
//#UC END# *96DE91D549EC_7A25B6D5DC06_var*
begin
//#UC START# *96DE91D549EC_7A25B6D5DC06_impl*
 Result := TtfwKeywordsIterator.Make(aDictionary);
//#UC END# *96DE91D549EC_7A25B6D5DC06_impl*
end;//TkwPopDictionaryKeyWordsIterator.KeyWordsIterator

procedure TkwPopDictionaryKeyWordsIterator.DoDoIt(const aCtx: TtfwContext);
var l_aDictionary: TtfwDictionary;
begin
 try
  l_aDictionary := TtfwDictionary(aCtx.rEngine.PopObjAs(TtfwDictionary));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionary: TtfwDictionary : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList(KeyWordsIterator(aCtx, l_aDictionary));
end;//TkwPopDictionaryKeyWordsIterator.DoDoIt

function TkwPopDictionaryKeyWordsIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwPopDictionaryKeyWordsIterator.GetResultTypeInfo

function TkwPopDictionaryKeyWordsIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopDictionaryKeyWordsIterator.GetAllParamsCount

function TkwPopDictionaryKeyWordsIterator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionary)]);
end;//TkwPopDictionaryKeyWordsIterator.ParamsTypes

class function TkwPopDictionaryKeyWordsIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:KeyWordsIterator';
end;//TkwPopDictionaryKeyWordsIterator.GetWordNameForRegister

function TkwPopDictionaryOwnKeywordByName.OwnKeywordByName(const aCtx: TtfwContext;
 aDictionary: TtfwDictionary;
 const aName: Il3CString): TtfwKeyWord;
 {* Реализация слова скрипта pop:Dictionary:OwnKeywordByName }
//#UC START# *A9DAF1057D09_5D0B14C07C4C_var*
//#UC END# *A9DAF1057D09_5D0B14C07C4C_var*
begin
//#UC START# *A9DAF1057D09_5D0B14C07C4C_impl*
 Result := aDictionary.OwnDRbyCName(aName);
//#UC END# *A9DAF1057D09_5D0B14C07C4C_impl*
end;//TkwPopDictionaryOwnKeywordByName.OwnKeywordByName

procedure TkwPopDictionaryOwnKeywordByName.DoDoIt(const aCtx: TtfwContext);
var l_aDictionary: TtfwDictionary;
var l_aName: Il3CString;
begin
 try
  l_aDictionary := TtfwDictionary(aCtx.rEngine.PopObjAs(TtfwDictionary));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDictionary: TtfwDictionary : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(OwnKeywordByName(aCtx, l_aDictionary, l_aName));
end;//TkwPopDictionaryOwnKeywordByName.DoDoIt

function TkwPopDictionaryOwnKeywordByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopDictionaryOwnKeywordByName.GetResultTypeInfo

function TkwPopDictionaryOwnKeywordByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopDictionaryOwnKeywordByName.GetAllParamsCount

function TkwPopDictionaryOwnKeywordByName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionary), @tfw_tiString]);
end;//TkwPopDictionaryOwnKeywordByName.ParamsTypes

class function TkwPopDictionaryOwnKeywordByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:OwnKeywordByName';
end;//TkwPopDictionaryOwnKeywordByName.GetWordNameForRegister

initialization
 TkwPopDictionaryWordsIterator.RegisterInEngine;
 {* Регистрация pop_Dictionary_WordsIterator }
 TkwPopDictionaryKeywordByName.RegisterInEngine;
 {* Регистрация pop_Dictionary_KeywordByName }
 TkwPopDictionaryKeyWordsIterator.RegisterInEngine;
 {* Регистрация pop_Dictionary_KeyWordsIterator }
 TkwPopDictionaryOwnKeywordByName.RegisterInEngine;
 {* Регистрация pop_Dictionary_OwnKeywordByName }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwDictionary));
 {* Регистрация типа TtfwDictionary }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
 {* Регистрация типа TtfwKeyWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
