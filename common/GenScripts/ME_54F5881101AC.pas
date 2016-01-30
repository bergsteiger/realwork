unit ScrollingWinControlWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ScrollingWinControlWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Controls
 , Forms
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Windows
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopControlVScrollerVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:VScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:VScrollerVisible >>> l_Boolean
[code]  }
  private
   function VScrollerVisible(const aCtx: TtfwContext;
    aControl: TWinControl): Boolean;
    {* Реализация слова скрипта pop:Control:VScrollerVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlVScrollerVisible

 TkwPopControlHScrollerVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Control:HScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aControl pop:Control:HScrollerVisible >>> l_Boolean
[code]  }
  private
   function HScrollerVisible(const aCtx: TtfwContext;
    aControl: TWinControl): Boolean;
    {* Реализация слова скрипта pop:Control:HScrollerVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopControlHScrollerVisible

 TkwPopScrollingWinControlVScrollerVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:ScrollingWinControl:VScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aScrollingWinControl pop:ScrollingWinControl:VScrollerVisible >>> l_Boolean
[code]  }
  private
   function VScrollerVisible(const aCtx: TtfwContext;
    aScrollingWinControl: TScrollingWinControl): Boolean;
    {* Реализация слова скрипта pop:ScrollingWinControl:VScrollerVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopScrollingWinControlVScrollerVisible

 TkwPopScrollingWinControlHScrollerVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:ScrollingWinControl:HScrollerVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aScrollingWinControl pop:ScrollingWinControl:HScrollerVisible >>> l_Boolean
[code]  }
  private
   function HScrollerVisible(const aCtx: TtfwContext;
    aScrollingWinControl: TScrollingWinControl): Boolean;
    {* Реализация слова скрипта pop:ScrollingWinControl:HScrollerVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopScrollingWinControlHScrollerVisible

function TkwPopControlVScrollerVisible.VScrollerVisible(const aCtx: TtfwContext;
 aControl: TWinControl): Boolean;
 {* Реализация слова скрипта pop:Control:VScrollerVisible }
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
//#UC START# *4DAEEDE10285_D64D3C18264A_var*
//#UC END# *4DAEEDE10285_D64D3C18264A_var*
begin
//#UC START# *4DAEEDE10285_D64D3C18264A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D64D3C18264A_impl*
end;//TkwPopControlVScrollerVisible.DoDoIt

class function TkwPopControlVScrollerVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:VScrollerVisible';
end;//TkwPopControlVScrollerVisible.GetWordNameForRegister

procedure TkwPopControlVScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D64D3C18264A_var*
//#UC END# *52D00B00031A_D64D3C18264A_var*
begin
//#UC START# *52D00B00031A_D64D3C18264A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D64D3C18264A_impl*
end;//TkwPopControlVScrollerVisible.SetValuePrim

function TkwPopControlVScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D64D3C18264A_var*
//#UC END# *551544E2001A_D64D3C18264A_var*
begin
//#UC START# *551544E2001A_D64D3C18264A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D64D3C18264A_impl*
end;//TkwPopControlVScrollerVisible.GetResultTypeInfo

function TkwPopControlVScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_D64D3C18264A_var*
//#UC END# *559687E6025A_D64D3C18264A_var*
begin
//#UC START# *559687E6025A_D64D3C18264A_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_D64D3C18264A_impl*
end;//TkwPopControlVScrollerVisible.GetAllParamsCount

function TkwPopControlVScrollerVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D64D3C18264A_var*
//#UC END# *5617F4D00243_D64D3C18264A_var*
begin
//#UC START# *5617F4D00243_D64D3C18264A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D64D3C18264A_impl*
end;//TkwPopControlVScrollerVisible.ParamsTypes

function TkwPopControlHScrollerVisible.HScrollerVisible(const aCtx: TtfwContext;
 aControl: TWinControl): Boolean;
 {* Реализация слова скрипта pop:Control:HScrollerVisible }
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
//#UC START# *4DAEEDE10285_F808620CE3AB_var*
//#UC END# *4DAEEDE10285_F808620CE3AB_var*
begin
//#UC START# *4DAEEDE10285_F808620CE3AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F808620CE3AB_impl*
end;//TkwPopControlHScrollerVisible.DoDoIt

class function TkwPopControlHScrollerVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:HScrollerVisible';
end;//TkwPopControlHScrollerVisible.GetWordNameForRegister

procedure TkwPopControlHScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F808620CE3AB_var*
//#UC END# *52D00B00031A_F808620CE3AB_var*
begin
//#UC START# *52D00B00031A_F808620CE3AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F808620CE3AB_impl*
end;//TkwPopControlHScrollerVisible.SetValuePrim

function TkwPopControlHScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F808620CE3AB_var*
//#UC END# *551544E2001A_F808620CE3AB_var*
begin
//#UC START# *551544E2001A_F808620CE3AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F808620CE3AB_impl*
end;//TkwPopControlHScrollerVisible.GetResultTypeInfo

function TkwPopControlHScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F808620CE3AB_var*
//#UC END# *559687E6025A_F808620CE3AB_var*
begin
//#UC START# *559687E6025A_F808620CE3AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F808620CE3AB_impl*
end;//TkwPopControlHScrollerVisible.GetAllParamsCount

function TkwPopControlHScrollerVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F808620CE3AB_var*
//#UC END# *5617F4D00243_F808620CE3AB_var*
begin
//#UC START# *5617F4D00243_F808620CE3AB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F808620CE3AB_impl*
end;//TkwPopControlHScrollerVisible.ParamsTypes

function TkwPopScrollingWinControlVScrollerVisible.VScrollerVisible(const aCtx: TtfwContext;
 aScrollingWinControl: TScrollingWinControl): Boolean;
 {* Реализация слова скрипта pop:ScrollingWinControl:VScrollerVisible }
//#UC START# *EC3279A91E15_0E188022DACF_var*
//#UC END# *EC3279A91E15_0E188022DACF_var*
begin
//#UC START# *EC3279A91E15_0E188022DACF_impl*
 Result := aScrollingWinControl.VertScrollBar.IsScrollBarVisible;
//#UC END# *EC3279A91E15_0E188022DACF_impl*
end;//TkwPopScrollingWinControlVScrollerVisible.VScrollerVisible

procedure TkwPopScrollingWinControlVScrollerVisible.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0E188022DACF_var*
//#UC END# *4DAEEDE10285_0E188022DACF_var*
begin
//#UC START# *4DAEEDE10285_0E188022DACF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0E188022DACF_impl*
end;//TkwPopScrollingWinControlVScrollerVisible.DoDoIt

class function TkwPopScrollingWinControlVScrollerVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScrollingWinControl:VScrollerVisible';
end;//TkwPopScrollingWinControlVScrollerVisible.GetWordNameForRegister

procedure TkwPopScrollingWinControlVScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_0E188022DACF_var*
//#UC END# *52D00B00031A_0E188022DACF_var*
begin
//#UC START# *52D00B00031A_0E188022DACF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_0E188022DACF_impl*
end;//TkwPopScrollingWinControlVScrollerVisible.SetValuePrim

function TkwPopScrollingWinControlVScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0E188022DACF_var*
//#UC END# *551544E2001A_0E188022DACF_var*
begin
//#UC START# *551544E2001A_0E188022DACF_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0E188022DACF_impl*
end;//TkwPopScrollingWinControlVScrollerVisible.GetResultTypeInfo

function TkwPopScrollingWinControlVScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_0E188022DACF_var*
//#UC END# *559687E6025A_0E188022DACF_var*
begin
//#UC START# *559687E6025A_0E188022DACF_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_0E188022DACF_impl*
end;//TkwPopScrollingWinControlVScrollerVisible.GetAllParamsCount

function TkwPopScrollingWinControlVScrollerVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0E188022DACF_var*
//#UC END# *5617F4D00243_0E188022DACF_var*
begin
//#UC START# *5617F4D00243_0E188022DACF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0E188022DACF_impl*
end;//TkwPopScrollingWinControlVScrollerVisible.ParamsTypes

function TkwPopScrollingWinControlHScrollerVisible.HScrollerVisible(const aCtx: TtfwContext;
 aScrollingWinControl: TScrollingWinControl): Boolean;
 {* Реализация слова скрипта pop:ScrollingWinControl:HScrollerVisible }
//#UC START# *C1B1B2C96DB6_B46C6A433AAC_var*
//#UC END# *C1B1B2C96DB6_B46C6A433AAC_var*
begin
//#UC START# *C1B1B2C96DB6_B46C6A433AAC_impl*
 Result := aScrollingWinControl.HorzScrollBar.IsScrollBarVisible;
//#UC END# *C1B1B2C96DB6_B46C6A433AAC_impl*
end;//TkwPopScrollingWinControlHScrollerVisible.HScrollerVisible

procedure TkwPopScrollingWinControlHScrollerVisible.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B46C6A433AAC_var*
//#UC END# *4DAEEDE10285_B46C6A433AAC_var*
begin
//#UC START# *4DAEEDE10285_B46C6A433AAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B46C6A433AAC_impl*
end;//TkwPopScrollingWinControlHScrollerVisible.DoDoIt

class function TkwPopScrollingWinControlHScrollerVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScrollingWinControl:HScrollerVisible';
end;//TkwPopScrollingWinControlHScrollerVisible.GetWordNameForRegister

procedure TkwPopScrollingWinControlHScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B46C6A433AAC_var*
//#UC END# *52D00B00031A_B46C6A433AAC_var*
begin
//#UC START# *52D00B00031A_B46C6A433AAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B46C6A433AAC_impl*
end;//TkwPopScrollingWinControlHScrollerVisible.SetValuePrim

function TkwPopScrollingWinControlHScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B46C6A433AAC_var*
//#UC END# *551544E2001A_B46C6A433AAC_var*
begin
//#UC START# *551544E2001A_B46C6A433AAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B46C6A433AAC_impl*
end;//TkwPopScrollingWinControlHScrollerVisible.GetResultTypeInfo

function TkwPopScrollingWinControlHScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_B46C6A433AAC_var*
//#UC END# *559687E6025A_B46C6A433AAC_var*
begin
//#UC START# *559687E6025A_B46C6A433AAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_B46C6A433AAC_impl*
end;//TkwPopScrollingWinControlHScrollerVisible.GetAllParamsCount

function TkwPopScrollingWinControlHScrollerVisible.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B46C6A433AAC_var*
//#UC END# *5617F4D00243_B46C6A433AAC_var*
begin
//#UC START# *5617F4D00243_B46C6A433AAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B46C6A433AAC_impl*
end;//TkwPopScrollingWinControlHScrollerVisible.ParamsTypes

initialization
 TkwPopControlVScrollerVisible.RegisterInEngine;
 {* Регистрация pop_Control_VScrollerVisible }
 TkwPopControlHScrollerVisible.RegisterInEngine;
 {* Регистрация pop_Control_HScrollerVisible }
 TkwPopScrollingWinControlVScrollerVisible.RegisterInEngine;
 {* Регистрация pop_ScrollingWinControl_VScrollerVisible }
 TkwPopScrollingWinControlHScrollerVisible.RegisterInEngine;
 {* Регистрация pop_ScrollingWinControl_HScrollerVisible }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWinControl));
 {* Регистрация типа TWinControl }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TScrollingWinControl));
 {* Регистрация типа TScrollingWinControl }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
