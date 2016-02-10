unit tfwWordBoxPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwWordBoxPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , WordsRTTIPack
 , tfwScriptingInterfaces
 , tfwClassLike
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
 TkwPopWordBoxBoxed = {final} class(TtfwClassLike)
  {* Слово скрипта pop:WordBox:Boxed
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aWordBox pop:WordBox:Boxed >>> l_TtfwWord
[code]  }
  private
   function Boxed(const aCtx: TtfwContext;
    const aWordBox: ItfwWordBox): TtfwWord;
    {* Реализация слова скрипта pop:WordBox:Boxed }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopWordBoxBoxed

function TkwPopWordBoxBoxed.Boxed(const aCtx: TtfwContext;
 const aWordBox: ItfwWordBox): TtfwWord;
 {* Реализация слова скрипта pop:WordBox:Boxed }
//#UC START# *B9B1A8117301_72ECED106E06_var*
//#UC END# *B9B1A8117301_72ECED106E06_var*
begin
//#UC START# *B9B1A8117301_72ECED106E06_impl*
 Result := aWordBox.Boxed;
//#UC END# *B9B1A8117301_72ECED106E06_impl*
end;//TkwPopWordBoxBoxed.Boxed

procedure TkwPopWordBoxBoxed.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_72ECED106E06_var*
//#UC END# *4DAEEDE10285_72ECED106E06_var*
begin
//#UC START# *4DAEEDE10285_72ECED106E06_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_72ECED106E06_impl*
end;//TkwPopWordBoxBoxed.DoDoIt

class function TkwPopWordBoxBoxed.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:WordBox:Boxed';
end;//TkwPopWordBoxBoxed.GetWordNameForRegister

function TkwPopWordBoxBoxed.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopWordBoxBoxed.GetResultTypeInfo

function TkwPopWordBoxBoxed.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopWordBoxBoxed.GetAllParamsCount

function TkwPopWordBoxBoxed.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_72ECED106E06_var*
//#UC END# *5617F4D00243_72ECED106E06_var*
begin
//#UC START# *5617F4D00243_72ECED106E06_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_72ECED106E06_impl*
end;//TkwPopWordBoxBoxed.ParamsTypes

initialization
 TkwPopWordBoxBoxed.RegisterInEngine;
 {* Регистрация pop_WordBox_Boxed }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwWordBox));
 {* Регистрация типа ItfwWordBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
