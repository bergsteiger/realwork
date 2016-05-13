unit kwKeyValuesPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\kwKeyValuesPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "kwKeyValuesPack" MUID: (567ACC1F028D)

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
 , kwKeyValues
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwKeyValuesCreate = {final} class(TtfwRegisterableWord)
  {* Слово скрипта KeyValues:Create }
  private
   function Create(const aCtx: TtfwContext): TkwKeyValues;
    {* Реализация слова скрипта KeyValues:Create }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwKeyValuesCreate

function TkwKeyValuesCreate.Create(const aCtx: TtfwContext): TkwKeyValues;
 {* Реализация слова скрипта KeyValues:Create }
//#UC START# *567ACC37033D_6CD721531904_var*
//#UC END# *567ACC37033D_6CD721531904_var*
begin
//#UC START# *567ACC37033D_6CD721531904_impl*
 Result := TkwKeyValues.Create(nil{Prodicer}, Self{nil}{Finder}, aCtx.rTypeInfo, aCtx, {nil}Key);
//#UC END# *567ACC37033D_6CD721531904_impl*
end;//TkwKeyValuesCreate.Create

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

procedure TkwKeyValuesCreate.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushObj(Create(aCtx));
end;//TkwKeyValuesCreate.DoDoIt

initialization
 TkwKeyValuesCreate.RegisterInEngine;
 {* Регистрация KeyValues_Create }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TkwKeyValues));
 {* Регистрация типа TkwKeyValues }
{$IfEnd} // NOT Defined(NoScripts)

end.
