unit TPicSizeEditDlgWordsPack;

// Модуль: "w:\archi\source\projects\Common\Dialogs\TPicSizeEditDlgWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TPicSizeEditDlgWordsPack" MUID: (55C8CDD703B3)

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
 , D_PicSizeEdit
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 TkwPopPicSizeEditDlgFake = {final} class(TtfwClassLike)
  {* Слово скрипта pop:PicSizeEditDlg:Fake
*Пример:*
[code]
 aPicSizeEditDlg pop:PicSizeEditDlg:Fake
[code]  }
  private
   procedure Fake(const aCtx: TtfwContext;
    aPicSizeEditDlg: TPicSizeEditDlg);
    {* Реализация слова скрипта pop:PicSizeEditDlg:Fake }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopPicSizeEditDlgFake

procedure TkwPopPicSizeEditDlgFake.Fake(const aCtx: TtfwContext;
 aPicSizeEditDlg: TPicSizeEditDlg);
 {* Реализация слова скрипта pop:PicSizeEditDlg:Fake }
//#UC START# *CD007FA5CC23_DF6A0ECD8244_var*
//#UC END# *CD007FA5CC23_DF6A0ECD8244_var*
begin
//#UC START# *CD007FA5CC23_DF6A0ECD8244_impl*
 RunnerError('fake-метод только для регистрации класса формы', aCtx);
//#UC END# *CD007FA5CC23_DF6A0ECD8244_impl*
end;//TkwPopPicSizeEditDlgFake.Fake

procedure TkwPopPicSizeEditDlgFake.DoDoIt(const aCtx: TtfwContext);
var l_aPicSizeEditDlg: TPicSizeEditDlg;
begin
 try
  l_aPicSizeEditDlg := TPicSizeEditDlg(aCtx.rEngine.PopObjAs(TPicSizeEditDlg));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPicSizeEditDlg: TPicSizeEditDlg : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Fake(aCtx, l_aPicSizeEditDlg);
end;//TkwPopPicSizeEditDlgFake.DoDoIt

function TkwPopPicSizeEditDlgFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopPicSizeEditDlgFake.GetResultTypeInfo

function TkwPopPicSizeEditDlgFake.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopPicSizeEditDlgFake.GetAllParamsCount

function TkwPopPicSizeEditDlgFake.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TPicSizeEditDlg)]);
end;//TkwPopPicSizeEditDlgFake.ParamsTypes

class function TkwPopPicSizeEditDlgFake.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:PicSizeEditDlg:Fake';
end;//TkwPopPicSizeEditDlgFake.GetWordNameForRegister

initialization
 TkwPopPicSizeEditDlgFake.RegisterInEngine;
 {* Регистрация pop_PicSizeEditDlg_Fake }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPicSizeEditDlg));
 {* Регистрация типа TPicSizeEditDlg }
{$IfEnd} // NOT Defined(NoScripts)

end.
