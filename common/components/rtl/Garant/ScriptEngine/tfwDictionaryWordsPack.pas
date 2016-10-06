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
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *55E727F40334impl_uses*
 //#UC END# *55E727F40334impl_uses*
;

type
 TkwPopDictionaryWordsIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:WordsIterator }
  private
   function WordsIterator(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary): ItfwValueList;
    {* Реализация слова скрипта pop:Dictionary:WordsIterator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryWordsIterator

 TkwPopDictionaryKeywordByName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:KeywordByName }
  private
   function KeywordByName(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary;
    const aName: Il3CString): TtfwKeyWord;
    {* Реализация слова скрипта pop:Dictionary:KeywordByName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryKeywordByName

 TkwPopDictionaryKeyWordsIterator = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:KeyWordsIterator }
  private
   function KeyWordsIterator(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary): ItfwValueList;
    {* Реализация слова скрипта pop:Dictionary:KeyWordsIterator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryKeyWordsIterator

 TkwPopDictionaryOwnKeywordByName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:OwnKeywordByName }
  private
   function OwnKeywordByName(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary;
    const aName: Il3CString): TtfwKeyWord;
    {* Реализация слова скрипта pop:Dictionary:OwnKeywordByName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryOwnKeywordByName

 TkwPopDictionaryCheckWord = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Dictionary:CheckWord }
  private
   function CheckWord(const aCtx: TtfwContext;
    aDictionary: TtfwDictionary;
    const aName: Il3CString): TtfwKeyWord;
    {* Реализация слова скрипта pop:Dictionary:CheckWord }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopDictionaryCheckWord

function TkwPopDictionaryWordsIterator.WordsIterator(const aCtx: TtfwContext;
 aDictionary: TtfwDictionary): ItfwValueList;
 {* Реализация слова скрипта pop:Dictionary:WordsIterator }
//#UC START# *55E7083D03A8_55E7083D03A8_4DAEECD90016_Word_var*
//#UC END# *55E7083D03A8_55E7083D03A8_4DAEECD90016_Word_var*
begin
//#UC START# *55E7083D03A8_55E7083D03A8_4DAEECD90016_Word_impl*
 Result := TtfwMembersIterator.Make(aDictionary);
//#UC END# *55E7083D03A8_55E7083D03A8_4DAEECD90016_Word_impl*
end;//TkwPopDictionaryWordsIterator.WordsIterator

class function TkwPopDictionaryWordsIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:WordsIterator';
end;//TkwPopDictionaryWordsIterator.GetWordNameForRegister

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

function TkwPopDictionaryKeywordByName.KeywordByName(const aCtx: TtfwContext;
 aDictionary: TtfwDictionary;
 const aName: Il3CString): TtfwKeyWord;
 {* Реализация слова скрипта pop:Dictionary:KeywordByName }
//#UC START# *55E728580305_55E728580305_4DAEECD90016_Word_var*
//#UC END# *55E728580305_55E728580305_4DAEECD90016_Word_var*
begin
//#UC START# *55E728580305_55E728580305_4DAEECD90016_Word_impl*
 Result := aDictionary.DRbyCName[aName];
//#UC END# *55E728580305_55E728580305_4DAEECD90016_Word_impl*
end;//TkwPopDictionaryKeywordByName.KeywordByName

class function TkwPopDictionaryKeywordByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:KeywordByName';
end;//TkwPopDictionaryKeywordByName.GetWordNameForRegister

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

function TkwPopDictionaryKeyWordsIterator.KeyWordsIterator(const aCtx: TtfwContext;
 aDictionary: TtfwDictionary): ItfwValueList;
 {* Реализация слова скрипта pop:Dictionary:KeyWordsIterator }
//#UC START# *55ED4C2503C3_55ED4C2503C3_4DAEECD90016_Word_var*
//#UC END# *55ED4C2503C3_55ED4C2503C3_4DAEECD90016_Word_var*
begin
//#UC START# *55ED4C2503C3_55ED4C2503C3_4DAEECD90016_Word_impl*
 Result := TtfwKeywordsIterator.Make(aDictionary);
//#UC END# *55ED4C2503C3_55ED4C2503C3_4DAEECD90016_Word_impl*
end;//TkwPopDictionaryKeyWordsIterator.KeyWordsIterator

class function TkwPopDictionaryKeyWordsIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:KeyWordsIterator';
end;//TkwPopDictionaryKeyWordsIterator.GetWordNameForRegister

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

function TkwPopDictionaryOwnKeywordByName.OwnKeywordByName(const aCtx: TtfwContext;
 aDictionary: TtfwDictionary;
 const aName: Il3CString): TtfwKeyWord;
 {* Реализация слова скрипта pop:Dictionary:OwnKeywordByName }
//#UC START# *5613A27E03D0_5613A27E03D0_4DAEECD90016_Word_var*
//#UC END# *5613A27E03D0_5613A27E03D0_4DAEECD90016_Word_var*
begin
//#UC START# *5613A27E03D0_5613A27E03D0_4DAEECD90016_Word_impl*
 Result := aDictionary.OwnDRbyCName(aName);
//#UC END# *5613A27E03D0_5613A27E03D0_4DAEECD90016_Word_impl*
end;//TkwPopDictionaryOwnKeywordByName.OwnKeywordByName

class function TkwPopDictionaryOwnKeywordByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:OwnKeywordByName';
end;//TkwPopDictionaryOwnKeywordByName.GetWordNameForRegister

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

function TkwPopDictionaryCheckWord.CheckWord(const aCtx: TtfwContext;
 aDictionary: TtfwDictionary;
 const aName: Il3CString): TtfwKeyWord;
 {* Реализация слова скрипта pop:Dictionary:CheckWord }
//#UC START# *57F5350E025B_57F5350E025B_4DAEECD90016_Word_var*
//#UC END# *57F5350E025B_57F5350E025B_4DAEECD90016_Word_var*
begin
//#UC START# *57F5350E025B_57F5350E025B_4DAEECD90016_Word_impl*
 Result := aDictionary.CheckWord(aName);
//#UC END# *57F5350E025B_57F5350E025B_4DAEECD90016_Word_impl*
end;//TkwPopDictionaryCheckWord.CheckWord

class function TkwPopDictionaryCheckWord.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:CheckWord';
end;//TkwPopDictionaryCheckWord.GetWordNameForRegister

function TkwPopDictionaryCheckWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopDictionaryCheckWord.GetResultTypeInfo

function TkwPopDictionaryCheckWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopDictionaryCheckWord.GetAllParamsCount

function TkwPopDictionaryCheckWord.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwDictionary), @tfw_tiString]);
end;//TkwPopDictionaryCheckWord.ParamsTypes

procedure TkwPopDictionaryCheckWord.DoDoIt(const aCtx: TtfwContext);
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
 aCtx.rEngine.PushObj(CheckWord(aCtx, l_aDictionary, l_aName));
end;//TkwPopDictionaryCheckWord.DoDoIt

initialization
 TkwPopDictionaryWordsIterator.RegisterInEngine;
 {* Регистрация pop_Dictionary_WordsIterator }
 TkwPopDictionaryKeywordByName.RegisterInEngine;
 {* Регистрация pop_Dictionary_KeywordByName }
 TkwPopDictionaryKeyWordsIterator.RegisterInEngine;
 {* Регистрация pop_Dictionary_KeyWordsIterator }
 TkwPopDictionaryOwnKeywordByName.RegisterInEngine;
 {* Регистрация pop_Dictionary_OwnKeywordByName }
 TkwPopDictionaryCheckWord.RegisterInEngine;
 {* Регистрация pop_Dictionary_CheckWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwDictionary));
 {* Регистрация типа TtfwDictionary }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
 {* Регистрация типа TtfwKeyWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
{$IfEnd} // NOT Defined(NoScripts)

end.
