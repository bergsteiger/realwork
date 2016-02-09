unit tfwDictionaryWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDictionaryWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwDictionary
 , tfwScriptingInterfaces
 , l3Interfaces
 , tfwClassLike
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
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
//#UC START# *4DAEEDE10285_D1DB0CBA0A4E_var*
//#UC END# *4DAEEDE10285_D1DB0CBA0A4E_var*
begin
//#UC START# *4DAEEDE10285_D1DB0CBA0A4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D1DB0CBA0A4E_impl*
end;//TkwPopDictionaryWordsIterator.DoDoIt

class function TkwPopDictionaryWordsIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:WordsIterator';
end;//TkwPopDictionaryWordsIterator.GetWordNameForRegister

function TkwPopDictionaryWordsIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D1DB0CBA0A4E_var*
//#UC END# *551544E2001A_D1DB0CBA0A4E_var*
begin
//#UC START# *551544E2001A_D1DB0CBA0A4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D1DB0CBA0A4E_impl*
end;//TkwPopDictionaryWordsIterator.GetResultTypeInfo

function TkwPopDictionaryWordsIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopDictionaryWordsIterator.GetAllParamsCount

function TkwPopDictionaryWordsIterator.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D1DB0CBA0A4E_var*
//#UC END# *5617F4D00243_D1DB0CBA0A4E_var*
begin
//#UC START# *5617F4D00243_D1DB0CBA0A4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D1DB0CBA0A4E_impl*
end;//TkwPopDictionaryWordsIterator.ParamsTypes

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
//#UC START# *4DAEEDE10285_9E811BEE054C_var*
//#UC END# *4DAEEDE10285_9E811BEE054C_var*
begin
//#UC START# *4DAEEDE10285_9E811BEE054C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9E811BEE054C_impl*
end;//TkwPopDictionaryKeywordByName.DoDoIt

class function TkwPopDictionaryKeywordByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:KeywordByName';
end;//TkwPopDictionaryKeywordByName.GetWordNameForRegister

function TkwPopDictionaryKeywordByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9E811BEE054C_var*
//#UC END# *551544E2001A_9E811BEE054C_var*
begin
//#UC START# *551544E2001A_9E811BEE054C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9E811BEE054C_impl*
end;//TkwPopDictionaryKeywordByName.GetResultTypeInfo

function TkwPopDictionaryKeywordByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopDictionaryKeywordByName.GetAllParamsCount

function TkwPopDictionaryKeywordByName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9E811BEE054C_var*
//#UC END# *5617F4D00243_9E811BEE054C_var*
begin
//#UC START# *5617F4D00243_9E811BEE054C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9E811BEE054C_impl*
end;//TkwPopDictionaryKeywordByName.ParamsTypes

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
//#UC START# *4DAEEDE10285_7A25B6D5DC06_var*
//#UC END# *4DAEEDE10285_7A25B6D5DC06_var*
begin
//#UC START# *4DAEEDE10285_7A25B6D5DC06_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7A25B6D5DC06_impl*
end;//TkwPopDictionaryKeyWordsIterator.DoDoIt

class function TkwPopDictionaryKeyWordsIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:KeyWordsIterator';
end;//TkwPopDictionaryKeyWordsIterator.GetWordNameForRegister

function TkwPopDictionaryKeyWordsIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7A25B6D5DC06_var*
//#UC END# *551544E2001A_7A25B6D5DC06_var*
begin
//#UC START# *551544E2001A_7A25B6D5DC06_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7A25B6D5DC06_impl*
end;//TkwPopDictionaryKeyWordsIterator.GetResultTypeInfo

function TkwPopDictionaryKeyWordsIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopDictionaryKeyWordsIterator.GetAllParamsCount

function TkwPopDictionaryKeyWordsIterator.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7A25B6D5DC06_var*
//#UC END# *5617F4D00243_7A25B6D5DC06_var*
begin
//#UC START# *5617F4D00243_7A25B6D5DC06_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7A25B6D5DC06_impl*
end;//TkwPopDictionaryKeyWordsIterator.ParamsTypes

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
//#UC START# *4DAEEDE10285_5D0B14C07C4C_var*
//#UC END# *4DAEEDE10285_5D0B14C07C4C_var*
begin
//#UC START# *4DAEEDE10285_5D0B14C07C4C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5D0B14C07C4C_impl*
end;//TkwPopDictionaryOwnKeywordByName.DoDoIt

class function TkwPopDictionaryOwnKeywordByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Dictionary:OwnKeywordByName';
end;//TkwPopDictionaryOwnKeywordByName.GetWordNameForRegister

function TkwPopDictionaryOwnKeywordByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_5D0B14C07C4C_var*
//#UC END# *551544E2001A_5D0B14C07C4C_var*
begin
//#UC START# *551544E2001A_5D0B14C07C4C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_5D0B14C07C4C_impl*
end;//TkwPopDictionaryOwnKeywordByName.GetResultTypeInfo

function TkwPopDictionaryOwnKeywordByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopDictionaryOwnKeywordByName.GetAllParamsCount

function TkwPopDictionaryOwnKeywordByName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_5D0B14C07C4C_var*
//#UC END# *5617F4D00243_5D0B14C07C4C_var*
begin
//#UC START# *5617F4D00243_5D0B14C07C4C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5D0B14C07C4C_impl*
end;//TkwPopDictionaryOwnKeywordByName.ParamsTypes

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
