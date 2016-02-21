unit kwKeyValuesPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwKeyValuesPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwKeyValues
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwKeyValuesCreate = {final} class(TtfwRegisterableWord)
  {* Слово скрипта KeyValues:Create
*Тип результата:* TkwKeyValues
*Пример:*
[code]
OBJECT VAR l_TkwKeyValues
 KeyValues:Create >>> l_TkwKeyValues
[code]  }
  private
   function Create(const aCtx: TtfwContext): TkwKeyValues;
    {* Реализация слова скрипта KeyValues:Create }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwKeyValuesCreate

function TkwKeyValuesCreate.Create(const aCtx: TtfwContext): TkwKeyValues;
 {* Реализация слова скрипта KeyValues:Create }
//#UC START# *7E12612EF455_6CD721531904_var*
//#UC END# *7E12612EF455_6CD721531904_var*
begin
//#UC START# *7E12612EF455_6CD721531904_impl*
 Result := TkwKeyValues.Create(nil{Prodicer}, Self{nil}{Finder}, aCtx.rTypeInfo, aCtx, {nil}Key);
//#UC END# *7E12612EF455_6CD721531904_impl*
end;//TkwKeyValuesCreate.Create

procedure TkwKeyValuesCreate.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Create(aCtx));
end;//TkwKeyValuesCreate.DoDoIt

class function TkwKeyValuesCreate.GetWordNameForRegister: AnsiString;
begin
 Result := 'KeyValues:Create';
end;//TkwKeyValuesCreate.GetWordNameForRegister

function TkwKeyValuesCreate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TkwKeyValues);
end;//TkwKeyValuesCreate.GetResultTypeInfo

function TkwKeyValuesCreate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwKeyValuesCreate.GetAllParamsCount

function TkwKeyValuesCreate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TkwKeyValues)]);
end;//TkwKeyValuesCreate.ParamsTypes

initialization
 TkwKeyValuesCreate.RegisterInEngine;
 {* Регистрация KeyValues_Create }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TkwKeyValues));
 {* Регистрация типа TkwKeyValues }
{$IfEnd} // NOT Defined(NoScripts)

end.
