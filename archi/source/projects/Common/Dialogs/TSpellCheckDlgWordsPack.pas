unit TSpellCheckDlgWordsPack;

// Модуль: "w:\archi\source\projects\Common\Dialogs\TSpellCheckDlgWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

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
 , D_spell
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopSpellCheckDlgFake = {final} class(TtfwClassLike)
  {* Слово скрипта pop:SpellCheckDlg:Fake
*Пример:*
[code]
 aSpellCheckDlg pop:SpellCheckDlg:Fake
[code]  }
  private
   procedure Fake(const aCtx: TtfwContext;
    aSpellCheckDlg: TSpellCheckDlg);
    {* Реализация слова скрипта pop:SpellCheckDlg:Fake }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopSpellCheckDlgFake

procedure TkwPopSpellCheckDlgFake.Fake(const aCtx: TtfwContext;
 aSpellCheckDlg: TSpellCheckDlg);
 {* Реализация слова скрипта pop:SpellCheckDlg:Fake }
//#UC START# *66B7B716E7E4_B3D7A1E7CA69_var*
//#UC END# *66B7B716E7E4_B3D7A1E7CA69_var*
begin
//#UC START# *66B7B716E7E4_B3D7A1E7CA69_impl*
 RunnerError('fake-метод только для регистрации класса формы', aCtx);
//#UC END# *66B7B716E7E4_B3D7A1E7CA69_impl*
end;//TkwPopSpellCheckDlgFake.Fake

procedure TkwPopSpellCheckDlgFake.DoDoIt(const aCtx: TtfwContext);
var l_aSpellCheckDlg: TSpellCheckDlg;
begin
 try
  l_aSpellCheckDlg := TSpellCheckDlg(aCtx.rEngine.PopObjAs(TSpellCheckDlg));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSpellCheckDlg: TSpellCheckDlg : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Fake(aCtx, l_aSpellCheckDlg);
end;//TkwPopSpellCheckDlgFake.DoDoIt

class function TkwPopSpellCheckDlgFake.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:SpellCheckDlg:Fake';
end;//TkwPopSpellCheckDlgFake.GetWordNameForRegister

function TkwPopSpellCheckDlgFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopSpellCheckDlgFake.GetResultTypeInfo

function TkwPopSpellCheckDlgFake.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopSpellCheckDlgFake.GetAllParamsCount

function TkwPopSpellCheckDlgFake.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TSpellCheckDlg)]);
end;//TkwPopSpellCheckDlgFake.ParamsTypes

initialization
 TkwPopSpellCheckDlgFake.RegisterInEngine;
 {* Регистрация pop_SpellCheckDlg_Fake }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TSpellCheckDlg));
 {* Регистрация типа TSpellCheckDlg }
{$IfEnd} // NOT Defined(NoScripts)

end.
