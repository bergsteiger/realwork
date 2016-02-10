unit TTableConvParamDialogWordsPack;

// Модуль: "w:\archi\source\projects\Common\Dialogs\TTableConvParamDialogWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include arCommon.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ddTableConvParamDlg
 , tfwClassLike
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
 TkwPopTableConvParamDialogFake = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TableConvParamDialog:Fake
*Пример:*
[code]
 aTableConvParamDialog pop:TableConvParamDialog:Fake
[code]  }
  private
   procedure Fake(const aCtx: TtfwContext;
    aTableConvParamDialog: TTableConvParamDialog);
    {* Реализация слова скрипта pop:TableConvParamDialog:Fake }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTableConvParamDialogFake

procedure TkwPopTableConvParamDialogFake.Fake(const aCtx: TtfwContext;
 aTableConvParamDialog: TTableConvParamDialog);
 {* Реализация слова скрипта pop:TableConvParamDialog:Fake }
//#UC START# *C4A5B2BD74DF_0BE0E0D34519_var*
//#UC END# *C4A5B2BD74DF_0BE0E0D34519_var*
begin
//#UC START# *C4A5B2BD74DF_0BE0E0D34519_impl*
 RunnerError('fake-метод только для регистрации класса формы', aCtx);
//#UC END# *C4A5B2BD74DF_0BE0E0D34519_impl*
end;//TkwPopTableConvParamDialogFake.Fake

procedure TkwPopTableConvParamDialogFake.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0BE0E0D34519_var*
//#UC END# *4DAEEDE10285_0BE0E0D34519_var*
begin
//#UC START# *4DAEEDE10285_0BE0E0D34519_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0BE0E0D34519_impl*
end;//TkwPopTableConvParamDialogFake.DoDoIt

class function TkwPopTableConvParamDialogFake.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:TableConvParamDialog:Fake';
end;//TkwPopTableConvParamDialogFake.GetWordNameForRegister

function TkwPopTableConvParamDialogFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopTableConvParamDialogFake.GetResultTypeInfo

function TkwPopTableConvParamDialogFake.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTableConvParamDialogFake.GetAllParamsCount

function TkwPopTableConvParamDialogFake.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwPopTableConvParamDialogFake.ParamsTypes

initialization
 TkwPopTableConvParamDialogFake.RegisterInEngine;
 {* Регистрация pop_TableConvParamDialog_Fake }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTableConvParamDialog));
 {* Регистрация типа TTableConvParamDialog }
{$IfEnd} // NOT Defined(NoScripts)

end.
