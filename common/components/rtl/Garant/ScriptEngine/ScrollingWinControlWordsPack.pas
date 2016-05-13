unit ScrollingWinControlWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\ScrollingWinControlWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ScrollingWinControlWordsPack" MUID: (54F5881101AC)

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
 , Controls
 , Forms
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , Windows
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopControlVScrollerVisible = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Control:VScrollerVisible }
  private
   function VScrollerVisible(const aCtx: TtfwContext;
    aControl: TWinControl): Boolean;
    {* ���������� ����� ������� pop:Control:VScrollerVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlVScrollerVisible

 TkwPopControlHScrollerVisible = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Control:HScrollerVisible }
  private
   function HScrollerVisible(const aCtx: TtfwContext;
    aControl: TWinControl): Boolean;
    {* ���������� ����� ������� pop:Control:HScrollerVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopControlHScrollerVisible

 TkwPopScrollingWinControlVScrollerVisible = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:ScrollingWinControl:VScrollerVisible }
  private
   function VScrollerVisible(const aCtx: TtfwContext;
    aScrollingWinControl: TScrollingWinControl): Boolean;
    {* ���������� ����� ������� pop:ScrollingWinControl:VScrollerVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopScrollingWinControlVScrollerVisible

 TkwPopScrollingWinControlHScrollerVisible = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:ScrollingWinControl:HScrollerVisible }
  private
   function HScrollerVisible(const aCtx: TtfwContext;
    aScrollingWinControl: TScrollingWinControl): Boolean;
    {* ���������� ����� ������� pop:ScrollingWinControl:HScrollerVisible }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopScrollingWinControlHScrollerVisible

function TkwPopControlVScrollerVisible.VScrollerVisible(const aCtx: TtfwContext;
 aControl: TWinControl): Boolean;
 {* ���������� ����� ������� pop:Control:VScrollerVisible }
//#UC START# *2316871D91AF_D64D3C18264A_var*
var
 l_PageMax: Integer;
 l_RangeMax: Integer;
 l_Err: Integer;
 l_PageInfo: TScrollInfo;
//#UC END# *2316871D91AF_D64D3C18264A_var*
begin
//#UC START# *2316871D91AF_D64D3C18264A_impl*
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
   if l_Err = 1447 then  // 1447: ���� �� ����� ����� ���������.
    Result := False
   else
    RunnerAssert(False, '������ ��� ������ GetScrollInfo. ��� ������: ' + IntToStr(l_Err), aCtx);
  end;
 end;//aControl Is TScrollingWinControl
//#UC END# *2316871D91AF_D64D3C18264A_impl*
end;//TkwPopControlVScrollerVisible.VScrollerVisible

procedure TkwPopControlVScrollerVisible.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(VScrollerVisible(aCtx, l_aControl));
end;//TkwPopControlVScrollerVisible.DoDoIt

class function TkwPopControlVScrollerVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:VScrollerVisible';
end;//TkwPopControlVScrollerVisible.GetWordNameForRegister

function TkwPopControlVScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlVScrollerVisible.GetResultTypeInfo

function TkwPopControlVScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlVScrollerVisible.GetAllParamsCount

function TkwPopControlVScrollerVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl)]);
end;//TkwPopControlVScrollerVisible.ParamsTypes

procedure TkwPopControlVScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� VScrollerVisible', aCtx);
end;//TkwPopControlVScrollerVisible.SetValuePrim

function TkwPopControlHScrollerVisible.HScrollerVisible(const aCtx: TtfwContext;
 aControl: TWinControl): Boolean;
 {* ���������� ����� ������� pop:Control:HScrollerVisible }
//#UC START# *1108E304B00C_F808620CE3AB_var*
var
 l_PageMax: Integer;
 l_RangeMax: Integer;
 l_Err: Integer;
 l_PageInfo: TScrollInfo;
//#UC END# *1108E304B00C_F808620CE3AB_var*
begin
//#UC START# *1108E304B00C_F808620CE3AB_impl*
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
   if l_Err = 1447 then  // 1447: ���� �� ����� ����� ���������.
    Result := False
   else
    RunnerAssert(False, '������ ��� ������ GetScrollInfo. ��� ������: ' + IntToStr(l_Err), aCtx);
  end;
 end;//aControl Is TScrollingWinControl
//#UC END# *1108E304B00C_F808620CE3AB_impl*
end;//TkwPopControlHScrollerVisible.HScrollerVisible

procedure TkwPopControlHScrollerVisible.DoDoIt(const aCtx: TtfwContext);
var l_aControl: TWinControl;
begin
 try
  l_aControl := TWinControl(aCtx.rEngine.PopObjAs(TWinControl));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aControl: TWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(HScrollerVisible(aCtx, l_aControl));
end;//TkwPopControlHScrollerVisible.DoDoIt

class function TkwPopControlHScrollerVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Control:HScrollerVisible';
end;//TkwPopControlHScrollerVisible.GetWordNameForRegister

function TkwPopControlHScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopControlHScrollerVisible.GetResultTypeInfo

function TkwPopControlHScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopControlHScrollerVisible.GetAllParamsCount

function TkwPopControlHScrollerVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TWinControl)]);
end;//TkwPopControlHScrollerVisible.ParamsTypes

procedure TkwPopControlHScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HScrollerVisible', aCtx);
end;//TkwPopControlHScrollerVisible.SetValuePrim

function TkwPopScrollingWinControlVScrollerVisible.VScrollerVisible(const aCtx: TtfwContext;
 aScrollingWinControl: TScrollingWinControl): Boolean;
 {* ���������� ����� ������� pop:ScrollingWinControl:VScrollerVisible }
//#UC START# *2316871D91AF_0E188022DACF_var*
//#UC END# *2316871D91AF_0E188022DACF_var*
begin
//#UC START# *2316871D91AF_0E188022DACF_impl*
 Result := aScrollingWinControl.VertScrollBar.IsScrollBarVisible;
//#UC END# *2316871D91AF_0E188022DACF_impl*
end;//TkwPopScrollingWinControlVScrollerVisible.VScrollerVisible

procedure TkwPopScrollingWinControlVScrollerVisible.DoDoIt(const aCtx: TtfwContext);
var l_aScrollingWinControl: TScrollingWinControl;
begin
 try
  l_aScrollingWinControl := TScrollingWinControl(aCtx.rEngine.PopObjAs(TScrollingWinControl));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aScrollingWinControl: TScrollingWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(VScrollerVisible(aCtx, l_aScrollingWinControl));
end;//TkwPopScrollingWinControlVScrollerVisible.DoDoIt

class function TkwPopScrollingWinControlVScrollerVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScrollingWinControl:VScrollerVisible';
end;//TkwPopScrollingWinControlVScrollerVisible.GetWordNameForRegister

function TkwPopScrollingWinControlVScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopScrollingWinControlVScrollerVisible.GetResultTypeInfo

function TkwPopScrollingWinControlVScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopScrollingWinControlVScrollerVisible.GetAllParamsCount

function TkwPopScrollingWinControlVScrollerVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TScrollingWinControl)]);
end;//TkwPopScrollingWinControlVScrollerVisible.ParamsTypes

procedure TkwPopScrollingWinControlVScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� VScrollerVisible', aCtx);
end;//TkwPopScrollingWinControlVScrollerVisible.SetValuePrim

function TkwPopScrollingWinControlHScrollerVisible.HScrollerVisible(const aCtx: TtfwContext;
 aScrollingWinControl: TScrollingWinControl): Boolean;
 {* ���������� ����� ������� pop:ScrollingWinControl:HScrollerVisible }
//#UC START# *1108E304B00C_B46C6A433AAC_var*
//#UC END# *1108E304B00C_B46C6A433AAC_var*
begin
//#UC START# *1108E304B00C_B46C6A433AAC_impl*
 Result := aScrollingWinControl.HorzScrollBar.IsScrollBarVisible;
//#UC END# *1108E304B00C_B46C6A433AAC_impl*
end;//TkwPopScrollingWinControlHScrollerVisible.HScrollerVisible

procedure TkwPopScrollingWinControlHScrollerVisible.DoDoIt(const aCtx: TtfwContext);
var l_aScrollingWinControl: TScrollingWinControl;
begin
 try
  l_aScrollingWinControl := TScrollingWinControl(aCtx.rEngine.PopObjAs(TScrollingWinControl));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aScrollingWinControl: TScrollingWinControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(HScrollerVisible(aCtx, l_aScrollingWinControl));
end;//TkwPopScrollingWinControlHScrollerVisible.DoDoIt

class function TkwPopScrollingWinControlHScrollerVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:ScrollingWinControl:HScrollerVisible';
end;//TkwPopScrollingWinControlHScrollerVisible.GetWordNameForRegister

function TkwPopScrollingWinControlHScrollerVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopScrollingWinControlHScrollerVisible.GetResultTypeInfo

function TkwPopScrollingWinControlHScrollerVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopScrollingWinControlHScrollerVisible.GetAllParamsCount

function TkwPopScrollingWinControlHScrollerVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TScrollingWinControl)]);
end;//TkwPopScrollingWinControlHScrollerVisible.ParamsTypes

procedure TkwPopScrollingWinControlHScrollerVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HScrollerVisible', aCtx);
end;//TkwPopScrollingWinControlHScrollerVisible.SetValuePrim

initialization
 TkwPopControlVScrollerVisible.RegisterInEngine;
 {* ����������� pop_Control_VScrollerVisible }
 TkwPopControlHScrollerVisible.RegisterInEngine;
 {* ����������� pop_Control_HScrollerVisible }
 TkwPopScrollingWinControlVScrollerVisible.RegisterInEngine;
 {* ����������� pop_ScrollingWinControl_VScrollerVisible }
 TkwPopScrollingWinControlHScrollerVisible.RegisterInEngine;
 {* ����������� pop_ScrollingWinControl_HScrollerVisible }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWinControl));
 {* ����������� ���� TWinControl }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TScrollingWinControl));
 {* ����������� ���� TScrollingWinControl }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
