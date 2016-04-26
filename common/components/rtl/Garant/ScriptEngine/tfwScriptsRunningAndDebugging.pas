unit tfwScriptsRunningAndDebugging;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\tfwScriptsRunningAndDebugging.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "tfwScriptsRunningAndDebugging" MUID: (56F556230193)

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
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 TkwScriptRunFromFile = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� script:RunFromFile
*������:*
[code]
 anOutputFile aFile script:RunFromFile
[code]  }
  private
   procedure script_RunFromFile(const aCtx: TtfwContext;
    const aFile: AnsiString;
    const anOutputFile: AnsiString);
    {* ���������� ����� ������� script:RunFromFile }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScriptRunFromFile

procedure TkwScriptRunFromFile.script_RunFromFile(const aCtx: TtfwContext;
 const aFile: AnsiString;
 const anOutputFile: AnsiString);
 {* ���������� ����� ������� script:RunFromFile }
//#UC START# *1DB03B13C581_7C9C5C70AAD4_var*
//#UC END# *1DB03B13C581_7C9C5C70AAD4_var*
begin
//#UC START# *1DB03B13C581_7C9C5C70AAD4_impl*
 if (anOutputFile = '') then
  TtfwScriptEngine.ScriptFromFile(aFile, TtfwDebugScriptCaller.Make)
 else 
  TtfwScriptEngine.ScriptFromFile(aFile, TtfwOutToFileScriptCaller.Make(anOutputFile));
//#UC END# *1DB03B13C581_7C9C5C70AAD4_impl*
end;//TkwScriptRunFromFile.script_RunFromFile

procedure TkwScriptRunFromFile.DoDoIt(const aCtx: TtfwContext);
var l_aFile: AnsiString;
var l_anOutputFile: AnsiString;
begin
 try
  l_aFile := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFile: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOutputFile := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anOutputFile: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 script_RunFromFile(aCtx, l_aFile, l_anOutputFile);
end;//TkwScriptRunFromFile.DoDoIt

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

class function TkwScriptRunFromFile.GetWordNameForRegister: AnsiString;
begin
 Result := 'script:RunFromFile';
end;//TkwScriptRunFromFile.GetWordNameForRegister

initialization
 TkwScriptRunFromFile.RegisterInEngine;
 {* ����������� script_RunFromFile }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� String }
{$IfEnd} // NOT Defined(NoScripts)

end.
