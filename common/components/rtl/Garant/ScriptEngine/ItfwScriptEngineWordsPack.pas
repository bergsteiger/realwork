unit ItfwScriptEngineWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\ItfwScriptEngineWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ItfwScriptEngineWordsPack" MUID: (559BD7E00278)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
 , tfwTypeInfo
 , l3Variant
 , tfwScriptingInterfaces
 , Types
 , tfwDictionaryPrim
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , tfwDictionaryEx
 , tfwDictionaryExWordsPack
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopScriptEngineAsKeywordFinder = {final} class(TtfwClassLike)
  {* ����� ������� pop:ScriptEngine:AsKeywordFinder }
  private
   function AsKeywordFinder(const aCtx: TtfwContext;
    const aScriptEngine: ItfwScriptEngine): TtfwKeywordFinder;
    {* ���������� ����� ������� pop:ScriptEngine:AsKeywordFinder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopScriptEngineAsKeywordFinder

 TkwPopScriptEngineAddInitialization = {final} class(TtfwClassLike)
  {* ����� ������� pop:ScriptEngine:AddInitialization }
  private
   procedure AddInitialization(const aCtx: TtfwContext;
    const aScriptEngine: ItfwScriptEngine;
    aWord: TtfwWord);
    {* ���������� ����� ������� pop:ScriptEngine:AddInitialization }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopScriptEngineAddInitialization

 TkwPopScriptEngineCurrentCompilingDictionary = {final} class(TtfwClassLike)
  {* ����� ������� pop:ScriptEngine:CurrentCompilingDictionary }
  private
   function CurrentCompilingDictionary(const aCtx: TtfwContext;
    const aScriptEngine: ItfwScriptEngine): TtfwDictionaryEx;
    {* ���������� ����� ������� pop:ScriptEngine:CurrentCompilingDictionary }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopScriptEngineCurrentCompilingDictionary

 TkwPopScriptEngineDisableForHelp = {final} class(TtfwClassLike)
  {* ����� ������� pop:ScriptEngine:DisableForHelp }
  private
   procedure DisableForHelp(const aCtx: TtfwContext;
    const aScriptEngine: ItfwScriptEngine;
    aWord: TtfwWord);
    {* ���������� ����� ������� pop:ScriptEngine:DisableForHelp }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopScriptEngineDisableForHelp

function TkwPopScriptEngineAsKeywordFinder.AsKeywordFinder(const aCtx: TtfwContext;
 const aScriptEngine: ItfwScriptEngine): TtfwKeywordFinder;
 {* ���������� ����� ������� pop:ScriptEngine:AsKeywordFinder }
//#UC START# *559BD88103B1_63D6AB9D9B8E_var*
//#UC END# *559BD88103B1_63D6AB9D9B8E_var*
begin
//#UC START# *559BD88103B1_63D6AB9D9B8E_impl*
 Result := aScriptEngine.KeywordFinder(aCtx);
//#UC END# *559BD88103B1_63D6AB9D9B8E_impl*
end;//TkwPopScriptEngineAsKeywordFinder.AsKeywordFinder

procedure TkwPopScriptEngineAsKeywordFinder.DoDoIt(const aCtx: TtfwContext);
var l_aScriptEngine: ItfwScriptEngine;
begin
 try
  l_aScriptEngine := ItfwScriptEngine(aCtx.rEngine.PopIntf(ItfwScriptEngine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aScriptEngine: ItfwScriptEngine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(AsKeywordFinder(aCtx, l_aScriptEngine));
end;//TkwPopScriptEngineAsKeywordFinder.DoDoIt

class function TkwPopScriptEngineAsKeywordFinder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScriptEngine:AsKeywordFinder';
end;//TkwPopScriptEngineAsKeywordFinder.GetWordNameForRegister

function TkwPopScriptEngineAsKeywordFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeywordFinder);
end;//TkwPopScriptEngineAsKeywordFinder.GetResultTypeInfo

function TkwPopScriptEngineAsKeywordFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopScriptEngineAsKeywordFinder.GetAllParamsCount

function TkwPopScriptEngineAsKeywordFinder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwScriptEngine)]);
end;//TkwPopScriptEngineAsKeywordFinder.ParamsTypes

procedure TkwPopScriptEngineAddInitialization.AddInitialization(const aCtx: TtfwContext;
 const aScriptEngine: ItfwScriptEngine;
 aWord: TtfwWord);
 {* ���������� ����� ������� pop:ScriptEngine:AddInitialization }
//#UC START# *55A3DFCE00D9_F4290567147F_var*
//#UC END# *55A3DFCE00D9_F4290567147F_var*
begin
//#UC START# *55A3DFCE00D9_F4290567147F_impl*
 aCtx.rEngine.AddInitialization(aCtx, aWord);
//#UC END# *55A3DFCE00D9_F4290567147F_impl*
end;//TkwPopScriptEngineAddInitialization.AddInitialization

procedure TkwPopScriptEngineAddInitialization.DoDoIt(const aCtx: TtfwContext);
var l_aScriptEngine: ItfwScriptEngine;
var l_aWord: TtfwWord;
begin
 try
  l_aScriptEngine := ItfwScriptEngine(aCtx.rEngine.PopIntf(ItfwScriptEngine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aScriptEngine: ItfwScriptEngine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 AddInitialization(aCtx, l_aScriptEngine, l_aWord);
end;//TkwPopScriptEngineAddInitialization.DoDoIt

class function TkwPopScriptEngineAddInitialization.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScriptEngine:AddInitialization';
end;//TkwPopScriptEngineAddInitialization.GetWordNameForRegister

function TkwPopScriptEngineAddInitialization.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopScriptEngineAddInitialization.GetResultTypeInfo

function TkwPopScriptEngineAddInitialization.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopScriptEngineAddInitialization.GetAllParamsCount

function TkwPopScriptEngineAddInitialization.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwScriptEngine), TypeInfo(TtfwWord)]);
end;//TkwPopScriptEngineAddInitialization.ParamsTypes

function TkwPopScriptEngineCurrentCompilingDictionary.CurrentCompilingDictionary(const aCtx: TtfwContext;
 const aScriptEngine: ItfwScriptEngine): TtfwDictionaryEx;
 {* ���������� ����� ������� pop:ScriptEngine:CurrentCompilingDictionary }
//#UC START# *55AE5A4303B3_1C1FE481A9C3_var*
//#UC END# *55AE5A4303B3_1C1FE481A9C3_var*
begin
//#UC START# *55AE5A4303B3_1C1FE481A9C3_impl*
 Result := aScriptEngine.CurrentCompilingDictionary As TtfwDictionaryEx;
//#UC END# *55AE5A4303B3_1C1FE481A9C3_impl*
end;//TkwPopScriptEngineCurrentCompilingDictionary.CurrentCompilingDictionary

procedure TkwPopScriptEngineCurrentCompilingDictionary.DoDoIt(const aCtx: TtfwContext);
var l_aScriptEngine: ItfwScriptEngine;
begin
 try
  l_aScriptEngine := ItfwScriptEngine(aCtx.rEngine.PopIntf(ItfwScriptEngine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aScriptEngine: ItfwScriptEngine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CurrentCompilingDictionary(aCtx, l_aScriptEngine));
end;//TkwPopScriptEngineCurrentCompilingDictionary.DoDoIt

class function TkwPopScriptEngineCurrentCompilingDictionary.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScriptEngine:CurrentCompilingDictionary';
end;//TkwPopScriptEngineCurrentCompilingDictionary.GetWordNameForRegister

function TkwPopScriptEngineCurrentCompilingDictionary.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwDictionaryEx);
end;//TkwPopScriptEngineCurrentCompilingDictionary.GetResultTypeInfo

function TkwPopScriptEngineCurrentCompilingDictionary.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopScriptEngineCurrentCompilingDictionary.GetAllParamsCount

function TkwPopScriptEngineCurrentCompilingDictionary.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwScriptEngine)]);
end;//TkwPopScriptEngineCurrentCompilingDictionary.ParamsTypes

procedure TkwPopScriptEngineDisableForHelp.DisableForHelp(const aCtx: TtfwContext;
 const aScriptEngine: ItfwScriptEngine;
 aWord: TtfwWord);
 {* ���������� ����� ������� pop:ScriptEngine:DisableForHelp }
//#UC START# *55AFBAE40273_B7DCC24F906E_var*
//#UC END# *55AFBAE40273_B7DCC24F906E_var*
begin
//#UC START# *55AFBAE40273_B7DCC24F906E_impl*
 aScriptEngine.DisableForHelp(aWord);
//#UC END# *55AFBAE40273_B7DCC24F906E_impl*
end;//TkwPopScriptEngineDisableForHelp.DisableForHelp

procedure TkwPopScriptEngineDisableForHelp.DoDoIt(const aCtx: TtfwContext);
var l_aScriptEngine: ItfwScriptEngine;
var l_aWord: TtfwWord;
begin
 try
  l_aScriptEngine := ItfwScriptEngine(aCtx.rEngine.PopIntf(ItfwScriptEngine));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aScriptEngine: ItfwScriptEngine : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DisableForHelp(aCtx, l_aScriptEngine, l_aWord);
end;//TkwPopScriptEngineDisableForHelp.DoDoIt

class function TkwPopScriptEngineDisableForHelp.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScriptEngine:DisableForHelp';
end;//TkwPopScriptEngineDisableForHelp.GetWordNameForRegister

function TkwPopScriptEngineDisableForHelp.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopScriptEngineDisableForHelp.GetResultTypeInfo

function TkwPopScriptEngineDisableForHelp.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopScriptEngineDisableForHelp.GetAllParamsCount

function TkwPopScriptEngineDisableForHelp.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwScriptEngine), TypeInfo(TtfwWord)]);
end;//TkwPopScriptEngineDisableForHelp.ParamsTypes

initialization
 TkwPopScriptEngineAsKeywordFinder.RegisterInEngine;
 {* ����������� pop_ScriptEngine_AsKeywordFinder }
 TkwPopScriptEngineAddInitialization.RegisterInEngine;
 {* ����������� pop_ScriptEngine_AddInitialization }
 TkwPopScriptEngineCurrentCompilingDictionary.RegisterInEngine;
 {* ����������� pop_ScriptEngine_CurrentCompilingDictionary }
 TkwPopScriptEngineDisableForHelp.RegisterInEngine;
 {* ����������� pop_ScriptEngine_DisableForHelp }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwScriptEngine));
 {* ����������� ���� ItfwScriptEngine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
 {* ����������� ���� TtfwKeywordFinder }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwDictionaryEx));
 {* ����������� ���� TtfwDictionaryEx }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* ����������� ���� TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
