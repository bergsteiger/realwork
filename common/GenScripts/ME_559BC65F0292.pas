unit ItfwParserWordsPack;

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
 , ItfwKeywordFinderWordsPack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopParserNextToken = class(TtfwClassLike)
  {* Слово скрипта pop:Parser:NextToken
*Пример:*
[code]
 aParser pop:Parser:NextToken
[code]  }
  procedure NextToken(const aCtx: TtfwContext;
   const aParser: ItfwParser);
   {* Реализация слова скрипта pop:Parser:NextToken }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserNextToken
 
 TkwPopParserTokenLongString = class(TtfwClassLike)
  {* Слово скрипта pop:Parser:TokenLongString
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aParser pop:Parser:TokenLongString >>> l_Il3CString
[code]  }
  function TokenLongString(const aCtx: TtfwContext;
   const aParser: ItfwParser): Il3CString;
   {* Реализация слова скрипта pop:Parser:TokenLongString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserTokenLongString
 
 TkwPopParserTokenInt = class(TtfwClassLike)
  {* Слово скрипта pop:Parser:TokenInt
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aParser pop:Parser:TokenInt >>> l_Integer
[code]  }
  function TokenInt(const aCtx: TtfwContext;
   const aParser: ItfwParser): Integer;
   {* Реализация слова скрипта pop:Parser:TokenInt }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserTokenInt
 
 TkwPopParserFileName = class(TtfwClassLike)
  {* Слово скрипта pop:Parser:FileName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aParser pop:Parser:FileName >>> l_String
[code]  }
  function FileName(const aCtx: TtfwContext;
   const aParser: ItfwParser): AnsiString;
   {* Реализация слова скрипта pop:Parser:FileName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserFileName
 
 TkwPopParserTokenType = class(TtfwClassLike)
  {* Слово скрипта pop:Parser:TokenType
*Тип результата:* Tl3TokenType
*Пример:*
[code]
Tl3TokenType VAR l_Tl3TokenType
 aParser pop:Parser:TokenType >>> l_Tl3TokenType
[code]  }
  function TokenType(const aCtx: TtfwContext;
   const aParser: ItfwParser): Tl3TokenType;
   {* Реализация слова скрипта pop:Parser:TokenType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserTokenType
 
 TkwPopParserSourceLine = class(TtfwClassLike)
  {* Слово скрипта pop:Parser:SourceLine
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aParser pop:Parser:SourceLine >>> l_Integer
[code]  }
  function SourceLine(const aCtx: TtfwContext;
   const aParser: ItfwParser): Integer;
   {* Реализация слова скрипта pop:Parser:SourceLine }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserSourceLine
 
end.
