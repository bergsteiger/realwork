unit ItfwParserExWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ItfwParserExWordsPack.pas"
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
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopParserExPushString = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ParserEx:PushString
*Пример:*
[code]
 aString aParserEx pop:ParserEx:PushString
[code]  }
  private
   procedure PushString(const aCtx: TtfwContext;
    const aParserEx: ItfwParserEx;
    const aString: Il3CString);
    {* Реализация слова скрипта pop:ParserEx:PushString }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserExPushString

 TkwPopParserExPushSymbol = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ParserEx:PushSymbol
*Пример:*
[code]
 aString aParserEx pop:ParserEx:PushSymbol
[code]  }
  private
   procedure PushSymbol(const aCtx: TtfwContext;
    const aParserEx: ItfwParserEx;
    const aString: Il3CString);
    {* Реализация слова скрипта pop:ParserEx:PushSymbol }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserExPushSymbol

 TkwPopParserExPushInt = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ParserEx:PushInt
*Пример:*
[code]
 aValue aParserEx pop:ParserEx:PushInt
[code]  }
  private
   procedure PushInt(const aCtx: TtfwContext;
    const aParserEx: ItfwParserEx;
    aValue: Integer);
    {* Реализация слова скрипта pop:ParserEx:PushInt }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserExPushInt

procedure TkwPopParserExPushString.PushString(const aCtx: TtfwContext;
 const aParserEx: ItfwParserEx;
 const aString: Il3CString);
 {* Реализация слова скрипта pop:ParserEx:PushString }
//#UC START# *3AD2F947D123_98DC2F9223CD_var*
//#UC END# *3AD2F947D123_98DC2F9223CD_var*
begin
//#UC START# *3AD2F947D123_98DC2F9223CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *3AD2F947D123_98DC2F9223CD_impl*
end;//TkwPopParserExPushString.PushString

procedure TkwPopParserExPushString.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_98DC2F9223CD_var*
//#UC END# *4DAEEDE10285_98DC2F9223CD_var*
begin
//#UC START# *4DAEEDE10285_98DC2F9223CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_98DC2F9223CD_impl*
end;//TkwPopParserExPushString.DoDoIt

class function TkwPopParserExPushString.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ParserEx:PushString';
end;//TkwPopParserExPushString.GetWordNameForRegister

function TkwPopParserExPushString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_98DC2F9223CD_var*
//#UC END# *551544E2001A_98DC2F9223CD_var*
begin
//#UC START# *551544E2001A_98DC2F9223CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_98DC2F9223CD_impl*
end;//TkwPopParserExPushString.GetResultTypeInfo

function TkwPopParserExPushString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_98DC2F9223CD_var*
//#UC END# *559687E6025A_98DC2F9223CD_var*
begin
//#UC START# *559687E6025A_98DC2F9223CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_98DC2F9223CD_impl*
end;//TkwPopParserExPushString.GetAllParamsCount

function TkwPopParserExPushString.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_98DC2F9223CD_var*
//#UC END# *5617F4D00243_98DC2F9223CD_var*
begin
//#UC START# *5617F4D00243_98DC2F9223CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_98DC2F9223CD_impl*
end;//TkwPopParserExPushString.ParamsTypes

procedure TkwPopParserExPushSymbol.PushSymbol(const aCtx: TtfwContext;
 const aParserEx: ItfwParserEx;
 const aString: Il3CString);
 {* Реализация слова скрипта pop:ParserEx:PushSymbol }
//#UC START# *8CF8220B1149_1C7124538968_var*
//#UC END# *8CF8220B1149_1C7124538968_var*
begin
//#UC START# *8CF8220B1149_1C7124538968_impl*
 !!! Needs to be implemented !!!
//#UC END# *8CF8220B1149_1C7124538968_impl*
end;//TkwPopParserExPushSymbol.PushSymbol

procedure TkwPopParserExPushSymbol.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1C7124538968_var*
//#UC END# *4DAEEDE10285_1C7124538968_var*
begin
//#UC START# *4DAEEDE10285_1C7124538968_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1C7124538968_impl*
end;//TkwPopParserExPushSymbol.DoDoIt

class function TkwPopParserExPushSymbol.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ParserEx:PushSymbol';
end;//TkwPopParserExPushSymbol.GetWordNameForRegister

function TkwPopParserExPushSymbol.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1C7124538968_var*
//#UC END# *551544E2001A_1C7124538968_var*
begin
//#UC START# *551544E2001A_1C7124538968_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1C7124538968_impl*
end;//TkwPopParserExPushSymbol.GetResultTypeInfo

function TkwPopParserExPushSymbol.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_1C7124538968_var*
//#UC END# *559687E6025A_1C7124538968_var*
begin
//#UC START# *559687E6025A_1C7124538968_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_1C7124538968_impl*
end;//TkwPopParserExPushSymbol.GetAllParamsCount

function TkwPopParserExPushSymbol.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1C7124538968_var*
//#UC END# *5617F4D00243_1C7124538968_var*
begin
//#UC START# *5617F4D00243_1C7124538968_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1C7124538968_impl*
end;//TkwPopParserExPushSymbol.ParamsTypes

procedure TkwPopParserExPushInt.PushInt(const aCtx: TtfwContext;
 const aParserEx: ItfwParserEx;
 aValue: Integer);
 {* Реализация слова скрипта pop:ParserEx:PushInt }
//#UC START# *1DDD13264747_E0E6B9391680_var*
//#UC END# *1DDD13264747_E0E6B9391680_var*
begin
//#UC START# *1DDD13264747_E0E6B9391680_impl*
 !!! Needs to be implemented !!!
//#UC END# *1DDD13264747_E0E6B9391680_impl*
end;//TkwPopParserExPushInt.PushInt

procedure TkwPopParserExPushInt.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E0E6B9391680_var*
//#UC END# *4DAEEDE10285_E0E6B9391680_var*
begin
//#UC START# *4DAEEDE10285_E0E6B9391680_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E0E6B9391680_impl*
end;//TkwPopParserExPushInt.DoDoIt

class function TkwPopParserExPushInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ParserEx:PushInt';
end;//TkwPopParserExPushInt.GetWordNameForRegister

function TkwPopParserExPushInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E0E6B9391680_var*
//#UC END# *551544E2001A_E0E6B9391680_var*
begin
//#UC START# *551544E2001A_E0E6B9391680_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E0E6B9391680_impl*
end;//TkwPopParserExPushInt.GetResultTypeInfo

function TkwPopParserExPushInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_E0E6B9391680_var*
//#UC END# *559687E6025A_E0E6B9391680_var*
begin
//#UC START# *559687E6025A_E0E6B9391680_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_E0E6B9391680_impl*
end;//TkwPopParserExPushInt.GetAllParamsCount

function TkwPopParserExPushInt.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E0E6B9391680_var*
//#UC END# *5617F4D00243_E0E6B9391680_var*
begin
//#UC START# *5617F4D00243_E0E6B9391680_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E0E6B9391680_impl*
end;//TkwPopParserExPushInt.ParamsTypes

initialization
 TkwPopParserExPushString.RegisterInEngine;
 {* Регистрация pop_ParserEx_PushString }
 TkwPopParserExPushSymbol.RegisterInEngine;
 {* Регистрация pop_ParserEx_PushSymbol }
 TkwPopParserExPushInt.RegisterInEngine;
 {* Регистрация pop_ParserEx_PushInt }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwParserEx));
 {* Регистрация типа ItfwParserEx }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
