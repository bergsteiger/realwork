unit ItfwParserExWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ItfwParserExWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ItfwParserExWordsPack" MUID: (559BC67C0005)

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
begin
 aParserEx.PushString(aString);
end;//TkwPopParserExPushString.PushString

procedure TkwPopParserExPushString.DoDoIt(const aCtx: TtfwContext);
var l_aParserEx: ItfwParserEx;
var l_aString: Il3CString;
begin
 try
  l_aParserEx := ItfwParserEx(aCtx.rEngine.PopIntf(ItfwParserEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParserEx: ItfwParserEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PushString(aCtx, l_aParserEx, l_aString);
end;//TkwPopParserExPushString.DoDoIt

function TkwPopParserExPushString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopParserExPushString.GetResultTypeInfo

function TkwPopParserExPushString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopParserExPushString.GetAllParamsCount

function TkwPopParserExPushString.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParserEx), @tfw_tiString]);
end;//TkwPopParserExPushString.ParamsTypes

class function TkwPopParserExPushString.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ParserEx:PushString';
end;//TkwPopParserExPushString.GetWordNameForRegister

procedure TkwPopParserExPushSymbol.PushSymbol(const aCtx: TtfwContext;
 const aParserEx: ItfwParserEx;
 const aString: Il3CString);
 {* Реализация слова скрипта pop:ParserEx:PushSymbol }
begin
 aParserEx.PushSymbol(aString);
end;//TkwPopParserExPushSymbol.PushSymbol

procedure TkwPopParserExPushSymbol.DoDoIt(const aCtx: TtfwContext);
var l_aParserEx: ItfwParserEx;
var l_aString: Il3CString;
begin
 try
  l_aParserEx := ItfwParserEx(aCtx.rEngine.PopIntf(ItfwParserEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParserEx: ItfwParserEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PushSymbol(aCtx, l_aParserEx, l_aString);
end;//TkwPopParserExPushSymbol.DoDoIt

function TkwPopParserExPushSymbol.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopParserExPushSymbol.GetResultTypeInfo

function TkwPopParserExPushSymbol.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopParserExPushSymbol.GetAllParamsCount

function TkwPopParserExPushSymbol.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParserEx), @tfw_tiString]);
end;//TkwPopParserExPushSymbol.ParamsTypes

class function TkwPopParserExPushSymbol.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ParserEx:PushSymbol';
end;//TkwPopParserExPushSymbol.GetWordNameForRegister

procedure TkwPopParserExPushInt.PushInt(const aCtx: TtfwContext;
 const aParserEx: ItfwParserEx;
 aValue: Integer);
 {* Реализация слова скрипта pop:ParserEx:PushInt }
begin
 aParserEx.PushInt(aValue);
end;//TkwPopParserExPushInt.PushInt

procedure TkwPopParserExPushInt.DoDoIt(const aCtx: TtfwContext);
var l_aParserEx: ItfwParserEx;
var l_aValue: Integer;
begin
 try
  l_aParserEx := ItfwParserEx(aCtx.rEngine.PopIntf(ItfwParserEx));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParserEx: ItfwParserEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PushInt(aCtx, l_aParserEx, l_aValue);
end;//TkwPopParserExPushInt.DoDoIt

function TkwPopParserExPushInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopParserExPushInt.GetResultTypeInfo

function TkwPopParserExPushInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopParserExPushInt.GetAllParamsCount

function TkwPopParserExPushInt.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParserEx), TypeInfo(Integer)]);
end;//TkwPopParserExPushInt.ParamsTypes

class function TkwPopParserExPushInt.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ParserEx:PushInt';
end;//TkwPopParserExPushInt.GetWordNameForRegister

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
