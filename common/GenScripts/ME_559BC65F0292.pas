unit ItfwParserWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ItfwParserWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwParserInterfaces
 , l3Interfaces
 , l3Parser
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ItfwKeywordFinderWordsPack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopParserNextToken = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Parser:NextToken
*Пример:*
[code]
 aParser pop:Parser:NextToken
[code]  }
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
  {* Слово скрипта pop:Parser:TokenLongString
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aParser pop:Parser:TokenLongString >>> l_Il3CString
[code]  }
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
  {* Слово скрипта pop:Parser:TokenInt
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aParser pop:Parser:TokenInt >>> l_Integer
[code]  }
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
  {* Слово скрипта pop:Parser:FileName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aParser pop:Parser:FileName >>> l_String
[code]  }
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
  {* Слово скрипта pop:Parser:TokenType
*Тип результата:* Tl3TokenType
*Пример:*
[code]
Tl3TokenType VAR l_Tl3TokenType
 aParser pop:Parser:TokenType >>> l_Tl3TokenType
[code]  }
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
  {* Слово скрипта pop:Parser:SourceLine
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aParser pop:Parser:SourceLine >>> l_Integer
[code]  }
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
//#UC START# *F35D5ECD9EFB_9FCC7CEF0219_var*
//#UC END# *F35D5ECD9EFB_9FCC7CEF0219_var*
begin
//#UC START# *F35D5ECD9EFB_9FCC7CEF0219_impl*
 !!! Needs to be implemented !!!
//#UC END# *F35D5ECD9EFB_9FCC7CEF0219_impl*
end;//TkwPopParserNextToken.NextToken

procedure TkwPopParserNextToken.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9FCC7CEF0219_var*
//#UC END# *4DAEEDE10285_9FCC7CEF0219_var*
begin
//#UC START# *4DAEEDE10285_9FCC7CEF0219_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9FCC7CEF0219_impl*
end;//TkwPopParserNextToken.DoDoIt

class function TkwPopParserNextToken.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:NextToken';
end;//TkwPopParserNextToken.GetWordNameForRegister

function TkwPopParserNextToken.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwPopParserNextToken.GetResultTypeInfo

function TkwPopParserNextToken.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserNextToken.GetAllParamsCount

function TkwPopParserNextToken.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9FCC7CEF0219_var*
//#UC END# *5617F4D00243_9FCC7CEF0219_var*
begin
//#UC START# *5617F4D00243_9FCC7CEF0219_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9FCC7CEF0219_impl*
end;//TkwPopParserNextToken.ParamsTypes

function TkwPopParserTokenLongString.TokenLongString(const aCtx: TtfwContext;
 const aParser: ItfwParser): Il3CString;
 {* Реализация слова скрипта pop:Parser:TokenLongString }
//#UC START# *B4F2C24959BB_391DC30DE773_var*
//#UC END# *B4F2C24959BB_391DC30DE773_var*
begin
//#UC START# *B4F2C24959BB_391DC30DE773_impl*
 !!! Needs to be implemented !!!
//#UC END# *B4F2C24959BB_391DC30DE773_impl*
end;//TkwPopParserTokenLongString.TokenLongString

procedure TkwPopParserTokenLongString.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_391DC30DE773_var*
//#UC END# *4DAEEDE10285_391DC30DE773_var*
begin
//#UC START# *4DAEEDE10285_391DC30DE773_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_391DC30DE773_impl*
end;//TkwPopParserTokenLongString.DoDoIt

class function TkwPopParserTokenLongString.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:TokenLongString';
end;//TkwPopParserTokenLongString.GetWordNameForRegister

function TkwPopParserTokenLongString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwPopParserTokenLongString.GetResultTypeInfo

function TkwPopParserTokenLongString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserTokenLongString.GetAllParamsCount

function TkwPopParserTokenLongString.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_391DC30DE773_var*
//#UC END# *5617F4D00243_391DC30DE773_var*
begin
//#UC START# *5617F4D00243_391DC30DE773_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_391DC30DE773_impl*
end;//TkwPopParserTokenLongString.ParamsTypes

function TkwPopParserTokenInt.TokenInt(const aCtx: TtfwContext;
 const aParser: ItfwParser): Integer;
 {* Реализация слова скрипта pop:Parser:TokenInt }
//#UC START# *9C93DFBF7BED_37FA824BDEEE_var*
//#UC END# *9C93DFBF7BED_37FA824BDEEE_var*
begin
//#UC START# *9C93DFBF7BED_37FA824BDEEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *9C93DFBF7BED_37FA824BDEEE_impl*
end;//TkwPopParserTokenInt.TokenInt

procedure TkwPopParserTokenInt.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_37FA824BDEEE_var*
//#UC END# *4DAEEDE10285_37FA824BDEEE_var*
begin
//#UC START# *4DAEEDE10285_37FA824BDEEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_37FA824BDEEE_impl*
end;//TkwPopParserTokenInt.DoDoIt

class function TkwPopParserTokenInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:TokenInt';
end;//TkwPopParserTokenInt.GetWordNameForRegister

function TkwPopParserTokenInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwPopParserTokenInt.GetResultTypeInfo

function TkwPopParserTokenInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserTokenInt.GetAllParamsCount

function TkwPopParserTokenInt.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_37FA824BDEEE_var*
//#UC END# *5617F4D00243_37FA824BDEEE_var*
begin
//#UC START# *5617F4D00243_37FA824BDEEE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_37FA824BDEEE_impl*
end;//TkwPopParserTokenInt.ParamsTypes

function TkwPopParserFileName.FileName(const aCtx: TtfwContext;
 const aParser: ItfwParser): AnsiString;
 {* Реализация слова скрипта pop:Parser:FileName }
//#UC START# *6F6E961268B2_77621D03947E_var*
//#UC END# *6F6E961268B2_77621D03947E_var*
begin
//#UC START# *6F6E961268B2_77621D03947E_impl*
 !!! Needs to be implemented !!!
//#UC END# *6F6E961268B2_77621D03947E_impl*
end;//TkwPopParserFileName.FileName

procedure TkwPopParserFileName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_77621D03947E_var*
//#UC END# *4DAEEDE10285_77621D03947E_var*
begin
//#UC START# *4DAEEDE10285_77621D03947E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_77621D03947E_impl*
end;//TkwPopParserFileName.DoDoIt

class function TkwPopParserFileName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:FileName';
end;//TkwPopParserFileName.GetWordNameForRegister

function TkwPopParserFileName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwPopParserFileName.GetResultTypeInfo

function TkwPopParserFileName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserFileName.GetAllParamsCount

function TkwPopParserFileName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_77621D03947E_var*
//#UC END# *5617F4D00243_77621D03947E_var*
begin
//#UC START# *5617F4D00243_77621D03947E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_77621D03947E_impl*
end;//TkwPopParserFileName.ParamsTypes

function TkwPopParserTokenType.TokenType(const aCtx: TtfwContext;
 const aParser: ItfwParser): Tl3TokenType;
 {* Реализация слова скрипта pop:Parser:TokenType }
//#UC START# *31C292E4C39C_5CF115AC9203_var*
//#UC END# *31C292E4C39C_5CF115AC9203_var*
begin
//#UC START# *31C292E4C39C_5CF115AC9203_impl*
 !!! Needs to be implemented !!!
//#UC END# *31C292E4C39C_5CF115AC9203_impl*
end;//TkwPopParserTokenType.TokenType

procedure TkwPopParserTokenType.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5CF115AC9203_var*
//#UC END# *4DAEEDE10285_5CF115AC9203_var*
begin
//#UC START# *4DAEEDE10285_5CF115AC9203_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5CF115AC9203_impl*
end;//TkwPopParserTokenType.DoDoIt

class function TkwPopParserTokenType.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:TokenType';
end;//TkwPopParserTokenType.GetWordNameForRegister

function TkwPopParserTokenType.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwPopParserTokenType.GetResultTypeInfo

function TkwPopParserTokenType.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserTokenType.GetAllParamsCount

function TkwPopParserTokenType.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_5CF115AC9203_var*
//#UC END# *5617F4D00243_5CF115AC9203_var*
begin
//#UC START# *5617F4D00243_5CF115AC9203_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_5CF115AC9203_impl*
end;//TkwPopParserTokenType.ParamsTypes

function TkwPopParserSourceLine.SourceLine(const aCtx: TtfwContext;
 const aParser: ItfwParser): Integer;
 {* Реализация слова скрипта pop:Parser:SourceLine }
//#UC START# *3C60D351E591_F99E43E0E32C_var*
//#UC END# *3C60D351E591_F99E43E0E32C_var*
begin
//#UC START# *3C60D351E591_F99E43E0E32C_impl*
 !!! Needs to be implemented !!!
//#UC END# *3C60D351E591_F99E43E0E32C_impl*
end;//TkwPopParserSourceLine.SourceLine

procedure TkwPopParserSourceLine.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F99E43E0E32C_var*
//#UC END# *4DAEEDE10285_F99E43E0E32C_var*
begin
//#UC START# *4DAEEDE10285_F99E43E0E32C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F99E43E0E32C_impl*
end;//TkwPopParserSourceLine.DoDoIt

class function TkwPopParserSourceLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Parser:SourceLine';
end;//TkwPopParserSourceLine.GetWordNameForRegister

function TkwPopParserSourceLine.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := ;
end;//TkwPopParserSourceLine.GetResultTypeInfo

function TkwPopParserSourceLine.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopParserSourceLine.GetAllParamsCount

function TkwPopParserSourceLine.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F99E43E0E32C_var*
//#UC END# *5617F4D00243_F99E43E0E32C_var*
begin
//#UC START# *5617F4D00243_F99E43E0E32C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F99E43E0E32C_impl*
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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwParser));
 {* Регистрация типа ItfwParser }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Tl3TokenType));
 {* Регистрация типа Tl3TokenType }
{$IfEnd} // NOT Defined(NoScripts)

end.
