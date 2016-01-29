unit KeyWordPack;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , tfwDictionary
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptEngineExInterfaces
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopKeyWordWord = class(TtfwPropertyLike)
  {* Слово скрипта pop:KeyWord:Word
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aKeyWord pop:KeyWord:Word >>> l_TtfwWord
[code]  }
  function Word(const aCtx: TtfwContext;
   aKeyWord: TtfwKeyWord): TtfwWord;
   {* Реализация слова скрипта pop:KeyWord:Word }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopKeyWordWord
 
 TkwPopKeyWordName = class(TtfwPropertyLike)
  {* Слово скрипта pop:KeyWord:Name
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aKeyWord pop:KeyWord:Name >>> l_Il3CString
[code]  }
  function Name(const aCtx: TtfwContext;
   aKeyWord: TtfwKeyWord): Il3CString;
   {* Реализация слова скрипта pop:KeyWord:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopKeyWordName
 
 TkwPopKeyWordDictionary = class(TtfwPropertyLike)
  {* Слово скрипта pop:KeyWord:Dictionary
*Тип результата:* TtfwDictionary
*Пример:*
[code]
OBJECT VAR l_TtfwDictionary
 aKeyWord pop:KeyWord:Dictionary >>> l_TtfwDictionary
[code]  }
  function Dictionary(const aCtx: TtfwContext;
   aKeyWord: TtfwKeyWord): TtfwDictionary;
   {* Реализация слова скрипта pop:KeyWord:Dictionary }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopKeyWordDictionary
 
end.
