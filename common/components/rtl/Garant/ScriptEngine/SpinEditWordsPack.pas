unit SpinEditWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$VT"
// Модуль: "SpinEditWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi::ScriptEngine$VT::vtControlsFromStackWords::SpinEditWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  vtSpinEdit,
  tfwScriptingInterfaces,
  tfwPropertyLike
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
 TkwPopSpinEditValue = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:SpinEdit:Value
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aSpinEdit pop:SpinEdit:Value >>> l_Integer
[code]  }
 private
 // private methods
   function Value(const aCtx: TtfwContext;
    aSpinEdit: TvtSpinEdit): Integer;
     {* Реализация слова скрипта pop:SpinEdit:Value }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 protected
 // protected methods
   class procedure DoSetValue(aSpinEdit: TvtSpinEdit;
    aValue: Integer);
     {* Метод установки значения свойства Value }
 end;//TkwPopSpinEditValue

// start class TkwPopSpinEditValue

function TkwPopSpinEditValue.Value(const aCtx: TtfwContext;
  aSpinEdit: TvtSpinEdit): Integer;
//#UC START# *7366517D8188_0F40F0279E11_var*
//#UC END# *7366517D8188_0F40F0279E11_var*
begin
//#UC START# *7366517D8188_0F40F0279E11_impl*
 Result := aSpinEdit.AsInteger;
//#UC END# *7366517D8188_0F40F0279E11_impl*
end;//TkwPopSpinEditValue.Value

class procedure TkwPopSpinEditValue.DoSetValue(aSpinEdit: TvtSpinEdit;
  aValue: Integer);
//#UC START# *A9BA2BCEA197_0F40F0279E11_var*
//#UC END# *A9BA2BCEA197_0F40F0279E11_var*
begin
//#UC START# *A9BA2BCEA197_0F40F0279E11_impl*
 aSpinEdit.AsInteger := aValue;
//#UC END# *A9BA2BCEA197_0F40F0279E11_impl*
end;//TkwPopSpinEditValue.DoSetValue

procedure TkwPopSpinEditValue.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aSpinEdit : TvtSpinEdit;
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
 aCtx.rEngine.PushInt((Value(aCtx, l_aSpinEdit)));
end;//TkwPopSpinEditValue.DoDoIt

class function TkwPopSpinEditValue.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:SpinEdit:Value';
end;//TkwPopSpinEditValue.GetWordNameForRegister

procedure TkwPopSpinEditValue.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
var
 l_SpinEdit: TvtSpinEdit;
begin
 try
  l_SpinEdit := TvtSpinEdit(aCtx.rEngine.PopObjAs(TvtSpinEdit));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра l_SpinEdit: TvtSpinEdit : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DoSetValue(l_SpinEdit, (aValue.AsInt));
end;//TkwPopSpinEditValue.SetValuePrim

function TkwPopSpinEditValue.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwPopSpinEditValue.GetResultTypeInfo

function TkwPopSpinEditValue.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopSpinEditValue.GetAllParamsCount

function TkwPopSpinEditValue.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TvtSpinEdit)]);
end;//TkwPopSpinEditValue.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация pop_SpinEdit_Value
 TkwPopSpinEditValue.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TvtSpinEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSpinEdit));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts

end.