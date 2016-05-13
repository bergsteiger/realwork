unit TTextSearchDlgWordsPack;

// Модуль: "w:\archi\source\projects\Common\Dialogs\TTextSearchDlgWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TTextSearchDlgWordsPack" MUID: (55C8CD3401D2)

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
 , D_TxSrch
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopTextSearchDlgFake = {final} class(TtfwClassLike)
  {* Слово скрипта pop:TextSearchDlg:Fake }
  private
   procedure Fake(const aCtx: TtfwContext;
    aTextSearchDlg: TTextSearchDlg);
    {* Реализация слова скрипта pop:TextSearchDlg:Fake }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopTextSearchDlgFake

procedure TkwPopTextSearchDlgFake.Fake(const aCtx: TtfwContext;
 aTextSearchDlg: TTextSearchDlg);
 {* Реализация слова скрипта pop:TextSearchDlg:Fake }
//#UC START# *55C8CD470049_2975C5F7A803_var*
//#UC END# *55C8CD470049_2975C5F7A803_var*
begin
//#UC START# *55C8CD470049_2975C5F7A803_impl*
 RunnerError('fake-метод только для регистрации класса формы', aCtx);
//#UC END# *55C8CD470049_2975C5F7A803_impl*
end;//TkwPopTextSearchDlgFake.Fake

procedure TkwPopTextSearchDlgFake.DoDoIt(const aCtx: TtfwContext);
var l_aTextSearchDlg: TTextSearchDlg;
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
begin
 Result := 'pop:TextSearchDlg:Fake';
end;//TkwPopTextSearchDlgFake.GetWordNameForRegister

function TkwPopTextSearchDlgFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopTextSearchDlgFake.GetResultTypeInfo

function TkwPopTextSearchDlgFake.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopTextSearchDlgFake.GetAllParamsCount

function TkwPopTextSearchDlgFake.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TTextSearchDlg)]);
end;//TkwPopTextSearchDlgFake.ParamsTypes

initialization
 TkwPopTextSearchDlgFake.RegisterInEngine;
 {* Регистрация pop_TextSearchDlg_Fake }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTextSearchDlg));
 {* Регистрация типа TTextSearchDlg }
{$IfEnd} // NOT Defined(NoScripts)

end.
