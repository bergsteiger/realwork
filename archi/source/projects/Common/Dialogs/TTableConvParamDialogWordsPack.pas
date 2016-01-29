unit TTableConvParamDialogWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Dialogs"
// Модуль: "w:/archi/source/projects/Common/Dialogs/TTableConvParamDialogWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$common::Dialogs::Dialogs::TTableConvParamDialogWordsPack
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Common\arCommon.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  ddTableConvParamDlg,
  tfwRegisterableWord
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
 TkwPopTableConvParamDialogFake = {final scriptword} class(TtfwRegisterableWord)
  {* Слово скрипта pop:TableConvParamDialog:Fake
*Пример:*
[code]
 aTableConvParamDialog pop:TableConvParamDialog:Fake
[code]  }
 private
 // private methods
   procedure Fake(const aCtx: TtfwContext;
    aTableConvParamDialog: TTableConvParamDialog);
     {* Реализация слова скрипта pop:TableConvParamDialog:Fake }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwPopTableConvParamDialogFake

// start class TkwPopTableConvParamDialogFake

procedure TkwPopTableConvParamDialogFake.Fake(const aCtx: TtfwContext;
  aTableConvParamDialog: TTableConvParamDialog);
//#UC START# *C4A5B2BD74DF_0BE0E0D34519_var*
//#UC END# *C4A5B2BD74DF_0BE0E0D34519_var*
begin
//#UC START# *C4A5B2BD74DF_0BE0E0D34519_impl*
 RunnerError('fake-метод только для регистрации класса формы', aCtx);
//#UC END# *C4A5B2BD74DF_0BE0E0D34519_impl*
end;//TkwPopTableConvParamDialogFake.Fake

procedure TkwPopTableConvParamDialogFake.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTableConvParamDialog : TTableConvParamDialog;
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
 {-}
begin
 Result := 'pop:TableConvParamDialog:Fake';
end;//TkwPopTableConvParamDialogFake.GetWordNameForRegister

function TkwPopTableConvParamDialogFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopTableConvParamDialogFake.GetResultTypeInfo
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация pop_TableConvParamDialog_Fake
 TkwPopTableConvParamDialogFake.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TTableConvParamDialog
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTableConvParamDialog));
{$IfEnd} //not NoScripts

end.