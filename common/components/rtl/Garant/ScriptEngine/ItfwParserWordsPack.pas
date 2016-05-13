unit ItfwParserWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ItfwParserWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ItfwParserWordsPack" MUID: (559BC65F0292)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
 , l3Parser
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwParserInterfaces
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , ItfwKeywordFinderWordsPack
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopParserNextToken = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Parser:NextToken }
  private
   procedure NextToken(const aCtx: TtfwContext;
    const aParser: ItfwParser);
    {* Реализация слова скрипта pop:Parser:NextToken }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserNextToken

 TkwPopParserTokenLongString = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Parser:TokenLongString }
  private
   function TokenLongString(const aCtx: TtfwContext;
    const aParser: ItfwParser): Il3CString;
    {* Реализация слова скрипта pop:Parser:TokenLongString }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserTokenLongString

 TkwPopParserTokenInt = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Parser:TokenInt }
  private
   function TokenInt(const aCtx: TtfwContext;
    const aParser: ItfwParser): Integer;
    {* Реализация слова скрипта pop:Parser:TokenInt }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserTokenInt

 TkwPopParserFileName = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Parser:FileName }
  private
   function FileName(const aCtx: TtfwContext;
    const aParser: ItfwParser): AnsiString;
    {* Реализация слова скрипта pop:Parser:FileName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserFileName

 TkwPopParserTokenType = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Parser:TokenType }
  private
   function TokenType(const aCtx: TtfwContext;
    const aParser: ItfwParser): Tl3TokenType;
    {* Реализация слова скрипта pop:Parser:TokenType }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserTokenType

 TkwPopParserSourceLine = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Parser:SourceLine }
  private
   function SourceLine(const aCtx: TtfwContext;
    const aParser: ItfwParser): Integer;
    {* Реализация слова скрипта pop:Parser:SourceLine }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserSourceLine

procedure TkwPopParserNextToken.NextToken(const aCtx: TtfwContext;
 const aParser: ItfwParser);
 {* Реализация слова скрипта pop:Parser:NextToken }
begin
 aParser.NextToken;
end;//TkwPopParserNextToken.NextToken

procedure TkwPopParserNextToken.DoDoIt(const aCtx: TtfwContext);
var l_aParser: ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 NextToken(aCtx, l_aParser);
end;//TkwPopParserNextToken.DoDoIt

class function TkwPopParserNextToken.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:NextToken';
end;//TkwPopParserNextToken.GetWordNameForRegister

function TkwPopParserNextToken.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopParserNextToken.GetResultTypeInfo

function TkwPopParserNextToken.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserNextToken.GetAllParamsCount

function TkwPopParserNextToken.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserNextToken.ParamsTypes

function TkwPopParserTokenLongString.TokenLongString(const aCtx: TtfwContext;
 const aParser: ItfwParser): Il3CString;
 {* Реализация слова скрипта pop:Parser:TokenLongString }
begin
 Result := aParser.TokenLongString;
end;//TkwPopParserTokenLongString.TokenLongString

procedure TkwPopParserTokenLongString.DoDoIt(const aCtx: TtfwContext);
var l_aParser: ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(TokenLongString(aCtx, l_aParser));
end;//TkwPopParserTokenLongString.DoDoIt

class function TkwPopParserTokenLongString.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:TokenLongString';
end;//TkwPopParserTokenLongString.GetWordNameForRegister

function TkwPopParserTokenLongString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopParserTokenLongString.GetResultTypeInfo

function TkwPopParserTokenLongString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserTokenLongString.GetAllParamsCount

function TkwPopParserTokenLongString.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserTokenLongString.ParamsTypes

function TkwPopParserTokenInt.TokenInt(const aCtx: TtfwContext;
 const aParser: ItfwParser): Integer;
 {* Реализация слова скрипта pop:Parser:TokenInt }
begin
 Result := aParser.TokenInt;
end;//TkwPopParserTokenInt.TokenInt

procedure TkwPopParserTokenInt.DoDoIt(const aCtx: TtfwContext);
var l_aParser: ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(TokenInt(aCtx, l_aParser));
end;//TkwPopParserTokenInt.DoDoIt

class function TkwPopParserTokenInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:TokenInt';
end;//TkwPopParserTokenInt.GetWordNameForRegister

function TkwPopParserTokenInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopParserTokenInt.GetResultTypeInfo

function TkwPopParserTokenInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserTokenInt.GetAllParamsCount

function TkwPopParserTokenInt.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserTokenInt.ParamsTypes

function TkwPopParserFileName.FileName(const aCtx: TtfwContext;
 const aParser: ItfwParser): AnsiString;
 {* Реализация слова скрипта pop:Parser:FileName }
begin
 Result := aParser.FileName;
end;//TkwPopParserFileName.FileName

procedure TkwPopParserFileName.DoDoIt(const aCtx: TtfwContext);
var l_aParser: ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(FileName(aCtx, l_aParser));
end;//TkwPopParserFileName.DoDoIt

class function TkwPopParserFileName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:FileName';
end;//TkwPopParserFileName.GetWordNameForRegister

function TkwPopParserFileName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopParserFileName.GetResultTypeInfo

function TkwPopParserFileName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserFileName.GetAllParamsCount

function TkwPopParserFileName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserFileName.ParamsTypes

function TkwPopParserTokenType.TokenType(const aCtx: TtfwContext;
 const aParser: ItfwParser): Tl3TokenType;
 {* Реализация слова скрипта pop:Parser:TokenType }
begin
 Result := aParser.TokenType;
end;//TkwPopParserTokenType.TokenType

procedure TkwPopParserTokenType.DoDoIt(const aCtx: TtfwContext);
var l_aParser: ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(TokenType(aCtx, l_aParser)));
end;//TkwPopParserTokenType.DoDoIt

class function TkwPopParserTokenType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:TokenType';
end;//TkwPopParserTokenType.GetWordNameForRegister

function TkwPopParserTokenType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Tl3TokenType);
end;//TkwPopParserTokenType.GetResultTypeInfo

function TkwPopParserTokenType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserTokenType.GetAllParamsCount

function TkwPopParserTokenType.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserTokenType.ParamsTypes

function TkwPopParserSourceLine.SourceLine(const aCtx: TtfwContext;
 const aParser: ItfwParser): Integer;
 {* Реализация слова скрипта pop:Parser:SourceLine }
begin
 Result := aParser.SourceLine;
end;//TkwPopParserSourceLine.SourceLine

procedure TkwPopParserSourceLine.DoDoIt(const aCtx: TtfwContext);
var l_aParser: ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(SourceLine(aCtx, l_aParser));
end;//TkwPopParserSourceLine.DoDoIt

class function TkwPopParserSourceLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:SourceLine';
end;//TkwPopParserSourceLine.GetWordNameForRegister

function TkwPopParserSourceLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopParserSourceLine.GetResultTypeInfo

function TkwPopParserSourceLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserSourceLine.GetAllParamsCount

function TkwPopParserSourceLine.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserSourceLine.ParamsTypes

initialization
 TkwPopParserNextToken.RegisterInEngine;
 {* Регистрация pop_Parser_NextToken }
 TkwPopParserTokenLongString.RegisterInEngine;
 {* Регистрация pop_Parser_TokenLongString }
 TkwPopParserTokenInt.RegisterInEngine;
 {* Регистрация pop_Parser_TokenInt }
 TkwPopParserFileName.RegisterInEngine;
 {* Регистрация pop_Parser_FileName }
 TkwPopParserTokenType.RegisterInEngine;
 {* Регистрация pop_Parser_TokenType }
 TkwPopParserSourceLine.RegisterInEngine;
 {* Регистрация pop_Parser_SourceLine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwParser));
 {* Регистрация типа ItfwParser }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Tl3TokenType));
 {* Регистрация типа Tl3TokenType }
{$IfEnd} // NOT Defined(NoScripts)

end.
