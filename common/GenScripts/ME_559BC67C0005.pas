unit ItfwParserExWordsPack;

interface

uses
 l3IntfUses
 , tfwParserInterfaces
 , l3Interfaces
 , l3Parser
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopParserExPushString = class(TtfwClassLike)
  {* Слово скрипта pop:ParserEx:PushString
*Пример:*
[code]
 aString aParserEx pop:ParserEx:PushString
[code]  }
  procedure PushString(const aCtx: TtfwContext;
   const aParserEx: ItfwParserEx;
   const aString: Il3CString);
   {* Реализация слова скрипта pop:ParserEx:PushString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserExPushString
 
 TkwPopParserExPushSymbol = class(TtfwClassLike)
  {* Слово скрипта pop:ParserEx:PushSymbol
*Пример:*
[code]
 aString aParserEx pop:ParserEx:PushSymbol
[code]  }
  procedure PushSymbol(const aCtx: TtfwContext;
   const aParserEx: ItfwParserEx;
   const aString: Il3CString);
   {* Реализация слова скрипта pop:ParserEx:PushSymbol }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserExPushSymbol
 
 TkwPopParserExPushInt = class(TtfwClassLike)
  {* Слово скрипта pop:ParserEx:PushInt
*Пример:*
[code]
 aValue aParserEx pop:ParserEx:PushInt
[code]  }
  procedure PushInt(const aCtx: TtfwContext;
   const aParserEx: ItfwParserEx;
   aValue: Integer);
   {* Реализация слова скрипта pop:ParserEx:PushInt }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserExPushInt
 
end.
