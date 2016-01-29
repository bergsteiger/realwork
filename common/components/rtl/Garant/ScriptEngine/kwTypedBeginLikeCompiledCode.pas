unit kwTypedBeginLikeCompiledCode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine"
// Модуль: "kwTypedBeginLikeCompiledCode.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine::CodeBranchingWords::TkwTypedBeginLikeCompiledCode
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  kwBeginLikeCompiledCode
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwTypedBeginLikeCompiledCode = class(TkwBeginLikeCompiledCode)
 private
 // private fields
   f_WordInfo : TtfwWordInfo;
 protected
 // overridden property methods
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 public
 // overridden public methods
   procedure SetResultTypeInfo(aValue: TtfwWordInfo;
     const aCtx: TtfwContext); override;
 end;//TkwTypedBeginLikeCompiledCode
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwTypedBeginLikeCompiledCode

procedure TkwTypedBeginLikeCompiledCode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_560937350073_var*
var
 l_StackCount : Integer;
 l_PrevStackCount : Integer;
//#UC END# *4DAEEDE10285_560937350073_var*
begin
//#UC START# *4DAEEDE10285_560937350073_impl*
 if f_WordInfo.ValueTypes.Empty then
  inherited
 else
 begin
  l_StackCount := aCtx.rEngine.ValuesCount - Self.GetAllParamsCount(aCtx);
  inherited;
  l_StackCount := aCtx.rEngine.ValuesCount - l_StackCount;
  l_PrevStackCount := l_StackCount;
  if f_WordInfo.Has(tfw_vtVoid) then
  begin
   if (l_StackCount <> 0) then
    RunnerError('Процедура не может возвращать значение через стек, а возвращается ' + IntToStr(l_PrevStackCount) + ' значений', aCtx);
  end//f_WordInfo.Has(tfw_vtVoid)
  else
  begin
   if (l_StackCount <> 1) then
   begin
    while (l_StackCount > 0) do
    begin
     aCtx.rEngine.Drop;
     Dec(l_StackCount);
    end;//l_StackCount > 0
    RunnerError('Нужно вернуть ТОЛЬКО одно значение, а возвращается ' + IntToStr(l_PrevStackCount) + ' значений', aCtx);
   end;//l_StackCount <> 1
   if not f_WordInfo.AcceptsValue(aCtx.rEngine.Top^) then
   begin
    aCtx.rEngine.Drop;
    RunnerError('Неверное возвращаемое значение', aCtx);
   end;//not f_WordInfo.AcceptsValue(aCtx.rEngine.Top^)
  end;//f_WordInfo.Has(tfw_vtVoid)
 end;//f_WordInfo.ValueTypes.Empty
//#UC END# *4DAEEDE10285_560937350073_impl*
end;//TkwTypedBeginLikeCompiledCode.DoDoIt

function TkwTypedBeginLikeCompiledCode.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_560937350073get_var*
//#UC END# *52CFC11603C8_560937350073get_var*
begin
//#UC START# *52CFC11603C8_560937350073get_impl*
 Result := f_WordInfo;
//#UC END# *52CFC11603C8_560937350073get_impl*
end;//TkwTypedBeginLikeCompiledCode.pm_GetResultTypeInfo

procedure TkwTypedBeginLikeCompiledCode.SetResultTypeInfo(aValue: TtfwWordInfo;
  const aCtx: TtfwContext);
//#UC START# *52EA6A2C0111_560937350073_var*
//#UC END# *52EA6A2C0111_560937350073_var*
begin
//#UC START# *52EA6A2C0111_560937350073_impl*
 f_WordInfo := aValue;
//#UC END# *52EA6A2C0111_560937350073_impl*
end;//TkwTypedBeginLikeCompiledCode.SetResultTypeInfo

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwTypedBeginLikeCompiledCode
 TkwTypedBeginLikeCompiledCode.RegisterClass;
{$IfEnd} //not NoScripts

end.