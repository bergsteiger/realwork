unit kwCompiledWordWorkerWordPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWordPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "kwCompiledWordWorkerWordPack" MUID: (559428430078)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCompiledWordWorkerWord
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopCompiledWordWorkerWordCompiled = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:CompiledWordWorkerWord:Compiled }
  private
   function Compiled(const aCtx: TtfwContext;
    aCompiledWordWorkerWord: TkwCompiledWordWorkerWord): TtfwWord;
    {* ���������� ����� ������� pop:CompiledWordWorkerWord:Compiled }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopCompiledWordWorkerWordCompiled

function TkwPopCompiledWordWorkerWordCompiled.Compiled(const aCtx: TtfwContext;
 aCompiledWordWorkerWord: TkwCompiledWordWorkerWord): TtfwWord;
 {* ���������� ����� ������� pop:CompiledWordWorkerWord:Compiled }
begin
 Result := aCompiledWordWorkerWord.Compiled;
end;//TkwPopCompiledWordWorkerWordCompiled.Compiled

class function TkwPopCompiledWordWorkerWordCompiled.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:CompiledWordWorkerWord:Compiled';
end;//TkwPopCompiledWordWorkerWordCompiled.GetWordNameForRegister

function TkwPopCompiledWordWorkerWordCompiled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopCompiledWordWorkerWordCompiled.GetResultTypeInfo

function TkwPopCompiledWordWorkerWordCompiled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopCompiledWordWorkerWordCompiled.GetAllParamsCount

function TkwPopCompiledWordWorkerWordCompiled.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TkwCompiledWordWorkerWord)]);
end;//TkwPopCompiledWordWorkerWordCompiled.ParamsTypes

procedure TkwPopCompiledWordWorkerWordCompiled.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Compiled', aCtx);
end;//TkwPopCompiledWordWorkerWordCompiled.SetValuePrim

procedure TkwPopCompiledWordWorkerWordCompiled.DoDoIt(const aCtx: TtfwContext);
var l_aCompiledWordWorkerWord: TkwCompiledWordWorkerWord;
begin
 try
  l_aCompiledWordWorkerWord := TkwCompiledWordWorkerWord(aCtx.rEngine.PopObjAs(TkwCompiledWordWorkerWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aCompiledWordWorkerWord: TkwCompiledWordWorkerWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Compiled(aCtx, l_aCompiledWordWorkerWord));
end;//TkwPopCompiledWordWorkerWordCompiled.DoDoIt

initialization
 TkwPopCompiledWordWorkerWordCompiled.RegisterInEngine;
 {* ����������� pop_CompiledWordWorkerWord_Compiled }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TkwCompiledWordWorkerWord));
 {* ����������� ���� TkwCompiledWordWorkerWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* ����������� ���� TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
