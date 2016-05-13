unit SpinEditWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\SpinEditWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "SpinEditWordsPack" MUID: (552E413F010E)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

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
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
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
//#UC START# *0F40F0279E11_DoSetValue_0F40F0279E11_var*
//#UC END# *0F40F0279E11_DoSetValue_0F40F0279E11_var*
begin
//#UC START# *0F40F0279E11_DoSetValue_0F40F0279E11_impl*
 aSpinEdit.AsInteger := aValue;
//#UC END# *0F40F0279E11_DoSetValue_0F40F0279E11_impl*
end;//TkwPopSpinEditValue.DoSetValue

function TkwPopSpinEditValue.Value(const aCtx: TtfwContext;
 aSpinEdit: TvtSpinEdit): Integer;
 {* Реализация слова скрипта pop:SpinEdit:Value }
//#UC START# *FFBFE1E95F74_0F40F0279E11_var*
//#UC END# *FFBFE1E95F74_0F40F0279E11_var*
begin
//#UC START# *FFBFE1E95F74_0F40F0279E11_impl*
 Result := aSpinEdit.AsInteger;
//#UC END# *FFBFE1E95F74_0F40F0279E11_impl*
end;//TkwPopSpinEditValue.Value

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

initialization
 TkwPopSpinEditValue.RegisterInEngine;
 {* Регистрация pop_SpinEdit_Value }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSpinEdit));
 {* Регистрация типа TvtSpinEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
