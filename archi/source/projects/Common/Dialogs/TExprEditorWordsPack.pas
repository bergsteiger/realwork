unit TExprEditorWordsPack;

// Модуль: "w:\archi\source\projects\Common\Dialogs\TExprEditorWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TExprEditorWordsPack" MUID: (55C8CDFC039B)

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
 , ExprEditForm
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *55C8CDFC039Bimpl_uses*
 //#UC END# *55C8CDFC039Bimpl_uses*
;

type
 TkwPopExprEditorFake = {final} class(TtfwClassLike)
  {* Слово скрипта pop:ExprEditor:Fake }
  private
   procedure Fake(const aCtx: TtfwContext;
    aExprEditor: TExprEditor);
    {* Реализация слова скрипта pop:ExprEditor:Fake }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopExprEditorFake

procedure TkwPopExprEditorFake.Fake(const aCtx: TtfwContext;
 aExprEditor: TExprEditor);
 {* Реализация слова скрипта pop:ExprEditor:Fake }
//#UC START# *55C8CE280375_55C8CE280375_4F57640C0241_Word_var*
//#UC END# *55C8CE280375_55C8CE280375_4F57640C0241_Word_var*
begin
//#UC START# *55C8CE280375_55C8CE280375_4F57640C0241_Word_impl*
 RunnerError('fake-метод только для регистрации класса формы', aCtx);
//#UC END# *55C8CE280375_55C8CE280375_4F57640C0241_Word_impl*
end;//TkwPopExprEditorFake.Fake

class function TkwPopExprEditorFake.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ExprEditor:Fake';
end;//TkwPopExprEditorFake.GetWordNameForRegister

function TkwPopExprEditorFake.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopExprEditorFake.GetResultTypeInfo

function TkwPopExprEditorFake.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopExprEditorFake.GetAllParamsCount

function TkwPopExprEditorFake.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TExprEditor)]);
end;//TkwPopExprEditorFake.ParamsTypes

procedure TkwPopExprEditorFake.DoDoIt(const aCtx: TtfwContext);
var l_aExprEditor: TExprEditor;
begin
 try
  l_aExprEditor := TExprEditor(aCtx.rEngine.PopObjAs(TExprEditor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aExprEditor: TExprEditor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Fake(aCtx, l_aExprEditor);
end;//TkwPopExprEditorFake.DoDoIt

initialization
 TkwPopExprEditorFake.RegisterInEngine;
 {* Регистрация pop_ExprEditor_Fake }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TExprEditor));
 {* Регистрация типа TExprEditor }
{$IfEnd} // NOT Defined(NoScripts)

end.
