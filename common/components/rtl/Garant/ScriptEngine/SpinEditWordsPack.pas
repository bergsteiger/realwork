unit SpinEditWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\SpinEditWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtSpinEdit
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopSpinEditValue = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:SpinEdit:Value
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aSpinEdit pop:SpinEdit:Value >>> l_Integer
[code]  }
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
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopSpinEditValue

function TkwPopSpinEditValue.Value(const aCtx: TtfwContext;
 aSpinEdit: TvtSpinEdit): Integer;
 {* Реализация слова скрипта pop:SpinEdit:Value }
//#UC START# *7366517D8188_0F40F0279E11_var*
//#UC END# *7366517D8188_0F40F0279E11_var*
begin
//#UC START# *7366517D8188_0F40F0279E11_impl*
 Result := aSpinEdit.AsInteger;
//#UC END# *7366517D8188_0F40F0279E11_impl*
end;//TkwPopSpinEditValue.Value

class procedure TkwPopSpinEditValue.DoSetValue(aSpinEdit: TvtSpinEdit;
 aValue: Integer);
 {* Метод установки значения свойства Value }
//#UC START# *A9BA2BCEA197_0F40F0279E11_var*
//#UC END# *A9BA2BCEA197_0F40F0279E11_var*
begin
//#UC START# *A9BA2BCEA197_0F40F0279E11_impl*
 aSpinEdit.AsInteger := aValue;
//#UC END# *A9BA2BCEA197_0F40F0279E11_impl*
end;//TkwPopSpinEditValue.DoSetValue

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

initialization
 TkwPopSpinEditValue.RegisterInEngine;
 {* Регистрация pop_SpinEdit_Value }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSpinEdit));
 {* Регистрация типа TvtSpinEdit }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
