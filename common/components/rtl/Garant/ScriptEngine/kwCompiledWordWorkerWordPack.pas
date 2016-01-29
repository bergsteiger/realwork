unit kwCompiledWordWorkerWordPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine"
// Модуль: "kwCompiledWordWorkerWordPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine::Scripting Axiomatics::kwCompiledWordWorkerWordPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  kwCompiledWordWorkerWord,
  tfwPropertyLike
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
 TkwPopCompiledWordWorkerWordCompiled = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:CompiledWordWorkerWord:Compiled
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aCompiledWordWorkerWord pop:CompiledWordWorkerWord:Compiled >>> l_TtfwWord
[code]  }
 private
 // private methods
   function Compiled(const aCtx: TtfwContext;
    aCompiledWordWorkerWord: TkwCompiledWordWorkerWord): TtfwWord;
     {* Реализация слова скрипта pop:CompiledWordWorkerWord:Compiled }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompiledWordWorkerWordCompiled

// start class TkwPopCompiledWordWorkerWordCompiled

function TkwPopCompiledWordWorkerWordCompiled.Compiled(const aCtx: TtfwContext;
  aCompiledWordWorkerWord: TkwCompiledWordWorkerWord): TtfwWord;
 {-}
begin
 Result := aCompiledWordWorkerWord.Compiled;
end;//TkwPopCompiledWordWorkerWordCompiled.Compiled

procedure TkwPopCompiledWordWorkerWordCompiled.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aCompiledWordWorkerWord : TkwCompiledWordWorkerWord;
begin
 try
  l_aCompiledWordWorkerWord := TkwCompiledWordWorkerWord(aCtx.rEngine.PopObjAs(TkwCompiledWordWorkerWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCompiledWordWorkerWord: TkwCompiledWordWorkerWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((Compiled(aCtx, l_aCompiledWordWorkerWord)));
end;//TkwPopCompiledWordWorkerWordCompiled.DoDoIt

class function TkwPopCompiledWordWorkerWordCompiled.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:CompiledWordWorkerWord:Compiled';
end;//TkwPopCompiledWordWorkerWordCompiled.GetWordNameForRegister

procedure TkwPopCompiledWordWorkerWordCompiled.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Compiled', aCtx);
end;//TkwPopCompiledWordWorkerWordCompiled.SetValuePrim

function TkwPopCompiledWordWorkerWordCompiled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopCompiledWordWorkerWordCompiled.GetResultTypeInfo

function TkwPopCompiledWordWorkerWordCompiled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopCompiledWordWorkerWordCompiled.GetAllParamsCount

function TkwPopCompiledWordWorkerWordCompiled.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TkwCompiledWordWorkerWord)]);
end;//TkwPopCompiledWordWorkerWordCompiled.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация pop_CompiledWordWorkerWord_Compiled
 TkwPopCompiledWordWorkerWordCompiled.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TkwCompiledWordWorkerWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TkwCompiledWordWorkerWord));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
{$IfEnd} //not NoScripts

end.