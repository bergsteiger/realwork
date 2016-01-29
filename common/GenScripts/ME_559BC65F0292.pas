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
  {* ����� ������� pop:Parser:NextToken
*������:*
[code]
 aParser pop:Parser:NextToken
[code]  }
  procedure NextToken(const aCtx: TtfwContext;
   const aParser: ItfwParser);
   {* ���������� ����� ������� pop:Parser:NextToken }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserNextToken
 
 TkwPopParserTokenLongString = class(TtfwClassLike)
  {* ����� ������� pop:Parser:TokenLongString
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aParser pop:Parser:TokenLongString >>> l_Il3CString
[code]  }
  function TokenLongString(const aCtx: TtfwContext;
   const aParser: ItfwParser): Il3CString;
   {* ���������� ����� ������� pop:Parser:TokenLongString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserTokenLongString
 
 TkwPopParserTokenInt = class(TtfwClassLike)
  {* ����� ������� pop:Parser:TokenInt
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aParser pop:Parser:TokenInt >>> l_Integer
[code]  }
  function TokenInt(const aCtx: TtfwContext;
   const aParser: ItfwParser): Integer;
   {* ���������� ����� ������� pop:Parser:TokenInt }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserTokenInt
 
 TkwPopParserFileName = class(TtfwClassLike)
  {* ����� ������� pop:Parser:FileName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aParser pop:Parser:FileName >>> l_String
[code]  }
  function FileName(const aCtx: TtfwContext;
   const aParser: ItfwParser): AnsiString;
   {* ���������� ����� ������� pop:Parser:FileName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserFileName
 
 TkwPopParserTokenType = class(TtfwClassLike)
  {* ����� ������� pop:Parser:TokenType
*��� ����������:* Tl3TokenType
*������:*
[code]
Tl3TokenType VAR l_Tl3TokenType
 aParser pop:Parser:TokenType >>> l_Tl3TokenType
[code]  }
  function TokenType(const aCtx: TtfwContext;
   const aParser: ItfwParser): Tl3TokenType;
   {* ���������� ����� ������� pop:Parser:TokenType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserTokenType
 
 TkwPopParserSourceLine = class(TtfwClassLike)
  {* ����� ������� pop:Parser:SourceLine
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aParser pop:Parser:SourceLine >>> l_Integer
[code]  }
  function SourceLine(const aCtx: TtfwContext;
   const aParser: ItfwParser): Integer;
   {* ���������� ����� ������� pop:Parser:SourceLine }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopParserSourceLine
 
end.
