unit ItfwParserWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "ItfwParserWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::Basics::ItfwParserWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  l3Parser,
  tfwScriptingInterfaces,
  tfwParserInterfaces,
  tfwClassLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  ItfwKeywordFinderWordsPack,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopParserNextToken = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Parser:NextToken
*������:*
[code]
 aParser pop:Parser:NextToken
[code]  }
 private
 // private methods
   procedure NextToken(const aCtx: TtfwContext;
    const aParser: ItfwParser);
     {* ���������� ����� ������� pop:Parser:NextToken }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserNextToken

// start class TkwPopParserNextToken

procedure TkwPopParserNextToken.NextToken(const aCtx: TtfwContext;
  const aParser: ItfwParser);
 {-}
begin
 aParser.NextToken;
end;//TkwPopParserNextToken.NextToken

procedure TkwPopParserNextToken.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aParser : ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 NextToken(aCtx, l_aParser);
end;//TkwPopParserNextToken.DoDoIt

class function TkwPopParserNextToken.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Parser:NextToken';
end;//TkwPopParserNextToken.GetWordNameForRegister

function TkwPopParserNextToken.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopParserNextToken.GetResultTypeInfo

function TkwPopParserNextToken.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopParserNextToken.GetAllParamsCount

function TkwPopParserNextToken.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserNextToken.ParamsTypes

type
 TkwPopParserTokenLongString = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Parser:TokenLongString
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aParser pop:Parser:TokenLongString >>> l_Il3CString
[code]  }
 private
 // private methods
   function TokenLongString(const aCtx: TtfwContext;
    const aParser: ItfwParser): Il3CString;
     {* ���������� ����� ������� pop:Parser:TokenLongString }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserTokenLongString

// start class TkwPopParserTokenLongString

function TkwPopParserTokenLongString.TokenLongString(const aCtx: TtfwContext;
  const aParser: ItfwParser): Il3CString;
 {-}
begin
 Result := aParser.TokenLongString;
end;//TkwPopParserTokenLongString.TokenLongString

procedure TkwPopParserTokenLongString.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aParser : ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((TokenLongString(aCtx, l_aParser)));
end;//TkwPopParserTokenLongString.DoDoIt

class function TkwPopParserTokenLongString.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Parser:TokenLongString';
end;//TkwPopParserTokenLongString.GetWordNameForRegister

function TkwPopParserTokenLongString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwPopParserTokenLongString.GetResultTypeInfo

function TkwPopParserTokenLongString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopParserTokenLongString.GetAllParamsCount

function TkwPopParserTokenLongString.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserTokenLongString.ParamsTypes

type
 TkwPopParserTokenInt = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Parser:TokenInt
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aParser pop:Parser:TokenInt >>> l_Integer
[code]  }
 private
 // private methods
   function TokenInt(const aCtx: TtfwContext;
    const aParser: ItfwParser): Integer;
     {* ���������� ����� ������� pop:Parser:TokenInt }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserTokenInt

// start class TkwPopParserTokenInt

function TkwPopParserTokenInt.TokenInt(const aCtx: TtfwContext;
  const aParser: ItfwParser): Integer;
 {-}
begin
 Result := aParser.TokenInt;
end;//TkwPopParserTokenInt.TokenInt

procedure TkwPopParserTokenInt.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aParser : ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((TokenInt(aCtx, l_aParser)));
end;//TkwPopParserTokenInt.DoDoIt

class function TkwPopParserTokenInt.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Parser:TokenInt';
end;//TkwPopParserTokenInt.GetWordNameForRegister

function TkwPopParserTokenInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopParserTokenInt.GetResultTypeInfo

function TkwPopParserTokenInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopParserTokenInt.GetAllParamsCount

function TkwPopParserTokenInt.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserTokenInt.ParamsTypes

type
 TkwPopParserFileName = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Parser:FileName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aParser pop:Parser:FileName >>> l_String
[code]  }
 private
 // private methods
   function FileName(const aCtx: TtfwContext;
    const aParser: ItfwParser): AnsiString;
     {* ���������� ����� ������� pop:Parser:FileName }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserFileName

// start class TkwPopParserFileName

function TkwPopParserFileName.FileName(const aCtx: TtfwContext;
  const aParser: ItfwParser): AnsiString;
 {-}
begin
 Result := aParser.FileName;
end;//TkwPopParserFileName.FileName

procedure TkwPopParserFileName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aParser : ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((FileName(aCtx, l_aParser)));
end;//TkwPopParserFileName.DoDoIt

class function TkwPopParserFileName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Parser:FileName';
end;//TkwPopParserFileName.GetWordNameForRegister

function TkwPopParserFileName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwPopParserFileName.GetResultTypeInfo

function TkwPopParserFileName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopParserFileName.GetAllParamsCount

function TkwPopParserFileName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserFileName.ParamsTypes

type
 TkwPopParserTokenType = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Parser:TokenType
*��� ����������:* Tl3TokenType
*������:*
[code]
Tl3TokenType VAR l_Tl3TokenType
 aParser pop:Parser:TokenType >>> l_Tl3TokenType
[code]  }
 private
 // private methods
   function TokenType(const aCtx: TtfwContext;
    const aParser: ItfwParser): Tl3TokenType;
     {* ���������� ����� ������� pop:Parser:TokenType }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserTokenType

// start class TkwPopParserTokenType

function TkwPopParserTokenType.TokenType(const aCtx: TtfwContext;
  const aParser: ItfwParser): Tl3TokenType;
 {-}
begin
 Result := aParser.TokenType;
end;//TkwPopParserTokenType.TokenType

procedure TkwPopParserTokenType.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aParser : ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(TokenType(aCtx, l_aParser)));
end;//TkwPopParserTokenType.DoDoIt

class function TkwPopParserTokenType.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Parser:TokenType';
end;//TkwPopParserTokenType.GetWordNameForRegister

function TkwPopParserTokenType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Tl3TokenType);
end;//TkwPopParserTokenType.GetResultTypeInfo

function TkwPopParserTokenType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopParserTokenType.GetAllParamsCount

function TkwPopParserTokenType.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserTokenType.ParamsTypes

type
 TkwPopParserSourceLine = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:Parser:SourceLine
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aParser pop:Parser:SourceLine >>> l_Integer
[code]  }
 private
 // private methods
   function SourceLine(const aCtx: TtfwContext;
    const aParser: ItfwParser): Integer;
     {* ���������� ����� ������� pop:Parser:SourceLine }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserSourceLine

// start class TkwPopParserSourceLine

function TkwPopParserSourceLine.SourceLine(const aCtx: TtfwContext;
  const aParser: ItfwParser): Integer;
 {-}
begin
 Result := aParser.SourceLine;
end;//TkwPopParserSourceLine.SourceLine

procedure TkwPopParserSourceLine.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aParser : ItfwParser;
begin
 try
  l_aParser := ItfwParser(aCtx.rEngine.PopIntf(ItfwParser));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aParser: ItfwParser : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((SourceLine(aCtx, l_aParser)));
end;//TkwPopParserSourceLine.DoDoIt

class function TkwPopParserSourceLine.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Parser:SourceLine';
end;//TkwPopParserSourceLine.GetWordNameForRegister

function TkwPopParserSourceLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopParserSourceLine.GetResultTypeInfo

function TkwPopParserSourceLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopParserSourceLine.GetAllParamsCount

function TkwPopParserSourceLine.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParser)]);
end;//TkwPopParserSourceLine.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_Parser_NextToken
 TkwPopParserNextToken.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Parser_TokenLongString
 TkwPopParserTokenLongString.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Parser_TokenInt
 TkwPopParserTokenInt.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Parser_FileName
 TkwPopParserFileName.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Parser_TokenType
 TkwPopParserTokenType.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_Parser_SourceLine
 TkwPopParserSourceLine.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� ItfwParser
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwParser));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Tl3TokenType
 TtfwTypeRegistrator.RegisterType(TypeInfo(Tl3TokenType));
{$IfEnd} //not NoScripts

end.