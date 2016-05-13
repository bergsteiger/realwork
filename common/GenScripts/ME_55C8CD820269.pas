unit TTableConvParamDialogWordsPack;

// Модуль: "w:\archi\source\projects\Common\Dialogs\TTableConvParamDialogWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TTableConvParamDialogWordsPack" MUID: (55C8CD820269)

{$Include w:\archi\source\projects\Common\arCommon.inc}

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
 , ddTableConvParamDlg
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopTableConvParamDialogFake = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TableConvParamDialog:Fake }
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
//#UC START# *55C8CE120197_0BE0E0D34519_var*
//#UC END# *55C8CE120197_0BE0E0D34519_var*
begin
//#UC START# *55C8CE120197_0BE0E0D34519_impl*
 RunnerError('fake-метод только для регистрации класса формы', aCtx);
//#UC END# *55C8CE120197_0BE0E0D34519_impl*
end;//TkwPopTableConvParamDialogFake.Fake

procedure TkwPopTableConvParamDialogFake.DoDoIt(const aCtx: TtfwContext);
var l_aTableConvParamDialog: TTableConvParamDialog;
begin
 try
  l_aTableConvParamDialog := TTableConvParamDialog(aCtx.rEngine.PopObjAs(TTableConvParamDialog));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTableConvParamDialog: TTableConvParamDialog : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Fake(aCtx, l_aTableConvParamDialog);
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
 Result := OpenTypesToTypes([TypeInfo(TTableConvParamDialog)]);
end;//TkwPopTableConvParamDialogFake.ParamsTypes

initialization
 TkwPopTableConvParamDialogFake.RegisterInEngine;
 {* Регистрация pop_TableConvParamDialog_Fake }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTableConvParamDialog));
 {* Регистрация типа TTableConvParamDialog }
{$IfEnd} // NOT Defined(NoScripts)

end.
