unit kwCompiledWordWorkerWordPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledWordWorkerWordPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledWordWorkerWord
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
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
 TkwPopCompiledWordWorkerWordCompiled = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:CompiledWordWorkerWord:Compiled
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aCompiledWordWorkerWord pop:CompiledWordWorkerWord:Compiled >>> l_TtfwWord
[code]  }
  private
   function Compiled(const aCtx: TtfwContext;
    aCompiledWordWorkerWord: TkwCompiledWordWorkerWord): TtfwWord;
    {* Реализация слова скрипта pop:CompiledWordWorkerWord:Compiled }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopCompiledWordWorkerWordCompiled

function TkwPopCompiledWordWorkerWordCompiled.Compiled(const aCtx: TtfwContext;
 aCompiledWordWorkerWord: TkwCompiledWordWorkerWord): TtfwWord;
 {* Реализация слова скрипта pop:CompiledWordWorkerWord:Compiled }
//#UC START# *E207F0F6327C_9E9D700614C3_var*
//#UC END# *E207F0F6327C_9E9D700614C3_var*
begin
//#UC START# *E207F0F6327C_9E9D700614C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *E207F0F6327C_9E9D700614C3_impl*
end;//TkwPopCompiledWordWorkerWordCompiled.Compiled

procedure TkwPopCompiledWordWorkerWordCompiled.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9E9D700614C3_var*
//#UC END# *4DAEEDE10285_9E9D700614C3_var*
begin
//#UC START# *4DAEEDE10285_9E9D700614C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9E9D700614C3_impl*
end;//TkwPopCompiledWordWorkerWordCompiled.DoDoIt

class function TkwPopCompiledWordWorkerWordCompiled.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:CompiledWordWorkerWord:Compiled';
end;//TkwPopCompiledWordWorkerWordCompiled.GetWordNameForRegister

procedure TkwPopCompiledWordWorkerWordCompiled.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_9E9D700614C3_var*
//#UC END# *52D00B00031A_9E9D700614C3_var*
begin
//#UC START# *52D00B00031A_9E9D700614C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_9E9D700614C3_impl*
end;//TkwPopCompiledWordWorkerWordCompiled.SetValuePrim

function TkwPopCompiledWordWorkerWordCompiled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9E9D700614C3_var*
//#UC END# *551544E2001A_9E9D700614C3_var*
begin
//#UC START# *551544E2001A_9E9D700614C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9E9D700614C3_impl*
end;//TkwPopCompiledWordWorkerWordCompiled.GetResultTypeInfo

function TkwPopCompiledWordWorkerWordCompiled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwPopCompiledWordWorkerWordCompiled.GetAllParamsCount

function TkwPopCompiledWordWorkerWordCompiled.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9E9D700614C3_var*
//#UC END# *5617F4D00243_9E9D700614C3_var*
begin
//#UC START# *5617F4D00243_9E9D700614C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9E9D700614C3_impl*
end;//TkwPopCompiledWordWorkerWordCompiled.ParamsTypes

initialization
 TkwPopCompiledWordWorkerWordCompiled.RegisterInEngine;
 {* Регистрация pop_CompiledWordWorkerWord_Compiled }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TkwCompiledWordWorkerWord));
 {* Регистрация типа TkwCompiledWordWorkerWord }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
