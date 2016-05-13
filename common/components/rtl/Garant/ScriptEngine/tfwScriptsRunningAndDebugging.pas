unit tfwScriptsRunningAndDebugging;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwScriptsRunningAndDebugging.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "tfwScriptsRunningAndDebugging" MUID: (56F556230193)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptEngine
 , tfwOutToFileScriptCaller
 , tfwDebugScriptCaller
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwScriptRunFromFile = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта script:RunFromFile }
  private
   procedure script_RunFromFile(const aCtx: TtfwContext;
    const aFile: AnsiString;
    const anOutputFile: AnsiString);
    {* Реализация слова скрипта script:RunFromFile }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScriptRunFromFile

procedure TkwScriptRunFromFile.script_RunFromFile(const aCtx: TtfwContext;
 const aFile: AnsiString;
 const anOutputFile: AnsiString);
 {* Реализация слова скрипта script:RunFromFile }
//#UC START# *56F5564A035F_56F5564A035F_Word_var*
//#UC END# *56F5564A035F_56F5564A035F_Word_var*
begin
//#UC START# *56F5564A035F_56F5564A035F_Word_impl*
 if (anOutputFile = '') then
  TtfwScriptEngine.ScriptFromFile(aFile, TtfwDebugScriptCaller.Make)
 else 
  TtfwScriptEngine.ScriptFromFile(aFile, TtfwOutToFileScriptCaller.Make(anOutputFile));
//#UC END# *56F5564A035F_56F5564A035F_Word_impl*
end;//TkwScriptRunFromFile.script_RunFromFile

class function TkwScriptRunFromFile.GetWordNameForRegister: AnsiString;
begin
 Result := 'script:RunFromFile';
end;//TkwScriptRunFromFile.GetWordNameForRegister

function TkwScriptRunFromFile.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwScriptRunFromFile.GetResultTypeInfo

function TkwScriptRunFromFile.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwScriptRunFromFile.GetAllParamsCount

function TkwScriptRunFromFile.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwScriptRunFromFile.ParamsTypes

procedure TkwScriptRunFromFile.DoDoIt(const aCtx: TtfwContext);
var l_aFile: AnsiString;
var l_anOutputFile: AnsiString;
begin
 try
  l_aFile := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOutputFile := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOutputFile: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 script_RunFromFile(aCtx, l_aFile, l_anOutputFile);
end;//TkwScriptRunFromFile.DoDoIt

initialization
 TkwScriptRunFromFile.RegisterInEngine;
 {* Регистрация script_RunFromFile }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
