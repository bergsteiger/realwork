unit TTextSearchDlgWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Dialogs"
// Модуль: "w:/archi/source/projects/Common/Dialogs/TTextSearchDlgWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$common::Dialogs::Dialogs::TTextSearchDlgWordsPack
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
  D_TxSrch,
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
 TkwPopTextSearchDlgFake = {final scriptword} class(TtfwRegisterableWord)
  {* Слово скрипта pop:TextSearchDlg:Fake
[panel]Этот метод нужен лишь для того, чтобы зарегистировать диалог в скриптовой машине.[panel]
*Пример:*
[code]
 aTextSearchDlg pop:TextSearchDlg:Fake
[code]  }
 private
 // private methods
   procedure Fake(const aCtx: TtfwContext;
    aTextSearchDlg: TTextSearchDlg);
     {* Реализация слова скрипта pop:TextSearchDlg:Fake }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwPopTextSearchDlgFake

// start class TkwPopTextSearchDlgFake

procedure TkwPopTextSearchDlgFake.Fake(const aCtx: TtfwContext;
  aTextSearchDlg: TTextSearchDlg);
//#UC START# *29B068DE5F56_2975C5F7A803_var*
//#UC END# *29B068DE5F56_2975C5F7A803_var*
begin
//#UC START# *29B068DE5F56_2975C5F7A803_impl*
 RunnerError('fake-метод только для регистрации класса формы', aCtx);
//#UC END# *29B068DE5F56_2975C5F7A803_impl*
end;//TkwPopTextSearchDlgFake.Fake

procedure TkwPopTextSearchDlgFake.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTextSearchDlg : TTextSearchDlg;
begin
 try
  l_aTextSearchDlg := TTextSearchDlg(aCtx.rEngine.PopObjAs(TTextSearchDlg));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTextSearchDlg: TTextSearchDlg : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Fake(aCtx, l_aTextSearchDlg);
end;//TkwPopTextSearchDlgFake.DoDoIt

class function TkwPopTextSearchDlgFake.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:TextSearchDlg:Fake';
end;//TkwPopTextSearchDlgFake.GetWordNameForRegister

function TkwPopTextSearchDlgFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwPopTextSearchDlgFake.GetResultTypeInfo
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация pop_TextSearchDlg_Fake
 TkwPopTextSearchDlgFake.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TTextSearchDlg
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTextSearchDlg));
{$IfEnd} //not NoScripts

end.