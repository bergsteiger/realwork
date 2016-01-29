unit ScrollingWinControlWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "ScrollingWinControlWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::ExtControlsProcessing::ScrollingWinControlWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  Controls,
  Forms,
  tfwScriptingInterfaces,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  Windows,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopControlVScrollerVisible = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:VScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:VScrollerVisible >>> l_Boolean
[code]  }
 private
 // private methods
   function VScrollerVisible(const aCtx: TtfwContext;
    aControl: TWinControl): Boolean;
     {* Реализация слова скрипта pop:Control:VScrollerVisible }
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
 end;//TkwPopControlVScrollerVisible

// start class TkwPopControlVScrollerVisible

function TkwPopControlVScrollerVisible.VScrollerVisible(const aCtx: TtfwContext;
  aControl: TWinControl): Boolean;
//#UC START# *9B30ABE39DA1_D64D3C18264A_var*
var
 l_PageMax: Integer;
 l_RangeMax: Integer;
 l_Err: Integer;
 l_PageInfo: TScrollInfo;
//#UC END# *9B30ABE39DA1_D64D3C18264A_var*
begin
//#UC START# *9B30ABE39DA1_D64D3C18264A_impl*
 if (aControl Is TScrollingWinControl) then
  Result := TScrollingWinControl(aControl).VertScrollBar.IsScrollBarVisible
 else
 begin
  with l_PageInfo do
  begin
   cbSize := SizeOf(l_PageInfo);
   fMask := SIF_ALL;
  end;//with l_ScrollInfo
  if GetScrollInfo(aControl.Handle, SB_VERT, l_PageInfo) then
  begin
   l_PageMax := l_PageInfo.nPage;
   l_RangeMax := l_PageInfo.nMax;
   Result := l_RangeMax > l_PageMax;
  end
  else
  begin
   l_Err := GetLastError;
   if l_Err = 1447 then  // 1447: Окно не имеет полос прокрутки.
    Result := False
   else
    RunnerAssert(False, 'Ошибка при вызове GetScrollInfo. Код ошибки: ' + IntToStr(l_Err), aCtx);
  end;
 end;//aControl Is TScrollingWinControl
//#UC END# *9B30ABE39DA1_D64D3C18264A_impl*
end;//TkwPopControlVScrollerVisible.VScrollerVisible

procedure TkwPopControlVScrollerVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TWinControl;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((VScrollerVisible(aCtx, l_aControl)));
end;//TkwPopControlVScrollerVisible.DoDoIt

class function TkwPopControlVScrollerVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:VScrollerVisible';
end;//TkwPopControlVScrollerVisible.GetWordNameForRegister

procedure TkwPopControlVScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству VScrollerVisible', aCtx);
end;//TkwPopControlVScrollerVisible.SetValuePrim

function TkwPopControlVScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlVScrollerVisible.GetResultTypeInfo

function TkwPopControlVScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlVScrollerVisible.GetAllParamsCount

function TkwPopControlVScrollerVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl)]);
end;//TkwPopControlVScrollerVisible.ParamsTypes

type
 TkwPopControlHScrollerVisible = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:HScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:HScrollerVisible >>> l_Boolean
[code]  }
 private
 // private methods
   function HScrollerVisible(const aCtx: TtfwContext;
    aControl: TWinControl): Boolean;
     {* Реализация слова скрипта pop:Control:HScrollerVisible }
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
 end;//TkwPopControlHScrollerVisible

// start class TkwPopControlHScrollerVisible

function TkwPopControlHScrollerVisible.HScrollerVisible(const aCtx: TtfwContext;
  aControl: TWinControl): Boolean;
//#UC START# *770305E8A083_F808620CE3AB_var*
var
 l_PageMax: Integer;
 l_RangeMax: Integer;
 l_Err: Integer;
 l_PageInfo: TScrollInfo;
//#UC END# *770305E8A083_F808620CE3AB_var*
begin
//#UC START# *770305E8A083_F808620CE3AB_impl*
 if (aControl Is TScrollingWinControl) then
  Result := TScrollingWinControl(aControl).HorzScrollBar.IsScrollBarVisible
 else
 begin
  with l_PageInfo do
  begin
   cbSize := SizeOf(l_PageInfo);
   fMask := SIF_ALL;
  end;//with l_ScrollInfo
  if GetScrollInfo(aControl.Handle, SB_HORZ, l_PageInfo) then
  begin
   l_PageMax := l_PageInfo.nPage;
   l_RangeMax := l_PageInfo.nMax;
   Result := l_RangeMax > l_PageMax;
  end
  else
  begin
   l_Err := GetLastError;
   if l_Err = 1447 then  // 1447: Окно не имеет полос прокрутки.
    Result := False
   else
    RunnerAssert(False, 'Ошибка при вызове GetScrollInfo. Код ошибки: ' + IntToStr(l_Err), aCtx);
  end;
 end;//aControl Is TScrollingWinControl
//#UC END# *770305E8A083_F808620CE3AB_impl*
end;//TkwPopControlHScrollerVisible.HScrollerVisible

procedure TkwPopControlHScrollerVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aControl : TWinControl;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((HScrollerVisible(aCtx, l_aControl)));
end;//TkwPopControlHScrollerVisible.DoDoIt

class function TkwPopControlHScrollerVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:Control:HScrollerVisible';
end;//TkwPopControlHScrollerVisible.GetWordNameForRegister

procedure TkwPopControlHScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HScrollerVisible', aCtx);
end;//TkwPopControlHScrollerVisible.SetValuePrim

function TkwPopControlHScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlHScrollerVisible.GetResultTypeInfo

function TkwPopControlHScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopControlHScrollerVisible.GetAllParamsCount

function TkwPopControlHScrollerVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl)]);
end;//TkwPopControlHScrollerVisible.ParamsTypes

type
 TkwPopScrollingWinControlVScrollerVisible = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:ScrollingWinControl:VScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aScrollingWinControl pop:ScrollingWinControl:VScrollerVisible >>> l_Boolean
[code]  }
 private
 // private methods
   function VScrollerVisible(const aCtx: TtfwContext;
    aScrollingWinControl: TScrollingWinControl): Boolean;
     {* Реализация слова скрипта pop:ScrollingWinControl:VScrollerVisible }
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
 end;//TkwPopScrollingWinControlVScrollerVisible

// start class TkwPopScrollingWinControlVScrollerVisible

function TkwPopScrollingWinControlVScrollerVisible.VScrollerVisible(const aCtx: TtfwContext;
  aScrollingWinControl: TScrollingWinControl): Boolean;
//#UC START# *EC3279A91E15_0E188022DACF_var*
//#UC END# *EC3279A91E15_0E188022DACF_var*
begin
//#UC START# *EC3279A91E15_0E188022DACF_impl*
 Result := aScrollingWinControl.VertScrollBar.IsScrollBarVisible;
//#UC END# *EC3279A91E15_0E188022DACF_impl*
end;//TkwPopScrollingWinControlVScrollerVisible.VScrollerVisible

procedure TkwPopScrollingWinControlVScrollerVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aScrollingWinControl : TScrollingWinControl;
begin
 try
  l_aScrollingWinControl := TScrollingWinControl(aCtx.rEngine.PopObjAs(TScrollingWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aScrollingWinControl: TScrollingWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((VScrollerVisible(aCtx, l_aScrollingWinControl)));
end;//TkwPopScrollingWinControlVScrollerVisible.DoDoIt

class function TkwPopScrollingWinControlVScrollerVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:ScrollingWinControl:VScrollerVisible';
end;//TkwPopScrollingWinControlVScrollerVisible.GetWordNameForRegister

procedure TkwPopScrollingWinControlVScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству VScrollerVisible', aCtx);
end;//TkwPopScrollingWinControlVScrollerVisible.SetValuePrim

function TkwPopScrollingWinControlVScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopScrollingWinControlVScrollerVisible.GetResultTypeInfo

function TkwPopScrollingWinControlVScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopScrollingWinControlVScrollerVisible.GetAllParamsCount

function TkwPopScrollingWinControlVScrollerVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TScrollingWinControl)]);
end;//TkwPopScrollingWinControlVScrollerVisible.ParamsTypes

type
 TkwPopScrollingWinControlHScrollerVisible = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:ScrollingWinControl:HScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aScrollingWinControl pop:ScrollingWinControl:HScrollerVisible >>> l_Boolean
[code]  }
 private
 // private methods
   function HScrollerVisible(const aCtx: TtfwContext;
    aScrollingWinControl: TScrollingWinControl): Boolean;
     {* Реализация слова скрипта pop:ScrollingWinControl:HScrollerVisible }
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
 end;//TkwPopScrollingWinControlHScrollerVisible

// start class TkwPopScrollingWinControlHScrollerVisible

function TkwPopScrollingWinControlHScrollerVisible.HScrollerVisible(const aCtx: TtfwContext;
  aScrollingWinControl: TScrollingWinControl): Boolean;
//#UC START# *C1B1B2C96DB6_B46C6A433AAC_var*
//#UC END# *C1B1B2C96DB6_B46C6A433AAC_var*
begin
//#UC START# *C1B1B2C96DB6_B46C6A433AAC_impl*
 Result := aScrollingWinControl.HorzScrollBar.IsScrollBarVisible;
//#UC END# *C1B1B2C96DB6_B46C6A433AAC_impl*
end;//TkwPopScrollingWinControlHScrollerVisible.HScrollerVisible

procedure TkwPopScrollingWinControlHScrollerVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aScrollingWinControl : TScrollingWinControl;
begin
 try
  l_aScrollingWinControl := TScrollingWinControl(aCtx.rEngine.PopObjAs(TScrollingWinControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aScrollingWinControl: TScrollingWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((HScrollerVisible(aCtx, l_aScrollingWinControl)));
end;//TkwPopScrollingWinControlHScrollerVisible.DoDoIt

class function TkwPopScrollingWinControlHScrollerVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:ScrollingWinControl:HScrollerVisible';
end;//TkwPopScrollingWinControlHScrollerVisible.GetWordNameForRegister

procedure TkwPopScrollingWinControlHScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HScrollerVisible', aCtx);
end;//TkwPopScrollingWinControlHScrollerVisible.SetValuePrim

function TkwPopScrollingWinControlHScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwPopScrollingWinControlHScrollerVisible.GetResultTypeInfo

function TkwPopScrollingWinControlHScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopScrollingWinControlHScrollerVisible.GetAllParamsCount

function TkwPopScrollingWinControlHScrollerVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TScrollingWinControl)]);
end;//TkwPopScrollingWinControlHScrollerVisible.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_VScrollerVisible
 TkwPopControlVScrollerVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_Control_HScrollerVisible
 TkwPopControlHScrollerVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_ScrollingWinControl_VScrollerVisible
 TkwPopScrollingWinControlVScrollerVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация pop_ScrollingWinControl_HScrollerVisible
 TkwPopScrollingWinControlHScrollerVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TWinControl
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWinControl));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TScrollingWinControl
 TtfwTypeRegistrator.RegisterType(TypeInfo(TScrollingWinControl));
{$IfEnd} //not NoScripts AND not NoVCL

end.