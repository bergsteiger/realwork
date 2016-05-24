unit SpinEditWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\SpinEditWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "SpinEditWordsPack" MUID: (552E413F010E)

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
 , vtSpinEdit
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopSpinEditValue = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:SpinEdit:Value }
  private
   function Value(const aCtx: TtfwContext;
    aSpinEdit: TvtSpinEdit): Integer;
    {* Реализация слова скрипта pop:SpinEdit:Value }
  protected
   class procedure DoSetValue(aSpinEdit: TvtSpinEdit;
    aValue: Integer);
    {* Метод установки значения свойства Value }
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopSpinEditValue

class procedure TkwPopSpinEditValue.DoSetValue(aSpinEdit: TvtSpinEdit;
 aValue: Integer);
 {* Метод установки значения свойства Value }
//#UC START# *552E41740211_4C52C0600246_Word_DoSetValue_552E41740211_4C52C0600246_Word_var*
//#UC END# *552E41740211_4C52C0600246_Word_DoSetValue_552E41740211_4C52C0600246_Word_var*
begin
//#UC START# *552E41740211_4C52C0600246_Word_DoSetValue_552E41740211_4C52C0600246_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *552E41740211_4C52C0600246_Word_DoSetValue_552E41740211_4C52C0600246_Word_impl*
end;//TkwPopSpinEditValue.DoSetValue

function TkwPopSpinEditValue.Value(const aCtx: TtfwContext;
 aSpinEdit: TvtSpinEdit): Integer;
 {* Реализация слова скрипта pop:SpinEdit:Value }
//#UC START# *552E41740211_552E41740211_4C52C0600246_Word_var*
//#UC END# *552E41740211_552E41740211_4C52C0600246_Word_var*
begin
//#UC START# *552E41740211_552E41740211_4C52C0600246_Word_impl*
 !!! Needs to be implemented !!!
//#UC END# *552E41740211_552E41740211_4C52C0600246_Word_impl*
end;//TkwPopSpinEditValue.Value

class function TkwPopSpinEditValue.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:SpinEdit:Value';
end;//TkwPopSpinEditValue.GetWordNameForRegister

function TkwPopSpinEditValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopSpinEditValue.GetResultTypeInfo

function TkwPopSpinEditValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopSpinEditValue.GetAllParamsCount

function TkwPopSpinEditValue.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtSpinEdit)]);
end;//TkwPopSpinEditValue.ParamsTypes

procedure TkwPopSpinEditValue.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_SpinEdit: TvtSpinEdit;
begin
 try
  l_SpinEdit := TvtSpinEdit(aCtx.rEngine.PopObjAs(TvtSpinEdit));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра SpinEdit: TvtSpinEdit : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DoSetValue(l_SpinEdit, aValue.AsInt);
end;//TkwPopSpinEditValue.SetValuePrim

procedure TkwPopSpinEditValue.DoDoIt(const aCtx: TtfwContext);
var l_aSpinEdit: TvtSpinEdit;
begin
 try
  l_aSpinEdit := TvtSpinEdit(aCtx.rEngine.PopObjAs(TvtSpinEdit));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSpinEdit: TvtSpinEdit : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Value(aCtx, l_aSpinEdit));
end;//TkwPopSpinEditValue.DoDoIt

initialization
 TkwPopSpinEditValue.RegisterInEngine;
 {* Регистрация pop_SpinEdit_Value }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSpinEdit));
 {* Регистрация типа TvtSpinEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
