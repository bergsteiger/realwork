unit CustomActionWordpack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\CustomActionWordpack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "CustomActionWordpack" MUID: (57FB3E5D00AD)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , ActnList
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *57FB3E5D00ADimpl_uses*
 //#UC END# *57FB3E5D00ADimpl_uses*
;

type
 TkwPopActionChecked = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Action:Checked }
  private
   function Checked(const aCtx: TtfwContext;
    aAction: TCustomAction): Boolean;
    {* Реализация слова скрипта pop:Action:Checked }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopActionChecked

function TkwPopActionChecked.Checked(const aCtx: TtfwContext;
 aAction: TCustomAction): Boolean;
 {* Реализация слова скрипта pop:Action:Checked }
//#UC START# *57FB3E9D03C1_57FB3E9D03C1_47E7626B0083_Word_var*
//#UC END# *57FB3E9D03C1_57FB3E9D03C1_47E7626B0083_Word_var*
begin
//#UC START# *57FB3E9D03C1_57FB3E9D03C1_47E7626B0083_Word_impl*
 Result := aAction.Checked;
//#UC END# *57FB3E9D03C1_57FB3E9D03C1_47E7626B0083_Word_impl*
end;//TkwPopActionChecked.Checked

class function TkwPopActionChecked.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Action:Checked';
end;//TkwPopActionChecked.GetWordNameForRegister

function TkwPopActionChecked.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopActionChecked.GetResultTypeInfo

function TkwPopActionChecked.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopActionChecked.GetAllParamsCount

function TkwPopActionChecked.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TCustomAction)]);
end;//TkwPopActionChecked.ParamsTypes

procedure TkwPopActionChecked.DoDoIt(const aCtx: TtfwContext);
var l_aAction: TCustomAction;
begin
 try
  l_aAction := TCustomAction(aCtx.rEngine.PopObjAs(TCustomAction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAction: TCustomAction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(Checked(aCtx, l_aAction));
end;//TkwPopActionChecked.DoDoIt

initialization
 TkwPopActionChecked.RegisterInEngine;
 {* Регистрация pop_Action_Checked }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCustomAction));
 {* Регистрация типа TCustomAction }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
