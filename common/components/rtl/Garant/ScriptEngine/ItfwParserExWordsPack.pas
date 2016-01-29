unit ItfwParserExWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "ItfwParserExWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::Basics::ItfwParserExWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwScriptingInterfaces,
  tfwParserInterfaces,
  tfwClassLike,
  l3Parser
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopParserExPushString = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:ParserEx:PushString
*������:*
[code]
 aString aParserEx pop:ParserEx:PushString
[code]  }
 private
 // private methods
   procedure PushString(const aCtx: TtfwContext;
    const aParserEx: ItfwParserEx;
    const aString: Il3CString);
     {* ���������� ����� ������� pop:ParserEx:PushString }
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
 end;//TkwPopParserExPushString

// start class TkwPopParserExPushString

procedure TkwPopParserExPushString.PushString(const aCtx: TtfwContext;
  const aParserEx: ItfwParserEx;
  const aString: Il3CString);
 {-}
begin
 aParserEx.PushString(aString);
end;//TkwPopParserExPushString.PushString

procedure TkwPopParserExPushString.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aParserEx : ItfwParserEx;
 l_aString : Il3CString;
begin
 try
  l_aParserEx := ItfwParserEx(aCtx.rEngine.PopIntf(ItfwParserEx));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aParserEx: ItfwParserEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PushString(aCtx, l_aParserEx, l_aString);
end;//TkwPopParserExPushString.DoDoIt

class function TkwPopParserExPushString.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:ParserEx:PushString';
end;//TkwPopParserExPushString.GetWordNameForRegister

function TkwPopParserExPushString.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopParserExPushString.GetResultTypeInfo

function TkwPopParserExPushString.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopParserExPushString.GetAllParamsCount

function TkwPopParserExPushString.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParserEx), @tfw_tiString]);
end;//TkwPopParserExPushString.ParamsTypes

type
 TkwPopParserExPushSymbol = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:ParserEx:PushSymbol
*������:*
[code]
 aString aParserEx pop:ParserEx:PushSymbol
[code]  }
 private
 // private methods
   procedure PushSymbol(const aCtx: TtfwContext;
    const aParserEx: ItfwParserEx;
    const aString: Il3CString);
     {* ���������� ����� ������� pop:ParserEx:PushSymbol }
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
 end;//TkwPopParserExPushSymbol

// start class TkwPopParserExPushSymbol

procedure TkwPopParserExPushSymbol.PushSymbol(const aCtx: TtfwContext;
  const aParserEx: ItfwParserEx;
  const aString: Il3CString);
 {-}
begin
 aParserEx.PushSymbol(aString);
end;//TkwPopParserExPushSymbol.PushSymbol

procedure TkwPopParserExPushSymbol.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aParserEx : ItfwParserEx;
 l_aString : Il3CString;
begin
 try
  l_aParserEx := ItfwParserEx(aCtx.rEngine.PopIntf(ItfwParserEx));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aParserEx: ItfwParserEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aString := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aString: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PushSymbol(aCtx, l_aParserEx, l_aString);
end;//TkwPopParserExPushSymbol.DoDoIt

class function TkwPopParserExPushSymbol.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:ParserEx:PushSymbol';
end;//TkwPopParserExPushSymbol.GetWordNameForRegister

function TkwPopParserExPushSymbol.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopParserExPushSymbol.GetResultTypeInfo

function TkwPopParserExPushSymbol.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopParserExPushSymbol.GetAllParamsCount

function TkwPopParserExPushSymbol.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParserEx), @tfw_tiString]);
end;//TkwPopParserExPushSymbol.ParamsTypes

type
 TkwPopParserExPushInt = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:ParserEx:PushInt
*������:*
[code]
 aValue aParserEx pop:ParserEx:PushInt
[code]  }
 private
 // private methods
   procedure PushInt(const aCtx: TtfwContext;
    const aParserEx: ItfwParserEx;
    aValue: Integer);
     {* ���������� ����� ������� pop:ParserEx:PushInt }
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
 end;//TkwPopParserExPushInt

// start class TkwPopParserExPushInt

procedure TkwPopParserExPushInt.PushInt(const aCtx: TtfwContext;
  const aParserEx: ItfwParserEx;
  aValue: Integer);
 {-}
begin
 aParserEx.PushInt(aValue);
end;//TkwPopParserExPushInt.PushInt

procedure TkwPopParserExPushInt.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aParserEx : ItfwParserEx;
 l_aValue : Integer;
begin
 try
  l_aParserEx := ItfwParserEx(aCtx.rEngine.PopIntf(ItfwParserEx));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aParserEx: ItfwParserEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PushInt(aCtx, l_aParserEx, l_aValue);
end;//TkwPopParserExPushInt.DoDoIt

class function TkwPopParserExPushInt.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:ParserEx:PushInt';
end;//TkwPopParserExPushInt.GetWordNameForRegister

function TkwPopParserExPushInt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopParserExPushInt.GetResultTypeInfo

function TkwPopParserExPushInt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopParserExPushInt.GetAllParamsCount

function TkwPopParserExPushInt.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwParserEx), TypeInfo(Integer)]);
end;//TkwPopParserExPushInt.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_ParserEx_PushString
 TkwPopParserExPushString.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_ParserEx_PushSymbol
 TkwPopParserExPushSymbol.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_ParserEx_PushInt
 TkwPopParserExPushInt.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� ItfwParserEx
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwParserEx));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts

end.