unit kwCompiledProcedureWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwCompiledProcedureWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "kwCompiledProcedureWordsPack" MUID: (5673E7B00334)

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
 , kwCompiledProcedure
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *5673E7B00334impl_uses*
 //#UC END# *5673E7B00334impl_uses*
;

type
 TkwCompiledProcedureCreate = {final} class(TtfwClassLike)
  {* Слово скрипта CompiledProcedure:Create }
  private
   function Create(const aCtx: TtfwContext): TkwCompiledProcedure;
    {* Реализация слова скрипта CompiledProcedure:Create }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompiledProcedureCreate

function TkwCompiledProcedureCreate.Create(const aCtx: TtfwContext): TkwCompiledProcedure;
 {* Реализация слова скрипта CompiledProcedure:Create }
//#UC START# *5673E7D50121_5673E7D50121_4F216D8D01A0_Word_var*
//#UC END# *5673E7D50121_5673E7D50121_4F216D8D01A0_Word_var*
begin
//#UC START# *5673E7D50121_5673E7D50121_4F216D8D01A0_Word_impl*
 Result := TkwCompiledProcedure.Create(nil{Prodicer}, Self{nil}{Finder}, aCtx.rTypeInfo, aCtx, {nil}Key);
//#UC END# *5673E7D50121_5673E7D50121_4F216D8D01A0_Word_impl*
end;//TkwCompiledProcedureCreate.Create

class function TkwCompiledProcedureCreate.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompiledProcedure:Create';
end;//TkwCompiledProcedureCreate.GetWordNameForRegister

function TkwCompiledProcedureCreate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TkwCompiledProcedure);
end;//TkwCompiledProcedureCreate.GetResultTypeInfo

function TkwCompiledProcedureCreate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwCompiledProcedureCreate.GetAllParamsCount

function TkwCompiledProcedureCreate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TkwCompiledProcedure)]);
end;//TkwCompiledProcedureCreate.ParamsTypes

procedure TkwCompiledProcedureCreate.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Create(aCtx));
end;//TkwCompiledProcedureCreate.DoDoIt

initialization
 TkwCompiledProcedureCreate.RegisterInEngine;
 {* Регистрация CompiledProcedure_Create }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TkwCompiledProcedure));
 {* Регистрация типа TkwCompiledProcedure }
{$IfEnd} // NOT Defined(NoScripts)

end.
