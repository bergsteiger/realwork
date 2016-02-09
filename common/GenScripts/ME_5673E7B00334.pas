unit kwCompiledProcedureWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwCompiledProcedure
 , tfwRegisterableWord
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
 TkwCompiledProcedureCreate = {final} class(TtfwRegisterableWord)
  {* Слово скрипта CompiledProcedure:Create
*Тип результата:* TkwCompiledProcedure
*Пример:*
[code]
OBJECT VAR l_TkwCompiledProcedure
 CompiledProcedure:Create >>> l_TkwCompiledProcedure
[code]  }
  private
   function Create(const aCtx: TtfwContext): TkwCompiledProcedure;
    {* Реализация слова скрипта CompiledProcedure:Create }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompiledProcedureCreate

function TkwCompiledProcedureCreate.Create(const aCtx: TtfwContext): TkwCompiledProcedure;
 {* Реализация слова скрипта CompiledProcedure:Create }
//#UC START# *8C9C82BDE803_87E51971436F_var*
//#UC END# *8C9C82BDE803_87E51971436F_var*
begin
//#UC START# *8C9C82BDE803_87E51971436F_impl*
 Result := TkwCompiledProcedure.Create(nil{Prodicer}, Self{nil}{Finder}, aCtx.rTypeInfo, aCtx, {nil}Key);
//#UC END# *8C9C82BDE803_87E51971436F_impl*
end;//TkwCompiledProcedureCreate.Create

procedure TkwCompiledProcedureCreate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_87E51971436F_var*
//#UC END# *4DAEEDE10285_87E51971436F_var*
begin
//#UC START# *4DAEEDE10285_87E51971436F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_87E51971436F_impl*
end;//TkwCompiledProcedureCreate.DoDoIt

class function TkwCompiledProcedureCreate.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompiledProcedure:Create';
end;//TkwCompiledProcedureCreate.GetWordNameForRegister

function TkwCompiledProcedureCreate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_87E51971436F_var*
//#UC END# *551544E2001A_87E51971436F_var*
begin
//#UC START# *551544E2001A_87E51971436F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_87E51971436F_impl*
end;//TkwCompiledProcedureCreate.GetResultTypeInfo

function TkwCompiledProcedureCreate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCompiledProcedureCreate.GetAllParamsCount

function TkwCompiledProcedureCreate.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_87E51971436F_var*
//#UC END# *5617F4D00243_87E51971436F_var*
begin
//#UC START# *5617F4D00243_87E51971436F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_87E51971436F_impl*
end;//TkwCompiledProcedureCreate.ParamsTypes

initialization
 TkwCompiledProcedureCreate.RegisterInEngine;
 {* Регистрация CompiledProcedure_Create }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TkwCompiledProcedure));
 {* Регистрация типа TkwCompiledProcedure }
{$IfEnd} // NOT Defined(NoScripts)

end.
