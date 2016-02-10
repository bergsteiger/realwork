unit ItfwParserExWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\ItfwParserExWordsPack.pas"
// ���������: "ScriptKeywordsPack"

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
  {* ����� ������� pop:ParserEx:PushString
*������:*
[code]
 aString aParserEx pop:ParserEx:PushString
[code]  }
  private
   procedure PushString(const aCtx: TtfwContext;
    const aParserEx: ItfwParserEx;
    const aString: Il3CString);
    {* ���������� ����� ������� pop:ParserEx:PushString }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserExPushString

 TkwPopParserExPushSymbol = {final} class(TtfwClassLike)
  {* ����� ������� pop:ParserEx:PushSymbol
*������:*
[code]
 aString aParserEx pop:ParserEx:PushSymbol
[code]  }
  private
   procedure PushSymbol(const aCtx: TtfwContext;
    const aParserEx: ItfwParserEx;
    const aString: Il3CString);
    {* ���������� ����� ������� pop:ParserEx:PushSymbol }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopParserExPushSymbol

 TkwPopParserExPushInt = {final} class(TtfwClassLike)
  {* ����� ������� pop:ParserEx:PushInt
*������:*
[code]
 aValue aParserEx pop:ParserEx:PushInt
[code]  }
  private
   procedure PushInt(const aCtx: TtfwContext;
    const aParserEx: ItfwParserEx;
    aValue: Integer);
    {* ���������� ����� ������� pop:ParserEx:PushInt }
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
 {* ���������� ����� ������� pop:ParserEx:PushString }
//#UC START# *3AD2F947D123_98DC2F9223CD_var*
//#UC END# *3AD2F947D123_98DC2F9223CD_var*
begin
//#UC START# *3AD2F947D123_98DC2F9223CD_impl*
 !!! Needs to be implemented !!!
//#UC END# *3AD2F947D123_98DC2F9223CD_impl*
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
   RunnerError('������ ��� ��������� ��������� aParserEx: ItfwParserEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
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
begin
 Result := 'pop:ParserEx:PushString';
end;//TkwPopParserExPushString.GetWordNameForRegister

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

procedure TkwPopParserExPushSymbol.PushSymbol(const aCtx: TtfwContext;
 const aParserEx: ItfwParserEx;
 const aString: Il3CString);
 {* ���������� ����� ������� pop:ParserEx:PushSymbol }
//#UC START# *8CF8220B1149_1C7124538968_var*
//#UC END# *8CF8220B1149_1C7124538968_var*
begin
//#UC START# *8CF8220B1149_1C7124538968_impl*
 !!! Needs to be implemented !!!
//#UC END# *8CF8220B1149_1C7124538968_impl*
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
   RunnerError('������ ��� ��������� ��������� aParserEx: ItfwParserEx : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aString := Il3CString(aCtx.rEngine.PopString);
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
begin
 Result := 'pop:ParserEx:PushSymbol';
end;//TkwPopParserExPushSymbol.GetWordNameForRegister

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

procedure TkwPopParserExPushInt.PushInt(const aCtx: TtfwContext;
 const aParserEx: ItfwParserEx;
 aValue: Integer);
 {* ���������� ����� ������� pop:ParserEx:PushInt }
//#UC START# *1DDD13264747_E0E6B9391680_var*
//#UC END# *1DDD13264747_E0E6B9391680_var*
begin
//#UC START# *1DDD13264747_E0E6B9391680_impl*
 !!! Needs to be implemented !!!
//#UC END# *1DDD13264747_E0E6B9391680_impl*
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
begin
 Result := 'pop:ParserEx:PushInt';
end;//TkwPopParserExPushInt.GetWordNameForRegister

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

initialization
 TkwPopParserExPushString.RegisterInEngine;
 {* ����������� pop_ParserEx_PushString }
 TkwPopParserExPushSymbol.RegisterInEngine;
 {* ����������� pop_ParserEx_PushSymbol }
 TkwPopParserExPushInt.RegisterInEngine;
 {* ����������� pop_ParserEx_PushInt }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwParserEx));
 {* ����������� ���� ItfwParserEx }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
